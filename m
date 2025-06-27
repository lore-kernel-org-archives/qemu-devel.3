Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C28C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 13:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8ii-0005zT-Va; Fri, 27 Jun 2025 09:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uV8ig-0005yh-Pg
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uV8ia-0005ny-P4
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 09:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751029330;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qYtnGXfWycl1Zi5Xt1fWTjVwNn6Etd4q+emR+q+5ees=;
 b=iWm5Jys3q+foBv5lmx3+igyI9E87HepHWhL+I6Ku+eNTfLcnqkIiIVtyIXHsg/5YB+FGfE
 RwUaLeFTyTn+8fa/y2fX7/G3eHhRFyIaPZlGH/YlhibveCYDdT1Lwx9FKI193NBauYd9j4
 pqvR38yk9xs5sohCr0w7/+tkQE2JJEU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-jyOqVdo1PlawaNybh0qMxA-1; Fri, 27 Jun 2025 09:02:09 -0400
X-MC-Unique: jyOqVdo1PlawaNybh0qMxA-1
X-Mimecast-MFC-AGG-ID: jyOqVdo1PlawaNybh0qMxA_1751029328
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-74880a02689so1798514b3a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 06:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751029328; x=1751634128;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYtnGXfWycl1Zi5Xt1fWTjVwNn6Etd4q+emR+q+5ees=;
 b=N/jQSeGbzhrsD1mJjc2dmreWpKYoHFuYxcn+EvaRmSE7udwn5UCP2NwgBlSQO7Q1Nm
 n/19rvRXCXkFgjqvaRNbAa8LYXDDT5jPQyhMhO5oLsKk8Kq3L+36dvxaiYyiUzW1adRQ
 dfpSHiVgtEkX6+yxJNJpmjltwjFLPvYXBkaDa5tPu7E155bedrs6CLeNgBzciDxZuE1j
 C7cX9+umcRKyyKr5aNAK3gvUAj4RwV8dduSAv3dgu1azvH7+BXsQpf1QWAT1c0fYpgSF
 apYWBWblvspgqQbSNbk49HtcL/6WL226m0geGE92hSg4+a/Spe61VRZcgkoPWphwAihD
 ieqA==
X-Gm-Message-State: AOJu0YwUPDvkfNwtxV8lP17utLohU/9Mv7lK8YeTT6snDBDxPqDcyMxr
 ByhvOPnVv/+6aZEtYQwVYnPBc5xi3ku0nJ6tpIEbwOPY9utfovVGyVzhmm+2MQR2jbATFlZYrV4
 vLy+0FoiH+d1CEL+GwTH+ktjwsRkn1iTX4jwW8RevIxpxFObikuv9zxm5
X-Gm-Gg: ASbGncskBFeGnzAP3lJ5ooTrhQtnioxeEbJ0YreXvs1IURicghtfus7+LOf5suxD+Ct
 rYbEU3Ci2geYEZDLKO2Cy9f24a7Zp9Tq/VCK7X8rI91pVnA/kAodpojB6VBZaBaxR+X64iUjbXy
 gb4deA8wdTUxzC7923RoG8oDNt4oUSI3olJXi5oEDrOq5k74ZIohS6GHwzBDZavBc2mjcFWUTEl
 4dff5Tvco75cOpfS4JrzknWKbBqzKgNg0l8t7Zy/OK/bF5ZN7zhIY4o8yrLfEeVUOrY2xyg+8Nf
 fuZdXHbV25zcWsQIJmaRbuUUTyINrk5s
X-Received: by 2002:a05:6a20:1582:b0:1f5:7ea8:a791 with SMTP id
 adf61e73a8af0-220a12b94bdmr4838149637.10.1751029327822; 
 Fri, 27 Jun 2025 06:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPoqjTydjTEovNlXlODY/rv3leUG6Rb2IeQ6otQGiu9a/Dc+GI4+IvDTQD5gOS+IwWsc2SBw==
X-Received: by 2002:a05:6a20:1582:b0:1f5:7ea8:a791 with SMTP id
 adf61e73a8af0-220a12b94bdmr4838056637.10.1751029327056; 
 Fri, 27 Jun 2025 06:02:07 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af57efae1sm2260951b3a.163.2025.06.27.06.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 06:02:06 -0700 (PDT)
Date: Fri, 27 Jun 2025 18:31:56 +0530
From: Arun Menon <armenon@redhat.com>
To: Peter Xu <peterx@redhat.com>
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
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 1/3] migration: Pass error object to report it to the
 caller
Message-ID: <aF6WRKeLeRShB9OP@armenon-kvm.bengluru.csb>
References: <20250624-propagate_tpm_error-v1-0-2171487a593d@redhat.com>
 <20250624-propagate_tpm_error-v1-1-2171487a593d@redhat.com>
 <aFqsSFv5poQxYvkz@x1.local>
 <aFvjYivVnQYT4YPs@armenon-kvm.bengluru.csb>
 <aFv2iVkq1gkpBeUD@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFv2iVkq1gkpBeUD@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

Thanks for the comments.
Updated in v2. 
Note: I have included a null check in the fail statement of
migration coroutine as well.
This is so that there are no dereferencing
issue in case local_err is not set in any of the paths.
(error_report_err call dereferences the err->msg)


On Wed, Jun 25, 2025 at 09:15:53AM -0400, Peter Xu wrote:
> On Wed, Jun 25, 2025 at 05:24:10PM +0530, Arun Menon wrote:
> > Hi Peter,
> 
> Hi, Arun,
> 
> [...]
> 
> > > >  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> > > > @@ -2071,6 +2072,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > > >  {
> > > >      MigrationIncomingState *mis = migration_incoming_get_current();
> > > >      QEMUFile *f = mis->from_src_file;
> > > > +    Error *local_err = NULL;
> > > >      int load_res;
> > > >      MigrationState *migr = migrate_get_current();
> > > >  
> > > > @@ -2089,7 +2091,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
> > > >      qemu_file_set_blocking(f, true);
> > > >  
> > > >      /* TODO: sanity check that only postcopiable data will be loaded here */
> > > > -    load_res = qemu_loadvm_state_main(f, mis);
> > > > +    load_res = qemu_loadvm_state_main(f, mis, &local_err);
> > > 
> > > Here we captured the error but ignored it.  AFAIU it'll be the same as
> > > NULL..
> > > 
> > > Not sure if you tried to trigger such vTPM migration failure with postcopy
> > > yet.  AFAIU this path will be for that.  To achieve your goal and make sure
> > > the error appears for postcopy too, you may want to make use of this
> > > local_err, probably by converting below (outside the diff context):
> > > 
> > >         qemu_file_set_error(f, load_res);
> > >         ...
> > >         
> > >         } else {
> > >             error_report("%s: loadvm failed: %d", __func__, load_res);
> > >             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > >                                            MIGRATION_STATUS_FAILED);
> > >         }
> > > 
> > > Into:
> > > 
> > >         error_prepend(...);
> > >         migrate_set_error(s, local_err);
> > > 
> > > Some test will be needed to make sure it works.
> > > 
> > > Side note: we really should have some migration failure tests on mismatched
> > > devices or device states / configs.  We have a bunch of tests under
> > > migration-test.c.  Feel free to have a look if you like to add precopy /
> > > postcopy unit tests for such case.  It's also ok to leave that for later -
> > > I don't want to keep piling up work for you, and I already appreciate your
> > > help. :)
> > > 
> > Yes, the postcopy errors also need to be propagated.
> > I still need to figure out to build a test case around post-copy.
> > Maybe we can do that in another commit/ticket.
> 
> Yes, for now it'll be good enough if the fix can cover postcopy for the
> same issue.  Manual test should be OK to switch postcopy rightaway in the
> wrong vTPM setup, and one should observe failure already, checking the
> query-migrate on dest on errors.

I need to package this version of qemu and try it on beaker machine,
in order to have 2 bare metal instances for migration.
I tried locally, running 2 QEMU instances, but it fails because of 
a file descriptor error, probably because I am using the same 
qcow2 image to spin the vm.
If there is any better way to do it, please let me know. 
Up until now I was saving the state in to a file and restoring from it.
I suppose postcopy requires the migration to be "live", and 2 running
qemu instances are necessary.

> 
> It's possible that postcopy may still have an issue that might hang src
> QEMU if it fails exactly at device transfer stage; I may need to have a
> closer look later and see whether it's true and if it's fixable - I think
> it is.  The ideal way is if device state migration failed when
> postcopy_start(), then we should fail the migration and continue on src
> QEMU (like a precopy failure, as postcopy hasn't yet really started).

Yes the source QEMU hangs while trying with 2 qemu instances on the same machine,
attached to 2 separate vTPM devices (encrypted with differen secrets).
I suppose exit-on-error does not apply to the postcopy-ram capability because
the destination QEMU exited.

> 
> For this specific issue, as long as the error will pop up correctly on dest
> after postcopy failed, it should be good.
> 
> The auto test case can be for later.
> 
> [...]
> 
> > > > @@ -3094,27 +3099,24 @@ out:
> > > >      return ret;
> > > >  }
> > > >  
> > > > -int qemu_loadvm_state(QEMUFile *f)
> > > > +int qemu_loadvm_state(QEMUFile *f, Error **errp)
> > > >  {
> > > >      MigrationState *s = migrate_get_current();
> > > >      MigrationIncomingState *mis = migration_incoming_get_current();
> > > > -    Error *local_err = NULL;
> > > >      int ret;
> > > >  
> > > > -    if (qemu_savevm_state_blocked(&local_err)) {
> > > > -        error_report_err(local_err);
> > > > +    if (qemu_savevm_state_blocked(errp)) {
> > > 
> > > Another thing to be careful here: I didn't check whether errp can be NULL
> > > here, likely it can.
> > > 
> > > In that case we'd better keep local_err, because error_setg() (inside of
> > > qemu_savevm_state_blocked) will ignore the error otherwise..
> > > 
> > > static void error_setv(Error **errp,
> > >                        const char *src, int line, const char *func,
> > >                        ErrorClass err_class, const char *fmt, va_list ap,
> > >                        const char *suffix)
> > > {
> > >     Error *err;
> > >     int saved_errno = errno;
> > > 
> > >     if (errp == NULL) {
> > >         return;
> > >     }
> > >     assert(*errp == NULL);
> > >     ...
> > > }
> > > 
> > > So here we can keep local_err but use error_propagate().
> > 
> > Please correct me if I am wrong, as far as I have checked,
> > qemu_loadvm_state() is called at 3 places
> >  - load_snapshot
> >  - qmp_xen_load_devices_state
> >  - process_incoming_migration_co
> > and in all these functions, Error **errp is passed.
> > I did not find a function that passes NULL.
> > Is it still required to declare and pass a local_err object?
> 
> In that case (this should include all the callers of the three call sites
> never passing in NULL) we're almost asserting errp!=NULL, then it should be
> OK.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 


Thanks,
Arun


