Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4AAC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 03:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcdA8-0006OF-Lr; Tue, 20 Feb 2024 22:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcdA6-0006O1-Mv
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 22:20:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcd9r-0002XF-Fr
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 22:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708485629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BlwXI/1W9CVTIrNCWqbpWpQEja6QrFf54CcS3jqWTaI=;
 b=YdJrlo60GecrY681K3klJdgobGW9KwgmbJIUms9hmCaG6Fpx86cBhKg/kUZfrQohwTnFR5
 /bFmfl4Dt4gGr2IKjqrX6MvGxCvileAQXPuQbzrZ+r3RWOxgX/pF8iBNfWn/L2qfMat/KU
 kpxv36O2Bf8Kw0h9zn3hjYgGjvasu8o=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-cphKxE2UPKKLQoWJdrlIPw-1; Tue, 20 Feb 2024 22:20:27 -0500
X-MC-Unique: cphKxE2UPKKLQoWJdrlIPw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6e482286cf7so293377b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 19:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708485625; x=1709090425;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlwXI/1W9CVTIrNCWqbpWpQEja6QrFf54CcS3jqWTaI=;
 b=Iz/aFkFBxT/Js8DgSMvhLVvSdbmkotOcPOSVxpp+hdLDtXSq+gO630EpSdvdwER00n
 iVnrrKXQQMDUSA80hBGRexkwqRwNgUKvnDBGq8izMzn2e0AcTuToWiMTdcn9jWhXTrAv
 6dVRgrzY6WUGDJDhebPG9FPpuRKQDmdls06JJf4zMaur/Dx9gbcnFZUspT2TjRi6OorF
 4kAPq2xYi0jiFd62v+3F2DSWRpjTxwho079odldJoRYp1vt7xI5efvQypr0zCGZ9jYOf
 +INc95BRc7TFJjuWDI6tBDKOAoz23UGJXVfA0V97oz+hUADUzfhbbKdFg6XMMmgNJ8kG
 iL8A==
X-Gm-Message-State: AOJu0YxBAT6OXu2ZeGF2zd+bFKLMPlIZtCDXxo1CYHOJJq9VP/fwcM/l
 PjJIdrZH4kV1kTc5LVzDFyx9bUg0FpYC4vmiepBNvUsEXKIvANHc62Fiz0S72vsvtlCVxWIijWT
 GS16xS9O9n+mE97TJxT8PsbcIAb8Vyibf1vK1H/kC9Wl3xxBxKmE6
X-Received: by 2002:a05:6a21:999a:b0:1a0:b46e:3f18 with SMTP id
 ve26-20020a056a21999a00b001a0b46e3f18mr4043388pzb.2.1708485625396; 
 Tue, 20 Feb 2024 19:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhCFI1La7fDElmvPcxrtitHoUNUnINPd2C37WaujYeRS3OCRhuCCNM4RY669wprwUOX49a8w==
X-Received: by 2002:a05:6a21:999a:b0:1a0:b46e:3f18 with SMTP id
 ve26-20020a056a21999a00b001a0b46e3f18mr4043371pzb.2.1708485625083; 
 Tue, 20 Feb 2024 19:20:25 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 e4-20020a170902b78400b001dc0e5ad5desm2723485pls.114.2024.02.20.19.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 19:20:24 -0800 (PST)
Date: Wed, 21 Feb 2024 11:20:18 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] migration/multifd: Drop registered_yank
Message-ID: <ZdVr8qTb7MKFgnHO@x1n>
References: <20240208035126.370620-1-peterx@redhat.com>
 <20240208035126.370620-3-peterx@redhat.com>
 <871q9nceam.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871q9nceam.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 08, 2024 at 09:48:33AM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > With a clear definition of p->c protocol, where we only set it up if the
> > channel is fully established (TLS or non-TLS), registered_yank boolean will
> > have equal meaning of "p->c != NULL".
> >
> > Drop registered_yank by checking p->c instead.
> >
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.h | 2 --
> >  migration/multifd.c | 7 +++----
> >  2 files changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 8a1cad0996..b3fe27ae93 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -78,8 +78,6 @@ typedef struct {
> >      bool tls_thread_created;
> >      /* communication channel */
> >      QIOChannel *c;
> > -    /* is the yank function registered */
> > -    bool registered_yank;
> >      /* packet allocated len */
> >      uint32_t packet_len;
> >      /* guest page size */
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 4a85a6b7b3..278453cf84 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -648,11 +648,11 @@ static int multifd_send_channel_destroy(QIOChannel *send)
> >  
> >  static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
> >  {
> > -    if (p->registered_yank) {
> > +    if (p->c) {
> >          migration_ioc_unregister_yank(p->c);
> > +        multifd_send_channel_destroy(p->c);
> 
> At socket_send_channel_destroy the clean up of outgoing_args.saddr will
> now be skipped. The failure at multifd_new_send_channel_async might have
> been due to TLS, in which case all of plain socket setup will have
> happened properly.

Right, IMHO it's a hack to free globals in a per-channel helper.  We should
have moved:

    if (outgoing_args.saddr) {
        qapi_free_SocketAddress(outgoing_args.saddr);
        outgoing_args.saddr = NULL;
    }

Outside irrelevant of that..

That could be done later I guess, because we have one more guard:

socket_start_outgoing_migration():
    /* in case previous migration leaked it */
    qapi_free_SocketAddress(outgoing_args.saddr);
    outgoing_args.saddr = addr;

If you think proper, I can add one more patch to do that cleanup, IOW, move
above free() into multifd_send_cleanup_state().

Thanks,

-- 
Peter Xu


