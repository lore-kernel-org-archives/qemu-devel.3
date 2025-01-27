Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A963C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYGE-0003sd-5l; Mon, 27 Jan 2025 18:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcYGA-0003rx-KP; Mon, 27 Jan 2025 18:11:14 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tcYG8-0002up-SG; Mon, 27 Jan 2025 18:11:14 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso7327960a12.0; 
 Mon, 27 Jan 2025 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738019470; x=1738624270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OAcb13yKxdtvwr2trvtvKYqKmZygughFPR3uezWb2o=;
 b=AHJTqJgdnfBILRSFFY//YvBFPV9V+8QUrdb8ZXyfvxlKKEjX/kqU3z8JGlMerqsizP
 hrUP7aZJDHFKFPlbp5OjkCPt2IKvthzTEOKShqEJxMEkwXuoaj2fABu5yytTlXW7PZGH
 P1K3evZpEwV18Oi5VD7LJF+2uesBiXZkcrQ+a9hS22RWllmZlcHdSVbY2QHIZMlZ9XN0
 oAjUFN5JTiyzfO2oao1mUPCzS930M0MzCQIDmvtLWyRlrPe65JoNMPEtPDOVSrRj0D5r
 KT41LN1Xo2AlWwwXK9Ho2KKV1IB4D9LIb+b72XXppt5LZTooceK89waDfS/PEoGGU0xa
 GrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738019470; x=1738624270;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OAcb13yKxdtvwr2trvtvKYqKmZygughFPR3uezWb2o=;
 b=UnRJPNgztAVfDPuavU+yPJ1z3re8iAgqKmVsHvWGFPaPSOCUTnQvenZo4LVlghAbpv
 9BCbYvhm+vzWWymy4OpnJ5oPjy0Lpao8x1kQ/xzpxk4U8HXc7LYnduUZn+bciVGRJoVZ
 JBDpfB86AwYSFXYWnGFQTGU6Affr8eXw4/hpwSH86Cmgt1TIC0namEu9CFRpTOhI0iC4
 IDDnuyGuY8OzMfDwC7pXbCzSugj3N0/km1Et+E7AFebf6dkunJ+3gzXYj1+mliReeTvo
 FXQ6xaFpNKaeRbXWJPpPsFVlV1BqXqziKbZm67oaTkwp9fPCKtmPYPvoay0qhvUXUl/7
 OrpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIsK8srcFyjTdvmABLbMn0NNkAwP/R+cHZVQZEVNYtjtegEl6shTOJ6hW+kGJR8mpqZD1pBRtHjoU5lQ==@nongnu.org,
 AJvYcCXYbQpk/pDlqatL+cvAgWEZiscoKpaT28O5XzuVIJMQUPtrfc1CB3hb6uainQXA2LQA4xc3Hr8xlg==@nongnu.org
X-Gm-Message-State: AOJu0YyDezOe8VwHWeZLxgSauuXZXkBrt9QR//BL2Mw63FCgCrWDv/Jz
 CeS3w57pGOAj+D0ZjsHdcoSd40CqQprNs01w3nF6ezVmlyfgVyha
X-Gm-Gg: ASbGncsGvIy4sz66KmUQY8ECHDwtpr/CPwru04LlK2fgW/BU4glqNDFxkHTsCRMdrWW
 /SyTJzogiA3F+OAsiMztTG7LeUx4OHYBfb4WsnvpxjAkYvtVOtO+UFjbIU5ilyHWHmbPNxjJixV
 hGah+EhGeH/ydTJNMDT7gd6eFRV3i8HYf7atrVYt9hUmY2SI2YzAmqW3KL1m2oyNDHIG+kTHs/F
 MUphw1ySz6N7AmOcQAUdH/jgyhs4Lmze9rPp47xqG/oZESGRKkFqyv4L/TH4Ogi+SpkTXKnTUID
 JsbMNbmgUMabexC+1BFTTARNfUKcO1uFRf0lA7kMMp8dD6wRP1RmUbVw
X-Google-Smtp-Source: AGHT+IEisztnD29Cs/9MwqJ5PVpVEchSi8Fa9wYfAl0rdKmq3U0DVWzzKLSCg0S9vuu7BenhcXELaQ==
X-Received: by 2002:a05:6402:1e8e:b0:5dc:1059:6b2 with SMTP id
 4fb4d7f45d1cf-5dc105a5ec1mr41869335a12.7.1738019469307; 
 Mon, 27 Jan 2025 15:11:09 -0800 (PST)
Received: from [127.0.0.1] (dynamic-093-128-047-181.93.128.pool.telefonica.de.
 [93.128.47.181]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc1863ae37sm6246803a12.41.2025.01.27.15.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 15:11:08 -0800 (PST)
Date: Mon, 27 Jan 2025 23:11:07 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_06/13=5D_hw/sd/sd=3A_Remove?=
 =?US-ASCII?Q?_legacy_sd=5Fset=5Fcb=28=29_in_favor_of_GPIOs?=
In-Reply-To: <CAFEAcA_m29rWYQPtz=xSBsS_FXb5_L6+DGBA2o_TrLcFy6YC3g@mail.gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
 <20250111183711.2338-7-shentey@gmail.com>
 <CAFEAcA_m29rWYQPtz=xSBsS_FXb5_L6+DGBA2o_TrLcFy6YC3g@mail.gmail.com>
Message-ID: <BB80F4B5-02D5-411A-95DF-9EEE91237EDB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 27=2E Januar 2025 13:24:46 UTC schrieb Peter Maydell <peter=2Emaydell@l=
inaro=2Eorg>:
>On Sat, 11 Jan 2025 at 18:37, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>> Commit ce5dd27534b0 "hw/sd: Remove omap2_mmc device" removed the last u=
ser of
>> sd_set_cb()=2E Rework this functionality into GPIOs=2E
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>What is this for? We have a non-legacy API for "the SD controller
>needs to know when the SD card is inserted or the readonly
>status changes", which is that the controller implements the
>SDBasClass set_inserted and set_readonly methods=2E (See the pl011
>for an example=2E)
>
>I would prefer it if we used that consistently, rather than having
>two mechanisms, one using GPIO lines and one using class methods=2E
>I think we should delete the sd_set_cb() API and handling code
>entirely=2E

According to the Linux MMC controller DT schema, there are actually two wa=
ys to implement cd and wp lines [1]=2E When implementing the imx8mp-evk boa=
rd, I thought I would need to model the GPIO style [2], hence I implemented=
 it plus the active low part on the SD card=2E Later I noticed that the car=
d gets detected anyway without the GPIO wiring, so I'm fine if the code get=
s removed instead=2E

Best regards,
Bernhard

[1] <https://github=2Ecom/torvalds/linux/blob/v6=2E13/Documentation/device=
tree/bindings/mmc/mmc-controller=2Eyaml#L60>
[2] <https://github=2Ecom/torvalds/linux/blob/v6=2E13/arch/arm64/boot/dts/=
freescale/imx8mp-evk=2Edts#L776>

>
>thanks
>-- PMM

