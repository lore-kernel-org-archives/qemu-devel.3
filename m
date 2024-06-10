Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC12C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 12:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGeIz-0005Ch-RI; Mon, 10 Jun 2024 08:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sGeIy-0005CF-AX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sGeIw-0000fe-Q8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718023157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBPK4F5CjF1DWwl/rsR+grgL9QeoUPI6WUcr5GqRwXA=;
 b=WVeOxSqPoDKIy8pSQgjO0dXOYd9sFjtwB2yeupLg6GCT823GooSMcx6kmJbcdyhhRyvLAV
 Oowk6S7PzzQ/rCxbcPnMcU+OfnDaKkGQ7VpWKyTQie0yRhSrqqrVw1gOSC00lOZH4aLVs0
 lT6Jp80rBIBN1uzve7x4JWyGkdAGhb0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-cIMdhaOjOi6kwQORZqyAbA-1; Mon,
 10 Jun 2024 08:39:14 -0400
X-MC-Unique: cIMdhaOjOi6kwQORZqyAbA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CF6D1955EF2; Mon, 10 Jun 2024 12:39:03 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F1771956050; Mon, 10 Jun 2024 12:39:01 +0000 (UTC)
Date: Mon, 10 Jun 2024 07:38:59 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [Stable-7.2.12 00/29] Patch Round-up for stable 7.2.12, frozen
 at 2024-06-07
Message-ID: <27cmgqpd7n3gbsvenoal44xwsbg6eldftepplye42qpswkqbyk@fa4wvmnslzhi>
References: <qemu-stable-7.2.12-20240607221018@cover.tls.msk.ru>
 <l6jbovskcivkkog7lkvazwn4f4vqflbilgo63lfgwecunsb4al@iak6kurhbl57>
 <9338d9f7-7aa4-44a2-853c-42b07fe115c2@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9338d9f7-7aa4-44a2-853c-42b07fe115c2@tls.msk.ru>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 10, 2024 at 03:20:53PM GMT, Michael Tokarev wrote:
> 10.06.2024 15:17, Eric Blake wrote:
> > > 01* 690ceb71936f Philippe Mathieu-Daudé:
> > >     gitlab-ci: Remove job building EDK2 firmware binaries
> > > 02* 7bc1286b81d4 Palmer Dabbelt:
> > >     gitlab/opensbi: Move to docker:stable
> > > 03* 04f6fb897a5a Michael Tokarev:
> > >     linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
> > > 04* ae6d91a7e9b7 Zhu Yangyang:
> > >     nbd/server: do not poll within a coroutine context
> > > 05* 4fa333e08dd9 Eric Blake:
> > >     nbd/server: Mark negotiation functions as coroutine_fn
> > 
> > In addition to these two, we also need the following for NBD:
> > 
> >   14ddea7e3c81 Eric Blake:
> >    qio: Inherit follow_coroutine_ctx across TLS
> 
> Does it need to be in 7.2.12, or can it wait for the next, 7.2.13, release?
> 
> I tagged 7.2.12 yesterday already.  So if this change is also needed, I guess
> we can make 7.2.13 release sooner than later.
> 
> Thank you for letting me know!

See my other response; but I just searched 'git log
v7.2.0..origin/stable-7.2', and do not see any mention of 06e0f098
being backported, therefore the trigger is not there and the qio patch
is not needed.  So it looks there is no need for an immediate 7.2.13,
at least from my end.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


