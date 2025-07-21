Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C5FC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 12:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udpj7-0000UR-4C; Mon, 21 Jul 2025 08:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1udpj2-0008R1-RU
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 08:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1udpiu-0002vN-Aj
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 08:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753101266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oPag02SFBomps4Z6Eo4sstcVWp9e9rJAUBU942/UZBM=;
 b=gM9c9mznbGMNy6XWZduyCfBSHYeYUnOVWF7eCNKjgWYmbrcpjC+6aD2blVixv19Dx/haji
 gv7m0jkKAYEBSrhYcmey8oOCtBxisg1KtwtezCDGKP9e681YN8AQHcKwnTt4lXYgwrOBrv
 IxVfhWWDlay4dM255qLUcKhvhoFI6jE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-XtqUBABFPCSWtsxHXHEZrg-1; Mon, 21 Jul 2025 08:34:25 -0400
X-MC-Unique: XtqUBABFPCSWtsxHXHEZrg-1
X-Mimecast-MFC-AGG-ID: XtqUBABFPCSWtsxHXHEZrg_1753101264
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so5816695a91.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 05:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753101264; x=1753706064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oPag02SFBomps4Z6Eo4sstcVWp9e9rJAUBU942/UZBM=;
 b=lWFiTPCp+Ykt5sGQBHnTSU2mLJzviKuDyiTQ5g9cv6Od0ZO7+z1/rL2EH1gfQQwQQY
 gPQvfa8ZYB14893fTO+TqpMheMnjXbZb/Nf8Fg+pc3r5TykUHnmaS8kYMRCSC2besNjV
 57aj6y86sJ6Yp/UdJsec8nuAMyrFm48oTw+6xJWedMQd7Genn8vBpRBvKiveBnRMrmAg
 nYlVjVlxtZswwnYhjFtqVAEPkjHVirbVjvOevtwVLmP3DIyv1mp+spsoqk5t+MORrT/j
 MKNHckbnRsRwrciCo0nOONK89xqKvzXvguETkFymFb9ZvICmF7apYwdSKGdKGT4YLO+0
 1JMw==
X-Gm-Message-State: AOJu0YxFWqX62oIjNvbTLC90qrWSecI2WyEdSf2vkV6SJyM0tr4Yty4U
 ohOWTD5qGMb492YyvATBgenri9s4WZGx2TM/0htgNoaXP/8sQnJC3yifdnoa6wNOm72oOTyoaoH
 rGgy8VnqASKchRM6lRA1SWOhU/AFDHE6Nchf5Vso6jDdqetdESJ+cN/6CYWnQFQHFe6AG9O21qT
 t+r5lwR2hbEA83gR2OqcuFFR/1i88THHM=
X-Gm-Gg: ASbGncu4XOzJGjJtdSUf+LQkqhafsz4fQGDJ2J3WLRaks5BhweIGtU6yBZjPxgZxaCp
 uOGsMbUvByWnxZK63YgQWJ4FY8FFjm8CmkRkUozLXRxm681dpsfiT8m8rPbsyaZYW27d/334cIT
 B8BCW1tD29Nw2DLQ0wUdExWOiYDaUyJJ5wYLC/vOygoLJK/MRGq0CnlA==
X-Received: by 2002:a17:90b:5846:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-31c9f398bf1mr27973559a91.3.1753101263934; 
 Mon, 21 Jul 2025 05:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGExTNKU6MF+l4WD3y+OhBv3kX7ASHaRmh7crRtsdtjw4Mli/97SMuahglWH2QdfP9KahGs5jLtTIKSWkd3LyU=
X-Received: by 2002:a17:90b:5846:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-31c9f398bf1mr27973525a91.3.1753101263552; Mon, 21 Jul 2025
 05:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-3-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-3-fef740e15e17@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 21 Jul 2025 16:34:12 +0400
X-Gm-Features: Ac12FXxB5oOHXO8Z5GjmTm1o3UH0VuitS4xAvcW0ZZ6SwXLAYH9R2u1Ryum6sUY
Message-ID: <CAMxuvayhm4aos_JDyu+92t==EX3Nr6JDn8L=3agu7k6rHQ-tag@mail.gmail.com>
Subject: Re: [PATCH v6 03/24] migration: push Error **errp into
 qemu_loadvm_state_header()
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
Content-Type: multipart/alternative; boundary="00000000000011df8e063a6fb2a2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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

--00000000000011df8e063a6fb2a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 21, 2025 at 3:30=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_state_header() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> ab947620f724874f325fb9fb59bef50b7c16fb51..162fb05933fae5993eeef107811f97c=
b08726ac3
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2814,35 +2814,42 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t
> type)
>      return 0;
>  }
>
> -static int qemu_loadvm_state_header(QEMUFile *f)
> +static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
>  {
>      unsigned int v;
>      int ret;
>
>      v =3D qemu_get_be32(f);
>      if (v !=3D QEMU_VM_FILE_MAGIC) {
> -        error_report("Not a migration stream");
> +        error_setg(errp, "Not a migration stream, "
> +                   "magic: %x !=3D %x", v, QEMU_VM_FILE_MAGIC);
>          return -EINVAL;
>      }
>
>      v =3D qemu_get_be32(f);
>      if (v =3D=3D QEMU_VM_FILE_VERSION_COMPAT) {
> -        error_report("SaveVM v2 format is obsolete and don't work
> anymore");
> +        error_setg(errp, "SaveVM v2 format is obsolete and no"
> +                   "longer supported, file version %x !=3D %x",
>

As Akihiko said in patch 2 review, better "not to have line breaks in
string literals" .. here, there is a missing space now.

+                   v, QEMU_VM_FILE_VERSION_COMPAT);
> +
>          return -ENOTSUP;
>      }
>      if (v !=3D QEMU_VM_FILE_VERSION) {
> -        error_report("Unsupported migration stream version");
> +        error_setg(errp, "Unsupported migration stream "
> +                   "version, file version %x !=3D %x", v,
> QEMU_VM_FILE_VERSION);
>          return -ENOTSUP;
>      }
>
>      if (migrate_get_current()->send_configuration) {
> -        if (qemu_get_byte(f) !=3D QEMU_VM_CONFIGURATION) {
> -            error_report("Configuration section missing");
> +        v =3D qemu_get_byte(f);
> +        if (v !=3D QEMU_VM_CONFIGURATION) {
> +            error_setg(errp, "Configuration section missing,"
>

here too


> +                       "%x !=3D %x", v, QEMU_VM_CONFIGURATION);
>              return -EINVAL;
>          }
> -        ret =3D vmstate_load_state(f, &vmstate_configuration,
> &savevm_state, 0,
> -                                 NULL);
>
> +        ret =3D vmstate_load_state(f, &vmstate_configuration,
> &savevm_state, 0,
> +                                 errp);
>          if (ret) {
>              return ret;
>          }
> @@ -3119,7 +3126,7 @@ int qemu_loadvm_state(QEMUFile *f)
>
>      qemu_loadvm_thread_pool_create(mis);
>
> -    ret =3D qemu_loadvm_state_header(f);
> +    ret =3D qemu_loadvm_state_header(f, NULL);
>      if (ret) {
>          return ret;
>      }
>
> --
> 2.50.0
>
>

--00000000000011df8e063a6fb2a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 21, 2=
025 at 3:30=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com"=
>armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This is an incremental step in converting vmstate loadin=
g<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that qemu_loadvm_state_header() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/savevm.c | 25 ++++++++++++++++---------<br>
=C2=A01 file changed, 16 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index ab947620f724874f325fb9fb59bef50b7c16fb51..162fb05933fae5993eeef107811=
f97cb08726ac3 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2814,35 +2814,42 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t t=
ype)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int qemu_loadvm_state_header(QEMUFile *f)<br>
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0unsigned int v;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0v =3D qemu_get_be32(f);<br>
=C2=A0 =C2=A0 =C2=A0if (v !=3D QEMU_VM_FILE_MAGIC) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Not a migration stream&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Not a migration stream,=
 &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;magic: %x !=3D %x&quot;, v, QEMU_VM_FILE_MAGIC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0v =3D qemu_get_be32(f);<br>
=C2=A0 =C2=A0 =C2=A0if (v =3D=3D QEMU_VM_FILE_VERSION_COMPAT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;SaveVM v2 format is obsolet=
e and don&#39;t work anymore&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;SaveVM v2 format is obs=
olete and no&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;longer supported, file version %x !=3D %x&quot;,<br></blockquote><div><br>=
</div><div>As Akihiko said in patch 2 review, better &quot;not to have line=
 breaks in string literals&quot; .. here, there is a missing space now.</di=
v><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v, QE=
MU_VM_FILE_VERSION_COMPAT);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (v !=3D QEMU_VM_FILE_VERSION) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unsupported migration strea=
m version&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unsupported migration s=
tream &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;version, file version %x !=3D %x&quot;, v, QEMU_VM_FILE_VERSION);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (migrate_get_current()-&gt;send_configuration) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_get_byte(f) !=3D QEMU_VM_CONFIGURATIO=
N) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Configuration=
 section missing&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D qemu_get_byte(f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v !=3D QEMU_VM_CONFIGURATION) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Configura=
tion section missing,&quot;<br></blockquote><div><br></div><div>here too</d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%x !=3D %x&quot;, v, QEMU_VM_CONFIGURATION);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_con=
figuration, &amp;savevm_state, 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vmstate_load_state(f, &amp;vmstate_con=
figuration, &amp;savevm_state, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -3119,7 +3126,7 @@ int qemu_loadvm_state(QEMUFile *f)<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_loadvm_thread_pool_create(mis);<br>
<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_header(f);<br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_header(f, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--00000000000011df8e063a6fb2a2--


