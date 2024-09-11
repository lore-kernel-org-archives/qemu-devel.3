Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1653EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE8a-0001cd-Mw; Tue, 10 Sep 2024 23:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE8X-0001KU-Ja
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:35:21 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE8V-0001k2-9G
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:35:20 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2d8a744aa9bso4002800a91.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025718; x=1726630518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5N9T/wKfpyPt0i5OXILcBzPVYCYnZwZ1/Blqe2hLP0U=;
 b=lHgZXzbiInrsPpMlBRatOnqPE+MLaxQmU6E3ktJxZGlRhxD5LC6tyfgHEEpoHsESum
 UrrJFmMl39JGaFbHfDUBALOFY9m95RVcufSUKUNUydaezKCce6BODOP6XECXbEkQ53en
 FiCSNHDKQnyNrKSc6EskvwGw04qFgpiR8o1p/iYukd2cWPsSMvcUmSV9qFNCEW16kDWd
 cT4frYJv3/J76VeHps0qflsLm5MHkdJOGA6+897rMQhve3yqTj/8cAxmSWoOjhiUdAm5
 Re21LIdJ0O6KdFOet3VHs3PuUS/mjgGgmlzwonFJVH6lxDZI0DGzPmY5VzodMDusUCp9
 a1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025718; x=1726630518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5N9T/wKfpyPt0i5OXILcBzPVYCYnZwZ1/Blqe2hLP0U=;
 b=EFuAhaSj2LqSI2WRxVEcjhtCAPWvS/zdkyEVbNJgapM5jsLhfxFwOCiBGWhNu5yn9Z
 Wg8cZAmnbKpX1Ozr65FBZbbJdzLwGsDQz+r8bSmqRU0Ms6F3oDtc+pmhFzZ30/lVM5F4
 tV8VOX0QMYGUVXaqmsy+vJkEFXu3XcTLINxaldNdwp0ET6i54McgVTnNRMgQlNDuP2pV
 +23Dj4RJN4KD9tfiPr3AE2qLMXNHN31TKX5UPBofbRZlSvYIqIqxeEiyT0DC9bm74Gw4
 xXmEfL6vcjixIno0fV4VJ/0agqhiIirswuBiSQnr++EJiVLLbMzJXBlQi0JxWXCqOZoh
 uNfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtLJaQXZ4qGVsD/9jxgxGvpxMmo+wufKwAgldREQ652s2IW6CPN/mys1N+ejdGGX2zjnhquxwu9Upu@nongnu.org
X-Gm-Message-State: AOJu0YzgeLO/DJklOdhH1YpVeYas8j6LaJCUWfEReMBiPx9Y3zplGdKA
 ZEbeMYumqw13yHyG82dkVWnKxyhTGgIBCzN/Ljj0tADi/7ROD1etTp/JhXMb4EI=
X-Google-Smtp-Source: AGHT+IHeBD/+MBSCIDMVQ1L/lLrVJTXH+l571XJPaBXWgqzapNyKRdRZZVkJD9IhvzVPcfQQj1vhAg==
X-Received: by 2002:a17:90a:4a0b:b0:2c3:2557:3de8 with SMTP id
 98e67ed59e1d1-2dad5119783mr18067836a91.33.1726025717793; 
 Tue, 10 Sep 2024 20:35:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc1104b0sm9321396a91.40.2024.09.10.20.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:35:17 -0700 (PDT)
Message-ID: <97657958-aeab-4899-83a2-4e57cb51fc4e@linaro.org>
Date: Tue, 10 Sep 2024 20:35:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/39] tcg/loongarch64: remove break after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-39-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-39-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 9/10/24 15:16, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index 5b7ed5c176b..973601aec36 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -650,7 +650,6 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
>   
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   
>       return ret | flags;

r~

