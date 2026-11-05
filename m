Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9664E606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=KxqkiNyZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOs0N-0004Mg-PM; Thu, 05 Nov 2026 02:35:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xOs0M-0004MS-6R
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:35:26 -0500
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xOs0J-0005Qx-0I
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:35:25 -0500
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4jKv3N3Jmzz5vtd;
 Thu,  5 Nov 2026 07:25:19 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu,  5 Nov 2026 07:25:19 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.182])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jKv3M52Kqz1xnN; Thu,  5 Nov 2026 07:25:19 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 29DAD1B43BFE;
 Thu,  5 Nov 2026 07:25:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0066b4579b2-366f-4208-9452-5b2cd7bbaa26,
 55F4AE82A352CC4A4912F42944C0BD1B07566F15) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f8228c8b-a642-4364-b465-85650b4b8c92@kaod.org>
Date: Thu, 5 Nov 2026 08:25:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] Aspeed: TMP421 and TMP1075 sensors, and the
 Clemente BMC machine
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 3413447046789966893
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFfOSpRP9Yj3PBtl7iqLR8XVjQhlK4Uaf5vSb9TFjXgntGtQe8ckPj+186Of0wB2PTIRrP7i5xDbUIhSmbXU8eQCIMkVAjhlY4qDuf4HX+mHb+O0SF249tHstPNXs3IgowC+/ohEd4P3crB54+2nRnBGH7XzDR2IAtz3CnqP/uWNv/hgsRgrA5G3wueIHQt2pMeMT0iwrtk2INJ5Ee5X8ynOx9LM3bhk8Z02dwlslcKfc97TQBOLUhGWcO4yQoajas71fQHlbbWHaFdB+uRi8tAvloiNOUtjKlbGWhI3F1uc0Ke8XDHKMVY3/GN09OOMb9uTV3Cf0LBR0SvG9VASfQ9TMSEVdxjnz9FtREf1Qz2k/yd1ZPL4O4+urAEdqOvE/3Bohk5COKDrPHuy5zjBwkp4VuZKiE7mcztqivWLPtOiTXuM9cZ/h8kMMdEry0TPo9vw+l8FzgSL+zjFuzjXqUbmUQtjcQhBth+Cz181x/GDb78oGNoYNqF9z+it2+lXFYCcmuPp1Ocwqm8ZuaxjQY8991x32n38VSzqlPrqJ0Cp/W3HUaLVTWDbB3rkvaH95iBAPU570r0uG5cJHGkUlb193Gh7hEV3Fd9n/rgbOGhlevHTBsvS6PsWpbDTiPsPxWcFfQRZX0ozQp7ucUz/YJ51UMqltG/DcMtw4driCGtBw
DKIM-Signature: a=rsa-sha256; bh=3RJoKgvYpwy06A+So+qhJRVsTMT0N4u1ilUddUafVSg=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793863522; v=1;
 b=KxqkiNyZjTEaiSEP97CDuFQYQ4rnSEYc6sPnMaFM7PZFHKcwf5yl+UHZBjER6ig587SM1j2S
 Li4W4KhGiM+odVgUbhRtJshLpw0fQGMcu79VkBcrQCIBWi1c2kDlL7qplVnjOa1SFCi1T1hXgHd
 6pjQbajVg0UjcVpWRgi25AgD3yxVaQwfsUHgZ7n+bqc2PsDakbHnBrcLDRPf92S+10CocJXKaOl
 mZ5nMoeytqV/vYl0q81LR0FALCBRdam/dp0DK6ZAcwV/WBHnQQy0N8PXPQkVMmpYs6fF+h7QBJ6
 nUTPL9Nr7OW/DpcO/x/Wn2137mZdMd1Qa9tAiAL6O4iAQ==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/15/26 13:57, Emmanuel Blot wrote:
> Add the clemente-bmc machine and the temperature sensors it needs.
> 
> The TMP421 variants are now described by a class descriptor instead
> of a lookup table. Channel enablement, register write masks, the
> one-shot trigger and the per-channel N-factor registers are modelled,
> reset follows Resettable API, and the variant type names move to a
> header so boards stop open-coding the strings.
> 
> The TMP1075 is a TMP105 with a 16-bit Config register and a read-only
> device ID.
> 
> The new TMP421 state is stored in optional subsections.



The series has been broken by recent changes. Need a resend. You
can keep the Reviewed-by.

Thanks,

C.

> 
> The clemente-bmc machine is derived from the platform device tree and
> instantiates every device that is supported in QEMU. FRU EEPROMs are
> sanitised images taken from real hardware.
> 
> New qtest for the TMP421 family, plus TMP105 cases for the TMP1075.
> Both check a migration round trip.
> 
> Based-on: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
> Emmanuel Blot (22):
>        hw/sensor: tmp421: do not report a stale errno on a parse failure
>        hw/sensor: tmp421: name the parent object field parent_obj
>        hw/sensor: tmp421: implement Resettable reset
>        hw/sensor: tmp421: model device variants with a class descriptor
>        hw/sensor: tmp421: honor per-variant channels and channel enablement
>        hw/sensor: tmp421: implement register write masks, one-shot and N-factor
>        hw/sensor: tmp421: describe the temperature properties
>        hw/sensor: tmp421: keep the measurement across a range change
>        hw/sensor: tmp421: migrate the exact measurement
>        hw/sensor: tmp421: publish the variant type names
>        hw/arm/aspeed: use the TMP421 type-name macros
>        tests/qtest: tmp421: cover device IDs and reset defaults
>        tests/qtest: tmp421: cover temperature encoding and range
>        tests/qtest: tmp421: cover per-variant channels and enablement
>        tests/qtest: tmp421: cover software reset and N-factor registers
>        tests/qtest: tmp421: cover the register form of the migration stream
>        hw/sensor: tmp105: add the TMP1075 variant
>        tests/qtest: tmp105: cover the TMP1075 device ID and reset defaults
>        tests/qtest: tmp105: cover the TMP1075 config register width
>        tests/qtest: tmp105: cover the Config low byte across a migration
>        hw/arm: clemente: add Facebook Clemente BMC machine
>        hw/arm: clemente: populate the FRU EEPROMs
> 
>   docs/system/arm/aspeed.rst                |    1 +
>   hw/arm/aspeed_ast2400_palmetto.c          |    3 +-
>   hw/arm/aspeed_ast2400_supermicrox11.c     |    3 +-
>   hw/arm/aspeed_ast2500_supermicro-x11spi.c |    3 +-
>   hw/arm/aspeed_ast2500_tiogapass.c         |   10 +-
>   hw/arm/aspeed_ast2500_witherspoon.c       |    7 +-
>   hw/arm/aspeed_ast2500_yosemitev2.c        |   10 +-
>   hw/arm/aspeed_ast2600_bletchley.c         |    3 +-
>   hw/arm/aspeed_ast2600_catalina.c          |    3 +-
>   hw/arm/aspeed_ast2600_clemente.c          | 1154 +++++++++++++++++++++++++++++
>   hw/arm/aspeed_ast2600_fby35.c             |    2 +-
>   hw/arm/aspeed_ast2600_fuji.c              |    3 +-
>   hw/arm/aspeed_ast2600_rainier.c           |   13 +-
>   hw/arm/meson.build                        |    1 +
>   hw/sensor/tmp105.c                        |   85 ++-
>   hw/sensor/tmp421.c                        |  429 ++++++++---
>   include/hw/sensor/tmp105.h                |    2 +
>   include/hw/sensor/tmp105_regs.h           |    5 +
>   include/hw/sensor/tmp421.h                |   19 +
>   tests/qtest/meson.build                   |    1 +
>   tests/qtest/tmp105-test.c                 |  111 +++
>   tests/qtest/tmp421-test.c                 |  326 ++++++++
>   22 files changed, 2050 insertions(+), 144 deletions(-)
> ---
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> change-id: 20260907-bmc-clemente-0056d6676717
> prerequisite-message-id: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
> prerequisite-patch-id: 5aae2c14351eb51fea0cb307bedf21021730debd
> prerequisite-patch-id: 4d9a408b21353dda070052227302e799e4c01726
> prerequisite-patch-id: 01470b3e3d522778ea23f39f03a3b82a2a0f2d3e
> prerequisite-patch-id: 11d0a41b1b3009d95ddf51d9bde960658c924ac1
> prerequisite-patch-id: f1072c7d99e462e1c85ecace78eef33bc6e8778a
> prerequisite-patch-id: 8897466a7505261a1060243ca01572c3a8874068
> prerequisite-patch-id: f35c864317c68dd2b9ca969bec243fafd80497e6
> prerequisite-patch-id: 8b05ecb9c1191509e7e4cc76944c88f4f7891ca2
> prerequisite-patch-id: 78155b4352683ffc03826038c3d8160b788c29ff
> prerequisite-patch-id: e0af745b421c39fd47311ca21576c510bc961526
> prerequisite-patch-id: c14af0a372dcb314ef92a04a47e5bedc846281c8
> prerequisite-patch-id: 684f5ec9f4ac0640438d1eead20832c529d67508
> prerequisite-patch-id: e09c684b2002e30ae14a11bfe409869478d104bd
> prerequisite-patch-id: 09afec3682584cbda09b00c0ac87dc60835454d7
> prerequisite-patch-id: a89dfec61a795b84c3cf02927fd7c40bc6f694ae
> prerequisite-patch-id: 6a23cb3b1362aaf70fe73f554d9d5fcf2e72c3ec
> prerequisite-patch-id: 7c11c16803a5b96be5653a05acf8b46a3020e8d9
> prerequisite-patch-id: b9251deb99859cc30a9c67b5dba3066124f32033
> prerequisite-patch-id: 87291d7798b6bddde6242c651f0e03deb96ab559
> prerequisite-patch-id: caac35561ca8b2bdd86101f943e93aa7bcd3a90c
> prerequisite-patch-id: 27b0b37242fba900f982f9bcaca36f48c6a115bb
> prerequisite-patch-id: 1259c5fbfeb5d2bf1760e7b12df59f182528cee6
> prerequisite-patch-id: 2654532e955554fbae6ffcdf6ff3b38bb03fbbd5
> prerequisite-patch-id: ff0505a46b3604ba502834d3f5bf17ab85b3c5fa
> prerequisite-patch-id: 250958c152f11026aa98d334892132f9ab7467db
> prerequisite-patch-id: f3d938264fb2f0c2c292dbb4fb218e5b8d22c3d9
> prerequisite-patch-id: 06602fc849e499131998af486ae455497a4245c1
> prerequisite-patch-id: d857ee22db2d62a98f4f2054d1966cce7ed39452
> prerequisite-patch-id: 7909e49ac93573ebd56424a556d4e4872e9778eb
> prerequisite-patch-id: 53cd0411fed556e85f6557cab6fc32056c24bddc
> prerequisite-patch-id: 71752a32c10eacd296f62bcc94c09db5d54007c3
> prerequisite-patch-id: 7a21b5fabeddff9c08d6b532b2a398737f375a06
> prerequisite-patch-id: c6154dd1e7a48decd770f062fb57f32cfb2e1826
> prerequisite-patch-id: b94e4e3d83aa013ffd05267e20d48d6813ca2d7c
> prerequisite-patch-id: 23716ee3fbb2395d0fc33922433fb6d708081fae
> prerequisite-patch-id: 2e57dc2effacfdfb8adb93f5e33bfefdb7c28dc0
> prerequisite-patch-id: 2400063e36ca403574b812436fef8c38608e6005
> prerequisite-patch-id: 557a2e98bce9c59d1d4513207e021e217d9dcc59
> prerequisite-patch-id: db5ca53f9dccded71da127446b4870678640c86f
> prerequisite-patch-id: ddf5d85c6eb13a9121342263b6f0ee9902b40d06
> prerequisite-patch-id: d9e3e31b88133c8d2ffac7c931d9ab153cf20af7
> prerequisite-patch-id: 7ed25d5dc6b899645ef98cdb591344042b77c41f
> prerequisite-patch-id: 6c70cb570c5c6bfe0d61cb4c5260e6d8f195f383
> prerequisite-patch-id: 3caea8b32b51fa447ee21565594b6465d2e51670
> prerequisite-patch-id: 758236b35dcee46e176a7167e703048e11f6e634
> prerequisite-patch-id: 0521a46d473cad9f3924b4e0f86473fe237c1982
> prerequisite-patch-id: 819077eedcc252ade342c8288af2d57e0c8ece6f
> prerequisite-patch-id: 913f8260d8274a1c1706d09915cf75c0dd11061c
> prerequisite-patch-id: b0913e3e23d3bd41ffb248a3afecdbfe93b4915d
> prerequisite-patch-id: ef2e1478aad5f5722a2d021b424803d7cb2cdc4c
> 
> Best regards,
> --
> Emmanuel Blot <emmanuel.blot@free.fr>


