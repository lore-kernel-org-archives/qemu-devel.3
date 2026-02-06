Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1251DEE6B50
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3g-0004OD-M2; Fri, 06 Feb 2026 15:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3M-0004Fx-AH
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:46 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008PD-NQ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408208; x=1771013008; i=lukasstraub2@web.de;
 bh=DHQzHBoMt9UcskNHv5moJtho17FjGy9wLz2dMotNemw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=sgGdbswT9yv6B9k/9emuS69saAIul+l9cbjZpbaj7J0BeVGsY1xb5qP3mfxaLRf4
 KPZbVn+CtYeAcBrAADLeed4XPrCBXNOYCQisDZlsGLLO7WnDEH0TZNwi90mOR90cp
 a5zQycTME22Kak9AVwYuJZm0L+kI/eU9Z/tr6TfDE60npx4Of79kkSWrUUqy0JuWN
 zQA9T+/+ClvrDkWWqHcGxQrQilgqdaxWkdD9SvY/m/PDe06f4yfixNmQWSKLV+94b
 8d3IKAE7069ba/2hLn3aHv7KofSD3XCZhUVxqWWi7MrIEK73em9ZOp5VZfrJpWGVh
 YA/Z3pGu10MsgJd3YQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sbr-1vn58S3JO3-0033gr; Fri, 06
 Feb 2026 21:03:27 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:13 +0100
Subject: [PATCH v6 15/18] Convert colo main documentation to restructuredText
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-15-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
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
 bh=0lpNjifnmfSQfDD2tpoOsffD4RYUt0R59Bfc2oHij+4=; 
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkGlT6mmu//SL69eKPfQBaj5g5ukKR+NBk1s
 7SETaMLRIWJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBgAKCRA1qwsonF2y
 WDYGD/99doAkU1Xwq2d6gDfT1oP4bFbHkiMB1fgcxKLgWhTwSMRfQB86i5dDnjeyeBHSWlBtW8y
 TFWl0uFTCVyh0SfzeO5KfOltja3xDe76qW/O17ZGohHjef4q3BQJVL5unGlkOvw35yC6/lUwe9P
 4+zQVcI3CdHnY6+D9h6FRwQtW1M/5qxKKDPiMsWgABq193I2uOfReZNxmeH1gGPtXCvTsoOPp1n
 LSTcuCKUHyvBX8qbFOsDURB103dcIxROecm4zTPWcwLiA/twfSLgOtSB3n7y46hO9A3fLZehSp8
 KlCsnrXn9YWOIyd3T7BX/IpCgqS/9fjf/BopH8zwTyzaWwIWPMjldFtNYxaN2DeeegM7UHpLA4b
 PJhMY/Y1U995CtldsltRk7z6NODr0rnQIxr49Zj09gy5cIKLF5Y3oasm9FEO5WzxwCMR6j702+q
 9eMLgoYIaXVWy5SwZlCFBAA1aqU9RruTljZcA8kQowyidXTkqKpedyTWxKM7DO7vnPsTX1WfW7H
 345Hxpvvld9ioGYHPEnA9wTpt5LNDRfcOoAdepCQc3PajtfvQjBntvKuvgNKd37jaPzs3peNlAH
 Il5xN0MIMoVStr9uPjm3r4mskjq2PUHLZ5d3cnzIHYyxbX32YYUHJVWQqHY81i1zuCNfc0WUFmY
 oHEwx0UfgVu7jjA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:oA/kQDf6UWaeTglfuhLvc7sS8BIUSL6QFMU1/nxA/ALwtqZ1bVp
 5qp+gHOyGmhAg9n450NBgwLaxBigUn4+uiIOmQU4wM9yuFiebL/rsnRbpancPs2tW4d65Bs
 ffx25blGS/ZmkGxJOmevPNJ3VQC3DWMgPwbEw9ig7K5pxfTivlgjar2pLuEBcWwZ56dwRfe
 bDf8PAB/pkPSWKHPmewXA==
UI-OutboundReport: notjunk:1;M01:P0:6TiN8ezCHFc=;tkr9ExRPlQf+lzhnFadZWoHov1y
 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
 Cy6avapjW5HmeBP7T1OoflQZ6YWYQ
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 8e63e0a08fc7417036986f27c2d910eb99d8a96a..f645590b8b940919bdc84ad585=
ee493f5452fc20 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3855,7 +3855,7 @@ F: migration/multifd-colo.*
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


