Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392D1FD9E2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 00:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvm8Y-0000qZ-SI; Thu, 26 Feb 2026 19:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvm8X-0000pw-27
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 19:55:21 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vvm8V-0004rX-EG
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 19:55:20 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8274a3db5e3so322716b3a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 16:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772153718; x=1772758518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k6k8lxjhfwtbrlz/Id6T7YRNU3IZwy1XnayAk/Z5iVk=;
 b=OBEDLdkV5EDk8IcR1sw7AqRA3NYDJ/3S8Sh8/JA9+p5OljvS9X5Bt8EesXvSfwBQpE
 IDvcZe2E7VKKVJSTKCR79Ki3b7C47pEYX0qzthVjLAS/9vMAFt31BIe8WWySs/c++b2b
 LKm2bIhtL7CPlHeG5P9kqRaCrchBMkQUkIYwTI9pFUgPpyx9avYaFHGe2oMcLGSUF5M6
 gHCPQqL44oEcEAK7iDZv+v0c85fpKFGu7Ld1PaLmydvqGcNAweFmAUYqTdTxWplJ3Img
 GeaSy7vZsl2W/gx0ObkRgeii1kvy7osSchdmGAeiZiM+8TzO3QIZCA9QVOUn8k3zOBSA
 wNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772153718; x=1772758518;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k6k8lxjhfwtbrlz/Id6T7YRNU3IZwy1XnayAk/Z5iVk=;
 b=FXgHiJ3B5W3whuEQQ6rxJePtSp1sKtbmbHYC/G2crE9GgdQAvM5RRCMdPhnSzDMxai
 FoAYQ+EIAmZe+FJUj1M+gp6Ia3B0ZCI0J9EO/RK1iKD6E9eOLDlMlLrHoZULy/EpgXQB
 ixSm8KKY2m+g5NTB5DAaYbcyCvbs3Xg98dx32z+cnv0yk+fsLM/8fF3WlLXtldPBKtm3
 Jzg1IkQUqh53z8RakV5S0yQvYhLsxl3fJkjOSkn4LtDF9PqHi8rEIKkhMDZYh7Rd/bkm
 OTVvVLOJ67+L14GtTYq+cqP2U4B5K8fbJITw+yc2Qs/9xx1OuKzSPDMPUpdFONetDAnp
 YSLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1k7KrVqv13WlFplWGPGAKhtPukrqS4nIEx6B9x8IvgaQYvvK2QR9v9PdRKmE0v0NNrDtekHzeY42H@nongnu.org
X-Gm-Message-State: AOJu0YxvmB9bou29llKe+NAPNg/BURSTd5f7QkuYNK+5fApsLjnZrDNg
 hFpmueZPBh+vRd59l14rHpkFQTDi3X+NqlN3HXQ4sY+NKEJtrSZLDM8aMPGs2HI0i6A=
X-Gm-Gg: ATEYQzykJMjY8UNrIQMq4Ri8iZYebLWM3oa6e+eYHrxLYmBx3tb6R9+ophTImY3BIF5
 xQl13MV/uOjbX3hsonq8Mym17pjv04lUWzMLzBap0mm1SvlfcSOF9kDdWGWC3o/smbkJOVzHEmh
 riKYDYTn7J6ORXTgetBfyfQQlqKmXIrM1ofg5VaBp29s+bbc/62XxLosTccfx+u7tMHgUTpGUgq
 4CaB8YoHMjPVCKVcig04zff8bnxzrBLKFbmz4ZOodINjScY98sKE5jNdlwS/K/hxdibopdpFDON
 ZUcJa/lgjG/U2ZRlpIWhTwX950ce1DSm6jxj/VcrQywkeOqUQPpWNn6VIbAlnlk1su3R4fGOTUN
 SU/2HfEYyssF3VxKlsCWwi729Ui9EiDTFM0SwRHdK8GEn9EejA/vLgf5PonEMoeZB/tC30REZa+
 xyRH1xAD1RmYutROp99CquJq9nWRt9ZVmV9NnWyAVdy//Kxl42iOH8VFPv0ifwEA==
X-Received: by 2002:a05:6a00:194b:b0:823:d04:deef with SMTP id
 d2e1a72fcca58-8274d9f5a87mr1089085b3a.35.1772153717477; 
 Thu, 26 Feb 2026 16:55:17 -0800 (PST)
Received: from [192.168.1.105] (61-68-87-122.tpgi.com.au. [61.68.87.122])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d4dc6dsm3417329b3a.6.2026.02.26.16.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 16:55:17 -0800 (PST)
Message-ID: <0eb7c279-ee2b-471b-9798-f9078c6e3ed8@linaro.org>
Date: Fri, 27 Feb 2026 11:55:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hvf/arm: expose FEAT_SME2 to guest if available
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260226-sme2-hvf-v3-0-ea5763dbeba2@linaro.org>
 <20260226-sme2-hvf-v3-2-ea5763dbeba2@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260226-sme2-hvf-v3-2-ea5763dbeba2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/26/26 18:25, Manos Pitsidianakis wrote:
> Starting from M4 cores and MacOS 15.2 SDK, HVF can virtualise FEAT_SME2.
> 
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   target/arm/cpu64.c   | 13 ++++++++++++-
>   target/arm/hvf/hvf.c | 25 +++++++++++++------------
>   2 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index dec430c48b92a8bf6bb8a9d247c23d5e7edb9c2b..c9991881f2e6cc39c9f3884efafae11bd210ed61 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -340,9 +340,20 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
>   {
>       uint32_t vq_map = cpu->sme_vq.map;
>       uint32_t vq_init = cpu->sme_vq.init;
> -    uint32_t vq_supported = cpu->sme_vq.supported;
> +    uint32_t vq_supported;
>       uint32_t vq;
>   
> +    if (hvf_enabled()) {
> +        if (hvf_arm_sme2_supported()) {
> +            vq_supported = hvf_arm_sme2_get_svl();
> +        } else {
> +            assert(!cpu_isar_feature(aa64_sme, cpu));
> +            vq_supported = 0;
> +        }
> +    } else {
> +        vq_supported = cpu->sme_vq.supported;
> +    }

After the cleanup just merged to master, you should now set cpu->sme_vq.supported in 
hvf_arm_set_cpu_features_from_host.

Compare commit 5b3feb36aec for kvm+svm.


r~

