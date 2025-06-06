Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3917EC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 17:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNb7j-0000du-Fb; Fri, 06 Jun 2025 13:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNb7d-0000cz-IS
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 13:44:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNb7b-000211-9T
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 13:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749231889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GuQwUjfA8zzgc+8w9LG9raFV+lNmJs07v2pZidjLmlw=;
 b=SB68rBN+1rGjKBh1o4x8Gyriivzl4ORQDsMABUgd8og9wRQ/fnjwcdhxdIptGFFoQFN37f
 gEWIq1ziMX/Arj5Uq9F9BAfpkUJcgPf5lHejDDWsK+SIcEmq0QDwPFcDE/9+8VOCRnkiNX
 ycGS29PK+4SgwqPhonoD+9jDU880nCA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-0CDz-f4OMRupPkG8tVuMOw-1; Fri, 06 Jun 2025 13:44:47 -0400
X-MC-Unique: 0CDz-f4OMRupPkG8tVuMOw-1
X-Mimecast-MFC-AGG-ID: 0CDz-f4OMRupPkG8tVuMOw_1749231887
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4a461632999so44458901cf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 10:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749231887; x=1749836687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuQwUjfA8zzgc+8w9LG9raFV+lNmJs07v2pZidjLmlw=;
 b=qifeeC6rKhbg8+GndIvwp95YeSQnhFiy/T25CvRyPdj7D2edrf72xIWR3b4oetmIPd
 edI1C3/3O8BlS4UfNbpuZQ6qi9mVAGmZCbaJZSczC2v/rz5atQ29csZ6GdVy6ngifzTB
 OsMOJJ9Xzxigx+4hsz9hIPGVMaXSVdPQmz2kwbl86oKUopJu5H8/eOI/GRJatXQTJ3Ui
 AjpSRuVuUgST0LUTmgWz2OdfAIvOXUpG7UxTjg29hGbGxELrBatuuA9F3On1AUQXSMIE
 wyuWPgzXhdZdVULymBJvPEZ9SN8HfxXEDgW9BP7mabLio5iEcI6Cs1ELki74fida2ZLm
 3i6A==
X-Gm-Message-State: AOJu0YzDgyRk4VxspphUl3G/kXepINg82gfXx8mpuWUfKwbQWMPopAKo
 bflxorKHlhzy3B44Q6kr82ol8PMOnJYj9QVqms6DEix2WrbDjZlFM09p5bTl3gtOlNcrzU5cPlT
 B7hCRkX9lUeVhJ17WFF3k0Q5KramS1kqhHNFYFM3yEd1EAJoVJLhw8+qV
X-Gm-Gg: ASbGncu7vQYD4gvRuGdExfRQRxytO+yNrkdTYAyaMqUlE4WtH7nEVy97X8NA7p+Ej/r
 bi0e49SnQa+8R6GjCArM9mw9d6lWT8ejmc8+d11ZsRNiNA/x27M+L9UacEcjyHBm8NCS0nD/mn4
 2p9fiEBp64eJjFd2nQKUEpjP9P5wGxUlwMy+RzQ+3qwdMfQr55aM/fpPjGlvTnhTyf5kjPlqkwf
 l0nzCPUAmsrEuZzASIMFNLMrhYErmQJ8ZVN17RjkoyVtbjI+TPoO70U1Ca36wWT/4EBNaeLmFfm
 vLI=
X-Received: by 2002:a05:622a:1cc5:b0:494:48b1:a1e0 with SMTP id
 d75a77b69052e-4a5b9a2c39emr70726371cf.20.1749231887139; 
 Fri, 06 Jun 2025 10:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHg292gYSedJGzjUCOA1LhUsMiU+wyyzKwcnRrFN12wXw9FvjkMYNU7Y+Y5dK513HYxHcn5w==
X-Received: by 2002:a05:622a:1cc5:b0:494:48b1:a1e0 with SMTP id
 d75a77b69052e-4a5b9a2c39emr70726061cf.20.1749231886773; 
 Fri, 06 Jun 2025 10:44:46 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a61116b780sm15832721cf.19.2025.06.06.10.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 10:44:46 -0700 (PDT)
Date: Fri, 6 Jun 2025 13:44:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 05/21] migration: Add a flag to track
 block-bitmap-mapping input
Message-ID: <aEMpDFJG37ADqMAi@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-6-farosas@suse.de> <aEMDTl7yaDGSv33I@x1.local>
 <87frgcx4dz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frgcx4dz.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 06, 2025 at 12:43:04PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jun 02, 2025 at 10:37:54PM -0300, Fabiano Rosas wrote:
> >> The QAPI converts an empty list on the block-bitmap-mapping input into
> >> a NULL BitmapMigrationNodeAliasList. The empty list is a valid input
> >> for the block-bitmap-mapping option, so commit 3cba22c9ad ("migration:
> >> Fix block_bitmap_mapping migration") started using the
> >> s->parameters.has_block_bitmap_mapping field to tell when the user has
> >> passed in an empty list vs. when no list has been passed at all.
> >> 
> >> However, using the has_block_bitmap_mapping field of s->parameters is
> >> only possible because MigrationParameters has had its members made
> >> optional due to historical reasons.
> >> 
> >> In order to make improvements to the way configuration options are set
> >> for a migration, we'd like to reduce the usage of the has_* fields of
> >> the global configuration object (s->parameters).
> >> 
> >> Add a separate boolean to track the status of the block_bitmap_mapping
> >> option.
> >> 
> >> (this was verified to not regress iotest 300, which is the test that
> >> 3cba22c9ad refers to)
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/migration.h | 7 +++++++
> >>  migration/options.c   | 6 +++---
> >>  2 files changed, 10 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/migration/migration.h b/migration/migration.h
> >> index d53f7cad84..ab797540b0 100644
> >> --- a/migration/migration.h
> >> +++ b/migration/migration.h
> >> @@ -510,6 +510,13 @@ struct MigrationState {
> >>      bool rdma_migration;
> >>  
> >>      GSource *hup_source;
> >> +
> >> +    /*
> >> +     * The block-bitmap-mapping option is allowed to be an emtpy list,
> >> +     * therefore we need a way to know wheter the user has given
> >> +     * anything as input.
> >> +     */
> >> +    bool has_block_bitmap_mapping;
> >>  };
> >>  
> >>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> >> diff --git a/migration/options.c b/migration/options.c
> >> index f64e141394..cf77826204 100644
> >> --- a/migration/options.c
> >> +++ b/migration/options.c
> >> @@ -685,7 +685,7 @@ bool migrate_has_block_bitmap_mapping(void)
> >>  {
> >>      MigrationState *s = migrate_get_current();
> >>  
> >> -    return s->parameters.has_block_bitmap_mapping;
> >> +    return s->has_block_bitmap_mapping;
> >>  }
> >>  
> >>  uint32_t migrate_checkpoint_delay(void)
> >> @@ -989,7 +989,7 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
> >>      params->has_announce_step = true;
> >>      params->announce_step = s->parameters.announce_step;
> >>  
> >> -    if (s->parameters.has_block_bitmap_mapping) {
> >> +    if (s->has_block_bitmap_mapping) {
> >>          params->has_block_bitmap_mapping = true;
> >>          params->block_bitmap_mapping =
> >>              QAPI_CLONE(BitmapMigrationNodeAliasList,
> >> @@ -1469,7 +1469,7 @@ static void migrate_params_apply(MigrationParameters *params)
> >>          qapi_free_BitmapMigrationNodeAliasList(
> >>              s->parameters.block_bitmap_mapping);
> >>  
> >> -        s->parameters.has_block_bitmap_mapping = true;
> >> +        s->has_block_bitmap_mapping = true;
> >>          s->parameters.block_bitmap_mapping =
> >>              QAPI_CLONE(BitmapMigrationNodeAliasList,
> >>                         params->block_bitmap_mapping);
> >> -- 
> >> 2.35.3
> >> 
> >
> > This is definitely unfortunate, and I'm still scratching my head on
> > understanding why it's necessary.
> >
> > E.g. I tried to revert this patch manually and iotest 300 passed, with:
> 
> This (mine) patch is not needed per-se. I want it so we stop using
> s->parameters.has_* altogether. If we think we need a flag to track
> whether the user has passed some value or not, then we add one to some
> migration specific state, say MigrationState.
> 
> This decouples the migration internal usage from the QAPI. Today we use
> MigrationParameters as defined by the QAPI, we might in the future want
> something else. And that something else might not come with has_*
> fields. So it's simple enough now to add this one flag to the
> MigrationState and be able to me completely independent from the
> QAPI-generated has_ fields.
> 
> >
> > ===8<===
> > From a952479805d8bdfe532ad4e0c0092f758991af08 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Fri, 6 Jun 2025 10:44:37 -0400
> > Subject: [PATCH] Revert "migration: Add a flag to track block-bitmap-mapping
> >  input"
> >
> > This reverts commit fd755a53c0e4ce9739d20d7cdd69400b2a37102c.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.h | 7 -------
> >  migration/options.c   | 4 ++--
> >  2 files changed, 2 insertions(+), 9 deletions(-)
> >
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 49761f4699..e710c421f8 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -510,13 +510,6 @@ struct MigrationState {
> >      bool rdma_migration;
> >  
> >      GSource *hup_source;
> > -
> > -    /*
> > -     * The block-bitmap-mapping option is allowed to be an emtpy list,
> > -     * therefore we need a way to know wheter the user has given
> > -     * anything as input.
> > -     */
> > -    bool has_block_bitmap_mapping;
> >  };
> >  
> >  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> > diff --git a/migration/options.c b/migration/options.c
> > index dd2288187d..e71a57764d 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -765,7 +765,7 @@ bool migrate_has_block_bitmap_mapping(void)
> >  {
> >      MigrationState *s = migrate_get_current();
> >  
> > -    return s->has_block_bitmap_mapping;
> > +    return s->parameters.has_block_bitmap_mapping;
> >  }
> >  
> >  uint32_t migrate_checkpoint_delay(void)
> > @@ -1376,7 +1376,7 @@ void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
> >       * params structure with the user input around.
> >       */
> >      if (params->has_block_bitmap_mapping) {
> > -        migrate_get_current()->has_block_bitmap_mapping = true;
> > +        migrate_get_current()->parameters.has_block_bitmap_mapping = true;
> >      }
> >  
> >      if (migrate_params_check(tmp, errp)) {
> > -- 
> > 2.49.0
> > ===8<===
> >
> > I'm staring at commit 3cba22c9ad now, looks like what it wants to do is
> > making sure construct_alias_map() will be invoked even if the block bitmap
> > mapping is NULL itself.  But then right below the code, it has:
> >
> > static int init_dirty_bitmap_migration(DBMSaveState *s, Error **errp)
> > {
> >     ...
> >     if (migrate_has_block_bitmap_mapping()) {
> >         alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
> >                                         &error_abort);
> >     }
> >     ...
> >     if (!alias_map) {
> >     ...
> >     }
> > }
> >
> > Looks like it's also ready for !alias_map anyway.  I'm definitely puzzled
> > by this code.
> >
> > Even if so, IIUC the question can still be asked on whether we can always
> > assume has_block_bitmap_mapping to be always true, then here instead of:
> >
> >     if (migrate_has_block_bitmap_mapping()) {
> >         alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
> >                                         &error_abort);
> >     }
> >
> > We do:
> >
> >     alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
> >                                     &error_abort);
> >
> > After all it looks like construct_alias_map() takes NULL too..
> 
> The point is that construct_alias_map always returns a hashtable. It
> might be empty if the user passes [], and that's ok according to
> 3cba22c9ad. So they needed some flag to say: "the user has tried to use
> block-bitmap-mapping".
> 
> I don't know why it needs to be like that and I honestly don't want to
> go into details of block migration just to be able to do a
> refactoring. All I want is that this code stop using s->parameters.has_*
> so we can do nice tricks with QAPI_CLONE later on and not bother about
> this.
> 
> I fully support we chase this, but keep in mind this patch (mine) is
> just gingerly moving the problem to the side so we can make progress
> with this series.

Yep that makes sense.

I'm thinking whether we have other better ways to move on without digging
another hole for ourselves, e.g. make migrate_has_block_bitmap_mapping() to
constantly return true?  We can cc the block people on that patch, assuming
we'd always better copy them when touching this part, including the current
patch.

AFAIU, as long as it takes NULL for the real parameter it'll just work.

Then if all tests can pass and no one is unhappy, we go with that.  We can
always add this var back when someone reports a break, then we at least
know this is needed and why.

That's what I'll do, but feel free to choose yours.  In all cases, I'd
still suggest we copy block developers on similar changes.

-- 
Peter Xu


