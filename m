Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E06C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLQn-0007Xc-Bp; Wed, 28 May 2025 14:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKLQj-0007X6-JN
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKLQh-0005i3-ST
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748456586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmckFwHgfrlLhKfB7sD4v2M/3/Cjr9OK97yDuuaUjsg=;
 b=H9FYnJMLSxjSw+rajdzJ7lIR8tlypB44HGGNXtmDutwCqVs83REK/3Ef/jXbeW1vkyYyjO
 tB9a6dyUZ1dLWDxqgAWlD26RJ0sINu3Hoi9QM769feUx03sthIEhj65IJb5i1TzIuuOzrk
 zz4wHzWIAcDQG7U8Ao2wNh+qgGVOH9E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-vcsT7_eSPgSXu78wWowNSw-1; Wed,
 28 May 2025 14:23:03 -0400
X-MC-Unique: vcsT7_eSPgSXu78wWowNSw-1
X-Mimecast-MFC-AGG-ID: vcsT7_eSPgSXu78wWowNSw_1748456582
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D2371800370; Wed, 28 May 2025 18:23:02 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F2A11944B05; Wed, 28 May 2025 18:22:59 +0000 (UTC)
Date: Wed, 28 May 2025 13:22:57 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
Message-ID: <ymewf4jzcd2vec4vtlbvtfrq5sj3zbvcddismo46woobwhm2cr@hkboigbkw6uu>
References: <20250515022904.575509-16-eblake@redhat.com>
 <20250515022904.575509-29-eblake@redhat.com>
 <874ix5ezgy.fsf@pond.sub.org>
 <5o7qspgmmjktoah6yoq5zp4uemhyultohiswqwvib7dqbh53ez@2ctslprvuxxx>
 <87plfsya8x.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plfsya8x.fsf@pond.sub.org>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, MONEY_NOHTML=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, May 28, 2025 at 06:23:58PM +0200, Markus Armbruster wrote:
> >>     # TEST_DIR      -- /work/armbru/qemu/bld-x86/scratch
> >
> > Which filesystem is TEST_DIR on?
> 
> $ findmnt --target /work/armbru/qemu/bld-x86/scratch
> TARGET SOURCE                                     FSTYPE OPTIONS
> /work  /dev/mapper/luks-898519e7-f64e-4a69-8cf9-8532063d8bb9
>                                                   xfs    rw,relatime,seclabel,at

Thanks; I installed a temporary xfs system (a bit easier to do on
Fedora than zfs), with my tweak to show actual du output, and see:

-Destination is sparse; expected sparse
+Destination is unexpected size (3145728); expected sparse

which is exactly at the 3M cutoff.  In fact:

$ findmnt --target /mnt/sysroot/
TARGET  SOURCE            FSTYPE OPTIONS
/mnt/sysroot
        /dev/mapper/my--vg-temp
                          xfs    rw,relatime,seclabel,attr2,inode64,logbufs=8,lo
$ qemu-img create -f raw /mnt/sysroot/dir/src.img 20M
Formatting '/mnt/sysroot/dir/src.img', fmt=raw size=20971520
$ qemu-io -c 'w 8M 2M' -f raw /mnt/sysroot/dir/src.img
wrote 2097152/2097152 bytes at offset 8388608
2 MiB, 1 ops; 00.00 sec (704.781 MiB/sec and 352.3905 ops/sec)
$ qemu-img map --output=json  -f raw '/mnt/sysroot/dir/src.img'
[{ "start": 0, "length": 4096, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 0},
{ "start": 4096, "length": 8384512, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 4096},
{ "start": 8388608, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": 8388608},
{ "start": 10485760, "length": 10485760, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": 10485760}]
$ du --block-size=1 /mnt/sysroot/dir/src.img
3145728	/mnt/sysroot/dir/src.img

So, even though SEEK_HOLE was able to show 4k data at the head + 2M
data at the 8M offset (matching how the file was built), du reports
3702 * 1k sectors or exactly 3M of disk usage.

On the bright side, it's an easy fix: either s/-lt/-le/ or s/3/4/ in
mirror-sparse for the bound of what forms a sparse file (we can easily
explain how even though less than 3M is reported as a hole, disk usage
can plausibly round its answers up and list every megabyte of content
that contains at least some data, while still being an "accurate"
measure of how sparse the file is).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


