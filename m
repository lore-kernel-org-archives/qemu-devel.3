Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47067C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 17:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX0rT-0003kg-Kb; Wed, 02 Jul 2025 13:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0rJ-0003jW-6n
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uX0rG-0003cg-EC
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 13:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751475773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xn6FNEac9ogsCNuJNqMUFEmVqLKCw623bM+SEFbcvrM=;
 b=Lrxg8BKZEyD03H5MuBt7aFryatqYR1EvDx7VohJQXlXC4tPhZSBF+rpLAzLn+migDLlyG5
 VOJNNl9709rxpBSSr5kPPViQN3n1z7ifVhOY+BXAX6zos2l7qGwlg2ADL8kpYUPfDZ/tcU
 KalBQ9retclp5rhWyD6+w9w5KHDPu9o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-R5lqsmxYMdKYeu5FpSICMA-1; Wed,
 02 Jul 2025 13:02:46 -0400
X-MC-Unique: R5lqsmxYMdKYeu5FpSICMA-1
X-Mimecast-MFC-AGG-ID: R5lqsmxYMdKYeu5FpSICMA_1751475766
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E5111801300; Wed,  2 Jul 2025 17:02:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC7E61956053; Wed,  2 Jul 2025 17:02:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Sean Wei <me@sean.taipei>
Subject: [PULL 6/9] MAINTAINERS: fix paths for relocated files
Date: Wed,  2 Jul 2025 19:02:01 +0200
Message-ID: <20250702170206.212303-7-thuth@redhat.com>
In-Reply-To: <20250702170206.212303-1-thuth@redhat.com>
References: <20250702170206.212303-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Sean Wei <me@sean.taipei>

Several files were renamed in previous commits, causing their entries
in MAINTAINERS to reference outdated paths.
This prevents scripts/get_maintainer.pl from correctly matching
these files to their maintainers.

Update the filenames to reflect their current locations so that
maintainer lookup works properly.

Related commits
---------------

  c45460decbd (Oct 2023)
    hw/input/stellaris_input: Rename to stellaris_gamepad
    Rename  include/hw/input/{gamepad.h => stellaris_gamepad.h}

  4faf359accb (Nov 2020)
    docs: Move virtio-net-failover.rst into the system manual
    Rename  docs/{ => system}/virtio-net-failover.rst

  89857312f32 (Apr 2024)
    hw/usb: move stubs out of stubs/
    Rename  stubs/usb-dev-stub.c => hw/usb/bus-stub.c

  f2604d8508a (Apr 2024)
    hw/virtio: move stubs out of stubs/
    Rename  stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c

  2c888febdfa (Apr 2024)
    memory-device: move stubs out of stubs/
    Rename  stubs/memory_device.c => hw/mem/memory-device-stubs.c

  d481cec7565 (Oct 2024)
    migration: Move cpu-throttle.c from system to migration
    Rename  {system => migration}/cpu-throttle.c

  864a3fa4392 (Jan 2023)
    monitor: Rename misc.c to hmp-target.c
    Rename  monitor/{misc.c => hmp-target.c}

Signed-off-by: Sean Wei <me@sean.taipei>
Message-ID: <374597a7-94e4-45b2-9617-35183db3ea9d@sean.taipei>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8aa0fd33b7d..a36f97ed006 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1007,7 +1007,7 @@ L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/*/stellaris*
 F: hw/display/ssd03*
-F: include/hw/input/gamepad.h
+F: include/hw/input/stellaris_gamepad.h
 F: include/hw/timer/stellaris-gptm.h
 F: docs/system/arm/stellaris.rst
 F: tests/functional/test_arm_stellaris.py
@@ -2173,7 +2173,7 @@ F: hw/net/
 F: include/hw/net/
 F: tests/qtest/virtio-net-test.c
 F: tests/functional/test_info_usernet.py
-F: docs/virtio-net-failover.rst
+F: docs/system/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
 
 Parallel NOR Flash devices
@@ -2224,7 +2224,6 @@ F: tests/qtest/sdhci-test.c
 USB
 S: Orphan
 F: hw/usb/*
-F: stubs/usb-dev-stub.c
 F: tests/qtest/usb-*-test.c
 F: docs/system/devices/usb.rst
 F: include/hw/usb.h
@@ -2477,9 +2476,8 @@ S: Supported
 F: hw/s390x/virtio-ccw-md.c
 F: hw/s390x/virtio-ccw-md.h
 F: hw/s390x/virtio-ccw-md-stubs.c
-F: hw/virtio/virtio-md-pci.c
+F: hw/virtio/virtio-md-*.c
 F: include/hw/virtio/virtio-md-pci.h
-F: stubs/virtio-md-pci.c
 
 virtio-mem
 M: David Hildenbrand <david@redhat.com>
@@ -3197,13 +3195,12 @@ M: David Hildenbrand <david@redhat.com>
 M: Igor Mammedov <imammedo@redhat.com>
 R: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
 S: Supported
-F: hw/mem/memory-device.c
+F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
 F: hw/mem/pc-dimm.c
 F: include/hw/mem/memory-device.h
 F: include/hw/mem/nvdimm.h
 F: include/hw/mem/pc-dimm.h
-F: stubs/memory_device.c
 F: docs/nvdimm.txt
 
 SPICE
@@ -3244,9 +3241,9 @@ F: util/qemu-timer*.c
 F: system/vl.c
 F: system/main.c
 F: system/cpus.c
-F: system/cpu-throttle.c
 F: system/cpu-timers.c
 F: system/runstate*
+F: migration/cpu-throttle.c
 F: qapi/run-state.json
 
 Read, Copy, Update (RCU)
@@ -3265,7 +3262,7 @@ Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dave@treblig.org>
 S: Maintained
 F: monitor/monitor-internal.h
-F: monitor/misc.c
+F: monitor/hmp-target.c
 F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
-- 
2.50.0


