Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17552F55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywF5-0005FU-1s; Sat, 07 Mar 2026 13:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF2-0005Eg-DE
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:08 -0500
Received: from qs-2004f-snip4-3.eps.apple.com ([57.103.84.56]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF0-0005O2-8p
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:08 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 1B16A18000AD; Sat,  7 Mar 2026 18:19:00 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907545; x=1775499545;
 bh=Zp0e7/Irj8vQ9+EL3DrYH7jy0VkIsNk2r9HzlCyvm7M=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=GBd1HM6sa6YmYLI82zn9R7MpFF7k+8AyFInybPPUPm9JzFPw8aiSqJLbmTBpgACymHw5MWr6M/PO7NWHj9NWtenmvSTc5Rq4knAeh5r90gCGG4V1OT8b49U9B4x0FQ5Dta6KVrt6v3kFYyGqGHW5xMHu2LfRSZEDoM5naozCL23IG03/3/V8I6tcwW524q0uFxhQQJYOGJn3un/PlTulApg8nlLUtt/9tgk9EjIQqiiCkO9pp8Hv9RUmj4ANx6fbOJnkNbD8VqL/8eyjkT7FZZW01/SVrhbx8hUplmdbfTDGAeutP+H7erocKLKEDTDIMLzezq1IN3Nj3CjTWhq5Eg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 71EED1800113; Sat,  7 Mar 2026 18:18:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v6 0/9] hvf, whpx: i386: x86-centric fixes before softfreeze
Date: Sat,  7 Mar 2026 19:18:47 +0100
Message-ID: <20260307181856.2209-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfX1GwoP5tMetzf
 pCOsFNzb/HXipFQAR7YpEaRSkA128uHdGJUplbi4W96X/6fFPAt7MHAe5/hridsM5wo6JDCfvyE
 UBgwfZfePioJ2QMXpnbp9lSaWPPb85yHQBAlk4wOudY9Oz9fZ6AmBPqj6+6Y68mBkaPob5DHwBi
 kOYAx/gFvcu0FYuYvXNTlQCvxTY6UbaDrJ86MX8G82wuokHaf3tELfHClQBUmAQwo8eztSKwRO+
 zcUgNDRcPI+g/WbrNyXGvVTJs4jamJZCsT3ib+7TRpup1SoeodlyvhOP0bwi0iyADdasLXzecB2
 U+BF0X5cqwFadTpsmIYCuWZrdvHftZOLwrBkyDR5a2OMz61kOC+sG0LxhlG7Mo=
X-Proofpoint-ORIG-GUID: DqCWCXzhRC-h2JMUTXidoMSH3nYtyG5B
X-Authority-Info-Out: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69ac6c17
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2hR40MzdYebMGYd4gb8A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DqCWCXzhRC-h2JMUTXidoMSH3nYtyG5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=875 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAABNkIspVZ99HTudyahvnnMkgk7XYILm9vqVk1CtUjYbeCSzPk7G6na7s0dfGH70hHMv0LdbyNDQlqlP9KU84ub2SDnKU6CoZpXonA15JEnqUCAYHUyCXWYpVXMjaJEFj8Gu7WnWH9or/YPDt2xy8PYG7bDfVj1K/j+hvoFPHqKsr2oDsfVr59NvYcWfzm00xKjIDfg0O7ZID6WbgQKZ3YsUkPhi5O8BfebeKZfvTOr84FYgllfj97mq69CZ0V+3LOCmy+Z0gJchb4uwDXjPvSEzGhyyAO/9HHEXigC0bSxe97gYact11YNJKO2UQ/l/+UdpzsRkvlfAK+zPpwszYFNSof3HaL95kZ6ulBdu1+hGsueIPsJSMBAmOPZbbP71gkEfbhMiXEUsPaW5xmbChzjJsRCbBLcgG/zNAZWRNQaBCF5Z8dipjFqTC5FTVzAFc3dPNW+yyE6mTmRZi5oFyo6UaImh6Og77hiOhugcL+K4b1aiXefFgEp0vqbTVcwkC/ItCmDmFJ5Pb0yAbWwZ8BlYsPzhB28jVhS/qVP56DD12iBnonG4njnmTdcxECyiFe2kPj/eJxW8lgftSrK9UoEEYG+Zptr+3mDSLV0PMpcU0t05cElQb4EdmetE/m2WgQrM40txrHTcR9CTsrOaGlmLDGyi8XvXOBeJDl7pauqeWEUjwJCGVmb44YD00Kb7yPormS94ssqX7sjk5QcNFmvG9tGTFHxJNoGBWgF2ZQLJdEIx9HuHt3mIkJ8BZlRGGCqqxwfGDc7WJPp9XQfYRfoOR7tkJeyzHSv2xY=
Received-SPF: pass client-ip=57.103.84.56;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v6:
- && __aarch64 -> && defined(__aarch64__)
- remove unneeded "#include "qemu/target-info.h"

v5:
- Also include HVF buildability fixes...

v4:
- Removed two patches that I didn't intend to be merged at this point yet...

v3:

- Added HVF build fix from Pierrick Bouvier (oops... forgot to have it copied over from the test machine earlier...)
- Also added a fix for "whpx: make enlightenments configurable" highlighted with an error from GCC. Clang did not catch this...

Mohamed Mediouni (8):
  meson.build: older macOS targeting compatibility with macOS 15.4 SDK
  hvf: arm: unbreak the x86 build
  whpx: i386: do not enable nested virt when kernel-irqchip=off
  target/i386: emulate: LA57 fix
  whpx: i386: enable some more enlightenments
  whpx: make Hyper-V enlightenments configurable
  whpx: arm64: enable enlightenments if asked for
  whpx: i386: remove SIPI trapping

Pierrick Bouvier (1):
  target/i386/hvf/hvf.c: fix compilation

 accel/whpx/whpx-common.c       |  43 ++++++++++++
 include/system/whpx-internal.h |   4 ++
 meson.build                    |   7 +-
 target/arm/hvf_arm.h           |   2 +-
 target/arm/whpx/whpx-all.c     |  37 ++++++++++
 target/i386/emulate/x86_mmu.c  |   2 +-
 target/i386/hvf/hvf.c          |  14 ++--
 target/i386/whpx/whpx-all.c    | 122 ++++-----------------------------
 8 files changed, 114 insertions(+), 117 deletions(-)

-- 
2.50.1 (Apple Git-155)


