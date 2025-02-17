Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90A5C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5VR-0003ij-Qz; Mon, 17 Feb 2025 13:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tk5VQ-0003iP-5U; Mon, 17 Feb 2025 13:06:08 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tk5VO-0005Nx-Fu; Mon, 17 Feb 2025 13:06:07 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e04064af07so3751057a12.0; 
 Mon, 17 Feb 2025 10:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739815564; x=1740420364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaN2sSPFFiwBnMfqYqsl5cyD2PC40+ClPj2oGdRuNAw=;
 b=fFr3u/T4BjYZX4rxftcOzo5jDC5iQzi0rpuND7aM79FW1BsFK2aZ8j6r2C85arzDAY
 s9SQst3zNPGS82jBJjUkyTAyxT7xgvRcomgM1hiEUZ6f6T89inuoc9QA/msfaglKOpy4
 bAI0QSLLOSa4swPxcdsODfJgFvy6jRcgfLHdh9zqqGmUtZCr8wkRTYbanGv5S5tUEp6l
 n6XMaNuFINDq1jn+HE7G/qGNfgq/MCRMpV7mgfmkaaeHQL/2p9rTnxXKQkonXMZuqYgD
 MOsmNxhSx1vINupZXN/t4gujZOe/1O1LNBPM/t2lw4RzV37sNqm6if7kS0yztPZuZN01
 316A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739815564; x=1740420364;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaN2sSPFFiwBnMfqYqsl5cyD2PC40+ClPj2oGdRuNAw=;
 b=gXtb3X/FlgViR3rNCTjUxUHox/c9Jlj+IFHHY/eMajfa0USCVtO+50YtrWvYjNBijB
 hcBKYRoZfQGGXvgne+fgY7CoWrlXcxTrk9eskkUDZwPK37dS4JURprN10xoRjzwJKJqX
 mAw6pu6JoymkrXfYliYkaF+mLKHiV2ZYWq1SZtDHyQascwPO4/gMfby/L9pHBp6XhQ74
 kv6o8s0+97jIllRoUL2qgV2UBcCmdqBRixMtefRVr5/QWMABGjQEbZTHn3l6/mu95FRu
 F0quougCwSNp3bU3vDwzT3FzFmRZfeNNpi9SVXfVDt+3k8vo4JpU/inA8m1n9SXxN8u0
 jVVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUabD0QendhZ4fzp0JNJ2Hin0VL4Ryk3HX73KOpVR/H2mXXJSW0u5K9iVKD7A7T1RTGYudaNHfW/A==@nongnu.org,
 AJvYcCUsUFN9+07B7fGexP5ILwwrhIksAfD5EyfKLVIQybjLtjx41vpaHODuzRHlXC2x4wYAxzxrSdOd42bBkw==@nongnu.org
X-Gm-Message-State: AOJu0YwkJ0JXwXqLGMtvx1GDo8EMd2IUfOkh6G+yyDb+IatiQT7INwuE
 fb+20wz4gHHAxyAKqIlYoi7RWVlNKl8ICi5TH/JaSH3ibYQ+FF5R
X-Gm-Gg: ASbGncsLWFAv5gq3A71eV83wUxaPpPCweiMoCyidusG1w4buTH1VYnaLjWHu2/wM6/A
 W18z5GukBE0OegExQvYKDdrwItfhP7JLpAWIYkcrj9wU5/r6CpRu9xwjLj5lSFvR0YIUM5Boyiy
 oWVYAp71JHBHfX5oJNTrlYqBPABf9GZfeyAINJ8ccwIPNI1sxCs+iknhmOC53i3U62i5UELTTmG
 hgbsq6IiKCB3LHgm8iGbQAed8fJVB+vqn6hQoKtGP8RJr63Dj/UcVsrvuKNEsakb9t+U5ypD96P
 j1BzjyXV2VE=
X-Google-Smtp-Source: AGHT+IHLuKYdW2FaIMOTwy4X6diFtHVZy+8wsq88+M4SIVCVNzTkDi0Qpk9+EB9Shqvx9sL12qvLAw==
X-Received: by 2002:a05:6402:4413:b0:5dc:d0be:c348 with SMTP id
 4fb4d7f45d1cf-5e0361cc69amr10060460a12.20.1739815563764; 
 Mon, 17 Feb 2025 10:06:03 -0800 (PST)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1b4debsm7544846a12.15.2025.02.17.10.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 10:06:03 -0800 (PST)
Date: Mon, 17 Feb 2025 18:06:01 +0000
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
Message-ID: <10A067EA-99B7-4898-BA08-15657BE841C4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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
>However they are NOT register-compatible with pca953x=2E I suppose, best
>decision would be new driver for TCA6416 which eventually should support =
whole
>pca953x family of I2C GPIO expanders=2E

Just for the record: There has been an attempt to implement it: <https://l=
ore=2Ekernel=2Eorg/qemu-devel/20241107195453=2E2684138-3-titusr@google=2Eco=
m/>

>
>Best regards,
>Dmitrii

