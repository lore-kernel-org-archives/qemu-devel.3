Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3549AE98E0B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRRt-0000Ah-P7; Mon, 23 Feb 2026 03:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRr-0000AC-Fj
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:47 -0500
Received: from p-east2-cluster4-host2-snip4-8.eps.apple.com ([57.103.78.169]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuRRp-0002Af-5O
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:37:47 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id
 837F61800168; Mon, 23 Feb 2026 08:37:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771835863; x=1774427863;
 bh=ZEXZ+aTnrDBCOh9Li2tnDLC2Xzz3JbNWeitNNLCXEtU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=RxZuf+zRxBlkS6sXSoq9ZbOCjQSZO3auxyf01Il0ZTv+pI2RN6Ohy2IRIvO06irhjIyZeZyb1rah982/KpEtEC9z36dwZBgGrHuoE26WhpyM4TgeYpQUPbLUXYPjd1aWRsbegv3FZ9yqulET/C0UUeBHMC97QSQCL1VGdIBnnCXu4pReED9zuoTPsKvYau4AIrz5ZhxJqVKab+FyNkManefyM0TQjCX1SCVIWwBjz7N2gBgIOLO2iZ8W/l3GoeS5tyv808jHORSR9azEdfBje5YCHF7H5gpfO6wN1aFpu3HHEcKSjl2Wp1q+D0CvmNlEvR0Gnf48c2WGC7PDtMqcOQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id
 629881800222; Mon, 23 Feb 2026 08:37:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 00/27] whpx: x86 updates (2026-02)
Date: Mon, 23 Feb 2026 09:37:06 +0100
Message-ID: <20260223083734.48533-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3NiBTYWx0ZWRfX+goc3kexVp9+
 BgepvleVgFLm8CTZmceofG0HI4VvFEPrWIq5T/ScTDFWS+4+NZ24RS6fDkkdFFKr8ICFKLy4sSr
 9T23/V1SZcV6x+ZGbaj/6ZLE3KL9xJ2D38DJgQr75HUHscxe3kq2iToI6ibfh/wXBoirDHTjL1p
 DqKEcFPtnvIlLbISgIYymGiBQYXyHu09KSltDL03rDIsDQk+cRlh+UFjhO0TZpr3mcyBXfcvm0T
 KMFadNGfNaZIv4c5SUBUvcx8VuDgSmm7R64q81ixt+HEZb4ZYwJNdtG4smnSVfuHDpuJHvzgPyD
 58kUXM5HNXymP+Ju3yNr693bmncvLzZd5UdKiCSJoBP2znBySl5FhhhefjhXSQ=
X-Proofpoint-GUID: -uVpWjct8pwQJmAbxNpNrG-w_QMBuIqj
X-Authority-Info-Out: v=2.4 cv=C/PkCAP+ c=1 sm=1 tr=0 ts=699c11d5
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=1kJ68ZxyAwdk7K1tokkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -uVpWjct8pwQJmAbxNpNrG-w_QMBuIqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 lowpriorityscore=0 spamscore=0 mlxlogscore=980 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230076
X-JNJ: AAAAAAABReO8mWYOVFjBfRw4Q07lFRFqsyrKsZzcp3PSnQ+cwjqpw5o3Ps6gpNqh25kuB1ZjUSnNKu4ldTIeAxCgocNThkEEHVqIJhHJKfRdkGBK/GOZPrubHDhS9Nu5jYNTa751QoaKi1oGuE6UYIZNzyWPB8ed5kL9HNsa2im/0nZXWixKdwPl4q9SAqMcdFgpLG7jhvE3YMm/K6Uk2BKzoAQWzjmzPCLMuNY2RTWkRR3wKYuVrVixRI7U82UpauhOtjG+4eXIxp+S90KRG5z0+W/AXFOOnbzCLyEPgjMeBgcMdsSG07FrmnMRsFwn0JYpQ/4Ixw0v/CjoPK8hxNhpSK9QIaoJ8BYl1UwrlGlNQjXt7NADn0uwbc3IJCSiEwygzwVXu7bTgxXh/J0AqHGtHAcYXb54ofVOvfbsbWiGhVDKBVMCmDFI6hQTSitdhjKIR3YEl2TIxgA4H27sllWDxxRGCvUymhGt9GVtsB6A+jbTL1tveBtCTC6eaMocydRud1rRCDFuqHxHfOC5gFka4emd5Cv+LqxYhiMFLKpB5kCUCT3GdZvWdjsKwEkVb/ZoMiPlM0kqgWCcq77Pl/Sz/ZEGgUgvR20cLKEAKDJJGDUI8oQgovChAWCblIC2uAnMybCY3EarMBlP1wyMuEtPsrmKd1PLKvaFxSQD1xKWte0HULUbsBcwBjiL0m3k/ht9xGAEC7IrPw3keg/Dduf1ux+19qKugg0jUsJ1eA/5Z1vKW9Ayqt6mdMjO5MUGuuQA+/lqwmllknWMAYbXtE0iZSqrxpU6zo0BcwZD0RrO2JJ3suO7HTBZ7xYbUHLqQ4f+G8hKWphpzBAYVcAp3iBLPYA3Tw==
Received-SPF: pass client-ip=57.103.78.169;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

x86_64 WHPX updates:

- target/i386/emulate fixes
- move HVF x86_mmu code to common code
- fixing debug support, which was broken since around: "gdbstub: move guest debug support check to ops"
a48e7d9e52f8fe8b47f4c74f3e99d9d677b87fe5
- switch over from winhvemulation to common x86 VM exit emulation code
- remove some log lines
- Remove WHPX CPUID traps as they're currently quite broken
- Reworked implementation of the REP prefix for string instructions
- page table walker rework, error propagation for target/i386/emulate,
and injecting exceptions too
- bump the exposed interrupt controller to an X2APIC
- preemptively ignore interrupt requests to vector 0 instead of making the HV do it

Changes added since v4:
- MMU code rework
- page table walker rework, (some) error propagation for target/i386/emulate,
and injecting exceptions too...
- all around cleanups around target/i386/emulate...
- bump the exposed interrupt controller to an X2APIC
- preemptively ignore interrupt requests to vector 0 instead of making the HV do it

Changes added since v3:
- Reworked implementation of the REP prefix for string instructions
- Pick up flags conversion for WHPX x86 (used by target/i386/emulate)
- get rid of the goto for the save/restore less state for WHPX patch

Changes added since v2:
- Take target/i386/emulate patches from Bernhard Beschow
https://lore.kernel.org/qemu-devel/20260214131659.31378-1-shentey@gmail.com/
- Rework state levels to an enum
- Skip some state loading on the registers save path too

Changes added since v1:
- move HVF x86_mmu code to common code
- Use x86_mmu in WHPX MMIO exits
- Remove WHPX CPUID traps as they're currently quite broken
- Optimise MMIO vmexits by not restoring the full state

Bernhard Beschow (3):
  target/i386/emulate/x86_decode: Fix compiler warning
  target/i386/hvf/x86_mmu: Fix compiler warning
  target/i386/emulate/x86_decode: Actually use stream in
    decode_instruction_stream()

Mohamed Mediouni (24):
  target/i386/emulate: rework string_rep emulation
  target/i386: emulate, hvf: move x86_mmu to common code
  whpx: i386: re-enable guest debug support
  whpx: preparatory changes before switching over from winhvemulation
  whpx: refactor whpx_destroy_vcpu to arch-specific function
  whpx: move whpx_get_reg/whpx_set_reg to generic code
  whpx: i386: switch over from winhvemulation to target/i386/emulate
  whpx: i386: flags conversion for target/i386/emulate internal state
  whpx: i386: remove remaining winhvemulation support code
  whpx: i386: remove messages
  whpx: i386: remove CPUID trapping
  whpx: common, i386, arm: rework state levels
  whpx: i386: saving/restoring less state for
    WHPX_LEVEL_FAST_RUNTIME_STATE
  target/i386: mshv, emulate: move the generic x86 helpers to
    target/i386/emulate
  target/i386: emulate: 5-level paging for the page table walker
  target/i386: emulate, hvf, mshv: rework MMU code
  hvf: i386: save/restore CR0/2/3
  target/i386: emulate: get rid of write_val_to_mem() helper
  target/i386: emulate: raise an exception on translation fault
  target/i386: emulate: remove fetch_instruction helper too
  target/i386: emulate: propagate memory errors on most reads/writes
  whpx: i386: inject exceptions
  whpx: i386: bump to x2apic
  whpx: i386: ignore send_msi to interrupt vector 0

 accel/whpx/whpx-accel-ops.c                   |   8 +
 accel/whpx/whpx-common.c                      |  68 +-
 include/system/whpx-accel-ops.h               |  16 +-
 include/system/whpx-all.h                     |  11 +-
 include/system/whpx-common.h                  |   6 +-
 include/system/whpx-internal.h                |  16 -
 meson.build                                   |   3 +-
 target/arm/whpx/whpx-all.c                    |  43 +-
 target/i386/cpu.h                             |   2 +-
 target/i386/emulate/meson.build               |   9 +
 target/i386/emulate/x86.h                     |   1 +
 target/i386/emulate/x86_decode.c              |  12 +-
 target/i386/emulate/x86_emu.c                 | 141 +++--
 target/i386/emulate/x86_emu.h                 |   6 +-
 .../{mshv/x86.c => emulate/x86_helpers.c}     |  13 +-
 target/i386/{hvf => emulate}/x86_mmu.c        | 188 ++++--
 target/i386/{hvf => emulate}/x86_mmu.h        |  31 +-
 target/i386/hvf/hvf.c                         |  40 +-
 target/i386/hvf/meson.build                   |   1 -
 target/i386/hvf/x86.c                         |  13 +-
 target/i386/hvf/x86_task.c                    |  10 +-
 target/i386/mshv/meson.build                  |   2 +-
 target/i386/mshv/mshv-cpu.c                   |  71 ---
 target/i386/whpx/whpx-all.c                   | 591 ++++++++----------
 target/i386/whpx/whpx-apic.c                  |   5 +
 25 files changed, 652 insertions(+), 655 deletions(-)
 rename target/i386/{mshv/x86.c => emulate/x86_helpers.c} (95%)
 rename target/i386/{hvf => emulate}/x86_mmu.c (50%)
 rename target/i386/{hvf => emulate}/x86_mmu.h (51%)

-- 
2.50.1 (Apple Git-155)


