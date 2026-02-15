Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08886EF5859
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 05:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrUaj-0000Fz-SM; Sun, 15 Feb 2026 00:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUad-0000Fc-Vj
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:40 -0500
Received: from p-west2-cluster3-host6-snip4-9.eps.apple.com ([57.103.69.102]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrUaa-0004q1-M7
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 00:22:38 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id
 DFEAA180010D; Sun, 15 Feb 2026 05:22:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771132954; x=1773724954;
 bh=5r6MQJEJ3iESg5UlG2XKuo1X6toQ1yNHBuwcqgZU86U=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=QVA3j0qw3oFDGgmjDolq1IAu3vsHBMA+AjdTnonuu7yhnJosIKNgPqLwDd3kkRq0gPEy7t0zWkv5eJ63T0bGBMsD7ol+yF73CK4LUwaJRgpqwq1JhaW3z3R6p791LCfq2dFxPbL+h6YOTHqmnDLBZiPf4xW3jSHfS6jwNWooJ5sbZF7a6yYzg1+RB8lRNs6fUA8gvYcFu7YVHsnpsbvk17rU9KyTll0ZMGmTSpbSLXbk4i5KcKiEVnrvHaqOQzGKnb0hNQG92voQUMvY8R3M4DImeGgHzKosqRojyrOrmZPk2MhhfCvxTKonuMbSiq0N+meDRSkuUG4CcvP15y31iQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id
 3CB891800103; Sun, 15 Feb 2026 05:22:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 00/14] whpx: x86 updates (2026-02)
Date: Sun, 15 Feb 2026 06:22:11 +0100
Message-ID: <20260215052225.22513-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kpZ0zTdTQTYABzvQk9sCg3xn0gqlvhUm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE1MDAzNiBTYWx0ZWRfX68DekAS9aRPz
 h1kJdPsmOcnE9+5scOBx3a89Nw9ANuRgXkHXXsRWDJjBoZl4epc2dgTojQxbvBfxdnzpo59hgR0
 kD0pwkTjV5EA33zFd4vXk8fmklabQ8d+zImv7xyoQ31Ap5/vIY9VtGaepnRSFiTj2Vk9q4rT8YH
 /ib3qb1YfqIy6Qc/t4aqp4RL7Q1CYU+7WRUjiw+3/MrDI3ZIuxK1n1wGR7JwJ4XASRGp2jZHSIm
 5G6+GQcL0zMQhiPJI4v1evtOQnEWNyukPXD6ctNex4zLmarOSg0KlR9xiqhXoO2ryvbGbG8bkWv
 k3ypcRA7G0KM4IE2OFBU5Um1AN0oyooew+ZxecyMv/ivdN7JQVfh0NGM7mqxIM=
X-Authority-Info-Out: v=2.4 cv=ZsPg6t7G c=1 sm=1 tr=0 ts=69915819
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=4FhJtAkXLpUwS9ICwxIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kpZ0zTdTQTYABzvQk9sCg3xn0gqlvhUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-15_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=758 bulkscore=0
 clxscore=1030 suspectscore=0 spamscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602150036
X-JNJ: AAAAAAABX1B1dAd7tds/s9f9lreiQ0ioWrB32hggdAjP72YKjQeg7oDOrocsqdRPbRVUDbh3G8xdb8dFZi6pIoLdLw2Au3BnzzL/X3H/d5swYH7xU7kY0v+kzVQq30SPQj99l0cNZ5qYrK42HwysaFFX9K37zqLQGoGhVU8p5zLJkj8sjVoQb62U8atGWPb+9FeMxWrvqjxecSAqLuyMZHv3mBsZJOgtneeClZFozcnLzpRA6NOlahyUgSmo3XQBLwYJ6W+doej58f7Jv5cyyJX85GN1OosN6l6VijYP2LuDYBASVqwSJgaCL3gsLzXn5mkuPZi11O1EfBx1yDwAWH6KFvqGSJ+dxGErRg/FKkS9E/Dc3pJb/B7tmcxxY7C2ZHrtqJhnMDc1FkgWFp9qOphIageBQxW5urg0WPrGGbxtGxv58ol3ga2uX5r7uhinB0/EYsEXX6pKTi72mchVQKgWhESF4PjNHppb7otoELWPtcZCUC6FcGtNxl412JE43TlYJ5mMyZ17qlXG8maQp2VuUkyxGh5A41JjNQPj1dotRAZ77QJutZvlQ+dXUQpAaENSQjAV4AgLqlAzwoGEDOy0h1defRuqhZV7SVWpLl1/6XIPQS1Cv9z9/V+HM7DQ44XbsBuDly70AQb8NKK06FgUHEjWJvP1xAiFSRODUinEznzfSGrCHvHhDCkijIoi/4eXNQFLXsPnV3o19564gFhuveQpS+Le236QxH+a4kAxd2sAM2lQ8gZY7z6J6FVgUFmHAv7zp06Ss7+IPPNZfwm+91QoS8f/xwDjMGtWK7WRImuMlN62L/6VCnL3OkVPJOsM8CBvmon3zMDwp4i2JoLPbpnQTZh9PoCn
Received-SPF: pass client-ip=57.103.69.102;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Mohamed Mediouni (11):
  target/i386: emulate, hvf: move x86_mmu to common code
  whpx: i386: re-enable guest debug support
  whpx: preparatory changes before switching over from winhvemulation
  whpx: refactor whpx_destroy_vcpu to arch-specific function
  whpx: move whpx_get_reg/whpx_set_reg to generic code
  whpx: i386: switch over from winhvemulation to target/i386/emulate
  whpx: i386: remove remaining winhvemulation support code
  whpx: i386: remove messages
  whpx: i386: remove CPUID trapping
  whpx: common, i386, arm: rework state levels
  whpx: i386: saving/restoring less state for
    WHPX_LEVEL_FAST_RUNTIME_STATE

 accel/whpx/whpx-accel-ops.c            |   8 +
 accel/whpx/whpx-common.c               |  68 +++--
 include/system/whpx-accel-ops.h        |  16 +-
 include/system/whpx-all.h              |  11 +-
 include/system/whpx-common.h           |   6 +-
 include/system/whpx-internal.h         |  16 -
 meson.build                            |   3 +-
 target/arm/whpx/whpx-all.c             |  41 +--
 target/i386/cpu.h                      |   2 +-
 target/i386/emulate/meson.build        |   2 +
 target/i386/emulate/x86_decode.c       |   6 +-
 target/i386/{hvf => emulate}/x86_mmu.c |  20 +-
 target/i386/{hvf => emulate}/x86_mmu.h |   0
 target/i386/hvf/hvf.c                  |  10 +-
 target/i386/hvf/meson.build            |   1 -
 target/i386/hvf/x86.c                  |   2 +-
 target/i386/hvf/x86_task.c             |   2 +-
 target/i386/mshv/meson.build           |   4 +
 target/i386/whpx/whpx-all.c            | 391 +++++++++----------------
 19 files changed, 253 insertions(+), 356 deletions(-)
 rename target/i386/{hvf => emulate}/x86_mmu.c (92%)
 rename target/i386/{hvf => emulate}/x86_mmu.h (100%)

-- 
2.50.1 (Apple Git-155)


