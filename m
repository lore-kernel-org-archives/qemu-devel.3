Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C650EEC2AF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufX3-000656-TF; Mon, 23 Feb 2026 18:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufX2-000632-Ew
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:04 -0500
Received: from qs-2007d-snip4-11.eps.apple.com ([57.103.84.171]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufWz-00048x-JZ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:04 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 E8A6D18003A9; Mon, 23 Feb 2026 23:39:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771889997; x=1774481997;
 bh=HUXfvZXjde5y0c+jzxA6xbAL3qQfV9Ci9wv140Dbk40=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=VyCi4fQY1UfIjSK4yGGlAWA8otr3WYVSy7+mhkp6mv3a08Yec4yn01gb9DqrAa8zz74VVpn2LkVTKTVmWsCZH2XR3E8RXCOuVa/xKh9p+tfIV0WBxXmVH5DjBNvWmoQWsRhwGAmpgjyIhnZBBn45KYqXZbPvQVn56Tk+qyMITc/HToEIB4RrbBxaL/1CiJp+P5SfripJQdxjc8SMqNIKgNsY5xOx68zAh2ETdaqsPL1MAbmUDJWG83izMbd8POxQhZFy+1rCRta27/xPjG23mhF+UaRx7nwcodDolLGjMJQOGkmRT0GeW2IiUGUlxoQXYM/y3OV9gSEjrpEeY8Jrag==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 3E3431800169; Mon, 23 Feb 2026 23:39:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 00/28] whpx: x86 updates (2026-02)
Date: Tue, 24 Feb 2026 00:39:22 +0100
Message-ID: <20260223233950.96076-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX7UZqRCv6dd9z
 FLpBdmHcRotS/aPNtTrHmGSdN8YALRiduj+R+wUv1kHOhhDH+ttlb18TokacpCkHmJlN8ITCKxf
 /QsW4qkG0wR8aqWSn8cG5lceEfJ+TyfQxoMJsk5xAOnfCFN7w6LF8nfbrxs/KNDum5EtusoclG3
 Z7gMdY4v4h1xKsp7nT4vEZLeKOauY1EO6wBkT4X2X3QLbSyOx4PCkwC7Q8R4SU7JZCGfSoDaaER
 OQAdxBMfldwqkShHd7Lr0JDKmM05fORW3lD16wGYonzcgcZpsdznOhpncqhlBwf39Gp1D4NsjzS
 O+dwSYFkrnXRlULW5WL7rEUly1hBPbYaU8NkseCmN8yHLJJAruD+MqbaNUDkQk=
X-Proofpoint-GUID: 8Ukjjm9068BmLi_3-H17i6Q6bgld_9Ut
X-Authority-Info-Out: v=2.4 cv=C/PkCAP+ c=1 sm=1 tr=0 ts=699ce54d
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=uioGPAa19xdNNuCvvvYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8Ukjjm9068BmLi_3-H17i6Q6bgld_9Ut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAAB8qm8goc0UwBu3Up0IoAyXEKbp/ZkgwHs3RD/I9cDOq+CQLCUrchTq2tFQnCSvfO31SIWHvpU52cmVH60ftHw5F0qi5YhDD2eV87TH6XDjXonRcQTVRqETkLA6yeS8DfA3oMaEtsNZ0eJt6SPkKkPQzL7w09kPZxIrtvfPHMlDMS7CUj/i8hZvGp8W2sgK/KTusfoVXn7TxNV5tU7k7nUjRpcGmm5zpODhPbhPbIN6ceyHPjIHX6G1lEP9mPq5tHAXWgbiSrifLNGW/Hb4X9B558/hJLhDoRRCHu72/xcNweu1VCW3IudG8Msd6yE13EXimb7pXTrMQXujToWB4hGm5io7QG2EwIk5cG73rv90NY0rlubmBrO6iZiZ6pZDKwJu5qXnVlGDhwmLiVJFlxJSMHa7mmaVW7ObFYOB76NjNJtWfuKYEVHiFNsF9A3C8z+VJURTdGjc1bZ496/T/5Sr6/XfH30lW+G6YQGqIGzJAiRKqsQWU+WjIIdlVDQfczgWant2Iq0WSnHUKMx7p7haNmplkO/N3V3R2vzIKxCQLC8jBqOhC8gtVMK90QE8pUn3l/ShIs1eHZY3TALUTGajyw5kZYnIKTy4BFItGchYpU+tYvVcUXtdiWozGQe9YJqDLBD55+GgC087Muus06P0gxr76Mz7g953dW83rd0ce9mDu4VLaDBb9twxcpsJYEaFtfTgpi08O8GNAnGaAJqZxk6P4TRf9q26NPpVLK8YTzyy8Xb9eobKCKxNWHr1ZXK4InaQr7Pul4B0i4qulQfEHZXt3cdbMLz6f/32n137ps=
Received-SPF: pass client-ip=57.103.84.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

It's a bit of a misnomer, but didn't rename this series to not cause more confusion... should
probably have been named more like:

whpx, target/i386/emulate: fixes for target/i386/emulate and move WHPX x86 to it + WHPX misc fixes

Should have probably put a bit less faith in the state of target/i386/emulate from the get-go...

In guest OSes compatibility: Win9x works now (but is not too stable...). I probably recommend using -M kernel-irqchip=off
for that case though as it apparently raises stability (a bit). Win9x didn't work with winhvemulate.

32-bit Haiku didn't work for me with or without this, with an invalid bit being there in the PTEs, but 64-bit Haiku works.

On the bright side, this series should fix a lot on x86 HVF too...

Some questions/notes for mshv:
- On the model of the "whpx: i386: inject exceptions" commit, also have injection of raised exceptions for
the MSHV backend for this all to work as expected.
- I removed the reliance on the Hyper-V GVA translate call, which is a very slow one. If you want to add it
back instead of using the QEMU target/i386/emulate page table walker, there probably ought to be a way to reduce
the number of calls to that...
- but emul_ops has a new mmu_gva_to_gpa call to enable this case to be implemented
- la57 code is not exactly tested

And in missing things that are probably a better fit for a separate patch (series) instead of this continously-growing one:
- I don't handle privileges for the page walker in target/i386/emulate
- and SMAP/SMEP for it, with complexity they might add to the picture
- and the same applies to putting the reserved bit on error_code for erroneous PTEs

Git: https://github.com/mediouni-m/qemu (tag for this revision: whpx-x86-202502-v5, and yeah the 2025 is a typo...)

This series contains:

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

Changes added since v5:
- Thorough propagation of memory error reads across target/i386/emulate
- target/i386/emulate: warn on read/write from/to unmapped MMIO
- for an unmapped GPA, continue and 0xff the register

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

Mohamed Mediouni (25):
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
  target/i386: emulate: propagate errors all the way and stop early

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
 target/i386/emulate/x86_emu.c                 | 356 +++++++----
 target/i386/emulate/x86_emu.h                 |  24 +-
 .../{mshv/x86.c => emulate/x86_helpers.c}     |  13 +-
 target/i386/emulate/x86_mmu.c                 | 354 +++++++++++
 target/i386/{hvf => emulate}/x86_mmu.h        |  31 +-
 target/i386/hvf/hvf.c                         |  40 +-
 target/i386/hvf/meson.build                   |   1 -
 target/i386/hvf/x86.c                         |  13 +-
 target/i386/hvf/x86_mmu.c                     | 277 --------
 target/i386/hvf/x86_task.c                    |  10 +-
 target/i386/mshv/meson.build                  |   2 +-
 target/i386/mshv/mshv-cpu.c                   |  71 ---
 target/i386/whpx/whpx-all.c                   | 591 ++++++++----------
 target/i386/whpx/whpx-apic.c                  |   5 +
 26 files changed, 1031 insertions(+), 952 deletions(-)
 rename target/i386/{mshv/x86.c => emulate/x86_helpers.c} (95%)
 create mode 100644 target/i386/emulate/x86_mmu.c
 rename target/i386/{hvf => emulate}/x86_mmu.h (51%)
 delete mode 100644 target/i386/hvf/x86_mmu.c

-- 
2.50.1 (Apple Git-155)


