Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C472D149F7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 22:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4SWH-0003AP-UG; Fri, 25 Oct 2024 18:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4SWG-0003AE-FF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 18:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4SWD-0000Im-O0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 18:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729894251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEyiCEx6LpPkXwFij3kbJXfo4yi9DcCyQ7fDkNxlgyo=;
 b=KNlLCgiUC+pOv0d5nI2ANzUJGwdZ8dBm08hwULNgx3pS2eds4GS4jpRPpPAXK04lVtdku7
 vcxKPeH/hx3wikjpIxah8nka6v16pk+9LUMro0NXfZBIsyFUSfMe8z6ONFKz1M/chHbpCi
 H4gjlw5rmuqttnEbKrVgVtZ8dqMS9ZY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-UWTLs7wgM429wiJXhs3-cg-1; Fri, 25 Oct 2024 18:10:50 -0400
X-MC-Unique: UWTLs7wgM429wiJXhs3-cg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b13ff957cbso315322385a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 15:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729894249; x=1730499049;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mEyiCEx6LpPkXwFij3kbJXfo4yi9DcCyQ7fDkNxlgyo=;
 b=tDGa3uwq7fa+0sD2iBVti0IqIq5pugqIBm21NbqZ51YlVbu2lAoggElLH66mYNzKbp
 drH1uuI0qsXRTtyNj9U4BGBWfTXdlU/VPWqhthnIdk67ec8iXpvnNruE7eEOweUwW9EM
 Ni+qZXdNJSXzvyup4S0baAHZVucylANEZ/2tZL5QJuaLOibwch18k73/CNmiMjJy0GMf
 fCswctxKkqgrIgUb6XHWZxtiRRq0CAM3iU42QzCm0tkrkSC8+pXxH+VORvj0uj21V9V3
 vlLifuvtlPF2YTTiQGEW18Ewmft5fd0LS9c6ZmyY1lnL5lGtQLCNjSRBZ9o5QWA2KGKb
 xiGw==
X-Gm-Message-State: AOJu0YzZcoX9p1IQgus/I7W9lg6BngRVyoqAat+wcEIh+mbn3njp/hzz
 rsBh47ecngyoQluMn5Z3gpDKosUbnHnuKwKMLU8RTxPOwM7YHmMR6W/fh6+3MWTUWDEdYVLxPuC
 9MCcbEKEA5U0wxsCOk3F+75pU39/8XBcRWvdXOGHec1+AcAMmOpl2
X-Received: by 2002:a05:620a:31a7:b0:7a9:bf9f:5ccb with SMTP id
 af79cd13be357-7b193ed7c8bmr114851885a.1.1729894249574; 
 Fri, 25 Oct 2024 15:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuh6rPAkRiTjJ4JdXaydvLdOwjegnpFhDHVBRw7i+fcUvAU0IdaIhXxH63ODmSCEQIL8mAfg==
X-Received: by 2002:a05:620a:31a7:b0:7a9:bf9f:5ccb with SMTP id
 af79cd13be357-7b193ed7c8bmr114848785a.1.1729894249264; 
 Fri, 25 Oct 2024 15:10:49 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d343cefsm94237285a.106.2024.10.25.15.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 15:10:48 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:10:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
Message-ID: <ZxwXZmrZN9EW6LIn@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
 <ZxtqGQbd4Hq4APtm@redhat.com> <ZxvEfrj5B59J5HHj@x1n>
 <ZxvFqYASUdSNtlr6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxvFqYASUdSNtlr6@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 25, 2024 at 05:22:01PM +0100, Daniel P. Berrangé wrote:
> On Fri, Oct 25, 2024 at 12:17:02PM -0400, Peter Xu wrote:
> > On Fri, Oct 25, 2024 at 10:51:21AM +0100, Daniel P. Berrangé wrote:
> > > > diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> > > > index e91a235347..ecc1cf781c 100644
> > > > --- a/qom/qom-qmp-cmds.c
> > > > +++ b/qom/qom-qmp-cmds.c
> > > > @@ -126,6 +126,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> > > >      ObjectProperty *prop;
> > > >      ObjectPropertyIterator iter;
> > > >      ObjectPropertyInfoList *prop_list = NULL;
> > > > +    bool create;
> > > >  
> > > >      klass = module_object_class_by_name(typename);
> > > >      if (klass == NULL) {
> > > > @@ -141,7 +142,15 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> > > >          return NULL;
> > > >      }
> > > >  
> > > > -    obj = object_new(typename);
> > > > +    /* Avoid creating multiple instances if the class is a singleton */
> > > > +    create = !object_class_is_singleton(klass) ||
> > > > +        !singleton_get_instance(klass);
> > > > +
> > > > +    if (create) {
> > > > +        obj = object_new(typename);
> > > > +    } else {
> > > > +        obj = singleton_get_instance(klass);
> > > > +    }
> > > 
> > > This is the first foot-gun example.
> > > 
> > > I really strongly dislike that the design pattern forces us to
> > > create code like this, as we can never be confident we've
> > > correctly identified all the places which may call object_new
> > > on a singleton...
> > 
> > Yeah I agree it's not pretty, IMHO it's a trade-off comparing to glib's,
> > I'll comment below for that.
> > 
> > Meanwhile I hope there should be very limited places in QEMU to randomly
> > create "any" object on the fly.. so far only qom/device-list-properties
> > that I see.
> 
> There's -object/-device CLI, and their corresponding object_add
> / device_add commands.

Ah I didn't mention that when reply, but this patch blocks properly any
device-add for singleton objects for more than once.  Please see the change
in qdev_device_add_from_qdict().

For migration object, it means it'll always fail because migration object
is created very early, before someone can try to create it.  Not to mention
it also has dc->hotpluggable==false, so things like -device will never work
on migration object.

For object-add, IIUC migration object should always be safe because it has
no USER_CREATABLE interface.

> 
> They are not relevant for the migration object, but you're adding
> this feature to QOM, so we have to take them into account. If anyone
> defines another Object or Device class as a singleton, we will have
> quite a few places where we can trigger the assert. This is especially
> bad if we trigger it from anything in QMP as that kills a running
> guest.
> 
> > 
> > I think glib's implementation is not thread safe on its own... consider two
> > threads invoke g_object_new() on the singleton without proper locking.  I
> > am guessing it could be relevant to glib's heavy event model.
> 
> I've not checked the full code path, to see if they have a serialization
> point somewhere it the g_object_new call chain, but yes, it is a valid
> concern that would need to be resolved.

Thanks,

-- 
Peter Xu


