Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B7CD5B845
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 00:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Zfj-0008NY-2k; Mon, 28 Oct 2024 20:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5Zfh-0008NO-5s
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 20:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5Zff-0007PR-Bk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 20:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730160073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ve/bWMagi2UauByStQ7ucEE19C8pbx0bo+KnRxxoALU=;
 b=VtiB79ky8QFQEBCD+14fJc6wSLVI1kQs8V5E2S3sn49HBK509mG9wIRkk7vuXGekoyXde1
 W0E4WohFCwgZjLJbFP3N12G8VRKZy8+sLneC+dEDZk0ezufSisWt7naUEOZrtNuPDlXyPK
 xgQ60RSxRBZMRpHBbfs35XULigGEkig=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-ZP3si6M6P9qUjs-kzN9YXg-1; Mon, 28 Oct 2024 20:01:07 -0400
X-MC-Unique: ZP3si6M6P9qUjs-kzN9YXg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4615d80492eso14679071cf.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 17:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730160066; x=1730764866;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ve/bWMagi2UauByStQ7ucEE19C8pbx0bo+KnRxxoALU=;
 b=fk0MLameWZv5YeT3siamH3VrdPE7qq8Ep2eE4Zl8LCcGUiBEtz6cVETFnlijutugFc
 51A83Tj1rK6Z7IlX8n3dFn1TtRXVEJB/gG3/6Jor/tL3GK2n4iptxz9nksib50rtJ90J
 OhlKcxvsamMrG6oYjvrC4U1YLwcPedDDBYWxFi20vH1qck51uMm0M5qq6eec5xNqr3oI
 nEopj6Pwts7+uPyhvLi6PI84kBntNViJLnVptrPB12xs71rNs2fQ1fsnqDr5BoiW8i/t
 E/TGnL8IjgyUb4OoSweNslpDWBqJs55je4aMigCc8gN+GkidsDEwJ+h6UZl5c9Hfd4yc
 gwBA==
X-Gm-Message-State: AOJu0YzrVX6qBGKnVpTtMtPYXFKFIBPOIeQp7Ne3NrcSSOHnN58RzTor
 b2gW/yOUaUE7xwJArFQWuaJ7T+Cy486PvW0RUD7eLl7LeLPaqu6z/odK+5j2ankDkuror6ONtEk
 GPPN9Nq5N8i/Ju/2CCqlotWemzC9u6fifwZTr8biQW9ww5EMznVhN
X-Received: by 2002:ac8:580f:0:b0:460:e907:ed4a with SMTP id
 d75a77b69052e-4613c176f43mr187378531cf.46.1730160066324; 
 Mon, 28 Oct 2024 17:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2wgn8nvTYAtMX0HwI4wCcd5PL929QcGEZjwX1HBPxlOXwuD7p7N81rh9d6/n5HFKxPtfYlw==
X-Received: by 2002:ac8:580f:0:b0:460:e907:ed4a with SMTP id
 d75a77b69052e-4613c176f43mr187378101cf.46.1730160065899; 
 Mon, 28 Oct 2024 17:01:05 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4613211a0fasm39385461cf.10.2024.10.28.17.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 17:01:04 -0700 (PDT)
Date: Mon, 28 Oct 2024 20:01:02 -0400
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
Message-ID: <ZyAlvozM73CY7oYn@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
 <ZxtqGQbd4Hq4APtm@redhat.com> <ZxvEfrj5B59J5HHj@x1n>
 <ZxvFqYASUdSNtlr6@redhat.com> <ZxwXZmrZN9EW6LIn@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxwXZmrZN9EW6LIn@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Oct 25, 2024 at 06:10:46PM -0400, Peter Xu wrote:
> On Fri, Oct 25, 2024 at 05:22:01PM +0100, Daniel P. Berrangé wrote:
> > On Fri, Oct 25, 2024 at 12:17:02PM -0400, Peter Xu wrote:
> > > On Fri, Oct 25, 2024 at 10:51:21AM +0100, Daniel P. Berrangé wrote:
> > > > > diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> > > > > index e91a235347..ecc1cf781c 100644
> > > > > --- a/qom/qom-qmp-cmds.c
> > > > > +++ b/qom/qom-qmp-cmds.c
> > > > > @@ -126,6 +126,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> > > > >      ObjectProperty *prop;
> > > > >      ObjectPropertyIterator iter;
> > > > >      ObjectPropertyInfoList *prop_list = NULL;
> > > > > +    bool create;
> > > > >  
> > > > >      klass = module_object_class_by_name(typename);
> > > > >      if (klass == NULL) {
> > > > > @@ -141,7 +142,15 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
> > > > >          return NULL;
> > > > >      }
> > > > >  
> > > > > -    obj = object_new(typename);
> > > > > +    /* Avoid creating multiple instances if the class is a singleton */
> > > > > +    create = !object_class_is_singleton(klass) ||
> > > > > +        !singleton_get_instance(klass);
> > > > > +
> > > > > +    if (create) {
> > > > > +        obj = object_new(typename);
> > > > > +    } else {
> > > > > +        obj = singleton_get_instance(klass);
> > > > > +    }
> > > > 
> > > > This is the first foot-gun example.
> > > > 
> > > > I really strongly dislike that the design pattern forces us to
> > > > create code like this, as we can never be confident we've
> > > > correctly identified all the places which may call object_new
> > > > on a singleton...
> > > 
> > > Yeah I agree it's not pretty, IMHO it's a trade-off comparing to glib's,
> > > I'll comment below for that.
> > > 
> > > Meanwhile I hope there should be very limited places in QEMU to randomly
> > > create "any" object on the fly.. so far only qom/device-list-properties
> > > that I see.
> > 
> > There's -object/-device CLI, and their corresponding object_add
> > / device_add commands.
> 
> Ah I didn't mention that when reply, but this patch blocks properly any
> device-add for singleton objects for more than once.  Please see the change
> in qdev_device_add_from_qdict().
> 
> For migration object, it means it'll always fail because migration object
> is created very early, before someone can try to create it.  Not to mention
> it also has dc->hotpluggable==false, so things like -device will never work
> on migration object.
> 
> For object-add, IIUC migration object should always be safe because it has
> no USER_CREATABLE interface.
> 
> > 
> > They are not relevant for the migration object, but you're adding
> > this feature to QOM, so we have to take them into account. If anyone
> > defines another Object or Device class as a singleton, we will have
> > quite a few places where we can trigger the assert. This is especially
> > bad if we trigger it from anything in QMP as that kills a running
> > guest.

Sorry, for some reason I think I didn't notice the 2nd paragraph.. And
somehow I was only thinking the migration use case.

Indeed this part is not easy to get right.  I hope this is not a blocker
yet so far.  We can have a look when I send the new version; I'll start to
mark the series RFC.

Meanwhile I'll have a closer look, hopefully object_class_is_abstract() is
a good point of reference where I can track most of dynamic creations of
objects, and I'll go from there.

My current plan is we can have one helper object_new_allowed(), where it
should contain both the check over abstract & singleton classes before any
instantiations happen.

-- 
Peter Xu


