Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60903EB5967
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 05:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3B1-0005U3-Ls; Wed, 11 Feb 2026 00:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3B0-0005TY-6i
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:14 -0500
Received: from p-west3-cluster1-host6-snip4-1.eps.apple.com ([57.103.73.182]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vq3Aw-0002oF-31
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 00:54:12 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPS id
 64F8A1800197; Wed, 11 Feb 2026 05:54:02 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770789244; x=1773381244;
 bh=JLRXXVJEPid2HoEP3BypIju25kk84tSwYYCsOaTG8P8=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=BjceXS96W4vPAALgRyRQSWQldYMHE2IyHgVHfWY42tZ6dwKII0FrLS7ikRMC/N1J/jjsJfeSPJwpWMCG4ePfwqCdeG5G4MxtC2JuCodDon7MmetmC03LE4u9Ttmhz4ybWMrs8CU44kCvSvpEjW4RgWDOfJQ/PcLWrk9V2BgpQ6NmB/9zn+7OJsj7n2d1YScq5+GpOkXwhGumU3WkhtF6tFJYHhaAT7jZ+04LHXFz5PS6vzX22egsSJe2DCN4FES0XuIHOjACx5xvvTe0KpKUeO9Y/0RVjvqGAXc/GU4UyRrFol40mkmJ54P/xweW31Lom2qDodUFOnoFlUvjTAC0lw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-7 (Postfix) with ESMTPSA id
 1FE621800188; Wed, 11 Feb 2026 05:53:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/7] whpx: x86 updates (2026-02)
Date: Wed, 11 Feb 2026 06:53:45 +0100
Message-ID: <20260211055356.44664-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA0NiBTYWx0ZWRfX+qvFXGgfLN1r
 7u9QGQKahTFZ3oVQWBEoU9YYf0V0/CkTtXMH3RTSIwfuvKLrI66nQEdhfupVYzg3BzPDBcU84U9
 hhzpj7W6rBd5n714n7VzkNW/o8GHqbcAKangpYAYDRjidgjBkAVenso0hv6NyNWeCHe3LeqY1GI
 Z/QtDGe5S8C2W+WYsOoZH2GzOi7b2kPbyokPaIKFI4ONh1YVueUjucu5bGFvoKZezl15CP//txl
 WfttIfN+lE8S1gsN/q/F3FUeqlIu9Cj1uHUCM4RYoU9+sFJz/cSOL8y5ADsI5Dsr75TV2ANvSHi
 8PAQFbr9NgA0foiiNVWpBLxckyRPt8gyf+5hMYoauflTCD3lN6BFMK6KwuMmlk=
X-Proofpoint-ORIG-GUID: w2IzzS5AG3LkVSfgIgHkxseT1Ffs_-lC
X-Authority-Info-Out: v=2.4 cv=Lc8xKzfi c=1 sm=1 tr=0 ts=698c197b
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=9g9VZJ4V8hbEpv_ugbMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w2IzzS5AG3LkVSfgIgHkxseT1Ffs_-lC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=777
 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1030 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110046
X-JNJ: AAAAAAABEf+E27RHvgL3BbPku104gBJcowV2pgMMk6iL8FJTScgpi69bP9dmsIk/bsKEfPIBoxoLJ6I/zAd0UwL2k7YlKg3Kh0LKXcXrsAKeyxXnIFRF6+v12EXqZX88t1yK8mB5u7hSbkp0cJVQQgdovXPc/rG6chCQ2QrvSpDdYgyB9i96dh8Ff/CgrsgsLuLvJfbgEhYOr+3D1vU5fT41K5LG0RAL5MrzXfybHtLHhPh88ZuIFXFCzqn/JCwYu+p988qmjlx8euC7oC5q7ubZFRNA3ydYdbkOP7HArqbufm9mX+EgCjXbkC9ZCqelPVeqYfHfIVbWl7dfkCHWUXzj/6YfG6I6g1aCMGX6WitYKscauDuFOdlFQk/A0cnxhyxNDM2+OohkZ0+sCzqUKocyJurzHc+u6SDrpKpWWFLll2z7n70Mh67kbY2rkrmDyzErOUx2NgfcTwrbKnkrW8xuHAP/qhrlDmw88wLyRteHt9NcZy7BJZB/g9xolkr+hERHOUkQI9v01yHokkQsLqkx3MfUcvi2wIQxyv+9UudFcXYw2Z6wBNnu913eW1Ag1lDdw83JUerVcmLH9S6Bb4gf9iV6U+zNa+RPUEPGQ2HZDvOMgW/CQhRFD8OLoiLNTjziNZsu1PA9otl0DAPHdG50g7USSOdcWyNSV0D6pXJyeKt6vyhcPki1UyqwlP4n/F61q9brvfKlyLgnNZwQYxGvX1Ns0ntUK3Nv2MXgGpjxv5vSMEh+LN2+w4usKvgMcSenQSsAVxFp+uDBMBV79RJdsKzh3ncsaLmBHkQIj+hgIqiZ/iVc
Received-SPF: pass client-ip=57.103.73.182;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

x86_64 WHPX updates:

- fixing debug support, which was broken since around: "gdbstub: move guest debug support check to ops"
a48e7d9e52f8fe8b47f4c74f3e99d9d677b87fe5
- switch over from winhvemulation to common x86 VM exit emulation code
- remove some log lines

Mohamed Mediouni (7):
  whpx: re-enable guest debug support on x86
  whpx: preparatory changes before switching over from winhvemulation
  whpx: refactor whpx_destroy_vcpu to arch-specific function
  whpx: move whpx_get_reg/whpx_set_reg to generic code
  whpx: x86: switch over from winhvemulation to target/i386/emulate
  whpx: remove remaining winhvemulation support code
  whpx: x86: remove messages

 accel/whpx/whpx-accel-ops.c     |   8 +
 accel/whpx/whpx-common.c        |  62 ++++---
 include/system/whpx-all.h       |   5 +
 include/system/whpx-common.h    |   6 +-
 include/system/whpx-internal.h  |  16 --
 meson.build                     |   3 +-
 target/arm/whpx/whpx-all.c      |  33 +---
 target/i386/cpu.h               |   2 +-
 target/i386/emulate/meson.build |   1 +
 target/i386/mshv/meson.build    |   4 +
 target/i386/whpx/whpx-all.c     | 308 ++++++++++++++++++++------------
 11 files changed, 252 insertions(+), 196 deletions(-)

-- 
2.50.1 (Apple Git-155)


