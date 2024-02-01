Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B520C48291
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 04:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVOfr-0004TF-U8; Wed, 31 Jan 2024 23:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVOfq-0004T7-8R
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 23:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVOfn-0006nM-T8
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 23:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706761654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMG7XbzlvtWhoaJAgslyeIql4UQeL9f4Ny0elHiwW7c=;
 b=b9Olf7YCkOEPU5YpDqODgCBO7BGjFUnGu5AU9tuHIrypbVTK5dMBkeb0jtNAvxaeh1eb+Y
 F+lA+8y0RVThTkfOOcorzwumHh6V4MAJYT8LqSg0mSZTGkK7kSzCm54LMtBE4l8gaqvi8T
 uXMOw3mR/AS2gpbjKT+Pk8tk4xxQGN8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-Jr4Jzvx2PMW4osz00ORnhg-1; Wed, 31 Jan 2024 23:27:32 -0500
X-MC-Unique: Jr4Jzvx2PMW4osz00ORnhg-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so132131a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 20:27:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706761651; x=1707366451;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OMG7XbzlvtWhoaJAgslyeIql4UQeL9f4Ny0elHiwW7c=;
 b=DJytRH6izFr7nEms4HqF2J/4X3xzpD5RibC+1l3pYOpLaKJn61ymdLbZOZLmxRMFWb
 Z+J2WIJAEuACdJ0Jig3Ipf/XYzaFqzecb98stdKrEjtgz4oTbya8XglJqJNM6YQET+bC
 Ca0ouKiO3mqUxchR70g1WH0j4Gss4mNHv/JD2t/KD8QL6JNqtRVQAb0Uo9zxRq6hdcqD
 EUDgLSHiHf0ZmxiBJhktL2CKAqwdyGfes0v7BntwAf+PqnJa+Jq8jbphddyJfYERzrA6
 DpBc48ntsAeHraVi7irOhgAepa2tGQ+MYbiZa0qSL+cWA6yaUD5PIDGGj9mjr1ZG01s0
 t4eg==
X-Gm-Message-State: AOJu0Yxm4zJjHeMgG/nagOzjtcyp8QK5nuNKOcgBIg1+vJ6v77Dd+f/q
 gjFFGDDLQnMC3XPJRvq60KfqgxMdQOJ1ykCGNqHEu0rCznYp6XzJs52hO5UUEAlNAaxUSEImUwx
 8DUtJhuXNDcoJlhkJL+QVS9WzrSdEZ+G5FMIQFxQUbsoaq3t23yN7
X-Received: by 2002:a17:90b:3b4c:b0:296:19b1:3317 with SMTP id
 ot12-20020a17090b3b4c00b0029619b13317mr349928pjb.2.1706761650798; 
 Wed, 31 Jan 2024 20:27:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH58iwQvxuYg1swrPOjw/749OldVPIyxnCNf2p4hDgWEMGBDNmrWV8HHCyaa5H/H1KjcFheNQ==
X-Received: by 2002:a17:90b:3b4c:b0:296:19b1:3317 with SMTP id
 ot12-20020a17090b3b4c00b0029619b13317mr349913pjb.2.1706761650401; 
 Wed, 31 Jan 2024 20:27:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWhr6EtRVfr3wXHx7WabSNfHz1JqSg5N4tv4k0j2LsZOXrBs7Pl4jzd/PIQW9d3Wnux6TU9paeni5L/yf7g1v0mfEhg0gQakvLBHFDhAdh3TPog399zH+nin4FL/itBqwBGw0JDpSD4P99bnotu4H9mu7KLNMlmypYGjJuL67LQX7TpNCpL9ORlTyHNmnCWp4WpcyC7z75t5MjTUZgQwGHvd0Yl1fkbRz5Cz7+e0Fbt6Pu6
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 su3-20020a17090b534300b002961d809272sm36823pjb.14.2024.01.31.20.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 20:27:29 -0800 (PST)
Date: Thu, 1 Feb 2024 12:27:22 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [External] Re: [PATCH v3 01/20] multifd: Add capability to
 enable/disable zero_page
Message-ID: <ZbsdqjFnCsT5O5n1@x1n>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-2-hao.xiang@bytedance.com>
 <22969801-AEDE-46EB-86E8-0E6F26E23397@nutanix.com>
 <CAAYibXjw42iB=5YgKsXy4erj6RsGuqDqFnhuOZxkfBit7S5TtA@mail.gmail.com>
 <8734uof5kw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734uof5kw.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 23, 2024 at 12:10:55PM -0300, Fabiano Rosas wrote:
> Hao Xiang <hao.xiang@bytedance.com> writes:
> 
> > On Sun, Jan 14, 2024 at 10:02 PM Shivam Kumar <shivam.kumar1@nutanix.com> wrote:
> >>
> >>
> >>
> >> > On 04-Jan-2024, at 6:14 AM, Hao Xiang <hao.xiang@bytedance.com> wrote:
> >> >
> >> > From: Juan Quintela <quintela@redhat.com>
> >> >
> >> > We have to enable it by default until we introduce the new code.
> >> >
> >> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> > ---
> >> > migration/options.c | 15 +++++++++++++++
> >> > migration/options.h |  1 +
> >> > qapi/migration.json |  8 +++++++-
> >> > 3 files changed, 23 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/migration/options.c b/migration/options.c
> >> > index 8d8ec73ad9..0f6bd78b9f 100644
> >> > --- a/migration/options.c
> >> > +++ b/migration/options.c
> >> > @@ -204,6 +204,8 @@ Property migration_properties[] = {
> >> >     DEFINE_PROP_MIG_CAP("x-switchover-ack",
> >> >                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
> >> >     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
> >> > +    DEFINE_PROP_MIG_CAP("main-zero-page",
> >> > +            MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
> >> >     DEFINE_PROP_END_OF_LIST(),
> >> > };
> >> >
> >> > @@ -284,6 +286,19 @@ bool migrate_multifd(void)
> >> >     return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
> >> > }
> >> >
> >> > +bool migrate_use_main_zero_page(void)
> >> > +{
> >> > +    /* MigrationState *s; */
> >> > +
> >> > +    /* s = migrate_get_current(); */
> >> > +
> >> > +    /*
> >> > +     * We will enable this when we add the right code.
> >> > +     * return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
> >> > +     */
> >> > +    return true;
> >> > +}
> >> > +
> >> > bool migrate_pause_before_switchover(void)
> >> > {
> >> >     MigrationState *s = migrate_get_current();
> >> > diff --git a/migration/options.h b/migration/options.h
> >> > index 246c160aee..c901eb57c6 100644
> >> > --- a/migration/options.h
> >> > +++ b/migration/options.h
> >> > @@ -88,6 +88,7 @@ int migrate_multifd_channels(void);
> >> > MultiFDCompression migrate_multifd_compression(void);
> >> > int migrate_multifd_zlib_level(void);
> >> > int migrate_multifd_zstd_level(void);
> >> > +bool migrate_use_main_zero_page(void);
> >> > uint8_t migrate_throttle_trigger_threshold(void);
> >> > const char *migrate_tls_authz(void);
> >> > const char *migrate_tls_creds(void);
> >> > diff --git a/qapi/migration.json b/qapi/migration.json
> >> > index eb2f883513..80c4b13516 100644
> >> > --- a/qapi/migration.json
> >> > +++ b/qapi/migration.json
> >> > @@ -531,6 +531,12 @@
> >> > #     and can result in more stable read performance.  Requires KVM
> >> > #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
> >> > #
> >> > +#
> >> > +# @main-zero-page: If enabled, the detection of zero pages will be
> >> > +#                  done on the main thread.  Otherwise it is done on
> >> > +#                  the multifd threads.
> >> > +#                  (since 8.2)
> >> > +#
> >> Should the capability name be something like "zero-page-detection" or just “zero-page”?
> >> CC: Fabiano Rosas
> >
> > I think the same concern was brought up last time Juan sent out the
> > original patchset. Right now, the zero page detection is done in the
> > main migration thread and it is always "ON". This change added a
> > functionality to move the zero page detection from the main thread to
> > the multifd sender threads. Now "main-zero-page" is turned "OFF" by
> > default, and zero page checking is done in the multifd sender thread
> > (much better performance). If user wants to run the zero page
> > detection in the main thread (keep current behavior), user can change
> > "main-zero-page" to "ON".
> >
> > Renaming it to "zero-page-detection" or just “zero-page” can not
> > differentiate the old behavior and the new behavior.
> 
> Yes, the main point here is what happens when we try to migrate from
> different QEMU versions that have/don't have this code. We need some way
> to maintain the compatibility. In this case Juan chose to keep this
> capability with the semantics of "old behavior" so that we can enable it
> on the new QEMU to match with the old binary that doesn't expect to see
> zero pages on the packet/stream.
> 
> > Here are the options:
> > 1) Keep the current behavior. "main-zero-page" is OFF by default and
> > zero page detection runs on the multifd thread by default. User can
> > turn the switch to "ON" if they want old behavior.
> > 2) Make "main-zero-page" switch ON as default. This would keep the
> > current behavior by default. User can set it to "OFF" for better
> > performance.
> 
> 3) Make multifd-zero-page ON by default. User can set it to OFF to get
> the old behavior. There was some consideration about how libvirt works
> that would make this one unusable, but I don't understand what's that
> about.
> 
> I would make this a default ON parameter instead of a capability.

If we want to add a knob for zero page, can it start with a string rather
than boolean?

It might already be helpful for debugging purpose when e.g. someone would
like to completely turn off zero page detection just for a comparison.  I
also believe there can be some corner cases where the guest workload
migrates faster without zero page detection: an extreme case is the guest
memory always got dirtied 1 byte at the end of each page, where the
detection will have a worst case overhead while always returns a !zero
page.

So that implies a string parameter with:

  - none: no zero page detection
  - legacy: only detect in main thread
  - multifd: use multifd detections

Then we can grow that with more HW accelerators.  We make machines <=9.0 to
use legacy then, with the default to multifd.

-- 
Peter Xu


