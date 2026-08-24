Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E33FC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyURI-0008Tv-Oa; Mon, 24 Aug 2026 09:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyURB-0008NQ-FA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUR8-0002WH-CR
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787576998;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ok8Z4qME9fWVOsbha6aEpq2As5kDOpXIGGrv9gyFhP4=;
 b=F/5ImYWrXpRFCHyKaXrBiKpE9KjduIureORKA7jEXB/kDFCdwBXDMspjeWJqHTFMmeJVO+
 9lwmC+eTMIsWg5+WhclevpfJwKFoXFb0yfv7RhBbianLTIAGK1290px4UBlKwOBM3Wh6Rq
 fO1hlSeLbqCsc+ASATWa8l9UOAAd6K0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-5ZF-HXbROJCKZv6bnMF5tA-1; Mon,
 24 Aug 2026 09:09:55 -0400
X-MC-Unique: 5ZF-HXbROJCKZv6bnMF5tA-1
X-Mimecast-MFC-AGG-ID: 5ZF-HXbROJCKZv6bnMF5tA_1787576994
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09A3C19541B1; Mon, 24 Aug 2026 13:09:54 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D396B434; Mon, 24 Aug 2026 13:09:52 +0000 (UTC)
Date: Mon, 24 Aug 2026 14:09:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Lucas Kornicki <lucas.kornicki@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] ui/vnc: notify client of clipboard peer status
Message-ID: <aoxCnWc9SOwYOhEK@redhat.com>
References: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
 <20260818121413.2660786-5-lucas.kornicki@nutanix.com>
 <CAJ+F1CKuDAzTz2iC+acOKf2j1vW3iFE6jinTKL=AwWCu3-1KGg@mail.gmail.com>
 <43d32e1c-ae73-4863-87a5-98c2f6ee5fe0@nutanix.com>
 <CAJ+F1CL_Z2C_k5_40VT9P6t80Z56YBObQ1fiQpW3t_nO0h1JWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CL_Z2C_k5_40VT9P6t80Z56YBObQ1fiQpW3t_nO0h1JWg@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Aug 24, 2026 at 04:36:12PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Aug 18, 2026 at 5:56 PM Lucas Kornicki
> <lucas.kornicki@nutanix.com> wrote:
> >
> > Hi Marc-Andre
> >
> > I quickly became aware of the shortcomings of my v1 series and I've
> > already drafted a v2 where the cover is a bit more detailed and the
> > commits were fixed to remove the Change-IDs.
> >
> > On 8/18/26 15:33, Marc-André Lureau wrote:
> > > !-------------------------------------------------------------------|
> > >    CAUTION: External Email
> > >
> > > |-------------------------------------------------------------------!
> > >
> > > Hi Lukasz
> > >
> > > On Tue, Aug 18, 2026 at 4:15 PM Lukasz Kornicki
> > > <lucas.kornicki@nutanix.com> wrote:
> > >> Introduce a new vnc message (VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS) and
> > >> the corresponding feature/encoding.
> > >>
> > >> When a client requests this feature, the server will inform the client
> > >> whether a guest clipboard peer is present. The server will repeat the
> > >> notification each time availability of a guest clipboard peer changes.
> > >>
> > >> This change enables the VNC client to determine if a guest side
> > >> clipboard peer is available for clipboard exchange and react to
> > >> changes of its availability.
> > >>
> > >> Until now the VNC clipboard peer was only registered when
> > >> VNC_FEATURE_CLIPBOARD_EXT was enabled. With this change the VNC peer
> > >> can be registered just for the purpose of receiving peer status
> > >> updates. This requires introducing a VNC_FEATURE_CLIPBOARD_EXT guard
> > >> before the QEMU_CLIPBOARD_UPDATE_INFO handler which previously only ran
> > >> if VNC_FEATURE_CLIPBOARD_EXT was enabled.
> > >>
> > > The series looks good, but this extension is not documented afaict.
> > > Can you make a PR for it?
> >
> > Sure. I've found this repo before but was not aware that it functions in
> > any official capacity.
> 
> I dont think we should take the change until the rfbproto documents it.

Yes, please submit an rfbproto  PR for the extension, as we've tried
to ensure everything QEMU implements is specified there to aid in
future interoperability and to spot design mistakes at spec time.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


