Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BA3C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWygB-0001SS-1R; Wed, 02 Jul 2025 10:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWyfX-00018X-S1
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uWyfT-0006ZQ-PV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751467351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJl/C9P5GaavsVIP4cckIrt90JYuwS63iqRFxWfnJs0=;
 b=YeDEMRHno3YG6+XtMriLCK5YR3H/E0FdnT8EFH5fGjjZ+Twjln4gZaMrujc/ZmV3MSuII9
 svpx3FBPtu4QYqP7fThDot8DkIRHuHdHUYrWRjbg/fjXNquzgd6Ahw4FuiHeIB7HpvEKLr
 xFkz9WJ8VZhRag1BQOrRe1R0v4sZz54=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-mUXO0sCjNjOTAt_ZOD5OwA-1; Wed, 02 Jul 2025 10:42:30 -0400
X-MC-Unique: mUXO0sCjNjOTAt_ZOD5OwA-1
X-Mimecast-MFC-AGG-ID: mUXO0sCjNjOTAt_ZOD5OwA_1751467350
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-234a102faa3so51005675ad.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467349; x=1752072149;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VJl/C9P5GaavsVIP4cckIrt90JYuwS63iqRFxWfnJs0=;
 b=AjxnQvaDtCruZUgyy+krEfwfY9Y4n+ypS/eXD+tTsCGd9IjI5cZVHbrnafbyzAyito
 ThzfvLo8Avxlg1gsznIEkZzv+27JbevR+5NDVp2dqkRrrRfbbyDzfkqPkX8EdtybOxUQ
 jsBrzSLTDt3H/PwaevByu2KEyGflpJuAtJut5n1XAnWEqXNgEP5SS4akBbFOtdBcpIPM
 CxaKZl6Ye2Gwup35dqQEpr25FKhpT5R17Gyq3jzVHepMB0r1cbShMcntpdJdygpki1fh
 RjTn43KrTyZJj1uYoQNdQE8DtMw5JpE45zs9TDWWoD2GbsHWJuzi88bETNaq4lWITVXh
 yRhg==
X-Gm-Message-State: AOJu0YyQNkdTeB5OeRphW7t1Fg8cnaGvOLmX3sg7E9jwDF517xWFMQMu
 ozwhQv9ORpQx4URl5SJ/7JDhi8r9fxGiPuDuAdjK5zkiKJlp280s80aJHiH28p53hk3GnxJHZ7L
 +WEbVxosJOig9N+j3Rtw8xxN8o1U0OsDECVcBkINRM9dWPMOUSHwNJ/M4
X-Gm-Gg: ASbGncv+o74iE5lFLZNH/dLGUORL17i8m7gHmQmYSXSg+CT+nMasNqa2+shD11DNnvG
 gCVOHRtq9UVb35Wf1D/Vwmwa09Cg/AEmBN1Dudz8PnHIEUEyp0ha/WXrsj9SkYq4+6BsOeWus1C
 SuNV4UPYKHByY3P9taLqzD/u50KiJbmT9hatMLl1cqZ1ea73k2EHuzcMJNZFbpsfqlNjexutAnt
 dVtvoqieNqkqUlyE4OSYGbWIyjcF5Mc2FMIWuWLlt0x8c9t8rukoRVb3iJu9ak4amexjDQVi2ZI
 USGImbLN8p3NBcUEIikmiHyTdTGCz954lok=
X-Received: by 2002:a17:903:1ac4:b0:234:c549:da13 with SMTP id
 d9443c01a7336-23c6e5023camr45286965ad.17.1751467348774; 
 Wed, 02 Jul 2025 07:42:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuXr4cQMunZPbViQ7cfVVhHa4cBvMwuxJDuQ0LwlzYE1wEFaN6iEbU9fQf5t36PWz8j1Ibig==
X-Received: by 2002:a17:903:1ac4:b0:234:c549:da13 with SMTP id
 d9443c01a7336-23c6e5023camr45286345ad.17.1751467348246; 
 Wed, 02 Jul 2025 07:42:28 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e325bsm133330675ad.29.2025.07.02.07.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 07:42:27 -0700 (PDT)
Date: Wed, 2 Jul 2025 20:12:13 +0530
From: Arun Menon <armenon@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
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
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] migration: Pass Error object errp into vm state
 loading functions
Message-ID: <aGVFRe0k9X9qsgJn@armenon-kvm.bengluru.csb>
References: <20250702-propagate_tpm_error-v3-0-986d94540528@redhat.com>
 <20250702-propagate_tpm_error-v3-1-986d94540528@redhat.com>
 <aGUhU_Sjsp68oTWp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGUhU_Sjsp68oTWp@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

Thanks for the review.

On Wed, Jul 02, 2025 at 01:08:51PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jul 02, 2025 at 05:06:50PM +0530, Arun Menon wrote:
> > - This is an incremental step in converting vmstate loading
> >   code to report errors.
> > - Minimal changes to the signature and body of the following
> >   functions are done,
> >   - vmstate_load()
> >   - vmstate_load_state()
> >   - vmstate_subsection_load()
> >   - qemu_load_device_state()
> >   - qemu_loadvm_state()
> >   - qemu_loadvm_section_start_full()
> >   - qemu_loadvm_section_part_end()
> >   - qemu_loadvm_state_header()
> >   - qemu_loadvm_state_main()
> > - error_report() has been replaced with error_setg();
> >   and in places where error has been already set,
> >   error_prepend() is used to not lose information.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  hw/display/virtio-gpu.c     |   2 +-
> >  hw/pci/pci.c                |   2 +-
> >  hw/s390x/virtio-ccw.c       |   2 +-
> >  hw/scsi/spapr_vscsi.c       |   2 +-
> >  hw/vfio/pci.c               |   2 +-
> >  hw/virtio/virtio-mmio.c     |   2 +-
> >  hw/virtio/virtio-pci.c      |   2 +-
> >  hw/virtio/virtio.c          |   4 +-
> >  include/migration/vmstate.h |   2 +-
> >  migration/colo.c            |  13 +++--
> >  migration/cpr.c             |   2 +-
> >  migration/migration.c       |  19 ++++--
> >  migration/savevm.c          | 137 +++++++++++++++++++++++++++-----------------
> >  migration/savevm.h          |   7 ++-
> >  migration/vmstate-types.c   |  10 ++--
> >  migration/vmstate.c         |  40 +++++++------
> >  tests/unit/test-vmstate.c   |  18 +++---
> >  17 files changed, 158 insertions(+), 108 deletions(-)
> > 
> 
> > diff --git a/migration/colo.c b/migration/colo.c
> > index e0f713c837f5da25d67afbd02ceb6c54024ca3af..808c980b4af3199968771cdc6cca3c2451a2f4a6 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
> >  static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >                        QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      uint64_t total_size;
> >      uint64_t value;
> >      Error *local_err = NULL;
> > @@ -686,11 +687,13 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >  
> >      bql_lock();
> >      cpu_synchronize_all_states();
> > -    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> > +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, &local_err);
> >      bql_unlock();
> >  
> >      if (ret < 0) {
> > -        error_setg(errp, "Load VM's live state (ram) error");
> > +        if (local_err != NULL) {
> > +            error_prepend(errp, "Load VM's live state (ram) error");
> > +        }
> 
> This doesn't look right to me.
> 
> The old code would unconditionally report an error, but this code
> now only appends an error if 'qemu_loadvm_state_main' already
> reported an error - if 'qemu_loadvm_state_main' was silent this
> method reports nothing too.
> 
> IMHO this is a bad design for qemu_loadvm_state_main - when we
> add an 'errp' to that method we *MUST* ensure it fills that
> in *all* possible error code paths.

I understand.
In one of my previous patches, I had both the cases covered 
(in a different file though, migration.c).
Something like, https://lore.kernel.org/qemu-devel/20250624-propagate_tpm_error-v1-2-2171487a593d@redhat.com/

        if (local_err) {
            error_prepend(&local_err, "load of migration failed: %s: ",
                          strerror(-ret));
        } else {
            error_setg(&local_err, "load of migration failed: %s",
                       strerror(-ret));
        }

So in either case, the error will be set.
But now I see. We must to set errp, if it is passed in a method.
That way we can unconditionally use error_prepend().
Also, way we avoid the extra NULL checks.

> 
> This code should then unconditionally use error_prepend().
> 
> >          return;
> >      }
> >  
> > @@ -729,9 +732,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
> >      bql_lock();
> >      vmstate_loading = true;
> >      colo_flush_ram_cache();
> > -    ret = qemu_load_device_state(fb);
> > +    ret = qemu_load_device_state(fb, &local_err);
> >      if (ret < 0) {
> > -        error_setg(errp, "COLO: load device state failed");
> > +        if (*errp != NULL) {
> > +            error_prepend(errp, "COLO: load device state failed");
> > +        }
> 
> Same flawed design here - qemu_load_device_state must guarantee it always
> fills its 'errp' parameter on failure code paths.
> 
> There are more instances of this general error reporting problem through
> this patch
> 
> IMHO this patch is changing too many methods at once to be confident when
> reviewing it.
> 
> This would be better changing 1 single method and its *immediate* callers
> only.
> 
> IOW, if we have a sequence a() -> b() -> c() -> d() all of which
> currently use 'error_report', don't try to change the whole call
> chain at once.
> 
> First add an "errp' to 'd()', and make 'c()' use 'error_report_err'.
> Then add an "errp' to 'c'()', and make 'b()' use 'error_report_err',
> ...repeat..

I understand.

> 
> This is what I tried todo previously to address this problem in
> migration code
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2021-02/msg01727.html
> 
> Though those patches are horribly outdated now, so can't be used as
> is, IMHO they show the right kind of incremental conversion
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

I see your point. Thank you.
I am going to try that way of having a sequence of changes instead 
of changing the whole call chain at once. 
I think I will have to modify more methods in doing so.


Regards,
Arun


