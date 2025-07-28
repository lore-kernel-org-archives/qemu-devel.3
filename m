Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C3EC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugM0O-00034b-48; Mon, 28 Jul 2025 07:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugLhp-0006gU-Ec
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:07:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugLhm-0002Wn-Lh
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753700861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KXl4786StpsdcvaQo314lHszBqNONxWMmPZv7GOBbNE=;
 b=ZMJzEkcGAQ/ZM8k87pTF4K8UVN1V5xyBrFtm77fTcFpxrEkW7IgIFYljpMIX7fpS414vrZ
 Uj1e7N+YbgSsCzUoMw5Mfr3JJ1EusNbDLN6cuEuYWX+GTzdRtk0AgFpsmCP73ka/qtKzrM
 AM1fTnLeUsJ4Rrn7un0yBgvrZYDqXJ8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-CHkb0BYKONG0tlJ3HLkBCQ-1; Mon, 28 Jul 2025 07:07:39 -0400
X-MC-Unique: CHkb0BYKONG0tlJ3HLkBCQ-1
X-Mimecast-MFC-AGG-ID: CHkb0BYKONG0tlJ3HLkBCQ_1753700858
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31ecf1603a5so1072997a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 04:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753700858; x=1754305658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KXl4786StpsdcvaQo314lHszBqNONxWMmPZv7GOBbNE=;
 b=Q6WNUfGYPQmLavF8Ww4UrtsQDT13pQP8r0GqnNBdb7jVZEJNOeTxhCwo/YQJzwCNWl
 aFkDfubNT1leGZc0DVuJjE5YUT5T/GptYn3YhIQ6xUeve7d+toOOtm73hLIoqTj6IEwO
 9LHregO8/ICRGrFkgTpNuwwZrtImu34nM+Yvr5JwSbv6D/r6uxhVpkv/l4ylc5YWGvEK
 rnDdcAvDp67y9HBKYmO2EFtaVqsG9v4DKGFys7r0wRVk5TvS03huIxPY71HKg7X+N42c
 dZ5mfHL/VyLx9yNwrhStH3FHnHUTlWsmLGgSdryG8VsTUmyqHapCsBCpi6Ofe9C49JQ2
 qWnw==
X-Gm-Message-State: AOJu0Yyra1h1LwGe4B9zB531EqPugGrzVA85dFbNgHi9WBD4MU71UWLA
 lFJeY5TJFCSasR+H5F1u1XCSpx7F17Z6wBHkBUuwOc0/g/RdzZcQWwrmDWF/vwvMgbGw/peYgIR
 NAq7+x14gphP2g0/eMOd0zednDAiT7554SfVMtuiSIL8pl262wwpYTr/sIRr1LQ2bs8zt7/AK/F
 Xf1zPS1RuSblfGp9QMEo4rFLXTZIV3ga8=
X-Gm-Gg: ASbGncvzN5WNIYvm7HHoMmM4BHGR9GPN8WrR4ly7MlrOzhb/Y2GNYhyJcumpo9gT7rk
 WzHgvnZejJYRgR6uuAOdCHM7z2+rOtfhpaRnv+hkgOmTbtrwN1OE+RdBS5/tSdHnasYhMPy3xGg
 geh7Yc3nClHsgR82W6NDLb/v4aRqd3qriKRsO2OE2Lfz440oYAExLqYw==
X-Received: by 2002:a17:90b:5848:b0:311:9c9a:58d7 with SMTP id
 98e67ed59e1d1-31e778f1a6fmr17461376a91.19.1753700857884; 
 Mon, 28 Jul 2025 04:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8QqQBqxGCeeZXm2bzoOLxl3L8BJg9uhUNp7kAsLRXu60FA/u80S28jNDb7N59OYUQ55BbnP6tHfcux9Z0sjo=
X-Received: by 2002:a17:90b:5848:b0:311:9c9a:58d7 with SMTP id
 98e67ed59e1d1-31e778f1a6fmr17461312a91.19.1753700857394; Mon, 28 Jul 2025
 04:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-23-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-23-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Jul 2025 15:07:25 +0400
X-Gm-Features: Ac12FXwBlwYDr-RZ5lNldT0clw7ZHo-OH5q2gtDrlixThpa-Tq2n57Vt4DeLDWs
Message-ID: <CAMxuvazqVEAM_7=P9fA=7mbeLp3gYbjqaDMVnMXBQKD8xuX4Yw@mail.gmail.com>
Subject: Re: [PATCH v7 23/24] migration: Add error-parameterized function
 variants in VMSD struct
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000a5cf1b063afb4cae"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000a5cf1b063afb4cae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jul 25, 2025 at 4:22=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> - We need to have good error reporting in the callbacks in
>   VMStateDescription struct. Specifically pre_save, post_save,
>   pre_load and post_load callbacks.
> - It is not possible to change these functions everywhere in one
>   patch, therefore, we introduce a duplicate set of callbacks
>   with Error object passed to them.
> - So, in this commit, we implement 'errp' variants of these callbacks,
>   introducing an explicit Error object parameter.
> - This is a functional step towards transitioning the entire codebase
>   to the new error-parameterized functions.
> - Deliberately called in mutual exclusion from their counterparts,
>   to prevent conflicts during the transition.
> - New impls should preferentally use 'errp' variants of
>   these methods, and existing impls incrementally converted.
>   The variants without 'errp' are intended to be removed
>   once all usage is converted.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  include/migration/vmstate.h | 11 ++++++++
>  migration/vmstate.c         | 62
> +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 65 insertions(+), 8 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index
> 056781b1c21e737583f081594d9f88b32adfd674..53fa72c1bbde399be02c88fc8745fdb=
b79bfd7c8
> 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -200,15 +200,26 @@ struct VMStateDescription {
>       * exclusive. For this reason, also early_setup VMSDs are migrated i=
n
> a
>       * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated
> in
>       * a QEMU_VM_SECTION_START section.
> +     *
> +     * There are duplicate impls of the post/pre save/load hooks.
> +     * New impls should preferentally use 'errp' variants of these
> +     * methods and existing impls incrementally converted.
> +     * The variants without 'errp' are intended to be removed
> +     * once all usage is converted.
>

It is not documented, but I think all the callbacks return value should be
0 on success, <0 on error with -value an error number from errno.h. Could
you document it?


>       */
> +
>      bool early_setup;
>      int version_id;
>      int minimum_version_id;
>      MigrationPriority priority;
>      int (*pre_load)(void *opaque);
> +    int (*pre_load_errp)(void *opaque, Error **errp);
>      int (*post_load)(void *opaque, int version_id);
> +    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
>      int (*pre_save)(void *opaque);
> +    int (*pre_save_errp)(void *opaque, Error **errp);
>      int (*post_save)(void *opaque);
> +    int (*post_save_errp)(void *opaque, Error **errp);
>      bool (*needed)(void *opaque);
>      bool (*dev_unplug_pending)(void *opaque);
>

You will also need to update docs/devel/migration/main.rst to reflect the
new callbacks


>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index
> bb5e9bf38d6ee7619ceb3e9da29209581c3c12eb..e427ef49b2b1991b0a3cdb14d641c19=
7e00014b0
> 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -152,7 +152,16 @@ int vmstate_load_state(QEMUFile *f, const
> VMStateDescription *vmsd,
>          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>          return -EINVAL;
>      }
> -    if (vmsd->pre_load) {
> +    if (vmsd->pre_load_errp) {
> +        ret =3D vmsd->pre_load_errp(opaque, errp);
> +        if (ret) {
> +            error_prepend(errp, "VM pre load failed for: '%s', "
> +                          "version_id: '%d', minimum version_id: '%d', "
> +                          "ret: %d: ", vmsd->name, vmsd->version_id,
> +                          vmsd->minimum_version_id, ret);
>

(but we don't have error_prepend_errno, ok)


> +            return ret;

+        }
> +    } else if (vmsd->pre_load) {
>          ret =3D vmsd->pre_load(opaque);
>          if (ret) {
>              error_setg(errp, "VM pre load failed for: '%s', "
> @@ -236,7 +245,14 @@ int vmstate_load_state(QEMUFile *f, const
> VMStateDescription *vmsd,
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
> -    if (vmsd->post_load) {
> +    if (vmsd->post_load_errp) {
> +        ret =3D vmsd->post_load_errp(opaque, version_id, errp);
> +        if (ret < 0) {
> +            error_prepend(errp, "VM Post load failed for: %s, version_id=
:
> %d, "
> +                          "minimum_version: %d, ret: %d: ", vmsd->name,
> +                          vmsd->version_id, vmsd->minimum_version_id,
> ret);
> +        }
> +    } else if (vmsd->post_load) {
>          ret =3D vmsd->post_load(opaque, version_id);
>          if (ret < 0) {
>              error_setg(errp,
> @@ -412,11 +428,19 @@ int vmstate_save_state_v(QEMUFile *f, const
> VMStateDescription *vmsd,
>                           void *opaque, JSONWriter *vmdesc, int
> version_id, Error **errp)
>  {
>      int ret =3D 0;
> +    Error *local_err =3D NULL;
>      const VMStateField *field =3D vmsd->fields;
>
>      trace_vmstate_save_state_top(vmsd->name);
>
> -    if (vmsd->pre_save) {
> +    if (vmsd->pre_save_errp) {
> +        ret =3D vmsd->pre_save_errp(opaque, errp);
> +        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> +        if (ret) {
> +            error_prepend(errp, "pre-save failed: %s: ", vmsd->name);
>

Here, it would be helpful to report "ret" too.


> +            return ret;
> +        }
> +    } else if (vmsd->pre_save) {
>

Imho, you should try to introduce a new helper function to call the
implemented callback appropriately and handle the non-errp case:

int the_callback(vmsd,.. **errp)
{
  ERRP_GUARD(); // mostly for consistency

  if (vmsd->the_callback_errp) {
   return vmsd->the_callback_errp(args.., errp);
  } else if (vmsd->the_callback) {
    ret =3Dvmsd->the_callback(args...);
    error_setg_errno(-ret, "the callback failed...")
    return ret;
  }

  return 0;
}

This should make it a bit easier to deal with.

         ret =3D vmsd->pre_save(opaque);
>          trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>          if (ret) {
> @@ -524,10 +548,22 @@ int vmstate_save_state_v(QEMUFile *f, const
> VMStateDescription *vmsd,
>                  }
>
>                  if (ret) {
> -                    error_setg(errp, "Save of field %s/%s failed",
> -                                vmsd->name, field->name);
> -                    if (vmsd->post_save) {
> -                        vmsd->post_save(opaque);
> +                    if (*errp =3D=3D NULL) {
> +                        error_setg(errp, "Save of field %s/%s failed",
> +                                   vmsd->name, field->name);
> +                    }
> +                    if (vmsd->post_save_errp) {
> +                        int ps_ret =3D vmsd->post_save_errp(opaque,
> &local_err);
> +                        if (ps_ret < 0) {
> +                            error_free_or_abort(errp);
> +                            error_propagate(errp, local_err);
> +                            ret =3D ps_ret;
> +                        }
> +                    } else if (vmsd->post_save) {
> +                        int ps_ret =3D vmsd->post_save(opaque);
>

It's a bit odd how post_save() is being used here. It could be worth to
document that it is called regardless of success of migration in callback
doc.

Imho, the function vmstate_save_state_v() should be refactored to call
pre_save() and post_save() and call an internal function in between. It
will also help to shrink the function a bit.


> +                        if (ps_ret < 0) {
> +                            ret =3D ps_ret;
> +                        }
>                      }
>                      return ret;
>                  }
> @@ -554,7 +590,17 @@ int vmstate_save_state_v(QEMUFile *f, const
> VMStateDescription *vmsd,
>
>      ret =3D vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>
> -    if (vmsd->post_save) {
> +    if (vmsd->post_save_errp) {
> +        int ps_ret =3D vmsd->post_save_errp(opaque, &local_err);
> +        if (!ret && ps_ret) {
> +            ret =3D ps_ret;
> +            error_propagate(errp, local_err);
> +        } else if (ret && ps_ret) {
> +            error_free_or_abort(errp);
> +            error_propagate(errp, local_err);
> +            ret =3D ps_ret;
> +        }
> +    } else if (vmsd->post_save) {
>          int ps_ret =3D vmsd->post_save(opaque);
>          if (!ret && ps_ret) {
>              ret =3D ps_ret;
>
> --
> 2.50.0
>
>

--000000000000a5cf1b063afb4cae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25, 2=
025 at 4:22=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com"=
>armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">- We need to have good error reporting in the callbacks =
in<br>
=C2=A0 VMStateDescription struct. Specifically pre_save, post_save,<br>
=C2=A0 pre_load and post_load callbacks.<br>
- It is not possible to change these functions everywhere in one<br>
=C2=A0 patch, therefore, we introduce a duplicate set of callbacks<br>
=C2=A0 with Error object passed to them.<br>
- So, in this commit, we implement &#39;errp&#39; variants of these callbac=
ks,<br>
=C2=A0 introducing an explicit Error object parameter.<br>
- This is a functional step towards transitioning the entire codebase<br>
=C2=A0 to the new error-parameterized functions.<br>
- Deliberately called in mutual exclusion from their counterparts,<br>
=C2=A0 to prevent conflicts during the transition.<br>
- New impls should preferentally use &#39;errp&#39; variants of<br>
=C2=A0 these methods, and existing impls incrementally converted.<br>
=C2=A0 The variants without &#39;errp&#39; are intended to be removed<br>
=C2=A0 once all usage is converted.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/migration/vmstate.h | 11 ++++++++<br>
=C2=A0migration/vmstate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 62 +++++++++++=
++++++++++++++++++++++++++++------<br>
=C2=A02 files changed, 65 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h<br>
index 056781b1c21e737583f081594d9f88b32adfd674..53fa72c1bbde399be02c88fc874=
5fdbb79bfd7c8 100644<br>
--- a/include/migration/vmstate.h<br>
+++ b/include/migration/vmstate.h<br>
@@ -200,15 +200,26 @@ struct VMStateDescription {<br>
=C2=A0 =C2=A0 =C2=A0 * exclusive. For this reason, also early_setup VMSDs a=
re migrated in a<br>
=C2=A0 =C2=A0 =C2=A0 * QEMU_VM_SECTION_FULL section, while save_setup() dat=
a is migrated in<br>
=C2=A0 =C2=A0 =C2=A0 * a QEMU_VM_SECTION_START section.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* There are duplicate impls of the post/pre save/load =
hooks.<br>
+=C2=A0 =C2=A0 =C2=A0* New impls should preferentally use &#39;errp&#39; va=
riants of these<br>
+=C2=A0 =C2=A0 =C2=A0* methods and existing impls incrementally converted.<=
br>
+=C2=A0 =C2=A0 =C2=A0* The variants without &#39;errp&#39; are intended to =
be removed<br>
+=C2=A0 =C2=A0 =C2=A0* once all usage is converted.<br></blockquote><div><b=
r></div><div>It is not documented, but I think all the callbacks return val=
ue should be 0 on success, &lt;0 on error with -value an error number from =
errno.h. Could you document it?</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 */<br>
+<br>
=C2=A0 =C2=A0 =C2=A0bool early_setup;<br>
=C2=A0 =C2=A0 =C2=A0int version_id;<br>
=C2=A0 =C2=A0 =C2=A0int minimum_version_id;<br>
=C2=A0 =C2=A0 =C2=A0MigrationPriority priority;<br>
=C2=A0 =C2=A0 =C2=A0int (*pre_load)(void *opaque);<br>
+=C2=A0 =C2=A0 int (*pre_load_errp)(void *opaque, Error **errp);<br>
=C2=A0 =C2=A0 =C2=A0int (*post_load)(void *opaque, int version_id);<br>
+=C2=A0 =C2=A0 int (*post_load_errp)(void *opaque, int version_id, Error **=
errp);<br>
=C2=A0 =C2=A0 =C2=A0int (*pre_save)(void *opaque);<br>
+=C2=A0 =C2=A0 int (*pre_save_errp)(void *opaque, Error **errp);<br>
=C2=A0 =C2=A0 =C2=A0int (*post_save)(void *opaque);<br>
+=C2=A0 =C2=A0 int (*post_save_errp)(void *opaque, Error **errp);<br>
=C2=A0 =C2=A0 =C2=A0bool (*needed)(void *opaque);<br>
=C2=A0 =C2=A0 =C2=A0bool (*dev_unplug_pending)(void *opaque);<br></blockquo=
te><div><br></div><div>You will also need to update=C2=A0docs/devel/migrati=
on/main.rst to reflect the new callbacks</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/migration/vmstate.c b/migration/vmstate.c<br>
index bb5e9bf38d6ee7619ceb3e9da29209581c3c12eb..e427ef49b2b1991b0a3cdb14d64=
1c197e00014b0 100644<br>
--- a/migration/vmstate.c<br>
+++ b/migration/vmstate.c<br>
@@ -152,7 +152,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescr=
iption *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_load_state_end(vmsd-&gt;nam=
e, &quot;too old&quot;, -EINVAL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (vmsd-&gt;pre_load) {<br>
+=C2=A0 =C2=A0 if (vmsd-&gt;pre_load_errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmsd-&gt;pre_load_errp(opaque, errp);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;VM pre=
 load failed for: &#39;%s&#39;, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;version_id: &#39;%d&#39;, minimum version_id: &#39;=
%d&#39;, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;ret: %d: &quot;, vmsd-&gt;name, vmsd-&gt;version_id=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 vmsd-&gt;minimum_version_id, ret);<br></blockquote><div><=
br></div><div>(but we don&#39;t have error_prepend_errno, ok)</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;=C2=A0</blockquote><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else if (vmsd-&gt;pre_load) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmsd-&gt;pre_load(opaque);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;VM p=
re load failed for: &#39;%s&#39;, &quot;<br>
@@ -236,7 +245,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescr=
iption *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_file_set_error(f, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (vmsd-&gt;post_load) {<br>
+=C2=A0 =C2=A0 if (vmsd-&gt;post_load_errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmsd-&gt;post_load_errp(opaque, versio=
n_id, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;VM Pos=
t load failed for: %s, version_id: %d, &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;minimum_version: %d, ret: %d: &quot;, vmsd-&gt;name=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 vmsd-&gt;version_id, vmsd-&gt;minimum_version_id, ret);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else if (vmsd-&gt;post_load) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmsd-&gt;post_load(opaque, versio=
n_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp,<br>
@@ -412,11 +428,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDe=
scription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 void *opaque, JSONWriter *vmdesc, int version_id, Error *=
*errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0const VMStateField *field =3D vmsd-&gt;fields;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_vmstate_save_state_top(vmsd-&gt;name);<br>
<br>
-=C2=A0 =C2=A0 if (vmsd-&gt;pre_save) {<br>
+=C2=A0 =C2=A0 if (vmsd-&gt;pre_save_errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmsd-&gt;pre_save_errp(opaque, errp);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_vmstate_save_state_pre_save_res(vmsd-&gt=
;name, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;pre-sa=
ve failed: %s: &quot;, vmsd-&gt;name);<br></blockquote><div><br></div><div>=
Here, it would be helpful to report &quot;ret&quot; too.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else if (vmsd-&gt;pre_save) {<br></blockquote><div><br></d=
iv><div>Imho, you should try to introduce a new helper function to call the=
 implemented callback appropriately and handle the non-errp case:</div><div=
><br></div><div>int the_callback(vmsd,.. **errp)</div><div>{</div><div>=C2=
=A0 ERRP_GUARD(); // mostly for consistency</div><div><br></div><div>=C2=A0=
 if (vmsd-&gt;the_callback_errp) {</div><div>=C2=A0 =C2=A0return vmsd-&gt;t=
he_callback_errp(args.., errp);</div><div>=C2=A0 } else if (vmsd-&gt;the_ca=
llback) {</div><div>=C2=A0 =C2=A0 ret =3Dvmsd-&gt;the_callback(args...);</d=
iv><div>=C2=A0 =C2=A0 error_setg_errno(-ret, &quot;the callback failed...&q=
uot;)</div><div>=C2=A0 =C2=A0 return ret;</div><div>=C2=A0 }</div><div>=C2=
=A0=C2=A0</div><div>=C2=A0 return 0;</div><div>}</div><div>=C2=A0=C2=A0</di=
v><div>This should make it a bit easier to deal with.</div><div><br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmsd-&gt;pre_save(opaque);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_save_state_pre_save_res(vms=
d-&gt;name, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
@@ -524,10 +548,22 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDe=
scription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_setg(errp, &quot;Save of field %s/%s failed&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsd-&gt;name, field-&gt;name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
vmsd-&gt;post_save) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 vmsd-&gt;post_save(opaque);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
*errp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 error_setg(errp, &quot;Save of field %s/%s failed&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsd-&gt;name, field-&g=
t;name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
vmsd-&gt;post_save_errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int ps_ret =3D vmsd-&gt;post_save_errp(opaque, &amp;local_err);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ps_ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 error_free_or_abort(errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ps_ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } el=
se if (vmsd-&gt;post_save) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int ps_ret =3D vmsd-&gt;post_save(opaque);<br></blockquote><div>=
<br></div><div>It&#39;s a bit odd how post_save() is being used here. It co=
uld be worth to document that it is called regardless of success of migrati=
on in callback doc.</div><div><br></div><div>Imho, the function=C2=A0vmstat=
e_save_state_v() should be refactored to call pre_save() and post_save() an=
d call an internal function in between. It will also help to shrink the fun=
ction a bit.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ps_ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ps_ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -554,7 +590,17 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDes=
cription *vmsd,<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D vmstate_subsection_save(f, vmsd, opaque, vmdesc=
, errp);<br>
<br>
-=C2=A0 =C2=A0 if (vmsd-&gt;post_save) {<br>
+=C2=A0 =C2=A0 if (vmsd-&gt;post_save_errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ps_ret =3D vmsd-&gt;post_save_errp(opaque,=
 &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret &amp;&amp; ps_ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ps_ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ret &amp;&amp; ps_ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free_or_abort(errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ps_ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else if (vmsd-&gt;post_save) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ps_ret =3D vmsd-&gt;post_save(opaque)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret &amp;&amp; ps_ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ps_ret;<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--000000000000a5cf1b063afb4cae--


