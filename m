Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429F8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 06:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGWb5-0006hp-WE; Wed, 05 Nov 2025 01:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGWb3-0006hS-RT
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 01:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGWb1-0007Vi-LY
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 01:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762322533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kKauCUJzYVtBm7uuGDn1t5g4punLzkr3Dsj4cxV28hw=;
 b=iuqPRc2lnryddFVWW7o6R9qC6J63JKWyklFuUsBigJnqaxOtEvLKaD0UwHhHzWOnkWqnRW
 s3NlfrpTpLQjJxJkY3HfBxcpyuDqXngaF84ePk3yCpsKI5F2yQmv5hjiEfwHf7vepMMzPx
 DBKG36AmmhDWuC9M7nYG3LWL1CilA9U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-j9FuNuQwOx2BRgwelb2DLw-1; Wed,
 05 Nov 2025 01:02:12 -0500
X-MC-Unique: j9FuNuQwOx2BRgwelb2DLw-1
X-Mimecast-MFC-AGG-ID: j9FuNuQwOx2BRgwelb2DLw_1762322531
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6000B180049F; Wed,  5 Nov 2025 06:02:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4DF43000198; Wed,  5 Nov 2025 06:02:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2DBB521E6A27; Wed, 05 Nov 2025 07:02:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: MAINTAINERS spring-cleaning
In-Reply-To: <CAFEAcA9oUfFSFXrN+swbCtr4LV+S+-DuUjdP5miGnSbkCt2ZYA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 4 Nov 2025 17:36:47 +0000")
References: <CAFEAcA9oUfFSFXrN+swbCtr4LV+S+-DuUjdP5miGnSbkCt2ZYA@mail.gmail.com>
Date: Wed, 05 Nov 2025 07:02:07 +0100
Message-ID: <87ikfpow4g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> I just did some analysis of our MAINTAINERS file with the aid of a
> local copy of the public-inbox archive of qemu-devel, and (unless my
> scripting is broken ;-)) of the 258 emails listed in MAINTAINERS,
> 50 have not sent an email to qemu-devel in the last three years.
>
> Some of that will be things like "the address somebody uses to send
> to the list is not quite the same as the one they have listed", so
> it will need some manual checking, but I think this shows we could
> use a bit of spring-cleaning of the file to remove stale entries.
>
> I propose to send some (not cc'd the list) emails to these people,
> asking (politely!) if they're still interested in being in the
> MAINTAINERS file, and treating "email bounces", "no" and "no reply
> within a month" as "I'm no longer interested in being cc'd on patches".
> Then we can update the file accordingly.
>
> (This was prompted by a series I sent out earlier today getting
> a load of "address unknown" bounce-mails from a corporate server;
> that's not a particularly rare thing to happen IME. And I also
> have developed a habit of manually curating cc lists to drop
> people I suspect of not actually being involved any more...)

Yes, please!

We talked about the issue of stale MAINTAINERS entries before, mostly
when e-mail bounces get sufficiently annoying for somebody to submit or
ask for a MAINTAINERS correction, but as far as I know it always stopped
at talk.

Ignored e-mail is arguably worse than bouncing e-mail.  50 entries out
of 258 is a lot.

If the cleaning you propose works, we should consider repeating it
regularly, to avoid backsliding.  Annually?


