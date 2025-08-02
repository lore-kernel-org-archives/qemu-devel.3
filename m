Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B319EC87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 08:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui7UI-00033h-O8; Sat, 02 Aug 2025 04:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Ra-0006zl-DJ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:21 -0400
Received: from p-east3-cluster6-host12-snip4-4.eps.apple.com ([57.103.85.245]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7RT-00052L-4A
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:13 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 36BBC180015F; Sat,  2 Aug 2025 08:18:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=xLD3aTPVXwYWJPsj0EHEsRDJLoBwcW/pVMsxvLoAftM=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:x-icloud-hme;
 b=EuM4mdrXWDng0eW1fOcumNoOilRRR+nvKnzze2nUyRfW7HsTN2GGcMpFCHFH5rsKxFdkZX7fN+mxNOMDda0tMD8bT93N8+9c48H77AUmlCuYMxd8ZhWU8J/AH5Hk2rp9pMr00SkjL+Yfw7gbByNEMQfblq8qzSjd1dvxQchH+o2bsxUAw1n4zJS2Ji2Z2FC1tVYac6NLcpwXM5hAioVgFr9/dnsNMoisETcb5KFhaQA/gbugpBK1Z9EZqt6KWYG6GzrJlbR1JFVD1aVRqoCma8fcukmBmScLgFtlZ/HQK+lIwvA4f3VlSUpaa3VHBm/8VnL+Qj/OLAEnpudDyaC7qw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 7D6C218000A4; Sat,  2 Aug 2025 08:18:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-arm@nongnu.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 00/14] WHPX support for Arm
Date: Sat,  2 Aug 2025 10:17:46 +0200
Message-Id: <20250802081800.76030-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pg8fIlttugy6IcI17DS0idNpi0Xw1UX4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA3MCBTYWx0ZWRfX0UdS+s/7d9Ty
 y8hz8NGbYQRIGf+ikt+4HRI3Fhn9U/TxxBtUTuGHPCkKkbagQ0kQ+xScJfRIaLLqtMEXhyi8V8I
 xqCwON19fo41na75qtISza4dqn1Dd/9a6D+G/deP73zkyy5/aR+giL1/9jwUV8evTcMMTZhxc8e
 lxWAi/uxbd5INBKPaUeQAgBn/6JUHNaJ786Qxj//ayJQIJpnnjKEjdJjnBATbTVqpaXeOjzLzwN
 Q46zv8ZrFEw8hCobi/aSSYAOFCZCkz+67v8pWZZq/C58YRW0tapHoq+oRu6pByvm3HrOcx6O4=
X-Proofpoint-ORIG-GUID: pg8fIlttugy6IcI17DS0idNpi0Xw1UX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=874
 malwarescore=0 clxscore=1030 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508020070
Received-SPF: pass client-ip=57.103.85.245;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this submission: whpx-v3)

Missing features:
- PSCI state sync with Hyper-V: notably breaks reboots when multiple cores are enabled
- Interrupt controller save-restore
- Debug register sync
- SVE register sync
- Adding a migration blocker because of the items above.

Updates since v2:
- Fixed up a rebase screwup for whpx-internal.h
- Fixed ID_AA64ISAR1_EL1 and ID_AA64ISAR2_EL1 feature probe for -cpu host
- Switched to ID_AA64PFR1_EL1/ID_AA64DFR0_EL1 instead of their non-AA64 variant

Updates since v1:
- Shutdowns and reboots
- MPIDR_EL1 register sync
- Fixing GICD_TYPER_LPIS value
- IPA size clamping
- -cpu host now implemented

Mohamed Mediouni (14):
  hw/arm: virt: add GICv2m for the case when ITS is not available
  whpx: Move around files before introducing AArch64 support
  whpx: reshuffle common code
  whpx: ifdef out some x86-only code paths
  hw, target, accel: whpx: change apic_in_platform to kernel_irqchip
  whpx: interrupt controller support
  whpx: add arm64 support
  whpx: copy over memory management logic from hvf
  target/arm: cpu: mark WHPX as supporting PSCI 1.1
  hw/arm: virt: cleanly fail on attempt to use the platform vGIC
    together with ITS
  whpx: arm64: clamp down IPA size
  whpx: arm64: implement -cpu host
  target/arm: whpx: instantiate GIC early
  MAINTAINERS: Add myself as a maintainer for WHPX

 MAINTAINERS                                   |    9 +-
 accel/meson.build                             |    1 +
 accel/whpx/meson.build                        |    7 +
 {target/i386 => accel}/whpx/whpx-accel-ops.c  |    6 +-
 accel/whpx/whpx-common.c                      |  674 +++++++++++
 hw/arm/virt-acpi-build.c                      |    4 +-
 hw/arm/virt.c                                 |   55 +-
 hw/i386/x86-cpu.c                             |    4 +-
 hw/intc/arm_gicv3_common.c                    |    3 +
 hw/intc/arm_gicv3_whpx.c                      |  261 +++++
 hw/intc/meson.build                           |    1 +
 include/hw/arm/virt.h                         |    2 +
 include/hw/boards.h                           |    1 +
 include/hw/intc/arm_gicv3_common.h            |    3 +
 .../whpx => include/system}/whpx-accel-ops.h  |    4 +-
 include/system/whpx-all.h                     |   14 +
 include/system/whpx-common.h                  |   23 +
 .../whpx => include/system}/whpx-internal.h   |   14 +-
 include/system/whpx.h                         |    4 +-
 meson.build                                   |   21 +-
 target/arm/cpu.c                              |    3 +-
 target/arm/cpu64.c                            |   14 +-
 target/arm/meson.build                        |    1 +
 target/arm/whpx/meson.build                   |    5 +
 target/arm/whpx/whpx-all.c                    | 1029 +++++++++++++++++
 target/arm/whpx/whpx-stub.c                   |   15 +
 target/arm/whpx_arm.h                         |   17 +
 target/i386/cpu-apic.c                        |    2 +-
 target/i386/whpx/meson.build                  |    1 -
 target/i386/whpx/whpx-all.c                   |  540 +--------
 target/i386/whpx/whpx-apic.c                  |    2 +-
 31 files changed, 2183 insertions(+), 557 deletions(-)
 create mode 100644 accel/whpx/meson.build
 rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
 create mode 100644 accel/whpx/whpx-common.c
 create mode 100644 hw/intc/arm_gicv3_whpx.c
 rename {target/i386/whpx => include/system}/whpx-accel-ops.h (92%)
 create mode 100644 include/system/whpx-all.h
 create mode 100644 include/system/whpx-common.h
 rename {target/i386/whpx => include/system}/whpx-internal.h (96%)
 create mode 100644 target/arm/whpx/meson.build
 create mode 100644 target/arm/whpx/whpx-all.c
 create mode 100644 target/arm/whpx/whpx-stub.c
 create mode 100644 target/arm/whpx_arm.h

-- 
2.39.5 (Apple Git-154)


