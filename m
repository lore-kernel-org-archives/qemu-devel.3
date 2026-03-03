Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E256AEDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWh8-00060Z-Bq; Tue, 03 Mar 2026 15:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh1-0005zy-7D
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:11 -0500
Received: from p-east2-cluster6-host9-snip4-1.eps.apple.com ([57.103.76.192]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWgy-0000i9-Ni
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:10 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 6E15E18000A3; Tue,  3 Mar 2026 20:50:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571007; x=1775163007;
 bh=XKJWOB0YKzpmGruYPm1LXPuvsqRH3lAKyghgrIoSZXY=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=LEkeswNAAaoZsqoxRuhpAtL4bYSeqnFMMSn35WjnbKc+X6gAjkXIkRnN+PZgBjstMKDiSdrgNsy/z5KA0VU2oDIylCqZy4cvB/O5O9pw17fJCYewr569cQscx74AMmGgzz/RFdeB8aQbDj1ZgefgLwuPPv8H02kHW1DVRtN597jssEx35BQxNXfX4Zzv92QolpUGv+1hIQKm8KSp6jzDXWFmAkDVTavaScCbZJCZRt2Bi6J20icUedM9DqjBUmLzWY1/sm+aQ2QQQruMdxA1UJxWUN9YrvxStQkG+zQiYTd5cy1Yuu8dvF9vIwmGGPgDS8TAuShJ+Y8qS3Ruvgywiw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 D1F2E1800412; Tue,  3 Mar 2026 20:50:01 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 0/9] whpx: i386: small random fixes
Date: Tue,  3 Mar 2026 21:49:50 +0100
Message-ID: <20260303204959.31156-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=DL+CIiNb c=1 sm=1 tr=0 ts=69a7497d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2hR40MzdYebMGYd4gb8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RVC7O7VIQajVaBb5SxXRqb5Udb4YN8-M
X-Proofpoint-ORIG-GUID: RVC7O7VIQajVaBb5SxXRqb5Udb4YN8-M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfX9OxngQdWiQXA
 VIxrVsjw5O5AYCWp4X5ALuSuc64JhsAqclWEE5935EAGN6CzlG/DPqQxOg2NJywR+65y5u/DMWj
 PwB3lNG9CxUzLk/S+NOgQXatgAqMDNTdsahOhZp6r8sLlMdAQ809HcvLTqEfObQYGN6QCvexYsr
 efMDRQGcOFr+jI2i+jdr4psgJGp7L/tou2udrKmOvINo8PSdBrbV3WaN8zW9bfxFIgUDm7vzVHq
 hFMXTeOfJ6SKg+IBJVwxy4pePDM5KYlY2tZMWaqXJAo7NP86Nt2JiTlo4ubuj6VVfalpJT/w3CF
 1ds2SRaA9weV/9W1b/nzKKPkttckkPT5KUZrvedHAvWyRjF3uQiKY0juW0GBYw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1030 mlxlogscore=655 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAAByyvH510HvnDLg56lmv9t5/Xkd7JafbK6mB5zM6TnOt9veZLtGnrDrLQGimp6NR1NSmPvDI2kQOayazoe5pLzosQV97hCfJivdfkdnV27fHrchuP+RT4yy0kKSZP9QV1G9M+HGPtnlvPgIs2YN01D7CU8BHIkKFXNfFWdodGdlpoDroD9pK0UZZ9KsC3s/nIWMYCu1LR/nbQH73RoobXn1yeqsDy7rq4jQ88uW2aEd+kv7lO6oZBpsb5gnq4O6Iffg+WWZWBTJpd3FC9j+X6SaYQkxwGXcQ4tbyClG8OBXdSX2zbjlXZZTLzKgMrwrnTvPxC9+gKReU00nYrx0C3yX7FcwM7Ro/QeVMXdSrq8NYvDTvcWHlhbZc8WSGGdCCF+/9DtCY0EI9xRW3jPXyle3IiVM1JBGWGK+H/NKJdDEzoS7xy3K3WrzE/PIv+wZWSOEF1ZWT6berg7ccc/FRm7RVFouAqBsGu5U3Pi7sqLTx0tcOCYHFKWs4tvIIURWkw7+FQxmUNwpNcS6R0n1wC7zwwDhMdvspYEIaEIAleJ7+I4V742KapmUs47nv6sg3eZ3DZ7L6o9bCRQHKhb18ddPI6UsfEqoCsVUnFMicethnC2c/IHDgTA/t0lA5eki3YCn4Q20SQgjd7FIMRAiMM40x1pSdDoFvFYQXLkKCkyml+4vDkRQ5kS81ATMUBQVGxdVvBdkaMNYaqn+zcO/0+ZlgkAD5raDMJwsgFjeqwOE649Mp+3
Received-SPF: pass client-ip=57.103.76.192;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Also has a small arm64 patch for enabling Hyper-V enlightenments if asked
for, which depends on another (common code) patch in the series

v3:

- Added HVF build fix from Pierrick Bouvier (oops... forgot to have it copied over from the test machine earlier...)
- Also added a fix for "whpx: make enlightenments configurable" highlighted with an error from GCC. Clang did not catch this...

Mohamed Mediouni (8):
  Revert "elf-ops.h: Map into memory the ELF to load"
  whpx: i386: apic: bring closer to MSHV code path
  whpx: i386: do not enable nested virt when kernel-irqchip=off
  target/i386: emulate: LA57 fix
  whpx: i386: enable some more enlightenments
  whpx: make Hyper-V enlightenments configurable
  whpx: arm64: enable enlightenments if asked for
  whpx: i386: remove SIPI trapping

Pierrick Bouvier (1):
  target/i386/hvf/hvf.c: fix compilation

 accel/whpx/whpx-common.c       |  44 +++++
 hw/intc/apic.c                 |   9 ++
 include/hw/elf_ops.h.inc       |  71 +++-----
 include/system/whpx-internal.h |  14 +-
 target/arm/whpx/whpx-all.c     |  37 +++++
 target/i386/cpu-apic.c         |   3 -
 target/i386/emulate/x86_mmu.c  |   2 +-
 target/i386/hvf/hvf.c          |  14 +-
 target/i386/whpx/irq.c         | 153 ++++++++++++++++++
 target/i386/whpx/irq.h         |  10 ++
 target/i386/whpx/meson.build   |   2 +-
 target/i386/whpx/whpx-all.c    | 139 ++--------------
 target/i386/whpx/whpx-apic.c   | 286 ---------------------------------
 13 files changed, 317 insertions(+), 467 deletions(-)
 create mode 100644 target/i386/whpx/irq.c
 create mode 100644 target/i386/whpx/irq.h
 delete mode 100644 target/i386/whpx/whpx-apic.c

-- 
2.50.1 (Apple Git-155)


