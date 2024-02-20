Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEFAC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVFL-0008BG-Sl; Tue, 20 Feb 2024 13:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcVFI-0008Aj-17
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:53:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcVFF-0000X4-8b
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708455212;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZnLo+Sr4Qj9chEFaGJI+AeN9c6NRm+HaarGYAM6zu/Y=;
 b=VSywEImoQcaBye5VSNwvlxcRGnTK3IsShX0PJ/wGHyiwvqZW37X3PysoiRN2/scBn0pfTe
 Q1tmbBFBBiIIP7JFw1b759g+n6GyKKcQciZWtoJLyNprQeQUg3UnCwEaIcnVEyRoQJy5Vs
 P4ofKcCaJLDmlNGA/Kvk03UI6WB0s/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-ba2pyN_6PdSPWz1waJUN5A-1; Tue, 20 Feb 2024 13:53:30 -0500
X-MC-Unique: ba2pyN_6PdSPWz1waJUN5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA039811E81;
 Tue, 20 Feb 2024 18:53:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA4C2166AF1;
 Tue, 20 Feb 2024 18:53:29 +0000 (UTC)
Date: Tue, 20 Feb 2024 18:53:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 00/23] qemu-img: refersh options and --help handling
Message-ID: <ZdT1J4aubpZYt6YP@redhat.com>
References: <cover.1707513011.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1707513011.git.mjt@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Feb 10, 2024 at 12:22:21AM +0300, Michael Tokarev wrote:
> Quite big patchset implementing normal, readable qemu-img --help
> (and qemu-img COMMAND --help) output with readable descriptions,
> and adding many long options in the process.
> 
> In the end I stopped using qemu-img-opts.hx in qemu-img.c, perhaps
> this can be avoided, with only list of commands and their desrciptions
> kept there, but I don't see big advantage here.  The same list should
> be included in docs/tools/qemu-img.rst, - this is not done now.

I think it'd be nice for qemu-img.c to be the canonical source
of truth, so we have the getopt short arg, long args, and
help all in the same place & thus much less likely to get
out of sync.  Thus I like the approach you've taken here
to stop using the .hx file.

As a later work, it wouldn't be too terrible to have a python
script that parses qemu-img.c to look for 'cmd_help(...)' calls
and extra the help text, which could be used to feed into the
qemu-img.rxt man page generation, thus fully eliminating the
.hx file.

> 
> Also each command syntax isn't reflected in the doc for now, because
> I want to give good names for options first, - and there, we've quite
> some inconsistences and questions.  For example, measure --output=OFMT
> -O OFMT, - this is priceless :)  I've no idea why we have this ugly
> --output=json thing, why not have --json? ;)  I gave the desired
> format long name --target-format to avoid clash with --output.
> 
> For rebase, src vs tgt probably should be renamed in local variables
> too, and I'm not even sure I've got the caches right. For caches,
> the thing is inconsistent across commands.
> 
> For compare, I used --a-format/--b-format (for -f/-F), - this can
> be made --souce-format and --target-format, to compare source (file1)
> with target (file2).
> 
> For bitmap, things are scary, I'm not sure what -b SRC_FILENAME
> really means, - for now I gave it --source option, but this does
> not make it more clear, suggestions welcome.
> 
> There are many other inconsistencies, I can't fix them all in one
> go.. :)

This is already a massive improvement on the status quo. My
comments were mostly around whitespace/layout tweaks to the
help output.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


