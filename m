Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91104CCFA00
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 22:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFge5-000276-8S; Sun, 02 Nov 2025 17:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vFge2-00026e-In
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:33:54 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vFge0-0006P9-BR
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 17:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762122813; x=1762727613; i=deller@gmx.de;
 bh=qk+v5MOUe5DEm7IExQNL49Iaih1MqwQawlhpB7GvTmY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j+5VOV05i+0oPbLNUz9XS4Vg3UIlzQWKt+Nba6RmXcrfIKyzsQLzniuJlethc+hk
 sQ/QxJkzUaqybHr6n0vM1jaY3J1hDYpQrdkpuotgVTGy41u0rFG9fHBeXWJ2hJkQL
 mDjgTLRjhW9ie5FGi32VwW4UeNLHF8ESaMvNRVFvUfgGJ+R5/OuhSJwvLlxQMq1wu
 3d8i4GJik4Py9vgqkNVr/waaklFjsBbW8bGNtl/F8JQSHi3kuK339jsRbc2dRWfq4
 uWqks3n8xwBYxvJHY4LRghwLHg1Vh2ZJg5/3YSfelsGyNHootiy9B09V7JC6C5NhB
 g+oNLFnlc66fE31WQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.170]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlf0K-1vx28F0FxS-00cavF; Sun, 02
 Nov 2025 23:33:33 +0100
Message-ID: <a96408bc-bb1f-4792-b3b0-b15ff86ef070@gmx.de>
Date: Sun, 2 Nov 2025 23:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hw/hppa: Enable LASI i82596 network on 715 machine
To: Guenter Roeck <linux@roeck-us.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk,
 Jason Wang <jasowang@redhat.com>, sarkarsoumyajyoti23@gmail.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251101125726.45912-1-soumyajyotisarkar23@gmail.com>
 <07200388-ae9b-4021-afb6-5fd93584d39a@roeck-us.net>
 <5b672b32-cc09-4e9e-8961-efe362991a87@gmx.de>
 <eed77eb0-175d-4853-81ad-4a5a7390f96c@roeck-us.net>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <eed77eb0-175d-4853-81ad-4a5a7390f96c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S6t3Zxb0likTBJ3fua1xCfST1dev1Aqvt2Bd7Wpw/IcnxwmO0G3
 9D2lwIJa0w51Jz8C6XjPgcTb3Vbq71+mtAfCojW7sS+cJlPPZE060vOyU2oUZCOo/UyDQkD
 yU+txYxHHKyEvAOUNpAa3Hls7EenGGJSieLF1K7v418jwtSzjMQd1r7lKw414ocs+MIDsPb
 HXFKwoe0UBtOmascOsKpA==
UI-OutboundReport: notjunk:1;M01:P0:OapPNemr5Lk=;qiLUpltRn2yjBEzr5FIFUsDfOqy
 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
 dqNUXyEs0PPY582/++p3HrpV80zDmB56yLtSoQ
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 11/2/25 23:27, Guenter Roeck wrote:
> On 11/2/25 14:11, Helge Deller wrote:
>> Hi Guenter,
>>
>> On 11/2/25 18:31, Guenter Roeck wrote:
>>> On Sat, Nov 01, 2025 at 06:27:25PM +0530, Soumyajyotii Ssarkar wrote:
>>>> From: RemZapCypher <soumyajyotisarkar23@gmail.com>
>>>>
>>>> Enable the i82596 network chip which is included in the LASI
>>>> multi I/O chip. Since LASI has different start addresses on
>>>> the various machines, always initialize the LASI components
>>>> by their offsets.
>>>>
>>>> As suggested by Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> Changes since v1:
>>>> Added proper Qemu device initialization for LASI
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>
>>> Signed-off-by: is missing. Other than that,
>>>
>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>
>> Thank you so much for testing the series!
>>
>>> Only on 715, though. The LASI Ethernet interface on B160L no longer
>>> instantiates for me after the SeaBIOS update to version 19.
>> Have you actually used LASI Ethernet with B160L, or just enabled it?
>=20
> I do basic testing - instantiate and get an IP address. That works
> (or, rather, used to work in 10.1) just as good as the 715 emulation,
> meaning it gets an IP address and then complains about
>=20
> Received frame too small, 60 vs. 64 bytes
> qemu-system-hppa: Slirp: Failed to send packet, ret: -1
>=20
> I fix this up locally with
>=20
> diff --git a/hw/net/i82596.c b/hw/net/i82596.c
> index c1ff3e6c56..26224645fc 100644
> --- a/hw/net/i82596.c
> +++ b/hw/net/i82596.c
> @@ -522,7 +522,8 @@ ssize_t i82596_receive(NetClientState *nc, const uin=
t8_t *buf, size_t sz)
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 /* Received frame smaller than configured "min=
 frame len"? */
> -=C2=A0=C2=A0=C2=A0 if (sz < s->config[10]) {
> +=C2=A0=C2=A0=C2=A0 /* Note: Add CRC to packet size */
> +=C2=A0=C2=A0=C2=A0 if (sz + 4 < s->config[10]) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Received frame=
 too small, %zu vs. %u bytes\n",
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sz, s->config[10]);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>=20
> With that, my basic LASI network interface test on B160L works with qemu=
 10.1.

Ok, but that means you are basically the only one using it, and
this just because you "fixed" the source code :-)
I assume it's OK for you to wait until we activate LASIC NIC on
B160L in a later version?
Until then I suggest you stay with the default & out-of-box working tulip =
card?

Helge

