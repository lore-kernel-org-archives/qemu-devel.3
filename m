Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9F5C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2ai-0003cj-TZ; Wed, 17 Jul 2024 07:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU2aZ-0002sq-IO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:12:51 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU2aJ-00035w-TB
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:12:51 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4f2c8e99c0fso519754e0c.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1721214753; x=1721819553;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eUiCpw6FOC3LTxm8Tr0fPAgbCAVN5AsSVaku3idwslA=;
 b=UHWTvj3vO4+LCZIM7cjk+YsEr8QDGc4yor1I9TGsFkOJFle4+7preDt7TWSJndXftW
 FOs7hsSr4CD9L+7Sk2leBNKZ5rlTvYasBxFI7wkP2KptrD7DX/4u9c6Wb3NA7lxPvfV+
 oeCeUCdJpcHFBsflFmWhVCARYoutvpq7PjBm39xdpCEyKMfYr1z3WfJg23I84zA/uLOD
 M+PIWUFmoZXkbF/WvjFVJ8HsaA1/5typEPxreB8eN638IcUOHp9FVDNp5JPf1O5F/PSW
 NdEdx+MsGPMKKrRAFymHPbSlQNfsHnGwhcgFdzEAc9RuoB2UGXn9a7Xlf77/Bp+zq/3H
 rvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721214753; x=1721819553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eUiCpw6FOC3LTxm8Tr0fPAgbCAVN5AsSVaku3idwslA=;
 b=HGn+h2A6aorNEP4EVsr8FG8tbqrALRra9WlcS/rIewctxrv6oAlJ11/+znHatXFSsr
 hWUmcqIzpZuOnxMfTHWQtXPCEQKg2YPzfpjVy76xdMVpUNrrZDwmDBu6yksTE04GOrbh
 IO+9JUZiTrYuTTzEv7JpVGPNX1IiLILgCwOEMN6JUnOZNdcK0srA9SEUEBMqq6tVbv1W
 lV4YdCdZuP88q1CBey6XB17TLdoW96y5Im2cCYVXo9dXBcvcL4bksoIQd9HeYxqEbKm5
 D63DTcta56bQ48YmiPsGCGgpCxraQ+nATf5jJ4GMH0xsuIwVLn3uKEeB2hwCwls+KII3
 aLgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXuakm6652YtZqK4ivhbJXfhujHtIeB6UWhlpsKHRuoFtM1HeGeJpQEME70YRfHodK8yog5O27Yxl7+2BfdUOSiKTPCks=
X-Gm-Message-State: AOJu0Yxkm9Ma/PlSeEyheTfFg+aRMUTgVoTaYflKdDzgVZSykcnkcPp0
 Zv6c1EXW1+F2ZogkJjcVlpemK0wQzGWMIKd0sgtvmBh19NL5DswEMUjbGOXMiaofLoSNbtCIUMe
 JBIsuGeEMFt8OFZv1y9TVDMz1ZTlhaVrNMogn
X-Google-Smtp-Source: AGHT+IHX7gOBsZW72JWEVYUQpSouB2UXmlgjyiu4UTm0wPc9KFKkmdJ9FM1OPEbcZMLkmUkpXk26J49XMMzY7TUuSU0=
X-Received: by 2002:a05:6122:912:b0:4ef:5e6b:6ccc with SMTP id
 71dfb90a1353d-4f4df6da32dmr1809663e0c.7.1721214752597; Wed, 17 Jul 2024
 04:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240715210705.32365-1-phil@philjordan.eu>
 <eca02ec3-e2f2-4994-baf5-b86908fa0418@daynix.com>
 <a7087230-9fc6-4ab4-b35c-d3df032d16df@linaro.org>
 <6c65537d-ee67-4e0f-9f76-3da2b2ef8c71@daynix.com>
In-Reply-To: <6c65537d-ee67-4e0f-9f76-3da2b2ef8c71@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 17 Jul 2024 13:12:22 +0200
Message-ID: <CAAibmn2kPFxXH8sdTW8_-Z4_ZDQ6FvJ_An=J=mLXFnP2HZW2iQ@mail.gmail.com>
Subject: Re: hw/display/apple-gfx
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de, graf@amazon.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com, 
 peter.maydell@linaro.org, lists@philjordan.eu
Content-Type: multipart/alternative; boundary="000000000000e94c9a061d6f898f"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a33;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000e94c9a061d6f898f
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 08:48, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> The cover letter says:
>
>  > 04-13: These patches address issues identified during code review in
>  > the original e-mail threads as well as my own review.
>
> So these patches are certainly to be squashed. There are other patches
> titled "fixes" or "refactoring", which should also be squashed. I expect
> squashing them will reduce the number of patches (and code to review)
> drastically.
>

I've just resubmitted the patch set after squashing most of the commits
into the original one. (and rebasing on latest upstream) Squashing is easy,
pulling the individual changes back out is hard, so I figured I'd rather
send it as too many patches first time around in case anyone wanted to see
the individual changes I made.

Thanks for taking a look!

--000000000000e94c9a061d6f898f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Tue, 16 Jul 2024 at 08:48, Akihiko Odaki &lt;<a href=3D"mailt=
o:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
The cover letter says:<br>
<br>
=C2=A0&gt; 04-13: These patches address issues identified during code revie=
w in<br>
=C2=A0&gt; the original e-mail threads as well as my own review.<br>
<br>
So these patches are certainly to be squashed. There are other patches <br>
titled &quot;fixes&quot; or &quot;refactoring&quot;, which should also be s=
quashed. I expect <br>
squashing them will reduce the number of patches (and code to review) <br>
drastically.<br></blockquote><div><br></div><div>I&#39;ve just resubmitted =
the patch set after squashing most of the commits into the original one. (a=
nd rebasing on latest upstream) Squashing is easy, pulling the individual c=
hanges back out is hard, so I figured I&#39;d rather send it as too many pa=
tches first time around in case anyone wanted to see the individual changes=
 I made.</div><div><br></div><div>Thanks for taking a look!<br></div></div>=
</div>

--000000000000e94c9a061d6f898f--

