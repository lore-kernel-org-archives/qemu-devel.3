Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56438C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nL0-0000oi-FT; Fri, 03 May 2024 03:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nKx-0000o7-Ni
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:28:08 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nKv-0002G4-Ux
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:28:07 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2df9af57b5eso88991691fa.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714721282; x=1715326082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Yc1zydq2T8Yyxb1KKrQvzqlbkzuayDxOJ9A9FFd9po=;
 b=idYssapyCWlbuc/Try9yBJqM9ZBWzeSTS1b7CpgBUkQkb6xQ4bVtWLOYJuVe1gQKKc
 bAaUxGx45osdUloHq/ffxsDrLsdQYAyVk+01mEosNTJYFqV1JJEviph6lof6xiSYTQSk
 wnA7Mw3j/WwfmKNmgqSLFoMo6xvkDaN8S6y/pGBDJMsP2L6OJVfYVSelaiTtfz/Z5T7N
 /b0xC2Egx2Y8QpmPV9tXIDdlyDuo9MBcMgCQAe1u0AfJU/y4L8NTNF/8i4PFL9H6K59G
 Y5sHu+YeTO9gD7+MIHV+Kc7JD656JcHojRGDlFS6nAjyibVy2syNX9jFukOc+sWtzLZ1
 U8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714721282; x=1715326082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Yc1zydq2T8Yyxb1KKrQvzqlbkzuayDxOJ9A9FFd9po=;
 b=aC5RrPTaONIoFWMpvRv2UOrMSjMxPXy/oyL67fMNEOmZMajV7modCbFJVFMszYj19T
 kMeKXKcCu/allcl711g9DQFsFFpBlb89XCuNoi3o022wBjnmy4Jo2fBOPvrIl1ObHiFz
 V4FNil++8q00M+vtdiWwLpke5XskRaoA7YwqgjQwv6nIXaJkq9J25PZ6jHYAHKGdKxt0
 ZGOENUIxx1nI0/YDHRPxjbjo+ahR1IntHZ4IR8UjL8AVwHRHwhXfpbTOm9kcqbRwzejH
 zmdtrkeworQoL5xYk8w/ueeErR88oL22U6elCwCX1z/DPlU95ee92vIoUK8fmH25gvaX
 fIHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYrKT/HpcFnYil3Ki0t1oQpNLW/Hd0O9AixR32SqfyKF/hN8cjfsGhgo3Xia5PT/v9CU+6CbaI6jCOKos4NxtIa1qZt1Q=
X-Gm-Message-State: AOJu0YwTxZ2InyfiVLkU31ruhdiJnLPuihNIzSQtLd6Z9hQL5/xM85Fa
 F3UL8/WgsOZpaRCd8Xs9LgmXC/SKiuksOb2OwUiiGfhuY7MImUng9xqvWXDKaSV53BGUfrX8Qi9
 s
X-Google-Smtp-Source: AGHT+IGTHao0CzB7VYPwjUK0yrgn9KK93zP6tWTPElahnzWOYci/53Rj3UUlf3TzT6+UXCxFrt2HpA==
X-Received: by 2002:a2e:9214:0:b0:2e0:e7a5:7209 with SMTP id
 k20-20020a2e9214000000b002e0e7a57209mr1454513ljg.26.1714721281913; 
 Fri, 03 May 2024 00:28:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a05600c444f00b0041be78ae1f0sm4599905wmn.2.2024.05.03.00.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 00:28:01 -0700 (PDT)
Message-ID: <7fbc741c-69b6-4854-af2e-ec51b71cae40@linaro.org>
Date: Fri, 3 May 2024 09:27:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] fw_cfg: remove useless declarations from typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

On 2/5/24 17:53, Paolo Bonzini wrote:
> Only FWCfgState is used as part of APIs such as acpi_ghes_add_fw_cfg.
> Everything else need not be in typedefs.h.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/nvram/fw_cfg.h | 2 ++
>   include/qemu/typedefs.h   | 3 ---
>   2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


