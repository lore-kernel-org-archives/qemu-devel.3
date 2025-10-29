Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D99CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE13m-0000GP-Ei; Wed, 29 Oct 2025 03:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE135-0000BX-Vx
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:56:57 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE130-0002eG-Oa
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:56:50 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso1487715566b.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 00:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761724603; x=1762329403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mDlUwSv1YaYEoXIZSoPMWKBvn/ShJ6uoGvpWcqRmAHg=;
 b=vKGlsxCZUsZfwm47T5qwCHQ6SPCeoXn0U2HNdCidVIuncPdwHQ0XtaS5Y48AfFHTVP
 sCw6Q0anDUTkFs3HmKnUGKXsbG0fHNX4HDEQbWuGJknTaL/VviaFyRpe5MSU9etwIWwx
 O6R81Ygtr/H2I8FJLhOrc4n98ICHEfF7012ZaTojgWNZLH9GHUDaCBLV5x4KafBrN4fF
 ao0GYDvcvjFnKQWVpXbBo4Bc4jKzseaLsOH65hj71FR1VEI/A/Zq/be1nr5L2BZUn02q
 r6ij1AJCH/KO8mvMMXZSjaRwzZ3Kot3A7ELbLEpSb4i9m/NoV9ScGtCEtr4P3ADNYp+w
 Zwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761724603; x=1762329403;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mDlUwSv1YaYEoXIZSoPMWKBvn/ShJ6uoGvpWcqRmAHg=;
 b=L9mFewVnRa6nHtG46p7LCKW6R2PuWJg6+szMUXbe1SyjdetzfSOK3+qfUl60paLi7p
 Xd+Qq8HL84JBeE2/0g3y4/uSgL7RGmE3WEDfxcuRTDiDzz1S9QpnWqioixHrvUAhK/d0
 YBiJixzhfHfFaAdlhrF/r1o/IuKg5RG7QUg3w7br3emnXwClA1dcZrlp8z4+fRiA3tiF
 c8AcCgC0cj6ap+PRDdSp6cJPx/E8CTwJ9NotYa9P/Zc8+IQPszLHfmaMj2Nm+YtSVmZH
 NYZQZVTiDlnOSR8bFQ99QNCrroDwidOmQJC9WNlTTwSBlIRATOfkMzqewxCEckoTeA4v
 pfvw==
X-Gm-Message-State: AOJu0Yw1Q72VbzE5J8n+GFXfCFZSo+7Esj0XJcIj5GahGX5hHJluYT7+
 e76FUmgqN03/t5OMGfcPOoKb4I1mDyWtuBvN6DeFj/dZzlp7323HYbhd1q1NBzoynzueV2/l73R
 704i7M4E=
X-Gm-Gg: ASbGncsMPN3p+cl3f7LI3uZER+aPlpaOvuEPIQ3YRvy8NYEsfbajZ5E3wImXp93rbdy
 fqtPVVrDYZEhid2cWv/OsIPKp3qJFbBdHaP+3w+ilWBch8L8PijFYxUtSgVWbcfzRtwwDL0L+0q
 1K5M4AnvztdrXG2W1Y/ShPzx3JAAWC2fuvGpBHrMvGM4nwn6nrlxieOM9fFrRLrhU801Bkap0qV
 CHJO8Eh09hUEa49BTcXoYdZS3JXkBNCQrt16EAQOjl+IpHDDReg5TnrWbFDMEemWo8axqHtxwQo
 lBqlEGSbPScD7rJ3yLGngerp+4PFqkmoiO+dxtzNM3ItzmbkGnjGIcwMT9hz8R7GnWcxhL+se3V
 dmpT8RY2fd/YfeO5DpdHQyFk01Ey63uk3L99LCCjguFZtBJ6WA+PvCpYfevqHd7pleTIMYmUywU
 bIafoQLoJjcteUTpU9
X-Google-Smtp-Source: AGHT+IGuJxYKnA0kPuNAjStDio2xHqUlIpkF5V0aMGFh2InN1c86fmz6TcnBu9Tl7zJtFyLzk1tSHA==
X-Received: by 2002:a17:907:9496:b0:b3c:3c8e:1896 with SMTP id
 a640c23a62f3a-b703d457176mr169005166b.42.1761724602741; 
 Wed, 29 Oct 2025 00:56:42 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f98adsm1320274766b.49.2025.10.29.00.56.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 00:56:42 -0700 (PDT)
Message-ID: <68bccdf6-beb4-4139-9cde-3b5c5ac4660b@linaro.org>
Date: Wed, 29 Oct 2025 08:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/25] hw/acpi/cxl: Use proper SysBus accessors
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> SysBusDevice::mmio[] is private data of SysBusDevice, use
> sysbus_mmio_get_region() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/acpi/cxl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

