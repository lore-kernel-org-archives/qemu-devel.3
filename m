Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6606ECD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcsv-00009G-Mp; Mon, 22 Jun 2026 07:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbcsq-00008q-Gm
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wbcso-0003Yw-3f
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782127925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWmWuwiPi/xW5bLWPZmjdzt9O9p+zEOwk+znYX2m14M=;
 b=O781PeYTI7poi/gzjKzm1LIwIGiMdHEXhS3smvgp6Z6souJDlwaPPuuH3gWYkKFs8b8dca
 FElshQdIbkKHCpXgFkVfUTfh0dJ5ORWQcwVIWZmVRG8vwGMIIev9z/e4PZq7FlK8vtdRb5
 KTzwpJ7HBpEijyXwSd39xETaLmlyGco=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-IIPndNd0N_u24MGCr3Sh9A-1; Mon,
 22 Jun 2026 07:32:01 -0400
X-MC-Unique: IIPndNd0N_u24MGCr3Sh9A-1
X-Mimecast-MFC-AGG-ID: IIPndNd0N_u24MGCr3Sh9A_1782127921
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0ADD61955F75
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:32:01 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.119])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04750195394E; Mon, 22 Jun 2026 11:31:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/3] MAINTAINERS: record known Git Lab handles for all
 reviewers
Date: Mon, 22 Jun 2026 12:31:52 +0100
Message-ID: <20260622113152.1710585-4-berrange@redhat.com>
In-Reply-To: <20260622113152.1710585-1-berrange@redhat.com>
References: <20260622113152.1710585-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

This updates MAINTAINERS with a "G:" line corresponding to every
"R:" line that can be identified with a match against

  https://gitlab.com/qemu-project/qemu/-/project_members

This update was done with the same automation as the previous
commit.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a62fe0e81..0d57df6e4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -74,9 +74,12 @@ F: */
 
 Project policy and developer guides
 R: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 R: Daniel P. Berrangé <berrange@redhat.com>
+G: @berrange
 R: Markus Armbruster <armbru@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 W: https://www.qemu.org/docs/master/devel/index.html
 S: Odd Fixes
 F: docs/devel/build-environment.rst
@@ -186,6 +189,7 @@ Overall TCG CPUs
 M: Richard Henderson <richard.henderson@linaro.org>
 G: @rth7680
 R: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: system/watchpoint.c
 F: page-vary-system.c
@@ -270,6 +274,7 @@ Hexagon TCG CPUs
 M: Brian Cain <brian.cain@oss.qualcomm.com>
 G: @brian-cain
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
+G: @pierrick.bouvier
 S: Supported
 F: target/hexagon/
 X: target/hexagon/idef-parser/
@@ -355,6 +360,7 @@ G: @npiggin
 R: Chinmay Rath <rathc@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
+G: @harshpb
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
@@ -376,6 +382,7 @@ M: Alistair Francis <alistair.francis@wdc.com>
 G: @alistair23
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
+G: @danielhb
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
 R: Chao Liu <chao.liu.zevorn@gmail.com>
 L: qemu-riscv@nongnu.org
@@ -424,6 +431,7 @@ M: Richard Henderson <richard.henderson@linaro.org>
 G: @rth7680
 M: Ilya Leoshkevich <iii@linux.ibm.com>
 R: David Hildenbrand <david@kernel.org>
+G: @davidhildenbrand
 S: Maintained
 F: target/s390x/
 F: target/s390x/tcg
@@ -520,6 +528,7 @@ PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 G: @npiggin
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
+G: @harshpb
 S: Odd Fixes
 F: target/ppc/kvm.c
 
@@ -571,7 +580,9 @@ Overall CPUs other accelerators
 M: Richard Henderson <richard.henderson@linaro.org>
 G: @rth7680
 R: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Maintained
 F: include/exec/cpu*.h
 F: include/exec/target_long.h
@@ -1075,6 +1086,7 @@ Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
 G: @pm215
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/raspi*.c
@@ -1758,6 +1770,7 @@ G: @npiggin
 R: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
+G: @harshpb
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: docs/system/ppc/powernv.rst
@@ -2000,6 +2013,7 @@ S390-ccw boot
 M: Jared Rossi <jrossi@linux.ibm.com>
 R: Zhuoying Cai <zycai@linux.ibm.com>
 R: Christian Borntraeger <borntraeger@linux.ibm.com>
+G: @cborntra
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
@@ -2039,6 +2053,7 @@ L: qemu-s390x@nongnu.org
 S390 CPU models
 M: Hendrik Brueckner <brueckner@linux.ibm.com>
 R: David Hildenbrand <david@kernel.org>
+G: @davidhildenbrand
 S: Maintained
 F: target/s390x/cpu_features*.[ch]
 F: target/s390x/cpu_models.[ch]
@@ -2323,6 +2338,7 @@ G: @mstredhat
 M: Igor Mammedov <imammedo@redhat.com>
 G: @imammedo
 R: Ani Sinha <anisinha@redhat.com>
+G: @anisinha
 S: Supported
 F: include/hw/acpi/*
 F: include/hw/firmware/smbios.h
@@ -2404,6 +2420,7 @@ Character devices
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 G: @marcandre.lureau-rh
 R: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Odd Fixes
 F: hw/char/
 F: include/hw/char/
@@ -2430,6 +2447,7 @@ SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
 G: @bonzini
 R: Fam Zheng <fam@euphon.net>
+G: @famzheng
 S: Supported
 F: include/hw/scsi/*
 F: hw/scsi/*
@@ -2554,6 +2572,7 @@ vhost
 M: Michael S. Tsirkin <mst@redhat.com>
 G: @mstredhat
 R: Stefano Garzarella <sgarzare@redhat.com>
+G: @sgarzarella
 S: Supported
 F: hw/*/*vhost*
 F: docs/interop/vhost-user*
@@ -2604,6 +2623,7 @@ virtio-9p
 M: Christian Schoenebeck <qemu_oss@crudebyte.com>
 G: @schoenebeck
 R: Greg Kurz <groug@kaod.org>
+G: @gkurz
 S: Maintained
 W: https://wiki.qemu.org/Documentation/9p
 F: hw/9pfs/
@@ -2733,6 +2753,7 @@ vhost-user-snd
 M: Alex Bennée <alex.bennee@linaro.org>
 G: @stsquad
 R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+G: @epilys
 S: Maintained
 F: hw/virtio/vhost-user-snd*
 F: include/hw/virtio/vhost-user-snd.h
@@ -2940,6 +2961,7 @@ F: include/hw/nvram/eeprom93xx.h
 VM Generation ID
 S: Orphan
 R: Ani Sinha <ani@anisinha.ca>
+G: @anisinha
 F: hw/acpi/vmgenid.c
 F: include/hw/acpi/vmgenid.h
 F: docs/specs/vmgenid.rst
@@ -2956,7 +2978,9 @@ Unimplemented device
 M: Peter Maydell <peter.maydell@linaro.org>
 G: @pm215
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Ani Sinha <ani@anisinha.ca>
+G: @anisinha
 S: Maintained
 F: include/hw/misc/unimp.h
 F: hw/misc/unimp.c
@@ -2964,7 +2988,9 @@ F: hw/misc/unimp.c
 Empty slot
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Ani Sinha <ani@anisinha.ca>
+G: @anisinha
 S: Maintained
 F: include/hw/misc/empty_slot.h
 F: hw/misc/empty_slot.c
@@ -3067,6 +3093,7 @@ F: include/hw/isa/vt82c686.h
 
 Firmware configuration (fw_cfg)
 R: Gerd Hoffmann <kraxel@redhat.com>
+G: @kraxel
 S: Orphaned
 F: docs/specs/fw_cfg.rst
 F: hw/nvram/fw_cfg*.c
@@ -3185,6 +3212,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 G: @cborntra
 R: David Hildenbrand <david@kernel.org>
+G: @davidhildenbrand
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/intc/s390_flic*.c
@@ -3265,6 +3293,7 @@ ALSA Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
 G: @kraxel
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
+G: @schoenebeck
 S: Odd Fixes
 F: audio/alsaaudio.c
 
@@ -3274,6 +3303,7 @@ G: @kraxel
 M: Philippe Mathieu-Daudé <philmd@mailo.com>
 G: @philmd
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
+G: @schoenebeck
 R: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
 S: Odd Fixes
 F: audio/coreaudio.m
@@ -3288,6 +3318,7 @@ JACK Audio Connection Kit backend
 M: Gerd Hoffmann <kraxel@redhat.com>
 G: @kraxel
 R: Christian Schoenebeck <qemu_oss@crudebyte.com>
+G: @schoenebeck
 S: Odd Fixes
 F: audio/jackaudio.c
 
@@ -3307,6 +3338,7 @@ SDL Audio backend
 M: Gerd Hoffmann <kraxel@redhat.com>
 G: @kraxel
 R: Thomas Huth <th.huth+qemu@posteo.eu>
+G: @thuth
 S: Odd Fixes
 F: audio/sdlaudio.c
 
@@ -3373,6 +3405,7 @@ Block SCSI subsystem
 M: Paolo Bonzini <pbonzini@redhat.com>
 G: @bonzini
 R: Fam Zheng <fam@euphon.net>
+G: @famzheng
 L: qemu-block@nongnu.org
 S: Supported
 F: include/scsi/*
@@ -3413,6 +3446,7 @@ CheckPoint and Restart (CPR)
 M: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
 R: Peter Xu <peterx@redhat.com>
 R: Fabiano Rosas <farosas@suse.de>
+G: @farosas
 R: Mark Kanda <mark.kanda@oracle.com>
 R: Ben Chaney <bchaney@akamai.com>
 S: Supported
@@ -3438,6 +3472,7 @@ G: @ebblake
 M: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
 G: @vsementsov
 R: John Snow <jsnow@redhat.com>
+G: @jsnow
 L: qemu-block@nongnu.org
 S: Supported
 F: include/qemu/hbitmap.h
@@ -3456,6 +3491,7 @@ Character device backends
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 G: @marcandre.lureau-rh
 R: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: chardev/
 F: include/chardev/
@@ -3491,6 +3527,7 @@ Device Tree
 M: Alistair Francis <alistair.francis@wdc.com>
 G: @alistair23
 R: David Gibson <david@gibson.dropbear.id.au>
+G: @dgibson
 S: Maintained
 F: system/device_tree.c
 F: include/system/device_tree.h
@@ -3500,6 +3537,7 @@ S: Supported
 M: Marc-André Lureau <marcandre.lureau@redhat.com>
 G: @marcandre.lureau-rh
 R: Ani Sinha <anisinha@redhat.com>
+G: @anisinha
 F: dump/
 F: hw/misc/vmcoreinfo.c
 F: include/hw/misc/vmcoreinfo.h
@@ -3548,6 +3586,7 @@ GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
 G: @stsquad
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Maintained
 F: docs/system/gdb.rst
 F: gdbstub/*
@@ -3563,6 +3602,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 G: @bonzini
 M: Peter Xu <peterx@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
@@ -3816,6 +3856,7 @@ QOM
 M: Paolo Bonzini <pbonzini@redhat.com>
 G: @bonzini
 R: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Supported
 F: docs/devel/qom.rst
 F: include/qom/
@@ -3832,6 +3873,7 @@ QDev
 M: Paolo Bonzini <pbonzini@redhat.com>
 G: @bonzini
 R: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Supported
 F: docs/qdev-device-use.txt
 F: hw/core/qdev*
@@ -3870,6 +3912,7 @@ G: @farosas
 M: Laurent Vivier <lvivier@redhat.com>
 G: @lvivier
 R: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 S: Maintained
 F: system/qtest.c
 F: include/system/qtest.h
@@ -3892,8 +3935,11 @@ Device Fuzzing
 M: Alexander Bulekov <alxndr@bu.edu>
 G: @a1xndr
 R: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Stefan Hajnoczi <stefanha@redhat.com>
+G: @stefanha
 R: Fabiano Rosas <farosas@suse.de>
+G: @farosas
 R: Darren Kenny <darren.kenny@oracle.com> 
 S: Maintained
 F: tests/qtest/fuzz/
@@ -4195,7 +4241,9 @@ F: tests/qtest/test-filter*
 
 Record/replay
 R: Paolo Bonzini <pbonzini@redhat.com>
+G: @bonzini
 R: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 W: https://wiki.qemu.org/Features/record-replay
 S: Odd Fixes
 F: replay/*
@@ -4273,6 +4321,7 @@ F: tests/qtest/isl_pmbus_vr-test.c
 FSI
 M: Ninad Palsule <ninad@linux.ibm.com>
 R: Cédric Le Goater <clg@kaod.org>
+G: @clegoate
 S: Maintained
 F: hw/fsi/*
 F: include/hw/fsi/*
@@ -4281,6 +4330,7 @@ F: tests/qtest/aspeed_fsi-test.c
 
 Firmware schema specifications
 R: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 R: Kashyap Chamarthy <kchamart@redhat.com>
 S: Orphan
 F: docs/interop/firmware.json
@@ -4303,6 +4353,7 @@ G: @kraxel
 M: Stefano Garzarella <sgarzare@redhat.com>
 G: @sgarzarella
 R: Ani Sinha <anisinha@redhat.com>
+G: @anisinha
 S: Maintained
 F: backends/igvm*.c
 F: docs/system/igvm.rst
@@ -4314,6 +4365,7 @@ VT-d Emulation
 M: Michael S. Tsirkin <mst@redhat.com>
 G: @mstredhat
 R: Jason Wang <jasowang@redhat.com>
+G: @jasowang
 R: Yi Liu <yi.l.liu@intel.com>
 R: Clément Mathieu--Drif <clement.mathieu--drif@bull.com>
 S: Supported
@@ -4336,6 +4388,7 @@ OpenSBI Firmware
 M: Alistair Francis <Alistair.Francis@wdc.com>
 G: @alistair23
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
+G: @danielhb
 L: qemu-riscv@nongnu.org
 S: Supported
 F: pc-bios/opensbi-*
@@ -4388,6 +4441,7 @@ G: @lvivier
 M: Helge Deller <deller@gmx.de>
 G: @hdeller
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
+G: @pierrick.bouvier
 S: Odd Fixes
 F: linux-user/
 F: configs/targets/*linux-user.mak
@@ -4450,6 +4504,7 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
 G: @alistair23
 R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
+G: @danielhb
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: tcg/riscv64/
@@ -4564,6 +4619,7 @@ NVMe Block Driver
 M: Stefan Hajnoczi <stefanha@redhat.com>
 G: @stefanha
 R: Fam Zheng <fam@euphon.net>
+G: @famzheng
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
@@ -4652,6 +4708,7 @@ Linux io_uring
 M: Stefan Hajnoczi <stefanha@redhat.com>
 G: @stefanha
 R: Stefano Garzarella <sgarzare@redhat.com>
+G: @sgarzarella
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/io_uring.c
@@ -4831,7 +4888,9 @@ Functional testing framework
 M: Thomas Huth <th.huth+qemu@posteo.eu>
 G: @thuth
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 S: Odd Fixes
 F: docs/devel/testing/functional.rst
 F: scripts/clean_functional_cache.py
@@ -4891,9 +4950,13 @@ Meson
 M: Paolo Bonzini <pbonzini@redhat.com>
 G: @bonzini
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
+G: @marcandre.lureau-rh
 R: Daniel P. Berrange <berrange@redhat.com>
+G: @berrange
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
+G: @philmd
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
+G: @pierrick.bouvier
 S: Maintained
 F: meson.build
 F: meson_options.txt
@@ -4905,6 +4968,7 @@ Top Level Makefile and configure
 M: Paolo Bonzini <pbonzini@redhat.com>
 G: @bonzini
 R: Alex Bennée <alex.bennee@linaro.org>
+G: @stsquad
 S: Maintained
 F: Makefile
 F: configure
-- 
2.54.0


