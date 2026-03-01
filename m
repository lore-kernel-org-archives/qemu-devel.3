Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C669FD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHy-0001G3-19; Sun, 01 Mar 2026 14:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHs-0001Ab-Da
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:08 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHn-0003XR-Ru
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392613; x=1772997413; i=lukasstraub2@web.de;
 bh=5ZMxuZledCNhBkww1q32JXmc44pD1RwIeIS5m+4DSPs=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=atU0WDuJszmKFcdiSeOG3zkVaOYfDqYWHGBExreSLRq4HcP3xCa8WfMg1Pwy0WPh
 vIcLvKue14uQmgEyM2LkQ5oPOW0vQmskxQGcuGe8htY04RoSI5G3WtPVPNAwzAYyK
 iT68B0oXE6Yyw9EJm5JXWATKSXsE05yaHu+ZNRhrFX9fciKv2zN8okMnYD32ODc/3
 w/i9glO9O2iOKAoAQVAA+u9bHuz/bxUdLPCYl38s/FfBzRqTQXkz/N4aSDS+0WMR+
 f3tRyHESixwclSYgFidoSulR/o08NdK60b09SlI5a3xevLJ//o4qk/7vij0gqF6k/
 gESWWNb5NSw1Yb3ZwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxsD-1wIYpW23kt-00JU5l; Sun, 01
 Mar 2026 20:16:53 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:39 +0100
Subject: [PATCH v11 14/21] Convert colo main documentation to restructuredText
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-14-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
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
 bh=ifBF4hUr+Rs6qxvXE1tWijcBFlkplxnUJNPDi8Qzm/k=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCdc1RUgxVSLXd54ahQFpIojg5hP7o70fn5w
 +MyN96oYumJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WGZZD/9VqslGUkyEM1qU+h0bqJlZlMt281jVRG25luHGjIx2jv/5kEUaRKdypwYj2Tss/umxBfD
 nNTyZgiBOgZEoD5QSvkVap2updDU9QKeED+kxesEFw7FJHyd1+oivtoPXve3Ixr2qrhbgKAfsnb
 JivSXIkFjDU+nNZqhCVcteM2q4TgVaTKVt1Zek3RaRJOKCOsKcznydXIrHtmwdW2Yoy6efoQdhd
 z3Ych0eXei/59oy76Ljj38YumDeDIiQSJC1kWiKZf3dYSNNphOI2MCAPUHxnbppWFk1U4DaXGYN
 Grg/RMTRBO6jcAQCtKhyLjfhlj5LJA+X09I6d5unHC3jTMzr4sBTVkPVY32rHNWFE1j5xLmjTi3
 gUF9WQnvc3lTDm4YZ19TIumjZWN6ow2sZpam9Z4uH+BVOVwHuNG40PwF/jgmf8o9/b1Ej3K1dw9
 Jn2XKfnBj1b0evaWgwvpEwAZjwHEkzAh51Zc5kUwy82+YDAyfS1VGMH1Q46ZUl7XUyXWhgFBYGM
 MRJiJzUqh0eWkGmQh70bk1/52R0pwLJVlGyfhBhQGjlVh53racb+TPvXIJB+MyI5k51rWJF/OU3
 gsqhS+adjHwEcc5S+Yk2jDmh7ljmZCr5Bwi1RgjOLgrmVNqSN63MJph38jk7mBut88BjLXc42cr
 M0kff3lJ7vt1Fww==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:svCQzSJ3G8JvCJPfZPp1vqqyvQxWpyNcI+M/XYA5qi5lQ67mL5O
 o81tw9sPAN/GTGZJbGeya0slaDf3EJ738TGJyzevLS2sdCr82lk+jzJ9yoaEkkt4a6//JK9
 lar28FS9aQvxm4u7GXuSgOkuahnIDnAdLD6ZF344clfssrSQU9Fpg20PXaEZO7OrgQ/KurG
 2aGvSTycHpBg2iXOHavfQ==
UI-OutboundReport: notjunk:1;M01:P0:zyhttvZmzAE=;GGCXtiDCBs5F5FRz7DgEXZirjAA
 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
 OCKMAPJfOmT9/3RVa8/H
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


