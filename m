Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E428AC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpjD-00053F-J8; Wed, 21 Feb 2024 11:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcpj6-0004zx-Pj
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcpiz-0007un-Th
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708533933;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8l6jeAgrYwbIXxonr/hAqL+fF2GHRwfN+uXuQ5h75a0=;
 b=cHdPqNDCyPoDi7IW0+2W3gSoQUKdQXjLvOML10qf85Xgg+aHzhPgdBhkhY4repDmdJ9vvF
 U/Cd28mgrcc6GprjYZWB7BLuwaQ/XjoX66dkr279w3zVb+vikRmup0iOekGa+Z/XlQX4+I
 OuOGQR13cdUWAIbzTxzDaIklxXjh3v4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-bZCOIyr4OMyZ4GHrytUZdA-1; Wed, 21 Feb 2024 11:45:28 -0500
X-MC-Unique: bZCOIyr4OMyZ4GHrytUZdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C73F85A5BB;
 Wed, 21 Feb 2024 16:45:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DE5F2026D06;
 Wed, 21 Feb 2024 16:45:09 +0000 (UTC)
Date: Wed, 21 Feb 2024 16:45:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 23/23] qemu-img: inline list of supported commands,
 remove qemu-img-cmds.h include
Message-ID: <ZdYok4eMWqU4WkdN@redhat.com>
References: <cover.1707513011.git.mjt@tls.msk.ru>
 <a7e67594e748d1b91f755dd971f222afa09f5443.1707513012.git.mjt@tls.msk.ru>
 <ZdT0A3b9-JrMd6aI@redhat.com>
 <edcdc77e-48f6-4bfd-ae0c-d8c72cd1c6b8@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edcdc77e-48f6-4bfd-ae0c-d8c72cd1c6b8@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 21, 2024 at 07:31:42PM +0300, Michael Tokarev wrote:
> 20.02.2024 21:48, Daniel P. Berrangé:
> 
> > This ends up looking a bit muddled together. I don't think we
> > need repeat 'qemu-img <cmd>' twice, and could add a little
> > more whitespace
> > 
> > eg instead of:
> > 
> > $ ./build/qemu-img check --help
> > qemu-img check: Check basic image integrity.  Usage:
> > qemu-img check [-f FMT | --image-opts] [-T CACHE_MODE] [-r] [-u]
> >          [--output human|json] [--object OBJDEF] FILENAME
> > Arguments:
> > ...snip...
> > 
> > have it look like
> > 
> > $ ./build/qemu-img check --help
> > Check basic image integrity.
> > 
> > Usage:
> > 
> >    qemu-img check [-f FMT | --image-opts] [-T CACHE_MODE] [-r] [-u]
> >          [--output human|json] [--object OBJDEF] FILENAME
> > 
> > Arguments:
> > ...snip...
> 
> Here's the current way how `create' help text looks like:
> 
> $ ./qemu-img create --help
> Create and format qemu image file.  Usage:
>   qemu-img create [-f FMT] [-o FMT_OPTS] [-b BACKING_FILENAME [-F BACKING_FMT]]
>         [--object OBJDEF] [-u] FILENAME [SIZE[bkKMGTPE]]
> Arguments:
>   -h, --help
>      print this help and exit
>   -q, --quiet
>      quiet operations
>   -f, --format FMT
>      specifies format of the new image, default is raw
>   -o, --options FMT_OPTS
>      format-specific options ('-o list' for list)
>   -b, --backing BACKING_FILENAME
>      stack new image on top of BACKING_FILENAME
>      (for formats which support stacking)
>   -F, --backing-format BACKING_FMT
>      specify format of BACKING_FILENAME
>   -u, --backing-unsafe
>      do not fail if BACKING_FMT can not be read
>   --object OBJDEF
>      QEMU user-creatable object (eg encryption key)
>   FILENAME
>      image file to create.  It will be overridden if exists
>   SIZE
>      image size with optional suffix (multiplies in 1024)
>      SIZE is required unless BACKING_IMG is specified,
>      in which case it will be the same as size of BACKING_IMG
> 
> Maybe it's a good idea to add newlines around the "syntax" part,
> ie, after "Usage:" and before "Arguments:".  I don't think it needs
> extra newlines between each argument description though, - this way
> it becomes just too long.
> 
> What do you think?

I still prefer to have more vertical whitespace, as I find it harder
to read through without it. I was using the typical man page option
/ usage formatting as a guide in my feedback.

Still, it would be useful to see what other maintainers think, as I'm
just one data point.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


