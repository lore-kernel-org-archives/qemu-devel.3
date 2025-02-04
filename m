Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3224C0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 08:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfE3Q-0001Mw-Go; Tue, 04 Feb 2025 03:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfE3O-0001Lt-Qv; Tue, 04 Feb 2025 03:13:06 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfE3N-0008GT-As; Tue, 04 Feb 2025 03:13:06 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so35833735e9.1; 
 Tue, 04 Feb 2025 00:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738656783; x=1739261583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+4WUeIaRkcurfxmP8uMY8cdQGLOHt4TcaAeO/QSkW4=;
 b=lpXOZffLVTjOFb7I2SNRoJyvXI+NFk58xrcQjZGQrN2Y7c3GNAVoDEO1ZWvNjLjoqp
 xJoWvtWTIvH7gOQAKmz7ujEwG6/Kqc2nTztyh+JJl7VuHGfo6qgE0orOJOi9++Uq7t6k
 heagijJYo7PnAjDjX5wmF2qkYu2i3AEAATYptwaOXykpUt5mACuGw5hQfl3KF859gPap
 iQhZNgpynQd3+LZ/r0c6+LtjhcerIorE0Ybzamnngw9Wmkebuv5HA+IiJZa7JV7RkApL
 ekmoAuj0hgWK013T1Lh+ta77GXgwV6GLWHrRS7Iyp5fwg8Ew/S70+Pwch8DKPlKS7OR3
 0N/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738656783; x=1739261583;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+4WUeIaRkcurfxmP8uMY8cdQGLOHt4TcaAeO/QSkW4=;
 b=NzoBGLML1Ut5hNl5AlLydkio93aqZcM7b/8kf0kjjs+JFNMlkOLHfLxqla85D2Plvv
 l7bwAp/F15c1qHgqxqJV5ufkrbK17GYU4YOXzSv6PdKx9v79BgM1jiwmA+a2rK7V3Ujd
 g1v6qoO4cHZH2OaNSNvbF55sfmYuV2+viy3Uf2+cGIMEGmM2tau2fz9tOcglcsAcs/6M
 4kDRGmYwdEkCxgVJTlIL17mXnd2GxqQN1dynIcthlGS8zce5p6vLiLxI7pE3tVXU8DdI
 qoHevpcclRQyqag6BtjUtjbjfoDsYQMM6zh5C657NpCSAvAgH6QwDGwL0x/7GnXamcWc
 M1VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKF29eyAnGDbD46bRndx+E16QRQExkkJHv2J9MSifxLRXc8x+bLIsLIEIypsmxt0hZg9xTLOyLfw==@nongnu.org,
 AJvYcCVSW5H6Tpld4Sm6JbN3OmHXVHb0r4OWTnKe3KV1dpzyxuVUAlKWEJ1E3gOuV8FH18dEFDE6S4tgMnH3Dg==@nongnu.org
X-Gm-Message-State: AOJu0Yww3EuHVdqTPhLpjG21MPFXVPMBEnv0F6PdohfhrU+sEYVwnc81
 EUM9/LYYxxi1FSnfK1e3JBZiXdoUESOLqHuR/trQ5jrC8ro/9zcY
X-Gm-Gg: ASbGncspWQqYNWiKwPPG9fsDqLqM7F7422nHr3amZpMouL94TCxgzIj3sskA6xt+Xsi
 bFs2eJ9gcy1xDJncHYFzDT1YrtgF03X88mNKZeg4egD0c33MK9rl3CGQFIhwHJ3oR6RMsC6nymR
 QvbXOeb2jRURW2nCeDw6zajgc1qMcF2xgV9WsaxMDZtojX8NsumvVZldgGFG5B9TfclMaoL7rcU
 oabix1Z+pVo3zhnQhVM+o5TW4SZCYDMv3JbNuQvQdwg1iDmj1ntbAswqdvoV40awfvuMFKYBZFe
 PoaxB3wCkOYxtVivvdGMzWAcHUZqRku5BcGrFlJXsMKsr0CBxVzkyXCAakXm7mZ3M8wuCaFP0g=
 =
X-Google-Smtp-Source: AGHT+IGm5tvrCO1sbypzpWGeqEZjBSN8QBPYx0m1W8kfWlRIjyvOOxmYWN4Qb4TnjD40zFgiQIosag==
X-Received: by 2002:a05:6000:1563:b0:385:ee40:2d75 with SMTP id
 ffacd0b85a97d-38c51960d9amr19272282f8f.20.1738656783055; 
 Tue, 04 Feb 2025 00:13:03 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf00430048cf2359cf0b0456.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:48cf:2359:cf0b:456])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0eccc3sm15244618f8f.18.2025.02.04.00.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 00:13:02 -0800 (PST)
Date: Tue, 04 Feb 2025 08:13:00 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Dmitriy Sharikhin <d.sharikhin@yadro.com>,
 "sai.pavan.boddu@amd.com" <sai.pavan.boddu@amd.com>,
 "edgar.iglesias@amd.com" <edgar.iglesias@amd.com>,
 "francisco.iglesias@amd.com" <francisco.iglesias@amd.com>,
 "philmd@linaro.org" <philmd@linaro.org>
CC: "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "jcd@tribudubois.net" <jcd@tribudubois.net>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 20/21] hw/i2c: Import TCA6416 emulation from Xilinx
In-Reply-To: <bfe7bca1df7d420266ec804d00a5352ef187c13c.camel@yadro.com>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-21-shentey@gmail.com>
 <df0ed59a-fe1b-44b0-a0cc-c62303294d7b@linaro.org>
 <32A9B14A-A0F9-4768-A28F-80702FA93960@gmail.com>
 <9d957453-5749-47c7-aad1-6977dac9aeea@linaro.org>
 <bfe7bca1df7d420266ec804d00a5352ef187c13c.camel@yadro.com>
Message-ID: <E970E3A7-1F4A-4A53-B121-B71257051935@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
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



Am 3=2E Februar 2025 05:42:55 UTC schrieb Dmitriy Sharikhin <d=2Esharikhin=
@yadro=2Ecom>:
>At Sun, 02/02/2025 at 18:09 +0100, Philippe Mathieu-Daud=C3=A9 writes:
>> No clue about compatibility=2E If you unfortunately need to add it,
>> then please address my comments in the next version=2E
>TCA6416 is _way_ more complex device than PCF8574=2E Basically PCF8574 is
>shift register directly connected to IO lines, while TCA6416 is more like
>fully-fledged GPIO controller with output direction, drive strength, inte=
rrupt
>mask configuration etc etc=2E
>
>In Linux kernel these devices are handled by family-compatible driver
>   drivers/gpio/gpio-pca953x=2Ec
>Closest things by implementation in QEMU source tree are
>   hw/gpio/pca9552=2Ec and
>   hw/gpio/pca9554=2Ec
>However they are NOT register-compatible with pca953x=2E

Thanks Dimitrii for the valuable hint! The pca9552 model works fine for my=
 purposes -- which is just to avoid clogging the i2c bus=2E

>I suppose, best
>decision would be new driver for TCA6416 which eventually should support =
whole
>pca953x family of I2C GPIO expanders=2E

I'll drop this patch then=2E

Best regards,
Bernhard

>
>Best regards,
>Dmitrii

