Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7F8C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 22:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHWmE-0002OX-EU; Wed, 12 Jun 2024 18:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHWmC-0002O9-9e
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 18:49:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHWmA-0007yh-Le
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 18:49:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4210aa012e5so4594295e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718232543; x=1718837343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VMPkjphzI7jBLRJzoWXb3tOsGoP14cnyUVZQCVDADyE=;
 b=XNoHVqsXirHbWCZQ0A9UNzS4xxYDHyqrfx2TeEsAfVjvvghXyfTJpJs91mRv18D9Ev
 qQ7kmqgnGUHxveNPOT3sSgTz5rlZokteIw7hktWLNhwOrJO6KY5lew0toFddJyvEaHu0
 ESoeqoQDMg//moBzz5xOLNirQzkyiyWPfpSDAC44iEeXah5wR2zAoPAldr9nJ6G4Afp4
 WLpUThGMw9XOR0d2O8bGJLLSZoCscbgo8cqsgK/qSuiIbruJprZWphTtiQf5f46BaG0U
 IwYFkTu8Rd1vZFKNT8QuIyR4T+ydAOayaSV8fBzxtzSXlajfxBWYMx/JoknF1+YCSCSr
 b10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718232543; x=1718837343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VMPkjphzI7jBLRJzoWXb3tOsGoP14cnyUVZQCVDADyE=;
 b=TL9DNPNcGKbf7vU+F/+cqasUrWuC4KeNQhwezKRtZus05ggp+oyzNeNBvrJqoP/P5i
 6zxLm9+fVAKG4xlnWVZxR0S0w0K69Po93gYN6trIqmq+Totb/B1W2j6hEZcEfdmSsUhQ
 drP/knJ5GYI3Ea5jatEWgIY0XuWoIgc1AH10m6c9U72R3Gl4zY/3uX2q7wnTj1+WtBbn
 63a7OejrA5jzeMjN3Udi1la1zojn7yW9UtS7HP4yyo6msuHcAHoz5sRwX30DSStIsyNa
 E+mJxDpWi6t4iydBMZPQSx6225aEHMQaIwx0B7Oyo4I9mJXMxy7jIKCv8sdtsQjz2fFd
 SMOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4u7UjbHrvtaqtBeWRGJySB1svMqq4wKotjpJsrjtUTK46Ub0XzWWwvPY//WgZP6khq1dSLB3DHE4HTdkALgHRkcqkzSc=
X-Gm-Message-State: AOJu0YzPnh8xXGRyKNw8QFgSj2/pv7RMdMGATi8GRSgDIo8BojycNxay
 5zgNCpCtwaIQnQZbTRtlTYTgSq981hgN1eJLQx2VhGARyojtaC9jHza4s4FHyV9qBBasI0B0Fzs
 m
X-Google-Smtp-Source: AGHT+IG82I8oRkEgvuYUNGAMoqJ8WB8pGOrwL7By2MqD6+zTzI84v7Sju0qUOcoXM0UEQxRdcrjGOg==
X-Received: by 2002:a05:600c:524e:b0:422:123f:4b05 with SMTP id
 5b1f17b1804b1-422866bfc43mr23266725e9.39.1718232543047; 
 Wed, 12 Jun 2024 15:49:03 -0700 (PDT)
Received: from [192.168.69.100] (sta21-h02-176-184-21-30.dsl.sta.abo.bbox.fr.
 [176.184.21.30]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602e7e3sm2432095e9.12.2024.06.12.15.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 15:49:02 -0700 (PDT)
Message-ID: <d9a20624-1813-4a29-b819-1de3961cc3cf@linaro.org>
Date: Thu, 13 Jun 2024 00:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/32] hw/sd: Add mmc switch function support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-22-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-22-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/7/23 15:24, Cédric Le Goater wrote:
> From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> 
> switch operation in mmc cards, updated the ext_csd register to
> request changes in card operations. Here we implement similar
> sequence but requests are mostly dummy and make no change.
> 
> Implement SWITCH_ERROR if the write operation offset goes beyond length
> of ext_csd.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> [ clg: - ported on SDProto framework ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/sd/sd.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)


> +static void mmc_function_switch(SDState *sd, uint32_t arg)
> +{
> +    uint32_t access = extract32(arg, 24, 2);
> +    uint32_t index = extract32(arg, 16, 8);
> +    uint32_t value = extract32(arg, 8, 8);
> +    uint8_t b = sd->ext_csd[index];

This field is added in the next patch :)

../../hw/sd/sd.c:927:21: error: no member named 'ext_csd' in 'struct 
SDState'
     uint8_t b = sd->ext_csd[index];
                 ~~  ^
../../hw/sd/sd.c:949:9: error: no member named 'ext_csd' in 'struct SDState'
     sd->ext_csd[index] = b;
     ~~  ^

No need to respin, as I'm integrating your work.

> +    switch (access) {
> +    case MMC_CMD6_ACCESS_COMMAND_SET:
> +        qemu_log_mask(LOG_UNIMP, "MMC Command set switching not supported\n");
> +        return;
> +    case MMC_CMD6_ACCESS_SET_BITS:
> +        b |= value;
> +        break;
> +    case MMC_CMD6_ACCESS_CLEAR_BITS:
> +        b &= ~value;
> +        break;
> +    case MMC_CMD6_ACCESS_WRITE_BYTE:
> +        b = value;
> +        break;
> +    }
> +
> +    if (index >= 192) {
> +        sd->card_status |= R_CSR_SWITCH_ERROR_MASK;
> +        return;
> +    }
> +
> +    sd->ext_csd[index] = b;
> +}


