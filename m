Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CC1D116E8
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 12:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t52YX-0000XR-7I; Sun, 27 Oct 2024 08:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t52YV-0000XC-RF
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 08:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t52YS-0002Ye-HU
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 08:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730032773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WHJM4+NQSyCrL8TkXbA3E7BvV1iD+Wp9nDOq2om9v34=;
 b=IS2A5hi06RYL+wZbmC8/ktKGHq7QG5/DdTMqqtJCBbG2utS5JN8G6wxejmX56nS9b+7oK0
 uu+Xkc6m/jfrPM6VLHW4VooxRn+F/blvolxRf16IeMkbIf03smZ0vsst4Bxbpx0Sc4F3m3
 8VL5CscHIKYu1XqYLpFyRqPnhr3/TbI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-mU3fMdYyP5SQbdKFu7KQhw-1; Sun, 27 Oct 2024 08:39:27 -0400
X-MC-Unique: mU3fMdYyP5SQbdKFu7KQhw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431604a3b47so24931185e9.3
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 05:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730032764; x=1730637564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WHJM4+NQSyCrL8TkXbA3E7BvV1iD+Wp9nDOq2om9v34=;
 b=butu+gw70FZLtif//LGJeRstn3fE/DT80QT/hz3TmdGq2smqazSIxC4z8MUB2CEKuR
 mitcoUkaPkMrB/L5/uPRX15JGHU8UBlzlq5Cg9YqDlfoK6upbRhrEGJ6eyAsHB5Zim+j
 vcgAldvBjluzm9fOhlk37fnrbJHyM323RX8iS74u6+soKJDjCOuWbLfAWjmXfR2XBn+2
 1rn3fbqJvHWWSra+BT8kWzKNDdAb4KTqv4xDToeuZG9MpKku8q9W9t1gCoc8pGex4z5l
 EZYCsO1btzmuAMxaaBWJg8BgVU3ZbCeKsaLhdW9XRwhEesgPu94jQ45vfY1PWb2TMlR/
 vWaw==
X-Gm-Message-State: AOJu0Yy/ssRrksmk62O6Z3Z6J5MQkGDF0udn9yi3NB3PsVvkY0eqPUw1
 6OngK5Z2x571X1PFtBOTR3emYN9QmW2ozTUcFRB0Gr0TPu/3GKYLdtfZ33ISa/Y/yznsLTi1IAc
 JKvXvTdE7EOxRcE1vwpQz9VfpEAY3HL55waUYwVv8GxqSS8Pc/jWv8G2HBsFoorBATNPQ2j1erg
 H0ukZu3Dz8ggoOPad9y3gvQyW7WDXGdfelBs4+wg==
X-Received: by 2002:a05:600c:4fcb:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-4319ac6fb93mr45517895e9.5.1730032764438; 
 Sun, 27 Oct 2024 05:39:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoZJSzncr/meH4YgSevmipz1/weiwp7cUmJnAtT5ciZiUlP7jVYVawhXDxbdRSk3WgxJH4r+c/bafNdDZqbtM=
X-Received: by 2002:a05:600c:4fcb:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-4319ac6fb93mr45517745e9.5.1730032764078; Sun, 27 Oct 2024
 05:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <95b07b6b-0980-4a32-86fd-602985750104@tls.msk.ru>
 <CABgObfb2qZnH6CKp37pxr8Dq5x39ug=0ND8K4_STerXKxxd6Vw@mail.gmail.com>
 <e4ce3a76-80f8-486a-894f-fe006e97c577@tls.msk.ru>
 <a5644958-907d-4940-818d-40a9b55a8297@tls.msk.ru>
In-Reply-To: <a5644958-907d-4940-818d-40a9b55a8297@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 27 Oct 2024 13:39:10 +0100
Message-ID: <CABgObfbSO9Zzr8LDrr=ZZ53OAvvbEtgjWhB-mXEzKKfc9PM5cw@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc and
 bindgen
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000005a8716062574a4f9"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005a8716062574a4f9
Content-Type: text/plain; charset="UTF-8"

Il dom 27 ott 2024, 10:43 Michael Tokarev <mjt@tls.msk.ru> ha scritto:

> 27.10.2024 12:38, Michael Tokarev wrote:
> > 27.10.2024 11:00, Paolo Bonzini wrpte:
> >
> > [rustc-web]
> >
> >> Thanks for pointing it out! It is indeed better, however it does not
> >> support mipsel.
> >
> > mipsel?  do you mean mips64el?
>
> Ah. I see what you mean.
> https://buildd.debian.org/status/package.php?p=rustc-web&suite=bookworm
>
> FWIW, mipsel has been removed for the next debian, it isn't supported
> anymore in sid or testing (trixie).
>

Oh, then we need to deprecate it! But for now we're a bit stuck with it.

Paolo


> /mjt
>
>

--0000000000005a8716062574a4f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 27 ott 2024, 10:43 Michael Tokarev &lt;<a href=
=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; ha scritto:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">27.10.2024 12:38, Michael Tok=
arev wrote:<br>
&gt; 27.10.2024 11:00, Paolo Bonzini wrpte:<br>
&gt; <br>
&gt; [rustc-web]<br>
&gt; <br>
&gt;&gt; Thanks for pointing it out! It is indeed better, however it does n=
ot<br>
&gt;&gt; support mipsel.<br>
&gt; <br>
&gt; mipsel?=C2=A0 do you mean mips64el?<br>
<br>
Ah. I see what you mean.<br>
<a href=3D"https://buildd.debian.org/status/package.php?p=3Drustc-web&amp;s=
uite=3Dbookworm" rel=3D"noreferrer noreferrer" target=3D"_blank">https://bu=
ildd.debian.org/status/package.php?p=3Drustc-web&amp;suite=3Dbookworm</a><b=
r>
<br>
FWIW, mipsel has been removed for the next debian, it isn&#39;t supported<b=
r>
anymore in sid or testing (trixie).<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Oh, then we need to deprecate it! But fo=
r now we&#39;re a bit stuck with it.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
/mjt<br>
<br>
</blockquote></div></div></div>

--0000000000005a8716062574a4f9--


