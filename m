Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF02FC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 07:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTPH-0000vQ-Ac; Thu, 15 May 2025 03:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFTPD-0000o8-LV
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uFTPB-0007Fr-Nf
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747295604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zh4Gnv2GLXV6gJfLIWzjYR7uOEnfCnrUR/UzO4yz8oA=;
 b=MEc0ntaou8wjBTEntWXJvvRKrcPHFZpGAoh3cSLq/exjipCdIxm8m79enN687Xx6/74GYK
 gSwc9anRAbQH83b06+wOagroqHpNRpMbUnyesTXu0URJqwlk1h8X7xPePj4oLzU0/HaFd1
 vyBv5oiDBR7y5Gb31jBb/4oxu0Lc5cQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-XYeNPb7wNCevPGhhS13fiw-1; Thu,
 15 May 2025 03:53:21 -0400
X-MC-Unique: XYeNPb7wNCevPGhhS13fiw-1
X-Mimecast-MFC-AGG-ID: XYeNPb7wNCevPGhhS13fiw_1747295600
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0968195605F; Thu, 15 May 2025 07:53:18 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.242])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AC9719560A7; Thu, 15 May 2025 07:53:15 +0000 (UTC)
Date: Thu, 15 May 2025 09:53:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 07/27] qemu-img: check: refresh options/--help
Message-ID: <aCWdaXsifyf4SxQM@redhat.com>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
 <20240927061121.573271-8-mjt@tls.msk.ru>
 <aCNrThMpezno1o1Z@redhat.com>
 <a5867bf2-fdbc-41ba-802a-e2f9a45c1b1c@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5867bf2-fdbc-41ba-802a-e2f9a45c1b1c@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 15.05.2025 um 08:50 hat Michael Tokarev geschrieben:
> On 13.05.2025 18:54, Kevin Wolf wrote:
> > Am 27.09.2024 um 08:11 hat Michael Tokarev geschrieben:
> 
> > > +            cmd_help(ccmd,
> > > +"[-f FMT | --image-opts] [-T CACHE_MODE] [-r] [-u]\n"
> > > +"        [--output human|json] [--object OBJDEF] FILENAME\n"
> > > +,
> > > +"  -q, --quiet\n"
> > > +"     quiet operations\n"
> > 
> > Let's keep the help text more in line with the terminology used in the
> > man page, even if shorter at times.
> 
> I haven't touched the man page for a reason, - I wasn't sure I
> understood all the options correctly.  And the man pages were the
> next planning step.  Unfortunately it's been quite some time ago
> and I don't remember details anymore.  It can be done either way,
> and I tried to make the whole thing as short as possible in the
> --help output.

Yes, we definitely need to shorten the descriptions from the man page
for --help. I think as long as it fits on a single line, it's okay, but
I understand if you want to keep it even shorter in some cases.

> > I would use the first sentence from it here: "Quiet mode - do not print
> > any output (except errors)"
> 
> Ok.

If this is too wordy for your liking, just "quiet mode" could be enough,
but I would keep the terminology the same (i.e. not "operations" here
and "mode" there").

> > > +"  -f, --format FMT\n"
> > > +"     specifies format of the image explicitly\n"
> > 
> > Maybe "format of the image (default: probing is used)"?
> 
> Yeah, makes sense.
> 
> Not wanting to risk going into an endless wording discussion,
> let's do it this way here and elsewhere.

The nature of your series is that a big part of the review is actually
the new help text, so it's unavoidable to have some wording discussions
here and there. Don't necessarily take my suggestions as the final word,
they are just suggestions on which we can iterate and find the best
wording for users. I think refining help texts is worth some thought and
back and forth between multiple people. So if you don't like my
suggestions, or you prefer a mix of yours and mine, or you have
additional improvements to them, feel free to say so.

Kevin


