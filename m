Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BBEC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 10:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKhQ-0001QC-IA; Mon, 28 Jul 2025 06:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ugKdE-0005pY-2b
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1ugKdB-00074r-NL
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753696730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AIRdmDKuxmGspluCkk0Fm5IYvSd2GDK8ErT9r1IMzmo=;
 b=RLFCWqLr4HhvC7JHrmdrz4fltolzH3eQSQ+Bbw2840Bq8uZpsh6SZUI/rUsLnGyrd4d6Ll
 wn+XcnEKXRUofSN0rFGcvomR5IOyZ73eT6TtkGVPavg5Ya8jTB2xo63h1i54tad1XXuTsb
 2Kh0jUlJYkN9Sb/Q3sacA2e+/KxrO28=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-jNjyC0s8N6SheiFXxcUWLQ-1; Mon, 28 Jul 2025 05:58:47 -0400
X-MC-Unique: jNjyC0s8N6SheiFXxcUWLQ-1
X-Mimecast-MFC-AGG-ID: jNjyC0s8N6SheiFXxcUWLQ_1753696727
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70732006280so30748986d6.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 02:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753696727; x=1754301527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AIRdmDKuxmGspluCkk0Fm5IYvSd2GDK8ErT9r1IMzmo=;
 b=ECh21kdU7OzMOgqlBTvTtWTDmttQaL2u9nPbMYgARwSIU6o0CR4sjh4Ev5Y4YCS96H
 7riBo0heIcObOvNq3qE/AApK7BH00XXNjKS7Rbk0Lg1nhzAuF4PU0hJG60IVgvd3ZclX
 UaKiZDv7qUt+syS9Gmd9UQyEhQ6727WO97m/2fNep63/EunpAzWeSNjt0dMvTtWF6SSi
 qzsZu7MWsvZFnyKeMw6M9M4EdVrgRL7BqI3kxpQIZw6fy22ISd9YCHjGGV0jjOjTXF6W
 lZZv+k6H0T5lmEIjao+7+REvJ8JTi8sROB3IeXRtgarNXv+UCArhht1ON+AeoueHOq7l
 btOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWEj4FHms+xGXAllglIicA1D+ml5UG/p/2zy53V6C94nes46y3rJwGtQ4nuT2834MJOMU8789qcJ3V@nongnu.org
X-Gm-Message-State: AOJu0YydkmoLUeQWxAv2wUo6dg1FRDA26jKRG6Ez06Faylwiv5zL+z8h
 52F+vXOqhZh4elAlc2Lo4fUHNOJpRal+LIcx9kzJURRB3z77YGrcjvjb9XDM0sr3Rlgp265W2yY
 LwJjdfaiFZJkf3NSGu1WZ9+bIJyuKy/1UaM4zMkh21kfplUtG8U2e9z36eV+XH52yT0WtmFnbzu
 zU4HAr7ONAB6rasEFlpN1MrKjB1ayCHOs=
X-Gm-Gg: ASbGnctkdOPKoFZfWHPclKhlTF2MCALgceHcDx1+2VzB1VudFgOFgbmUEWa1tpFWJsz
 JnTHA9dR38j+dh46zL8B3N3TRb4BrhoHEUU0nEaoKEK3mPjT9UVdZ62InV2S563wDfmVmvKWSZf
 jsJ0dMZvhV5+hBmZ154hj0S14=
X-Received: by 2002:a05:6214:2342:b0:704:7fda:d174 with SMTP id
 6a1803df08f44-707204e8ce2mr147424976d6.2.1753696726768; 
 Mon, 28 Jul 2025 02:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJsrH+/Ls1UEOw947XqzzIbqejTwb4NeRa0VrnhyKrfzPAenK6sh/ge4PxbEssoD8UC6qH7QyKjA72whLszq4=
X-Received: by 2002:a05:6214:2342:b0:704:7fda:d174 with SMTP id
 6a1803df08f44-707204e8ce2mr147424786d6.2.1753696726392; Mon, 28 Jul 2025
 02:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250717145948.77870-1-kkostiuk@redhat.com>
 <87pldwbspt.fsf@pond.sub.org>
 <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
 <87seipkif5.fsf@pond.sub.org>
 <CAPMcbCrTTkr5sX11wn1WaXOLgqQTAD-1oxUuqOc+oEmUxcotkw@mail.gmail.com>
 <c3afe3f5-962d-40ba-a778-716ef9929053@linaro.org>
 <CAPMcbCp5BuLADQoDijw811G4-u-ssBJ+eFrzyiU8_G9Tr7uLHA@mail.gmail.com>
 <44ca54d5-1292-4388-9436-dca2b6e7e97f@linaro.org>
In-Reply-To: <44ca54d5-1292-4388-9436-dca2b6e7e97f@linaro.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 28 Jul 2025 12:58:34 +0300
X-Gm-Features: Ac12FXzct8tipo1CCpbJf6oshs6NNpsI_YLXdren3zIJaB11tM6TQsEzYbpR7Lg
Message-ID: <CAPMcbCrhuuEbSUTk7a_h9bc-a70JekF682ozzYS=8MeUyf3uWA@mail.gmail.com>
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Yan Vugenfirer <yvugenfi@redhat.com>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006bb16c063afa56a1"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

--0000000000006bb16c063afa56a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Based on the following part from the new docs
* If a human readable message cannot be found for the given @error, an empt=
y
* string is returned.
Do you have any objections to this patch?

Best Regards,
Konstantin Kostiuk.


On Mon, Jul 28, 2025 at 12:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> On 25/7/25 11:59, Kostiantyn Kostiuk wrote:
> > Issue reported to GLib https://gitlab.gnome.org/GNOME/glib/-/issues/374=
0
> > <https://gitlab.gnome.org/GNOME/glib/-/issues/3740>
> > PR with fix https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4716
> > <https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4716>
>
> Even already merged, thank you!
>
>

--0000000000006bb16c063afa56a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Based on the following part from the new docs</div><d=
iv><div class=3D"gmail-diff-grid-row gmail-diff-tr gmail-line_holder"><div =
id=3D"gmail-c7a468422ca8b8131ed7db3eb8052e74a0daacb0_207_210" class=3D"gmai=
l-diff-grid-left gmail-left-side"><div class=3D"gmail-diff-td gmail-line_co=
ntent gmail-with-coverage gmail-left-side gmail-new"><span class=3D"gmail-l=
ine"><span class=3D"gmail-cm"> * If a human readable message cannot be foun=
d for the given @error, an empty</span></span>
</div></div> </div>   <div class=3D"gmail-diff-grid-row gmail-diff-tr gmail=
-line_holder"><div id=3D"gmail-c7a468422ca8b8131ed7db3eb8052e74a0daacb0_207=
_211" class=3D"gmail-diff-grid-left gmail-left-side"></div></div><div class=
=3D"gmail-diff-td gmail-line-coverage gmail-left-side gmail-has-tooltip gma=
il-new"></div> <div class=3D"gmail-diff-td gmail-line-inline-findings gmail=
-left-side gmail-new"></div> <div class=3D"gmail-diff-td gmail-line_content=
 gmail-with-coverage gmail-left-side gmail-new"><span class=3D"gmail-line">=
<span class=3D"gmail-cm"> * string is returned.</span></span> <br></div>Do =
you have any objections to this patch?<div class=3D"gmail-diff-td gmail-lin=
e_content gmail-with-coverage gmail-left-side gmail-new"><br></div></div><d=
iv><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signa=
ture"><div dir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiuk.</di=
v></div></div></div><br></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 28, 2025 at 12:48=
=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro=
.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 25/7/25 11:59, Kostiantyn Kostiuk wrote:<br>
&gt; Issue reported to GLib <a href=3D"https://gitlab.gnome.org/GNOME/glib/=
-/issues/3740" rel=3D"noreferrer" target=3D"_blank">https://gitlab.gnome.or=
g/GNOME/glib/-/issues/3740</a> <br>
&gt; &lt;<a href=3D"https://gitlab.gnome.org/GNOME/glib/-/issues/3740" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.gnome.org/GNOME/glib/-/iss=
ues/3740</a>&gt;<br>
&gt; PR with fix <a href=3D"https://gitlab.gnome.org/GNOME/glib/-/merge_req=
uests/4716" rel=3D"noreferrer" target=3D"_blank">https://gitlab.gnome.org/G=
NOME/glib/-/merge_requests/4716</a> <br>
&gt; &lt;<a href=3D"https://gitlab.gnome.org/GNOME/glib/-/merge_requests/47=
16" rel=3D"noreferrer" target=3D"_blank">https://gitlab.gnome.org/GNOME/gli=
b/-/merge_requests/4716</a>&gt;<br>
<br>
Even already merged, thank you!<br>
<br>
</blockquote></div>

--0000000000006bb16c063afa56a1--


