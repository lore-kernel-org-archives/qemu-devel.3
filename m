Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32EFC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYr9-0004xN-Fz; Wed, 06 Aug 2025 03:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYqv-0004l7-3s
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYqr-0000XA-PL
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754466380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7g+kedt4I1TQLFqECPRFn2YhOESHRmXJ6JXahKiNi+4=;
 b=KaI/7K2JnVzIZh70SynCWcQuSQlhjZV7LpkD+IlNXnkhGArN8q2K2eNfmzlyDltTXnX0cq
 5eIJc35FcEO40nlPKiNferzfF9kgAfcj9C3FA9lADLcgDNV8X2yN5vPDKVY+SVB4VDugdp
 +AJSKNcIkQxi7BqRlMcrABuSKBBQjfI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-45EIJYUoP9WFt00-8TYrgQ-1; Wed, 06 Aug 2025 03:46:19 -0400
X-MC-Unique: 45EIJYUoP9WFt00-8TYrgQ-1
X-Mimecast-MFC-AGG-ID: 45EIJYUoP9WFt00-8TYrgQ_1754466378
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31ebadfb7f2so6446432a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754466378; x=1755071178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7g+kedt4I1TQLFqECPRFn2YhOESHRmXJ6JXahKiNi+4=;
 b=ecfyLCNlgs5MDgzOAOUUuwDNRqwKwZnN4IjSF/iFW0jQbVAid12X+KuEc7SVm1oSs6
 nLsj6PEaChnbyPl/Zix87LYis82Pd+jRUnvQ6aBOI5eLp6RrrImLZIuDevjkA17b8UiI
 l4WobpqcDcBJIVFCLHd6LF1sHnij9VMGU7Hiutz0s30foO//C47C6NwXgX0CHtDDi1TQ
 cvh6asPVYwjVYz+5oUZFyriZ/J04qOc1t2gRnYuYrNj//KiEPkZ0LJAmrzFfxB/alkB4
 IGl9HWxOnfjJX0Xbm1rDvt42qsIvLgvMGpzjOaW9B7HQktWOoiXCJ6dobyN0ysER9s81
 BeMg==
X-Gm-Message-State: AOJu0YyLwckW+Ktwl/VSzFPLjUslgY7eLA14mEXw4TgvYgBUjMlqT23v
 1yxTkp3rLUqEzpbvcDzSXnueljePRxQ6T67RG6Um5ZhHzclWEPXYHEB+u4C9acv4RtPCM9lJoSN
 cX8PMVzt1yiJH5q9EeHiW3ZOGeHbH3p4s4mz4JIjfxIer2masjYliTTEGaHEo0sv61sx8QLsq+N
 qN1+zp8W29+Bi0pGbDzI8PknvViyzvvKE9Zo6qc0tQuEseubw=
X-Gm-Gg: ASbGncsujKLvqH956iayKobOlVf1iJdDrNlaF9Hq5tNpzhIR3MTQjAeYNyzIwxcBM5s
 zCEzfJL0Q4OhHcu6mVRkuabPIySoAAs+xxB0MZp5DOvaV7w+n/CllfFzxoyZPua7CuayRJ2gAPO
 oH3hSGFOamd0vKoSS6kvHNHtQPRF16iYwmbmbQxh+Pi13PzfafWP2vbA==
X-Received: by 2002:a17:90b:1d8f:b0:31c:bfb9:fca0 with SMTP id
 98e67ed59e1d1-32166c1e972mr2452259a91.4.1754466378163; 
 Wed, 06 Aug 2025 00:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwike0lQ06CxV2BRDGcUdTnKBJi7VrTRc/oeOnZo6uutFfno4sa8rwb74mbjzGRFNDpM76Cp8ZQYcRVVXU7Bs=
X-Received: by 2002:a17:90b:1d8f:b0:31c:bfb9:fca0 with SMTP id
 98e67ed59e1d1-32166c1e972mr2452225a91.4.1754466377744; Wed, 06 Aug 2025
 00:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-11-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-11-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Aug 2025 11:46:06 +0400
X-Gm-Features: Ac12FXw98BLO5TUHp13Ue6wBO-jUrAVs8V0VELmwySrJ_ZcEzKUJLaQGWc8kS-o
Message-ID: <CAMxuvaxprfd5YZ8H1iPkHXnpgKZ7iHx7vmfszspj7OKeB+1-Qw@mail.gmail.com>
Subject: Re: [PATCH v9 11/27] migration: push Error **errp into
 qemu_loadvm_section_part_end()
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
Content-Type: multipart/alternative; boundary="0000000000003755b0063bad8984"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

--0000000000003755b0063bad8984
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:29=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_section_part_end() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/savevm.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> e337e3c61e7627f09b853bf5e9b845c38cb5f082..1b93df7894dd332aea25da91e24d02f=
a16e73363
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2804,8 +2804,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t
> type, Error **errp)
>  }
>
>  static int
> -qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
> +qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
>  {
> +    ERRP_GUARD();
>      bool trace_downtime =3D (type =3D=3D QEMU_VM_SECTION_END);
>      int64_t start_ts, end_ts;
>      uint32_t section_id;
> @@ -2816,8 +2817,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t
> type)
>
>      ret =3D qemu_file_get_error(f);
>      if (ret) {
> -        error_report("%s: Failed to read section ID: %d",
> -                     __func__, ret);
> +        error_setg(errp, "Failed to read section ID: %d", ret);
>          return ret;
>      }
>
> @@ -2828,7 +2828,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t
> type)
>          }
>      }
>      if (se =3D=3D NULL) {
> -        error_report("Unknown savevm section %d", section_id);
> +        error_setg(errp, "Unknown savevm section %d", section_id);
>          return -EINVAL;
>      }
>
> @@ -2836,10 +2836,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t
> type)
>          start_ts =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>      }
>
> -    ret =3D vmstate_load(f, se, NULL);
> +    ret =3D vmstate_load(f, se, errp);
>      if (ret < 0) {
> -        error_report("error while loading state section id %d(%s)",
> -                     section_id, se->idstr);
> +        error_prepend(errp, "error while loading state section id %d(%s)=
:
> ",
> +                      section_id, se->idstr);
>          return ret;
>      }
>
> @@ -2850,6 +2850,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t
> type)
>      }
>
>      if (!check_section_footer(f, se)) {
> +        error_setg(errp, "Check section footer error, section_id: %d",
> +                   section_id);
>          return -EINVAL;
>      }
>
> @@ -3108,7 +3110,7 @@ retry:
>              break;
>          case QEMU_VM_SECTION_PART:
>          case QEMU_VM_SECTION_END:
> -            ret =3D qemu_loadvm_section_part_end(f, section_type);
> +            ret =3D qemu_loadvm_section_part_end(f, section_type, errp);
>              if (ret < 0) {
>                  goto out;
>              }
> @@ -3132,9 +3134,6 @@ retry:
>
>  out:
>      if (ret < 0) {
> -        if (*errp =3D=3D NULL) {
> -            error_setg(errp, "Loading VM state failed: %d", ret);
> -        }
>          qemu_file_set_error(f, ret);
>
>          /* Cancel bitmaps incoming regardless of recovery */
>
> --
> 2.50.1
>
>

--0000000000003755b0063bad8984
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, =
2025 at 10:29=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.co=
m">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">This is an incremental step in converting vmstate load=
ing<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that qemu_loadvm_section_part_end() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0migration/savevm.c | 21 ++++++++++-----------<br>
=C2=A01 file changed, 10 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index e337e3c61e7627f09b853bf5e9b845c38cb5f082..1b93df7894dd332aea25da91e24=
d02fa16e73363 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2804,8 +2804,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t t=
ype, Error **errp)<br>
=C2=A0}<br>
<br>
=C2=A0static int<br>
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)<br>
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0bool trace_downtime =3D (type =3D=3D QEMU_VM_SECTION_EN=
D);<br>
=C2=A0 =C2=A0 =C2=A0int64_t start_ts, end_ts;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t section_id;<br>
@@ -2816,8 +2817,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t typ=
e)<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D qemu_file_get_error(f);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: Failed to read section =
ID: %d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__func__, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to read section =
ID: %d&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2828,7 +2828,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t typ=
e)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (se =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unknown savevm section %d&q=
uot;, section_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unknown savevm section =
%d&quot;, section_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2836,10 +2836,10 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t t=
ype)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_ts =3D qemu_clock_get_us(QEMU_CLOCK=
_REALTIME);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ret =3D vmstate_load(f, se, NULL);<br>
+=C2=A0 =C2=A0 ret =3D vmstate_load(f, se, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;error while loading state s=
ection id %d(%s)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0section_id, se-&gt;idstr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;error while loading =
state section id %d(%s): &quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 section_id, se-&gt;idstr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2850,6 +2850,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t typ=
e)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!check_section_footer(f, se)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Check section footer er=
ror, section_id: %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0secti=
on_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -3108,7 +3110,7 @@ retry:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case QEMU_VM_SECTION_PART:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case QEMU_VM_SECTION_END:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D qemu_loadvm_section_part=
_end(f, section_type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D qemu_loadvm_section_part=
_end(f, section_type, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -3132,9 +3134,6 @@ retry:<br>
<br>
=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*errp =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Loading V=
M state failed: %d&quot;, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_file_set_error(f, ret);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Cancel bitmaps incoming regardless of =
recovery */<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--0000000000003755b0063bad8984--


