Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B6FC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIkl-0001il-GI; Fri, 25 Jul 2025 09:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ufIkj-0001fY-1m
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ufIkg-0004IA-35
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753451181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oNfSPFieItn6EV2vNwhRSEfLNg9TB58zC9Mto99AZCs=;
 b=NbVjqT6g8Qcq084kHnnps9Z4xPjati99jjB5tmoCy2SNpXX0/YhHdsXe/C33PVtN8KBopl
 aJyyiiROFVur3z7N+1eWF9R8B7uV2qfsqqP9A3i39/838Uh7nN1UNz3AAE9mHYn4wmZq7G
 9ec2ZQ0xyyboKh4OS9SmoHdvnMvyx6M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-zmCQ-9icN8yCu8xbRcERdg-1; Fri, 25 Jul 2025 09:46:19 -0400
X-MC-Unique: zmCQ-9icN8yCu8xbRcERdg-1
X-Mimecast-MFC-AGG-ID: zmCQ-9icN8yCu8xbRcERdg_1753451175
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-313f702d37fso2583086a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 06:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753451175; x=1754055975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNfSPFieItn6EV2vNwhRSEfLNg9TB58zC9Mto99AZCs=;
 b=vPk4PUDugE3icgKKhZ+aTlu/7elx3VgfPgOYiv77x2MluFJGb/J9k7pMQKLJKOypLB
 GLTPE8+QLx3Z4Tz/a/2pD66cT8lL3BD3J04D+NT9lnBgHlDG0tEhGAr5dWfBJDXuA4ij
 Yee7WYVZx1SpAQdTg/zt5+fwRvdc8Hb8hObnKy0R6LtvuOtaEme5a7gF/I6nHuLRvUKE
 cQV5mlctN9RZLLhJoRpv7s+1ptbqhIV+oMAfwgWEWxSl0NU+55Kyyu0RhJsoo84giNSy
 pUl2B9ZqC7X7RstvfoPIotRTPc4IzYdqPm/IyfVMZDORGEuQ9/utiS6XmyCLnDBHy+3m
 C2XA==
X-Gm-Message-State: AOJu0YxtgF5twJsqd67uj8/xGTXijOX45/bo1eFdzvFkQBT1rVvynGPZ
 flk3fnRAtyrEYvkr10WVA4LSV6s5FCfLgXppPwu1z8JHQkoIwbzBCifHNHiR3MfrCND5CuGTO11
 12mR0GI66jtINef2fwWjCyCFUvAIibvuU6TzQ6cHdu4EBq1kzlcMUhK3pS8VlGfYgOB14qb+sZn
 fF5tYNzd5wmMcOKrGBNYmb1IKnJ824LZw=
X-Gm-Gg: ASbGncvdN5EtA2M/uAXn0B7Km1YOE1jLGnKO3QsmOaIHEmd10zz7VdmR64yJxQ4SccR
 +V4uabiMWZr4OC5qlJFB2ds4G/o2qWmtZTNb5yoImchkzNv/Thtemc4H3tdkgpD6yGbJROA8g1T
 c+yQRRdpo3913UE59sru42jZDzHxYa3IRRsXzs7r3AU5xzqrEXmamg7g==
X-Received: by 2002:a17:90b:2b4d:b0:313:287c:74bd with SMTP id
 98e67ed59e1d1-31e77a4b0f3mr3188641a91.33.1753451175457; 
 Fri, 25 Jul 2025 06:46:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER+zHycfs9i5NKC5PVf3Ps3d+8jlxOblgKOKzh1f2raPtIyEe9HuiFBjZbjGIWh+0dgVQa2atbl3TWTr6NGNA=
X-Received: by 2002:a17:90b:2b4d:b0:313:287c:74bd with SMTP id
 98e67ed59e1d1-31e77a4b0f3mr3188585a91.33.1753451175010; Fri, 25 Jul 2025
 06:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-1-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-1-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Jul 2025 17:46:02 +0400
X-Gm-Features: Ac12FXzsr16p5vuRE2zMdn_XLK_FVgDRf14oc8RmBUMgSm4CBC-X05Rhs5fCatk
Message-ID: <CAMxuvaznYbcpxc7dtDP5yVBzVcDJpVWVXHeWxB1zo0bfdBuw2g@mail.gmail.com>
Subject: Re: [PATCH v7 01/24] migration: push Error **errp into
 vmstate_subsection_load()
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
Content-Type: multipart/alternative; boundary="0000000000006af662063ac12a77"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--0000000000006af662063ac12a77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:19=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_subsection_load() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/vmstate.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index
> 5feaa3244d259874f03048326b2497e7db32e47c..aeffeafaa4fa7582076a4f2747906dd=
f9aca891b
> 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const
> VMStateDescription *vmsd,
>                                     void *opaque, JSONWriter *vmdesc,
>                                     Error **errp);
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription
> *vmsd,
> -                                   void *opaque);
> +                                   void *opaque, Error **errp);
>
>  /* Whether this field should exist for either save or load the VM? */
>  static bool
> @@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const
> VMStateDescription *vmsd,
>          field++;
>      }
>      assert(field->flags =3D=3D VMS_END);
> -    ret =3D vmstate_subsection_load(f, vmsd, opaque);
> +    ret =3D vmstate_subsection_load(f, vmsd, opaque, NULL);
>      if (ret !=3D 0) {
>          qemu_file_set_error(f, ret);
>          return ret;
> @@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription *
> const *sub,
>  }
>
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription
> *vmsd,
> -                                   void *opaque)
> +                                   void *opaque, Error **errp)
>  {
>      trace_vmstate_subsection_load(vmsd->name);
>
> @@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const
> VMStateDescription *vmsd,
>          sub_vmsd =3D vmstate_get_subsection(vmsd->subsections, idstr);
>          if (sub_vmsd =3D=3D NULL) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
> "(lookup)");
> +            error_setg(errp, "VM subsection '%s' in '%s' does not exist"=
,
> +                       idstr, vmsd->name);
>              return -ENOENT;
>          }
>          qemu_file_skip(f, 1); /* subsection */
> @@ -608,6 +610,9 @@ static int vmstate_subsection_load(QEMUFile *f, const
> VMStateDescription *vmsd,
>          ret =3D vmstate_load_state(f, sub_vmsd, opaque, version_id);
>          if (ret) {
>              trace_vmstate_subsection_load_bad(vmsd->name, idstr,
> "(child)");
> +            error_setg(errp,
> +                       "Loading VM subsection '%s' in '%s' failed : %d",
>

extra space before ":"

other than that
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> +                       idstr, vmsd->name, ret);
>              return ret;
>          }
>      }
>
> --
> 2.50.0
>
>

--0000000000006af662063ac12a77
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 4:19=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.co=
m">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">This is an incremental step in converting vmstate load=
ing<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that vmstate_subsection_load() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/vmstate.c | 11 ++++++++---<br>
=C2=A01 file changed, 8 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/migration/vmstate.c b/migration/vmstate.c<br>
index 5feaa3244d259874f03048326b2497e7db32e47c..aeffeafaa4fa7582076a4f27479=
06ddf9aca891b 100644<br>
--- a/migration/vmstate.c<br>
+++ b/migration/vmstate.c<br>
@@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMS=
tateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *opaque, JSONWrit=
er *vmdesc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp);<br>
=C2=A0static int vmstate_subsection_load(QEMUFile *f, const VMStateDescript=
ion *vmsd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **e=
rrp);<br>
<br>
=C2=A0/* Whether this field should exist for either save or load the VM? */=
<br>
=C2=A0static bool<br>
@@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescri=
ption *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0field++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0assert(field-&gt;flags =3D=3D VMS_END);<br>
-=C2=A0 =C2=A0 ret =3D vmstate_subsection_load(f, vmsd, opaque);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_subsection_load(f, vmsd, opaque, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_file_set_error(f, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
@@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription * const=
 *sub,<br>
=C2=A0}<br>
<br>
=C2=A0static int vmstate_subsection_load(QEMUFile *f, const VMStateDescript=
ion *vmsd,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *opaque, Error **e=
rrp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0trace_vmstate_subsection_load(vmsd-&gt;name);<br>
<br>
@@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const V=
MStateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sub_vmsd =3D vmstate_get_subsection(vmsd-=
&gt;subsections, idstr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sub_vmsd =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_subsection_lo=
ad_bad(vmsd-&gt;name, idstr, &quot;(lookup)&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;VM subsec=
tion &#39;%s&#39; in &#39;%s&#39; does not exist&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0idstr, vmsd-&gt;name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOENT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_file_skip(f, 1); /* subsection */<br=
>
@@ -608,6 +610,9 @@ static int vmstate_subsection_load(QEMUFile *f, const V=
MStateDescription *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D vmstate_load_state(f, sub_vmsd, o=
paque, version_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vmstate_subsection_lo=
ad_bad(vmsd-&gt;name, idstr, &quot;(child)&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Loading VM subsection &#39;%s&#39; in &#39;%s&#39; failed :=
 %d&quot;,<br></blockquote><div><br></div><div>extra space before &quot;:&q=
uot;</div><div><br></div><div>other than that</div><div>Reviewed-by: Marc-A=
ndr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcand=
re.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0idstr, vmsd-&gt;name, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--0000000000006af662063ac12a77--


