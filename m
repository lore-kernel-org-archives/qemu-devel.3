Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5670ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmTM-0006xw-41; Mon, 09 Sep 2024 18:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmTI-0006xM-8s
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:02:56 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmTF-0007RI-D5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:02:55 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f75e5f3debso22636731fa.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725919371; x=1726524171; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=drltcMgivYdfoRLl2mq7Yt01Hx75iedodM8F+UVBsTY=;
 b=fxmupvrp+fNR35+malJ7q+8tdfrSlm1JKXKOo+w6OALockK/Tq7xgv2XQKGea4p/5y
 bL7RRAxYLllx6wVTo5ZOiF5r3SSIzv1f7Xph49xDsaoSueTpnNrDoxtqZXByNcWzyJP/
 7TGNOjEFhSXLr9dylOvzcb0+MTXt7vKKhIMKLQAihSpO/d8QzRDS7bgvBf3ut86Hst7J
 wJEHj+YQ4+hTxlRVEQxv7Pnvfo958XL/ZUcr+4FdSFu1Uvmnw/sNJe73YN1ewbwH09MK
 S1GBo3z53Atb2oCstzwLLyCbHumFXcFA5IhSJLgN/oHT5mA3gUcpm/hY6wGysfqBAdUD
 9ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725919371; x=1726524171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=drltcMgivYdfoRLl2mq7Yt01Hx75iedodM8F+UVBsTY=;
 b=j6jPKTFRX8JbWAOsVrcG5D5W3kCTE8RuiN8HPOUU2uCam3fnr287ur4NfkOXdPRHWq
 rUEAQsTaSMNiCYoagooSbfpiEZPttKlbU9yb4GTFh7qn7zQeEb3/L+cSs+Vf5zZ2DO7i
 VBhoEkXrz+JaEIRA5Et5/RNYUws+QQihSMULg7jQiWIWBUsi9oGMC8vaVjMtyN9eKNeL
 lQiZuPWIfwx0dRMqpRMOc5kQL45InNj47cnAmT2cDTdAnRdXUwHzMPGndzlpcMZjBxXf
 vuldYaEYMxilOoHKgcBmPMP46gLYlZFbHiXb5szsJyz1GgXi3XiRKtpuxUWSlIdPrz2i
 DgHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTqMBVzmlPM2D95lzBriejVQCWNrrJwCaWRpQuRn+xpklO1QV8Wtjy6UYcMT4g9a+7wqQVBD7j5tz8@nongnu.org
X-Gm-Message-State: AOJu0Yz9kwF03+gENJR1aEGliSYE4uOjRVeaKs6iDeALJUdJuNWZ9fe9
 z7i5ctZib13J1hNZGrtKofrGQg+YVqQPpyGX72bVnhz+m4M8T/1+CpfRjYyuKH0=
X-Google-Smtp-Source: AGHT+IE90az9Cs2bjOG6IUUsKyFs1tSKOAgt3yH9q9wzJ+C/3mbLmkUA6JkRazmeJ3PHw/9FFpTRuA==
X-Received: by 2002:a05:6512:224f:b0:533:aa6:767b with SMTP id
 2adb3069b0e04-536587a679dmr8647250e87.10.1725919370787; 
 Mon, 09 Sep 2024 15:02:50 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835a76sm392660266b.39.2024.09.09.15.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:02:50 -0700 (PDT)
Message-ID: <e7c628f3-2d93-4b0b-bd3e-375f0c3fcdba@linaro.org>
Date: Tue, 10 Sep 2024 00:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/26] target/m68k: Merge gen_ea into SRC_EA and DEST_EA
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> This will enable further cleanups further down the call chain.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


