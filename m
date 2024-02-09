Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B475EC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOYL-0007Q5-VV; Fri, 09 Feb 2024 05:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rYOYI-0007PR-9Z
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:56:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rYOYE-0008FF-2B
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707476168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hYHNIN++QP+0dssdbwumSET1rx79nnruzD8IvNIj4sM=;
 b=iDd6XxxsSXj6oSyriyLtSuTZmI0x/3Su/wItlHxwuqw5d0HLoEEaNEgV9mLjaM14sIh2N2
 kRsIAmz0Wiypq9JC6GViWK9O2bA3T4+nQTOiKRdV7e2516b+c53nLNFhzW9eTx8QWTHAJk
 btqzemgzAk/i2bT/yZWsC708vhqL3o4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-aW7mfNVyOwmt2u5PIlpLPg-1; Fri,
 09 Feb 2024 05:56:05 -0500
X-MC-Unique: aW7mfNVyOwmt2u5PIlpLPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C410A1C0BA4F;
 Fri,  9 Feb 2024 10:56:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BE712166B31;
 Fri,  9 Feb 2024 10:56:04 +0000 (UTC)
Date: Fri, 9 Feb 2024 11:56:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [RFC/INCOMPLETE PATCH 0/8] Attempt to make qemu-img options
 consistent and --help working
Message-ID: <ZcYEw8pyqF2AB6Pz@redhat.com>
References: <cover.1707328606.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707328606.git.mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 07.02.2024 um 18:58 hat Michael Tokarev geschrieben:
> This is an incomplete first attempt only, there's a lot left to do.
> 
> All the options in qemu-img is a complete mess, - no, inconsistent or
> incomplete syntax in documentation, many undocumented options, option
> names are used inconsistently and differently for different commands,
> no long options exists for many short options, --help output is a huge
> mess by its own, and the way how it all is generated is another story.
> docs/tools/qemu-img.rst with qemu-img-opts.hx is yet another.
> 
> I hoped to fix just an option or two, but it ended up in a large task,
> and I need some help and discussion, hence the RFC.
> 
> The idea is:
> 
>  - create more or less consistent set of options between different
>    subcommands
>  - provide long options which can be used without figuring out which
>    -T/-t, -f|-F|-O etc to use for which of the two images given
>  - have qemu-img --help provide just a list of subcommands
>  - have qemu-img COMMAND --help to describe just this subcommand

The help desperately needs some cleanup like this, so thank you for
doing something about it.

>  - get rid of qemu-img-opts.hx, instead finish documentation in
>    qemu-img.rst based on the actual options implemented in
>    qemu-img.c.

You mean qemu-img-cmds.hx? The one advantage it has is that it makes it
obvious if there is a mismatch in the options we show in the help output
and in the documentation.

But I'm not overly concerned either way. I would probably have left it
alone just because leaving it is less work than changing it and the
result isn't very different.

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

I think it's better not to touch things like this. qemu-img is much more
likely to be used directly by human users (and their small scripts) than
QEMU itself, so we need to be even more careful with deprecating things.

In fact, I'm not even sure if combining them would make it easier to
use. Often, it's only source _or_ target that have a complicated setup
that requires blockdev-type descriptions. As a human user, I prefer if I
can still just use the file name for the other image instead of getting
the full -blockdev verbosity there, too.

>  o For conversion (convert, dd, etc), we've source and destination,
>    so it's easy to distinguish using long options, like --source-format
>    --target-cache etc (-t/-T -f/-F is a mess here already).  What to
>    do with compare? --format1 --format2 is ugly, maybe --a-format and
>    --b-format?  Maybe we can get off with --source (a) and --target (b)
>    instead of filename1 & filename2?
>    (--cache in this context is global for both).

For those commands where there is a source and a target, --source-format
and --target-format have a clear advantage, they are easy to remember
and hard to confuse.

For compare, as you saw, there is no clear naming. 1/2 or a/b don't make
the command any clearer than -f/-F. So maybe just don't add long
versions there?

>  o qemu-img convert.  It's the most messy one, and it is not really
>    documented (nor in qemu-img.rst , eg there's nothing in there about
>    FILENAME2, -B is difficult to understand, etc).
>    At the very least, I'd say the options should be
>     --source-format, --source-cache etc
>     --target-format, --target-options

These seem obvious. (Actually, --target-options vs. just --options isn't
completely obvious - after all, there are fundamentally no create
options for source.)

--source-* are also a bit weird because 'qemu-img convert' takes
multiple source images and then it applies the same format to all of
them. But that's more about how it works, so not a problem with the
option _name_.

>     --target-image-opts - this shold go IMHO

This one less so. Even generally speaking, changing interfaces
incompatibly comes with a cost that is probably too big to justify it
just for interfaces that look a bit nicer, but don't provide any new
functionality.

And as I said above, I don't agree that image-opts should be global.

>  o check and commit - inconsistent cache flags?
>    In convert, cache is backwards (source/target)?

It's a bit messy because the cache mode options -T/-t work the opposite
way of -f/-F. But I think the commands are consistent with each other?

-T was added as a source cache parameter to all of the subcommands at
the same time, in commit 40055951a.

> At first, I tried to have more or less common option descriptions,
> using various parameters, variables or #defines, but in different
> commands the same options has slightly different wording, and in
> some option names are different, so it looks like it's best to
> have complete text in each subcommand.

Yeah, let's not make this more complicated than it has to be.

Kevin


