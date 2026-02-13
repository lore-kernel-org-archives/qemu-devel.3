Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B515FEF48C8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 03:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqk8H-0008Et-A7; Thu, 12 Feb 2026 22:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8E-0008E7-Vk
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:14 -0500
Received: from p-west1-cluster5-host1-snip4-1.eps.apple.com ([57.103.66.172]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqk8C-0005A8-Tk
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 22:46:14 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 E149518002D3; Fri, 13 Feb 2026 03:46:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770954368; x=1773546368;
 bh=5/IltRImc6gegLCsNoWDi+eINUGJYWBjLLMmPMJ7ibM=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=d6fo7RBwXYh75+EKvs6HoLb9vmeXYWUcB3EjkWrCgUyJwwGDBpqWQfSqBKDbyo2d1sVgHQCsEHuQze6m0FhpytHRuC/ek46E/8RmefVaxhB+5iNEQEgiwnKCgmvtWtgICfJkobpskf0rGKGpyZ/cC3FJhsrIhq5F8wUeM1JbWa4z15FcubEV3ZICGTn0Ctq98MmNczXOg33BRS1JlfwDq+XiRY9xZTGrS9gKKu0ENmxC8D14/7V6a06gJ+ewri+/5HV0m54C3wf4Qp91V5bUzM8ngeUC2gclXT4jFF3cOxiIL3qr3oVgcyTkl+h4aCjK1UkYBS7BAnUvSg3N/0ddCA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 B7DAB18002D0; Fri, 13 Feb 2026 03:46:00 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 00/10] whpx: x86 updates (2026-02)
Date: Fri, 13 Feb 2026 04:45:43 +0100
Message-ID: <20260213034556.13471-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=Y8z1cxeN c=1 sm=1 tr=0 ts=698e9e7e
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=UNKDkAC45PISUlO_G4wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P4t30khYDSCHnMQalhgXYqmz1AzJ0MYZ
X-Proofpoint-GUID: P4t30khYDSCHnMQalhgXYqmz1AzJ0MYZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDAyNSBTYWx0ZWRfXzJKe4S5GVVz2
 Hdf7bWTAd8bqYoQuB/ckLYduhwZko++XfPbXC1/CnKXVUVTeUoFIdbCM6UEOFR6U9swbK+B30ii
 drV47UK9XoF2KcGLPhAdSMaWjaDAFWVjxgf0Z24o4UvPjBa1NXxDPjnszITqm7wvyE87YAxmBjw
 ZMneeuK7XzxxqeRn7oW70ckHVS5zT95cG2w8FAPteZS8qRq5PZbsdvClVDvXyqkgCyd1xIvSZ+6
 Nxf3adkLwlxXdhCZI/1RjDhFGbNtGf6SPsV9DrdkYwn4RJcQ3zXJgdplHf8nrAEcED1Tb4lm5Tq
 KrB0H0vjRjVA/VziNXcNy1Oighhi8wU89o2eKwqexHv4pK5PLhXFX0Gf3C7/9g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 clxscore=1030 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0
 mlxlogscore=758 adultscore=0 lowpriorityscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130025
X-JNJ: AAAAAAABj0daTcSe3R04s8iOe90v9/LyFxoslOge9hAtEhJYAEn+v/sQKo+nLUcqb+Su2PgC34sgLj+zJZgituQ51gpM6YZKhAvpjraqOtj0mEu2Xbdzr3nAbfMtA02sw4KuU+D9p87PHLH6nD5jz6ly5yFYkHz/gtKE+2X8qWFItvFdKv3m7eyUySQPo4Yb6aEVk0Nhg/SjwpLG3OZm9p3Rj3ok/KAn0hOdBI+ulKlkbnmhJEwpijykkhCFoM8n09y5YWKjE0/nj7+flf2DXLgfcpDModD85ejdpqN9sj/WDt264kKAsRCU3bu6laOhqlxpzxOVN0eOnko0b0HO35yW7SqeNOHN5eknLNgb76hsQez9p5KBsZyfDSgsx+2rbPH10kH7NU6K35Y20xI9ikObYY39XsMkB3Vp8bNR33HD6II3ETF/mf/d9TMJJaMmMUornanVo9Esp+cVjyX6BWei/AfSmxcn8ZZj5IkhjuQ0sfohUF7juzLXHGVxCg9ITMi1HkkUTgocfCOLpZ8QtHxETfZkpRiS+5Kyx9zPQZK7JW+ojmsiTLIDHmpYtrb6jtLfUIAyHebwEsQH6kgq4yam20PcUZ764o1w/zuMvkNL9IffVp+urkVSI05Ue+gps21TAHi3Vhb/ekQvn8QCRstQbtiBhFAtlok9tPQ4PLsAoUfmiyWHKo2CigLCJWyZz2e6pj9nR7C7Yu4bQ8iCsPASUqlxbrMKyJ9xp7iLASrw5/4EV716CuOx0Lzoa8DoCsfRUs5qe1C4QtpK2+9mYXmZehqCsxVc7HwbyzF/6Glr4fwWY7RK
Received-SPF: pass client-ip=57.103.66.172;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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

- move HVF x86_mmu code to common code
- fixing debug support, which was broken since around: "gdbstub: move guest debug support check to ops"
a48e7d9e52f8fe8b47f4c74f3e99d9d677b87fe5
- switch over from winhvemulation to common x86 VM exit emulation code
- remove some log lines
- Remove WHPX CPUID traps as they're currently quite broken

Changes added since v1:
- move HVF x86_mmu code to common code
- Use x86_mmu in WHPX MMIO exits
- Remove WHPX CPUID traps as they're currently quite broken
- Optimise MMIO vmexits by not restoring the full state

Mohamed Mediouni (10):
  target/i386: emulate, hvf: move x86_mmu to common code
  whpx: re-enable guest debug support on x86
  whpx: preparatory changes before switching over from winhvemulation
  whpx: refactor whpx_destroy_vcpu to arch-specific function
  whpx: move whpx_get_reg/whpx_set_reg to generic code
  whpx: x86: switch over from winhvemulation to target/i386/emulate
  whpx: remove remaining winhvemulation support code
  whpx: x86: remove messages
  whpx: i386: remove CPUID trapping
  whpx: x86: optimise MMIO vmexit by only restoring needed registers

 accel/whpx/whpx-accel-ops.c            |   8 +
 accel/whpx/whpx-common.c               |  62 ++--
 include/system/whpx-accel-ops.h        |   8 +-
 include/system/whpx-all.h              |   5 +
 include/system/whpx-common.h           |   6 +-
 include/system/whpx-internal.h         |  16 --
 meson.build                            |   3 +-
 target/arm/whpx/whpx-all.c             |  33 +--
 target/i386/cpu.h                      |   2 +-
 target/i386/emulate/meson.build        |   2 +
 target/i386/{hvf => emulate}/x86_mmu.c |  14 +-
 target/i386/{hvf => emulate}/x86_mmu.h |   0
 target/i386/hvf/hvf.c                  |   6 +-
 target/i386/hvf/meson.build            |   1 -
 target/i386/hvf/x86.c                  |   2 +-
 target/i386/hvf/x86_task.c             |   2 +-
 target/i386/mshv/meson.build           |   4 +
 target/i386/whpx/whpx-all.c            | 373 +++++++++----------------
 18 files changed, 217 insertions(+), 330 deletions(-)
 rename target/i386/{hvf => emulate}/x86_mmu.c (95%)
 rename target/i386/{hvf => emulate}/x86_mmu.h (100%)

-- 
2.50.1 (Apple Git-155)


