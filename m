Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C16C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 18:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tniNc-00015g-R6; Thu, 27 Feb 2025 13:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1tniNH-00013n-Bb
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:12:50 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1tniND-0006pA-3N
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:12:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-390df942558so930745f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 10:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740679955; x=1741284755; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2MLgPcoWN1rjM+lw/xMIBwTa10ujDuMKXxMFFUlvkoE=;
 b=pNfQ9l5as9G0OmDmC3YRhbAmYbCsmQFtyxWL5DC0KZDhXlxp9FcIJDqRKQG14Ea2D1
 kaRb8MeknKKhyW61nYjR+hVKyykCQwD+xbYoOILxAM9T5U5NMtrlXc/krH4ZMxM4VRNi
 NB0I45nGjFoOGTYeWHMnSXAiW99lRo977N1MFxo6LP/TFJJm9538KJLBvzmX/8zIp4pr
 Mu2l5CGHdN6Kus2XBlKBOqPEbke0jKldOy87JCGGWTdEyKRoDIY93SNMU7Bz9CHBtDaL
 lXh1crpolpJZo+aYSi8pCgezjyaSROQ58Af4fS+9Kcw4JYY/OwDb2261rndQMlKG2i9x
 WtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740679955; x=1741284755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2MLgPcoWN1rjM+lw/xMIBwTa10ujDuMKXxMFFUlvkoE=;
 b=rK+9NMW7osXiJ+6AICJuxjU9thgwALFzfh/IDqg3GHpwXSGbHQiAmJPI8zF/7LsS0P
 DuSQwz3oxyPkAeqY6qMSrXcUM5Ci/8RpABXu2P+4hVxJR4rPoxOKBzmKyS9kHF+juND6
 1tNZpZPRRTE34+p/ITETwrJI6V+pYtDtSpH5JxdnxGFPabRbJfu7YtYIRPxHIDZrh7DO
 N04sphM8dqxPCEKIHyiYQfeFFhUXW+0oqdH0ZHSSqwOxmfOESfM+Nw6tBHwnC7XPgm2q
 KdwSsyd8zeJ6LudNcbWu/nTtuBwMZMCA4dVgP/xk2K8EE5Tmcy0T0F0Dci3x71N8gcaf
 RkcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCAabRrVFbJNGBdSdz2jMiCWm0FDbmBIGN6PCnN7mAVHRpVaOk8yR/WWhLNBHS+T0RuOExg3Tuod/a@nongnu.org
X-Gm-Message-State: AOJu0YyrhITPyJLxhI5LlCegKZe3VnTCXe3HAMUC8hfAk2Abp1HTWsmj
 etwfHdkL27yF0tYJqFreZoRdyKj9jFfbVJD5HzNceKqM0uPNzOUb0Knv/225y2YhYtv2FCy77dX
 V6PQvhnp4TBz8y3KaWpN6jBFscsfMNDlC0W6i
X-Gm-Gg: ASbGncvf0Nfnn60yE1sOa8qO5XQEk2Z0IE2dLu3hXWy4C41TfoTtb7yYDcCWdlX38ri
 XCHOuGp6q6a4CYQG52oCge52ZFD4urzXb2+lURvC+GJRYxAdNFxqPJOxKl2ax7L2HQtl5eZ9tvf
 ZVvbCcx7nBlXzOmhRFYFIj4Zw/8MMvvuVZbOWAow==
X-Google-Smtp-Source: AGHT+IERnLoesF6ieTS3o5U/33GNuKCHjx+JRBZujMZ1NbRYoINtE1qVTBUNEplR7A+zjb2uPG1lAmL7tTPrasPyScQ=
X-Received: by 2002:a5d:47cd:0:b0:38d:e481:c680 with SMTP id
 ffacd0b85a97d-390ec9bb569mr160835f8f.18.1740679955448; Thu, 27 Feb 2025
 10:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20250227154003.1646017-1-venture@google.com>
 <CAFEAcA_wR-M3+BhZY0MFjv3OfoyL2gvukduvKZ6ksKwUKmdB6Q@mail.gmail.com>
 <CAO=noty89OsH=vGmemL7eLcR2wV6n4XG9a2HfT7Uzo8EPRy4PQ@mail.gmail.com>
 <CAFEAcA-gyMTz-KpmamyXcKX9QOL=yYHDMPRF2Xji_uJbG02WpA@mail.gmail.com>
 <CAO=notwcXTU9v4c_Hz=Si=QLrM5HNymYEO0ry4Td30GYUZqBwg@mail.gmail.com>
In-Reply-To: <CAO=notwcXTU9v4c_Hz=Si=QLrM5HNymYEO0ry4Td30GYUZqBwg@mail.gmail.com>
From: Patrick Venture <venture@google.com>
Date: Thu, 27 Feb 2025 10:12:21 -0800
X-Gm-Features: AQ5f1JpSRxJEd2_mP2Yj6ogaXvr7U2RsJigm3QDaHwaF3Ll7AJu6RDsk-6BUC3s
Message-ID: <CAO=notxXT3m26=GxryTwJSqLQBfxrCCXV9ffdBGdYokxxnHz=A@mail.gmail.com>
Subject: Re: [PATCH] hw/net: npcm7xx_emc: fix alignment to eth_hdr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000069fe6f062f23a29e"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=venture@google.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--00000000000069fe6f062f23a29e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 8:08=E2=80=AFAM Patrick Venture <venture@google.com=
> wrote:

>
>
> On Thu, Feb 27, 2025 at 8:01=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org>
> wrote:
>
>> On Thu, 27 Feb 2025 at 15:55, Patrick Venture <venture@google.com> wrote=
:
>> >
>> >
>> >
>> > On Thu, Feb 27, 2025 at 7:52=E2=80=AFAM Peter Maydell <peter.maydell@l=
inaro.org>
>> wrote:
>> >>
>> >> On Thu, 27 Feb 2025 at 15:40, Patrick Venture <venture@google.com>
>> wrote:
>> >> >
>> >> > 'const struct eth_header', which requires 2 byte alignment
>> >> >
>> >> > Signed-off-by: Patrick Venture <venture@google.com>
>> >> > ---
>> >> >  hw/net/npcm7xx_emc.c | 7 ++++++-
>> >> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
>> >> > index e06f652629..11ed4a9e6a 100644
>> >> > --- a/hw/net/npcm7xx_emc.c
>> >> > +++ b/hw/net/npcm7xx_emc.c
>> >> > @@ -424,7 +424,12 @@ static bool emc_can_receive(NetClientState *nc=
)
>> >> >  static bool emc_receive_filter1(NPCM7xxEMCState *emc, const uint8_=
t
>> *buf,
>> >> >                                  size_t len, const char
>> **fail_reason)
>> >> >  {
>> >> > -    eth_pkt_types_e pkt_type =3D
>> get_eth_packet_type(PKT_GET_ETH_HDR(buf));
>> >> > +    struct eth_header eth_hdr =3D {};
>> >> > +    eth_pkt_types_e pkt_type;
>> >> > +
>> >> > +    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
>> >> > +           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
>> >> > +    pkt_type =3D get_eth_packet_type(&eth_hdr);
>> >>
>> >> Maybe better to mark struct eth_header as QEMU_PACKED?
>> >> Compare commit f8b94b4c5201 ("net: mark struct ip_header as
>> >> QEMU_PACKED"). The handling of these header structs in eth.h
>> >> is in general pretty suspect IMHO. We do the same
>> >> "get_eth_packet_type(PKT_GET_ETH_HDR(buf))" in other devices,
>> >> so this isn't just this device's bug.
>>
>> > Roger that. We saw this in the two NICs we happened to be testing that
>> day, and yeah, I grepped and just figured that those other NICs were doi=
ng
>> something with their buffer allocations that we didn't. I'll give
>> QEMU_PACKED  whirl.
>>
>> You might find you need to make some fixes to other
>> devices to get the QEMU_PACKED change to compile (do an
>> all-targets build to test that). For instance for the
>> ip_header change I had to first fix virtio-net.c in commit
>> 5814c0846793715. The kind of thing that will need fixing is
>> if there are places where code takes the address of the
>> h_proto field and puts it into a uint16_t* : the compiler
>> will complain about that. A quick grep suggests that the
>> rocker_of_dpa.c code might be doing something like this, but
>> hopefully that's it.
>>
>
Ok, so digging, and I see that vlanhdr is used similarly in the
rocker_of_dpa.c code, so, without trying to bit off the yak shave of fixing
all ethernet headers, but in reality ethernet packets are packed
structures, should we just make them all packed and bite that bullet?


>
> Thanks for the head's up.
>
>>
>> thanks
>> -- PMM
>>
>

--00000000000069fe6f062f23a29e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 27,=
 2025 at 8:08=E2=80=AFAM Patrick Venture &lt;<a href=3D"mailto:venture@goog=
le.com">venture@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb=
 27, 2025 at 8:01=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.mayd=
ell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 27 Feb 20=
25 at 15:55, Patrick Venture &lt;<a href=3D"mailto:venture@google.com" targ=
et=3D"_blank">venture@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Feb 27, 2025 at 7:52=E2=80=AFAM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Thu, 27 Feb 2025 at 15:40, Patrick Venture &lt;<a href=3D"mailt=
o:venture@google.com" target=3D"_blank">venture@google.com</a>&gt; wrote:<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &#39;const struct eth_header&#39;, which requires 2 byte alig=
nment<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@=
google.com" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 hw/net/npcm7xx_emc.c | 7 ++++++-<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c<br>
&gt;&gt; &gt; index e06f652629..11ed4a9e6a 100644<br>
&gt;&gt; &gt; --- a/hw/net/npcm7xx_emc.c<br>
&gt;&gt; &gt; +++ b/hw/net/npcm7xx_emc.c<br>
&gt;&gt; &gt; @@ -424,7 +424,12 @@ static bool emc_can_receive(NetClientSta=
te *nc)<br>
&gt;&gt; &gt;=C2=A0 static bool emc_receive_filter1(NPCM7xxEMCState *emc, c=
onst uint8_t *buf,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len, const =
char **fail_reason)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 eth_pkt_types_e pkt_type =3D get_eth_packet_ty=
pe(PKT_GET_ETH_HDR(buf));<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 struct eth_header eth_hdr =3D {};<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 eth_pkt_types_e pkt_type;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 memcpy(&amp;eth_hdr, PKT_GET_ETH_HDR(buf),<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sizeof(eth_hdr) &g=
t; len) ? len : sizeof(eth_hdr));<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 pkt_type =3D get_eth_packet_type(&amp;eth_hdr)=
;<br>
&gt;&gt;<br>
&gt;&gt; Maybe better to mark struct eth_header as QEMU_PACKED?<br>
&gt;&gt; Compare commit f8b94b4c5201 (&quot;net: mark struct ip_header as<b=
r>
&gt;&gt; QEMU_PACKED&quot;). The handling of these header structs in eth.h<=
br>
&gt;&gt; is in general pretty suspect IMHO. We do the same<br>
&gt;&gt; &quot;get_eth_packet_type(PKT_GET_ETH_HDR(buf))&quot; in other dev=
ices,<br>
&gt;&gt; so this isn&#39;t just this device&#39;s bug.<br>
<br>
&gt; Roger that. We saw this in the two NICs we happened to be testing that=
 day, and yeah, I grepped and just figured that those other NICs were doing=
 something with their buffer allocations that we didn&#39;t. I&#39;ll give =
QEMU_PACKED=C2=A0 whirl.<br>
<br>
You might find you need to make some fixes to other<br>
devices to get the QEMU_PACKED change to compile (do an<br>
all-targets build to test that). For instance for the<br>
ip_header change I had to first fix virtio-net.c in commit<br>
5814c0846793715. The kind of thing that will need fixing is<br>
if there are places where code takes the address of the<br>
h_proto field and puts it into a uint16_t* : the compiler<br>
will complain about that. A quick grep suggests that the<br>
rocker_of_dpa.c code might be doing something like this, but<br>
hopefully that&#39;s it.<br></blockquote></div></div></blockquote><div><br>=
</div><div>Ok, so digging, and I see that vlanhdr is used similarly in the =
rocker_of_dpa.c code, so, without trying to bit off the yak shave of fixing=
 all ethernet headers, but in reality ethernet packets are packed structure=
s, should we just make them all packed and bite that bullet?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"></blockquote><div><br></div><div>Thanks for the head&#39;s up.=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>
</blockquote></div></div>

--00000000000069fe6f062f23a29e--

