Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAF2C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 13:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufIv5-0005e2-Pt; Fri, 25 Jul 2025 09:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ufIun-0005HH-NA
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ufIuk-00071y-RT
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 09:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753451805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HD3hBfYt9gD5SVrOggzBZtAeOZ2iig6eTgPP9KryJd4=;
 b=bMpmDhWF4HsAGlEaBC2iEnJ1CrJrq7phydxl1JacGW3auUl8YEppUQ5jIwd/KFbg94qZFt
 xrUOE9IxM/qdEgYKS6tEhorkGqlkXcfD7S2T6ERxfOUYKZRbB7WqAjdcTiUGuoJCB95Lpy
 neYj6XoZZRmNH8g2zNL8t0hN5l8qYZE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-XCDG70M7M8SJhWNJ4mwWcQ-1; Fri, 25 Jul 2025 09:56:43 -0400
X-MC-Unique: XCDG70M7M8SJhWNJ4mwWcQ-1
X-Mimecast-MFC-AGG-ID: XCDG70M7M8SJhWNJ4mwWcQ_1753451802
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31366819969so1979012a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 06:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753451802; x=1754056602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HD3hBfYt9gD5SVrOggzBZtAeOZ2iig6eTgPP9KryJd4=;
 b=W9RyIC/KB6VX82FZ7vEOFnwkVzPbcbQ9Mp9+2zxOYf83+bW7xwglebsoMzD65mpMBO
 Lv1vLCcaj3rFfavn4HBkPFUpI8gEB3twTOHoxb80k4GhaIyHjHma9OJmj2fjeQv84Ecn
 v77YkaYh7zNQpf11BTV306v9l41fGq7UP5+CayL60uldgkDjfdNqn9r+84UYZWzqcXcm
 iLtKKuxk/rp1q7X1pTqaoGtE/LeHQ5xxjG47x0XCRWDI8WDUBANhn5708W3AsYW55lz7
 GdOHVGDDJVxP033NWgGY+bVapGIZdO2xWEeraG2J8f6KSWj1osWdghKv06/Dl++qGMGF
 mqlA==
X-Gm-Message-State: AOJu0Yzs8hqsZCfNgagUVw1gw2balcGE1it1+QA7tRYgRJsWfGnMCVq3
 HyOgfLv9l/Sievgt21UKx3A+46t/u+v+WzAZ39fCzHCphzY/0qQxap1GdHz/3oLN/jyzDRYYiJ/
 5d72keYzWSU/6v+qXh0xlv2CSBw89/n49O8QyEaDrtXXwnnq7dK8WgUen4LjBrsxK51uYQjHOwm
 2Lz3ol5kzA5N+sSb/rnYPakVVpvM2XoCo=
X-Gm-Gg: ASbGnctG5YYN+xrVQ+Ng49q75hls/oKU9Ew+B7LUA/jllLlST8vcthhnSEIdaBPq5ni
 wJa0oX0v3LhS5Nk7HDWos9J8Ij+fE86Zasvs9oX74NMx1qGogIk7ahHaBzl2wFV2Wis5ys4VEZK
 4nOtSRH8lw/ox/HoDPEdr7CnwSOq2P8W+L4uOZrbeolq4zvwBFLuTZ+Q==
X-Received: by 2002:a17:90a:e185:b0:31c:bfb9:fca0 with SMTP id
 98e67ed59e1d1-31e77a18508mr2844064a91.4.1753451802155; 
 Fri, 25 Jul 2025 06:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbqDbHFYVeEhDrhfhpZiCA4QFe83d+PuWAo+EsaSGY/PHjkZJrl9BcgBveBJo4+AshPCpz9hKQexYSPrk5LrY=
X-Received: by 2002:a17:90a:e185:b0:31c:bfb9:fca0 with SMTP id
 98e67ed59e1d1-31e77a18508mr2844030a91.4.1753451801704; Fri, 25 Jul 2025
 06:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-4-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-4-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Jul 2025 17:56:30 +0400
X-Gm-Features: Ac12FXxFRPbbUX9bjvz6DsB3mlX66kMYADIJAY3egu_r8F5JyCdKmz1usZW_bK0
Message-ID: <CAMxuvawNbvc6ie249Y_oSw+d2QrYpdMJGZBKN_iCdEXpdqpSKw@mail.gmail.com>
Subject: Re: [PATCH v7 04/24] migration: push Error **errp into vmstate_load()
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
Content-Type: multipart/alternative; boundary="000000000000c58e54063ac14fcf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

--000000000000c58e54063ac14fcf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:19=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_load() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/savevm.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> 842ff3dc6d5ccb05f7d33cef9f7319b141419501..736410be867a29efa24d749528c9bc2=
03a3e8131
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -963,14 +963,20 @@ void vmstate_unregister(VMStateIf *obj, const
> VMStateDescription *vmsd,
>      }
>  }
>
> -static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
> +static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
>  {
> +    int ret;
>      trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
>      if (!se->vmsd) {         /* Old style */
> -        return se->ops->load_state(f, se->opaque, se->load_version_id);
> +        ret =3D se->ops->load_state(f, se->opaque, se->load_version_id);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load VM version_id: '%d', ret:
> '%d'",
> +                       se->load_version_id, ret);
> +        }
> +        return ret;
>      }
>      return vmstate_load_state(f, se->vmsd, se->opaque,
> se->load_version_id,
> -                              NULL);
> +                              errp);
>  }
>
>  static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> @@ -2741,7 +2747,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t
> type)
>          start_ts =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>      }
>
> -    ret =3D vmstate_load(f, se);
> +    ret =3D vmstate_load(f, se, NULL);
>      if (ret < 0) {
>          error_report("error while loading state for instance 0x%"PRIx32"
> of"
>                       " device '%s'", instance_id, idstr);
> @@ -2794,7 +2800,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t
> type)
>          start_ts =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>      }
>
> -    ret =3D vmstate_load(f, se);
> +    ret =3D vmstate_load(f, se, NULL);
>      if (ret < 0) {
>          error_report("error while loading state section id %d(%s)",
>                       section_id, se->idstr);
>
> --
> 2.50.0
>
>

--000000000000c58e54063ac14fcf
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
It is ensured that vmstate_load() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0migration/savevm.c | 16 +++++++++++-----<br>
=C2=A01 file changed, 11 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index 842ff3dc6d5ccb05f7d33cef9f7319b141419501..736410be867a29efa24d749528c=
9bc203a3e8131 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -963,14 +963,20 @@ void vmstate_unregister(VMStateIf *obj, const VMState=
Description *vmsd,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se)<br>
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 int ret;<br>
=C2=A0 =C2=A0 =C2=A0trace_vmstate_load(se-&gt;idstr, se-&gt;vmsd ? se-&gt;v=
msd-&gt;name : &quot;(old)&quot;);<br>
=C2=A0 =C2=A0 =C2=A0if (!se-&gt;vmsd) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 Old style */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return se-&gt;ops-&gt;load_state(f, se-&gt;opa=
que, se-&gt;load_version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D se-&gt;ops-&gt;load_state(f, se-&gt;op=
aque, se-&gt;load_version_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load VM version_id: &#39;%d&#39;, ret: &#39;%d&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0se-&gt;load_version_id, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return vmstate_load_state(f, se-&gt;vmsd, se-&gt;opaque=
, se-&gt;load_version_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errp);<br>
=C2=A0}<br>
<br>
=C2=A0static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,<b=
r>
@@ -2741,7 +2747,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t t=
ype)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_ts =3D qemu_clock_get_us(QEMU_CLOCK=
_REALTIME);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load(f, se);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load(f, se, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;error while loading st=
ate for instance 0x%&quot;PRIx32&quot; of&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot; device &#39;%s&#39;&quot;, instance_id, idstr);<br>
@@ -2794,7 +2800,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t typ=
e)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_ts =3D qemu_clock_get_us(QEMU_CLOCK=
_REALTIME);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load(f, se);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load(f, se, NULL);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;error while loading st=
ate section id %d(%s)&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 section_id, se-&gt;idstr);<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--000000000000c58e54063ac14fcf--


