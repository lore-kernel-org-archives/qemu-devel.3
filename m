Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063C5C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc7x-0000Gz-1r; Sun, 16 Aug 2026 10:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc7i-0000Av-Ly
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc7g-0000bB-1I
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlSL23162140
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=TEX7gmbTv08ZMByqhnznws
 K8r64Phob7AwSP54MX2AY=; b=hRVcgNcepqzv0bOz8otEPNJE+e1/tKTrFH3WHx
 TivtMvsVZVNK8X47D+P8ot0gjzNfxlzI6GanJ0toD8JYWdvgGzv4peqCJ47MTwLa
 mo6gH+cJfzQ/ccc2kdXCQjBtGbiUZdZ6oHA+ez6VlDWtKiJ3cbNzyPeZ83ZbcJE8
 izOiV0xinmIjH3Jnl8+Vm3SzC9tHy124cMscEEoMPgqt0d/Nvgm60AwUjhPdCWYl
 HY+zqTytbYXcX4xCHNkK1xDi6cxMdwZn1QYkngsHYYPmxPQAb8bZm5hjTWTQlgbr
 OgDbhnhKAuNVFcJPR7tdhOgm4qrnROSl5yyjsk1MaYWuSHhg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7ufyk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso46854891cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891560; x=1787496360; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TEX7gmbTv08ZMByqhnznwsK8r64Phob7AwSP54MX2AY=;
 b=Af6JaVhT4Cil0gSSUommhlaHzAwVq6CXkkwd6L5CJbo1QUeSiv03lUve//25wVhrf6
 sMMG/Ee1TW2z37sZNZKF4GBohTgMFl9MDsS3vgY3uc6JLrILS//k6TIC/ENRLHYojt1Z
 Ea0ldVzwzC0Ka3AJefpQrZpDbPuMkbeJ1b5ffoYvQlkr7zIbQZaWhsA8hn6UpOd6kQsF
 RLXeEnLTcFXMrD6tZOqX9DCT1E6JhCdqALDaqJNIq1/2kukNahwDnH298XUhRxugjpwZ
 ZJ3EIpL3iROsgyPjPvEDxcER7x7nV6R06lshEd3mWr5W1pRtLm63oUrUT7bDuifuCtlf
 A4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891560; x=1787496360;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TEX7gmbTv08ZMByqhnznwsK8r64Phob7AwSP54MX2AY=;
 b=filtG5Jw1zBRTAJFGgDEpBnJ1E98/HqRMYv1SFH6s2KCAbqC1G0XoaLt/yGED+LujY
 C4cTZOjEjXseGR+9QN9pLkfQWjHLotHvMWad1afXWDbjp8nKYu89QDtMQfmQmB99CbYm
 zrM5bqHB8DlsqZq+ZQNgOYYzJq4PWb8z3AJf3q1KgwaH4v+0Fk0pwqNFHP7Kotxr91/K
 JrAMjkVmorP3w3HcPHrTn61Iwn+0caAlPYoK5vdvwY9Oi4edczhPwXq1meZOiYqqfd2P
 ZPQHCDrYVeK6mvkYbGnVZK10kK7SjvcyULq13FEmIaGtLRFwoVs93C2qKnzpaOa+JKJz
 haew==
X-Gm-Message-State: AOJu0YwZ7VysqrmEEaDulXmSy2saQwo2t+ForD0bo+z0hC6iAaVz/dbQ
 FFe0tOFhywv8eE2kCfk7sL+OVdf54UWAhV6NNvssXdTjT2BK4DQWlfb9ikTPHblrcYVlxiaBHaN
 IYscWwokBEl1hqS1DJZtTR7oO3hr/42n8g4xHADVKSoyg1I0+ZyT4eQGDjwKJruwu6A==
X-Gm-Gg: AR+sD13aCL+eG5Xpn81WvfwlhAsioWM5pCZowfUME78wYvEc51gUA7daU1ZxXNHhHCQ
 pseb4AOv7S1TTWW4y2f3PyZD60C856PPpjQGLs75j/KsmLTWe5JVpcQ8P7MUn60uE7UQKArmSCh
 sxxyr06OMOSnjCDUPyMK36ZUpK8T39xaQtgQMUdJOpENC0tElB91iva3a7rYWZjYaaHAqhjH87M
 E242GUjFrMbY07rq4Qmh5sq9IRGSX6/Bgkkrqhl9gH9tv+t9xOdsZPDUN73+1WOMQGzOiDqiwF6
 X5ibEMaJ/zTTfyVLNXg6L33Mxw3ba0txmg+6LWOrdTnzQV2b1I6zSPBSfsDA8A23R92OqOUiTlW
 hvIxzBnrovDML/GqIWSNqYhiNEh+D2cb4/kdQZuES1A==
X-Received: by 2002:a05:622a:1901:b0:51b:fe3c:6c1 with SMTP id
 d75a77b69052e-52d85444130mr185409081cf.27.1786891559592; 
 Sun, 16 Aug 2026 07:45:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1901:b0:51b:fe3c:6c1 with SMTP id
 d75a77b69052e-52d85444130mr185408711cf.27.1786891559090; 
 Sun, 16 Aug 2026 07:45:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610ecf4sm46234895e9.7.2026.08.16.07.45.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:45:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/56] Misc HW patches for 2026-08-16
Date: Sun, 16 Aug 2026 16:44:59 +0200
Message-ID: <20260816144556.69009-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExNyBTYWx0ZWRfXwH/dvMaKMCw5
 rFJln15ZQl1vFbhxnqVD7U9gxY+w8zFcIU3uH3OennJFkKco+MPMfusWTDgd865LZF0aQ1zk8Cc
 6DdPwSSEZMAkdEOz/cYqvoBmeQp3gGGTnref2XXmlH+/hmrYiwJT2fBT7limQBQjLeFhKv3yqpJ
 21pX03PjaOdhJ1PeJWuPxEBXdmXZxStMQ1tRybnjjKMSdYcrY+I6lj5+JLqYmqG9DIUp5jvm1Yp
 Jo1qBNCV+SykhjzWwPn0/FQqI+zRuAs8s+lTYOkpsVUdz6xHpSxJfYuJes9tQqM+7xNx6pm+vmv
 AkYpEyPxlo0vsJu8xV/VvCtXdFv/D47Q9KtEnA1w0wPZrOOAemk+Ax4MclsN9idGWf5Aha4N5jz
 KfwX1ef1+bJzxzQD0mkuqW6Q+VW/fR0IOQ75EG8nyzNfTD33iYMn8QZjZB689m2gSdCf2pU+6yM
 TUHUJHYWb9O+iHIBrGw==
X-Proofpoint-GUID: TXKPY_S-JQFrYvKFK6J_IzIQpMqddS_z
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a81cd29 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=P5CfKFitDfONB5l4hMEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: TXKPY_S-JQFrYvKFK6J_IzIQpMqddS_z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExNyBTYWx0ZWRfXw8dPZYGfizNs
 CONxPAhKHEwUGLO1d0LvDIHbfCjWvIR1OR6uF+HVs8aE3gY55FwY/m/D8q2KYSrQhpQGNDWm3TM
 szpuyepqsZr2nwqtFJp7eTAhr/wUe9s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160117
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit af06b5df2610fe5de6c02d17c17bced9e9f0d47d:

  Merge tag 'qom-qdev-20260814' of https://gitlab.com/mcayland-ntx/qemu into staging (2026-08-14 08:44:51 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260816

for you to fetch changes up to b409523587c49a08b1ddadd51212a320092347b1:

  hw/core/machine: Move EHCI migration compat properties to 11.1 (2026-08-16 16:35:27 +0200)

----------------------------------------------------------------
Misc HW and Monitor patch queue

- Bug fixes

 . Reinstate x86/pc 'xenfv' machine alias
 . Defend against malformed ELF headers to prevent underflows
 . Restore ROMD mode after migration for Intel PFlash (CFI01)
 . Fix VLAN tag handling on incoming packets on RTL8139 model

- Refactoring (Monitor, common CPU, NMI)

 . Add missing inclusions and remove unnecessary ones
 . Use qdev_is_realized() consistently (no direct field access)
 . Remove deprecated DEFINE_PROP_DMAADDR() macro
 . Renaming churn around cpu_{exec,common}* helpers
 . Simplify NMI API hanlding
 . Move QMP handlers (physmem, nmi) to appropriate subsystems
 . Replace container_of() casts with HMP typed accessors
 . Rename @mon to @hmp in MonitorHMP for clarity

----------------------------------------------------------------

Akihiko Odaki (13):
  qdev: Make qdev_is_realized() take a const DeviceState *
  hw/hyperv/balloon: Use qdev_is_realized()
  hw/intc/apic: Use qdev_is_realized()
  hw/mem/memory-device: Use qdev_is_realized()
  hw/mem/pc-dimm: Use qdev_is_realized()
  hw/nvram: Use qdev_is_realized()
  hw/ppc/pnv_xscom: Use qdev_is_realized()
  hw/vfio: Use qdev_is_realized()
  hw/virtio/virtio-mem: Use qdev_is_realized()
  hw/virtio/virtio-qmp: Use qdev_is_realized()
  target/i386/cpu: Use qdev_is_realized()
  target/s390x: Use qdev_is_realized()
  hw/qdev: Parent device before setting parent bus

Alex Bennée (1):
  hw/elf_ops: defend against weird elf headers

Bin Guo (1):
  hw/block/pflash_cfi01: Restore ROMD mode after migration

Dario Faggioli (1):
  hw/i386/pc: xen: reinstate the "xenfv" machine alias

Jamin Lin (1):
  hw/core/machine: Move EHCI migration compat properties to 11.1

Marc-André Lureau (1):
  hw/mem/nvdimm: fix "size" property typename

Peter Maydell (2):
  hw/net/rtl8139: Fix handling of VLAN tags on incoming short packets
  hw/net/rtl8139: Send whole of vlan-tagged packet when doing loopback

Philippe Mathieu-Daudé (35):
  hw/qdev: Remove DEFINE_PROP_DMAADDR() and 'hw/qdev-dma.h'
  hw/cpu: Correct CPU_GET_CLASS() comment
  hw/cpu: Include missing 'qemu/accel.h' header
  hw/cpu: Move internal declarations to new 'cpu-internal.h' header
  hw/cpu: Rename cpu_common_realizefn() -> cpu_exec_realize()
  hw/cpu: Rename cpu_exec_realizefn() -> cpu_common_realize()
  hw/cpu: Rename cpu_exec_unrealizefn() -> cpu_common_unrealize()
  hw/cpu: Extract cpu_exec_realize() out of cpu_common_realizefn()
  hw/cpu: Move system-specific cpu_exec_realize() to cpu-system.c
  hw/nmi: Use object_child_foreach_recursive() in nmi_children()
  hw/s390x/virtio-ccw: Always inject NMI to first CPU
  hw/nmi: Remove @cpu_index argument from
    NMIClass::nmi_monitor_handler()
  hw/nmi: Remove @cpu_index argument from nmi_inject()
  hw/nmi: Rename nmi_monitor_handler() -> raise_nmi()
  hw/nmi: Remove unused @errp argument from raise_nmi()
  hw/nmi: Raise NMI line only once
  hexagon: Remove unnecessary 'monitor/monitor.h' header
  net/vhost-vdpa: Include missing 'qemu/iov.h' header
  tests/unit: Include 'qemu/main-loop.h' header in test-util-sockets.c
  qapi/qmp-dispatch: Include 'qemu/aio-wait.h' and 'monitor/monitor.h'
  qapi/qmp-registry: Remove unnecessary 'monitor/monitor.h' header
  migration/hmp-cmds: Include 'block/block-global-state.h' header
  monitor: Include missing 'qemu/aio-wait.h' header
  monitor: Include missing 'qemu/lockable.h' header
  monitor: Include missing 'qemu/coroutine-core.h' header
  monitor: Reduce inclusion of 'qapi/qapi-emit-events.h' header
  monitor: Remove unnecessary 'block/block.h' header
  system: Remove unnecessary 'monitor/monitor.h' header
  system/dirtylimit: Extract HMP code to dirtylimit-hmp-cmds.c
  system: Move qmp_inject_nmi() to hw/core/machine-qmp-cmds.c
  system: Extract QMP memsave/pmemsave commands to physmem-qmp-cmds.c
  system: Move runstate-related code from cpus.c to runstate.c
  monitor: Rename MonitorHMP @mon -> @hmp
  monitor: Better express monitor_read()'s opaque arg is of Monitor type
  monitor: Replace container_of(MonitorHMP, parent_obj) -> MONITOR_HMP()

Stefan Hajnoczi (1):
  hw/nvme: add SPDM_SOCKET Kconfig dependency

 MAINTAINERS                      |   3 +
 qapi/machine.json                |   7 +-
 qapi/run-state.json              |   6 +-
 hw/core/cpu-internal.h           |  23 +++
 include/hw/core/cpu.h            |  15 +-
 include/hw/core/nmi.h            |  33 +++-
 include/hw/core/qdev-dma.h       |  16 --
 include/hw/core/qdev.h           |   2 +-
 include/hw/hexagon/hexagon_tlb.h |   2 +-
 include/monitor/monitor.h        |   7 +-
 include/qapi/qmp-registry.h      |   1 -
 monitor/monitor-internal.h       |   3 +-
 target/hexagon/hex_mmu.h         |   3 +-
 include/hw/elf_ops.h.inc         |   5 +
 hw/block/pflash_cfi01.c          |  10 ++
 hw/core/cpu-common.c             |  32 +---
 hw/core/cpu-system.c             |  30 +++-
 hw/core/cpu-user.c               |   8 +-
 hw/core/machine-qmp-cmds.c       |   6 +
 hw/core/machine.c                |   7 +-
 hw/core/nmi.c                    |  48 ++----
 hw/core/qdev.c                   |  51 ++++---
 hw/hppa/machine.c                |   4 +-
 hw/hyperv/hv-balloon.c           |   2 +-
 hw/i386/pc_piix.c                |   1 +
 hw/i386/x86.c                    |   4 +-
 hw/intc/apic_common.c            |   2 +-
 hw/intc/m68k_irqc.c              |   4 +-
 hw/ipmi/ipmi.c                   |   3 +-
 hw/m68k/q800-glue.c              |   4 +-
 hw/mem/memory-device.c           |   4 +-
 hw/mem/nvdimm.c                  |   2 +-
 hw/mem/pc-dimm.c                 |   2 +-
 hw/misc/macio/gpio.c             |   4 +-
 hw/net/rtl8139.c                 |   6 +-
 hw/nvram/xlnx-bbram.c            |   2 +-
 hw/nvram/xlnx-efuse.c            |   2 +-
 hw/ppc/pnv.c                     |   4 +-
 hw/ppc/pnv_xscom.c               |   2 +-
 hw/ppc/spapr.c                   |   4 +-
 hw/s390x/s390-virtio-ccw.c       |   8 +-
 hw/usb/hcd-ohci-pci.c            |   1 -
 hw/usb/hcd-ohci-sysbus.c         |   3 +-
 hw/usb/hcd-ohci.c                |   1 -
 hw/vfio/container-legacy.c       |   4 +-
 hw/vfio/device.c                 |   4 +-
 hw/vfio/iommufd.c                |   2 +-
 hw/virtio/virtio-mem.c           |   4 +-
 hw/virtio/virtio-qmp.c           |   4 +-
 hw/watchdog/watchdog.c           |   2 +-
 migration/migration-hmp-cmds.c   |   1 +
 monitor/fds.c                    |   1 +
 monitor/hmp-cmds.c               |   6 +-
 monitor/hmp.c                    | 136 ++++++++---------
 monitor/monitor.c                |   2 +
 monitor/qmp.c                    |   3 +-
 net/vhost-vdpa.c                 |   1 +
 qapi/qmp-dispatch.c              |   2 +
 system/cpus.c                    | 248 -------------------------------
 system/device_tree.c             |   1 -
 system/dirtylimit-hmp-cmds.c     |  74 +++++++++
 system/dirtylimit.c              |  60 --------
 system/physmem-qmp-cmds.c        | 107 +++++++++++++
 system/physmem.c                 |   2 -
 system/runstate.c                | 154 +++++++++++++++++++
 target/alpha/cpu.c               |   2 +-
 target/arm/cpu.c                 |   2 +-
 target/avr/cpu.c                 |   2 +-
 target/hexagon/cpu.c             |   2 +-
 target/hppa/cpu.c                |   2 +-
 target/i386/cpu.c                |  12 +-
 target/i386/kvm/kvm-cpu.c        |   4 +-
 target/loongarch/cpu.c           |   2 +-
 target/m68k/cpu.c                |   2 +-
 target/microblaze/cpu.c          |   2 +-
 target/mips/cpu.c                |   2 +-
 target/or1k/cpu.c                |   2 +-
 target/ppc/cpu_init.c            |   4 +-
 target/riscv/cpu.c               |   2 +-
 target/riscv/kvm/kvm-cpu.c       |   2 +-
 target/riscv/tcg/tcg-cpu.c       |   2 +-
 target/rx/cpu.c                  |   2 +-
 target/s390x/cpu.c               |   2 +-
 target/s390x/cpu_models.c        |   4 +-
 target/sh4/cpu.c                 |   2 +-
 target/sparc/cpu.c               |   2 +-
 target/tricore/cpu.c             |   2 +-
 target/xtensa/cpu.c              |   2 +-
 tests/unit/test-qdev.c           |  13 ++
 tests/unit/test-util-sockets.c   |   1 +
 ui/ui-hmp-cmds.c                 |   6 +-
 hmp-commands.hx                  |   7 +-
 hw/nvme/Kconfig                  |   1 +
 system/meson.build               |   2 +
 94 files changed, 702 insertions(+), 595 deletions(-)
 create mode 100644 hw/core/cpu-internal.h
 delete mode 100644 include/hw/core/qdev-dma.h
 create mode 100644 system/dirtylimit-hmp-cmds.c
 create mode 100644 system/physmem-qmp-cmds.c

-- 
2.53.0


