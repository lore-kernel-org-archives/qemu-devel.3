Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C460EF99C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqyFf-0008Sr-0L; Fri, 13 Feb 2026 13:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqyFH-0008JN-PT
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:50:29 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqyFD-0005NG-OT
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:50:25 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso755955b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771008622; x=1771613422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7WVuqsRPruTGyjFLLhsvkZuWnS04plL07MOV9ROGdhw=;
 b=kSzkWxsmVw648xFpCemcWUv0BVcS4szb5k8DVhDK6t+Ohg32lp9A1icg4oOYXTRrRa
 2IV7z+zW7Zr01XZQATkj7SRA70JZgxzylehtwLrRphCx9IAD8cGOEm6qnhUHNW3Z3LCO
 NY/FAjuIVL1On6U9dV4bboVQh/tmd4TgF27t3PZ9/2tlfkbMCdn8uhUFAw5VeSG2pR9R
 FzPWGLAdhFm+j374ByIgol9ydz1STdtE3Gfl8BrwKs1A/geCVErmGafkFy/9UvACCuxH
 qtDoOF16MKLnlAYvQnSiGl4PyuVzrUslSHL1iz1bITBjJrwpInfQIEKpfhiO55mwU2Lw
 O+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771008622; x=1771613422;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7WVuqsRPruTGyjFLLhsvkZuWnS04plL07MOV9ROGdhw=;
 b=M79z5op8EsggGQ3jtnwTCoNbeU8vuiY1VZphH0jh2Zz1YgXJeoT2UgDTBJAcqv/9Z7
 08F0+stZSE/c+RQ+RN2H7qZmFYaSOlp7jvgivxyWNwJjND/RmCJzQun3uIRenKjNO/a1
 BZh3ubPXW7cyQjZSi63XMBtYH5D+riEPoOPPo/QUzYJJvxR11uSFQYixEL//IB7MwTgq
 tFUr2wZtoSsmZEWt7ZhK22bNtHam5FA4eY07sh/7KuVu+2ZRivNaayQtUeQH3HkstQD6
 hXCf/B0ILd31q2qtcYOrTu45vxwwAfH/Yyd6OI5GJ6JXL63NvOAFRIoQ8VRPlI4SVL06
 ErHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/MGkpW6IMlklWrKo0Hzw+WOQvYHKEWrC7L4n37dA2e9eulVm7gZ3Kg3Aha+8Ggf11LhERVtPITzht@nongnu.org
X-Gm-Message-State: AOJu0Yw1jrSAig70ikmKaLxOPsw6v3NSiSd6UwH3I5FfqA+fO0tVF1VA
 sS4AtPVQ2dKjd5IpPsYDS3nFLOtkFPfXgPbGSx0JpJC10ELNPkcV0JvXL0ghsygs1VU=
X-Gm-Gg: AZuq6aI/fXMpDKZefmAyS0TZ4mkeJ5AICPOI9piMird85SR/JKF7uA9/ehKVNMHpaLA
 gp0UpW3XSiKcbnorxUWAtrZ68gFcv3gPGpb2V38iP4biXun4wNbPoUQGr2S5em0gGfAXyYoIWUS
 r4GH9WjCRNl948xFxgcxHtYtgIx49bxAX/d8p4I0jZRA/qvzywDu/diAAnrNIWdHix6QHBHO8EK
 HS4QQYS/Z6+ZYi/4t2kqNH9qSRjRCxdcsqH5ax1EY2i6usYTKNydljjsPub6h0J9Y9VbiSstGim
 xztlmpsp14Cc+XAcAaQOgfQkN0pKG3m6WKnsncbh4NQmyZnxMxN0ULAmbDrpV9xZJyBTRjZce94
 5325EV8m23OKJ+I5B4o0sJawfm74USxFPhCpYWmGYoSmn691ed8d5540sltMUNpDwyBwlyjH389
 HpGPRicUuN4TzbfqRuRqbcV51g2nN1AdPa3Zt19OBEjLzm6GQ7158vW25JZSkiNuoJtu69
X-Received: by 2002:a05:6a00:84c:b0:81c:5bca:8104 with SMTP id
 d2e1a72fcca58-824d5e698c8mr822935b3a.24.1771008622351; 
 Fri, 13 Feb 2026 10:50:22 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b69f2asm3235427b3a.37.2026.02.13.10.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 10:50:21 -0800 (PST)
Message-ID: <97638e2e-5749-453d-ba5e-5ca72cc5ec1a@linaro.org>
Date: Fri, 13 Feb 2026 10:50:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] qemu/target_info: Add target_s390x() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260213175032.32121-1-philmd@linaro.org>
 <20260213175032.32121-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260213175032.32121-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 2/13/26 9:50 AM, Philippe Mathieu-Daudé wrote:
> Add a helper to distinct whether the binary is targetting
> S390x or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 5 +++++
>   2 files changed, 12 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

