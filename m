Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276B6C9EC94
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIrW-0007Zj-E1; Mon, 12 Jan 2026 09:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vfIrU-0007Yr-Tu
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:25:40 -0500
Received: from smtp-relay-services-1.canonical.com ([185.125.188.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noreply@launchpad.net>)
 id 1vfIrS-00063p-Bz
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:25:40 -0500
Received: from scripts.lp.internal (scripts.lp.internal [10.131.215.246])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-services-1.canonical.com (Postfix) with ESMTPSA id 680B1401A3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=launchpad.net;
 s=20210803; t=1768227936;
 bh=VIZ8qqHUP8l3IgWiHtdxhNv3CJQWbadCh/C/UW+IttM=;
 h=MIME-Version:Content-Type:Date:From:To:Reply-To:References:
 Message-Id:Subject;
 b=ir0lsGhtjMEg6JwyTmWRu60eQ6wJRcDbKfWwCPLvIIzliIYDlnXgc0MhXQ478AcRS
 FjcGqfMv2o3yGYdnFS/ndM17Tkgqi6hLnApTbzHdy6sJ6btRXN2RIKoKLiB96KVg/b
 6KS/0v6ANtxiEkMRKY62ICVn/GRYdxH5TnJrcJNLeBXz0ShNa9PGWDt7b9fZAMfpxH
 9iogfg8JgDFnC9RBGYi0XPs8gqmFq0s3zH26Tdf1ot//YBrOsOlzCILIHNmwuUP7WC
 f5DZih5+/cl96c4gqOWYMZBCoDPcvXYuQ04Eujv/jboit5dOg6rtS49AVmn7HCZVCy
 zbzb6b1kpfInA==
Received: from scripts.lp.internal (localhost [127.0.0.1])
 by scripts.lp.internal (Postfix) with ESMTP id 5A1957E365
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Jan 2026 14:19:18 -0000
From: Wesley Hershberger <2126951@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Unknown;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Confirmed; importance=Medium; assignee=wesley.hershberger@canonical.com;
X-Launchpad-Bug: distribution=ubuntu; distroseries=jammy; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Medium;
 assignee=wesley.hershberger@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=noble; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Medium;
 assignee=wesley.hershberger@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=plucky; sourcepackage=qemu;
 component=main; status=Won't Fix; importance=Medium;
 assignee=wesley.hershberger@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=questing; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Medium;
 assignee=wesley.hershberger@canonical.com; 
X-Launchpad-Bug: distribution=ubuntu; distroseries=resolute; sourcepackage=qemu;
 component=main; status=Confirmed; importance=Medium;
 assignee=wesley.hershberger@canonical.com; 
X-Launchpad-Bug-Tags: sts
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: athos whershberger
X-Launchpad-Bug-Reporter: Wesley Hershberger (whershberger)
X-Launchpad-Bug-Modifier: Wesley Hershberger (whershberger)
References: <175977079933.1446079.11908449148472830395.malonedeb@juju-98d295-prod-launchpad-3>
Message-Id: <176822755900.2103020.10975250915760940984.malone@juju-98d295-prod-launchpad-3>
Subject: [Bug 2126951] Re: `block-stream` segfault with concurrent
 `query-named-block-nodes`
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c00f518760bdd50fc6e353e7736d2fff8fba4a";
 Instance="launchpad-scripts"
X-Launchpad-Hash: c88edd7a1223221dc758290c1f6b8eab0bd529e5
Received-SPF: pass client-ip=185.125.188.251;
 envelope-from=noreply@launchpad.net; helo=smtp-relay-services-1.canonical.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Thanks for the ping Athos; I won't be able to get to this before the
Plucky EOL.

The fix for this landed as 9dbfd4e28dd11a83f54c371fade8d49a63d6dc1e
upstream, present in v10.2.0-rc1 and released in v10.2.0.

** Changed in: qemu (Ubuntu Plucky)
       Status: Confirmed =3D> Won't Fix

--=20
You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/2126951

Title:
  `block-stream` segfault with concurrent `query-named-block-nodes`

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Confirmed
Status in qemu source package in Jammy:
  Confirmed
Status in qemu source package in Noble:
  Confirmed
Status in qemu source package in Plucky:
  Won't Fix
Status in qemu source package in Questing:
  Confirmed
Status in qemu source package in Resolute:
  Confirmed

Bug description:
  [ Impact ]

  When running `block-stream` and `query-named-block-nodes`
  concurrently, a null-pointer dereference causes QEMU to segfault.

  This occurs in every version of QEMU shipped with Ubuntu, 22.04 thru
  25.10. I have not yet reproduced the bug using an upstream build.

  I will link the upstream bug report here as soon as I've written it.

  [ Reproducer ]

  In `query-named-block-nodes.sh`:
  ```sh
  #!/bin/bash

  while true; do
      virsh qemu-monitor-command "$1" query-named-block-nodes > /dev/null
  done
  ```

  In `blockrebase-crash.sh`:
  ```sh
  #!/bin/bash

  set -ex

  domain=3D"$1"

  if [ -z "${domain}" ]; then
      echo "Missing domain name"
      exit 1
  fi

  ./query_named_block_nodes.sh "${domain}" &
  query_pid=3D$!

  while [ -n "$(virsh list --uuid)" ]; do
      snap=3D"snap0-$(uuidgen)"

      virsh snapshot-create-as "${domain}" \
          --name "${snap}" \
          --disk-only file=3D \
          --diskspec vda,snapshot=3Dno \
          --diskspec "vdb,stype=3Dfile,file=3D/var/lib/libvirt/images/n0-bl=
k0_${snap}.qcow2" \
          --atomic \
          --no-metadata

      virsh blockpull "${domain}" vdb

      while bjr=3D$(virsh blockjob "$domain" vdb); do
          if [[ "$bjr" =3D=3D *"No current block job for"* ]] ; then
              break;
          fi;
      done;
  done

  kill "${query_pid}"
  ```

  Provision (`Ctrl + ]` after boot):
  ```sh
  wget https://cloud-images.ubuntu.com/daily/server/noble/current/noble-ser=
ver-cloudimg-amd64.img

  sudo cp noble-server-cloudimg-amd64.img /var/lib/libvirt/images/n0-root.q=
cow2
  sudo qemu-img create -f qcow2 /var/lib/libvirt/images/n0-blk0.qcow2 10G

  touch network-config
  touch meta-data
  touch user-data

  virt-install \
    -n n0 \
    --description "Test noble minimal" \
    --os-variant=3Dubuntu24.04 \
    --ram=3D1024 --vcpus=3D2 \
    --import \
    --disk path=3D/var/lib/libvirt/images/n0-root.qcow2,bus=3Dvirtio,cache=
=3Dwritethrough,size=3D10 \
    --disk path=3D/var/lib/libvirt/images/n0-blk0.qcow2,bus=3Dvirtio,cache=
=3Dwritethrough,size=3D10 \
    --graphics none \
    --network network=3Ddefault \
    --cloud-init user-data=3D"user-data,meta-data=3Dmeta-data,network-confi=
g=3Dnetwork-config"
  ```

  And run the script to cause the crash (you may need to manually kill
  query-named-block-jobs.sh):
  ```sh
  ./blockrebase-crash n0
  ```

  [ Details ]

  Backtrace from the coredump (source at [1]):
  ```
  #0  bdrv_refresh_filename (bs=3D0x5efed72f8350) at /usr/src/qemu-1:10.1.0=
+ds-5ubuntu2/b/qemu/block.c:8082
  #1  0x00005efea73cf9dc in bdrv_block_device_info (blk=3D0x0, bs=3D0x5efed=
72f8350, flat=3Dtrue, errp=3D0x7ffeb829ebd8)
      at block/qapi.c:62
  #2  0x00005efea7391ed3 in bdrv_named_nodes_list (flat=3D<optimized out>, =
errp=3D0x7ffeb829ebd8)
      at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:6275
  #3  0x00005efea7471993 in qmp_query_named_block_nodes (has_flat=3D<optimi=
zed out>, flat=3D<optimized out>,
      errp=3D0x7ffeb829ebd8) at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/b=
lockdev.c:2834
  #4  qmp_marshal_query_named_block_nodes (args=3D<optimized out>, ret=3D0x=
7f2b753beec0, errp=3D0x7f2b753beec8)
      at qapi/qapi-commands-block-core.c:553
  #5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=3D0x7f2b753beed0) at=
 qapi/qmp-dispatch.c:128
  #6  0x00005efea75108e6 in aio_bh_poll (ctx=3D0x5efed6f3f430) at util/asyn=
c.c:219
  #7  0x00005efea74ffdb2 in aio_dispatch (ctx=3D0x5efed6f3f430) at util/aio=
-posix.c:436
  #8  0x00005efea7512846 in aio_ctx_dispatch (source=3D<optimized out>, cal=
lback=3D<optimized out>,
      user_data=3D<optimized out>) at util/async.c:361
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
ockjob, since it reaches "concluded" state before crashing. I assume that t=
his is one of:
  - `stream_clean` is freeing/modifying the `cor_filter_bs` without holding=
 a lock that it needs to [2][3]
  - `bdrv_refresh_filename` needs to handle the possibility that the QLIST =
of children for a filter bs could be NULL [1]

  [1] https://git.launchpad.net/ubuntu/+source/qemu/tree/block.c?h=3Dubuntu=
/questing-devel#n8071
  [2] https://git.launchpad.net/ubuntu/+source/qemu/tree/block/stream.c?h=
=3Dubuntu/questing-devel#n131
  [3] https://git.launchpad.net/ubuntu/+source/qemu/tree/block/stream.c?h=
=3Dubuntu/questing-devel#n340

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/2126951/+subscriptions


