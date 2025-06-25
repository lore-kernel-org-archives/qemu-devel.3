Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4CDC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUPz6-0003tW-2x; Wed, 25 Jun 2025 09:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUPz2-0003qa-FV
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUPyw-00018X-Ls
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750857364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VHcotiHBYD7ObW+DMeQ2WgqSCFxgHg25lMmFmCABUgY=;
 b=PTq6AeYb/AoPgYcIVTzJfZS9UeudD4Z6z+0FbJ4+X2pcXAbpqOYJA8giu59NFKo1mDSjdj
 goNXixSCM/BOwggZFHuE+Eb3t7VArJmGwiGQnejWaaJpflHB5qpjIaWU8CayxKNWBI6uDi
 M1EDUDvpHU1egPF0nqOfvr2Lm2AGnPw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-nTnPkeaCM5ilZyUTk7n5fw-1; Wed, 25 Jun 2025 09:16:03 -0400
X-MC-Unique: nTnPkeaCM5ilZyUTk7n5fw-1
X-Mimecast-MFC-AGG-ID: nTnPkeaCM5ilZyUTk7n5fw_1750857362
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-234b133b428so13248945ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 06:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857362; x=1751462162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHcotiHBYD7ObW+DMeQ2WgqSCFxgHg25lMmFmCABUgY=;
 b=ks+As7RblaGGlUD7716gSQ9oIqQc1HZqEUxkssLbwcRNVMYp71YJZCxXlrFb45UHGK
 egJv1L0BpwOEcVVUAiuMFJC8cI0xzYUHcJsB4/pOZSxDfMtuZjkCYMDIFB3zvVSmcCT4
 N5pmKDZ5fN3lRKxgHyrGrFUfCoqAIsfGK1PZCClCHzO7JJY1Ns0JjkcIgVjLDvJhUNUs
 VXs1Vfdmg+zEQfxt0mlXJ3VmezbehSrfjBrgmUeqluyM4MELSqmgix4Pln16SsusB3W1
 FcPQi0Jl2bn6il+CWSl93dU0PBvg7yIUVXDOJrP0p1/gcFNEzmaec3hNdbWtOJ0vzhVb
 njpA==
X-Gm-Message-State: AOJu0Yz4nRS0+3V8RfectPaoW70WyWQXdLiluLP9LUfwSW0rn8sxqSwb
 9PeILhW51oLp41lNigSQvAJ7BgLZozN9z2WtD3UedB2rNX/RKjXqKKa6pfsrsGqzFwwYP/BO0wA
 wOvUUo/ggU5ZMtYhVpAt8dsQ0/LHeCjZd56k53Jkzvth3nEuFLV1e4eO2
X-Gm-Gg: ASbGnctiaXYA2d2DefhKdbWIa09aXc/ybZ1bU/Dm0yGb5rtm3cD6h9nEuv/kcAGkSwo
 bKWYOpb9iS3XCCmYFykSiWqIABT1YVdIw5MjnkuD1x27+bBamImcppwpPfAD1ozWp5HI5CcfBFX
 iLkl25VRlvXT5JmN/oahtZuUavcDSreR1D+9Lk0bUyHcSxl+B7eVORae+5sftnyt0tWv6D31dD/
 7M2Cm9hbDcOWvUP5ngacpTAD0aQ55KdANc/AGLvNlHLMZiXqpDv+02t8+p+G7bO1tGJOW+sE+/N
 4KYZAqgpuaNsFQ==
X-Received: by 2002:a17:902:ec90:b0:235:e8da:8d6 with SMTP id
 d9443c01a7336-2382454566fmr52740935ad.2.1750857361623; 
 Wed, 25 Jun 2025 06:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNIVuQPWX66IQYFYajVfRyRS7Vf91yoK5aL7uHY7EGTg1WU49UMoTKWk35sAs2TfjcelZv/A==
X-Received: by 2002:a17:902:ec90:b0:235:e8da:8d6 with SMTP id
 d9443c01a7336-2382454566fmr52740315ad.2.1750857361111; 
 Wed, 25 Jun 2025 06:16:01 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8640dc6sm132101475ad.146.2025.06.25.06.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:15:59 -0700 (PDT)
Date: Wed, 25 Jun 2025 09:15:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 1/3] migration: Pass error object to report it to the
 caller
Message-ID: <aFv2iVkq1gkpBeUD@x1.local>
References: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
 <20250624-propagate_tpm_error-v1-1-2171487a593d@redhat.com>
 <aFqsSFv5poQxYvkz@x1.local>
 <aFvjYivVnQYT4YPs@armenon-kvm.bengluru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFvjYivVnQYT4YPs@armenon-kvm.bengluru.csb>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Jun 25, 2025 at 05:24:10PM +0530, Arun Menon wrote:
> Hi Peter,

Hi, Arun,

[...]

> > >  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> > > @@ -2071,6 +2072,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > >  {
> > >      MigrationIncomingState *mis = migration_incoming_get_current();
> > >      QEMUFile *f = mis->from_src_file;
> > > +    Error *local_err = NULL;
> > >      int load_res;
> > >      MigrationState *migr = migrate_get_current();
> > >  
> > > @@ -2089,7 +2091,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > >      qemu_file_set_blocking(f, true);
> > >  
> > >      /* TODO: sanity check that only postcopiable data will be loaded here */
> > > -    load_res = qemu_loadvm_state_main(f, mis);
> > > +    load_res = qemu_loadvm_state_main(f, mis, &local_err);
> > 
> > Here we captured the error but ignored it.  AFAIU it'll be the same as
> > NULL..
> > 
> > Not sure if you tried to trigger such vTPM migration failure with postcopy
> > yet.  AFAIU this path will be for that.  To achieve your goal and make sure
> > the error appears for postcopy too, you may want to make use of this
> > local_err, probably by converting below (outside the diff context):
> > 
> >         qemu_file_set_error(f, load_res);
> >         ...
> >         
> >         } else {
> >             error_report("%s: loadvm failed: %d", __func__, load_res);
> >             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> >                                            MIGRATION_STATUS_FAILED);
> >         }
> > 
> > Into:
> > 
> >         error_prepend(...);
> >         migrate_set_error(s, local_err);
> > 
> > Some test will be needed to make sure it works.
> > 
> > Side note: we really should have some migration failure tests on mismatched
> > devices or device states / configs.  We have a bunch of tests under
> > migration-test.c.  Feel free to have a look if you like to add precopy /
> > postcopy unit tests for such case.  It's also ok to leave that for later -
> > I don't want to keep piling up work for you, and I already appreciate your
> > help. :)
> > 
> Yes, the postcopy errors also need to be propagated.
> I still need to figure out to build a test case around post-copy.
> Maybe we can do that in another commit/ticket.

Yes, for now it'll be good enough if the fix can cover postcopy for the
same issue.  Manual test should be OK to switch postcopy rightaway in the
wrong vTPM setup, and one should observe failure already, checking the
query-migrate on dest on errors.

It's possible that postcopy may still have an issue that might hang src
QEMU if it fails exactly at device transfer stage; I may need to have a
closer look later and see whether it's true and if it's fixable - I think
it is.  The ideal way is if device state migration failed when
postcopy_start(), then we should fail the migration and continue on src
QEMU (like a precopy failure, as postcopy hasn't yet really started).

For this specific issue, as long as the error will pop up correctly on dest
after postcopy failed, it should be good.

The auto test case can be for later.

[...]

> > > @@ -3094,27 +3099,24 @@ out:
> > >      return ret;
> > >  }
> > >  
> > > -int qemu_loadvm_state(QEMUFile *f)
> > > +int qemu_loadvm_state(QEMUFile *f, Error **errp)
> > >  {
> > >      MigrationState *s = migrate_get_current();
> > >      MigrationIncomingState *mis = migration_incoming_get_current();
> > > -    Error *local_err = NULL;
> > >      int ret;
> > >  
> > > -    if (qemu_savevm_state_blocked(&local_err)) {
> > > -        error_report_err(local_err);
> > > +    if (qemu_savevm_state_blocked(errp)) {
> > 
> > Another thing to be careful here: I didn't check whether errp can be NULL
> > here, likely it can.
> > 
> > In that case we'd better keep local_err, because error_setg() (inside of
> > qemu_savevm_state_blocked) will ignore the error otherwise..
> > 
> > static void error_setv(Error **errp,
> >                        const char *src, int line, const char *func,
> >                        ErrorClass err_class, const char *fmt, va_list ap,
> >                        const char *suffix)
> > {
> >     Error *err;
> >     int saved_errno = errno;
> > 
> >     if (errp == NULL) {
> >         return;
> >     }
> >     assert(*errp == NULL);
> >     ...
> > }
> > 
> > So here we can keep local_err but use error_propagate().
> 
> Please correct me if I am wrong, as far as I have checked,
> qemu_loadvm_state() is called at 3 places
>  - load_snapshot
>  - qmp_xen_load_devices_state
>  - process_incoming_migration_co
> and in all these functions, Error **errp is passed.
> I did not find a function that passes NULL.
> Is it still required to declare and pass a local_err object?

In that case (this should include all the callers of the three call sites
never passing in NULL) we're almost asserting errp!=NULL, then it should be
OK.

Thanks,

-- 
Peter Xu


