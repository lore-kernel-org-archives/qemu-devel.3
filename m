Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9F3EB26E1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWe-00015F-Mn; Tue, 10 Feb 2026 11:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWZ-0000yb-7l
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:40 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWU-0006zj-Uy
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740605; x=1771345405; i=lukasstraub2@web.de;
 bh=hGC+m0tA3M0So0oR7D2e5cbVpsMtE6mQ3ydGsBOWEV8=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JTsuWwS8ZQi9Q6l85bRF5ayJMQuf+qJqQnjx0ESqicByCUzU0Jyq3S0tXqO+KbmY
 IVjvrWbtHvAta1rZNmpVjW7Z/WJbC17cc87yLBpvojLpdwdVlUSf5dV8ejkvfzj/S
 Ldd77fiDWD/n5cLSOtB0mPGoxk5LRs5byoKWoz3MXTI5eO4ioBQ+7px5tWeu7F8pb
 FUeH4s/Ooz66R1MIEo5bVnvPdHVVy0SSNnIkM183SZ1Ya9yE81SnjijcZ6eKIrybx
 UUBo9/hjTnhIhlntO2g8kHtrZPiPVHFQMsMIgHMTod66FoGzDUCGxK3QAS2B+nR2Q
 Bl4Oa33SlpwmE8laiQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVacq-1wHJWL0WOK-00RboJ; Tue, 10
 Feb 2026 17:23:25 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:12 +0100
Subject: [PATCH v8 14/17] Convert colo main documentation to restructuredText
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-14-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=41531; i=lukasstraub2@web.de; 
 h=from:subject:message-id;
 bh=+Fe4mH4KK78+TLQ/FOH4wNoY+Th9EiHhTnmw9JF8BDE=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t3abaXCzb5lBr6BK4xd4E7QL4nb54yq+aOH
 /bKGFCKRDqJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WCGWEACKbgBopcDgluE2mgrZYOIuz5fop183CP7rr7t4lvBSvhZh+FcBRT/TFIkxN4OqvN06Alu
 UigcNwXdbTWDNBE3ghOHZCqOwyL4F0rv/RYfBTZ5fPApEqQ3/bRazZ0BjkGWqTZawkdULhUPAYd
 HJD2DVnYDzi1qjBmnsQO1ZYR0npYbv2Y+WRry1foiGFPEKQ8JR4Hjt0tRSKfZaV8jcY4t5TxVOY
 5VoArbifObWnX1OQarhzT9k9V8HyzKzqcMD5HDWYvqNjsIm6sdwQQ9rB0vLQ97Q656Vx4StinPx
 hwVtoBTG71LqiMdlR5OCYFSJ0D/u0tZCvcBXcH6hvN4IFsSYzynNhf3sFYnnHulQQZvDPmKmQMI
 HhfZ8xmtLpLjXgliqpOXLJZmR5KEZ538FYZuiVCfwNEiAeF+wPwi03kMObJ1iAu1Z8Y40wUhfcZ
 E59X3N5HUYagHFFdog4TPc/44AInZ2Df/VyRCmUIpNlPU3FVrNvT6d4dNUIL6oS+wosAE4B5+g9
 HqRWtthOOt59Igsr04NqUabtpX8Kdldia5nX6kwVwQM06EPH30BvtIQLxheSNVO1xdU5ipkq1eg
 TV4q/wjHaJK0YWBi2tYqId6SGitVtNmhBtiMJmrSrBnj9VfiX11uaWnB6dNSiSavyULjBY5eL8T
 RWqIG76bQ7walDA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:DkJ2nl3pzfGJpFltMpZvcXb5KImaJsaXSAy/tRtt7R+bzyEQO0X
 4TYo0q7YuF3Ipe6kgVEFaO2PTs2SMqTJpbpSMMG/cX3/F5ZJzeTWyTQbkkC1Szmqzd8v2IS
 idGL5a6vuTJUah57HtqilwObhvzwgOjZX5N4xNaPSrLWnqIdXXZrn6smIQFnlUx2FmCFY8C
 88IJrFOI/hEL6R7I6RnOA==
UI-OutboundReport: notjunk:1;M01:P0:7GJT3qvMuxI=;knmRf7S73UAUAv3rQ4yNdqdGdOM
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS               |   2 +-
 docs/COLO-FT.txt          | 334 -----------------------------------------=
-
 docs/system/index.rst     |   1 +
 docs/system/qemu-colo.rst | 360 +++++++++++++++++++++++++++++++++++++++++=
+++++
 4 files changed, 362 insertions(+), 335 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe6010929fc4cb83bc8a7686fbe537f1120f1eba..50beba7cb105efb867c7d8cb14=
0357f329241654 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3863,7 +3863,7 @@ F: migration/multifd-colo.*
 F: include/migration/colo.h
 F: include/migration/failover.h
 F: tests/qtest/migration/colo-tests.c
-F: docs/COLO-FT.txt
+F: docs/system/qemu-colo.rst
=20
 COLO Proxy
 M: Zhang Chen <zhangckid@gmail.com>
diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
deleted file mode 100644
index 2283a09c080b8996f9767eeb415e8d4fbdc940af..00000000000000000000000000=
00000000000000
=2D-- a/docs/COLO-FT.txt
+++ /dev/null
@@ -1,334 +0,0 @@
-COarse-grained LOck-stepping Virtual Machines for Non-stop Service
=2D----------------------------------------
-Copyright (c) 2016 Intel Corporation
-Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
-Copyright (c) 2016 Fujitsu, Corp.
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.
-See the COPYING file in the top-level directory.
-
-This document gives an overview of COLO's design and how to use it.
-
-=3D=3D Background =3D=3D
-Virtual machine (VM) replication is a well known technique for providing
-application-agnostic software-implemented hardware fault tolerance,
-also known as "non-stop service".
-
-COLO (COarse-grained LOck-stepping) is a high availability solution.
-Both primary VM (PVM) and secondary VM (SVM) run in parallel. They receiv=
e the
-same request from client, and generate response in parallel too.
-If the response packets from PVM and SVM are identical, they are released
-immediately. Otherwise, a VM checkpoint (on demand) is conducted.
-
-=3D=3D Architecture =3D=3D
-
-The architecture of COLO is shown in the diagram below.
-It consists of a pair of networked physical nodes:
-The primary node running the PVM, and the secondary node running the SVM
-to maintain a valid replica of the PVM.
-PVM and SVM execute in parallel and generate output of response packets f=
or
-client requests according to the application semantics.
-
-The incoming packets from the client or external network are received by =
the
-primary node, and then forwarded to the secondary node, so that both the =
PVM
-and the SVM are stimulated with the same requests.
-
-COLO receives the outbound packets from both the PVM and SVM and compares=
 them
-before allowing the output to be sent to clients.
-
-The SVM is qualified as a valid replica of the PVM, as long as it generat=
es
-identical responses to all client requests. Once the differences in the o=
utputs
-are detected between the PVM and SVM, COLO withholds transmission of the
-outbound packets until it has successfully synchronized the PVM state to =
the SVM.
-
-  Primary Node                                                           =
 Secondary Node
-+------------+  +-----------------------+       +------------------------=
+  +------------+
-|            |  |       HeartBeat       +<----->+       HeartBeat        =
|  |            |
-| Primary VM |  +-----------+-----------+       +-----------+------------=
+  |Secondary VM|
-|            |              |                               |            =
   |            |
-|            |  +-----------|-----------+       +-----------|------------=
+  |            |
-|            |  |QEMU   +---v----+      |       |QEMU  +----v---+        =
|  |            |
-|            |  |       |Failover|      |       |      |Failover|        =
|  |            |
-|            |  |       +--------+      |       |      +--------+        =
|  |            |
-|            |  |   +---------------+   |       |   +---------------+    =
|  |            |
-|            |  |   | VM Checkpoint +-------------->+ VM Checkpoint |    =
|  |            |
-|            |  |   +---------------+   |       |   +---------------+    =
|  |            |
-|Requests<--------------------------\ /-----------------\ /--------------=
=2D------>Requests|
-|            |  |                   ^ ^ |       |       | |              =
|  |            |
-|Responses+---------------------\ /-|-|------------\ /-------------------=
=2D-----+Responses|
-|            |  |               | | | | |       |  | |  | |              =
|  |            |
-|            |  | +-----------+ | | | | |       |  | |  | | +----------+ =
|  |            |
-|            |  | | COLO disk | | | | | |       |  | |  | | | COLO disk| =
|  |            |
-|            |  | |   Manager +---------------------------->| Manager  | =
|  |            |
-|            |  | ++----------+ v v | | |       |  | v  v | +---------++ =
|  |            |
-|            |  |  |+-----------+-+-+-++|       | ++-+--+-+---------+ |  =
|  |            |
-|            |  |  ||   COLO Proxy     ||       | |   COLO Proxy    | |  =
|  |            |
-|            |  |  || (compare packet  ||       | |(adjust sequence | |  =
|  |            |
-|            |  |  ||and mirror packet)||       | |    and ACK)     | |  =
|  |            |
-|            |  |  |+------------+---+-+|       | +-----------------+ |  =
|  |            |
-+------------+  +-----------------------+       +------------------------=
+  +------------+
-+------------+     |             |   |                                |  =
   +------------+
-| VM Monitor |     |             |   |                                |  =
   | VM Monitor |
-+------------+     |             |   |                                |  =
   +------------+
-+---------------------------------------+       +------------------------=
=2D---------------+
-|   Kernel         |             |   |  |       |   Kernel            |  =
                |
-+---------------------------------------+       +------------------------=
=2D---------------+
-                   |             |   |                                |
-    +--------------v+  +---------v---+--+       +------------------+ +v--=
=2D----------+
-    |   Storage     |  |External Network|       | External Network | |   =
Storage    |
-    +---------------+  +----------------+       +------------------+ +---=
=2D----------+
-
-
-=3D=3D Components introduction =3D=3D
-
-You can see there are several components in COLO's diagram of architectur=
e.
-Their functions are described below.
-
-HeartBeat:
-Runs on both the primary and secondary nodes, to periodically check platf=
orm
-availability. When the primary node suffers a hardware fail-stop failure,
-the heartbeat stops responding, the secondary node will trigger a failove=
r
-as soon as it determines the absence.
-
-COLO disk Manager:
-When primary VM writes data into image, the colo disk manager captures th=
is data
-and sends it to secondary VM's which makes sure the context of secondary =
VM's
-image is consistent with the context of primary VM 's image.
-For more details, please refer to docs/block-replication.txt.
-
-Checkpoint/Failover Controller:
-Modifications of save/restore flow to realize continuous migration,
-to make sure the state of VM in Secondary side is always consistent with =
VM in
-Primary side.
-
-COLO Proxy:
-Delivers packets to Primary and Secondary, and then compare the responses=
 from
-both side. Then decide whether to start a checkpoint according to some ru=
les.
-Please refer to docs/colo-proxy.txt for more information.
-
-Note:
-HeartBeat has not been implemented yet, so you need to trigger failover p=
rocess
-by using 'x-colo-lost-heartbeat' command.
-
-=3D=3D COLO operation status =3D=3D
-
-+-----------------+
-|                 |
-|    Start COLO   |
-|                 |
-+--------+--------+
-         |
-         |  Main qmp command:
-         |  migrate-set-capabilities with x-colo
-         |  migrate
-         |
-         v
-+--------+--------+
-|                 |
-|  COLO running   |
-|                 |
-+--------+--------+
-         |
-         |  Main qmp command:
-         |  x-colo-lost-heartbeat
-         |  or
-         |  some error happened
-         v
-+--------+--------+
-|                 |  send qmp event:
-|  COLO failover  |  COLO_EXIT
-|                 |
-+-----------------+
-
-COLO use the qmp command to switch and report operation status.
-The diagram just shows the main qmp command, you can get the detail
-in test procedure.
-
-=3D=3D Test procedure =3D=3D
-Note: Here we are running both instances on the same host for testing,
-change the IP Addresses if you want to run it on two hosts. Initially
-127.0.0.1 is the Primary Host and 127.0.0.2 is the Secondary Host.
-
-=3D=3D Startup qemu =3D=3D
-1. Primary:
-Note: Initially, $imagefolder/primary.qcow2 needs to be copied to all hos=
ts.
-You don't need to change any IP's here, because 0.0.0.0 listens on any
-interface. The chardev's with 127.0.0.1 IP's loopback to the local qemu
-instance.
-
-# imagefolder=3D"/mnt/vms/colo-test-primary"
-
-# qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -smp 1 =
-qmp stdio \
-   -device piix3-usb-uhci -device usb-tablet -name primary \
-   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge-he=
lper \
-   -device rtl8139,id=3De0,netdev=3Dhn0 \
-   -chardev socket,id=3Dmirror0,host=3D0.0.0.0,port=3D9003,server=3Don,wa=
it=3Doff \
-   -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=3D9004,server=3Don,w=
ait=3Don \
-   -chardev socket,id=3Dcompare0,host=3D127.0.0.1,port=3D9001,server=3Don=
,wait=3Doff \
-   -chardev socket,id=3Dcompare0-0,host=3D127.0.0.1,port=3D9001 \
-   -chardev socket,id=3Dcompare_out,host=3D127.0.0.1,port=3D9005,server=
=3Don,wait=3Doff \
-   -chardev socket,id=3Dcompare_out0,host=3D127.0.0.1,port=3D9005 \
-   -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0=
 \
-   -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=
=3Dcompare_out \
-   -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outdev=
=3Dcompare0 \
-   -object iothread,id=3Diothread1 \
-   -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=
=3Dcompare1,\
-outdev=3Dcompare_out0,iothread=3Diothread1 \
-   -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vo=
te-threshold=3D1,\
-children.0.file.filename=3D$imagefolder/primary.qcow2,children.0.driver=
=3Dqcow2 -S
-
-2. Secondary:
-Note: Active and hidden images need to be created only once and the
-size should be the same as primary.qcow2. Again, you don't need to change
-any IP's here, except for the $primary_ip variable.
-
-# imagefolder=3D"/mnt/vms/colo-test-secondary"
-# primary_ip=3D127.0.0.1
-
-# qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
-
-# qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
-
-# qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -smp 1 =
-qmp stdio \
-   -device piix3-usb-uhci -device usb-tablet -name secondary \
-   -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridge-he=
lper \
-   -device rtl8139,id=3De0,netdev=3Dhn0 \
-   -chardev socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnect-ms=
=3D1000 \
-   -chardev socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnect-ms=
=3D1000 \
-   -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0=
 \
-   -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred=
1 \
-   -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
-   -drive if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/primary.qco=
w2,driver=3Dqcow2 \
-   -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondary,fi=
le.driver=3Dqcow2,\
-top-id=3Dcolo-disk0,file.file.filename=3D$imagefolder/secondary-active.qc=
ow2,\
-file.backing.driver=3Dqcow2,file.backing.file.filename=3D$imagefolder/sec=
ondary-hidden.qcow2,\
-file.backing.backing=3Dparent0 \
-   -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vo=
te-threshold=3D1,\
-children.0=3Dchilds0 \
-   -incoming tcp:0.0.0.0:9998
-
-
-3. On Secondary VM's QEMU monitor, issue command
-{"execute":"qmp_capabilities"}
-{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {=
"capability": "x-colo", "state": true } ] } }
-{"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "d=
ata": {"host": "0.0.0.0", "port": "9999"} } } }
-{"execute": "nbd-server-add", "arguments": {"device": "parent0", "writabl=
e": true } }
-
-Note:
-  a. The qmp command nbd-server-start and nbd-server-add must be run
-     before running the qmp command migrate on primary QEMU
-  b. Active disk, hidden disk and nbd target's length should be the
-     same.
-  c. It is better to put active disk and hidden disk in ramdisk. They
-     will be merged into the parent disk on failover.
-
-4. On Primary VM's QEMU monitor, issue command:
-{"execute":"qmp_capabilities"}
-{"execute": "human-monitor-command", "arguments": {"command-line": "drive=
_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.h=
ost=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplica=
tion0"}}
-{"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "no=
de": "replication0" } }
-{"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {=
"capability": "x-colo", "state": true } ] } }
-{"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
-
-  Note:
-  a. There should be only one NBD Client for each primary disk.
-  b. The qmp command line must be run after running qmp command line in
-     secondary qemu.
-
-5. After the above steps, you will see, whenever you make changes to PVM,=
 SVM will be synced.
-You can issue command '{ "execute": "migrate-set-parameters" , "arguments=
":{ "x-checkpoint-delay": 2000 } }'
-to change the idle checkpoint period time
-
-6. Failover test
-You can kill one of the VMs and Failover on the surviving VM:
-
-If you killed the Secondary, then follow "Primary Failover". After that,
-if you want to resume the replication, follow "Primary resume replication=
"
-
-If you killed the Primary, then follow "Secondary Failover". After that,
-if you want to resume the replication, follow "Secondary resume replicati=
on"
-
-=3D=3D Primary Failover =3D=3D
-The Secondary died, resume on the Primary
-
-{"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "c=
hild": "children.1"} }
-{"execute": "human-monitor-command", "arguments":{ "command-line": "drive=
_del replication0" } }
-{"execute": "object-del", "arguments":{ "id": "comp0" } }
-{"execute": "object-del", "arguments":{ "id": "iothread1" } }
-{"execute": "object-del", "arguments":{ "id": "m0" } }
-{"execute": "object-del", "arguments":{ "id": "redire0" } }
-{"execute": "object-del", "arguments":{ "id": "redire1" } }
-{"execute": "x-colo-lost-heartbeat" }
-
-=3D=3D Secondary Failover =3D=3D
-The Primary died, resume on the Secondary and prepare to become the new P=
rimary
-
-{"execute": "nbd-server-stop"}
-{"execute": "x-colo-lost-heartbeat"}
-
-{"execute": "object-del", "arguments":{ "id": "f2" } }
-{"execute": "object-del", "arguments":{ "id": "f1" } }
-{"execute": "chardev-remove", "arguments":{ "id": "red1" } }
-{"execute": "chardev-remove", "arguments":{ "id": "red0" } }
-
-{"execute": "chardev-add", "arguments":{ "id": "mirror0", "backend": {"ty=
pe": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0.0.0=
.0", "port": "9003" } }, "server": true } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare1", "backend": {"t=
ype": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0.0.=
0.0", "port": "9004" } }, "server": true } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare0", "backend": {"t=
ype": "socket", "data": {"addr": { "type": "inet", "data": { "host": "127.=
0.0.1", "port": "9001" } }, "server": true } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare0-0", "backend": {=
"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "12=
7.0.0.1", "port": "9001" } }, "server": false } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare_out", "backend": =
{"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "1=
27.0.0.1", "port": "9005" } }, "server": true } } } }
-{"execute": "chardev-add", "arguments":{ "id": "compare_out0", "backend":=
 {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "=
127.0.0.1", "port": "9005" } }, "server": false } } } }
-
-=3D=3D Primary resume replication =3D=3D
-Resume replication after new Secondary is up.
-
-Start the new Secondary (Steps 2 and 3 above), then on the Primary:
-{"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "job-id=
": "resync", "target": "nbd://127.0.0.2:9999/parent0", "mode": "existing",=
 "format": "raw", "sync": "full"} }
-
-Wait until disk is synced, then:
-{"execute": "stop"}
-{"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
-
-{"execute": "human-monitor-command", "arguments":{ "command-line": "drive=
_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.h=
ost=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplica=
tion0"}}
-{"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "n=
ode": "replication0" } }
-
-{"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id"=
: "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
-{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", =
"id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out" } =
}
-{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", =
"id": "redire1", "netdev": "hn0", "queue": "rx", "outdev": "compare0" } }
-{"execute": "object-add", "arguments":{ "qom-type": "iothread", "id": "io=
thread1" } }
-{"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "id":=
 "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "outdev"=
: "compare_out0", "iothread": "iothread1" } }
-
-{"execute": "migrate-set-capabilities", "arguments":{ "capabilities": [ {=
"capability": "x-colo", "state": true } ] } }
-{"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.2:9998" } }
-
-Note:
-If this Primary previously was a Secondary, then we need to insert the
-filters before the filter-rewriter by using the
-""insert": "before", "position": "id=3Drew0"" Options. See below.
-
-=3D=3D Secondary resume replication =3D=3D
-Become Primary and resume replication after new Secondary is up. Note
-that now 127.0.0.1 is the Secondary and 127.0.0.2 is the Primary.
-
-Start the new Secondary (Steps 2 and 3 above, but with primary_ip=3D127.0=
.0.2),
-then on the old Secondary:
-{"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "job-id=
": "resync", "target": "nbd://127.0.0.1:9999/parent0", "mode": "existing",=
 "format": "raw", "sync": "full"} }
-
-Wait until disk is synced, then:
-{"execute": "stop"}
-{"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
-
-{"execute": "human-monitor-command", "arguments":{ "command-line": "drive=
_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.h=
ost=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplica=
tion0"}}
-{"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0", "n=
ode": "replication0" } }
-
-{"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", "id"=
: "m0", "insert": "before", "position": "id=3Drew0", "netdev": "hn0", "que=
ue": "tx", "outdev": "mirror0" } }
-{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", =
"id": "redire0", "insert": "before", "position": "id=3Drew0", "netdev": "h=
n0", "queue": "rx", "indev": "compare_out" } }
-{"execute": "object-add", "arguments":{ "qom-type": "filter-redirector", =
"id": "redire1", "insert": "before", "position": "id=3Drew0", "netdev": "h=
n0", "queue": "rx", "outdev": "compare0" } }
-{"execute": "object-add", "arguments":{ "qom-type": "iothread", "id": "io=
thread1" } }
-{"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "id":=
 "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "outdev"=
: "compare_out0", "iothread": "iothread1" } }
-
-{"execute": "migrate-set-capabilities", "arguments":{ "capabilities": [ {=
"capability": "x-colo", "state": true } ] } }
-{"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
-
-=3D=3D TODO =3D=3D
-1. Support shared storage.
-2. Develop the heartbeat part.
-3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 427b020483104f6589878bbf255a367ae114c61b..6268c41aea9c74dc3e59d896b5=
ae082360bfbb1a 100644
=2D-- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -41,3 +41,4 @@ or Hypervisor.Framework.
    igvm
    vm-templating
    sriov
+   qemu-colo
diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
new file mode 100644
index 0000000000000000000000000000000000000000..4b5fbbf398f8a5c4ea6baad615=
bde94b2b4678d2
=2D-- /dev/null
+++ b/docs/system/qemu-colo.rst
@@ -0,0 +1,360 @@
+Qemu COLO Fault Tolerance
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+| Copyright (c) 2016 Intel Corporation
+| Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+| Copyright (c) 2016 Fujitsu, Corp.
+
+This work is licensed under the terms of the GNU GPL, version 2 or later.
+See the COPYING file in the top-level directory.
+
+This document gives an overview of COLO's design and how to use it.
+
+Background
+----------
+Virtual machine (VM) replication is a well known technique for providing
+application-agnostic software-implemented hardware fault tolerance,
+also known as "non-stop service".
+
+COLO (COarse-grained LOck-stepping) is a high availability solution.
+Both primary VM (PVM) and secondary VM (SVM) run in parallel. They receiv=
e the
+same request from client, and generate response in parallel too.
+If the response packets from PVM and SVM are identical, they are released
+immediately. Otherwise, a VM checkpoint (on demand) is conducted.
+
+Architecture
+------------
+The architecture of COLO is shown in the diagram below.
+It consists of a pair of networked physical nodes:
+The primary node running the PVM, and the secondary node running the SVM
+to maintain a valid replica of the PVM.
+PVM and SVM execute in parallel and generate output of response packets f=
or
+client requests according to the application semantics.
+
+The incoming packets from the client or external network are received by =
the
+primary node, and then forwarded to the secondary node, so that both the =
PVM
+and the SVM are stimulated with the same requests.
+
+COLO receives the outbound packets from both the PVM and SVM and compares=
 them
+before allowing the output to be sent to clients.
+
+The SVM is qualified as a valid replica of the PVM, as long as it generat=
es
+identical responses to all client requests. Once the differences in the o=
utputs
+are detected between the PVM and SVM, COLO withholds transmission of the
+outbound packets until it has successfully synchronized the PVM state to =
the SVM.
+
+Overview::
+
+      Primary Node                                                       =
     Secondary Node
+    +------------+  +-----------------------+       +--------------------=
=2D---+  +------------+
+    |            |  |       HeartBeat       +<----->+       HeartBeat    =
    |  |            |
+    | Primary VM |  +-----------+-----------+       +-----------+--------=
=2D---+  |Secondary VM|
+    |            |              |                               |        =
       |            |
+    |            |  +-----------|-----------+       +-----------|--------=
=2D---+  |            |
+    |            |  |QEMU   +---v----+      |       |QEMU  +----v---+    =
    |  |            |
+    |            |  |       |Failover|      |       |      |Failover|    =
    |  |            |
+    |            |  |       +--------+      |       |      +--------+    =
    |  |            |
+    |            |  |   +---------------+   |       |   +---------------+=
    |  |            |
+    |            |  |   | VM Checkpoint +-------------->+ VM Checkpoint |=
    |  |            |
+    |            |  |   +---------------+   |       |   +---------------+=
    |  |            |
+    |Requests<--------------------------\ /-----------------\ /----------=
=2D---------->Requests|
+    |            |  |                   ^ ^ |       |       | |          =
    |  |            |
+    |Responses+---------------------\ /-|-|------------\ /---------------=
=2D---------+Responses|
+    |            |  |               | | | | |       |  | |  | |          =
    |  |            |
+    |            |  | +-----------+ | | | | |       |  | |  | | +--------=
=2D-+ |  |            |
+    |            |  | | COLO disk | | | | | |       |  | |  | | | COLO di=
sk| |  |            |
+    |            |  | |   Manager +---------------------------->| Manager=
  | |  |            |
+    |            |  | ++----------+ v v | | |       |  | v  v | +--------=
-++ |  |            |
+    |            |  |  |+-----------+-+-+-++|       | ++-+--+-+---------+=
 |  |  |            |
+    |            |  |  ||   COLO Proxy     ||       | |   COLO Proxy    |=
 |  |  |            |
+    |            |  |  || (compare packet  ||       | |(adjust sequence |=
 |  |  |            |
+    |            |  |  ||and mirror packet)||       | |    and ACK)     |=
 |  |  |            |
+    |            |  |  |+------------+---+-+|       | +-----------------+=
 |  |  |            |
+    +------------+  +-----------------------+       +--------------------=
=2D---+  +------------+
+    +------------+     |             |   |                               =
 |     +------------+
+    | VM Monitor |     |             |   |                               =
 |     | VM Monitor |
+    +------------+     |             |   |                               =
 |     +------------+
+    +---------------------------------------+       +--------------------=
=2D-------------------+
+    |   Kernel         |             |   |  |       |   Kernel           =
 |                  |
+    +---------------------------------------+       +--------------------=
=2D-------------------+
+                       |             |   |                               =
 |
+        +--------------v+  +---------v---+--+       +------------------+ =
+v-------------+
+        |   Storage     |  |External Network|       | External Network | =
|   Storage    |
+        +---------------+  +----------------+       +------------------+ =
+--------------+
+
+Components introduction
+^^^^^^^^^^^^^^^^^^^^^^^
+You can see there are several components in COLO's diagram of architectur=
e.
+Their functions are described below.
+
+HeartBeat
+~~~~~~~~~
+Runs on both the primary and secondary nodes, to periodically check platf=
orm
+availability. When the primary node suffers a hardware fail-stop failure,
+the heartbeat stops responding, the secondary node will trigger a failove=
r
+as soon as it determines the absence.
+
+COLO disk Manager
+~~~~~~~~~~~~~~~~~
+When primary VM writes data into image, the colo disk manager captures th=
is data
+and sends it to secondary VM's which makes sure the context of secondary =
VM's
+image is consistent with the context of primary VM 's image.
+For more details, please refer to docs/block-replication.txt.
+
+Checkpoint/Failover Controller
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Modifications of save/restore flow to realize continuous migration,
+to make sure the state of VM in Secondary side is always consistent with =
VM in
+Primary side.
+
+COLO Proxy
+~~~~~~~~~~
+Delivers packets to Primary and Secondary, and then compare the responses=
 from
+both side. Then decide whether to start a checkpoint according to some ru=
les.
+Please refer to docs/colo-proxy.txt for more information.
+
+Note:
+HeartBeat has not been implemented yet, so you need to trigger failover p=
rocess
+by using 'x-colo-lost-heartbeat' command.
+
+COLO operation status
+^^^^^^^^^^^^^^^^^^^^^
+
+Overview::
+
+    +-----------------+
+    |                 |
+    |    Start COLO   |
+    |                 |
+    +--------+--------+
+             |
+             |  Main qmp command:
+             |  migrate-set-capabilities with x-colo
+             |  migrate
+             |
+             v
+    +--------+--------+
+    |                 |
+    |  COLO running   |
+    |                 |
+    +--------+--------+
+             |
+             |  Main qmp command:
+             |  x-colo-lost-heartbeat
+             |  or
+             |  some error happened
+             v
+    +--------+--------+
+    |                 |  send qmp event:
+    |  COLO failover  |  COLO_EXIT
+    |                 |
+    +-----------------+
+
+
+COLO use the qmp command to switch and report operation status.
+The diagram just shows the main qmp command, you can get the detail
+in test procedure.
+
+Test procedure
+--------------
+Note: Here we are running both instances on the same host for testing,
+change the IP Addresses if you want to run it on two hosts. Initially
+``127.0.0.1`` is the Primary Host and ``127.0.0.2`` is the Secondary Host=
.
+
+Startup qemu
+^^^^^^^^^^^^
+**1. Primary**:
+Note: Initially, ``$imagefolder/primary.qcow2`` needs to be copied to all=
 hosts.
+You don't need to change any IP's here, because ``0.0.0.0`` listens on an=
y
+interface. The chardev's with ``127.0.0.1`` IP's loopback to the local qe=
mu
+instance::
+
+    # imagefolder=3D"/mnt/vms/colo-test-primary"
+
+    # qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -sm=
p 1 -qmp stdio \
+       -device piix3-usb-uhci -device usb-tablet -name primary \
+       -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridg=
e-helper \
+       -device rtl8139,id=3De0,netdev=3Dhn0 \
+       -chardev socket,id=3Dmirror0,host=3D0.0.0.0,port=3D9003,server=3Do=
n,wait=3Doff \
+       -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=3D9004,server=3D=
on,wait=3Don \
+       -chardev socket,id=3Dcompare0,host=3D127.0.0.1,port=3D9001,server=
=3Don,wait=3Doff \
+       -chardev socket,id=3Dcompare0-0,host=3D127.0.0.1,port=3D9001 \
+       -chardev socket,id=3Dcompare_out,host=3D127.0.0.1,port=3D9005,serv=
er=3Don,wait=3Doff \
+       -chardev socket,id=3Dcompare_out0,host=3D127.0.0.1,port=3D9005 \
+       -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmir=
ror0 \
+       -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,ind=
ev=3Dcompare_out \
+       -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,out=
dev=3Dcompare0 \
+       -object iothread,id=3Diothread1 \
+       -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_=
in=3Dcompare1,\
+    outdev=3Dcompare_out0,iothread=3Diothread1 \
+       -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfif=
o,vote-threshold=3D1,\
+    children.0.file.filename=3D$imagefolder/primary.qcow2,children.0.driv=
er=3Dqcow2 -S
+
+
+**2. Secondary**:
+Note: Active and hidden images need to be created only once and the
+size should be the same as ``primary.qcow2``. Again, you don't need to ch=
ange
+any IP's here, except for the ``$primary_ip`` variable::
+
+    # imagefolder=3D"/mnt/vms/colo-test-secondary"
+    # primary_ip=3D127.0.0.1
+
+    # qemu-img create -f qcow2 $imagefolder/secondary-active.qcow2 10G
+
+    # qemu-img create -f qcow2 $imagefolder/secondary-hidden.qcow2 10G
+
+    # qemu-system-x86_64 -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -sm=
p 1 -qmp stdio \
+       -device piix3-usb-uhci -device usb-tablet -name secondary \
+       -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/lib/qemu/qemu-bridg=
e-helper \
+       -device rtl8139,id=3De0,netdev=3Dhn0 \
+       -chardev socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnect=
-ms=3D1000 \
+       -chardev socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnect=
-ms=3D1000 \
+       -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3D=
red0 \
+       -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=
=3Dred1 \
+       -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
+       -drive if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/primary=
.qcow2,driver=3Dqcow2 \
+       -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondar=
y,file.driver=3Dqcow2,\
+    top-id=3Dcolo-disk0,file.file.filename=3D$imagefolder/secondary-activ=
e.qcow2,\
+    file.backing.driver=3Dqcow2,file.backing.file.filename=3D$imagefolder=
/secondary-hidden.qcow2,\
+    file.backing.backing=3Dparent0 \
+       -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfif=
o,vote-threshold=3D1,\
+    children.0=3Dchilds0 \
+       -incoming tcp:0.0.0.0:9998
+
+
+**3.** On Secondary VM's QEMU monitor, issue command::
+
+    {"execute":"qmp_capabilities"}
+    {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet"=
, "data": {"host": "0.0.0.0", "port": "9999"} } } }
+    {"execute": "nbd-server-add", "arguments": {"device": "parent0", "wri=
table": true } }
+
+Note:
+  a. The qmp command ``nbd-server-start`` and ``nbd-server-add`` must be =
run
+     before running the qmp command migrate on primary QEMU
+  b. Active disk, hidden disk and nbd target's length should be the
+     same.
+  c. It is better to put active disk and hidden disk in ramdisk. They
+     will be merged into the parent disk on failover.
+
+**4.** On Primary VM's QEMU monitor, issue command::
+
+    {"execute":"qmp_capabilities"}
+    {"execute": "human-monitor-command", "arguments": {"command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
+    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "replication0" } }
+    {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
+
+Note:
+  a. There should be only one NBD Client for each primary disk.
+  b. The qmp command line must be run after running qmp command line in
+     secondary qemu.
+
+**5.** After the above steps, you will see, whenever you make changes to =
PVM, SVM will be synced.
+You can issue command ``{ "execute": "migrate-set-parameters" , "argument=
s":{ "x-checkpoint-delay": 2000 } }``
+to change the idle checkpoint period time
+
+Failover test
+^^^^^^^^^^^^^
+You can kill one of the VMs and Failover on the surviving VM:
+
+If you killed the Secondary, then follow "Primary Failover".
+After that, if you want to resume the replication, follow "Primary resume=
 replication"
+
+If you killed the Primary, then follow "Secondary Failover".
+After that, if you want to resume the replication, follow "Secondary resu=
me replication"
+
+Primary Failover
+~~~~~~~~~~~~~~~~
+The Secondary died, resume on the Primary::
+
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "child": "children.1"} }
+    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_del replication0" } }
+    {"execute": "object-del", "arguments":{ "id": "comp0" } }
+    {"execute": "object-del", "arguments":{ "id": "iothread1" } }
+    {"execute": "object-del", "arguments":{ "id": "m0" } }
+    {"execute": "object-del", "arguments":{ "id": "redire0" } }
+    {"execute": "object-del", "arguments":{ "id": "redire1" } }
+    {"execute": "x-colo-lost-heartbeat" }
+
+Secondary Failover
+~~~~~~~~~~~~~~~~~~
+The Primary died, resume on the Secondary and prepare to become the new P=
rimary::
+
+    {"execute": "nbd-server-stop"}
+    {"execute": "x-colo-lost-heartbeat"}
+
+    {"execute": "object-del", "arguments":{ "id": "f2" } }
+    {"execute": "object-del", "arguments":{ "id": "f1" } }
+    {"execute": "chardev-remove", "arguments":{ "id": "red1" } }
+    {"execute": "chardev-remove", "arguments":{ "id": "red0" } }
+
+    {"execute": "chardev-add", "arguments":{ "id": "mirror0", "backend": =
{"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "0=
.0.0.0", "port": "9003" } }, "server": true } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare1", "backend":=
 {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "=
0.0.0.0", "port": "9004" } }, "server": true } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare0", "backend":=
 {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host": "=
127.0.0.1", "port": "9001" } }, "server": true } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare0-0", "backend=
": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host":=
 "127.0.0.1", "port": "9001" } }, "server": false } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare_out", "backen=
d": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host"=
: "127.0.0.1", "port": "9005" } }, "server": true } } } }
+    {"execute": "chardev-add", "arguments":{ "id": "compare_out0", "backe=
nd": {"type": "socket", "data": {"addr": { "type": "inet", "data": { "host=
": "127.0.0.1", "port": "9005" } }, "server": false } } } }
+
+Primary resume replication
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+Resume replication after new Secondary is up.
+
+Start the new Secondary (Steps 2 and 3 above), then on the Primary::
+
+    {"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "jo=
b-id": "resync", "target": "nbd://127.0.0.2:9999/parent0", "mode": "existi=
ng", "format": "raw", "sync": "full"} }
+
+Wait until disk is synced, then::
+
+    {"execute": "stop"}
+    {"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
+
+    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out=
" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire1", "netdev": "hn0", "queue": "rx", "outdev": "compare0" =
} }
+    {"execute": "object-add", "arguments":{ "qom-type": "iothread", "id":=
 "iothread1" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "=
id": "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "out=
dev": "compare_out0", "iothread": "iothread1" } }
+
+    {"execute": "migrate-set-capabilities", "arguments":{ "capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.2:9998" } }
+
+Note:
+If this Primary previously was a Secondary, then we need to insert the
+filters before the filter-rewriter by using the
+""insert": "before", "position": "id=3Drew0"" Options. See below.
+
+Secondary resume replication
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Become Primary and resume replication after new Secondary is up. Note
+that now 127.0.0.1 is the Secondary and 127.0.0.2 is the Primary.
+
+Start the new Secondary (Steps 2 and 3 above, but with primary_ip=3D127.0=
.0.2),
+then on the old Secondary::
+
+    {"execute": "drive-mirror", "arguments":{ "device": "colo-disk0", "jo=
b-id": "resync", "target": "nbd://127.0.0.1:9999/parent0", "mode": "existi=
ng", "format": "raw", "sync": "full"} }
+
+Wait until disk is synced, then::
+
+    {"execute": "stop"}
+    {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
+
+    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "insert": "before", "position": "id=3Drew0", "netdev": "hn0", =
"queue": "tx", "outdev": "mirror0" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "insert": "before", "position": "id=3Drew0", "netdev"=
: "hn0", "queue": "rx", "indev": "compare_out" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire1", "insert": "before", "position": "id=3Drew0", "netdev"=
: "hn0", "queue": "rx", "outdev": "compare0" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "iothread", "id":=
 "iothread1" } }
+    {"execute": "object-add", "arguments":{ "qom-type": "colo-compare", "=
id": "comp0", "primary_in": "compare0-0", "secondary_in": "compare1", "out=
dev": "compare_out0", "iothread": "iothread1" } }
+
+    {"execute": "migrate-set-capabilities", "arguments":{ "capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
+    {"execute": "migrate", "arguments":{ "uri": "tcp:127.0.0.1:9998" } }
+
+TODO
+----
+1. Support shared storage.
+2. Develop the heartbeat part.
+3. Reduce checkpoint VM=E2=80=99s downtime while doing checkpoint.

=2D-=20
2.39.5


