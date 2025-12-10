Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A75D3C928
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 16:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTNSr-0006G5-TK; Wed, 10 Dec 2025 11:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTNSp-0006Fg-VI
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:54:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTNSn-0008Bi-E8
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765385690;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FusV5pkrbjy8J4fYQ81Jd5hTilUD2ATjfZj5RqT6wmc=;
 b=eItmfnryom9m7vn9ORrjA34jmyXQwRHNhmIvj/p/ISuza3knR+IKgoRsomxaGvokrK80bN
 1o1EIfTXMBf7wOl1/Az4MAerhTHNeVpShzvFSyC4Em/QSfbu5UB6yj+hlyn113T915EXGH
 vzguEgdZ03eRt+t64ImOd9mh1ozWzVw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-sdiC_t4oO1qyHtL4K_mCmQ-1; Wed,
 10 Dec 2025 11:54:45 -0500
X-MC-Unique: sdiC_t4oO1qyHtL4K_mCmQ-1
X-Mimecast-MFC-AGG-ID: sdiC_t4oO1qyHtL4K_mCmQ_1765385684
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D491219560B2; Wed, 10 Dec 2025 16:54:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8125D30001A5; Wed, 10 Dec 2025 16:54:41 +0000 (UTC)
Date: Wed, 10 Dec 2025 16:54:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, Peter Maydell <peter.maydell@linaro.org>,
 Vishnu Pajjuri OS <vishnu@os.amperecomputing.com>,
 Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
Subject: Re: FWD: [ATTENTION] Mails on qemu mailing list are disapapearing
 making communication unreliable
Message-ID: <aTmlzlAWK8BcGaEp@redhat.com>
References: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.gmail.com>
 <20251209022028-mutt-send-email-mst@kernel.org>
 <aTfpQO14axEvcOIT@redhat.com>
 <CAJ7pxeYbd+yq9VXob2zTShBd5Ph598kmjLJTsKdKzFikCbVLLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ7pxeYbd+yq9VXob2zTShBd5Ph598kmjLJTsKdKzFikCbVLLA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 SUBJ_ATTENTION=0.5 autolearn=no autolearn_force=no
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

On Wed, Dec 10, 2025 at 01:20:26AM +0000, Salil Mehta wrote:
> Hi Daniel & Michael,
> 
> Many thanks for replying.
> 
> On Tue, Dec 9, 2025 at 9:18 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Dec 09, 2025 at 02:24:44AM -0500, Michael S. Tsirkin wrote:
> > > Hi guys,
> > > who has ability to contact the list admins? Can help Salil?
> >
> > I'm not a list admin, but I have some observations below
> >
> > > ----- Forwarded message from Salil Mehta <salil.mehta@opnsrc.net> -----
> > >
> > > From: Salil Mehta <salil.mehta@opnsrc.net>
> > > Date: Tue, 9 Dec 2025 00:44:04 +0000
> > > To: "Michael S. Tsirkin" <mst@redhat.com>
> > > Subject: [ATTENTION] Mails on qemu mailing list are disapapearing making communication unreliable
> > > Message-ID: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.gmail.com>
> > >
> > > Hi Michael,
> > >
> > > I hope you are doing well.
> > >
> > > I’ve noticed that some emails are going missing from the qemu-devel mailing
> > > list. This has now happened multiple times, both with emails I have sent from my
> > > official address and with emails from other contributors.
> > >
> > > Over the past three months, I have consistently observed emails disappearing
> > > from the qemu-devel archives, which makes the mailing list communication highly
> > > unreliable.
> >
> > I can see patches arriving in my INBOX via qemu-devel from salil.mehta@opnsrc.net
> > but no patches from salil.mehta@huawei.com
> >
> > I do see some (non-patch) emails from salil.mehta@huawei.com, but the
> > mailing list is re-writing this From address for DMARC countermeasures
> >
> >  Salil Mehta via <qemu-devel@nongnu.org>
> >
> >
> > Recapping mail delivery policies, DMARC requires a pass for *either*
> > SPF or DKIM checks.
> >
> > SPF checks will always fail for mails forwarded via any mailing list.
> >
> > DKIM checks should still succeed *provided* the mailing list does not
> > modify the message content, or certain headers. QEMU mailing list
> > behaves in this respect generally, and applies countermeasures when
> > appropriate.
> >
> > I see no  DKIM records huawei.com, but I do see SPF records.
> 
> 
> Thanks for identifying this.
> 
> When you say there are no DKIM records for huawei.com, do you mean
> that my @huawei.com mails do not contain any DKIM-Signature header,
> or that a DKIM-Signature is present but cannot be validated against
> a published key?

I see no DKIM-Signature, and not DKIM DNS records with the
default selector.

> If there are SPF/DKIM/DMARC logs on the list side, would it be
> possible to see whether DKIM validation is failing for my messages?

We have no access to anything in the mailman service - we're just
using the nongnu.org service for QEMU, run by the GNU project.

> > This guarantees DMARC fail for any @huawei.com sender using any mailing
> > list, however, the @huawei.com DMARC policy is only set to 'quarantine'.
> 
> Agreed. I will check with the IT department here about the DKIM
> headers and whether the public key is being published correctly.

I should have checked before, but I see there are other people
using @huawei.com email addresses that are posting to qemu-devel
successfully.

That seems to suggest that the huawei mail is able to work with
QEMU lists and nothing about SPF/DKIM/DMARC is a blocking problem

> > I wonder how Salil is sending patches ? Some tool like git send-email
> > or git-publish ?
> 
> Mails disappear or not appear in the mailing list even when I reply
> via outlook and the same happens when I sometimes use git-send-mail.
> 
> check these:
> https://lore.kernel.org/qemu-devel/20251001010127.3092631-1-salil.mehta@opnsrc.net/
> 
> AND
> 
> https://lore.kernel.org/qemu-devel/CAJ7pxea721f4EwqpDdcztgRoN-rsB2tqthf-_Kb+mmsRkK1GyQ@mail.gmail.com/
> 
> I'm replying to this broken link which existed but disappeared later.
>  [not found] <20250930224037.224833-1-salil.mehta@huawei.com>


> > If not, perhaps that is triggering some rule that discards the mails when
> > sending is amperemail.onmicrosoft.com
> 
> Could be. Do we have access to the logs to verify the reason?

Unfortunately we have no insight into operation of the mailman service
as that's not run by QEMU.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


