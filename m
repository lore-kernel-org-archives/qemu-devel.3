Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23413C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 10:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsJ2K-0004Ug-78; Wed, 12 Mar 2025 06:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJ2E-0004T5-MQ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:09:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsJ2C-00065Y-DZ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 06:09:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so4872016f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741774194; x=1742378994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/gYqu0M+CR9SR4Zc2eKOzFtLtrstSCUxdQBwmDow0e4=;
 b=nD2/xP8csgyvJeLvUCFjiedhkYCr8oHDbVw1pQHBVTCZpx12iEQ97IudBcB+AbBQMU
 0+6FtQMHljD9E7pLmXEBW2gW7eJDxue/YOCoEfQgO91TsYpJ+H7W54rRHUMVdAzbVKUQ
 yJsNGfYuJcQq5sRFQ8wXNMPg3sErspRUHCtOB/b79WXoUC++wVnIKozIjjUOReok2bKt
 lQLaNIbR1rMlvah/UCLz4ofwEH7EnZUaXrVY/gf+bjR+tJU+NDcEp58W24v7WRPVTrFF
 8Acj6Tuvnk97f/BmMrrmcv+LFYidJ4i35HnucAIgj3DdVVcDHNZ6wsyzwOpCxxp+YQLj
 iHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741774194; x=1742378994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/gYqu0M+CR9SR4Zc2eKOzFtLtrstSCUxdQBwmDow0e4=;
 b=Xwm7ZEYfX84dizfJkG5cEYQv/ninOogBRfMk0Zl7yhAveZHklt/oh+8sifRIK8nfwt
 1zK99A6b+Lo72G8YTjsE76v5N4rWu0skTgHSuNlJfiO5KhSyOp364pjBfjJb4dTO2mtY
 +dT0WTyo+UhYqXTO9M4qNhiJxANRKY+J+/Y7j4lVfVht53HUqoMW39RGlbGmT7CkLaRU
 E1cKyRfJbpQqsMBdbtwyf+lujRGF6iUwmU/vSNlHVOEX8Ke8kpNmIeBHE8kaPwguEwvM
 bPd834upZA7zgbTD05ZwmQ5gvb/Kz8onp8fIJeWalDtZ0WYEJvCQ5+s+f8m2YpQHR0oA
 EKBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoCzo6ukzlcJZYp1YKn8ZTqjHF545soqKZn0GpE+fXf9xVKDxEFv04crRKXNh4CmQ/2RGZ9mi97XM5@nongnu.org
X-Gm-Message-State: AOJu0YwhcmInEwFTkpu+mNehZFTL0OmvsR0oVQ8ch9HvL4BICs5sua0q
 WyMk3vUIAMJpqiKl082+83dXB4vDtq37FrGytzn9DH5DhYhoK1omPXRqQCx68jY=
X-Gm-Gg: ASbGncvxXTZ4BVzzl4RBNNWrJrurOaWfonvsKJDNtZfx1I1SP2ln3ss+vkFNcsFuBaA
 kjyhbirlgkBpSqzJB74vU5khYsSouEPbb/IyBOpbxUK0sgim8uAdNDNyVcFIsfQAx9MVqbnp5WA
 km3hrRA1o1XT6wN4R8hU+u40WtY6l1RplXZdIXQyMnTg76sbd9nAJ1260h8uGDWcoHUxbATh+U7
 BoQWSfhpC3Ermg/Xnb6rRMmWzf0D4EhxoxxzfCraKaVnpY2dj8GJiDa7hAxB68Wk+oFullHXN6V
 IEAeNVjeDz9xpkABH3tlSik74Ff1p/GmdcW1IA0NRaPoupLkg0iuBUuTUG62mxi2DPuVNDHrSej
 Ye1YCLA==
X-Google-Smtp-Source: AGHT+IGZ438rh1zLwFpq9IZSHi29YR1nhgVwNp4GGwJQfXEHwcfOVm8FkN4w5e3I64/UIJgocvFhvg==
X-Received: by 2002:a05:6000:402a:b0:390:ed05:aa26 with SMTP id
 ffacd0b85a97d-39132d30c22mr15449673f8f.5.1741774194337; 
 Wed, 12 Mar 2025 03:09:54 -0700 (PDT)
Received: from [10.223.46.213] (99.167.185.81.rev.sfr.net. [81.185.167.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015c2csm20178494f8f.49.2025.03.12.03.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 03:09:53 -0700 (PDT)
Message-ID: <408efa3d-bd73-47bc-8723-08c805df6815@linaro.org>
Date: Wed, 12 Mar 2025 11:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: fix default cpu for pre-10.0 machines.
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250312055804.2134569-1-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250312055804.2134569-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 12/3/25 06:58, Harsh Prateek Bora wrote:
> When POWER10 CPU was made as default, we missed keeping POWER9 as
> default for older pseries releases (pre-10.0) at that time.
> This caused breakge in default cpu evaluation for older pseries
> machines and hence this fix.
> 

Should we also include:

   Cc: qemu-stable@nongnu.org

?

> Fixes: 51113013f3 ("ppc/spapr: change pseries machine default to POWER10 CPU")
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   hw/ppc/spapr.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c15340a58d..b31a91e2e2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4748,6 +4748,7 @@ static void spapr_machine_9_2_class_options(MachineClass *mc)
>   {
>       spapr_machine_10_0_class_options(mc);
>       compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");

This is confusing because v9.2 has already been released with that...

>   }
>   
>   DEFINE_SPAPR_MACHINE(9, 2);


