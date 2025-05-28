Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA2DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 15:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKItC-0000GK-Va; Wed, 28 May 2025 11:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKItA-0000Fy-Ne
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKIt8-0006mc-85
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748446816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IKf1V/zacoq/d0V0xrfU5pS5ODEp4a7a2v+YDxrlRk=;
 b=Uw1Xm6KOQOZI1e6fOotRNvn8RK+WSST3K+IAN041i9PvaiRJx5M5+cCqT1KWp75HT9skzu
 i5jUYwEz/ZaIEUpgmc+vIeXQJLFBmmn6nchz1sHW5uKJt/pz7qAH4ThlsSE7KuxUPiSUe3
 yUzeijImON0amAzmIoIjy2Kul5KrnCQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-IxE9MbPaOw6RHYBoNw4dxg-1; Wed,
 28 May 2025 11:40:14 -0400
X-MC-Unique: IxE9MbPaOw6RHYBoNw4dxg-1
X-Mimecast-MFC-AGG-ID: IxE9MbPaOw6RHYBoNw4dxg_1748446813
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C7141956095; Wed, 28 May 2025 15:40:13 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.48])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99DD618004A7; Wed, 28 May 2025 15:40:10 +0000 (UTC)
Date: Wed, 28 May 2025 10:40:07 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
Message-ID: <5o7qspgmmjktoah6yoq5zp4uemhyultohiswqwvib7dqbh53ez@2ctslprvuxxx>
References: <20250515022904.575509-16-eblake@redhat.com>
 <20250515022904.575509-29-eblake@redhat.com>
 <874ix5ezgy.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ix5ezgy.fsf@pond.sub.org>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On Wed, May 28, 2025 at 01:39:25PM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > Prove that blockdev-mirror can now result in sparse raw destination
> > files, regardless of whether the source is raw or qcow2.  By making
> > this a separate test, it was possible to test effects of individual
> > patches for the various pieces that all have to work together for a
> > sparse mirror to be successful.
> >

> Fails for me:
> 
>     TAP version 13
>     # QEMU          -- "/work/armbru/qemu/bld/qemu-system-x86_64" -nodefaults -display none -accel qtest
>     # QEMU_IMG      -- "/work/armbru/qemu/bld/qemu-img" 
>     # QEMU_IO       -- "/work/armbru/qemu/bld/qemu-io" --cache writeback --aio threads -f qcow2
>     # QEMU_NBD      -- "/work/armbru/qemu/bld/qemu-nbd" 
>     # IMGFMT        -- qcow2
>     # IMGPROTO      -- file
>     # PLATFORM      -- Linux/x86_64 dusky 6.12.7-200.fc41.x86_64
>     # TEST_DIR      -- /work/armbru/qemu/bld-x86/scratch

Which filesystem is TEST_DIR on?

>     # SOCK_DIR      -- /tmp/qemu-iotests-nqettsyq
>     # GDB_OPTIONS   -- 
>     # VALGRIND_QEMU -- 
>     # PRINT_QEMU_OUTPUT -- 
>     # 
>     1..1
>     # running qcow2 mirror-sparse
>     not ok qcow2 mirror-sparse
>     --- /work/armbru/qemu/tests/qemu-iotests/tests/mirror-sparse.out
>     +++ /work/armbru/qemu/bld-x86/scratch/qcow2-file-mirror-sparse/mirror-sparse.out.bad
>     @@ -140,7 +140,7 @@
>      {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
>      {"return": {}}
>      Images are identical.
>     -Destination is sparse; expected sparse
>     +Destination is unknown; expected sparse

> > Looks like the same failure Fiona reported; does this fix it?
> >
> > https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg05567.html
> 
> It does not.

Since my patch for Fiona is not working for you, I will tweak it
slightly to output the actual du output (in addition to "unknown") for
the cases where the size is neither -lt 3M or -gt 19M.  The test is
dealing with a 20M image containing 2M of data, so du reporting
something in between 3 and 19 is unexpected.  Could it be the result
of du reporting smaller numbers on a compressed filesystem?  But even
then, my followup series was trying to filter out any filesystem where
-o preallocation=full of 5M results in a du report of < 4M on the
grounds that it would catch compression artifacts as rendering the
test unreliable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


