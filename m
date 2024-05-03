Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202FDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2oWA-00065P-Jv; Fri, 03 May 2024 04:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oW8-00064r-FV
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:43:44 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oW6-0006FE-Rb
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:43:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34d8f6cfe5bso2475268f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714725820; x=1715330620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e5n6xiekzPtwoeW++o5yLAXJS0ob0+4JFG3O1yY727U=;
 b=mkfqpdj+/12MPtgDvEIRNBHgunGPmzK8hVAjZ5DzXKUynZnhUD99bflGzPaZBAh8IQ
 1FNeOt9GPGIUBatiqcEIHqUdnsnLCyU0oltVYQSq49J+eNRPB7MWny0J9HyMfwXGLLQB
 WzkpYm2naCPSp3Ltyl7Cwir5NmYj9Lwinf6Lj5N1xqlIrDWxV5QtqSF/ZswGA4LhAd5K
 IfKbg88RHeIMIVuLczVawQD8tqiobCZv+/KD2c9vuW/oMEfx0CeFKccAoH+ahQpIPD6a
 swgZuR4v2EBj5gAdMv/cJfc5JCeVM6UP1SbTOcxFKPgf/j6VlU2it5lKjuc6MIzOxpsd
 2KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714725820; x=1715330620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e5n6xiekzPtwoeW++o5yLAXJS0ob0+4JFG3O1yY727U=;
 b=UhyACJ14UpU9/daTFwE/LGFNmWhMhWoIr/zUU+2TDqfAD9gS6qN3JGhhrG4xuKpUfD
 uc5pILZWwX9+8Z5eCbC4CaTlSRLfSeViPW24E+ijqpM6FCVlKsn0UD5ShPOeOgxZ51Wz
 r98NYUMUZqa4NyVe1juSlpFqbRzJkM7SKLX2Jd2/NFClHqsKdGfEjCCZHEfXcaRgxDvs
 lnlalais0OcZtul60X89dpMM0d78imi/yLkgm1zR8RAhsOjwdkmE8cOyGQEymfq0ZSEQ
 xo6Utxe1HxcHmSzOXIp6Jk2PzB3GgigUNQlrnbzRYazvkohagpjqoFoyoYj/KnL3WIz/
 /M3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZIWo0M38C1uINoVK8uMP+KufA9TF7i9um34Vjs3wwVuLhnVfn1T9e7dHunfCqK7uEcS3whwuIZKt0cg+x+kAR7DbtTfo=
X-Gm-Message-State: AOJu0YxObWsIo0TD8vBIKvPQFIApwluk1Putrygt/2fV4GH7i3tehBF5
 4DYcWyOWifoQ3ZYxSOjMoafIoplDdRL6CdnS2hkbB+xwu4uxBXdZR7F/iuV1u1ougdXjBIuxWGd
 r
X-Google-Smtp-Source: AGHT+IEOAAy06yk9ykUtzNoLcenpIBMkZMdxTMHz/FLyRFWTTL0f8TAibfsKeuMp5VIDAQbFt31/Ow==
X-Received: by 2002:a05:6000:87:b0:34c:5f6e:1720 with SMTP id
 m7-20020a056000008700b0034c5f6e1720mr1500323wrx.60.1714725820186; 
 Fri, 03 May 2024 01:43:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 dz1-20020a0560000e8100b0034ccb43dbbbsm3195537wrb.38.2024.05.03.01.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 01:43:39 -0700 (PDT)
Message-ID: <27024999-170b-45b5-aa13-9288b950b4a7@linaro.org>
Date: Fri, 3 May 2024 10:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] intc: remove PICCommonState from typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-7-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
> Move it to the existing "PIC related things" header, hw/intc/i8259.h.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/intc/i8259.h | 2 ++
>   include/qemu/typedefs.h | 1 -
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
> index c4125757753..1f2420231f1 100644
> --- a/include/hw/intc/i8259.h
> +++ b/include/hw/intc/i8259.h
> @@ -3,6 +3,8 @@
>   
>   /* i8259.c */
>   
> +typedef struct PICCommonState PICCommonState;

I'd rather move from "hw/isa/i8259_internal.h" to here:

#define TYPE_PIC_COMMON "pic-common"
OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, PIC_COMMON)

struct PICCommonState {
    ...
};

Can be done later, so meanwhile:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


