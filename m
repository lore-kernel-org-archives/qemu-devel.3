Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE13CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNkG-00063S-V2; Mon, 11 May 2026 06:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNjn-0005v6-Ht
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:19:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNjj-0006Cl-KV
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:19:46 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso3618348f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778494782; x=1779099582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zMoXdvZrBGo6m8vCrMhMx01TsoQ1jPS2lHd2UGcU+g4=;
 b=vuv9miskK2vEyDQr725bbeqc0ZMppjPTGizWK6AKc7VVNKSFbOtLov8BwqMW5+aN4x
 hYnT0rTuxdWpUKNPwqFoufafXAeY3shksfurEpcn+I+/igs/7+/jL+FKpspmzPAN7HCn
 P59JWBjH8y+Q/GyjvsBeyUlBCYuyYktpavfFDBfiBffFE9mhqAQzwzojXC0g3Kv2aeZE
 HAYHdrbhuTqw8IngQFni+dEDPPGocnR8yWpxdiHgjYBBOmBthZLzXkgpjGhDfj6Mgyg3
 v0GPftnynCdms1Ga+vNV6t7ovbj8ejyEss6knYg6jy1w3gBOensbBjcLjapxFnW9dmJb
 dC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778494782; x=1779099582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zMoXdvZrBGo6m8vCrMhMx01TsoQ1jPS2lHd2UGcU+g4=;
 b=NzQdrThGovboIQ0nn8QpZHnI7yj843sX/ZCsZBYZC9agJYA8neDtq9ONYorZniKQ8r
 3x9T7UHqfGs8lR43e3sHqFngvfc9pDdvGQ4JeMQJ22uLZ+t48MREdFfiwxkvFZnV0sxT
 +SmdgRakIRPPfUy1YsCLh+aku+jzS5QTPKN2QeQFV9QljUSYisu9VcpTkT18hKbYpYrF
 i3U+xUe1MfubkU13tLmM2CTsRIEYudYzAXnpJ1RaDz9kgX5mRpbv6kk6u7tiIheZXEYD
 XVOGbgwsOj6aPUWQT6jkMMwG1f4ZgFVK1wwxb7wGym/bNkYU5Po/5Sog6n0/nSIu6ktQ
 pBQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/rNM5irLRnl2E9xqEKq5hKQVG8lXbRIU+05X4VcR0VJy1P8Wi88F+UWJ2JG4XhXu6pDGqcg/ou1bC@nongnu.org
X-Gm-Message-State: AOJu0YzrToSLRysOHnR8zBYW5HQeDhZjxzZMuoULA6yBQXAEJSGCJBIS
 w5rySm9FRFEW7r7L5r8toru/iDL8U4Jj4Q68qq7GekxMEroolpJY96DgtLKhbBGwlzg=
X-Gm-Gg: Acq92OF8ruFNwnqgQ8yKs5sDpelCAX/qi/Tjn0g9ZYxzS5PVmCkgttvZFze1n8MPIp7
 xJuDUSadYmd8xKC6xWUqhlOYWIkJUClXOFekeHpIs7FWc8ybp3qdiQFGgSfCpn1x8Vgiu3L/uJ1
 PDf3CEw/K3FAbD8QDzl/4Kgzj5tkHbdAyhlcb7rBr5+iYUm1goslL+utKWOwFst4+AtvjFajpvd
 kvx/0lnasZpflt26U7vT3Z8z12xCB31vxilIBz6fBzOLt2Ly0cwM8BVOkPjC7gf2WCsCtXY0A67
 ULsYHNxjsc3fbzIbVX4fhBrdlo5lbl3Y37pIfNKEOAnmd4amitUPdura/CaDZks//xXSzuziWrg
 ET9b+NehakTmuiqngqPyVNXb5x7IAvF18B5Qq4aTqUnoN0z5j1zdCn/6m7iacHQoVpXnQH2ytXw
 K6rxgixwOgJDGWNeifXvngnJG19wD5DkmBAxOHvaQDdjQfx1WNCSL/u8CpR35qIMyXNQ==
X-Received: by 2002:a05:6000:4308:b0:455:4288:6c34 with SMTP id
 ffacd0b85a97d-45542886c70mr17085622f8f.24.1778494781978; 
 Mon, 11 May 2026 03:19:41 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e4bbebdsm26518664f8f.5.2026.05.11.03.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:19:41 -0700 (PDT)
Message-ID: <53a66de2-e155-45d0-bcac-2f4d45f1e5fe@linaro.org>
Date: Mon, 11 May 2026 12:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] [RFC] hw/i2c/designware_i2c: add SMBUS_INTR_MASK
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
References: <20260507120524.111056-1-npiggin@gmail.com>
 <20260507120524.111056-5-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507120524.111056-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/5/26 14:05, Nicholas Piggin wrote:
> QEMU complains about access to unimplemented register when Linux
> inits the controller. It is the SMBUS interrupt mask which the
> driver unmasks. Since the model implements no SMBUS interrupts,
> the mask can be implemented trivially.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/i2c/designware_i2c.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

