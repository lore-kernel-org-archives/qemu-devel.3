Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B4EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlR1-0005kS-VN; Wed, 21 May 2025 11:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHlQb-0005gw-QO
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uHlQZ-00055j-4Y
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747841535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DeZi5jq5JKOWEBab4inuDc2YFVWtCYh7uf7r41I0TM0=;
 b=RMXsxeWC5R0rRnfz/mNE5zYF6mF2JSArHiZl84k1s5++sjbJKOvrUVKUcJTmOehZLgQGwd
 4PPQiQUMnpcRgXSZuCP5gomAlkCD2pZNrDbNIREjkx9sK6FBYumwvJo6Ob0zh3bDUZGmMR
 b/0SO5jDCrU0kUgeOM5wW3DNfJWJERY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-jp1WZ0cMPQ6Bk2dizauQOQ-1; Wed,
 21 May 2025 11:32:08 -0400
X-MC-Unique: jp1WZ0cMPQ6Bk2dizauQOQ-1
X-Mimecast-MFC-AGG-ID: jp1WZ0cMPQ6Bk2dizauQOQ_1747841528
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B684719560B5; Wed, 21 May 2025 15:32:07 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7417F19560A7; Wed, 21 May 2025 15:32:05 +0000 (UTC)
Date: Wed, 21 May 2025 10:32:02 -0500
From: Eric Blake <eblake@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
Message-ID: <kd563ogyr5t2sh5nz3i3iydcy4r5o2kuze4byv3d22rjyffktt@gbmqgnuufpnh>
References: <20250515022904.575509-16-eblake@redhat.com>
 <20250515022904.575509-29-eblake@redhat.com>
 <78bc08dc-5da5-4fcf-804b-1a387f2e9ea8@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bc08dc-5da5-4fcf-804b-1a387f2e9ea8@proxmox.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 11:54:03AM +0200, Fiona Ebner wrote:
> Hi,
> 
> Am 15.05.25 um 04:28 schrieb Eric Blake:
> > +do_test full ignore off full
> 
> for me, this one fails irregularly (more than 50% of the time) with:
> -Destination is full; expected full
> +Destination is unknown; expected full
> 
> My file system is ext4 inside a virtual machine.
> > [I] febner@dev8 ~/repos/qemu/build/tests/qemu-iotests (master) [1]> findmnt --target .
> > TARGET             SOURCE   FSTYPE OPTIONS
> > /home/febner/repos /dev/sdb ext4   rw,relatime
> 
> The virtual disk is an LVM image. When the test fails, I consistently
> get 20975616 bytes rather than 20971520 bytes as the result of
> disk_usage(), i.e. it has one 4 KiB block more. ls -l will still report
> 20971520 bytes as the length, qemu-img compare succeeds.

Odd, but should be something I can cater to by treating any value >=
20M (rather than exactly 20M) as fully allocated (the test still does
the qemu-img compare to ensure that the actual length compares
correctly, even if the allocated length was slightly overallocated due
to filesystem magic).

> 
> After the image creation, i.e. job1, the allocation is still as expected:
> > +20971520	/home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw
> > +-rw-r--r-- 1 febner febner 20971520 May 21 11:18 /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw
> 
> Only after mirroring, i.e. job2, it will be larger:
> > +20975616	/home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw
> > +-rw-r--r-- 1 febner febner 20971520 May 21 11:18 /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw

Weird, but filesystems have been known to do weird things.  So the
test should be updated to tolerate it.

> 
> Some more information:
> 
> > [I] febner@dev8 ~/repos/qemu/tests/qemu-iotests/tests (master)> sudo filefrag /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw -e
> > Filesystem type is: ef53
> > File size of /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw is 20971520 (5120 blocks of 4096 bytes)
> >  ext:     logical_offset:        physical_offset: length:   expected: flags:
> >    0:        0..      15:   36233216..  36233231:     16:            
> >    1:       16..    2047:   36233232..  36235263:   2032:             unwritten
> >    2:     2048..    2559:   36239360..  36239871:    512:   36235264:
> >    3:     2560..    4095:   36239872..  36241407:   1536:             unwritten
> >    4:     4096..    5119:   33792000..  33793023:   1024:   36241408: last,unwritten,eof
> > /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw: 3 extents found
> 
> Note that one of the offsets is not 4KiB-aligned:
> > 36239360%4096
> > 2048
> 
> I suppose that is the reason?
> 
> > [I] febner@dev8 ~/repos/qemu/tests/qemu-iotests/tests (master)> stat /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw
> >   File: /home/febner/repos/qemu/build/tests/qemu-iotests/scratch/raw-file-mirror-sparse/t.raw
> >   Size: 20971520  	Blocks: 40968      IO Block: 4096   regular file
> > Device: 8,16	Inode: 4866541     Links: 1
> > Access: (0644/-rw-r--r--)  Uid: ( 1000/  febner)   Gid: ( 1000/  febner)
> > Access: 2025-05-21 11:18:37.622692254 +0200
> > Modify: 2025-05-21 11:18:37.540686997 +0200
> > Change: 2025-05-21 11:18:37.540686997 +0200
> >  Birth: 2025-05-21 11:18:37.463682059 +0200
> 
> I also tried it on my host, where the filesystem is ZFS using
> compression, and there, 'du' will already report a lower value after
> creating the image, because of compression. And even without compression
> it seems that preallocation=full on ZFS is somehow async :/
> 
> > [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> qemu-img create my.raw 20M -f raw -o preallocation=full
> > Formatting 'my.raw', fmt=raw size=20971520 preallocation=full
> > [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
> > 512	my.raw
> > [I] febner@enia ~/qemu/build/tests/qemu-iotests (master)> du --block-size=1 my.raw
> > 20980224	my.raw

That one may be a bit harder to work around, but I'll give it a shot
while I'm patching the first one.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


