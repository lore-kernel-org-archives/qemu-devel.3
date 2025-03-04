Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B9AC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaN5-0007eB-GI; Tue, 04 Mar 2025 17:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpaN2-0007dn-EO
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpaMz-0008It-HR
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741125847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zyWuUT9sVnwLvRJzvPYhS3UM/SkW/bbK0rne4vfaS+c=;
 b=d84/jcNDbxgyIIBMRocK+L1M9XrMlXw/8HsFLUansAsZObPVql/5oRFH47d8inFGAwwsEE
 w6xamJSiwsinbRJ9k00Ki+iSst9A79Cdj5tezFfd++mrA8LbjXOB/sXkhz3GQxptzZbdl6
 2e7yAodve2tW3OjDpz5QprCBHJ9R8e0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-ybwp0jPVNg2gBEmWi4wxSA-1; Tue, 04 Mar 2025 17:03:50 -0500
X-MC-Unique: ybwp0jPVNg2gBEmWi4wxSA-1
X-Mimecast-MFC-AGG-ID: ybwp0jPVNg2gBEmWi4wxSA_1741125830
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e89808749eso143156356d6.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741125830; x=1741730630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zyWuUT9sVnwLvRJzvPYhS3UM/SkW/bbK0rne4vfaS+c=;
 b=AYtlydb6FJqxHfTBvVnlPTo4bEI+OFTAnmL1GDGDa0fZGuCR1CjEsxF/QUVt8SX3K2
 a1z0el767HxqIFKApxpGbU2DqczuO8gT4rv0BljQQ23lrAGLa377PvIFxzHcosKeCjSb
 QSG4yHIGOzWq44ClZt/UQ5uY+iBLwwRB9GJNH+VDPPpIpVtUICloWUiG2cMISEg7y4Av
 uhRCX3YUeY/FX0qmf1YqVbkVJyUd3TRQKG7wfyQ5iIBsr49C+nvdUc8Mwkk2Lpv4/EGu
 /xw8frjpr6/GL7LXsnE05t73JMCOgkO9ZdIeMgaDZplNEl/1KXk6rD9IsAQJ9O+lwFvx
 MxLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrxSANsJNJvWfFt+v33xDav2S3hkg+aQ3/Ehp4PHQSIRlrd1MrPueVm+M1c0MSj0U6eTMEDY4cbE+W@nongnu.org
X-Gm-Message-State: AOJu0Yxrw2qlyYnTbWWFowTQgc3P4SPAPxBU5ENCGyExMtpMFpYk1Sre
 3JyLh+qLJ/DTjOJG6gCLUDzUXmJavzJ3youbsY/7fhe0HszLauyNe7kkfB2V3ldjdr5ceaKdShL
 O1n4I4HKRyLu/EjAmTEzyZXkfBWT+lTh5Tsg7KkaGygxcAvqDLgO1
X-Gm-Gg: ASbGncsmHsL1yNRF0ktQ+swh2bssC0GlAE/L6H5mDyooX6Yv01UX74emgCFVb06q4xG
 LhSHNc47O7pfb3B9KxDphQreYLfZk7Ygj9mRbJipRxrlo1usRhlxVdMAoNz6M5f+6ssX+vYCkV0
 SUHK2lkhWbsmPMONROf3uSKUeRlBtFhtNmBVkS6mTWOVuibtaePynA+x4/W26NuRZs8Eeu5Jvld
 LownaXtUdGCNH2KhaxMF6+NYvxZhL8mXRp+uf0DcfHA/MRW8mLCN5PUkOWzHXROFG9AZOLHVYYd
 iAx4rv8=
X-Received: by 2002:ad4:5cc4:0:b0:6e6:61a5:aa4c with SMTP id
 6a1803df08f44-6e8e6dd1937mr15762776d6.31.1741125829816; 
 Tue, 04 Mar 2025 14:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvwuJNI902YM/EgJMH+ACk5C6U9Un4XS38BQGBBcPTzL+lwPWcKvCKACyE3m20yhQY0pFQqg==
X-Received: by 2002:ad4:5cc4:0:b0:6e6:61a5:aa4c with SMTP id
 6a1803df08f44-6e8e6dd1937mr15762236d6.31.1741125829429; 
 Tue, 04 Mar 2025 14:03:49 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e89766176dsm71223666d6.66.2025.03.04.14.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:03:48 -0800 (PST)
Date: Tue, 4 Mar 2025 17:03:46 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 17/36] migration: Add
 save_live_complete_precopy_thread handler
Message-ID: <Z8d4wiV6C3jiBsMS@x1.local>
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <910a9d0950b609943e414ec557bebee85a4804a5.1739994627.git.maciej.szmigiero@oracle.com>
 <Z79EyapCxc2HMHPQ@x1.local>
 <bf254e83-d7fb-481b-929b-189a2436c21c@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf254e83-d7fb-481b-929b-189a2436c21c@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Mar 04, 2025 at 10:50:29PM +0100, Maciej S. Szmigiero wrote:
> On 26.02.2025 17:43, Peter Xu wrote:
> > On Wed, Feb 19, 2025 at 09:33:59PM +0100, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > This SaveVMHandler helps device provide its own asynchronous transmission
> > > of the remaining data at the end of a precopy phase via multifd channels,
> > > in parallel with the transfer done by save_live_complete_precopy handlers.
> > > 
> > > These threads are launched only when multifd device state transfer is
> > > supported.
> > > 
> > > Management of these threads in done in the multifd migration code,
> > > wrapping them in the generic thread pool.
> > > 
> > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > ---
> > >   include/migration/misc.h         | 17 +++++++
> > >   include/migration/register.h     | 19 +++++++
> > >   include/qemu/typedefs.h          |  3 ++
> > >   migration/multifd-device-state.c | 85 ++++++++++++++++++++++++++++++++
> > >   migration/savevm.c               | 35 ++++++++++++-
> > >   5 files changed, 158 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/migration/misc.h b/include/migration/misc.h
> > > index 273ebfca6256..8fd36eba1da7 100644
> > > --- a/include/migration/misc.h
> > > +++ b/include/migration/misc.h
> > > @@ -119,8 +119,25 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> > >                          Error **errp);
> > >   /* migration/multifd-device-state.c */
> > > +typedef struct SaveLiveCompletePrecopyThreadData {
> > > +    SaveLiveCompletePrecopyThreadHandler hdlr;
> > > +    char *idstr;
> > > +    uint32_t instance_id;
> > > +    void *handler_opaque;
> > > +} SaveLiveCompletePrecopyThreadData;
> > > +
> > >   bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
> > >                                   char *data, size_t len);
> > >   bool multifd_device_state_supported(void);
> > > +void
> > > +multifd_spawn_device_state_save_thread(SaveLiveCompletePrecopyThreadHandler hdlr,
> > > +                                       char *idstr, uint32_t instance_id,
> > > +                                       void *opaque);
> > > +
> > > +bool multifd_device_state_save_thread_should_exit(void);
> > > +
> > > +void multifd_abort_device_state_save_threads(void);
> > > +bool multifd_join_device_state_save_threads(void);
> > > +
> > >   #endif
> > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > index 58891aa54b76..c041ce32f2fc 100644
> > > --- a/include/migration/register.h
> > > +++ b/include/migration/register.h
> > > @@ -105,6 +105,25 @@ typedef struct SaveVMHandlers {
> > >        */
> > >       int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
> > > +    /**
> > > +     * @save_live_complete_precopy_thread (invoked in a separate thread)
> > > +     *
> > > +     * Called at the end of a precopy phase from a separate worker thread
> > > +     * in configurations where multifd device state transfer is supported
> > > +     * in order to perform asynchronous transmission of the remaining data in
> > > +     * parallel with @save_live_complete_precopy handlers.
> > > +     * When postcopy is enabled, devices that support postcopy will skip this
> > > +     * step.
> > > +     *
> > > +     * @d: a #SaveLiveCompletePrecopyThreadData containing parameters that the
> > > +     * handler may need, including this device section idstr and instance_id,
> > > +     * and opaque data pointer passed to register_savevm_live().
> > > +     * @errp: pointer to Error*, to store an error if it happens.
> > > +     *
> > > +     * Returns true to indicate success and false for errors.
> > > +     */
> > > +    SaveLiveCompletePrecopyThreadHandler save_live_complete_precopy_thread;
> > > +
> > >       /* This runs both outside and inside the BQL.  */
> > >       /**
> > > diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> > > index fd23ff7771b1..42ed4e6be150 100644
> > > --- a/include/qemu/typedefs.h
> > > +++ b/include/qemu/typedefs.h
> > > @@ -108,6 +108,7 @@ typedef struct QString QString;
> > >   typedef struct RAMBlock RAMBlock;
> > >   typedef struct Range Range;
> > >   typedef struct ReservedRegion ReservedRegion;
> > > +typedef struct SaveLiveCompletePrecopyThreadData SaveLiveCompletePrecopyThreadData;
> > >   typedef struct SHPCDevice SHPCDevice;
> > >   typedef struct SSIBus SSIBus;
> > >   typedef struct TCGCPUOps TCGCPUOps;
> > > @@ -133,5 +134,7 @@ typedef struct IRQState *qemu_irq;
> > >   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> > >   typedef bool (*MigrationLoadThread)(void *opaque, bool *should_quit,
> > >                                       Error **errp);
> > > +typedef bool (*SaveLiveCompletePrecopyThreadHandler)(SaveLiveCompletePrecopyThreadData *d,
> > > +                                                     Error **errp);
> > >   #endif /* QEMU_TYPEDEFS_H */
> > > diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> > > index 5de3cf27d6e8..63f021fb8dad 100644
> > > --- a/migration/multifd-device-state.c
> > > +++ b/migration/multifd-device-state.c
> > > @@ -8,7 +8,10 @@
> > >    */
> > >   #include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > >   #include "qemu/lockable.h"
> > > +#include "block/thread-pool.h"
> > > +#include "migration.h"
> > >   #include "migration/misc.h"
> > >   #include "multifd.h"
> > >   #include "options.h"
> > > @@ -17,6 +20,9 @@ static struct {
> > >       QemuMutex queue_job_mutex;
> > >       MultiFDSendData *send_data;
> > > +
> > > +    ThreadPool *threads;
> > > +    bool threads_abort;
> > >   } *multifd_send_device_state;
> > >   void multifd_device_state_send_setup(void)
> > > @@ -27,10 +33,14 @@ void multifd_device_state_send_setup(void)
> > >       qemu_mutex_init(&multifd_send_device_state->queue_job_mutex);
> > >       multifd_send_device_state->send_data = multifd_send_data_alloc();
> > > +
> > > +    multifd_send_device_state->threads = thread_pool_new();
> > > +    multifd_send_device_state->threads_abort = false;
> > >   }
> > >   void multifd_device_state_send_cleanup(void)
> > >   {
> > > +    g_clear_pointer(&multifd_send_device_state->threads, thread_pool_free);
> > >       g_clear_pointer(&multifd_send_device_state->send_data,
> > >                       multifd_send_data_free);
> > > @@ -115,3 +125,78 @@ bool multifd_device_state_supported(void)
> > >       return migrate_multifd() && !migrate_mapped_ram() &&
> > >           migrate_multifd_compression() == MULTIFD_COMPRESSION_NONE;
> > >   }
> > > +
> > > +static void multifd_device_state_save_thread_data_free(void *opaque)
> > > +{
> > > +    SaveLiveCompletePrecopyThreadData *data = opaque;
> > > +
> > > +    g_clear_pointer(&data->idstr, g_free);
> > > +    g_free(data);
> > > +}
> > > +
> > > +static int multifd_device_state_save_thread(void *opaque)
> > > +{
> > > +    SaveLiveCompletePrecopyThreadData *data = opaque;
> > > +    g_autoptr(Error) local_err = NULL;
> > > +
> > > +    if (!data->hdlr(data, &local_err)) {
> > > +        MigrationState *s = migrate_get_current();
> > > +
> > > +        assert(local_err);
> > > +
> > > +        /*
> > > +         * In case of multiple save threads failing which thread error
> > > +         * return we end setting is purely arbitrary.
> > > +         */
> > > +        migrate_set_error(s, local_err);
> > 
> > Where did you kick off all the threads when one hit error?  I wonder if
> > migrate_set_error() should just set quit flag for everything, but for this
> > series it might be easier to use multifd_abort_device_state_save_threads().
> 
> I've now added call to multifd_abort_device_state_save_threads() if a migration
> error is already set to avoid needlessly waiting for the remaining threads to
> do all of their work.

With that, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


