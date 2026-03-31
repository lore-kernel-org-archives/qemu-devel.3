Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2C910F92E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7cP9-0002tg-Ao; Tue, 31 Mar 2026 12:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w7cP3-0002su-Td
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:57:21 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w7cP2-00022q-6D
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1774976238; x=1775581038; i=deller@gmx.de;
 bh=X8m9A+mz0w2MrtKa4gcrX0Jg2+gKJeMDFzOEzs/w4Ro=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lJbiKna0N+Bun9CdUATdtfLrRyQO0HIKFfvTB3h8nTGMlSSbZwi7pqrO848E0jLY
 3c/1+giO8xzKwwaLillrLppSAucNtimDHlnxvfEo6s1+vzYZsFD2to6rDeUHqCSn1
 8QrfQuJuaISHL2ksWjZXDmwMAAkAVnRTw6JOm/boJQaNWVxZPm5CyXUBdhgExb6CF
 atVvyMGA3XJlxyRcY+6QRJXyplBfoHoai4kvXPC+U/tew4ror/svS87/CgG0l/+rd
 X7uZlcYxKy+vMK4d4O2QgMoNoFGtDb922353oZoRvdgD+XjjQBVwVfZxHBF4WybS4
 F2FFhM6cEfLEBhs1rQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNY8-1vYHaI1R0S-00fjHV; Tue, 31
 Mar 2026 18:57:18 +0200
Message-ID: <feff0860-0dc2-4a5b-983d-e3e98e7f9b02@gmx.de>
Date: Tue, 31 Mar 2026 18:57:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] hw/pci-host/astro: Add comment about Astro version
 numbers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-9-deller@kernel.org>
 <a0b4d43e-6798-49c1-9699-a25d260ccebe@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <a0b4d43e-6798-49c1-9699-a25d260ccebe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TCsUkN6Wqi0MTFEy4c1RbOPPAZXoeKzSUZwtdnmRBF0+RCfK5sB
 N4d0JoXIal1d4Bc4ooZCR4Ewbx3NVdNn5BdWgSukMzoHBwVVKcoOodbCcP/l6tKkP8cge36
 TkKsItQxo9fZkUXniFOQoT9tYF8wm7Lokh1QaTFx+ykZx7d58wqsa3K3YBGsXCbR9u519Yg
 uHCcQVkZkJcOsvfVrmrAA==
UI-OutboundReport: notjunk:1;M01:P0:lG0m5YbtfBk=;+H8l8YkPq6DsJKqrF1WtMX6RuuP
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/30/26 23:54, Philippe Mathieu-Daud=C3=A9 wrote:
> On 30/3/26 23:18, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 hw/pci-host/astro.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
>> index 8c61c696bd..776267e150 100644
>> --- a/hw/pci-host/astro.c
>> +++ b/hw/pci-host/astro.c
>> @@ -738,7 +738,7 @@ static MemTxResult astro_chip_read_with_attrs(void =
*opaque, hwaddr addr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch ((addr >> 3) << 3) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* R2I registers */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x0000:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* ID */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D (0x01 << 3) | 0x01U=
LL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D (0x01 << 3) | 0x01U=
LL; /* 0=3DAstro 1.0, 9=3DAstro 2.1, 2=3DAstro 3.0 */
>=20
> Using enum:
>=20
> enum { ID_ASTRO_1_0 =3D 0, ID_ASTRO_2_1 =3D 9, ID_ASTRO_3_0 =3D 2 };
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =
=3D ID_ASTRO_2_1;

Good idea.
I've fixed it up and queued this patch for post qemu-v11.

Thanks!
Helge


>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x0008:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* IOC_CTRL */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D s->ioc_c=
trl;
>=20


