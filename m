Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6126DC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhq16-0008W3-NM; Fri, 01 Aug 2025 09:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhpxs-0003gA-4V
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhpxp-0001YS-Ss
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754055505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltONUDdtmUm8NwD+BDdGB9o7iB3/5H+hF1zrIjbsDKQ=;
 b=SCecXMY7aFE2n4rnTSeze8GqN9aH2gJ+E02AoxZzSM+AtXpHZzmRV4F+buGgIXI7S8V0Sn
 LUhEhfWv3oaZzkFgc6WGvxPMeT+Q4OZWAyTltPrUN9iSdyRjxcymjfLCM0MVUY5QE1pjk3
 08Vx8/4Ny0IsE6uEIvfsV5xWRl7s750=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-G_czyGWMOvOjUdFnn0c5rA-1; Fri, 01 Aug 2025 09:38:20 -0400
X-MC-Unique: G_czyGWMOvOjUdFnn0c5rA-1
X-Mimecast-MFC-AGG-ID: G_czyGWMOvOjUdFnn0c5rA_1754055500
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b3f76a5ba7fso701040a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754055500; x=1754660300;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ltONUDdtmUm8NwD+BDdGB9o7iB3/5H+hF1zrIjbsDKQ=;
 b=njXb7WEXWc8Z1WNnrN3QyOiwys3lQWm/u0lF/ko4bmYIciKpfYQlq5Vlnm56S2glaM
 G5j/gk8D8Fmk5ah02jq3OJoPClSTZAyzl3uM20+G2EUUkLqO0CS1ONS6sJfKZR/FWkjN
 Y/98Yhek6UuUEiPyyTNcLsoVETSN3aBlYXc4seDP9YOuFBSGbljtoNFMUoDS4WLMxO2h
 /Uw5TRFf7L5+0ffyPUZpYegZLPPS6CznSbi+iOTJZW2KRbmXa41gkn+SzBNoEqFDnPIx
 YAq7hSBHIXNJ7BqkLNy1DOCQpt6Xv0f1UHebqqsK1c1zQ+YpdJdBR4nbd9pXu0Icg/2Z
 Rc9w==
X-Gm-Message-State: AOJu0YyA48EBqod2TQ165yLXbsAVR63qzILH+yh0cdzLtdLYIZodqCD7
 2PCF7pswNktsXZKpcCfZvDvY4MSto4qw1LRlS/59zdeBTOfcpg3gmSDW1r33OTLoR74dwBer0Rp
 EXay9EerSG9Qi+1jVg9bCvd5fNxHT/t9sOOr1J1zdweA23kt/thzdS1Nz
X-Gm-Gg: ASbGncu0HaF0fs9rJEe+4JH5+fj6I6rA8f20dJo1dH9h2FaseZDxv1+w+sfyYXkOXeQ
 bHEZyK7Z8ELvCxO8gPBW7UfR9NIyR3sPPhTBg5upBAwDhuIw/QsCHz+AbfyifO2j1cSI0HPSARO
 JCALE5VoaLkeS3iN6Ihib/nVcqPaAZEMaR/aFa5RPBWgUnWXxQqj1CdmZ+AEOnd4GQ7v/93NdXP
 bQWZuDRsHBqJC+uaoNdN5w5k0lVe1fmtHh/psDfu6zic2op5NXuwiDc3gl3I73PtLnBD5LHpddI
 ptaCq8gwnOqzaj0MbsoCbrkIkIivJ7ej69zPcsO5ysceY9VGXUSNsw==
X-Received: by 2002:a17:903:291:b0:240:58a7:8938 with SMTP id
 d9443c01a7336-24096ac598fmr137160855ad.7.1754055499566; 
 Fri, 01 Aug 2025 06:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSGuylcFssDqnYrWdzpaD0XdCwncf4kIneLrY8e7WV2SyQ5ankllAIChXqXFom8+qe76Mxtw==
X-Received: by 2002:a17:903:291:b0:240:58a7:8938 with SMTP id
 d9443c01a7336-24096ac598fmr137160335ad.7.1754055499035; 
 Fri, 01 Aug 2025 06:38:19 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899b4adsm43871995ad.132.2025.08.01.06.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:38:18 -0700 (PDT)
Date: Fri, 1 Aug 2025 19:08:06 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v8 19/27] migration: push Error **errp into
 qemu_loadvm_state_main()
Message-ID: <aIzDPr0iQAbB0VSE@armenon-kvm.bengluru.csb>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
 <20250731-propagate_tpm_error-v8-19-28fd82fdfdb2@redhat.com>
 <91c9a8ab-6fdb-4945-8e7d-da60cd037116@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91c9a8ab-6fdb-4945-8e7d-da60cd037116@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Akihiko, 

Thanks for the review.

On Fri, Aug 01, 2025 at 04:17:04PM +0900, Akihiko Odaki wrote:
> On 2025/07/31 22:20, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_loadvm_state_main() must report an error
> > in errp, in case of failure.
> > loadvm_process_command also sets the errp object explicitly.
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/colo.c   |  5 +++--
> >   migration/savevm.c | 27 ++++++++++++++++-----------
> >   migration/savevm.h |  3 ++-
> >   3 files changed, 21 insertions(+), 14 deletions(-)
> > 
> > diff --git a/migration/colo.c b/migration/colo.c
> > index 981bd4bf9ced8b45b4c5d494acae119a174ee974..529794dfc8d943b8ba3a25391ee2132c0c3f312e 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
> >   static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >                         QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       uint64_t total_size;
> >       uint64_t value;
> >       Error *local_err = NULL;
> > @@ -686,11 +687,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >       bql_lock();
> >       cpu_synchronize_all_states();
> > -    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> > +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, errp);
> >       bql_unlock();
> >       if (ret < 0) {
> > -        error_setg(errp, "Load VM's live state (ram) error");
> > +        error_prepend(errp, "Load VM's live state (ram) error: ");
> >           return;
> >       }
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index e885f1724f223771d60081fea199320abc549d2f..f5903995edd2b4c4f6c1a214c7126d831f10c9f1 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2111,7 +2111,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >       qemu_file_set_blocking(f, true);
> >       /* TODO: sanity check that only postcopiable data will be loaded here */
> > -    load_res = qemu_loadvm_state_main(f, mis);
> > +    load_res = qemu_loadvm_state_main(f, mis, NULL);
> >       /*
> >        * This is tricky, but, mis->from_src_file can change after it
> > @@ -2412,6 +2412,7 @@ static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> >    */
> >   static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       int ret;
> >       size_t length;
> >       QIOChannelBuffer *bioc;
> > @@ -2461,9 +2462,9 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis, Error **errp)
> >           qemu_coroutine_yield();
> >       } while (1);
> > -    ret = qemu_loadvm_state_main(packf, mis);
> > +    ret = qemu_loadvm_state_main(packf, mis, errp);
> >       if (ret < 0) {
> > -        error_setg(errp, "VM state load failed: %d", ret);
> > +        error_prepend(errp, "Loading VM state failed: %d: ", ret);
> >       }
> >       trace_loadvm_handle_cmd_packaged_main(ret);
> >       qemu_fclose(packf);
> > @@ -3066,8 +3067,10 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
> >       return true;
> >   }
> > -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> > +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> > +                           Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       uint8_t section_type;
> >       int ret = 0;
> > @@ -3075,8 +3078,10 @@ retry:
> >       while (true) {
> >           section_type = qemu_get_byte(f);
> > -        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, NULL);
> > +        ret = qemu_file_get_error_obj_any(f, mis->postcopy_qemufile_dst, errp);
> >           if (ret) {
> > +            error_prepend(errp, "Failed to load device state section ID: %d: ",
> > +                          ret);
> 
> I noticed this is after the "retry" label; errp already contains an error
> when retried so the error needs to be properly reported and freed.

Yes, I shall check how to report error, because there is an error_report() in the
default case. And yes, errp needs to be freed and set to NULL before retry.


> 
> >               break;
> >           }
> > @@ -3084,20 +3089,20 @@ retry:
> >           switch (section_type) {
> >           case QEMU_VM_SECTION_START:
> >           case QEMU_VM_SECTION_FULL:
> > -            ret = qemu_loadvm_section_start_full(f, section_type, NULL);
> > +            ret = qemu_loadvm_section_start_full(f, section_type, errp);
> >               if (ret < 0) {
> >                   goto out;
> >               }
> >               break;
> >           case QEMU_VM_SECTION_PART:
> >           case QEMU_VM_SECTION_END:
> > -            ret = qemu_loadvm_section_part_end(f, section_type, NULL);
> > +            ret = qemu_loadvm_section_part_end(f, section_type, errp);
> >               if (ret < 0) {
> >                   goto out;
> >               }
> >               break;
> >           case QEMU_VM_COMMAND:
> > -            ret = loadvm_process_command(f, NULL);
> > +            ret = loadvm_process_command(f, errp);
> >               trace_qemu_loadvm_state_section_command(ret);
> >               if ((ret < 0) || (ret == LOADVM_QUIT)) {
> >                   goto out;
> > @@ -3107,7 +3112,7 @@ retry:
> >               /* This is the end of migration */
> >               goto out;
> >           default:
> > -            error_report("Unknown savevm section type %d", section_type);
> > +            error_setg(errp, "Unknown savevm section type %d", section_type);
> >               ret = -EINVAL;
> >               goto out;
> >           }
> > @@ -3171,7 +3176,7 @@ int qemu_loadvm_state(QEMUFile *f)
> >       cpu_synchronize_all_pre_loadvm();
> > -    ret = qemu_loadvm_state_main(f, mis);
> > +    ret = qemu_loadvm_state_main(f, mis, NULL);
> >       qemu_event_set(&mis->main_thread_load_event);
> >       trace_qemu_loadvm_state_post_main(ret);
> > @@ -3245,7 +3250,7 @@ int qemu_load_device_state(QEMUFile *f)
> >       int ret;
> >       /* Load QEMU_VM_SECTION_FULL section */
> > -    ret = qemu_loadvm_state_main(f, mis);
> > +    ret = qemu_loadvm_state_main(f, mis, NULL);
> >       if (ret < 0) {
> >           error_report("Failed to load device state: %d", ret);
> >           return ret;
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 2d5e9c716686f06720325e82fe90c75335ced1de..fd7419e6ff90062970ed246b3ea71e6d49a6e372 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -66,7 +66,8 @@ int qemu_save_device_state(QEMUFile *f);
> >   int qemu_loadvm_state(QEMUFile *f);
> >   void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> > -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> > +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> > +                           Error **errp);
> >   int qemu_load_device_state(QEMUFile *f);
> >   int qemu_loadvm_approve_switchover(void);
> >   int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> > 
> 
Regards,
Arun


