Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335B9C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 02:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rczG3-0007Hk-ML; Wed, 21 Feb 2024 21:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rczG0-0007HF-M0
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:56:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rczFz-0004eA-9a
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 21:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708570578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zFPmGy81lNg+XAh+N8ZatgzyKG/G0Rd9VX7vVLL28ig=;
 b=AiByuJSf2mAjoQ3XwdtxGSU6wQTu7TFUtKdu37VXq4E+8U2U9sgQzrjG1OTiX/YoVyTRJo
 acF9IAcycvn7UWnY1Ry5n+ltXhijRpmT9l2LHSPqow4+2hs0vc51f9MPCbyLr6wpnL2NLl
 Ws37R+RvwYlt0iStpZXISe18FAq2NFE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-NuHpUAHxP6KjdqFD90Kmfg-1; Wed, 21 Feb 2024 21:56:14 -0500
X-MC-Unique: NuHpUAHxP6KjdqFD90Kmfg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-603c0e020a6so62561927b3.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 18:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708570574; x=1709175374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFPmGy81lNg+XAh+N8ZatgzyKG/G0Rd9VX7vVLL28ig=;
 b=ADKVRtj6JHK8zsw0jzeuF8eKQrZGcrT2a76Ens5Mu41IiZZEKivw/Bwxvi/froJdCI
 Xps8nQnqOn10MjviZvHcdWfhAtsPhuQlwqP+JfcK9BJrF3EEahiZmqwv3V/0wi6jBMKw
 e3vttAT370gB5yWmDg1evdRmqOnv7agBpjSeNmJbJ5EeECPN48NcKX0eugpIp9y/l/Hl
 KyC0GhQqMn5rYTF3Om1il5isX3AI5v/cgy8Y4oJbZ4iCajOKpQ8jCVJe9K9zOd8cMGRc
 HfyH6O2/TW4gURFbVoapc7Qd92wC0MrF5dkFIKWpJxGCbzbBVJwK+aaKOF7Lp5sVSw/5
 jsTg==
X-Gm-Message-State: AOJu0Yx0jBZYIH3hPoJRWPbUS+BVSp6ofOpewAkIiJg4Izd9m5p55pJi
 8Bg7uWk1Qoot2D9Z4dmYFLw/6sX2XhZZZPjKnSkyF5+qbUPuWEURAiiYuB0dollL6FOd1U5Od5r
 tbUkDUIVl4HtoYCg+Tq1MQ6x5lC5RGAwQx36PWN3huuh3EN/SwWsE+ey4Az+iekhVhHnGJ3xpgV
 uYtmacfCTjYXxtPmERSg5jM3QuoTC9TbcXQX8=
X-Received: by 2002:a0d:ea91:0:b0:608:7dd:3649 with SMTP id
 t139-20020a0dea91000000b0060807dd3649mr11962234ywe.14.1708570574195; 
 Wed, 21 Feb 2024 18:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnStJqE91XUdrseDpBriqKfqH4RgNpuNhOvnB4kmxxqEjKS5Q9anY4wMxL4GhpN6HgkFiy47PC1Hlcno+TYLk=
X-Received: by 2002:a0d:ea91:0:b0:608:7dd:3649 with SMTP id
 t139-20020a0dea91000000b0060807dd3649mr11962225ywe.14.1708570573939; Wed, 21
 Feb 2024 18:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20240221095130.52711-1-demeng@redhat.com>
 <CAPMcbCr9y89BiM+mTF3i2n6GfAA9Xnu3ovoS-KamLZFEiAhrSA@mail.gmail.com>
In-Reply-To: <CAPMcbCr9y89BiM+mTF3i2n6GfAA9Xnu3ovoS-KamLZFEiAhrSA@mail.gmail.com>
From: Dehan Meng <demeng@redhat.com>
Date: Thu, 22 Feb 2024 10:56:03 +0800
Message-ID: <CA+kPPJweQkm50+6q4uYx33kU8kc-u13TbkhqEO+CL3VHht18CQ@mail.gmail.com>
Subject: Re: [PATCH] qga-win: Add support of Windows Server 2025 in get-osinfo
 command
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000002237320611ef9639"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000002237320611ef9639
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Done. thanks.

On Wed, Feb 21, 2024 at 6:00=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

>
>
> On Wed, Feb 21, 2024 at 11:51=E2=80=AFAM Dehan Meng <demeng@redhat.com> w=
rote:
>
>> Add support of Windows Server 2025 in get-osinfo command
>>
>> Signed-off-by: Dehan Meng <demeng@redhat.com>
>> ---
>>  qga/commands-win32.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index 697c65507c..f3c7e604c9 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -2154,6 +2154,7 @@ static ga_win_10_0_t const
>> WIN_10_0_SERVER_VERSION_MATRIX[4] =3D {
>>
>
> You don't update the array size, there are out of range elements
>
>
>>      {14393, "Microsoft Windows Server 2016",    "2016"},
>>      {17763, "Microsoft Windows Server 2019",    "2019"},
>>      {20344, "Microsoft Windows Server 2022",    "2022"},
>> +    {26040, "MIcrosoft Windows Server 2025",    "2025"},
>>      {0, 0}
>>  };
>>
>> --
>> 2.35.1
>>
>>

--0000000000002237320611ef9639
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Done. thanks.=C2=A0<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 21, 2024 at 6:00=E2=80=
=AFPM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiu=
k@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 21, 2024 at 1=
1:51=E2=80=AFAM Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Add support of Windows Server 2025 in get-osin=
fo command<br>
<br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 697c65507c..f3c7e604c9 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2154,6 +2154,7 @@ static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MA=
TRIX[4] =3D {<br></blockquote><div><br></div><div>You don&#39;t update the =
array size, there are out of range elements<br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0{14393, &quot;Microsoft Windows Server 2016&quot;,=C2=
=A0 =C2=A0 &quot;2016&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{17763, &quot;Microsoft Windows Server 2019&quot;,=C2=
=A0 =C2=A0 &quot;2019&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{20344, &quot;Microsoft Windows Server 2022&quot;,=C2=
=A0 =C2=A0 &quot;2022&quot;},<br>
+=C2=A0 =C2=A0 {26040, &quot;MIcrosoft Windows Server 2025&quot;,=C2=A0 =C2=
=A0 &quot;2025&quot;},<br>
=C2=A0 =C2=A0 =C2=A0{0, 0}<br>
=C2=A0};<br>
<br>
-- <br>
2.35.1<br>
<br>
</blockquote></div></div>
</blockquote></div>

--0000000000002237320611ef9639--


