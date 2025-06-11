Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88962C71135
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 20:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPRxH-0003SP-LE; Wed, 11 Jun 2025 16:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPRxA-0003Rk-9Z
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPRx7-0007a7-KL
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 16:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749673298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QE0YZYK5Rgci6SgNbzKZXa40yfAYQL/U3zeDLa60RHw=;
 b=WxzLGorTnWn5bmP9P2mf023buHiC9KvaKydGZXTOT6NPUflYVAa42WJgXRpN0lbX4to3xP
 laSsuuh6GTdwR1lurKQrfXCnbZ91YCKGZjxM4UoZdtj01R7hN68krHZ0z/Mn92NmuMfiCH
 3N2fivF2HLPNOmQrxZaND6jxwU/k3bU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-Ad5tVN6DOH-Lg3yx7Ow1qQ-1; Wed, 11 Jun 2025 16:21:36 -0400
X-MC-Unique: Ad5tVN6DOH-Lg3yx7Ow1qQ-1
X-Mimecast-MFC-AGG-ID: Ad5tVN6DOH-Lg3yx7Ow1qQ_1749673295
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a5281ba3a4so97129f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 13:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673295; x=1750278095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QE0YZYK5Rgci6SgNbzKZXa40yfAYQL/U3zeDLa60RHw=;
 b=KLdN5STYEHRYvoXAMqSd8JapEoQ+0OFljR0OMPUkHODnSI/UZJokZMHqYD+qRHLvuZ
 FLwS3nbKiUWufxzoGHBivnXYgEQObyJOOf6k3RNNcPG5FHsvF2tbGhdXlgjylyHea15x
 em1jGfG6BD83EjGSHzcVpIJgvhaiz4J71zmkDdS5BoRv4F/AMwjdMSABSzamx0c9yUBo
 PAEhiXx/4bbPN0jSuS6MRtNuqqgCnwWlYNvudIT4OYYVw6H1qn1wDP9j63YR8I3L7yMt
 J9cZTZMJ0D7PyKQQN13xlJX/UY2CaBfEgKd+gD5EfOzAlrtX7T4IxvM9pVFtnSzxhd0/
 Hjjw==
X-Gm-Message-State: AOJu0YwJXJ3dhrJGMWycIa0ieb0uSeGhEUt8iGbz63N3cHCMied4JATB
 7tdRPsHECucG4qEPECAuqBllGLvXXW4Y6KGY0Erl7iVZqg0Or4tcUSpfjP8gz3yJNwUxdJYa2Cj
 Toak4i95xePE5kLeTrS2xBOuFk5LN08smLzqvId1SXd6NgHPgLAgjEA6bAQcQf+XASPEbFQTwiO
 ZFWlM975+pXX9m9Qmjbx9AanrlmKpLmaA=
X-Gm-Gg: ASbGncs01kboSp+OZCKtOpq1k8lZUlCtm5axCSvgEiuZgxc8YWgYt0SjnQLzH1cAtux
 waq1DYyy/hh+RehbjMHMNutxvlqF0WbiNiM0mnguHzTn17Vd2o/wHwHuUAWbRTKpUhIB/YYHZaa
 RapA==
X-Received: by 2002:a05:6000:4305:b0:3a4:f7ae:77cc with SMTP id
 ffacd0b85a97d-3a5603b08ddmr650067f8f.0.1749673295397; 
 Wed, 11 Jun 2025 13:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiTeNyZYRIh6EcBnfwPyeuwpF+YYcoG8d+HnGF6qrOyzpGXj8RCqam/IG7mVH/Mt8C5Bl+B0Ge0ojL/BnxoaE=
X-Received: by 2002:a05:6000:4305:b0:3a4:f7ae:77cc with SMTP id
 ffacd0b85a97d-3a5603b08ddmr650058f8f.0.1749673295036; Wed, 11 Jun 2025
 13:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250610212829.2818792-1-pierrick.bouvier@linaro.org>
 <20250610212829.2818792-2-pierrick.bouvier@linaro.org>
 <CABgObfaNGO+hJtGWf=eBvurQqi4u3GmLUFsoa4dWVwk0iiA3PQ@mail.gmail.com>
 <23b737f9-f8b6-437e-a59e-ecd8fec3819c@linaro.org>
In-Reply-To: <23b737f9-f8b6-437e-a59e-ecd8fec3819c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jun 2025 22:21:22 +0200
X-Gm-Features: AX0GCFtkKqs-ojs2nE64yQkkzA9loEESTQHzKbvEoeEgQcM4h61fd48Ton74oRs
Message-ID: <CABgObfZ7J+1uUn_b9s_2KoR5u7nG-XzEV9HEkbytbSN67DApqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] qemu/timer: introduce time dilation factor
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "P. Berrange, Daniel" <berrange@redhat.com>, "Maydell,
 Peter" <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000395e170637518f94"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000395e170637518f94
Content-Type: text/plain; charset="UTF-8"

Il mer 11 giu 2025, 20:55 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> > 1) different clocks have different starts, so the clock_start must be
> > stored per clock type
> >
>
> I was not sure if several clocks are used, so I'll simply use static in
> concerned functions.
>

Ok.

The cycles counter is also problematic, so perhaps make dilation work only
with TCG?

> 2) dilation must be applied to timers too.
>
>  From what I saw, timers either use clock function (already dilated), or
> rely on cpu_get_host_ticks().
> Do you suggest to dilate time returned by cpu_get_host_ticks(), or
> something different?
>

Right. It just seemed that something was missing... and indeed that's
deadline computation: it must convert the dilated deadline to host
nanoseconds, i.e. do a division instead of a multiply.

Paolo

--000000000000395e170637518f94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 11 giu 2025, 20:55 Pierri=
ck Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouv=
ier@linaro.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt; 1) different clocks have different starts, so the clock_start must be =
<br>
&gt; stored per clock type<br>
&gt;<br>
<br>
I was not sure if several clocks are used, so I&#39;ll simply use static in=
 <br>
concerned functions.<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Ok.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
The cycles counter is also problematic, so perhaps make dilation work only =
with TCG?</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; 2) dilation must be applied to timers too.<br>
<br>
=C2=A0From what I saw, timers either use clock function (already dilated), =
or <br>
rely on cpu_get_host_ticks().<br>
Do you suggest to dilate time returned by cpu_get_host_ticks(), or <br>
something different?<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Right. It just seemed that something was missing... and=
 indeed that&#39;s deadline computation: it must convert the dilated deadli=
ne to host nanoseconds, i.e. do a division instead of a multiply.=C2=A0</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--000000000000395e170637518f94--


