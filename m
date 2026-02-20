Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78E1C5B55D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXp-0000WF-2u; Fri, 20 Feb 2026 14:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXl-0000Vn-H1
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:05 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXg-0001T9-B6
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617111; x=1772221911; i=lukasstraub2@web.de;
 bh=tm2GuqhPzDQglqiU9unalx2iQFmY16oh1Y5nzSaxNkU=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IHMTsvV6/cj06RI/8tY7DGntUTZq5jpTTVL8ZOQn0vdm8cu4vXM0FgoEh0cTxsxn
 1y61v79d8VcRo8CWO5R+FypzT5yCIHs5zQskJKUTDjal47hkfEx0IiOlhYA7fPD/T
 6AMocH+XZcQX58ivlyzLgdtxOse8S+UuG6IrIOMCLQ1+ZIbV52vzFJnr6iSXGuhTK
 ZAnQF9u+yVebi4bNLRHQs+hUKDATc7+/nJ+H5sybVu9+nkXMRdKYHyOPOCUjbFsHo
 fV6d7eVITLeeZlyUxLALr4PnyrNj0cYT75ku06L7hrIMgqlVO6J9HyXEXLzUCHj9L
 SveBkhdsqwEx08ZW5w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwfU-1w4Z8p0YO0-00O65o; Fri, 20
 Feb 2026 20:51:51 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:36 +0100
Subject: [PATCH v10 14/19] Convert colo main documentation to restructuredText
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-14-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
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
 bh=iT0yKWdgPjIrLAMyRRhfEz9UKNNM/A4TaDEqfoojmL4=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtOUaKYKgoTo4StRHNY3GlcV0krIwwtXPTw9
 HvHjmTdZqyJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WIPkD/9dLoOPfZzObLd/OihacZTpu7Yuj2VgG6vlT0NbUOKsHJtcShFlbQQbuOg/0qh+lkcH8Z7
 kpBC6zHztb68gRRfhCvjLBuCQqJica71SqRXgrDNXw4YoDpEVRQbthg7YVDAg9zphVJp+Qm9HcA
 CYW6atPzTA5zPZbUJXQMJpsRVpSBMhRPhGrTJ5zCwKD0yahFITHGtcIAd/Uyq0rrEsxzqY3spAi
 h2gcVUfDyNZztB8eDXRpWYN8F51jX/JOdIMQsIIXISG9H1Ct9gfhqKahP2ZvkNgVQIahu+Lnm+y
 8wzAZ1SG6Y63hVJXK3pxG/E5wwGN4dk4tnvk2b5DTjgtcXwdz7VCEKiMvttVhoIV3c+d+PaJAsp
 ynoI3aL1t0bdcYvyMKDdILww3ZS6enS6GzGAnNHpDOz6YtAw5McXuTF5qi18YIaUiEP5pdMsXcL
 u0eUIva9ZogKYtSgvI9btjaD79BcW6lasd54CPXv/drcUxuWXY+KRR5GkIF4t2l1NjNFQbsaOr0
 eZ3rsHYDIXHrdNDNUPiMAmwV/SWfmK37nSPpBrlZcF00iRwLzJicIhmMSNN8Rf9ZChGFv1aHyto
 /F/+TMeFLNS31Z6vtNZIJuDSjdmnK+eSjHSOSV2UWM5tDlOFZxlzSZKFIVoyLkHudAl2Ap6kDtT
 BbMTFZ3MF9ZleDQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:ImepbSKhqJoELp+6LjZkecujlglgiwepl/I/nSoXUsj0b1L4KfL
 vOsz7XqNAKERPPFNmVeW7H5imRsL7evdDk+OcPrf40S+MN/AmMUZb2sIqTSJJ8jscNWQ+jB
 Ter2edKjxkbSKiPC1QdGb9KHdsR7tRk+G6xq3H883tDKKIKPawPBUob6zLcX0DcoPsxMg/x
 OAMFCQ9Q9g0MTnj1JmZAQ==
UI-OutboundReport: notjunk:1;M01:P0:nCqL8/b3DMI=;UHw1hcDjHj9S6qB2gcWjGhDEDtv
 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
 oOCcInOqduiKaq+rmkLX
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index a587a9233ac556a420f8784c4e3217e5c5b99f34..486c361ceac893175a8cb4f9ae=
2e8ac8202137ea 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3872,7 +3872,7 @@ F: migration/multifd-colo.*
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


