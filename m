Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070ACC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 18:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx8mk-0001p1-9L; Tue, 25 Mar 2025 14:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tx8mi-0001no-4y
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tx8mg-0006Zo-5x
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 14:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742926432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwDJXm2RsJNe4eB8DGHeaNjAcbEU1mHJXaYb8kSqj78=;
 b=aUt1mbNQjGdy+WagJ6mcCwBUyiiwU9xqueElq96fSxK85M1pINks+OafG3HUrrJJl7BzR2
 zqEkfSWTMxGbtQshgMPheOnxSr7gS0wVjPKpjsZvqDgAihruI+EK86U4n1dUclcoLlSMfr
 bnnJF7VmM/nvftv7PPxqnbYOC1mWgTM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-HHv1PfLxNxSTFB6CvyFZBQ-1; Tue, 25 Mar 2025 14:13:48 -0400
X-MC-Unique: HHv1PfLxNxSTFB6CvyFZBQ-1
X-Mimecast-MFC-AGG-ID: HHv1PfLxNxSTFB6CvyFZBQ_1742926428
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3032f4ea8cfso5429051a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 11:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742926427; x=1743531227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UwDJXm2RsJNe4eB8DGHeaNjAcbEU1mHJXaYb8kSqj78=;
 b=CWTGCZXEHmzLHpUvjeVBoodf2t0g+nmILiEiVHDdCyjkveTWwzhBVCGN+HgHVBajaX
 OChoVaYI7JTc+AcmJ7uU7M4jfi6ODvDy9Tx0TeLEu7qtmj3uob/GlJxtb3PMyKiiduhK
 UIt58BwhC8sNIJ9E6eyV+4Nq+6A6TtKDoEZQPwEHEc0IgrLLg16U+iG0iqfXK/M2jdMZ
 Mo1lfnd9XRu07dbKbjJ6m6bCxkx/mZR5rgxHIaC4xfSPx6tVc1mRKaqT5QnnabUhXEjp
 YqpoZwU0v5HFblrCgWt2Oy/v4E+uIGo1afGoCfSw8i//Sho5AbsfGHK9YnlbYv0r9AUK
 Y9Vg==
X-Gm-Message-State: AOJu0Yx7xJZAFeDeqwyEHESZNtVECObl+cBFP0ueWmDNNEjs9rUaYg9V
 QX8hHhGjOflMJ5Z7grjtvwjXL53w6aQu7GkXJYK7uAKiAE3ijFa7ORPTWldX6lQiBMfgx4i7nZr
 kAM7Da8n9PZbmdqi7iYdwuvWwN3lgU46X4B3/yklKBl/7qcjKKItZJ30Dn2tCE3wccJFoDodL0f
 E+X9LYUaAL+fSIs6KuAmkyRxWehdE=
X-Gm-Gg: ASbGncsCJy8FpZmpPosAY56ktMba7rKMRiOWO8JPD3sJvun6E2GB1GX1btn7em/9Htx
 4HW5Uz31oa3QkHdjJtZ+HvA0OL2TBiUZ1T9mLZZ4AB7SarHbZbJPAid7hJ6qU3gi6jsJ9z/lCyh
 whY/4SDoZFm7haAySexAiaqFbpEzuG
X-Received: by 2002:a17:90b:48c2:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-3030fe83954mr36667418a91.12.1742926427472; 
 Tue, 25 Mar 2025 11:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtmyi6GcFqJ3m1wquqvMzV9hfAZaSyUBkaM6fiqp8kmmjJ/Bbe7WxF9zPc9vruchvmpBqsgq7pCmUF5bEXzgg=
X-Received: by 2002:a17:90b:48c2:b0:2fa:15ab:4de7 with SMTP id
 98e67ed59e1d1-3030fe83954mr36667363a91.12.1742926427037; Tue, 25 Mar 2025
 11:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250322010857.309490-1-jsnow@redhat.com>
 <20250322010857.309490-3-jsnow@redhat.com>
 <87a599o5hy.fsf@pond.sub.org>
In-Reply-To: <87a599o5hy.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 25 Mar 2025 14:13:35 -0400
X-Gm-Features: AQ5f1JpyUOGx4WHsKaXiJm5gxBquSYODiTaS-a2DQ4NgGGUsng15Jjzjop4IEeI
Message-ID: <CAFn=p-a5vaW94HTzRtcX-xss5GzitHc_auPnnK-brWVhOZt23Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] docs, qapi: generate undocumented return sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Lukas Straub <lukasstraub2@web.de>, 
 Fabiano Rosas <farosas@suse.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org, 
 Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, 
 Zhenwei Pi <pizhenwei@bytedance.com>, Mads Ynddal <mads@ynddal.dk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: multipart/alternative; boundary="0000000000008dbb4c06312eaedf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000008dbb4c06312eaedf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 4:54=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This patch changes the qapidoc transmogrifier to generate Return value
> > documentation for any command that has a return value but hasn't
> > explicitly documented that return value.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> A number of commands lack return value documentation before the patch.
> These are:
>
> QGA: guest-network-get-route
>
> QMP: x-debug-query-block-graph, query-tpm, query-dirty-rate,
>      query-vcpu-dirty-limit, query-vm-generation-id,
>      query-memory-size-summary, query-memory-devices,
>      query-acpi-ospm-status, query-stats-schemas, query-stats-schemas
>
> This patch fixes that.  However, in my testing, it adds the missing
> "Return:" doc *twice* for x-debug-query-block-graph and
> query-dirty-rate.


Guess who forgot a "break" statement?

--js

--0000000000008dbb4c06312eaedf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 25,=
 2025 at 4:54=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch changes the qapidoc transmogrifier to generate Return value=
<br>
&gt; documentation for any command that has a return value but hasn&#39;t<b=
r>
&gt; explicitly documented that return value.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
A number of commands lack return value documentation before the patch.<br>
These are:<br>
<br>
QGA: guest-network-get-route<br>
<br>
QMP: x-debug-query-block-graph, query-tpm, query-dirty-rate,<br>
=C2=A0 =C2=A0 =C2=A0query-vcpu-dirty-limit, query-vm-generation-id,<br>
=C2=A0 =C2=A0 =C2=A0query-memory-size-summary, query-memory-devices,<br>
=C2=A0 =C2=A0 =C2=A0query-acpi-ospm-status, query-stats-schemas, query-stat=
s-schemas<br>
<br>
This patch fixes that.=C2=A0 However, in my testing, it adds the missing<br=
>
&quot;Return:&quot; doc *twice* for x-debug-query-block-graph and<br>
query-dirty-rate.</blockquote><div><br></div><div>Guess who forgot a &quot;=
break&quot; statement?</div><div><br></div><div>--js <br></div></div></div>

--0000000000008dbb4c06312eaedf--


