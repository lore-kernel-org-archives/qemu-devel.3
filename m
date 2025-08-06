Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585A0C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 08:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZNq-00069p-ND; Wed, 06 Aug 2025 04:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujZNJ-0005rH-DB
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujZNE-0006bo-CL
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 04:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754468385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3wzNFWC9qKI36T0R/jOl6OdloPspkcTUQfi1dnwLf8w=;
 b=hxbAL/eBwq9ZQQtzjGEta/KY28bnlz7wPqu0Y/5HfXn6yEl/zXi359pTy9XITMmFXi+Xsu
 GO+wDUivpyNEl+anuxOlzM/FyTOcc3spAQP/4anO30ANF8qbFBQGJ5omFnfNUujOsosS/w
 vaHpbxpTkyq+KGepv0rYEO6GpRNOE9Y=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-NSHpXXiaOja0f5Y_2toW5A-1; Wed, 06 Aug 2025 04:19:44 -0400
X-MC-Unique: NSHpXXiaOja0f5Y_2toW5A-1
X-Mimecast-MFC-AGG-ID: NSHpXXiaOja0f5Y_2toW5A_1754468382
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31f3b65ce07so10448501a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 01:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754468382; x=1755073182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3wzNFWC9qKI36T0R/jOl6OdloPspkcTUQfi1dnwLf8w=;
 b=pJhnMXfALhkBrO5lD7m15tu8pC9P3vA8NbI3OcDv7G9961+eeQYtTcPJIJhX5Taqzd
 dApMcjtfQ5/CKBSAghECUsi6MElArA3Y5zJPh/J8lTpIPHgXdZiG2s5ZWpQ4BAczYU+O
 Xd7wpBiPcgOu7kk4Oqlwn2OqgXi9bh9wOo+kIejwkie4lnqw5CE5YFZ5ILytPZj3A+Va
 gRovb1LNOAZoKmIKad21lufXSytazwPnrmQhOw9SF9mrcpoRo6jpZ9YwYMNbTNaJ/r1Z
 tCHKJgGZgIltaUBjz9vFAbueAVZsyAYKkS3txWfICWCyHJYJL1p+oJMnb9r7cUwFKWyC
 eFdg==
X-Gm-Message-State: AOJu0Yy0iSwz9GyaP/xfx/b3xSxMdyvubPFJPH1zZCrBNixO7Qn3muog
 UJDHAtrdqsRbLVVOGUX0ps10BVUxvYTzzk+TyfFF5Ds5RlSPqf3OiwCNTKQl85Chn8G3QoEfYdh
 ZCAY+nO7shBM8YNv5ZUQwsYpJLEAMQ2V/Art4lVlAbheg9WUIKmvg4PnQmHmMZeaHg1Wi5zeR2d
 l3IP415crQOUEh/KNof0j+3sUhaFglGZg=
X-Gm-Gg: ASbGncvzBAgggKKFKdQZ90+al9GiAFEX/Sk1WPSZ/Tbr1Laa96xdxs2c+E/h3QLD16N
 QcE/rI9u4uWMNlWvV2jzLaheOV8b5NxGfrO1pR1EDY91m4vgmVk/mNSDWgn3O4l+HZs55HvDUGY
 3vO4ADobfTpfY2/OKcDy5jH3qpfyBSqm0wENiKVjRzICIxwa5r00wKeQ==
X-Received: by 2002:a17:90b:2dcd:b0:321:2160:bf76 with SMTP id
 98e67ed59e1d1-32166cc6a3emr2145752a91.25.1754468381725; 
 Wed, 06 Aug 2025 01:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFClRmOi5rdeP6tqrTy9vGjoP/Wr8YHv3kbxrQUxx5I7iWfI6uvT+F5ExmfV0vlJ1L5UjPd5WCO8oxjOcBZ48=
X-Received: by 2002:a17:90b:2dcd:b0:321:2160:bf76 with SMTP id
 98e67ed59e1d1-32166cc6a3emr2145715a91.25.1754468381284; Wed, 06 Aug 2025
 01:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-23-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-23-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Aug 2025 12:19:29 +0400
X-Gm-Features: Ac12FXxEQ4blpwDKxQ-cCTGclEfdKI5llTH7ny9gIIJFf3fGuB6ifX6OEtXQuCQ
Message-ID: <CAMxuvax_9EP3T0PwAknxb3B_-3S_D3saQqZ+u3z1Sc6zAaS4OQ@mail.gmail.com>
Subject: Re: [PATCH v9 23/27] migration: Refactor vmstate_save_state_v()
 function
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000a2ed5a063bae0012"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000a2ed5a063bae0012
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 5, 2025 at 10:31=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> The original vmstate_save_state_v() function combined multiple
> responsibilities like calling pre-save hooks, saving the state of
> the device, handling subsection saves and invoking post-save hooks.
> This led to a lengthy and less readable function.
>
> To address this, introduce wrapper functions for pre-save,
> post-save and the device-state save functionalities.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/vmstate.c | 78
> ++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 60 insertions(+), 18 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index
> 60ff38858cf54277992fa5eddeadb6f3d70edec3..fbc59caadbbcc75fe6de27b459aa9aa=
25e76aa0a
> 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -414,22 +414,43 @@ int vmstate_save_state_with_err(QEMUFile *f, const
> VMStateDescription *vmsd,
>      return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,
> vmsd->version_id, errp);
>  }
>
> -int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> -                         void *opaque, JSONWriter *vmdesc, int
> version_id, Error **errp)
> +static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaqu=
e,
> +                             Error **errp)
>  {
>      int ret =3D 0;
> -    const VMStateField *field =3D vmsd->fields;
> -
> -    trace_vmstate_save_state_top(vmsd->name);
> -
>      if (vmsd->pre_save) {
>          ret =3D vmsd->pre_save(opaque);
>          trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>          if (ret) {
> -            error_setg(errp, "pre-save failed: %s", vmsd->name);
> -            return ret;
> +            error_setg(errp, "pre-save for %s failed, ret: %d",
> +                       vmsd->name, ret);
>          }
>      }
> +    return ret;
> +}
> +
> +static int post_save_dispatch(const VMStateDescription *vmsd, void
> *opaque,
> +                              Error **errp)
> +{
> +    int ret =3D 0;
> +    if (vmsd->post_save) {
> +        ret =3D vmsd->post_save(opaque);

+        error_setg(errp, "post-save for %s failed, ret: %d",
> +                   vmsd->name, ret);
>

Only set errp if ret !=3D 0


> +    }
> +    return ret;
> +}
> +
> +static int vmstate_save_dispatch(QEMUFile *f,
> +                                 const VMStateDescription *vmsd,
> +                                 void *opaque, JSONWriter *vmdesc,
> +                                 int version_id, Error **errp)
> +{
> +    ERRP_GUARD();
> +    int ret =3D 0;
> +    int ps_ret =3D 0;
> +    Error *local_err =3D NULL;
> +    const VMStateField *field =3D vmsd->fields;
>
>      if (vmdesc) {
>          json_writer_str(vmdesc, "vmsd_name", vmsd->name);
> @@ -532,9 +553,7 @@ int vmstate_save_state_v(QEMUFile *f, const
> VMStateDescription *vmsd,
>                  if (ret) {
>                      error_setg(errp, "Save of field %s/%s failed",
>                                  vmsd->name, field->name);
> -                    if (vmsd->post_save) {
> -                        vmsd->post_save(opaque);
> -                    }
> +                    ps_ret =3D post_save_dispatch(vmsd, opaque, &local_e=
rr);
>

why keep ps_ret ?

What do you do of local_err ?


>                      return ret;
>                  }
>
> @@ -557,16 +576,39 @@ int vmstate_save_state_v(QEMUFile *f, const
> VMStateDescription *vmsd,
>      if (vmdesc) {
>          json_writer_end_array(vmdesc);
>      }
> +    return ret;
> +}
>
> -    ret =3D vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>
> -    if (vmsd->post_save) {
> -        int ps_ret =3D vmsd->post_save(opaque);
> -        if (!ret && ps_ret) {
> -            ret =3D ps_ret;
> -            error_setg(errp, "post-save failed: %s", vmsd->name);
> -        }
> +int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> +                         void *opaque, JSONWriter *vmdesc, int version_i=
d,
> +                         Error **errp)
> +{
> +    ERRP_GUARD();
> +    int ret =3D 0;
> +    Error *local_err =3D NULL;
> +    int ps_ret =3D 0;
> +
> +    trace_vmstate_save_state_top(vmsd->name);
> +
> +    ret =3D pre_save_dispatch(vmsd, opaque, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret =3D vmstate_save_dispatch(f, vmsd, opaque, vmdesc,
> +                                version_id, errp);
> +    if (ret) {
> +        return ret


post_save_dispatch() should be called on failure.

>
>      }
> +
> +    ret =3D vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>

Imho this should be moved back to the vmstate_save_dispatch()

+    ps_ret =3D post_save_dispatch(vmsd, opaque, &local_err);
> +    if (!ret && ps_ret) {
> +        ret =3D ps_ret;
> +        error_setg(errp, "post-save failed: %s", vmsd->name);
>

And then you can have a single place to call post_save_dispatch() - remove
it from vmstate_subsection_save.

It should probably call error_propagate() instead.



> +    }
> +
>      return ret;
>  }
>
>
> --
> 2.50.1
>
>

--000000000000a2ed5a063bae0012
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, 20=
25 at 10:31=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com"=
>armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">The original vmstate_save_state_v() function combined mu=
ltiple<br>
responsibilities like calling pre-save hooks, saving the state of<br>
the device, handling subsection saves and invoking post-save hooks.<br>
This led to a lengthy and less readable function.<br>
<br>
To address this, introduce wrapper functions for pre-save,<br>
post-save and the device-state save functionalities.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/vmstate.c | 78 ++++++++++++++++++++++++++++++++++++++++----=
---------<br>
=C2=A01 file changed, 60 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/migration/vmstate.c b/migration/vmstate.c<br>
index 60ff38858cf54277992fa5eddeadb6f3d70edec3..fbc59caadbbcc75fe6de27b459a=
a9aa25e76aa0a 100644<br>
--- a/migration/vmstate.c<br>
+++ b/migration/vmstate.c<br>
@@ -414,22 +414,43 @@ int vmstate_save_state_with_err(QEMUFile *f, const VM=
StateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id,=
 vmsd-&gt;version_id, errp);<br>
=C2=A0}<br>
<br>
-int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0void *opaque, JSONWriter *vmdesc, int version_id, Error **=
errp)<br>
+static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaque,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
-=C2=A0 =C2=A0 const VMStateField *field =3D vmsd-&gt;fields;<br>
-<br>
-=C2=A0 =C2=A0 trace_vmstate_save_state_top(vmsd-&gt;name);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (vmsd-&gt;pre_save) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmsd-&gt;pre_save(opaque);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_save_state_pre_save_res(vms=
d-&gt;name, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;pre-save =
failed: %s&quot;, vmsd-&gt;name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;pre-save =
for %s failed, ret: %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vmsd-&gt;name, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static int post_save_dispatch(const VMStateDescription *vmsd, void *opaque=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 int ret =3D 0;<br>
+=C2=A0 =C2=A0 if (vmsd-&gt;post_save) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmsd-&gt;post_save(opaque);=C2=A0</blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;post-save for %s failed=
, ret: %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsd-=
&gt;name, ret);<br></blockquote><div><br></div><div>Only set errp if ret !=
=3D 0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static int vmstate_save_dispatch(QEMUFile *f,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const VMStateDescription *vmsd=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, JSONWriter *vmde=
sc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int version_id, Error **errp)<=
br>
+{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
+=C2=A0 =C2=A0 int ret =3D 0;<br>
+=C2=A0 =C2=A0 int ps_ret =3D 0;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 const VMStateField *field =3D vmsd-&gt;fields;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (vmdesc) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0json_writer_str(vmdesc, &quot;vmsd_name&q=
uot;, vmsd-&gt;name);<br>
@@ -532,9 +553,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDesc=
ription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0error_setg(errp, &quot;Save of field %s/%s failed&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmsd-&gt;name, field-&gt;name)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
vmsd-&gt;post_save) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 vmsd-&gt;post_save(opaque);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ps_r=
et =3D post_save_dispatch(vmsd, opaque, &amp;local_err);<br></blockquote><d=
iv><br></div><div>why keep ps_ret ?</div><div><br></div><div>What do you do=
 of local_err ?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -557,16 +576,39 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDe=
scription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0if (vmdesc) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0json_writer_end_array(vmdesc);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
<br>
-=C2=A0 =C2=A0 ret =3D vmstate_subsection_save(f, vmsd, opaque, vmdesc, err=
p);<br>
<br>
-=C2=A0 =C2=A0 if (vmsd-&gt;post_save) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ps_ret =3D vmsd-&gt;post_save(opaque);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret &amp;&amp; ps_ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ps_ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;post-save=
 failed: %s&quot;, vmsd-&gt;name);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0void *opaque, JSONWriter *vmdesc, int version_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
+=C2=A0 =C2=A0 int ret =3D 0;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 int ps_ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 trace_vmstate_save_state_top(vmsd-&gt;name);<br>
+<br>
+=C2=A0 =C2=A0 ret =3D pre_save_dispatch(vmsd, opaque, errp);<br>
+=C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ret =3D vmstate_save_dispatch(f, vmsd, opaque, vmdesc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 version_id, errp);<br>
+=C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret</blockquote><div><br></div><div>pos=
t_save_dispatch() should be called on failure.</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 ret =3D vmstate_subsection_save(f, vmsd, opaque, vmdesc, err=
p);<br></blockquote><div><br></div><div>Imho this should be moved back to t=
he vmstate_save_dispatch()</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
+=C2=A0 =C2=A0 ps_ret =3D post_save_dispatch(vmsd, opaque, &amp;local_err);=
<br>
+=C2=A0 =C2=A0 if (!ret &amp;&amp; ps_ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ps_ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;post-save failed: %s&qu=
ot;, vmsd-&gt;name);<br></blockquote><div><br></div><div>And then you can h=
ave a single place to call=C2=A0post_save_dispatch() - remove it from=C2=A0=
vmstate_subsection_save.</div><div><br></div><div>It should probably call e=
rror_propagate() instead.</div><div><br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--000000000000a2ed5a063bae0012--


