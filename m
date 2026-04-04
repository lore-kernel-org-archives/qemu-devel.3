Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616CEE88D80
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 11:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8zWL-0006Xt-V0; Sat, 04 Apr 2026 07:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w8zWH-0006WD-1e
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 07:50:29 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w8zWF-0003Jt-7m
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 07:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775303419; x=1775908219; i=deller@gmx.de;
 bh=/7ICdp6bKrahsTdG1We4dYa2MXXFE6gJCHE8sAgltHk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qLy0To70v5vN/kgFj4+ieOD3eeTxY6nz0bIEvPP+Z4awrXyEbMZqgoTNDjlYtWbL
 zH7do/GPr0A10/xmZcUD4eSGM5dokDibn/xh5f22HCf8VSyO0cMchrJJLVJPC89B3
 qYUiylQ2Svg249lamn0lEitQq3hx/sl0g/ldkM6w2VOXFoPAxhxxF1k9zOUNhBMZ4
 Or5ldrauBFz7QbLIv+BKgHiEC1+uKtPCRhWrINd+yZhB9tF4c9S73ybheEFgZMD5e
 bRCWAzdGrUzyJMJRcAEG1M+S2TuOHJd6jFGpONQMMxO0MArVuDs04V+OSAGtd2MxW
 12xTmmHHR2MSCbHtAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mwwdf-1vGaNE1VMJ-00uGJi; Sat, 04
 Apr 2026 13:50:19 +0200
Message-ID: <5ab94e34-1f76-4fe9-8942-2b24823d7eba@gmx.de>
Date: Sat, 4 Apr 2026 13:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 6/6] RFC: Allow building qemu tools on 32-bit
 hosts
To: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <20260403104327.1163942-7-mjt@tls.msk.ru>
 <eb9b80b4-78a9-4a0e-be63-aecfa8b426c5@linaro.org>
 <64e92c21-86b1-4828-b9b1-a7372986288e@redhat.com>
 <0b5eb7b7-7b99-4170-9553-fa92c187b9a3@tls.msk.ru>
 <CABgObfYPjpQxHXOf-fQ6ESGP3+G8giEUrn2kTC+DNh5gFz1dbQ@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CABgObfYPjpQxHXOf-fQ6ESGP3+G8giEUrn2kTC+DNh5gFz1dbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0CpFZA33OvYTkxzMo1YFxtAACAHyXeiAcHs9rSgSytpUlAAioy+
 mtGlibpCtw8JjOk+Wcb43FfcAQD0xVzHSz2YEFdvf8l1wXEMis/UAEsPYxCb4StYJKzF7WU
 YWahH5QLocA0Q/gSPkp9KuhSXCW4RxA1eqbu/VVbKuW1de8+AbhWrVQKPuVe1/MCNnDknId
 yMN8RynVz6XVrUpLePoHw==
UI-OutboundReport: notjunk:1;M01:P0:Gj3h0AXCPkI=;Kb46uOt9Pd/kgAsiZb7tXUpoceV
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Paolo,

On 4/4/26 13:03, Paolo Bonzini wrote:
> Il sab 4 apr 2026, 11:51 Michael Tokarev <mjt@tls.msk.ru <mailto:mjt@tls=
.msk.ru>> ha scritto:
>=20
>     On 04.04.2026 09:38, Paolo Bonzini wrote:
>      > On 4/4/26 01:49, Richard Henderson wrote:
>=20
>      >> Since the goal is tools, which do not have to interact atomicall=
y with
>      >> guest emulation, we can fall back to libatomic.=C2=A0 But that r=
equires
>      >> that we make the meson.build changes to actually link with libat=
omic.
>      > I think we should just do the guest agent, and limit tools to 64-=
bit hosts.
>=20
>     What's the prob with the tools on 32bit anyway?
>=20
>     BTW, tools doesn't even use atomics, while qga does :)
>=20
>=20
> They do, and in fact Stat64 was removed as part of dropping 32-bit suppo=
rt.

Please note that debian (and probably other distributions still supporting=
 32-bit)
enabled 64-bit file offsets, 64-bit time stamps and many other 64-bit flag=
s by default,
so there are actually no 32-bit limits/issues left on all 32-bit platforms
beside i386/i686.
 =20
> Tools share all the storage code with system emulation, which is way
> more complex than qga and would be mostly untested for 32-bit hosts.

I think nobody expects that the qemu team should officially test and
support 32-bit hosts. Limiting official support to 64-bit is OK.

The ask is simply to not actively *prevent* from being able to build and r=
un
on 32-bit hosts (or other unsupported architectures like m68k, powerpc, al=
pha, ...).

Helge

