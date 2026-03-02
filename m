Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCB7E9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Pa-0008Ge-Ro; Mon, 02 Mar 2026 05:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0O4-0006ke-OA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:32 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Ny-0007LP-3y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446815; x=1773051615; i=lukasstraub2@web.de;
 bh=5ZMxuZledCNhBkww1q32JXmc44pD1RwIeIS5m+4DSPs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bKYpUKGK/J6OujqX338rmVYt5Tc/YEOxJgW1ZQJQpC8fHfzWzpsH36r6b/nJK75C
 YhkmeTnzqtqDOJHSHJimlXnNy9ewdcSThp3zEhpKdOjbNMUqDwW8CjiFjo5kfj3H3
 M2TWMzMTYDyKACcxZ/iFrIj/BflsWajs47CxMlno3jbvOu7BvcU1nd9kyVwVwvDrx
 OHes2j9fSNh/uiBeNqfioHD3uy3hueEJAGCJcMz81jQFlQ4OgHI7XNUVdhece3DtO
 69lcqDK5/DTqAOFlvyQhvatmnFVKeRHXliyJGEVX8/LK5Pr9jQGH8/+IoYWpOQToV
 TP7G8Q53nkT1wflJgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N1d7s-1vYqlb1y00-00uVt6; Mon, 02
 Mar 2026 11:20:15 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 14/21] Convert colo main documentation to restructuredText
Date: Mon,  2 Mar 2026 11:19:56 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-14-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=41531; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=ifBF4hUr+Rs6qxvXE1tWijcBFlkplxnUJNPDi8Qzm/k=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQprRtX3beqANqPi8wNYqgrvyz8qAI10Jgw5
 XO5YyKOIseJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WOMMD/4oyFoHwT1tlZQKMyjJzRnS3mDHQdkmzSaJMMwFmjuvaAMLDDCEwcr/27D7P3tZPeRPgqV
 EfsYoDwoRfQZhwxXUhj//m+ev+uixnOp5sddO8z+NIE172L/lB41i0qQL9kWCO+cANTgMBEwp/W
 WQyddNFdbR3q80KXBvIUJgOfjLHJ7gmaI6nC3hulQrHVAwBOrHwoW6MpUoELOU9LBacl5T8D+X/
 r84jkLJRlWes6aEPfBW44yQVpFJ/B/OnfckMbntvekod/9YMIBqkGufscFsnLN8Go63ATPJ5LVb
 edNJXYTIXbvDAtNZiAJTkKjiGKozAHTl773E1mg49guho6iv3ou5lUrQUmCBlBARjk460HNsc60
 j2tLEzkWKMwjNfhCfbLDp+b4PpT547vgyiWhzvSDqRZ1cEofdWZ9BZHj23giLi2HXXozm8zv/3l
 dMbGclLuN/kjGEkoOkoRoCXtbFpumRVwMd/aKF0/0uiPTjsYNRiz1Vn9gLfeFcLwiMyvvvvo1HT
 EdIgI4/PkffDswWZpkm1cDLIu1jit0mjZ5zUTUcllmITBDn5YmZ3DidstqTTG3NZ9bkEXyP3yO1
 rFWSSjLtoNazLt6trmkzEryHgWOPGHK7h0g2r4doKARj4qUj6OiAVPSNZrqIEZtLZPub2csdeHU
 7hKdSxnhQYssOjw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:304wzrHeo5eP3Zfr3F2LxJ8rGfKVLf8Mh6mBTr5wQZ+XpTRShOW
 Z/kXbU/a4SS1T5shzG62Plh+BXJMSuTTO7wbIT2u3EQHBqMvV7sspxp0Bf8B6+dbLl/Byhj
 sDCmyurjInoftbsFi6qt7ZDPdb3ou9RafVX2zYSJk86g+Tm5uQ//xnDqfQI0tKkKHbCyUNm
 JkoBNnaXSPkmefjeitQ3g==
UI-OutboundReport: notjunk:1;M01:P0:64TgZQCNJOs=;2WLr1bpxcVH1r7t1ifsYR/shQz1
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 1b0ae10750036be00571b7104ad8426c071bb54c..32ab4b1faa29499ae9067088ae=
1739e52680cbb4 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3876,7 +3876,7 @@ F: migration/multifd-colo.*
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


