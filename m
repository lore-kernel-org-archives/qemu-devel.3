Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320B9C02194
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcsaR-0001mw-KG; Tue, 28 Jan 2025 15:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsaC-0001i7-Mg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:53:18 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcsaB-0001QT-1Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:53:16 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef28f07dbaso8585743a91.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738097593; x=1738702393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=URo8FEmDFzB6A///SxC3rjAeGZIUOBN9+BRHaomH+z8=;
 b=uJ/wVrx3v7Bp2zjievknXA9UAR1FkzUPNEApmSDvzH7aS8SRRT0qZdZ+oyP1n+H2aK
 PDRE5msyApPcdjC9lBsUlyDlYJur7LUGPrhd6RMO+IUbzrnqRHF10J8J19+F0RNv8wqw
 a0u5nJ9WzKgnWiCzqwmoqocll/WYXtiBEMlfy+4bOKjop63LjivJfmRdoiLJrGfjkJyl
 bkQcq8p8fKrs/OzERg9BG/tKxpvwknk13O++GyoVvQjx1pHj4JMHIbU0wuCxDWSlz47H
 kqcsbViKeK8NGy9IZIpvQz92JUWFwa5ZIk1o/bWhHvDyP3VIk1U4bkYPdcD2Wd7Moavz
 /Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738097593; x=1738702393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=URo8FEmDFzB6A///SxC3rjAeGZIUOBN9+BRHaomH+z8=;
 b=cx1BRqQBnAE6kLusU/fGmioDgXuHVrJOP2DprVuIOBWViI32FA3eB8Pl7qUpv/lWHy
 6mGm/ea0lnU1X+E4DjWV4A2FZBcoUygbzu8j1b4L0JWLqc1AeVN1TQXpqhXqML9y8kQY
 ckUL4BhMNXyjbNn/UtCWblfjp1el2GSlf4nwfeJLdefLUvBQy2ShMdp3b3UscqRIRZms
 RIZaUcq3/rCdk7q3qnf9VESErOT41yF59Gdwr7LH4vUx4zpgWhkWqSdYzpalwdAciRBQ
 GTCOove0iq23rdkHBM25zwivH3jjbPYJupX2YFvdai/kTXQGCFOI5EVipBf8iOUTBAlG
 irdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW/f0IVMpqNkz/H2onWMqhzjYpOCIa8c6p1a+LaW36tSxUIxe0CeVu1kqc4SkjhNlVV0g7oTaWTyGh@nongnu.org
X-Gm-Message-State: AOJu0Yy7ZlKmgpIVX7mqaZLG4POICSMYN3MpOMIid5wDZX5BoaJ9Vd2F
 fOzdx6r7Jz8QNuD97GflcG+fMRPYSW/VkTekp/ULJH12P81OJEBNjBp1lFr46JY=
X-Gm-Gg: ASbGncvfhkrnc75enBS3d+s12arTYCosfUf4NSW+we/yfnHTOw4CwlVS+r9+hOJFKuP
 Dy/paocusdEm3JzT/dZ3vSjPals2kdMjHmjj8JpqMTPWUdxP036WF0LxqFt8ShncT0i/dd2QRbu
 hna0jRDyVRTzNBkRavvitxZdmX5/DVjai2vTBYUbSAukZvIsvPptjL4THULrfHd6xdf4JznAGHQ
 89dxRxtjp2zVfZzwd0N3v4cS3yHf0NLTo84FJdX4qMHfgfAmg+dG9ZVvzL3pRK6vkY8cBw1zt7f
 I/M0aHYZByHdJPfavRapIjSHfYduaCqq2R8r/FRC3HMO/F8OovIoDJL27Q==
X-Google-Smtp-Source: AGHT+IGbCkwFcnvbvgjiI0FpzcUxshvLULe2uXuxSWfByzQcwn839F54/2Qol24ldyXXBsV6F8SoBA==
X-Received: by 2002:a17:90b:4d06:b0:2ee:ab29:1a57 with SMTP id
 98e67ed59e1d1-2f83abb3553mr703945a91.2.1738097593044; 
 Tue, 28 Jan 2025 12:53:13 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f830a3d74esm589772a91.2.2025.01.28.12.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 12:53:12 -0800 (PST)
Message-ID: <e57a850a-0f1d-426c-ad35-54ea6106f5a0@linaro.org>
Date: Tue, 28 Jan 2025 12:53:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] cpus: Add DeviceClass::[un]wire() stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250128142152.9889-1-philmd@linaro.org>
 <20250128142152.9889-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128142152.9889-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 1/28/25 06:21, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/cpu-common.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index cb79566cc51..9ee44a00277 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -219,6 +219,14 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>       /* NOTE: latest generic point where the cpu is fully realized */
>   }
>   
> +static void cpu_common_wire(DeviceState *dev)
> +{
> +}
> +
> +static void cpu_common_unwire(DeviceState *dev)
> +{
> +}
> +
>   static void cpu_common_unrealizefn(DeviceState *dev)
>   {
>       CPUState *cpu = CPU(dev);
> @@ -311,6 +319,8 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
>       k->gdb_write_register = cpu_common_gdb_write_register;
>       set_bit(DEVICE_CATEGORY_CPU, dc->categories);
>       dc->realize = cpu_common_realizefn;
> +    dc->wire = cpu_common_wire;
> +    dc->unwire = cpu_common_unwire;
>       dc->unrealize = cpu_common_unrealizefn;
>       rc->phases.hold = cpu_common_reset_hold;
>       cpu_class_init_props(dc);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But doesn't need to be split from patch 6.


r~

