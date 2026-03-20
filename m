Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2060109316E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 02:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Q2Y-0005eB-0u; Thu, 19 Mar 2026 22:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1w3Q2W-0005e3-Tf
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 22:56:44 -0400
Received: from smtp-relay-services-0.canonical.com ([185.125.188.250])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1w3Q2T-0000MO-Mh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 22:56:44 -0400
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-0.canonical.com (Postfix) with ESMTPSA id 4585042F57
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1773975399;
 bh=SmSrCL2c72y6L3hd0s9BjMPQgS/udNfIU/pYsiUxulg=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=cppWQP2Z79iOrjy68aM6kFPeFCyoEuGu0Khsk4NAAi/nnzZI4J3DBXVYSPz3+UB5p
 5Ls4g8NOroMcYD2uxJ7V3BbccVgVj7zRIiqXmauTuCsXrDQpncALPH/ztnyWkZvJ9m
 baVEhfQTsO+/5NCXiVBdbna+7HmzXxG5HV8zNW18QvBzfA6AWrn3+XOOv/nhUIWfoM
 sVKCAzYG8O6Ul124Ck1YTHJDyMRfW0c3ygnOxaKvSpZ22woo3VNMt5gwK6UoKOgIlk
 JfhtrnX540tslCvOOh7Da6SmkQArxiTCuSAIjxtbotIfCgezKQBpjnaSYFW6DTetii
 qQPiadCRsNptw==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 3DC0A7F0B6
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:56:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Mar 2026 02:23:04 -0000
From: Ubuntu SRU Bot <2126951@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Committed; importance=Medium; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=jammy; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Medium;
 assignee=wesley.hershberger@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Medium;
 assignee=wesley.hershberger@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=qemu;
 component=main; status=Won't Fix; importance=Medium;
 assignee=wesley.hershberger@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Medium;
 assignee=wesley.hershberger@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=resolute; sourcepackage=qemu;
 component=main; status=Fix Committed; importance=Medium; assignee=None; 
X-Launchpad-Bug-Tags: sts verification-needed verification-needed-jammy
 verification-needed-noble verification-needed-questing
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: athos hectorcao mjt+launchpad-tls tjaalton
 ubuntu-sru-bot whershberger
X-Launchpad-Bug-Reporter: Wesley Hershberger (whershberger)
X-Launchpad-Bug-Modifier: Ubuntu SRU Bot (ubuntu-sru-bot)
References: <175977079933.1446079.11908449148472830395.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <20260320022304.C3A63FC025@ubuntu-archive-toolbox.internal>
Subject: [Bug 2126951] Autopkgtest regression report
 (qemu/1:10.1.0+ds-5ubuntu2.5)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="30ebb7e51b1d452d1afd137b32cca7f23d23d307";
 Instance="launchpad-scripts"
X-Launchpad-Hash: 0690554daf4952c30e26d943e1eb9dbcea899445
Received-SPF: pass client-ip=185.125.188.250;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-0.canonical.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 2126951 <2126951@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All autopkgtests for the newly accepted qemu (1:10.1.0+ds-5ubuntu2.5) for q=
uesting have finished running.
The following regressions have been reported in tests triggered by the pack=
age:

freedom-maker/0.34 (armhf)
multipath-tools/0.11.1-3ubuntu2 (ppc64el)
nova/unknown (ppc64el)
qemu/1:10.1.0+ds-5ubuntu2.5 (armhf)
systemd/257.9-0ubuntu2.1 (armhf)


Please visit the excuses page listed below and investigate the failures, pr=
oceeding afterwards as per the StableReleaseUpdates policy regarding autopk=
gtest regressions [1].

https://people.canonical.com/~ubuntu-archive/proposed-
migration/questing/update_excuses.html#qemu

[1] https://wiki.ubuntu.com/StableReleaseUpdates#Autopkgtest_Regressions

Thank you!

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2126951

Title:
  `block-stream` segfault with concurrent `query-named-block-nodes`

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Committed
Status in qemu source package in Jammy:
  Fix Committed
Status in qemu source package in Noble:
  Fix Committed
Status in qemu source package in Plucky:
  Won't Fix
Status in qemu source package in Questing:
  Fix Committed
Status in qemu source package in Resolute:
  Fix Committed

Bug description:
  [ Impact ]

  When running `block-stream` and `query-named-block-nodes`
  concurrently, a null-pointer dereference causes QEMU to segfault.

  The original reporter of this issue experienced the bug while
  performing concurrent libvirt `virDomainBlockPull` calls on the same
  VM/different disks. The race condition occurs at the end of the
  `block-stream` QMP; libvirt's handler for a completed `block-stream`
  (`qemuBlockJobProcessEventCompletedPull` [1]) calls `query-named-
  block-nodes` (see "libvirt trace" below for a full trace).

  This occurs in every version of QEMU shipped with Ubuntu, 22.04 thru
  25.10.

  [1] qemuBlockJobProcessEventCompletedPull

  [ Test Plan ]

  ```
  sudo apt install libvirt-daemon-system virtinst
  ```

  In `query-named-block-nodes.sh`:
  ```sh
  #!/bin/bash

  while true; do
  =C2=A0=C2=A0=C2=A0=C2=A0virsh qemu-monitor-command "$1" query-named-block=
-nodes > /dev/null
  done
  ```

  In `blockrebase-crash.sh`:
  ```sh
  #!/bin/bash

  set -ex

  domain=3D"$1"

  if [ -z "${domain}" ]; then
  =C2=A0=C2=A0=C2=A0=C2=A0echo "Missing domain name"
  =C2=A0=C2=A0=C2=A0=C2=A0exit 1
  fi

  ./query-named-block-nodes.sh "${domain}" &
  query_pid=3D$!

  while [ -n "$(virsh list --uuid)" ]; do
  =C2=A0=C2=A0=C2=A0=C2=A0snap=3D"snap0-$(uuidgen)"

  =C2=A0=C2=A0=C2=A0=C2=A0virsh snapshot-create-as "${domain}" \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--name "${snap}" \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--disk-only file=3D \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--diskspec vda,snapshot=
=3Dno \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--diskspec "vdb,stype=3Df=
ile,file=3D/var/lib/libvirt/images/n0-blk0_${snap}.qcow2" \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--atomic \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0--no-metadata

  =C2=A0=C2=A0=C2=A0=C2=A0virsh blockpull "${domain}" vdb

  =C2=A0=C2=A0=C2=A0=C2=A0while bjr=3D$(virsh blockjob "$domain" vdb); do
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [[ "$bjr" =3D=3D *"No =
current block job for"* ]] ; then
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0b=
reak;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi;
  =C2=A0=C2=A0=C2=A0=C2=A0done;
  done

  kill "${query_pid}"
  ```

  `provision.sh` (`Ctrl + ]` after boot):
  ```sh
  #!/bin/bash

  set -ex

  wget https://cloud-images.ubuntu.com/daily/server/noble/current/noble-
  server-cloudimg-amd64.img

  sudo cp noble-server-cloudimg-amd64.img /var/lib/libvirt/images/n0-root.q=
cow2
  sudo qemu-img create -f qcow2 /var/lib/libvirt/images/n0-blk0.qcow2 10G

  touch network-config
  touch meta-data
  touch user-data

  virt-install \
  =C2=A0=C2=A0-n n0 \
  =C2=A0=C2=A0--description "Test noble minimal" \
  =C2=A0=C2=A0--os-variant=3Dubuntu24.04 \
  =C2=A0=C2=A0--ram=3D1024 --vcpus=3D2 \
  =C2=A0=C2=A0--import \
  =C2=A0=C2=A0--disk path=3D/var/lib/libvirt/images/n0-root.qcow2,bus=3Dvir=
tio,cache=3Dwritethrough,size=3D10 \
  =C2=A0=C2=A0--disk path=3D/var/lib/libvirt/images/n0-blk0.qcow2,bus=3Dvir=
tio,cache=3Dwritethrough,size=3D10 \
  =C2=A0=C2=A0--graphics none \
  =C2=A0=C2=A0--network network=3Ddefault \
  =C2=A0=C2=A0--cloud-init user-data=3D"user-data,meta-data=3Dmeta-data,net=
work-config=3Dnetwork-config"
  ```

  And run the script to cause the crash (you may need to manually kill
  query-named-block-jobs.sh):
  ```sh
  chmod 755 provision.sh blockrebase-crash.sh query-named-block-nodes.sh
  ./provision.sh
  ./blockrebase-crash n0
  ```

  Expected behavior: `blockrebase-crash.sh` runs until "No space left on
  device"

  Actual behavior: QEMU crashes after a few iterations:
  ```
  Block Pull: [81.05 %]+ bjr=3D
  + [[ '' =3D=3D *\N\o\ \c\u\r\r\e\n\t\ \b\l\o\c\k\ \j\o\b\ \f\o\r* ]]
  ++ virsh blockjob n0 vdb
  Block Pull: [97.87 %]+ bjr=3D
  + [[ '' =3D=3D *\N\o\ \c\u\r\r\e\n\t\ \b\l\o\c\k\ \j\o\b\ \f\o\r* ]]
  ++ virsh blockjob n0 vdb
  error: Unable to read from monitor: Connection reset by peer
  error: Unable to read from monitor: Connection reset by peer
  + bjr=3D
  ++ virsh list --uuid
  + '[' -n 4eed8ba4-300b-4488-a520-510e5b544f57 ']'
  ++ uuidgen
  + snap=3Dsnap0-88be23e5-696c-445d-870a-abe5f7df56c0
  + virsh snapshot-create-as n0 --name snap0-88be23e5-696c-445d-870a-abe5f7=
df56c0 --disk-only file=3D --diskspec vda,snapshot=3Dno --diskspec vdb,styp=
e=3Dfile,file=3D/var/lib/libvirt/images/n0-blk0_snap0-88be23e5-696c-445d-87=
0a-abe5f7df56c0.qcow2 --atomic --no-metadata
  error: Requested operation is not valid: domain is not running
  Domain snapshot snap0-88be23e5-696c-445d-870a-abe5f7df56c0 created
  + virsh blockpull n0 vdb
  error: Requested operation is not valid: domain is not running
  error: Requested operation is not valid: domain is not running

  wesley@nv0:~$ error: Requested operation is not valid: domain is not runn=
ing
  ```

  [ Where problems could occur ]

  The only codepaths affected by this change are `block-stream` and
  `blockdev-backup` [1][2]. If the code is somehow broken, we would
  expect to see failures when executing these QMP commands (or the
  libvirt APIs that use them, `virDomainBlockPull` and
  `virDomainBackupBegin` [3][4]).

  As noted in the upstream commit message, the change does cause an
  additional flush to occur during `blockdev-backup` QMPs.

  The patch that was ultimately merged upstream was a revert of most of
  [5]. _That_ patch was a workaround for a blockdev permissions issue
  that was later resolved in [6] (see the end of [7] and replies for
  upstream discussion). Both [5] and [6] are present in QEMU 6.2.0, so
  the assumptions that led us to the upstream solution hold for Jammy.

  [1] https://qemu-project.gitlab.io/qemu/interop/qemu-qmp-ref.html#command=
-QMP-block-core.block-stream
  [2] https://qemu-project.gitlab.io/qemu/interop/qemu-qmp-ref.html#command=
-QMP-block-core.blockdev-backup
  [3] https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainBlockPu=
ll
  [4] https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainBackupB=
egin
  [5] https://gitlab.com/qemu-project/qemu/-/commit/3108a15cf09
  [6] https://gitlab.com/qemu-project/qemu/-/commit/3860c0201924d
  [7] https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg06800.html

  [ Other info ]

  Backtrace from the coredump (source at [1]):
  ```
  #0  bdrv_refresh_filename (bs=3D0x5efed72f8350) at /usr/src/qemu-1:10.1.0=
+ds-5ubuntu2/b/qemu/block.c:8082
  #1  0x00005efea73cf9dc in bdrv_block_device_info (blk=3D0x0, bs=3D0x5efed=
72f8350, flat=3Dtrue, errp=3D0x7ffeb829ebd8)
  =C2=A0=C2=A0=C2=A0=C2=A0at block/qapi.c:62
  #2  0x00005efea7391ed3 in bdrv_named_nodes_list (flat=3D<optimized out>, =
errp=3D0x7ffeb829ebd8)
  =C2=A0=C2=A0=C2=A0=C2=A0at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/bloc=
k.c:6275
  #3  0x00005efea7471993 in qmp_query_named_block_nodes (has_flat=3D<optimi=
zed out>, flat=3D<optimized out>,
  =C2=A0=C2=A0=C2=A0=C2=A0errp=3D0x7ffeb829ebd8) at /usr/src/qemu-1:10.1.0+=
ds-5ubuntu2/b/qemu/blockdev.c:2834
  #4  qmp_marshal_query_named_block_nodes (args=3D<optimized out>, ret=3D0x=
7f2b753beec0, errp=3D0x7f2b753beec8)
  =C2=A0=C2=A0=C2=A0=C2=A0at qapi/qapi-commands-block-core.c:553
  #5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=3D0x7f2b753beed0) at=
 qapi/qmp-dispatch.c:128
  #6  0x00005efea75108e6 in aio_bh_poll (ctx=3D0x5efed6f3f430) at util/asyn=
c.c:219
  #7  0x00005efea74ffdb2 in aio_dispatch (ctx=3D0x5efed6f3f430) at util/aio=
-posix.c:436
  #8  0x00005efea7512846 in aio_ctx_dispatch (source=3D<optimized out>, cal=
lback=3D<optimized out>,
  =C2=A0=C2=A0=C2=A0=C2=A0user_data=3D<optimized out>) at util/async.c:361
  #9  0x00007f2b77809bfb in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so=
.0
  #10 0x00007f2b77809e70 in g_main_context_dispatch () from /lib/x86_64-lin=
ux-gnu/libglib-2.0.so.0
  #11 0x00005efea7517228 in glib_pollfds_poll () at util/main-loop.c:287
  #12 os_host_main_loop_wait (timeout=3D0) at util/main-loop.c:310
  #13 main_loop_wait (nonblocking=3D<optimized out>) at util/main-loop.c:589
  #14 0x00005efea7140482 in qemu_main_loop () at system/runstate.c:905
  #15 0x00005efea744e4e8 in qemu_default_main (opaque=3Dopaque@entry=3D0x0)=
 at system/main.c:50
  #16 0x00005efea6e76319 in main (argc=3D<optimized out>, argv=3D<optimized=
 out>) at system/main.c:93
  ```

  The libvirt logs suggest that the crash occurs right at the end of the bl=
ockjob, since it reaches "concluded" state before crashing. I assumed that =
this was one of:
  - `stream_clean` is freeing/modifying the `cor_filter_bs` without holding=
 a lock that it needs to [2][3]
  - `bdrv_refresh_filename` needs to handle the possibility that the QLIST =
of children for a filter bs could be NULL [1]

  Ultimately the fix was neither of these [4]; `bdrv_refresh_filename`
  should not be able to observe a NULL list of children.

  `query-named-block-nodes` iterates the global list of block nodes
  `graph_bdrv_states` [5]. The offending block node (the
  `cor_filter_bs`, added during a `block-stream`) was removed from the
  list of block nodes _for the disk_ when the operation finished, but
  not removed from the global list of block nodes until later (this is
  the window for the race). The patch keeps the block node in the disk's
  list until it is dropped at the end of the blockjob.

  [1] https://git.launchpad.net/ubuntu/+source/qemu/tree/block.c?h=3Dubuntu=
/questing-devel#n8071
  [2] https://git.launchpad.net/ubuntu/+source/qemu/tree/block/stream.c?h=
=3Dubuntu/questing-devel#n131
  [3] https://git.launchpad.net/ubuntu/+source/qemu/tree/block/stream.c?h=
=3Dubuntu/questing-devel#n340
  [4] https://gitlab.com/qemu-project/qemu/-/commit/9dbfd4e28dd11a83f54c371=
fade8d49a63d6dc1e
  [5] https://gitlab.com/qemu-project/qemu/-/blob/v10.1.0/block.c?ref_type=
=3Dtags#L72
  [6] https://gitlab.com/qemu-project/qemu/-/commit/9dbfd4e28dd11a83f54c371=
fade8d49a63d6dc1e

  [ libvirt trace ]
  `qemuBlockJobProcessEventCompletedPull` [1]
  `qemuBlockJobProcessEventCompletedPullBitmaps` [2]
  `qemuBlockGetNamedNodeData` [3]
  `qemuMonitorBlockGetNamedNodeData` [4]
  `qemuMonitorJSONBlockGetNamedNodeData` [5]
  `qemuMonitorJSONQueryNamedBlockNodes` [6]

  [1] https://git.launchpad.net/ubuntu/+source/libvirt/tree/src/qemu/qemu_b=
lockjob.c?h=3Dapplied/ubuntu/questing-devel#n870
  [2] https://git.launchpad.net/ubuntu/+source/libvirt/tree/src/qemu/qemu_b=
lockjob.c?h=3Dapplied/ubuntu/questing-devel#n807
  [3] https://git.launchpad.net/ubuntu/+source/libvirt/tree/src/qemu/qemu_b=
lock.c?h=3Dapplied/ubuntu/questing-devel#n2925
  [4] https://git.launchpad.net/ubuntu/+source/libvirt/tree/src/qemu/qemu_m=
onitor.c?h=3Dapplied/ubuntu/questing-devel#n2039
  [5] https://git.launchpad.net/ubuntu/+source/libvirt/tree/src/qemu/qemu_m=
onitor_json.c?h=3Dapplied/ubuntu/questing-devel#n2816
  [6] https://git.launchpad.net/ubuntu/+source/libvirt/tree/src/qemu/qemu_m=
onitor_json.c?h=3Dapplied/ubuntu/questing-devel#n2159

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2126951/+subscriptions


