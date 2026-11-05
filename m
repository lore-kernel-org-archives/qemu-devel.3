Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4E606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=H5k3coTG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrW0-0004H1-GB; Thu, 05 Nov 2026 02:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xOrVx-0004GO-Pn
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:04:02 -0500
Received: from smtpout8.mo536.mail-out.ovh.net ([51.210.91.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xOrVu-0001zM-Nf
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:04:01 -0500
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4jKtZV3s9rz8Bqj;
 Thu,  5 Nov 2026 07:03:46 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Thu,  5 Nov 2026 07:03:46 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.135])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4jKtZV2rKlz6MbC;
 Thu,  5 Nov 2026 07:03:46 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.7])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id C3E77203BFF; 
 Thu,  5 Nov 2026 07:03:45 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003bca7d49c-fd1b-43ce-8eb0-e3ceecba0e1b,
 55F4AE82A352CC4A4912F42944C0BD1B07566F15) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b0b7b17a-65d7-413e-98bd-3beb76ec1636@kaod.org>
Date: Thu, 5 Nov 2026 08:03:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] initial support for yosemite 4
To: alexander.hansen@9elements.com, qemu-devel@nongnu.org
Cc: eblot@meta.com, titusr@google.com
References: <20261013124649.194808-1-alexander.hansen@9elements.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261013124649.194808-1-alexander.hansen@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 3049499899778083851
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTESU0XKYpk21o4PFFiTkJKHe0U7+qbi7E3m8b1nR1DDjo7X55kMmOQRVBKX96WE7JSfgeV0VYvKfqFMItvEsJ6VBH02kkNtT5SSxFvCzN59PJL6qCVCMqknXa4Pp1zG+zjSbcyF7Le7LK94dtDFGwQdFcu7s5eNW3+RFCWEpy/8uX5FzIk/hgP8zg2HzWvo54K63zH3aYjLoQ49HYyfjbFkAJMQwWonxT9xRiIinCz1TEFi/FKVD7usOWOOkP3XfI/d6cTZusgNkXyOv7W8ia/9jR0ySSi0H3AtrVC6oxhrCD+DxtmW78NhbKvZix9j5FbLEuJnyi4Z4hw32ybTFsc8cRPo/bPTRAoFqg7FLkpw47N2POmmGIoGpUxTtaASpqdl9IV3Sb3wbTI/XYPhKyGmsWglZ3Pe9jgbmSGs86WvTRNaMk4erSCqVnARpWvLsrqBg0HUSXD0n7QZ7dPs04jHDRjsOiDVHw0iPatf0IYked9lj7YwRVqM57h4J2RJNPjkjvOTOkYTxX1eJMqSxIcFdDVdoCR1/jKt1aCfjDnAFNktJWpe+H4+endlL4tkbYJlyeVsGeql1lpDyCMNuzcDZL9oa82xXkqPqd0rYe9vDHa3VBX7PxhdIKwhBh6KlHrK+Em3ZRZia1sJSXmvMfDPEgt2ArZb2+vCLL7rx5HvaQ
DKIM-Signature: a=rsa-sha256; bh=Dzzw236H6ODgbFMnflD5MgKd8Xe8XMX/DPmpsoMFn+M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793862226; v=1;
 b=H5k3coTGf0I2p7cSpLH/NikWxUhq/GRW85PQkl0CE02OFtPjfg9QtskcJz/PkvZZJy7Regff
 H8LMKZMKuN/vhZ7jDsjrxI2y0gglLM9GnnhcAY73keTeszsL2jfY2B+sDFhGPYQ1rH2Kf48Rvt7
 eukalEF8v/5OqJ2tnQbg5giAqf7x3LDrMlqFIpdW09QpA10sBz2Unat0Y+LzawJMyTTZsbYivFB
 ssgZDsnFGyHmuXol9w2DhX9a/QV2Fsp3Qsk/r9m8D5oVtGDzWw0cCdVmpT2T4KWIaeJFqUXAget
 OtJ39ge96zzlylXjywYI3W0stH3lhKbCbMeqEqac7MlKA==
Received-SPF: pass client-ip=51.210.91.17; envelope-from=clg@kaod.org;
 helo=smtpout8.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alexander,

On 10/13/26 14:46, alexander.hansen@9elements.com wrote:
> From: Alexander Hansen <alexander.hansen@9elements.com>
> 
> compared to v7, there is now also partial support for PCA9544, which was
> needed since it's apparently in front of the FRU eeproms [1]. Previous
> versions of this series did not account for that because testing was
> done with a downstream image which had patches still applied [2].
> 
> This updated version should line up with the dts [1] and work with an
> unmodified yv4 image.
> 
> References:
> [1] https://github.com/torvalds/linux/blob/24a19b953e2a3d0ea5a8c4951a0ab8f32720c907/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts#L597
> [2] https://discordapp.com/channels/775381525260664832/867820390406422538/1541811213988528128
> 
> Alexander Hansen (5):
>    hw/i2c: support PCA9544
>    ast2600: yosemite4 initial support
>    ast2600: yosemite4 functional test
>    hw/sensor: MAX31790 support
>    hw/sensor: support MAX11615
> 
>   MAINTAINERS                              |   2 +
>   docs/system/arm/aspeed.rst               |   5 +-
>   hw/arm/Kconfig                           |   2 +
>   hw/arm/aspeed_ast2600_fby4.c             | 292 +++++++++++++
>   hw/arm/meson.build                       |   1 +
>   hw/i2c/i2c_mux_pca954x.c                 |  88 +++-
>   hw/sensor/Kconfig                        |   8 +
>   hw/sensor/max1161x.c                     | 314 ++++++++++++++
>   hw/sensor/max31790.c                     | 508 +++++++++++++++++++++++
>   hw/sensor/meson.build                    |   2 +
>   hw/sensor/trace-events                   |  22 +
>   include/hw/i2c/i2c_mux_pca954x.h         |   1 +
>   include/hw/sensor/max1161x.h             |   7 +
>   include/hw/sensor/max31790.h             |   7 +
>   tests/functional/arm/meson.build         |   2 +
>   tests/functional/arm/test_aspeed_fby4.py | 101 +++++
>   16 files changed, 1349 insertions(+), 13 deletions(-)
>   create mode 100644 hw/arm/aspeed_ast2600_fby4.c
>   create mode 100644 hw/sensor/max1161x.c
>   create mode 100644 hw/sensor/max31790.c
>   create mode 100644 include/hw/sensor/max1161x.h
>   create mode 100644 include/hw/sensor/max31790.h
>   create mode 100755 tests/functional/arm/test_aspeed_fby4.py
> 

Since the device modelsare rather complex, please separate the changes
in two (or more) series for the reviews :

  1 - sensors
  2 - machines

There is not much point in adding new machines types (we have tons
already) without the sensors and tests. So sensor should be reviewed
first.

Thanks,

C.




