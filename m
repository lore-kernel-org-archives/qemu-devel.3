Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E2ACFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 17:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syx7J-0001V5-Nl; Thu, 10 Oct 2024 13:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syx7H-0001TN-V8
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:38:24 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syx7G-0004i0-7C
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 13:38:23 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71df67c67fcso931347b3a.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728581900; x=1729186700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V0mw49V0IXddKlBVbYVhB5hVUmIHEFA198edmByKXo8=;
 b=Kt1sxc+4vNC4QpalVkGoDnnzgtJGKA7fMyPHjVQJZ1+hX3sKmvN1l9CGDN92PjbBEe
 HpPK5Je4oPcbkCOdBzbRqWS6AQ1Tu3FG8RkusG0aSlGqPr82pUehAX/+Wz5KfVGNCxD9
 tb7uy+1s4IYq04d7d/5H01WOcAEw0UO/gIgRmsaGz3lwboqxmFE0wAVVxQ1e/EZCmCtU
 t3/hFIoYhJdP/7jxpohFulPhIZMq9pJkjtqx1k9mpXnN0WXumDU86fswOYKUWW/jEQ9b
 WogEfpZuanuwy4Pjf4JV04rwtzQqpw67IIVuWfk8xPdNBSzcIKNK6KG84d+EgbaPn5Fl
 QjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728581900; x=1729186700;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V0mw49V0IXddKlBVbYVhB5hVUmIHEFA198edmByKXo8=;
 b=Gl/SXlCzzBNkpdC9ryei0pg9MEQpsvG4UqNcwGmXsyyjI7PcnkSGbvPn9TDDR2JmPw
 CkqkbJzH182cXu9kQ0K+mBUYJJ921aM6fqiCRx27lYDhPZlz4ZBc0Ni1y21Vmxltvc1H
 C57Ka3Y2hvhnvGRGAEiRBB0kf/yOph1rDNQhXHfzYg3fkwN9DIiqmTEdNdbh0LqrHLWD
 kUTL5m31IP5iYP/7Wcu4S+joJivRJDf5CbVcy2f+p1DGjs2yCCaMK0IYkJvaH66GPOK0
 RCWgM/W1LhlCJe2YHPOPE0FNdbeRmq85FQFs8E13hBCrXabXjnLcsehkeKQaq0tcmtHd
 zfbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaM7AkQltmNL6tzyChjT63kzzSv+Ji/ZVLLkyMaiCSkn6xXp4abo2UWkRdAGbVxOmEW0k9BqMWyigq@nongnu.org
X-Gm-Message-State: AOJu0YxZSKK56etCbRgbnsx2fMR2wKL3WmJqTH3nc0AipN7mbJjo5KXI
 1uaSuSgczGERQcNwzbXPVDST83orItmNNeFxT1aCvECsbHo0Jci8XgU4CYp2Afo=
X-Google-Smtp-Source: AGHT+IEg6yYRC68vvwTg5aCpUBEtGSxwGOVnsDdCc8ZcCr81GgkjHMJkxR9Nn6u3RA0S/zAfeC/v+w==
X-Received: by 2002:a05:6a00:1ac6:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-71e1dbb570dmr11993863b3a.19.1728581900337; 
 Thu, 10 Oct 2024 10:38:20 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2aa0e02esm1317893b3a.96.2024.10.10.10.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 10:38:19 -0700 (PDT)
Message-ID: <eed14342-3b79-450c-a617-533d3256a241@linaro.org>
Date: Thu, 10 Oct 2024 14:38:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] target/i386/cpu: Improve errors for out of bounds
 property values
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-6-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241010150144.986655-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/10/24 12:01, Markus Armbruster wrote:
> The error message for a "stepping" value that is out of bounds is a
> bit odd:
> 
>      $ qemu-system-x86_64 -cpu qemu64,stepping=16
>      qemu-system-x86_64: can't apply global qemu64-x86_64-cpu.stepping=16: Property .stepping doesn't take value 16 (minimum: 0, maximum: 15)
> 
> The "can't apply global" part is an unfortunate artifact of -cpu's
> implementation.  Left for another day.
> 
> The remainder feels overly verbose.  Change it to
> 
>      qemu64-x86_64-cpu: can't apply global qemu64-x86_64-cpu.stepping=16: parameter 'stepping' can be at most 15
> 
> Likewise for "family", "model", and "tsc-frequency".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   target/i386/cpu.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)


> @@ -5623,16 +5622,15 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
>                                      void *opaque, Error **errp)
>   {
>       X86CPU *cpu = X86_CPU(obj);
> -    const int64_t min = 0;
>       const int64_t max = INT64_MAX;
>       int64_t value;
>   
>       if (!visit_type_int(v, name, &value, errp)) {
>           return;
>       }
> -    if (value < min || value > max) {
> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> -                   name ? name : "null", value, min, max);
> +    if (value < 0 || value > max) {
> +        error_setg(errp, "parameter '%s' can be at most %" PRId64,
> +                   name ? name : "null", max);

Confusing:

     qemu64-x86_64-cpu: can't apply global 
qemu64-x86_64-cpu.stepping=-1: parameter 'stepping' can be at most 15

>           return;
>       }
>   


