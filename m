Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42921C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYZX-0004ud-0D; Wed, 06 Aug 2025 03:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujYZM-0004sT-7X
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujYZK-0004pJ-82
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754465293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T0gqvoxglsh24HU1FNGc+lsTTgYZFJdPfxxnKOYetzg=;
 b=NXJ4a52IOQJKoo61GHOmIltqZM/RnK2nRnuKkFXM/Vfkixmk0CoLXPo7bmeOEdJS1Z1/ey
 WitrqfZp/FB7WZPCt/iIYvzV4aIKXNcbM1pkKL8fOSEX1LoxlMkVSEvR2mwJf07JsXEdK/
 DV+yyivz93nmogMIX9w/b4+UzBCWBmg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-e1lZIxF8OJ6zluqXGuGuEQ-1; Wed, 06 Aug 2025 03:28:11 -0400
X-MC-Unique: e1lZIxF8OJ6zluqXGuGuEQ-1
X-Mimecast-MFC-AGG-ID: e1lZIxF8OJ6zluqXGuGuEQ_1754465290
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-75ab147e0f7so6391776b3a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754465290; x=1755070090;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0gqvoxglsh24HU1FNGc+lsTTgYZFJdPfxxnKOYetzg=;
 b=N2yNoJZAsu+4Z5Or2LXvDKHi16Gt6Yo8cA0oUIFPfrUIDvA3gSonE/vc6U+6g6kaQ1
 tS6tChbnnB59G9mRjU4N5YTgUSVc7itdKemXL+SE0bIoucO/0+dbm7L+yU69aKC36ivt
 SQipr2kfb2+Cxid24u4GCIYuvehXUWIgAaZkItz9JeO5TnsypSHow/IZsLZFtB32Kg0K
 ZrHgR/AuhZj6jmCn3hBqWjkwzkDjdTamP0QLdQQQ0FTUdQydv9zMg4cmwjMefN+pF5Ae
 eRF9dFZ+27QvR8oDGMklqMNWFbI1GRMGbaGzd/Yu3glnFrkKWcgrI/to7jHt7ey7xAj8
 kqRA==
X-Gm-Message-State: AOJu0Yy+9tOZ6hewmTAvtyvfnX6cOUm/Zl7e74PPtNsha9e7qgioD4FA
 nxjp9eYilpoBQxye/BIUmkzRv2FdpAWp6Y4gaxNCfEqzM7V29BveM9Ksp0vlQsyhf3d7jejOCK7
 NsvLLkN0C2ZymS+V5sFJkmTM7PyjUWUWgiRcYm5RULVb3eR60dA5Gnb6G
X-Gm-Gg: ASbGncsmKWYZbsBqziMuREWkzl+e6fkSd0AKfd8P7Pfm6fjL/Tlwrc+4zWNyiFdZkJx
 1hy22hXRAbOV4yoj9y0vbFA0uOWETHRd91xad6quSsaloEvk9xJRCWf2juie++v//121SewBrij
 k6a6bpAzUlZxGEvxdxU8EAnTbbs7PCt692ETSSLqHw1+naog93OF5LgZ7tsmMHQxNyRkzFKdhny
 5wzYSJVFYJEsEO/OY/l+pWS2++EzeAF0Tczt+a5NIxtXI+isy/HgnVoqwaJYBamPGL1zazHQ0Ls
 LUJpFk3+ExvD+QifpnY3zFcYKg/IzRhgEWn+dj6LesAtgZJvYJYLxw==
X-Received: by 2002:a05:6a00:18a8:b0:76b:e936:607 with SMTP id
 d2e1a72fcca58-76c29b2b12fmr2303561b3a.0.1754465290314; 
 Wed, 06 Aug 2025 00:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2CbVlBbkBE/l+Ewi3Wt+TN82BIAfsGyUBxD5AySxoN9kno1EQyK16arZ7busbTDNUxC2bKQ==
X-Received: by 2002:a05:6a00:18a8:b0:76b:e936:607 with SMTP id
 d2e1a72fcca58-76c29b2b12fmr2303528b3a.0.1754465289870; 
 Wed, 06 Aug 2025 00:28:09 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.249])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bdc8c7661sm12404539b3a.76.2025.08.06.00.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 00:28:09 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:57:57 +0530
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
Subject: Re: [PATCH v9 26/27] migration: Add error-parameterized function
 variants in VMSD struct
Message-ID: <aJMD_Y5jUuWG4ucX@armenon-kvm.bengluru.csb>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-26-123450810db7@redhat.com>
 <fa7bcb8f-03c1-4528-ae67-b7b8c5d6f443@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa7bcb8f-03c1-4528-ae67-b7b8c5d6f443@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 06, 2025 at 02:45:01PM +0900, Akihiko Odaki wrote:
> On 2025/08/06 3:25, Arun Menon wrote:
> > - We need to have good error reporting in the callbacks in
> >    VMStateDescription struct. Specifically pre_save, post_save,
> >    pre_load and post_load callbacks.
> > - It is not possible to change these functions everywhere in one
> >    patch, therefore, we introduce a duplicate set of callbacks
> >    with Error object passed to them.
> > - So, in this commit, we implement 'errp' variants of these callbacks,
> >    introducing an explicit Error object parameter.
> > - This is a functional step towards transitioning the entire codebase
> >    to the new error-parameterized functions.
> > - Deliberately called in mutual exclusion from their counterparts,
> >    to prevent conflicts during the transition.
> > - New impls should preferentally use 'errp' variants of
> >    these methods, and existing impls incrementally converted.
> >    The variants without 'errp' are intended to be removed
> >    once all usage is converted.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   docs/devel/migration/main.rst | 24 ++++++++++++++++++++++++
> >   include/migration/vmstate.h   | 15 +++++++++++++++
> >   migration/vmstate.c           | 34 ++++++++++++++++++++++++++++++----
> >   3 files changed, 69 insertions(+), 4 deletions(-)
> > 
> > diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> > index 6493c1d2bca48a2fa34d92f6c0979c215c56b8d5..35bf5ae26c87f3c82964eb15618be373ab5a41fc 100644
> > --- a/docs/devel/migration/main.rst
> > +++ b/docs/devel/migration/main.rst
> > @@ -444,6 +444,30 @@ The functions to do that are inside a vmstate definition, and are called:
> >     This function is called after we save the state of one device
> >     (even upon failure, unless the call to pre_save returned an error).
> > +Following are the errp variants of these functions.
> > +
> > +- ``int (*pre_load_errp)(void *opaque, Error **errp);``
> > +
> > +  This function is called before we load the state of one device.
> > +
> > +- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
> > +
> > +  This function is called after we load the state of one device.
> > +
> > +- ``int (*pre_save_errp)(void *opaque, Error **errp);``
> > +
> > +  This function is called before we save the state of one device.
> > +
> > +- ``int (*post_save_errp)(void *opaque, Error **errp);``
> > +
> > +  This function is called after we save the state of one device
> > +  (even upon failure, unless the call to pre_save returned an error).
> 
> Reviewing "[PATCH v9 24/27] migration: Propagate last encountered error in
> vmstate_save_state_v() function", I wondered why it has never been a problem
> post_load(), and this says only post_save_errp() is called upon failure.
> 
> Now I suspect it may be better to clarify their differences and avoid
> introducing post_save_errp() instead.
> 
> My guess is that post_save_errp() is being introduced for consistency with
> post_load(), but they cannot have "consistency" if post_load() and
> post_save() are not corresponding functions of save/load but are independent
> two functions. Perhaps the true problem here is that post_load() and
> post_save() look similar; if so, that can be solved by:
> - Renaming post_save() to e.g., cleanup_save()
> - Changing it to return void
> 
That is insightful. I agree. It was introduced because of the nomenclature. 
From what I have seen, the functionality indeed differs, in the sense that,
currently post_load does some sanity checks after loading the device state,
and therefore it can fail and return an error; whereas post_save is not known
to fail until now.

It is therefore possible to implement your suggestion : renaming it to
cleanup_save and returning void. This will avoid us in having the extra
patch 24/27.
While I have deviated a bit from TPM backend to make these changes in the
migration module, I believe they are important and hope the maintainers
will agree.

> > +
> > +New impls should preferentally use 'errp' variants of these
> > +methods and existing impls incrementally converted.
> > +The variants without 'errp' are intended to be removed
> > +once all usage is converted.
> > +
> >   Example: You can look at hpet.c, that uses the first three functions
> >   to massage the state that is transferred.
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a..51baf6c7f9d061ee33949d7e798f2184e50b4cbf 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -200,15 +200,30 @@ struct VMStateDescription {
> >        * exclusive. For this reason, also early_setup VMSDs are migrated in a
> >        * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
> >        * a QEMU_VM_SECTION_START section.
> > +     *
> > +     * There are duplicate impls of the post/pre save/load hooks.
> > +     * New impls should preferentally use 'errp' variants of these
> > +     * methods and existing impls incrementally converted.
> > +     * The variants without 'errp' are intended to be removed
> > +     * once all usage is converted.
> > +     *
> > +     * For the errp variants,
> > +     * Returns: 0 on success,
> > +     *          <0 on error where -value is an error number from errno.h
> >        */
> > +
> >       bool early_setup;
> >       int version_id;
> >       int minimum_version_id;
> >       MigrationPriority priority;
> >       int (*pre_load)(void *opaque);
> > +    int (*pre_load_errp)(void *opaque, Error **errp);
> >       int (*post_load)(void *opaque, int version_id);
> > +    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
> >       int (*pre_save)(void *opaque);
> > +    int (*pre_save_errp)(void *opaque, Error **errp);
> >       int (*post_save)(void *opaque);
> > +    int (*post_save_errp)(void *opaque, Error **errp);
> >       bool (*needed)(void *opaque);
> >       bool (*dev_unplug_pending)(void *opaque);
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index 569e66ea983f833e6a0d651d2a751f34a64e8f5c..0acaa855cfec8ddac63e33d4562e39c345856213 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -152,7 +152,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >           trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
> >           return -EINVAL;
> >       }
> > -    if (vmsd->pre_load) {
> > +    if (vmsd->pre_load_errp) {
> > +        ret = vmsd->pre_load_errp(opaque, errp);
> > +        if (ret) {
> > +            error_prepend(errp, "VM pre load failed for: '%s', "
> > +                          "version_id: %d, minimum version_id: %d, "
> > +                          "ret: %d: ", vmsd->name, vmsd->version_id,
> > +                          vmsd->minimum_version_id, ret);
> > +            return ret;
> > +        }
> > +    } else if (vmsd->pre_load) {
> >           ret = vmsd->pre_load(opaque);
> >           if (ret) {
> >               error_setg(errp, "VM pre load failed for: '%s', "
> > @@ -242,7 +251,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
> >           qemu_file_set_error(f, ret);
> >           return ret;
> >       }
> > -    if (vmsd->post_load) {
> > +    if (vmsd->post_load_errp) {
> > +        ret = vmsd->post_load_errp(opaque, version_id, errp);
> > +        if (ret < 0) {
> > +            error_prepend(errp, "VM Post load failed for: %s, version_id: %d, "
> > +                          "minimum_version: %d, ret: %d: ", vmsd->name,
> > +                          vmsd->version_id, vmsd->minimum_version_id, ret);
> > +        }
> > +    } else if (vmsd->post_load) {
> >           ret = vmsd->post_load(opaque, version_id);
> >           if (ret < 0) {
> >               error_setg(errp,
> > @@ -411,8 +427,16 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
> >   static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaque,
> >                                Error **errp)
> >   {
> > +    ERRP_GUARD();
> >       int ret = 0;
> > -    if (vmsd->pre_save) {
> > +    if (vmsd->pre_save_errp) {
> > +        ret = vmsd->pre_save_errp(opaque, errp);
> > +        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> > +        if (ret) {
> > +            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
> > +                          vmsd->name, ret);
> > +        }
> > +    } else if (vmsd->pre_save) {
> >           ret = vmsd->pre_save(opaque);
> >           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> >           if (ret) {
> > @@ -427,7 +451,9 @@ static int post_save_dispatch(const VMStateDescription *vmsd, void *opaque,
> >                                 Error **errp)
> >   {
> >       int ret = 0;
> > -    if (vmsd->post_save) {
> > +    if (vmsd->post_save_errp) {
> > +        ret = vmsd->post_save_errp(opaque, errp);
> > +    } else if (vmsd->post_save) {
> >           ret = vmsd->post_save(opaque);
> >           error_setg(errp, "post-save for %s failed, ret: %d",
> >                      vmsd->name, ret);
> > 
> 
Regards,
Arun


