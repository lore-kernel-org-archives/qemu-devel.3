Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B16FC636A1
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 18:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuDnL-0008PN-MO; Sun, 22 Feb 2026 13:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnF-0008MF-64
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:57 -0500
Received: from qs-2007j-snip4-11.eps.apple.com ([57.103.84.231]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vuDnD-0000Ii-Eb
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 13:02:56 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPS id
 8BFDD180050D; Sun, 22 Feb 2026 18:02:46 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771783369; x=1774375369;
 bh=KtYElilKmH9uwAnD9+E5o0+kWjazb9uelAqIjHQ9XNU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Gg81dgwkCu1QAZveTzveSzRlVY1ym8sG5aJ2aCRmVBQeqZ2FH723X4M77CVM/WxCS8SEEllG1t8WVnYDBUU1/FGmypTHeKppeLoUzdDM+xs/T6+PnLoTTKETiYIOtokDaQD98BSplz9+c+qgxoMYOtsmHEHnh1U2LKiQxWsbndfFr2jPylwNt4WeQ88xTVg6uvnpO+9EucVv/humsEsORhAzS52YOsJkDk3x7ZKD7dXqkqv6k6oxdjawtRgkVYcXIAAiZ8a6qgldaRN61iea8Atdrlk9mF/d34Icx7I4k814tQhNHX4KVS9st/n2uaYtRIaB2J/pXzKQDzUgUTfcCQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-12 (Postfix) with ESMTPSA id
 713431800502; Sun, 22 Feb 2026 18:02:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v4 00/16] whpx: x86 updates (2026-02)
Date: Sun, 22 Feb 2026 19:02:24 +0100
Message-ID: <20260222180241.14621-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIyMDE3NCBTYWx0ZWRfXzU132556x/I6
 wuwpSSYf7lYNJdMHzOOMQSIAP8h914Cy1v0SzsOxUURzvyVQjogOukbqZbe8XKWn/PINqJC+FCI
 fegj+C9YiHTDuAnyLBHAQ74bO57rAH7Hv1XsUwdKGzRZlcmiwzMsoCktzZPfDopwlyDR+M+Y5bv
 PZ/wbsLsKkxAwgpzft/LXjpl9NLQNeKQR28T1TGfyP+ZQ9RNOnfQGZ8uIV6rupBRZ0hkYvH2Mnq
 6wTZt//ydPv1FUK3JnsV8tfEMg+wfqWxwm9l1M70gm9xeYlTXnZXa2JgOjtTvpuUNs40W3km1sZ
 qb9PLjwjdi4i7iHkxHlRTS60wcq9YltL7ffQ0Gv1AaEhYsT6/9k3Rt87TFusqo=
X-Proofpoint-GUID: yIAH6sWnUi4y-ZAJd3gzXACI9rOjcBft
X-Authority-Info-Out: v=2.4 cv=RYadyltv c=1 sm=1 tr=0 ts=699b44c7
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=468swt_i-pP2A01jCVsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yIAH6sWnUi4y-ZAJd3gzXACI9rOjcBft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-22_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 suspectscore=0 adultscore=0
 mlxlogscore=876 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602220174
X-JNJ: AAAAAAABhXcNWh8u21qoDGrUSdXcN/zLkgvF6DT8WVKI99jOjPwde4inQd6BD+/W5fZTIbTM11XNgeAz8A5OWJHOvbdfxpH13JnArZe8fvGWvUfVqNtSpPK8oCGO2mep45Ov1q7/Z7eZ7dbLgd/FBbtai22vZyQUbagPR4Xrsbk3d8KlI2hPUVlcHKO1EpaasSJFDNluODistYnYgIblQvM+twZrezV2hOS90U7Jq0EZXf5Uz8cq4+8k+kDufVqDvPUt+vTGa37Q8hOpGDFE/ExccPX61NuVA4IlBe37bodV6LqF2Jf3904pewJvNWBj/4Hfg0RAZ83VhzfGDx9QwhteWhMclWFBNEdZ5SsplR06JpXJUARzpkeEdttNxENbrFDEJpE/mSfc7zhJNz+YyPmQKXGllgCYRCO07/YVlB9zwlhWMJ7O+e+Bs8ABIB2RJg2kujxBBw/FAsK5V2bWfnjF30YlrNMl8o4Wt/f4dKj7A9KZGqnX35YN3cTZYGKeDBuJaYKpbxB+i86OK3kIq5yReXgBOmjdWnbjCrKHk7+WimKrg4RnGODJBLxvRQBimY9X7LXmqVHHBDtfS37hP+Z/X3e5DGXVNpNInu1CcP28e47yylj6gUIb9+TxzEXj718wBMj6f4vGmIlmv7HfEkbuV0DEzddqkjN+VI7eOE3pVNKW6kEOwkWT6C+sIYaq3QMUYSoFEH7NRHdy6kOTuurvHuWjfcGerCjoz5VvPeAyXP1lzo2BWPqvNhhnSUmJJRu3hSYkUK51jm4K8Oum0hv8COZWOGr9zOuzpvijbTk52Rrtukcf4ti3dKvq2qZX/V8DkqvmK3QoKwdE3WWKgDEkg7U=
Received-SPF: pass client-ip=57.103.84.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_PASS=-0.001,
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

x86_64 WHPX updates:

- target/i386/emulate fixes
- move HVF x86_mmu code to common code
- fixing debug support, which was broken since around: "gdbstub: move guest debug support check to ops"
a48e7d9e52f8fe8b47f4c74f3e99d9d677b87fe5
- switch over from winhvemulation to common x86 VM exit emulation code
- remove some log lines
- Remove WHPX CPUID traps as they're currently quite broken
- Reworked implementation of the REP prefix for string instructions

Regression note:

target/i386/emulate doesn't currently properly emulate instructions
which might cause a page fault during their execution. Notably, REP STOS/MOVS
from MMIO to an address which is unmapped until a page fault exception is raised
causes an abort() in vmx_write_mem.

This is known to cause a regression when booting Haiku in BIOS mode, with UEFI working.
Or the Hurd when launching X11. Will be addressed in a future patchset, or this one if this
is a blocker... Win9x also hits this scenario.

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

Mohamed Mediouni (13):
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

 accel/whpx/whpx-accel-ops.c            |   8 +
 accel/whpx/whpx-common.c               |  68 +--
 include/system/whpx-accel-ops.h        |  16 +-
 include/system/whpx-all.h              |  11 +-
 include/system/whpx-common.h           |   6 +-
 include/system/whpx-internal.h         |  16 -
 meson.build                            |   3 +-
 target/arm/whpx/whpx-all.c             |  43 +-
 target/i386/cpu.h                      |   2 +-
 target/i386/emulate/meson.build        |   2 +
 target/i386/emulate/x86_decode.c       |   6 +-
 target/i386/emulate/x86_emu.c          |  13 +-
 target/i386/{hvf => emulate}/x86_mmu.c |  20 +-
 target/i386/{hvf => emulate}/x86_mmu.h |   0
 target/i386/hvf/hvf.c                  |  10 +-
 target/i386/hvf/meson.build            |   1 -
 target/i386/hvf/x86.c                  |   2 +-
 target/i386/hvf/x86_task.c             |   2 +-
 target/i386/mshv/meson.build           |   4 +
 target/i386/whpx/whpx-all.c            | 579 ++++++++++---------------
 20 files changed, 358 insertions(+), 454 deletions(-)
 rename target/i386/{hvf => emulate}/x86_mmu.c (92%)
 rename target/i386/{hvf => emulate}/x86_mmu.h (100%)

-- 
2.50.1 (Apple Git-155)


