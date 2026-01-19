Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C998CCF2D5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhm91-0003ei-AN; Mon, 19 Jan 2026 05:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8r-0003b2-5W
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vhm8n-0005dQ-FK
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768817143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Myq8WfbWk3P+rJR1PLSujH488z1pfbb11ETcIohPzYU=;
 b=jEIQDd2vEvlcmv8h52qOIw0zJLV2B5bOvrc89hnXINF0G/gu8tCaKUaDVt63/XVui9A6Tx
 dFRQT3vVe/65IHREjn+kka13y5Uge/gZuyU5scULvvCQ/NRp9EycLCVMsQqEhNd9/WW+ia
 cGk68YXQC5C6/usxX+5xZUWSCiaEubg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-MdaOwnADNqy0__mIsNanZQ-1; Mon,
 19 Jan 2026 05:05:41 -0500
X-MC-Unique: MdaOwnADNqy0__mIsNanZQ-1
X-Mimecast-MFC-AGG-ID: MdaOwnADNqy0__mIsNanZQ_1768817140
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 916951800EF6
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00EEB1800109
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:05:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7767421E692D; Mon, 19 Jan 2026 11:05:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] Clean up header guards again
Date: Mon, 19 Jan 2026 11:05:32 +0100
Message-ID: <20260119100537.463312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Our use of header guards is rather sloppy.  Sloppiness there can lead
to confusing compilation errors.  This series cleans up existing
header guards.  In particular, it normalizes guard symbols to follow a
common pattern, in the hope of making clashes less likely.  It doesn't
add new header guards.  We have more than 300 headers without a
recognizable header guard.  A few of them are for multiple inclusion,
many don't need header guards because they don't do anything but
include, but quite a few probably should have one.  Left for another
day.

Previously cleaned up in merge commit ec11dc41eec (2022), merge commit
01807c8b0e9 (2019), and merge commit ca3d87d4c84 (2016).

Markus Armbruster (5):
  scripts/clean-header-guards: Update exclusions
  Clean up header guards that don't match their file name
  Clean up ill-advised or unusual header guards
  Normalize header guard symbol definition
  Clean up decorations and whitespace around header guards

 accel/accel-internal.h                      | 2 +-
 accel/tcg/tb-internal.h                     | 4 ++--
 backends/tpm/tpm_ioctl.h                    | 7 ++++---
 bsd-user/bsd-proc.h                         | 6 +++---
 crypto/akcipherpriv.h                       | 2 +-
 crypto/der.h                                | 2 +-
 crypto/tlscredsbox.h                        | 6 +++---
 hw/i386/tdvf-hob.h                          | 4 ++--
 hw/net/e1000x_regs.h                        | 2 +-
 hw/net/igb_regs.h                           | 4 ++--
 hw/riscv/riscv-iommu-bits.h                 | 2 +-
 hw/riscv/riscv-iommu.h                      | 4 ++--
 include/accel/accel-cpu-target.h            | 2 +-
 include/exec/page-protection.h              | 5 +++--
 include/exec/replay-core.h                  | 4 ++--
 include/exec/target_long.h                  | 6 +++---
 include/exec/tb-flush.h                     | 7 ++++---
 include/exec/tlb-common.h                   | 3 ++-
 include/exec/tswap.h                        | 2 +-
 include/gdbstub/helpers.h                   | 6 +++---
 include/gdbstub/syscalls.h                  | 6 +++---
 include/hw/acpi/ich9_tco.h                  | 6 +++---
 include/hw/arm/raspberrypi-fw-defs.h        | 7 +++----
 include/hw/arm/stm32l4x5_soc.h              | 4 ++--
 include/hw/audio/virtio-snd.h               | 4 ++--
 include/hw/char/max78000_uart.h             | 2 +-
 include/hw/core/hw-error.h                  | 4 ++--
 include/hw/core/qdev.h                      | 4 ++--
 include/hw/core/sysemu-cpu-ops.h            | 6 +++---
 include/hw/fsi/fsi-master.h                 | 3 ++-
 include/hw/gpio/pcf8574.h                   | 6 +++---
 include/hw/intc/loongarch_extioi_common.h   | 2 +-
 include/hw/intc/loongarch_pic_common.h      | 2 +-
 include/hw/loongarch/virt.h                 | 4 ++--
 include/hw/misc/allwinner-a10-ccm.h         | 2 +-
 include/hw/misc/sifive_e_aon.h              | 4 ++--
 include/hw/misc/xlnx-cfi-if.h               | 3 ++-
 include/hw/misc/xlnx-versal-cfu.h           | 5 +++--
 include/hw/net/xlnx-versal-canfd.h          | 4 ++--
 include/hw/pci-bridge/cxl_upstream_port.h   | 7 ++++---
 include/hw/pci-host/fsl_imx8m_phy.h         | 4 ++--
 include/hw/ppc/pnv_n1_chiplet.h             | 2 +-
 include/hw/ppc/pnv_nest_pervasive.h         | 6 +++---
 include/hw/ssi/pnv_spi_regs.h               | 4 ++--
 include/hw/virtio/vdpa-dev.h                | 5 +++--
 include/hw/virtio/vhost-user-gpio.h         | 6 +++---
 include/hw/virtio/vhost-user-scmi.h         | 6 +++---
 include/hw/xen/xen-pvh-common.h             | 4 ++--
 include/io/channel-null.h                   | 4 ++--
 include/qapi/qmp-registry.h                 | 4 ++--
 include/qemu/mem-reentrancy.h               | 2 +-
 include/qemu/target-info-qapi.h             | 4 ++--
 include/semihosting/uaccess.h               | 2 +-
 include/system/cpu-timers-internal.h        | 6 +++---
 include/system/dirtylimit.h                 | 5 +++--
 include/system/ioport.h                     | 2 +-
 include/system/spdm-socket.h                | 4 ++--
 include/tcg/insn-start-words.h              | 6 +++---
 include/tcg/tcg-temp-internal.h             | 2 +-
 include/user/tswap-target.h                 | 5 +++--
 qga/cutils.h                                | 6 +++---
 target/arm/cpu-features.h                   | 4 ++--
 target/arm/tcg/mte_helper.h                 | 6 +++---
 target/hexagon/idef-parser/parser-helpers.h | 2 +-
 target/i386/confidential-guest.h            | 5 +++--
 target/i386/emulate/x86.h                   | 4 ++--
 target/i386/emulate/x86_decode.h            | 4 ++--
 target/i386/emulate/x86_flags.h             | 6 +++---
 target/i386/kvm/xen-compat.h                | 2 +-
 target/loongarch/cpu-mmu.h                  | 2 +-
 target/loongarch/tcg/tcg_loongarch.h        | 4 +++-
 target/riscv/cpu_vendorid.h                 | 2 +-
 target/sparc/translate.h                    | 5 +++--
 target/xtensa/core-lx106/core-isa.h         | 7 +++----
 scripts/clean-header-guards.pl              | 5 +++--
 75 files changed, 163 insertions(+), 149 deletions(-)

-- 
2.52.0


