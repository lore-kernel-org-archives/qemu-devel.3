Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E743CF64A2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 07:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLzSb-0004CP-BZ; Thu, 20 Nov 2025 02:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1vLzSY-0004Bq-Ls
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 02:52:06 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1vLzSU-0006mu-3A
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 02:52:06 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-640c857ce02so525482d50.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 23:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763624832; x=1764229632; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XHRtT09ONWK9qV5XAP5FbYoBYjc+fXZzlYdG9kcBAbo=;
 b=QPM5bpwPDGEucBHRpA0aBOqmkYEFsXJxLgGotgBdfFMbsEWV/S1snntYKyyujf0jZ8
 VjHHBE4vQtboXyd6+ZQcj91bgg5oP1s62OtqvqZ0SSX1BIVQbusmqSqfSQIlwhW30wWw
 3o5FVUZ4pOu2/TMmJbXCPm8p+K2Lt+4YMdb3OCKjhQujELYBV6gREIQc97/I1Dlr8t1n
 70WkCmuD5BL90PLPA9PttMbxCam8kx+spGG1GPjmkkj18DNHi+EWr9M3HLWnLs5rhczA
 NgFoefWKLKB5iNicCKhruZeQHrdza/IsjT1sgiZN0H9GS3b4mI0MpH3QtWpZqFrK6JVP
 +6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763624832; x=1764229632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHRtT09ONWK9qV5XAP5FbYoBYjc+fXZzlYdG9kcBAbo=;
 b=WNBmM0viYdrLPMveerExFQhuApGRZct41ZbHfZN80t3HY+rWPIOC7psNkOPO7Szgqk
 FNqLmn6YvWsv2d7nNuNHA+YYJ7p1BDjRtVxn2RSkdPiou3vk+XG90AGiwZ4FvKsalGLw
 11MVyTMkCyXmwyEGmrz1fHHTbMocQWilgezql7h4j+fu1FTK5B1vSpnXklW+r2cLkZKX
 6wJVun80FUtlGQPnIQjxLeifeq0Ziebh/YgEmu6utqc1hqNmx+nefjEHQGXHsY3+U9e6
 o22eohbZa94p1/IlOn31jimmrV6rglkBdSPClwJRHthgpOshImfLWab93MNgzUyyS4mv
 lXoA==
X-Gm-Message-State: AOJu0YyhWwtJLnF4grk+5ILgnsJZKhuSeEYJ2xa4ZBP/4cxJn9fDNAe3
 kpOdzXdzQxeMeTOxFfBlHUkB6m0pVBcF4LY8Hh2yoh82qHX0xjbT8CbjcxJ9GOiXty/PdIu7BbJ
 wqYQ04d1byojRgZsarEQhebHczue5iNY=
X-Gm-Gg: ASbGncsViX6npgozkjYzTcIVhPJ3bb2JjL0cSMXEL+AhSmFIlGz9Muh6ILRTqTHcCOX
 nr3bDsigU+zAn92Hrk0aOpZ3vIzT0MYJnLRI/O3oLE2M/cTFEk838OmsWNzPd4eYRRxZ5QtHBNc
 ADhrgd2CED59Peao+sOgry2DKYWIEyf9nCHmKdgzdTlPl5luMrPnkAaS7jhmIsAcz2S+sNiPjed
 cKOhjnZWSMKAdcKBN0syjaaZJDfHj/skI3I90NZ2ygQwGfmQ7PzBikNy047b5H3NmvrR+5tmdiA
 vyR31ViTggpbxlGtxSNMVuxBdboJ
X-Google-Smtp-Source: AGHT+IGFPRqQUIuH0DNNjuTC+HlxqTnaKtQRdIATsDdVkSVaB3pmDpYaN9NNHd9ExqUTwhYSRMzt3xR68w1gOiuaXeI=
X-Received: by 2002:a05:690e:42dc:b0:640:e3c6:c419 with SMTP id
 956f58d0204a3-642f77b9bb4mr1025280d50.18.1763624832636; Wed, 19 Nov 2025
 23:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-10-alex.bennee@linaro.org>
In-Reply-To: <20251119113953.1432303-10-alex.bennee@linaro.org>
From: William Kosasih <kosasihwilliam4@gmail.com>
Date: Thu, 20 Nov 2025 18:17:01 +1030
X-Gm-Features: AWmQ_bl48qgxGqVTw1C4gPCqIpLriYj_eaERIeIB5rEyDtveMRX2hbLMesPwcXk
Message-ID: <CAG66A_cQw+_NpbxCSYW66T05pBy0C+ei6RgqhMDWrVZ8zdU+yA@mail.gmail.com>
Subject: Re: [PATCH 9/9] contrib/gitdm: add more individual contributors
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000aa9ca9064401e787"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000aa9ca9064401e787
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: William Kosasih<kosasihwilliam4@gmail.com>

On Wed, Nov 19, 2025 at 22:10 Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

> I'll only add names explicitly acked here as its quite possible people
> are using different addresses than their company affiliation. Let me
> know if you want contributions mapped to a company or academia instead.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
> Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> Cc: Tomita Moeko <tomitamoeko@gmail.com>
> Cc: Julian Ganz <neither@nut.email>
> Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Cc: Sean Wei <me@sean.taipei>
> Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Cc: Phil Dennis-Jordan <phil@philjordan.eu>
> Cc: Jackson Donaldson <jackson88044@gmail.com>
> Cc: Weifeng Liu <weifeng.liu.z@gmail.com>
> Cc: Roman Penyaev <r.peniaev@gmail.com>
> Cc: William Kosasih <kosasihwilliam4@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  contrib/gitdm/group-map-individuals | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/contrib/gitdm/group-map-individuals
> b/contrib/gitdm/group-map-individuals
> index d7116f5444f..4ac0f99b87c 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -42,3 +42,17 @@ shentey@gmail.com
>  bmeng@tinylab.org
>  strahinja.p.jankovic@gmail.com
>  Jason@zx2c4.com
> +amarjargal16@gmail.com
> +soumyajyotisarkar23@gmail.com
> +tomitamoeko@gmail.com
> +neither@nut.email
> +ktokunaga.mail@gmail.com
> +me@sean.taipei
> +roy.hopkins@randomman.co.uk
> +phil@philjordan.eu
> +jackson88044@gmail.com
> +weifeng.liu.z@gmail.com
> +r.peniaev@gmail.com
> +kosasihwilliam4@gmail.com
> +linux@roeck-us.net
> +tanishdesai37@gmail.com
> --
> 2.47.3
>
>

--000000000000aa9ca9064401e787
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div><div><div>
<div>
<p dir=3D"auto">Acked-by: William Kosasih&lt;<a href=3D"mailto:kosasihwilli=
am4@gmail.com" target=3D"_blank">kosasihwilliam4@gmail.com</a>&gt;</p></div=
></div></div></div></div><div><div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Nov 19, 2025 at 22:10 Alex Benn=C3=A9=
e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.benn=
ee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:soli=
d;padding-left:1ex;border-left-color:rgb(204,204,204)">I&#39;ll only add na=
mes explicitly acked here as its quite possible people<br>
are using different addresses than their company affiliation. Let me<br>
know if you want contributions mapped to a company or academia instead.<br>
<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Cc: Amarjargal Gundjalam &lt;<a href=3D"mailto:amarjargal16@gmail.com" targ=
et=3D"_blank">amarjargal16@gmail.com</a>&gt;<br>
Cc: Soumyajyotii Ssarkar &lt;<a href=3D"mailto:soumyajyotisarkar23@gmail.co=
m" target=3D"_blank">soumyajyotisarkar23@gmail.com</a>&gt;<br>
Cc: Tomita Moeko &lt;<a href=3D"mailto:tomitamoeko@gmail.com" target=3D"_bl=
ank">tomitamoeko@gmail.com</a>&gt;<br>
Cc: Julian Ganz &lt;neither@nut.email&gt;<br>
Cc: Kohei Tokunaga &lt;<a href=3D"mailto:ktokunaga.mail@gmail.com" target=
=3D"_blank">ktokunaga.mail@gmail.com</a>&gt;<br>
Cc: Sean Wei &lt;me@sean.taipei&gt;<br>
Cc: Roy Hopkins &lt;<a href=3D"mailto:roy.hopkins@randomman.co.uk" target=
=3D"_blank">roy.hopkins@randomman.co.uk</a>&gt;<br>
Cc: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu" target=3D"=
_blank">phil@philjordan.eu</a>&gt;<br>
Cc: Jackson Donaldson &lt;<a href=3D"mailto:jackson88044@gmail.com" target=
=3D"_blank">jackson88044@gmail.com</a>&gt;<br>
Cc: Weifeng Liu &lt;<a href=3D"mailto:weifeng.liu.z@gmail.com" target=3D"_b=
lank">weifeng.liu.z@gmail.com</a>&gt;<br>
Cc: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" target=3D"_bla=
nk">r.peniaev@gmail.com</a>&gt;<br>
Cc: William Kosasih &lt;<a href=3D"mailto:kosasihwilliam4@gmail.com" target=
=3D"_blank">kosasihwilliam4@gmail.com</a>&gt;<br>
Cc: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blan=
k">linux@roeck-us.net</a>&gt;<br>
Cc: Tanish Desai &lt;<a href=3D"mailto:tanishdesai37@gmail.com" target=3D"_=
blank">tanishdesai37@gmail.com</a>&gt;<br>
---<br>
=C2=A0contrib/gitdm/group-map-individuals | 14 ++++++++++++++<br>
=C2=A01 file changed, 14 insertions(+)<br>
<br>
diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-=
individuals<br>
index d7116f5444f..4ac0f99b87c 100644<br>
--- a/contrib/gitdm/group-map-individuals<br>
+++ b/contrib/gitdm/group-map-individuals<br>
@@ -42,3 +42,17 @@ <a href=3D"mailto:shentey@gmail.com" target=3D"_blank">s=
hentey@gmail.com</a><br>
=C2=A0<a href=3D"mailto:bmeng@tinylab.org" target=3D"_blank">bmeng@tinylab.=
org</a><br>
=C2=A0<a href=3D"mailto:strahinja.p.jankovic@gmail.com" target=3D"_blank">s=
trahinja.p.jankovic@gmail.com</a><br>
=C2=A0<a href=3D"mailto:Jason@zx2c4.com" target=3D"_blank">Jason@zx2c4.com<=
/a><br>
+<a href=3D"mailto:amarjargal16@gmail.com" target=3D"_blank">amarjargal16@g=
mail.com</a><br>
+<a href=3D"mailto:soumyajyotisarkar23@gmail.com" target=3D"_blank">soumyaj=
yotisarkar23@gmail.com</a><br>
+<a href=3D"mailto:tomitamoeko@gmail.com" target=3D"_blank">tomitamoeko@gma=
il.com</a><br>
+neither@nut.email<br>
+<a href=3D"mailto:ktokunaga.mail@gmail.com" target=3D"_blank">ktokunaga.ma=
il@gmail.com</a><br>
+me@sean.taipei<br>
+<a href=3D"mailto:roy.hopkins@randomman.co.uk" target=3D"_blank">roy.hopki=
ns@randomman.co.uk</a><br>
+<a href=3D"mailto:phil@philjordan.eu" target=3D"_blank">phil@philjordan.eu=
</a><br>
+<a href=3D"mailto:jackson88044@gmail.com" target=3D"_blank">jackson88044@g=
mail.com</a><br>
+<a href=3D"mailto:weifeng.liu.z@gmail.com" target=3D"_blank">weifeng.liu.z=
@gmail.com</a><br>
+<a href=3D"mailto:r.peniaev@gmail.com" target=3D"_blank">r.peniaev@gmail.c=
om</a><br>
+<a href=3D"mailto:kosasihwilliam4@gmail.com" target=3D"_blank">kosasihwill=
iam4@gmail.com</a><br>
+<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net=
</a><br>
+<a href=3D"mailto:tanishdesai37@gmail.com" target=3D"_blank">tanishdesai37=
@gmail.com</a><br>
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>
</div>

--000000000000aa9ca9064401e787--

