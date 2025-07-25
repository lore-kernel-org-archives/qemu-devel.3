Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50311C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 07:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufCb1-00021R-1T; Fri, 25 Jul 2025 03:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCZ0-0007Ye-J5
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufCYv-0003Ie-PT
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 03:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753427387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y0W/PzWHuP0jUfaE5MFTD5SnTMtcqIvZy/uOmivKEQw=;
 b=MRntsjXFSAtOI5r5HOFccs96ebEOh8Ns93N+C/RZxNy/TYB6H6OBo+4bchSE4sipWUjpIJ
 Jg4QhVuNBjc8rA8g/1XAFyn8SXrfCdvCO0y1KH2zz8kqJqUI2Rn8nzg5Qx5Sgjc9PkE0xm
 L7fMjM7urm0lwL3qHHzB/c+cb03fHIk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-n7vj1YQ3MV2AjO7cfPUIUA-1; Fri, 25 Jul 2025 03:09:45 -0400
X-MC-Unique: n7vj1YQ3MV2AjO7cfPUIUA-1
X-Mimecast-MFC-AGG-ID: n7vj1YQ3MV2AjO7cfPUIUA_1753427384
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-75ab147e0a3so3084115b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 00:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753427384; x=1754032184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0W/PzWHuP0jUfaE5MFTD5SnTMtcqIvZy/uOmivKEQw=;
 b=B+C5bO8nKf2eBocPHyiVqOsxVwtIJXjuUu3JJ+dY2GAefxIV+XljkT1c8kQ0gB1rxH
 06vttzR++cTRogrO5httgEUgPwPffrueA1bbB0aykZZynpy38tpKyAKHpUubOif3piRn
 QXydTaNGnslP3PkvBR/9h2YquhHTvsVA8DRayVZkXXQPhgJagRiN2e7XezY0iW0lfJrd
 l4OighOcDsHiHaCFggNE75Z55Zfqw/HCae8NrbdZqGgjs+9CrxO78TSWNQk5wwJHUZjy
 C8Uly861klDJax1d5jah3E8mE3I4A43rGZsRzVNlZPGPGhDTg287RFQcbDvEDPLQRSlW
 mXpw==
X-Gm-Message-State: AOJu0Yx7o2cwAGADMJ4y0dsO6GszI3NDPyAo/PMO8eL2DvCWAZ8ds0Rv
 yqIMRYPgubMT08rlK7G4WYcM/WAjhB/mq02AT4voDDA6+pMfn7A8Pcm+88aOEkzySjRdoprCm1K
 qcDLHeelrX7UusVqB7MujcQYCMm7w//KAbKOYt/IwL4LuKW1Oaqu/Fu02
X-Gm-Gg: ASbGncs3bSSnpq/K4Ycybq/zsZY3g8eZJnl7fkRTCXqTZTAU+G4THn+b716S7FBjekS
 pGBEfv8d0EzrrmaHpYZCrQql35r1/FiCXCwL1qak81gldC7yAbHRG+AlZKLfWuQnirRGjfjMOlo
 xX7adszeMtfnXcnc8vo+x6LqTs0TRbWvvjGKQk9tpiuRtgAKGZ/D00kxo/iNvkqMG/m9mhdq3u8
 eOMs9sbOt9F+DyXZ133HfJmou00cjE0kkxGFMLMHFnx8bI+62WprCzvuXgxMRVdGqA+INCtglLO
 +q6+ywYgReX3ObqK9G8JzBVOWzu0RAmrtEU3zjEj1Qmeoyx4N93G
X-Received: by 2002:a05:6a20:a126:b0:232:fcfc:7209 with SMTP id
 adf61e73a8af0-23d701a89d9mr1307010637.35.1753427384356; 
 Fri, 25 Jul 2025 00:09:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvggfeV4kCsnRvsdb/gjNRtXEfdWGNVK6vD1z/G5+ynMyE16sKd8MEF0ubcggllkcZRQyVyg==
X-Received: by 2002:a05:6a20:a126:b0:232:fcfc:7209 with SMTP id
 adf61e73a8af0-23d701a89d9mr1306958637.35.1753427383917; 
 Fri, 25 Jul 2025 00:09:43 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.73])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7630c947c37sm826136b3a.46.2025.07.25.00.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 00:09:43 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:39:32 +0530
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
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v6 20/24] migration: push Error **errp into
 qemu_loadvm_state()
Message-ID: <aIMtrDeDtALlH4Qf@armenon-kvm.bengluru.csb>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-20-fef740e15e17@redhat.com>
 <155575ab-29c0-4591-a62a-19a6ae3283a6@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155575ab-29c0-4591-a62a-19a6ae3283a6@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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

Hi,
Thanks for the review

On Mon, Jul 21, 2025 at 10:01:24PM +0900, Akihiko Odaki wrote:
> On 2025/07/21 20:29, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that qemu_loadvm_state() must report an error
> > in errp, in case of failure.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   migration/migration.c |  5 +++--
> >   migration/savevm.c    | 25 +++++++++++++------------
> >   migration/savevm.h    |  2 +-
> >   3 files changed, 17 insertions(+), 15 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index d748a02712dc4ebc2de6b0488fb199c92c4d4079..09fadf36dbbbd2f68df1e4cafbf3a51b18531978 100644
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
> > +        error_prepend(&local_err, "load of migration failed: %s ",
> > +                      strerror(-ret));
> >           goto fail;
> >       }
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index ba146f91427f2a36880aadeb16b11ab2b7df099a..1261e81c86f836e6b5a155ba1880b5823a779567 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -3137,27 +3137,24 @@ out:
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
> > -    ret = qemu_loadvm_state_header(f, NULL);
> > +    ret = qemu_loadvm_state_header(f, errp);
> >       if (ret) {
> >           return ret;
> >       }
> > -    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
> > -        error_report_err(local_err);
> > +    if (qemu_loadvm_state_setup(f, errp) != 0) {
> >           return -EINVAL;
> >       }
> > @@ -3167,7 +3164,7 @@ int qemu_loadvm_state(QEMUFile *f)
> >       cpu_synchronize_all_pre_loadvm();
> > -    ret = qemu_loadvm_state_main(f, mis, NULL);
> > +    ret = qemu_loadvm_state_main(f, mis, errp);
> >       qemu_event_set(&mis->main_thread_load_event);
> >       trace_qemu_loadvm_state_post_main(ret);
> > @@ -3185,8 +3182,12 @@ int qemu_loadvm_state(QEMUFile *f)
> >           if (migrate_has_error(migrate_get_current()) ||
> >               !qemu_loadvm_thread_pool_wait(s, mis)) {
> >               ret = -EINVAL;
> > +            error_setg(errp, "Error while loading vmstate : %d", ret);
> 
> Printing ret here does not help much as ret is always -EINVAL here.
> 
> Having an error message different from qemu_file_get_error() will help more
> as it will allow reliably distinguishing these two error conditions.
Yes, maybe I can add "Migration stream has error" to the error message.
> 
> >           } else {
> >               ret = qemu_file_get_error(f);
> > +            if (ret < 0) {
> > +                error_setg(errp, "Error while loading vmstate : %d", ret);
> > +            }
> >           }
> >       }
> >       /*
> > @@ -3472,10 +3473,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
> >       f = qemu_file_new_input(QIO_CHANNEL(ioc));
> >       object_unref(OBJECT(ioc));
> > -    ret = qemu_loadvm_state(f);
> > +    ret = qemu_loadvm_state(f, errp);
> >       qemu_fclose(f);
> >       if (ret < 0) {
> > -        error_setg(errp, "loading Xen device state failed");
> > +        error_prepend(errp, "loading Xen device state failed ");
> >       }
> >       migration_incoming_state_destroy();
> >   }
> > @@ -3546,13 +3547,13 @@ bool load_snapshot(const char *name, const char *vmstate,
> >           ret = -EINVAL;
> >           goto err_drain;
> >       }
> > -    ret = qemu_loadvm_state(f);
> > +    ret = qemu_loadvm_state(f, errp);
> >       migration_incoming_state_destroy();
> >       bdrv_drain_all_end();
> >       if (ret < 0) {
> > -        error_setg(errp, "Error %d while loading VM state", ret);
> > +        error_prepend(errp, "Error %d while loading VM state ", ret);
> >           return false;
> >       }
> > diff --git a/migration/savevm.h b/migration/savevm.h
> > index fd7419e6ff90062970ed246b3ea71e6d49a6e372..a6df5198f3fe1a39fc0e6ce3e79cf7a5d8e032db 100644
> > --- a/migration/savevm.h
> > +++ b/migration/savevm.h
> > @@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
> >   void qemu_savevm_live_state(QEMUFile *f);
> >   int qemu_save_device_state(QEMUFile *f);
> > -int qemu_loadvm_state(QEMUFile *f);
> > +int qemu_loadvm_state(QEMUFile *f, Error **errp);
> >   void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> >   int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> >                              Error **errp);
> > 
> 
Regards,
Arun


