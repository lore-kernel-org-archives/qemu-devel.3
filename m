Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA8CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFqM-0002Sd-DM; Mon, 18 Mar 2024 12:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmFqG-0002Q6-5t
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:28:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmFq2-0006e9-Vc
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710779269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCLOZNDcomJZBo0/HPMDP+Rj48VmjAEfEP1kRfGsD1U=;
 b=bEXiQUskaVeA7Cv0euGmREW3HV3MQ4PqWdgMZWTfTTQYe9F0jLPL/+feEeglzZlpTC71OG
 9aQvI0y63clWm5KU3QD2e8mCBnhx7UOqK/+6VYWYIAEb9SuizUpHTGH22/F+1S1vMtvv0S
 PSWkjkRkkOClFrMOXWldI7ZsNSy+ios=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-JOpS0o09OQOD4uqNBo_ayA-1; Mon, 18 Mar 2024 12:27:46 -0400
X-MC-Unique: JOpS0o09OQOD4uqNBo_ayA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3c377528ca3so357671b6e.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710779266; x=1711384066;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCLOZNDcomJZBo0/HPMDP+Rj48VmjAEfEP1kRfGsD1U=;
 b=vFKSwA/2WFDssAlHvt3VGsd/Eshc9Pi7YWJf6ZUVHFS+QvUhta4xs1wS4pspJc61SM
 AIDy/qZeEMkCjG96lqsDL0JWxRVgtQlgzi2AsZqfjAkn1e99b5FpMHTbcJI9oHbBFs+1
 hH4zNszD1UOozz599OPKNbeWMd7VxX7d5klrWWDZ3x033p1lFtFuZa7lR/V+CjKbvH9s
 d3sSJsUlSAqV4I8YpnzkAQGvEZPTjtx6f7sHUAjfFHYZj5xMGjlO9d2bQlzcM5bLCS13
 PEyzrGyOaWEMqbIb42bB45lDrePanK9HE1vNU06eQ8vhj0NuuyQej0HLw/Re5RzChvLF
 dozA==
X-Gm-Message-State: AOJu0Yxra3Ep7KKdMmmPTOHYyXGgq4R5QoZNaGsyfeMF6+9ZwLQBxBtk
 VrFCA9bfpikzP3YLj0Lo4I2T2RXoF1Cx+5d5TjgKiiz+LgEeRa9XsiH1BJWjlJZYVo0pX1o0WTL
 lo0ljMvyBkFoNdiaDsMJDIHTkeCwutJVdJTZLZ171tiwTu5xnkk64
X-Received: by 2002:a05:6808:3a97:b0:3c3:7dec:8fda with SMTP id
 fb23-20020a0568083a9700b003c37dec8fdamr6394803oib.4.1710779266026; 
 Mon, 18 Mar 2024 09:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhk73rLiuTixdnk0lhdZzAfArq0UKj20XuJOzh27yFjGXwM65jzm0wx6BEVjtK+CEXy/gDpQ==
X-Received: by 2002:a05:6808:3a97:b0:3c3:7dec:8fda with SMTP id
 fb23-20020a0568083a9700b003c37dec8fdamr6394783oib.4.1710779265607; 
 Mon, 18 Mar 2024 09:27:45 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 fj5-20020a05622a550500b00430b423f06csm3680832qtb.86.2024.03.18.09.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:27:45 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:27:42 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 13/25] memory: Add Error** argument to
 .log_global_start() handler
Message-ID: <ZfhrfotENipvXJVr@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-14-clg@redhat.com> <ZfQukLXQsgFEap4f@x1n>
 <40d6777a-7d58-4fe1-a441-67df73ca5efd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40d6777a-7d58-4fe1-a441-67df73ca5efd@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 18, 2024 at 03:54:28PM +0100, Cédric Le Goater wrote:
> On 3/15/24 12:18, Peter Xu wrote:
> > > @@ -3009,13 +3045,16 @@ static void listener_add_address_space(MemoryListener *listener,
> > >   {
> > >       FlatView *view;
> > >       FlatRange *fr;
> > > +    Error *local_err = NULL;
> > >       if (listener->begin) {
> > >           listener->begin(listener);
> > >       }
> > >       if (global_dirty_tracking) {
> > >           if (listener->log_global_start) {
> > > -            listener->log_global_start(listener);
> > > +            if (!listener->log_global_start(listener, &local_err)) {
> > > +                error_report_err(local_err);
> > > +            }
> > IMHO we should assert here instead of error report.  We have this to guard
> > hot-plug during migration so I think the assert is justified:
> > 
> > qdev_device_add_from_qdict():
> > 
> >      if (!migration_is_idle()) {
> >          error_setg(errp, "device_add not allowed while migrating");
> >          return NULL;
> >      }
> > 
> > If it really happens it's a bug, as listener_add_address_space() will still
> > keep the rest things around even if the hook failed.  It'll start to be a
> > total mess..
> 
> It seems that adding a region listener while logging is active has been
> supported from the beginning, commit 7664e80c8470 ("memory: add API for
> observing  updates to the physical memory map"). Can it happen ? if not
> we could simply remove the  log_global_start() call.

IMHO we'd better keep it for the sake of logic completeness, even though I
don't know when it'll be useful..

I think it's safe to assert because log_global_start() should only be
triggered by either vhost/vfio with current code base when reaching here.
It doesn't mean that in the future all log_global_start() hooks are based
on a device object. E.g., there's the other Xen user, it just won't trigger
either, afaict.  So the assert should be safe.

In the future maybe we could allow other things to trigger here besides
device, but obviously we're not ready for failing it.  Instead of adding
the failure handling which will never be used for now, IIUC it's simpler we
just provide an assert until someone add a real user of such.

Thanks,

-- 
Peter Xu


