Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37401E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 16:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvCs-0006VV-AO; Thu, 09 Jan 2025 11:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVvCl-0006Ql-40; Thu, 09 Jan 2025 11:16:19 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVvCj-0006xx-Fx; Thu, 09 Jan 2025 11:16:18 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aaf8f0ea963so224379366b.3; 
 Thu, 09 Jan 2025 08:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736439375; x=1737044175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3P6B7cN90sb0P7F9FYFrgYnlz+CEgisiDOu013qBXD0=;
 b=Gf9QSxYdLoM82YII+DXzKxcJTyaR8jnozmCNS67SeWxkz0SwRV2WoctfEBo8HSDrhf
 fDOFv9vzIozqSTrXRjaQsgW+5JQb/oYhTDwgwcjsT8VJe5+mnQ/W2fIzmvwICtOC/gFk
 gPI8lVNYCiVxdlpnR3jzti2w15O7O35JSkZj1W0h7Rx+45ANDX0/vOWCTIDhDs8pu+Ul
 Negw/9F7tNpvCUyKvT18+XGMOEeC0zZ2LA089GXUZSTEwitAN0FVw1tzL0EIIYTNny6M
 Sy8YvsNa5bIoHt8I3iaD8y7UbXcnWXzUSllAgpSio3RDwKgY2Op4JriO9tP1NtWbE/Tr
 R9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736439375; x=1737044175;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3P6B7cN90sb0P7F9FYFrgYnlz+CEgisiDOu013qBXD0=;
 b=Otb2VX7e/rFK6PBZC95E4b2Ct6Cp0sQ4F5LdJ3IGIDhvgCpGFgy29P5FqG2n2rx1ya
 lunawx440yXHKyWRpXWwXjX9/Ftcs6023WkzE3rBN4cm5pTzmXRij+U6CO3PBhVS59Mu
 ymlhabRRP3tIw9RJ8Y1fokTKmQqaGV7XyCR2RgaIZafqDpzeVhleDAzFPnR6+XeakAOz
 iFRqEqXbmakhDh6tEzmyZGTXKmfp+gL2s2ugmfq13FjfAzBLaiSuG2T89DsbkPCe/jBF
 48ugOcPaQ96Rtl22rE7G6p6/oC8L9gfxtCRTrK3xCiY4qs3K7KgOteLfhvagUUMHu++w
 ZZgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1XqkYEFpelFDrMjk1BH+U5ZfuIDJPCjQG2WUzkMqVO4IWZc5aaSd9KKFZYWqJ0sbQwQbfg9vcEg==@nongnu.org,
 AJvYcCVsBVQdL6FEWqAJPU0xRmN7gk2ZfbV6LCNKuAotT6s3tjqBbYV6ajB1trpW/8o1eTknyDuXYqFHZPK8Yw==@nongnu.org,
 AJvYcCWcSnxgncudb9ypGlb2tF/X368PuCo868mz+MK2f++wzPFwkzWkMn2khQL4t19gMMpbQlnNpjmiYVsxzQ==@nongnu.org
X-Gm-Message-State: AOJu0Ywc3610KnbOJTLUxkct6zkuxAx0K2tmiyI07d2YE2F9aNEohH0k
 We8DR7emH7yVesyYh5kTnqXdBSo2y2gfBuucI09oIlypW8DmokMQ
X-Gm-Gg: ASbGncvDIlwIQT5lKt5qhRhRtaja2Titn3KkHnDfxcUMDQLmwarmlJ3EeGgyJPnKlB9
 WaFVIi/i+k6ctWHDbKMWfsLzaMpmajwHKOhlEhzR04ABNAliBuRdv4a6pN5cdCKldiYGkDNM6e9
 ugXxyIYKZ7+5Ir2PBJdDxKt0aPWIZPh1XagMemkEWkHF9rOMzvHQVZ64Mcq+8Qoi7QPxuRiLGcS
 wDQY4Umrv48WyfDuZhJt7NTTZwLaNAlYjca/BJkVfFDi6WUUmVe0+nDtg6Wjf0VSorZEGJc/X7Z
 /hu4ksK0O+TQ002I3kpLe/bG6rs=
X-Google-Smtp-Source: AGHT+IGwmbwtjaQapRFZWN6m0os2Ts5jqNF8vHLZXqBbFZMblLreOgkxOEApdfCWwPYgBK1/wRV+4g==
X-Received: by 2002:a17:907:3d86:b0:aa6:557a:c36f with SMTP id
 a640c23a62f3a-ab2abc6d264mr761857066b.46.1736439374596; 
 Thu, 09 Jan 2025 08:16:14 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9563b06sm85631066b.100.2025.01.09.08.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 08:16:14 -0800 (PST)
Date: Thu, 09 Jan 2025 16:16:11 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
CC: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 12/14] hw/i2c/imx_i2c: Convert DPRINTF() to trace events
In-Reply-To: <d1ee0d2b-0266-4d26-9832-0f9fc05fb3b9@linaro.org>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-13-shentey@gmail.com>
 <696c9a80-7311-4a95-ab3c-f85bc0b38e6e@linaro.org>
 <258e62c4-9e7f-432c-ace2-a5c459d8e016@linaro.org>
 <d1ee0d2b-0266-4d26-9832-0f9fc05fb3b9@linaro.org>
Message-ID: <D6A2F8A2-9E3A-4A78-945B-220E008F71F1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 9=2E Januar 2025 12:38:11 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>On 9/1/25 12:56, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 9/1/25 12:43, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 8/1/25 10:25, Bernhard Beschow wrote:
>>>> Also print the MMIO address when tracing=2E This allows to distinguis=
hing the
>>>> many instances a typical i=2EMX SoC has=2E
>>=20
>> I'm not a fan of using peripheral address access, because it
>> can change i=2Ee=2E when a vCPU is accessing it from secure or
>> non-secure mode=2E
>>=20
>> I'd rather use an 'id', a 'name' or even the QOM (canonical?)
>> path=2E
>>=20
>> Maybe we should directly cache that as Device::qom_path, so
>> all devices can use it for tracing, and we don't need to set
>> an id/name property when creating the device=2E=2E=2E
>
>We already have that, it is Device::canonical_path :)

Will do!

>
>>=20
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>> =C2=A0 hw/i2c/imx_i2c=2Ec=C2=A0=C2=A0=C2=A0 | 21 +++++---------------=
-
>>>> =C2=A0 hw/i2c/trace-events |=C2=A0 5 +++++
>>>> =C2=A0 2 files changed, 10 insertions(+), 16 deletions(-)
>>>=20
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>=20
>

