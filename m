Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6531CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 21:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnQIV-0007S6-Tv; Thu, 21 Mar 2024 17:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQIU-0007RH-12
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:50:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQIR-0005WR-FL
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:50:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e6fb9a494aso1214397b3a.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711057796; x=1711662596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SEedUd9ZDW4vcsMsOgWvMetsOcnszAjVcVT/IGiFqtI=;
 b=mdpXMAt0/XGZYvFcF8fSd0wrM6ITRx5Sil9FgNFEDaqN7i2xO0+dgQorDNMylFD778
 AxvNs/0KnFZ1d3ht5uzBF4ZPJBm8uViTpqtZR7EZKqwFZTd2paw1ypQ66UD15Gz4aLFd
 lU6K0X7Rg5nfwTQdAT8aPHvZtmKuVR6Ftpwbv3qTd6xNBmsYnaTnD4XjQzWMtLvdQRdV
 DK48hKGIJ9P6CIWjAEcBPqQQqgbPxzdfJ6XLn0+NCBKbf9Gf+h4fJj1O4lyaVuks1Roc
 WqZmsVLeK6bSFGKddo/IXGJWeZ4EJuOG0n54uQ514ijQPbB1d5bLCvBGaXvu+gCSv/ai
 Yh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711057796; x=1711662596;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SEedUd9ZDW4vcsMsOgWvMetsOcnszAjVcVT/IGiFqtI=;
 b=EIE+EOfaYwPJjVk2XqV70ptxGv8Csrgf9IZBHn91Xdel/ghb1tGzbJLrkM7e2pvPca
 tQ2+HFkkqzuU4rUklkh5WGLL0z8ZCCNEBMvnosd0i9UoNSve918p7Pn8Evnj7muCsMla
 ipcMNq3oV5grL5OAqfSBxDMfSGCipFA/vWhvqtFoUOD265CU44/U/aAtqS+GFItYv6pH
 iLNx1kPSt6heX0iYvmqh+Z2dDrpPoJCw/44Yb9D7s/vCaiOiJKa17/4cYVXFbyF42PX5
 WseVXL65KR6BiWEJR6vwHHVz+gaW/W/QZig140NidsnRELHEWH+3LeAGaGHaIcNufM5N
 wDvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrRYfwq6VMMrCOtSSM3Jt9SnRnsiLuHB19pKsJt+TKb2flVEy/Vev2vjoFmp7c3mC1zRHSnsGXjJDUmPwZ7IzVb4qGO7E=
X-Gm-Message-State: AOJu0YyBhaV/7ZikWQCqKKTilJ4ZhdSYtb2tOxQZBetnWD4phX7u/Q6x
 WAHAoSdNJHl7zCD+Viowj/sr8oO/7emDFgPmiTI+Sjmam1ZLzhe0OvqIxmUiGPo=
X-Google-Smtp-Source: AGHT+IGv+gW70ojCQRLGj1/ORk7cxHChFo4CMd7J9rtOzL1aE2gcSvhwzQ+5XJ6EWEvcXaIRitwSqw==
X-Received: by 2002:a05:6a00:2387:b0:6ea:7f6f:af15 with SMTP id
 f7-20020a056a00238700b006ea7f6faf15mr781003pfc.23.1711057796538; 
 Thu, 21 Mar 2024 14:49:56 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 g3-20020aa79f03000000b006e6b7a88e64sm314923pfr.73.2024.03.21.14.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 14:49:56 -0700 (PDT)
Message-ID: <601cc8a0-717c-41cd-ac00-9112f44ea2da@linaro.org>
Date: Thu, 21 Mar 2024 11:49:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 06/21] target/m68k: Have dump_ttr() take a
 @description argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, "Dr . David Alan Gilbert"
 <dave@treblig.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321154838.95771-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/21/24 05:48, Philippe Mathieu-Daudé wrote:
> Slightly simplify dump_mmu() by passing the description as
> argument to dump_ttr().
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/helper.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

