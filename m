Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B0FE8537A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 15:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8gso-0003S7-3C; Fri, 03 Apr 2026 11:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1w8gsm-0003RY-2i; Fri, 03 Apr 2026 11:56:28 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1w8gsk-0001Aq-47; Fri, 03 Apr 2026 11:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775231779; x=1775836579; i=deller@gmx.de;
 bh=WpC/Z4Y4FRpuMs2aq5qNNOP9kzm5yndKpy/ofQXXHy4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=duTBc+hCGdqXeOAjuS0earJgD2A6dfB9t2tbnXsszADppysDygCZraQa9+jQQ7Hi
 XDdtGI8trQwU52wFXHcdqIUYNYRR8ELCZX4HHVBEUxMaRLq+sU8XyUHbJz3mB7CTS
 B00SGSPiEmA8Xb3N+kUp3Q5lhploSDSvoyF9s7UlHvak6ivqPy8YyGuz5EcJtpqPN
 w3vg0lAFaZkWHjHbHV20eywnoTuIaDyay7K90Pu9LBLe3EzS3L3q5d5ZuKzlDPtYH
 o3nC+h8OMJ9Dla+QE9XTiKYg3jUIUFwmNn/T/5/WMzL5eZTBkgpOZjC5SwpQqTomH
 U8YA5G0n7gTRYs8Htg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNY8-1vZM831Ex6-00fjCs; Fri, 03
 Apr 2026 17:56:19 +0200
Message-ID: <5beced2f-f241-45c6-941d-a5da6ad2c975@gmx.de>
Date: Fri, 3 Apr 2026 17:56:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 0/6] allow building tools and qemu-guest-agent on
 32bit hosts
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Helge Deller <deller@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-block <qemu-block@nongnu.org>
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <695a7724-1440-4956-bcd9-fd2e3283464d@linaro.org>
 <de60e96a-9c43-4b43-916b-9bf34b19058c@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <de60e96a-9c43-4b43-916b-9bf34b19058c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vsBvtG91kbAzAybLtPvtb9n6v/DXtvPXsbrqudL9ZpRGbhjqqUe
 qcc4Vw6DU6mnPy2Ba+jlsvCWF62ZvwDF7ie+VVmn2SBCEISQWloMADcfbQ/UvS0GWelzuND
 azXRQfSYh5t3G7Aa06IXxxkfqnOP3sn+A0vosZLAISAWUtuUR6a+kMGR1MMwMLDQVeNjaG0
 ysbcyyaEnm4uyLvF+iqaA==
UI-OutboundReport: notjunk:1;M01:P0:criyA6Px4rs=;ZzR/Ci9C3AljVjt+jl+pSqwQdgY
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/3/26 17:40, Michael Tokarev wrote:
> On 03.04.2026 18:33, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 3/4/26 12:43, Michael Tokarev wrote:
>>> This is a patchset which makes qemu-guest-agent, qemu-img & qemu-nbd
>>> buildable on 32bit hosts again.=C2=A0 The patches are simple enough to=
 be
>>> picked up for 11.0.=C2=A0 The one from Helge is marked as RFC still, b=
ut
>>> I'd love for it to be accepted the way it is.
>>
>> v11.0.0-rc2 is already out, these look (in particular the atomic patch)
>> too late to me.
>=20
> I don't see a problem with applying atomics change to 11.0.=C2=A0 It is =
just
> removing asserts because they're really useless - on 64bit platforms we
> do have all necessary atomics.

Correct.
Like Michael, I suggest we include this patch series into v11 as well.
 =20
> If that sounds too risky, we can add a meson check for atomics if a
> system or user build is requested.

Isn't that what the second hunk in my patch already does?

>> Is it doable distributions use v9.2 for qemu-guest-agent / qemu-img /
>> qemu-nbd on 32-bit hosts?
>
> Guess you mean 10.2.=C2=A0 Nope, it's easier than that: if this patchset
> isn't accepted upstream for 11.0, I'll include it in debian.=C2=A0 See
> https://salsa.debian.org/qemu-team/qemu/-/tree/experimental/debian/patch=
es/32bit?ref_type=3Dheads --
> this is what I uploaded a few minutes ago.=C2=A0 Hopefully it builds on =
all
> 32bit platforms too.
>=20
> Using 10.2 is.. not easy.

Right.

Helge

