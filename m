Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1B7C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPeo-0008Le-MF; Mon, 28 Jul 2025 11:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ugPeU-0006vR-Vg
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ugPeQ-0008O0-R8
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753716028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CN5vFE1/ZeFO2kEG0TusmN+VOR4Iu2MM19cZIreCUDU=;
 b=YsfIddYWAVhAbAMLVEuZhK+XZM4PZKXI2kIOSLzOFLinyBCnXlqA9v0tANEFjyKf/7jySg
 NyuWchl2c8fpXwYMOlFPwaYQvtUZE/S30VbRiqgDWBsOCjnX5mc1wANupWxRDfjlIvh+zB
 OH52CoXxEtkUbOJq+YBVflOJpXhV4gI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-nrhj3bP8NuyfHhqdht9z5A-1; Mon, 28 Jul 2025 11:20:26 -0400
X-MC-Unique: nrhj3bP8NuyfHhqdht9z5A-1
X-Mimecast-MFC-AGG-ID: nrhj3bP8NuyfHhqdht9z5A_1753716026
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-748f3613e6aso2761193b3a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753716025; x=1754320825;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CN5vFE1/ZeFO2kEG0TusmN+VOR4Iu2MM19cZIreCUDU=;
 b=kiJRP8rfJ79ebJg5Fs2vyLJIkuBsESsyb7UuHj0fVj1WxZezZnmaUFq6X2QXQaMZAl
 6CBdhysiURPb/66ELoSX3oe8w0fOwlRZnNsGccgmfNkm8DMuUVpPZ6g53bHkReBx8TZa
 MaNZAn4SBXdF1dKuXzaora81Z8MZkUuCMuSxwRm0KIw8OzCrkFB+zHQoszEZ6TAz9WHz
 raSFBMW0/7MrsuJ6liAzXmN2ePFDQ33u40+HSVcqsIuXfFT7YsPR1A8Lhl2ePnWf8+A3
 3oRB9tkTB/WTDqXsGK2cYbUXYLRtvJdi5MfdCj4Q3OQkayiEFLmsWKTOaQM/gkVM1/Wa
 YeWQ==
X-Gm-Message-State: AOJu0YybPGWAnD5wg08QGrbdpm+WCT1zU4RVrBqqXpWQYNP+67ihkf8z
 W5JqWDB21Soiy7ohv5vQ1bH9FqxLTlhCwWMJzWufTtO3zKXxRlXbqq/mon1D0NxM5OGi1keZ+XH
 eMmMhqE8b+aHQsvpPwIsf77rWsySz3dCfkcAGRoWxLSTE3L44nIyhr8Ta
X-Gm-Gg: ASbGncvJcASWoKDF3707dtz0i1vekF7gs3TF3KOaP7yp8SN53mrqy5eSa+ouDgEuIAI
 WVHngoPhCsMFdDt9l+CpM0ZdmBY/c1CXcwjI75jWO/dX+FDDlvZRRtLtiaxpfTIw/sSEXCAu7Zg
 j3M4L6sI+ZK4zflvjwdwZ3LKY9pMOfjcrIEtK2ej6yGO9FvojQNCAMDeYLGf/Ky16PfL03/irTm
 8qH8CdpuDhqgXpX0RWhIiIxxFLPfiMe4dQOZjCiqdKdg/05M/nWyjLAaX8pyxGYRhkyfmneYxIm
 a+9I1BdVcnGp8OWVqYPLRSUxf7GtA6GFRmmjmPTkiIx3BjMpfLj+
X-Received: by 2002:a05:6a00:218e:b0:74e:ab25:a936 with SMTP id
 d2e1a72fcca58-763346c65e3mr15221273b3a.17.1753716025359; 
 Mon, 28 Jul 2025 08:20:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtWKXdqfgv5XRq0VF4ueqWR6vLI/PRd2t3oEDn4NFBgIhA2TAXtO+JDrn+3mHi5x0llwZU0w==
X-Received: by 2002:a05:6a00:218e:b0:74e:ab25:a936 with SMTP id
 d2e1a72fcca58-763346c65e3mr15221216b3a.17.1753716024610; 
 Mon, 28 Jul 2025 08:20:24 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-766cc11bfd6sm3935250b3a.74.2025.07.28.08.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 08:20:24 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:50:06 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
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
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v7 23/24] migration: Add error-parameterized function
 variants in VMSD struct
Message-ID: <aIeVJsx5wqJxokkK@armenon-kvm.bengluru.csb>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-23-d52704443975@redhat.com>
 <CAMxuvazqVEAM_7=P9fA=7mbeLp3gYbjqaDMVnMXBQKD8xuX4Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazqVEAM_7=P9fA=7mbeLp3gYbjqaDMVnMXBQKD8xuX4Yw@mail.gmail.com>
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

Hi Marc-André,
Thanks for the review.

On Mon, Jul 28, 2025 at 03:07:25PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jul 25, 2025 at 4:22 PM Arun Menon <armenon@redhat.com> wrote:
> 
> > - We need to have good error reporting in the callbacks in
> >   VMStateDescription struct. Specifically pre_save, post_save,
> >   pre_load and post_load callbacks.
> > - It is not possible to change these functions everywhere in one
> >   patch, therefore, we introduce a duplicate set of callbacks
> >   with Error object passed to them.
> > - So, in this commit, we implement 'errp' variants of these callbacks,
> >   introducing an explicit Error object parameter.
> > - This is a functional step towards transitioning the entire codebase
> >   to the new error-parameterized functions.
> > - Deliberately called in mutual exclusion from their counterparts,
> >   to prevent conflicts during the transition.
> > - New impls should preferentally use 'errp' variants of
> >   these methods, and existing impls incrementally converted.
> >   The variants without 'errp' are intended to be removed
> >   once all usage is converted.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  include/migration/vmstate.h | 11 ++++++++
> >  migration/vmstate.c         | 62
> > +++++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 65 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index
> > 056781b1c21e737583f081594d9f88b32adfd674..53fa72c1bbde399be02c88fc8745fdbb79bfd7c8
> > 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -200,15 +200,26 @@ struct VMStateDescription {
> >       * exclusive. For this reason, also early_setup VMSDs are migrated in
> > a
> >       * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated
> > in
> >       * a QEMU_VM_SECTION_START section.
> > +     *
> > +     * There are duplicate impls of the post/pre save/load hooks.
> > +     * New impls should preferentally use 'errp' variants of these
> > +     * methods and existing impls incrementally converted.
> > +     * The variants without 'errp' are intended to be removed
> > +     * once all usage is converted.
> >
> 
> It is not documented, but I think all the callbacks return value should be
> 0 on success, <0 on error with -value an error number from errno.h. Could
> you document it?
Sure. I shall add it in the header file and also in main.rst
> 
> 
> >       */
> > +
> >      bool early_setup;
> >      int version_id;
> >      int minimum_version_id;
> >      MigrationPriority priority;
> >      int (*pre_load)(void *opaque);
> > +    int (*pre_load_errp)(void *opaque, Error **errp);
> >      int (*post_load)(void *opaque, int version_id);
> > +    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
> >      int (*pre_save)(void *opaque);
> > +    int (*pre_save_errp)(void *opaque, Error **errp);
> >      int (*post_save)(void *opaque);
> > +    int (*post_save_errp)(void *opaque, Error **errp);
> >      bool (*needed)(void *opaque);
> >      bool (*dev_unplug_pending)(void *opaque);
> >
> 
> You will also need to update docs/devel/migration/main.rst to reflect the
> new callbacks
Yes
> 
> 
> >
> > diff --git a/migration/vmstate.c b/migration/vmstate.c
> > index
> > bb5e9bf38d6ee7619ceb3e9da29209581c3c12eb..e427ef49b2b1991b0a3cdb14d641c197e00014b0
> > 100644
> > --- a/migration/vmstate.c
> > +++ b/migration/vmstate.c
> > @@ -152,7 +152,16 @@ int vmstate_load_state(QEMUFile *f, const
> > VMStateDescription *vmsd,
> >          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
> >          return -EINVAL;
> >      }
> > -    if (vmsd->pre_load) {
> > +    if (vmsd->pre_load_errp) {
> > +        ret = vmsd->pre_load_errp(opaque, errp);
> > +        if (ret) {
> > +            error_prepend(errp, "VM pre load failed for: '%s', "
> > +                          "version_id: '%d', minimum version_id: '%d', "
> > +                          "ret: %d: ", vmsd->name, vmsd->version_id,
> > +                          vmsd->minimum_version_id, ret);
> >
> 
> (but we don't have error_prepend_errno, ok)
> 
> 
> > +            return ret;
> 
> +        }
> > +    } else if (vmsd->pre_load) {
> >          ret = vmsd->pre_load(opaque);
> >          if (ret) {
> >              error_setg(errp, "VM pre load failed for: '%s', "
> > @@ -236,7 +245,14 @@ int vmstate_load_state(QEMUFile *f, const
> > VMStateDescription *vmsd,
> >          qemu_file_set_error(f, ret);
> >          return ret;
> >      }
> > -    if (vmsd->post_load) {
> > +    if (vmsd->post_load_errp) {
> > +        ret = vmsd->post_load_errp(opaque, version_id, errp);
> > +        if (ret < 0) {
> > +            error_prepend(errp, "VM Post load failed for: %s, version_id:
> > %d, "
> > +                          "minimum_version: %d, ret: %d: ", vmsd->name,
> > +                          vmsd->version_id, vmsd->minimum_version_id,
> > ret);
> > +        }
> > +    } else if (vmsd->post_load) {
> >          ret = vmsd->post_load(opaque, version_id);
> >          if (ret < 0) {
> >              error_setg(errp,
> > @@ -412,11 +428,19 @@ int vmstate_save_state_v(QEMUFile *f, const
> > VMStateDescription *vmsd,
> >                           void *opaque, JSONWriter *vmdesc, int
> > version_id, Error **errp)
> >  {
> >      int ret = 0;
> > +    Error *local_err = NULL;
> >      const VMStateField *field = vmsd->fields;
> >
> >      trace_vmstate_save_state_top(vmsd->name);
> >
> > -    if (vmsd->pre_save) {
> > +    if (vmsd->pre_save_errp) {
> > +        ret = vmsd->pre_save_errp(opaque, errp);
> > +        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> > +        if (ret) {
> > +            error_prepend(errp, "pre-save failed: %s: ", vmsd->name);
> >
> 
> Here, it would be helpful to report "ret" too.
Sure, will add.
> 
> 
> > +            return ret;
> > +        }
> > +    } else if (vmsd->pre_save) {
> >
> 
> Imho, you should try to introduce a new helper function to call the
> implemented callback appropriately and handle the non-errp case:
> 
> int the_callback(vmsd,.. **errp)
> {
>   ERRP_GUARD(); // mostly for consistency
> 
>   if (vmsd->the_callback_errp) {
>    return vmsd->the_callback_errp(args.., errp);
>   } else if (vmsd->the_callback) {
>     ret =vmsd->the_callback(args...);
>     error_setg_errno(-ret, "the callback failed...")
>     return ret;
>   }
> 
>   return 0;
> }
> 
> This should make it a bit easier to deal with.
Yes, will do.
> 
>          ret = vmsd->pre_save(opaque);
> >          trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> >          if (ret) {
> > @@ -524,10 +548,22 @@ int vmstate_save_state_v(QEMUFile *f, const
> > VMStateDescription *vmsd,
> >                  }
> >
> >                  if (ret) {
> > -                    error_setg(errp, "Save of field %s/%s failed",
> > -                                vmsd->name, field->name);
> > -                    if (vmsd->post_save) {
> > -                        vmsd->post_save(opaque);
> > +                    if (*errp == NULL) {
> > +                        error_setg(errp, "Save of field %s/%s failed",
> > +                                   vmsd->name, field->name);
> > +                    }
> > +                    if (vmsd->post_save_errp) {
> > +                        int ps_ret = vmsd->post_save_errp(opaque,
> > &local_err);
> > +                        if (ps_ret < 0) {
> > +                            error_free_or_abort(errp);
> > +                            error_propagate(errp, local_err);
> > +                            ret = ps_ret;
> > +                        }
> > +                    } else if (vmsd->post_save) {
> > +                        int ps_ret = vmsd->post_save(opaque);
> >
> 
> It's a bit odd how post_save() is being used here. It could be worth to
> document that it is called regardless of success of migration in callback
> doc.
I think it is present in the documentation.

+  This function is called after we save the state of one device
+  (even upon failure, unless the call to pre_save returned an error).

> 
> Imho, the function vmstate_save_state_v() should be refactored to call
> pre_save() and post_save() and call an internal function in between. It
> will also help to shrink the function a bit.
Possible. I shall give it a try. But just by adding pre-save and post-save
wrapper functions makes the code lot more readable.
> 
> 
> > +                        if (ps_ret < 0) {
> > +                            ret = ps_ret;
> > +                        }
> >                      }
> >                      return ret;
> >                  }
> > @@ -554,7 +590,17 @@ int vmstate_save_state_v(QEMUFile *f, const
> > VMStateDescription *vmsd,
> >
> >      ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> >
> > -    if (vmsd->post_save) {
> > +    if (vmsd->post_save_errp) {
> > +        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
> > +        if (!ret && ps_ret) {
> > +            ret = ps_ret;
> > +            error_propagate(errp, local_err);
> > +        } else if (ret && ps_ret) {
> > +            error_free_or_abort(errp);
> > +            error_propagate(errp, local_err);
> > +            ret = ps_ret;
> > +        }
> > +    } else if (vmsd->post_save) {
> >          int ps_ret = vmsd->post_save(opaque);
> >          if (!ret && ps_ret) {
> >              ret = ps_ret;
> >
> > --
> > 2.50.0
> >
> >

Regards,
Arun


