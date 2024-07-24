Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDB5C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 10:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWZCK-0001h6-80; Wed, 24 Jul 2024 06:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sWZCI-0001ey-DC; Wed, 24 Jul 2024 06:26:14 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sWZCG-0006hI-Sx; Wed, 24 Jul 2024 06:26:14 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-44f666d9607so33732041cf.1; 
 Wed, 24 Jul 2024 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721816771; x=1722421571; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=540EeNV4R+zrfhS5zWQDqQkqFjTDrHCu4bGFDWxQunU=;
 b=HhkI0UJEHsLcCIgySbBpYXDDUCZ9reKggQIfaDG/JcNgF9wrFBuuXvcMIimKOKblxK
 OGAOGMOWrXwvgHNVT7xEMX2tWnZb2ALETHKvyv6ivnQ0SI03cF1J949iG97J854bbz8e
 gHe+QpYdtNx5bXHb9QjNo57GMcZL6OiFg9g23jWGpdhgyZ4BlJjAvJFBs9dWICJMVflz
 z+MxTl4MVRnZF7h0W3Vs0XbiPDPg4CPg7THOXpWiuNCqRgecT3dhNE32zCbi9gusYbN3
 H1qHtJl7Kzpm2fEmVWJpnw849HqXh5p4N9R8FuQvUU0+C7gx/nqx3+K7PUTKOmJmecGb
 qcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721816771; x=1722421571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=540EeNV4R+zrfhS5zWQDqQkqFjTDrHCu4bGFDWxQunU=;
 b=LmtfsGY3/EgKNUt4HjgOfwbVcAH5sUUEuSB1R5LH+uvrd4Cu/CUFPTsHi+ef1vmaUg
 VKGi011bw9PHy6u/2qToM7AViTCplCI6wvrFXLm3hyIXY/7yUKHUs06Z7IrylIHtvV22
 j4K6cSWjfL2fB87rZfopFD9qzSzRbTNoj0Dxv3bj+XkHr3gaxFlfTeVV5lMSHj9Y7aOj
 piYOVm3F/a66MreLdR9oAw91IUL5JIZU8hQpNA18ldgdLeQ40HNfGJJC/dsk+rIOkJWT
 kvz23LfVBb7i/gsXAP7IBqKj96tJQUKN3YoJLOGevbKZcf2y8ZvtbyjU5RsztSDLHktI
 IG7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvQ7SE4UKbhQaVquWFy9N6KwGrjJBGptQ3E7n8D8TwgTmnF4xboJs5LJjaJ5V31EDIzS+oRnWNGeRBqS5080SflN1BYCUDa1Td/TWkx28AnXCWxMnucSjQIvd0wis=
X-Gm-Message-State: AOJu0YwFAUpd9GcYPfDziZeLF1YquZPRY++JfWLw67fkN28TB6xqu9u1
 RvS5YphSuQPNToUUSsvLeYmKl+tvvr1TeOu2bOt5oedksDJuzWiXf8B1PFjq199TXV26Jcp0P8w
 hLCdIefJjjOodQRLhVaVQddY3cBQ=
X-Google-Smtp-Source: AGHT+IF4UBNPLMU/Pz+s3mMuQZ9OdNoiF2NtS9mj0dE7AarRPp5so/CY3De8Hp9sJKW4CmaBmnouBMbOctYIjolxoqU=
X-Received: by 2002:ac8:5e4a:0:b0:447:f863:52a5 with SMTP id
 d75a77b69052e-44fd41223c1mr31917361cf.37.1721816771148; Wed, 24 Jul 2024
 03:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <ME3P282MB25488BE7C39BF0C35CD0DA5D8CA82@ME3P282MB2548.AUSP282.PROD.OUTLOOK.COM>
 <9dfc4a6a-da91-4185-a800-40c80dd9a0f6@tls.msk.ru>
In-Reply-To: <9dfc4a6a-da91-4185-a800-40c80dd9a0f6@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 Jul 2024 14:25:59 +0400
Message-ID: <CAJ+F1CKm891c5-QLPqVYzzykufpbFvMCxPZKfkuYHh1trztQ8w@mail.gmail.com>
Subject: Re: [PATCH v2] chardev/char-win-stdio.c: restore old console mode
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: songziming <s.ziming@hotmail.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000034465061dfbb564"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000034465061dfbb564
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 24, 2024 at 8:48=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> 22.07.2024 12:52, songziming wrote:
> > If I use `-serial stdio` on Windows, after QEMU exits, the terminal
> > could not handle arrow keys and tab any more. Because stdio backend
> > on Windows sets console mode to virtual terminal input when starts,
> > but does not restore the old mode when finalize.
> >
> > This small patch saves the old console mode and set it back.
>
> Is this a stable@ material?
>

It should be safe, but I don't think it deserves a stable backport: it
always had that behaviour before.

--=20
Marc-Andr=C3=A9 Lureau

--000000000000034465061dfbb564
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Jul 24, 2024 at 8:48=E2=80=AFAM Micha=
el Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">22.07.2024 1=
2:52, songziming wrote:<br>
&gt; If I use `-serial stdio` on Windows, after QEMU exits, the terminal<br=
>
&gt; could not handle arrow keys and tab any more. Because stdio backend<br=
>
&gt; on Windows sets console mode to virtual terminal input when starts,<br=
>
&gt; but does not restore the old mode when finalize.<br>
&gt; <br>
&gt; This small patch saves the old console mode and set it back.<br>
<br>
Is this a stable@ material?<br clear=3D"all"></blockquote><div><br></div><d=
iv>It should be safe, but I don&#39;t think it deserves a stable backport: =
it always had that behaviour before. <br></div></div><br><span class=3D"gma=
il_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signatur=
e">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000034465061dfbb564--

