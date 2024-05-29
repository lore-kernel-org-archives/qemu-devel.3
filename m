Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDA7C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 18:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCODH-0007Ri-6I; Wed, 29 May 2024 14:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCODG-0007RP-41
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCOD8-0002W2-8b
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717007981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j3AWtT/YaFI2DuXN8sTVc5ccamqFtPxU+NgWSUkmGiI=;
 b=dcKOP7fc4jzOQBjN8JzWZ41D4+6Ll2GFOUudGaxAavILBV2ATWG40QmrDSuAvkiuZehrFF
 xEkWPKMwJB4PLY6vjPa0YbeFaokFGi1/w+i+Pk2zsGFYuZL4fHcGfPfo6T1wleIog1qpYG
 Z40+jcPMOo842o4GeZAkQsm0bsqRI2c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-oNAgZtCSOEeyMsZbqXMTCg-1; Wed, 29 May 2024 14:39:39 -0400
X-MC-Unique: oNAgZtCSOEeyMsZbqXMTCg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ad5ebfaa68so108426d6.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 11:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717007979; x=1717612779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3AWtT/YaFI2DuXN8sTVc5ccamqFtPxU+NgWSUkmGiI=;
 b=UunlRDpT0bfXYZL3Zwf8jR2uZYNoD3k2ED9RmFGtUsIqoEFm2RtpFYuZLMrqB47f+W
 NpyxnquctMlo6o0+URvLJN20CGy5ImyUWtGJZVNBw68lHDDYHJ4QtcAZZKgjxsdp6AmM
 9Xk96se/ly9mB/AucHkYzUyHSB7gTkwu0GII2PibjiPWDN5QKlCJE7CpcG7VP08SvLJ6
 enPPxwiMOIBaO5An3iINE2seUcOsNn7xuY9rdD/Bl88WZRx1ePhVLVuiyAYdaNxvXHzI
 /iMqfPD87vmEKtLiV9X93noH7V/P9gBEXFF4CpHokUrocUPnk9mx5q+JsY4RnSc8wevw
 2Kbw==
X-Gm-Message-State: AOJu0Yz0lj7D2C6/oQ3PPGRafOOBAEQPGEXrkYTH3XECLKSAzrv5LTLX
 Vh6CsQ0FRyO+OTpPll97rd6RA+hl8r/bFf7BsC6RUYc01fJod/IJOYsroLr4qmeNKsPHFxhJV8+
 VeG4J8kQ1ymF57ty8EALnPzd5GlGL33ReQoo3Dy1ncZ6bwHl6paUM
X-Received: by 2002:ac8:7f8e:0:b0:43d:f8b7:96c4 with SMTP id
 d75a77b69052e-43fe93345c5mr641501cf.4.1717007978263; 
 Wed, 29 May 2024 11:39:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3nGgMf/Z07k4xYzeR1+IAQu9pk75LFXzH1Eda7fePqwguPXqULPnqvoPtpid0gifPZiuVgg==
X-Received: by 2002:ac8:7f8e:0:b0:43d:f8b7:96c4 with SMTP id
 d75a77b69052e-43fe93345c5mr641091cf.4.1717007977435; 
 Wed, 29 May 2024 11:39:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18b0e3bsm56407571cf.68.2024.05.29.11.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 11:39:36 -0700 (PDT)
Date: Wed, 29 May 2024 14:39:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 05/26] migration: precreate vmstate
Message-ID: <Zld2ZqscwwJg7fkE@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-6-git-send-email-steven.sistare@oracle.com>
 <ZlTOCLFNF894T46U@x1n>
 <daca5ee5-87a7-4a07-8161-d5e133c9443d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <daca5ee5-87a7-4a07-8161-d5e133c9443d@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 28, 2024 at 11:09:49AM -0400, Steven Sistare wrote:
> On 5/27/2024 2:16 PM, Peter Xu wrote:
> > On Mon, Apr 29, 2024 at 08:55:14AM -0700, Steve Sistare wrote:
> > > Provide the VMStateDescription precreate field to mark objects that must
> > > be loaded on the incoming side before devices have been created, because
> > > they provide properties that will be needed at creation time.  They will
> > > be saved to and loaded from their own QEMUFile, via
> > > qemu_savevm_precreate_save and qemu_savevm_precreate_load, but these
> > > functions are not yet called in this patch.  Allow them to be called
> > > before or after normal migration is active, when current_migration and
> > > current_incoming are not valid.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   include/migration/vmstate.h |  6 ++++
> > >   migration/savevm.c          | 69 +++++++++++++++++++++++++++++++++++++++++----
> > >   migration/savevm.h          |  3 ++
> > >   3 files changed, 73 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > > index 294d2d8..4691334 100644
> > > --- a/include/migration/vmstate.h
> > > +++ b/include/migration/vmstate.h
> > > @@ -198,6 +198,12 @@ struct VMStateDescription {
> > >        * a QEMU_VM_SECTION_START section.
> > >        */
> > >       bool early_setup;
> > > +
> > > +    /*
> > > +     * Send/receive this object in the precreate migration stream.
> > > +     */
> > > +    bool precreate;
> > > +
> > >       int version_id;
> > >       int minimum_version_id;
> > >       MigrationPriority priority;
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 9789823..a30bcd9 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -239,6 +239,7 @@ static SaveState savevm_state = {
> > >   #define SAVEVM_FOREACH(se, entry)                                    \
> > >       QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
> > > +        if (!se->vmsd || !se->vmsd->precreate)
> > >   #define SAVEVM_FOREACH_ALL(se, entry)                                \
> > >       QTAILQ_FOREACH(se, &savevm_state.handlers, entry)
> > > @@ -1006,13 +1007,19 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
> > >       }
> > >   }
> > > +static bool send_section_footer(SaveStateEntry *se)
> > > +{
> > > +    return (se->vmsd && se->vmsd->precreate) ||
> > > +           migrate_get_current()->send_section_footer;
> > > +}
> > 
> > Does the precreate vmsd "require" the footer?  Or it should also work?
> > IMHO it's less optimal to bind features without good reasons.
> 
> It is not required.  However, IMO we should not treat send-section-footer as
> a fungible feature.  It is strictly an improvement, as was added to catch
> misformated sections.  It is only registered as a feature for backwards
> compatibility with qemu 2.3 and xen.
> 
> For a brand new data stream such as precreate, where we are not constrained
> by backwards compatibility, we should unconditionally use the better protocol,
> and always send the footer.

I see your point, but I still don't think we should mangle these things.
It makes future justification harder on whether section footer should be
sent.

Take example of whatever new feature added for migration like mapped-ram,
we might also want to enforce it by adding "return migrate_mapped_ram() ||
..." but it means we keep growing this with no benefit.

What you worry on "what if this is turned off" isn't a real one: nobody
will turn it off!  We started to deprecate machines, and I had a feeling
it will be enforced at some point by default.

-- 
Peter Xu


