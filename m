Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FB2C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 06:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujtnP-0007RT-PV; Thu, 07 Aug 2025 02:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujtmo-0007IG-Ml
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujtml-00087X-9r
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 02:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754546849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kCjNgmvSAsecOU9Cfzad9kKMx3I3k3sY/UlwVUfWCA4=;
 b=XeOTBKGDuUc8TihW6M4eG5z4llU7x5Z/crVaIw/CreZgoICLw5z7ZGtZRCDEZn64f8i03p
 u1pruQd6d5mGzUNBxghJKS/K8xGg+UrBuVjn+c2/jRrNDiYzmuFV8GJNU4zhBThtu4Y/+G
 azSPYcR3oZry1j/j7jQZ3QBbMu7zA7Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-H7FC4GMDMZ6X8X5JrFKaXQ-1; Thu, 07 Aug 2025 02:07:27 -0400
X-MC-Unique: H7FC4GMDMZ6X8X5JrFKaXQ-1
X-Mimecast-MFC-AGG-ID: H7FC4GMDMZ6X8X5JrFKaXQ_1754546847
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b068c25f04so33531771cf.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 23:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754546847; x=1755151647;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCjNgmvSAsecOU9Cfzad9kKMx3I3k3sY/UlwVUfWCA4=;
 b=E2Wbof0hFr7SziDkiLLdGqgEoEm6q+HAcRPcPJtKQoEEj61M56wSzPuQ5Z1rUuajRa
 t5mt2AVvjLtft86Vphipy0BZS4f4ghss8FWPlRN7RaasYmps2Icne3FdBLojZw5WPxQs
 tmMiQvjFuf07kE4ExMHARFh2SHXjvftenSMcSNsSvOgIaa1Jeo865jNekzi5Zlk4elex
 Lz+Dc/4x1g8Cd1OSAqKvfMDNAkA9o68+76vJFXMO10kF81LfDxBug/EjzJoyKRzwgt+X
 n3dUJEGEv2oL0mnVIDImvfLqBoL6voWkxfHqtjnnj2VLpC17BOgxIhgDtjtKOJesLDYE
 FHlw==
X-Gm-Message-State: AOJu0Yy4QwU4vEDk58B2j5ptbbewqiuwe4HGuXYAHVlELAOPT3xGQ+31
 E3g7R/2xd79w4PoTbGhSZYG/fWIaRh1vaACbNZ7YcX1MqzS7feH/RWrFS437R47dq6j+7Aeh4GR
 ADcJwCv8S7LOP1XQ3wwR+Pt65yAafqoAsBepPOWFHiPxxGQgoethQPAuh
X-Gm-Gg: ASbGnctTM0rFtrqHiU86g8KPGyMgHvhWH9Nm1ba3vZCV7m1Q1kolpVOwcp/kg5bfiqP
 mJA9YaLDONhxwy1HPErcPjP687Zb1Zp9fe1VJuAf5mYwUYHBY7eJiJDdxG7N3pxzIpmkSw9r2ZV
 n4/hjCxo3CMJcwaXIL01jc80e7VshdbmwyckPDbfrAdzTD8Tmr5oN8dsl9azgRLsGz+FnPIbiNP
 GOS80u/mk5kKGICruo/PXzJZTVQ5zYmsG1FK5KJzr6nUBc+cQy5AuOkGa601fWdlaGv7IClWSr1
 AkQy8PuR3OaWyOdCs3VUSqj4IDCl6UgIsc2NpvnRPcaWuJhSQRQ=
X-Received: by 2002:ac8:5745:0:b0:4af:68f3:4a17 with SMTP id
 d75a77b69052e-4b0a07ed6d7mr28662161cf.14.1754546847046; 
 Wed, 06 Aug 2025 23:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqHBMtzrEdRxVLa56Bl09JuczpPcaWA2FpHgqvJQpFPzJeroldniyConGhJyjkTqgZveFRRA==
X-Received: by 2002:ac8:5745:0:b0:4af:68f3:4a17 with SMTP id
 d75a77b69052e-4b0a07ed6d7mr28661861cf.14.1754546846591; 
 Wed, 06 Aug 2025 23:07:26 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.53])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b061be8c43sm52584391cf.12.2025.08.06.23.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 23:07:26 -0700 (PDT)
Date: Thu, 7 Aug 2025 11:37:08 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 07/27] migration: push Error **errp into
 qemu_loadvm_state()
Message-ID: <aJRCjLGbSFzWyy2C@armenon-kvm.bengluru.csb>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-7-123450810db7@redhat.com>
 <07eebc10-a6e0-4fb8-a364-09f026a4a342@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07eebc10-a6e0-4fb8-a364-09f026a4a342@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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

On Wed, Aug 06, 2025 at 02:17:02PM +0900, Akihiko Odaki wrote:
> On 2025/08/06 3:25, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_loadvm_state() must report an error
> > in errp, in case of failure.
> > 
> > When postcopy live migration runs, the device states are loaded by
> > both the qemu coroutine process_incoming_migration_co() and the
> > postcopy_ram_listen_thread(). Therefore, it is important that the
> > coroutine also reports the error in case of failure, with
> > error_report_err(). Otherwise, the source qemu will not display
> > any errors before going into the postcopy pause state.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/migration.c |  7 ++++---
> >   migration/savevm.c    | 31 +++++++++++++++++++------------
> >   migration/savevm.h    |  2 +-
> >   3 files changed, 24 insertions(+), 16 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25dec01f206eacad2edd24d21f00e614c..bb7d5e1dee52692cbea1d2c8fdca541e6a75bedb 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
> >                         MIGRATION_STATUS_ACTIVE);
> >       mis->loadvm_co = qemu_coroutine_self();
> > -    ret = qemu_loadvm_state(mis->from_src_file);
> > +    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
> >       mis->loadvm_co = NULL;
> >       trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> > @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
> >       }
> >       if (ret < 0) {
> > -        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
> > +        error_prepend(&local_err, "load of migration failed: %s: ",
> > +                      strerror(-ret));
> >           goto fail;
> >       }
> > @@ -924,7 +925,7 @@ fail:
> >       migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> >                         MIGRATION_STATUS_FAILED);
> >       migrate_set_error(s, local_err);
> > -    error_free(local_err);
> > +    error_report_err(local_err);
> 
> There is "error_report_err(s->error)" after this so this can result in
> duplicate error printing.

Yes, we can replace this with error_free(s->error).

> 
> >       migration_incoming_state_destroy();
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 1bd27efe437d4d911728d776e995490d0a45dcf5..ca166ebd397ad80836ed2f9cb20a92f704fd4ed5 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -3149,28 +3149,24 @@ out:
> >       return ret;
> >   }
> > -int qemu_loadvm_state(QEMUFile *f)
> > +int qemu_loadvm_state(QEMUFile *f, Error **errp)
> >   {
> >       MigrationState *s = migrate_get_current();
> >       MigrationIncomingState *mis = migration_incoming_get_current();
> > -    Error *local_err = NULL;
> >       int ret;
> > -    if (qemu_savevm_state_blocked(&local_err)) {
> > -        error_report_err(local_err);
> > +    if (qemu_savevm_state_blocked(errp)) {
> >           return -EINVAL;
> >       }
> >       qemu_loadvm_thread_pool_create(mis);
> > -    ret = qemu_loadvm_state_header(f, &local_err);
> > +    ret = qemu_loadvm_state_header(f, errp);
> >       if (ret) {
> > -        error_report_err(local_err);
> >           return ret;
> >       }
> > -    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
> > -        error_report_err(local_err);
> > +    if (qemu_loadvm_state_setup(f, errp) != 0) {
> >           return -EINVAL;
> >       }
> > @@ -3181,6 +3177,9 @@ int qemu_loadvm_state(QEMUFile *f)
> >       cpu_synchronize_all_pre_loadvm();
> >       ret = qemu_loadvm_state_main(f, mis);
> > +    if (ret < 0) {
> > +        error_setg(errp, "Load VM state failed: %d", ret);
> > +    }
> >       qemu_event_set(&mis->main_thread_load_event);
> >       trace_qemu_loadvm_state_post_main(ret);
> > @@ -3198,8 +3197,14 @@ int qemu_loadvm_state(QEMUFile *f)
> >           if (migrate_has_error(migrate_get_current()) ||
> >               !qemu_loadvm_thread_pool_wait(s, mis)) {
> >               ret = -EINVAL;
> > +            error_setg(errp,
> > +                       "Error while loading VM state: "
> > +                       "Migration stream has error");
> >           } else {
> >               ret = qemu_file_get_error(f);
> > +            if (ret < 0) {
> > +                error_setg(errp, "Error while loading vmstate : %d", ret);
> > +            }
> >           }
> >       }
> >       /*
> > @@ -3464,6 +3469,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
> >   void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       QEMUFile *f;
> >       QIOChannelFile *ioc;
> >       int ret;
> > @@ -3485,10 +3491,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >       f = qemu_file_new_input(QIO_CHANNEL(ioc));
> >       object_unref(OBJECT(ioc));
> > -    ret = qemu_loadvm_state(f);
> > +    ret = qemu_loadvm_state(f, errp);
> >       qemu_fclose(f);
> >       if (ret < 0) {
> > -        error_setg(errp, "loading Xen device state failed");
> > +        error_prepend(errp, "loading Xen device state failed: ");
> >       }
> >       migration_incoming_state_destroy();
> >   }
> > @@ -3496,6 +3502,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >   bool load_snapshot(const char *name, const char *vmstate,
> >                      bool has_devices, strList *devices, Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       BlockDriverState *bs_vm_state;
> >       QEMUSnapshotInfo sn;
> >       QEMUFile *f;
> > @@ -3559,13 +3566,13 @@ bool load_snapshot(const char *name, const char *vmstate,
> >           ret = -EINVAL;
> >           goto err_drain;
> >       }
> > -    ret = qemu_loadvm_state(f);
> > +    ret = qemu_loadvm_state(f, errp);
> >       migration_incoming_state_destroy();
> >       bdrv_drain_all_end();
> >       if (ret < 0) {
> > -        error_setg(errp, "Error %d while loading VM state", ret);
> > +        error_prepend(errp, "Error %d while loading VM state: ", ret);
> >           return false;
> >       }
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24a7baeae73d90955 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
> >   void qemu_savevm_live_state(QEMUFile *f);
> >   int qemu_save_device_state(QEMUFile *f);
> > -int qemu_loadvm_state(QEMUFile *f);
> > +int qemu_loadvm_state(QEMUFile *f, Error **errp);
> >   void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> >   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> >   int qemu_load_device_state(QEMUFile *f);
> > 
> 
Regards,
Arun Menon


