Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0B0C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmMW-0002Lk-Su; Wed, 07 Feb 2024 13:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXmMV-0002Jn-CU
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:09:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXmMR-0005vG-CT
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707329365;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trnJhRVUZyaGd/s5n18vTEdyW5bFb3V+hVw56AdJVis=;
 b=N07woZc0re/oJVHTBGvpNSatmzPui6IGnuk0c6Ah2vbrtkPo8+SxQvi6ELSDNfklOo040W
 Tur56SVE+YjfcNBLkqBEMoinAdx2qJ4PwFeywFYGvzVySIqNddZYtAoL8ugV3OpTFABMZ4
 ByJLbuJUHjwJKf5qF3LU40joQcxRH9o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-CEdWug8jO1iTvZmXhBuoXg-1; Wed, 07 Feb 2024 13:09:21 -0500
X-MC-Unique: CEdWug8jO1iTvZmXhBuoXg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87C7083B821;
 Wed,  7 Feb 2024 18:09:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04DBB492BF0;
 Wed,  7 Feb 2024 18:09:20 +0000 (UTC)
Date: Wed, 7 Feb 2024 18:09:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [RFC/INCOMPLETE PATCH 0/8] Attempt to make qemu-img options
 consistent and --help working
Message-ID: <ZcPHQIt8cz2ZxIvT@redhat.com>
References: <cover.1707328606.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1707328606.git.mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 07, 2024 at 08:58:09PM +0300, Michael Tokarev wrote:

>  - create more or less consistent set of options between different
>    subcommands
>  - provide long options which can be used without figuring out which
>    -T/-t, -f|-F|-O etc to use for which of the two images given
>  - have qemu-img --help provide just a list of subcommands
>  - have qemu-img COMMAND --help to describe just this subcommand
>  - get rid of qemu-img-opts.hx, instead finish documentation in
>    qemu-img.rst based on the actual options implemented in
>    qemu-img.c.

Yes, yes, yes, yes & more yes :-)

I cry every time I have to read the qemu-img --help output,
and I'm not much of a fan of the man page either to be fair,
as I don't like the global list of options at the top which
is divorced from which commands actually use them.

These days I see many programs with subcommands switching to
a separate man page per sub-command. Still, I'm not asking
you todo that too, its just an idea for the gallery.

> I started converting subcommands one by one, providing long options
> and --help output.  And immediately faced some questions which needs
> wider discussion.
> 
>  o We have --image-opts and --target-image-opts.  Do we really need both?
>    In my view, --image-opts should be sort of global, turning *all*
>    filenames on this command line into complete image specifications,
>    there's no need to have separate image-opts and --target-image-opts.
>    Don't know what to do wrt compatibility though.  It shouldn't be made
>    this way from the beginning.  As a possible solution, introduce a new
>    option and deprecate current set.

This is basically a crutch for incomplete conversion of the block
layer APIs, which meant we had a situation where we wanted to use
image opts syntax for the source, but were unable todo so for
the target:

  commit 305b4c60f200ee8e6267ac75f3f5b5d09fda1079
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Mon May 15 17:47:11 2017 +0100

    qemu-img: introduce --target-image-opts for 'convert' command
    
    The '--image-opts' flag indicates whether the source filename
    includes options. The target filename has to remain in the
    plain filename format though, since it needs to be passed to
    bdrv_create().  When using --skip-create though, it would be
    possible to use image-opts syntax. This adds --target-image-opts
    to indicate that the target filename includes options. Currently
    this mandates use of the --skip-create flag too.

we do have internal support for creating block devices using
the full QAPI schema, via BlockdevCreateOptions.

I'm not sure if bdrv_create can be made to create using the
image-opts syntax. If it can, there is still the additional
problem that after creation it then needs to re-open the
file, and the image-opts for open is defined by BlockdevOptions
not BlockdevCreateOptions. So we would need a way to convert
from the latter to the former.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


