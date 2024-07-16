Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FD6C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjBG-0005lc-1b; Tue, 16 Jul 2024 10:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sTjBD-0005YG-Gz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:29:23 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sTjBB-00008o-4S
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:29:23 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-8102bbc95d1so105212241.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1721140158; x=1721744958;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NokxzlWojGk6SIAlluI/GG6PeT3IT3aIYhtNcIm6PMc=;
 b=uRvFlyDMy8H+6W4c54b3liBd42HEVm6Up3klcUCQDUdpNDx/RShg2r5B69oyMfJp89
 Kn1/R8JN2mPqSAc8d52MfnPYbsNWTHwKtmzkxweg55fj3bLjZTvPhh3gmL/ohin4gl+y
 JPT6y4ESKXRFA9XBvuD/fSqwDUWQmzDxqNIAy/8HNIYUXb5/LX+zEw9+9cLYiHN0pQc2
 5dg8+uqS4TLEmsV+vyxc6sLGFsdq5MexphDJk9Ck8WNlQufdxQlsw3nSETFjZ+tVEnt+
 LASQfQ919re055NVlQtr1pd09r2G/dwLDzRhWp9NqFddOUQwdxVt3cISooBl870NqTor
 pTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721140158; x=1721744958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NokxzlWojGk6SIAlluI/GG6PeT3IT3aIYhtNcIm6PMc=;
 b=eq/bzDoZELMD+3BvXWiRnCpViGMTehoy7+iLARl3ItzSjS6G7taTgrlewriC3+iwSO
 e10NTR5XxINaxaI5XsniLY5YaVcVBSStzZamIVX4Oe3l3R3atHry7iw7vtB04jjqryoK
 5w8fU5AVTElenc1ZKvPMZMuxOmLbxP2NVaA+A4VcqlqOu/YTylcvczV60wHV3yPh58iJ
 DfFIdhVLkB/rjY9scFh3DfkkFMaxs0ZuCf6F+IkCH7hbPHK1DaNwUIyTcJx9vFUue7+F
 jmr15wER8jKLe2h3bsQPZwuhAuuOO9HNml685jiNqKztVKm8ITuxBgQvbw8lnfC3DyZG
 FhMw==
X-Gm-Message-State: AOJu0Yw9+LVmVcqRKOXuYrsG3lW+R1Pjgg0tqgElzwO/XS7cv9qBoCTa
 yybRbxfAINYxh+q8Haj9+JrtLeAfzoDnHKvbV2VgVYRBeY8xAKnv0aZftY74ESc8NIAuUJw9Box
 fVtqdzb8kF+r27UKePWbDyGJfYmcm0fMJqJuo
X-Google-Smtp-Source: AGHT+IHu+AIJ3uAnhVuZdWWqojXtvEcSHGXKfdKrQXa7UGJ7mDjJuyvoSObQ5PzGxbE76sJ0Gj5oqbeFMdF51xvoHYE=
X-Received: by 2002:a05:6122:8c1:b0:4f2:a973:8ae with SMTP id
 71dfb90a1353d-4f4d6f360a3mr1314077e0c.5.1721140158668; Tue, 16 Jul 2024
 07:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240715210705.32365-1-phil@philjordan.eu>
 <20240715210705.32365-17-phil@philjordan.eu>
 <28a35035-840a-4c70-aaba-4192f7cd8ef3@linaro.org>
In-Reply-To: <28a35035-840a-4c70-aaba-4192f7cd8ef3@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 16 Jul 2024 16:29:07 +0200
Message-ID: <CAAibmn1zEFWVt-K3LkucStVxL-jyj=EWThwwtewwyKbKodQ0Sw@mail.gmail.com>
Subject: Re: [PATCH 16/26] hw/display/apple-gfx: Asynchronous MMIO writes on
 x86-64
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de, 
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, akihiko.odaki@daynix.com, 
 lists@philjordan.eu
Content-Type: multipart/alternative; boundary="000000000000c4415a061d5e2b92"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92c;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92c.google.com
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

--000000000000c4415a061d5e2b92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jul 2024 at 23:26, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> Hi Phil,
>
> On 15/7/24 23:06, Phil Dennis-Jordan wrote:
> > This change ensures that the MMIO write calls into the PVG
> > framework are performed asynchronously on a background dispatch
> > queue. Without this, we rapidly run into re-entrant MMIO issues.
> >
> > This problem only seems to exist on x86-64 hosts. Conversely,
> > doing it async on arm64/vmapple causes other issues,
>
> Such as?
>

Sorry for being vague. I've just refreshed my memory by testing with async
MMIO writes on aarch64, and the guest never manages to initialise the
display at all. I've admittedly not attempted to debug through this in any
significant way, though with PVG being something of a black box I'm not
sure it's worth it. It works reliably on x86-64 with async writes, and on
aarch64 with sync writes.

I'll add comments to the #ifdefs for v2.

Thanks,
Phil

--000000000000c4415a061d5e2b92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 15 Jul 2024 at 23:26, Philipp=
e Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro=
.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi Phil,<br>
<br>
On 15/7/24 23:06, Phil Dennis-Jordan wrote:<br>
&gt; This change ensures that the MMIO write calls into the PVG<br>
&gt; framework are performed asynchronously on a background dispatch<br>
&gt; queue. Without this, we rapidly run into re-entrant MMIO issues.<br>
&gt; <br>
&gt; This problem only seems to exist on x86-64 hosts. Conversely,<br>
&gt; doing it async on arm64/vmapple causes other issues,<br>
<br>
Such as?<br></blockquote><div><br></div><div>Sorry for being vague. I&#39;v=
e just refreshed my memory by testing with async MMIO writes on aarch64, an=
d the guest never manages to initialise the display at all. I&#39;ve admitt=
edly not attempted to debug through this in any significant way, though wit=
h PVG being something of a black box I&#39;m not sure it&#39;s worth it. It=
 works reliably on x86-64 with async writes, and on aarch64 with sync write=
s.<br></div><div><br></div><div>I&#39;ll add comments to the #ifdefs for v2=
.<br></div><div><br></div><div>Thanks,</div><div>Phil</div><div><br></div><=
/div></div>

--000000000000c4415a061d5e2b92--

