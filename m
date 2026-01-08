Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549EBD1D467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrOT-0004aO-9Y; Thu, 08 Jan 2026 09:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdrOQ-0004UK-Ti
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:53:42 -0500
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdrON-0004mC-1l
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:53:40 -0500
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-11df4458a85so4725039c88.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767884014; x=1768488814; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9WukLj5oPC1UOqySO4IjN3CGVMJRRnobzH9yHdqM9ho=;
 b=MhESZizkbeWTfrf19tJd4uYJU+TbxopQ4KHO6P5qe4xeyR7MM8lZjkoNKd9a0xftKx
 KgveiqeBl7IFu5Lpdwhzzl4LtxLakqUGC4njBptSx5gYB4wxxuAsh6YXOxOEB2UzB0Re
 EWZqSD+S7MZ5+S1Dz5uvDLnOjh9x+Cn5YmCyOt7dDUoK7HQu8Dtxlfg0Wg+hW9JDLZL0
 T50pIiMQWpv1DH4bz/WsnWnChBRq96lOd8sMk9SkggPyzE1oj8wqWKcXg5irb8xq9Yy4
 qgXqfIEu4RW4mZO0OrumYaI74zXXiEafW4GBCvtPDRJvun30wf+LWl5w/ghiwJeLiBst
 1s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767884014; x=1768488814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WukLj5oPC1UOqySO4IjN3CGVMJRRnobzH9yHdqM9ho=;
 b=sfdIJjfX+ZkEGJOKQcu3tBIdkwynh67YvfoSPQz1BPDkIAH0zLMuuF0dH5EycAHyBx
 bNExaIp0sgslIY3e8vm4c87ahKxu02M406BtfgglMLpOyPDXtlvIzjW4a1b/iXvTn8jY
 vPTXyUhKdKlHQZkZF7AwlhsNNN0wC/mP0CMaW5yFTPOGtNG9/hklXTKPLeyzR6qYGAd6
 yU4Satd8XRHWWTsHE0Hd7APKzkqx+z5EgNFjc4ISwryT0QZZ34mQXPtx1a/BRKcqCBiY
 IyZsm+zvbytwu5o9An1IT+b7tuIlEPaoFBBy5kC+sjRIzE1qZd1QkgznAohAJEa2NuQK
 7xDA==
X-Gm-Message-State: AOJu0YwiTHzV5BzkWMgn745G9ewzhdLdU3HQz9LrprNnLfj8NzdycVFv
 glOjj6PZfy3oQwIqVduZ6oZf864DxEFugcCUWXb1FEspgZOLNzAP7QkJQURMi6KKLYpakgIfm5L
 K39Nnp5YGXb09/M80EKu+hT3n4JMyO9c=
X-Gm-Gg: AY/fxX6UjvkxNhZerbs9n3yfEXhU/TuA9qeS/oC7dECEXCeuYsxpzn3cE1QbaBKU+m5
 d6rk5Pt+7evygH/NWR4toABow1u3lCUrr33Y1x0dbbYUjN8DmO+aW7bqdP5SIyqz0sTDVScHLuH
 WNcCJRBXAvKAUjtJtEELBIokB7i1FM+ptZYZ/UFurTV/CimXp5A/kKxg3t+5OLBAI3YA9u2xJbP
 5p1ssE/BolS9K15WTu/srEPGqrCtUdFcRiKEidWMIemyLXwhPWVpRdTeBHrXt2vxR8k0ccLlsAg
 y5J2NmQxXbpjwiOak1OV3PMFh3KOUTBnghyf
X-Google-Smtp-Source: AGHT+IEwK6kmGZy57hz/2vuGShGNRO25XIv6D+9rgK4BuQZ6RbtUBflIJUcDVMG69jL2gxZD1ZEoR/faPhF9ZD44TUI=
X-Received: by 2002:a05:7022:e21:b0:119:e569:fba9 with SMTP id
 a92af1059eb24-121f8b40a97mr5771722c88.24.1767884014390; Thu, 08 Jan 2026
 06:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-2-richard.henderson@linaro.org>
 <aV9y9b2-XRvNOYTG@redhat.com>
 <4df07fa5-f12d-4df5-9b59-0a2fce44b236@linaro.org>
In-Reply-To: <4df07fa5-f12d-4df5-9b59-0a2fce44b236@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 8 Jan 2026 23:53:21 +0900
X-Gm-Features: AQt7F2p69J1zEDqD9dXHkNWFyWWt_b0oq1Exn7MCMXCG4dTBVPGnONJDJqM2aB4
Message-ID: <CAEDrbUbqV3Zev8sfYvW1uCBF-4ONVqPvJdCgNDepHTXu2LzFCQ@mail.gmail.com>
Subject: Re: [PATCH 01/50] gitlab: Remove 32-bit host testing
To: Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ae8f390647e192c5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x122f.google.com
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

--000000000000ae8f390647e192c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel and Richard,

Thank you for pinging me.

> On 1/8/26 20:03, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Jan 08, 2026 at 04:29:29PM +1100, Richard Henderson wrote:
> >> These deprecated builds will be disabled.
> >> Remove testing of armhf, i686, and wasm32.
> >
> > CC'ing the wasm maintainer.
> >
> > This patch is removing our only CI testing of wasm.  Is there any
> > 64-bit container image that can be used to test wasm instead ?
>
> Ah, right.  Yesterday I remembered that I should include this in the
cover letter, but
> then today when I actually posted it I forgot.
>
> There are two sets of wasm64 patches; the simple one uses TCI, just like
the existing
> wasm32 code:
>
>
https://lore.kernel.org/qemu-devel/cover.1754494089.git.ktokunaga.mail@gmai=
l.com/
>
> I attempted to incorporate these patches, but there were too many
conflicts.
>
> The complex wasm64 patch set includes a complete tcg backend:
>
>
https://lore.kernel.org/qemu-devel/cover.1756724464.git.ktokunaga.mail@gmai=
l.com/
>
> I really need to study that more before I'm willing to accept the core
tcg changes required.
>
> Anyway, I meant to cc Kohei about this, to see if he would revive the TCI
patch set in the
> short term.

I'm rebasing the wasm64 TCI patch series and will post it to the mailing
list
when it's ready.

Regards,
Kohei

--000000000000ae8f390647e192c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi Daniel and Richard,</=
div><br>Thank you for pinging me.<br><br>&gt; On 1/8/26 20:03, Daniel P. Be=
rrang=C3=A9 wrote:<br>&gt; &gt; On Thu, Jan 08, 2026 at 04:29:29PM +1100, R=
ichard Henderson wrote:<br>&gt; &gt;&gt; These deprecated builds will be di=
sabled.<br>&gt; &gt;&gt; Remove testing of armhf, i686, and wasm32.<br>&gt;=
 &gt;<br>&gt; &gt; CC&#39;ing the wasm maintainer.<br>&gt; &gt;<br>&gt; &gt=
; This patch is removing our only CI testing of wasm.=C2=A0 Is there any<br=
>&gt; &gt; 64-bit container image that can be used to test wasm instead ?<b=
r>&gt; <br>&gt; Ah, right.=C2=A0 Yesterday I remembered that I should inclu=
de this in the cover letter, but<br>&gt; then today when I actually posted =
it I forgot.<br>&gt; <br>&gt; There are two sets of wasm64 patches; the sim=
ple one uses TCI, just like the existing<br>&gt; wasm32 code:<br>&gt; <br>&=
gt; <a href=3D"https://lore.kernel.org/qemu-devel/cover.1754494089.git.ktok=
unaga.mail@gmail.com/">https://lore.kernel.org/qemu-devel/cover.1754494089.=
git.ktokunaga.mail@gmail.com/</a><br>&gt; <br>&gt; I attempted to incorpora=
te these patches, but there were too many conflicts.<br>&gt; <br>&gt; The c=
omplex wasm64 patch set includes a complete tcg backend:<br>&gt; <br>&gt; <=
a href=3D"https://lore.kernel.org/qemu-devel/cover.1756724464.git.ktokunaga=
.mail@gmail.com/">https://lore.kernel.org/qemu-devel/cover.1756724464.git.k=
tokunaga.mail@gmail.com/</a><br>&gt; <br>&gt; I really need to study that m=
ore before I&#39;m willing to accept the core tcg changes required.<br>&gt;=
 <br>&gt; Anyway, I meant to cc Kohei about this, to see if he would revive=
 the TCI patch set in the<br>&gt; short term.<br><br>I&#39;m rebasing the w=
asm64 TCI patch series and will post it to the mailing list<br>when it&#39;=
s ready.<br><br>Regards,<br>Kohei</div>
</div>

--000000000000ae8f390647e192c5--

