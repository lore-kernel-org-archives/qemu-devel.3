Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96CFD65C60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 15:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVtAK-0001pO-4S; Wed, 17 Dec 2025 10:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVtAI-0001pF-Rz
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:10:10 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVtAH-0007e7-A0
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 10:10:10 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so46397655e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 07:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765984207; x=1766589007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/Y0BnC3YXXY6t6v61hWaNIgd/7wUijoZxCy95Q2lVc=;
 b=dfB2tHVrlHGtj8uhIwRrNddZWmtsd2GAi5cvURHJLFR3FfaMOK75T3GbOryeoxNM47
 gDjGChy6XlOSQFxMyBghcOGsjVm+Ok/t8LL2fAnwN9iTX0TJ+TWKWb4Ik2cW0nPAVOzD
 MND8BCsHPPTYhFHJmWrJI4NadyZDeaZvRunr5qw43PLAfYbOncz50oi60I7xZ3T3Gc/G
 7JRun+bVSDwSQHDsNM85ZqSRy0f4pBefhgB5ONyMKZbWsC2OgG6B/cG/V5G/YmAAg/O/
 K1EQDFYnph4Dw+Gu3mTak8xvw1DJSLCjQOuhg/1Aml8JPCkOo2uS9vUj0GBDprJQERDc
 DvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765984207; x=1766589007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/Y0BnC3YXXY6t6v61hWaNIgd/7wUijoZxCy95Q2lVc=;
 b=FpWhdzquX/iUsTgdJuPCprraU8hkIHiL3I19cUPeNEfRpf3CPf6++cYBoydstuiz2u
 EVFTPHDUiJHPO3j2tUI852HRWE1U26lLf5yXL9nMoBbXLi3Yo0G9St+IXIrAAbcp0aRx
 /ygpQcNCpu6Ik9HjMSvHaNYxGv8vZgGesCg4iQzbX4XZR+pOzCzrSX11vicXXCTflAHG
 nYo4HmUrxtnJMNulxCPiu9buHa6eMlYUqP+vgzaEZK3z/6OacPVrPVEb6j4Gh3rBXMje
 rP8ufBgr4BmfPdVX2tXE0ewLsUGFUjH5TNqxb3x5Hx2myh1kBj/3nRfsgEfKVB3RI/MD
 HvMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2zX2tmJZ45lIKpvAxfDEsivCcK10XpCWCtjYU617rUawP/xqA5bFMAqj0dx3nLPpNubOD8ApnwaCB@nongnu.org
X-Gm-Message-State: AOJu0YwrkBeHUulBhBpwjBRJ+RBo1wbythk0I4vsbqhCZwk8eaxXlFoF
 kl329CA2gigJ1J7cD1xlNomoyajcA1h7dz5r0ybvBHifUzIUHqEQGdP7QNKKsQlDvcg=
X-Gm-Gg: AY/fxX7dnoxBFj24RFnJAe1nTqsMVY0co1eaQ5a522IMOXSkdmRhYZ4Y/+Omh6oY8tp
 Meh7feZnyq5sD+DnexXByUznCcoZNheOhWaH2kTVIjqokEDlYeSYbiuTQIl5AaFbk46aGdwKrBk
 r+dG21WtYDBwLmPzKWAdL69ChAd0z8V/zS+oC+grRaT5AsajjxM4RG1KUU7lmlNjZRAmCouwGy/
 +IDUZQQd6vFUx05Q3wLHx83p5XK3wRJ8nqyudhqu5fjXaujJIdcVyd2uidy0v1eUnOfCQm67lwH
 96fznyE4C2iBnKbJzJ1EJXThNVkeOHSwUfMMTtPbRaG+sXLhgVVJxeIpz/nYl++sqvqe3EfVRVY
 rBg7McEPH9yaxJiA8gufmTyZ76pUv9U5AFNZNNZWupsQaMXILjOxf/u8+8LX7RIOetlQn8mNl2z
 AkZ5qJ6JhczZSm2NGwej5X4GltfChg6cOCiylZQRF4TLxyUD91o77gpg==
X-Google-Smtp-Source: AGHT+IGR2QctbQ+UREBi95TsHXLm6VDJrwHAbam6rGqVfVkeFRAqY9G59CiT1x9Eus0bRAB+ma8VTw==
X-Received: by 2002:a05:600c:4751:b0:479:3a87:2090 with SMTP id
 5b1f17b1804b1-47a8f916cfbmr181389445e9.37.1765984207232; 
 Wed, 17 Dec 2025 07:10:07 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bdc23c2b0sm41815155e9.15.2025.12.17.07.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 07:10:06 -0800 (PST)
Message-ID: <3abfecc0-56f0-47d8-80c8-3ed12df038a2@linaro.org>
Date: Wed, 17 Dec 2025 16:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] target/riscv: Replace TARGET_LONG_BITS in header
 exposed to common code
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
 <20251217-hw-riscv-cpu-int-v1-9-d24a4048d3aa@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251217-hw-riscv-cpu-int-v1-9-d24a4048d3aa@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/12/25 00:51, Anton Johansson wrote:
> Macro is used in hw/intc/riscv_imsic.c.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu_bits.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b62dd82fe7..3d1c48487f 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -810,7 +810,7 @@ typedef enum RISCVException {
>   #define IRQ_PMU_OVF                        13
>   #define IRQ_LOCAL_MAX                      64
>   /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
> -#define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
> +#define IRQ_LOCAL_GUEST_MAX                (target_long_bits() - 1)

Code smell.

Should be a field in RISCVCPUClass instead?

