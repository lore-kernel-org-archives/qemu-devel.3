Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41204C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 10:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM2fN-0002TG-4n; Mon, 02 Jun 2025 06:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uM2fK-0002Sq-VC
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uM2fH-0008Rl-H3
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748861108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VRkFt/Vqaf6PRspXQ1d6Nb49zqxItZ5ukRiCrhHxy1k=;
 b=LKRQYSFkKuvxrwY87dT/0u8jrP7FqpORwNtcmMW1Ih3eWxFWVmR/1kxN4Re4GekvVqYSg8
 zFeoI4f2j7I1c30RkhasYrzi1Uk/QPMc6zIe5lE0iPJh7z/En0r18dYXMp5cOyJ570oKiq
 H0e3xVZTiAvRwflrhnaZNPDfqF+RsJ8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-2RO3YRGRO-ywWD_rn4-Uig-1; Mon,
 02 Jun 2025 06:45:05 -0400
X-MC-Unique: 2RO3YRGRO-ywWD_rn4-Uig-1
X-Mimecast-MFC-AGG-ID: 2RO3YRGRO-ywWD_rn4-Uig_1748861104
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E75F81955DB3; Mon,  2 Jun 2025 10:45:02 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.243])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79DE9180049D; Mon,  2 Jun 2025 10:45:00 +0000 (UTC)
Date: Mon, 2 Jun 2025 12:44:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 07/27] qemu-img: check: refresh options/--help
Message-ID: <aD2AqX5djiFuhdgP@redhat.com>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
 <20240927061121.573271-8-mjt@tls.msk.ru>
 <aCNrThMpezno1o1Z@redhat.com>
 <09003bdd-8d2c-4f75-80e4-1ca812ba0bdf@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09003bdd-8d2c-4f75-80e4-1ca812ba0bdf@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 31.05.2025 um 18:51 hat Michael Tokarev geschrieben:
> On 13.05.2025 18:54, Kevin Wolf wrote:
> > Am 27.09.2024 um 08:11 hat Michael Tokarev geschrieben:
> > > Add missing long options and --help output.
> ...
> > > +"  --image-opts\n"
> > > +"     indicates that FILENAME is a complete image specification\n"
> > > +"     instead of a file name (incompatible with --format)\n"
> > 
> > The man page has:
> > 
> >    Indicates that the source *FILENAME* parameter is to be interpreted as a
> >    full option string, not a plain filename. This parameter is mutually
> >    exclusive with the *-f* parameter.
> > 
> > A possible adaptation for qemu-img check specially:
> > 
> >    indicates that FILENAME is a full option string, not a plain filename
> >    (incompatible with --format)
> 
> What I ended up now is:
> 
>   --image-opts
>      treat FILE as an option string (key=value,..), not a file name
>      (incompatible with -f|--format)

That's better, I like it.

I'm not sure if we really need to have both short and long name for
incomatible options, but I don't mind either way as long as we're
consistent with it.

> Note I used short "FILE" everywhere, while in the manpage we see
> longer FILENAME - my plan is to get the manpage to use the same
> FILE too, in the next step (I can probably do it together with
> each individual commit in this series too).
> 
> Maybe it's better to use IMAGE instead of FILE, because:
> 
>   FILE
>      name of the image file, or an option string (key=value,..)
>      with --image-opts, to operate on
> 
> (this is another common idiom I used in all the changes).

I think FILE is clear enough, but I wouldn't object to IMAGE either.

> > > +"  --object OBJDEF\n"
> > > +"     QEMU user-creatable object (eg encryption key)\n"
> > 
> > "e.g."
> 
> it is also different from the manpage (where OBJECTDEF is used).
> I ended up with just:
> 
>   --object OBJDEF
>      defines QEMU user-creatable object
> 
> Since --object can be used with any command, maybe it's a good
> idea to have it in common options string, before a subcommand.

That is an interesting idea. But wouldn't we need to keep the existing
code anyway for compatibility? I don't think we have code so far for
options that can be used both before and after the subcommand name.

Kevin


