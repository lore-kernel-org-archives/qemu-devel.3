Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F419C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 06:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uceFP-00018E-2N; Fri, 18 Jul 2025 02:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uceFK-00014Z-I6
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:07:02 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uceFH-0004Jy-8k
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:07:02 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so1097403f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 23:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752818817; x=1753423617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b9w+VOmtrDkzwqwfsAJHUFRqgXBoAXodiO5gYMhKLlQ=;
 b=yO2IITh1dSfpOlXYJNz4OCv6Xv7n62LNQFQUKhgVbh5moIG6ReucMIL/3UpFIx0S9M
 +vbWerZTpw9yMoTg0izJl7UrGQnx45gj6OXNEC3w8ZfAGJ2L4qwmhOPbja3aLeQwYjdV
 emKmz99nneu3VE+rMQpAk9UCum7Cg5Sk0bLBfmQexZ2kfg4zlq1QW0sN3PKN64xV3jqW
 x6Poi+nFdgyoOciZgc1wlq1tAUhPR4R3aE5DmPqhIYOGXqVgLH/xsVUU8nvGWuhCx2Di
 I+HcBC0HguD/B+H9OF1KsD+IMkrkPP34+ZDZKJgLFnnYFXP7S+jucaDvgjLRxCHbRNVV
 GdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752818817; x=1753423617;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b9w+VOmtrDkzwqwfsAJHUFRqgXBoAXodiO5gYMhKLlQ=;
 b=nMvdQdIxqTPaUxqJym7tWaDpAZBIzOc/0DBrhtY0g3zRY3yQinNgAlEE8AJFvYyAjc
 iMCwXiFpMyIGNKBdrTYw/chfrGWytYe6n2GlK5fs25glns/AAIuU9Qwsu3UG1nMhlh4i
 DFYVGn6tGplHHm2H0EGaH+QviywMTvWkbw4zHWoELCzqgBXig6rmLElp5NsO6H1U31bY
 zGp5kskk9+AfZejSfqfwM08R5mdo+466a1nLbx/RHvP+ls3p2XGuVzN8RyaDbPYW8Fyt
 torR+Q5DeoYEFOiVIwNgq1SdeSIySMv5Y6sgIm/vim4A0OVhsZdA7ruSceQ/ALl2vay2
 bhbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzkNnWjDgyiCfj3+VQRINAp3oLgB9bBOdpXt6YlNjLzxWdFXNpTcUkjSAqOR58V9O/2/IOKmvhl53R@nongnu.org
X-Gm-Message-State: AOJu0YygToqDXSjLP5XbyuIicmC3EtUd8C0/vdr+XFcIITgkJoL6Uh6K
 CBoFkqt1PjytVKkn0BFsOCER6DrEOE1L5wHLR2rPYp2vzOvU+3dkYNrLgjt9DsMG5xU=
X-Gm-Gg: ASbGncvv3yd05kPEeaUAfhkgAqvfVTMRqXRDmlg0X/qesAy6Lgexl7K7IarCZ/0olZs
 qzYRjn7a7IIIrFBNCc3GkYHBezrdQLqBuszFraF9i99x6sPxbx1QvGYS8qTxL3JCI2eKKmpFAGA
 NkUtPWawbLAftLhsiBRYS+HFdMAUOHBC8keqTlWeeu1+6bhqThx+YtK7t2++zMMr8LOt108oFNZ
 9su0cUuefOLrWx0V3iJ3XWo5pqKlThyRYKjgSFNpKCLjYnYkMi+ENPD6RFmVGSs2hbeP+4OxLOn
 03eTiAW2VXUneEvuWzH4Rg1FSbbdDXcL3dabquq7GC9VuKzVikMJ0MWthoR2BySV/hTh6mx3YIQ
 SArkXoraWV6vKJMZhz+J5Cq51//nyo2dQGzqKV9ZCvrI2IyASShq6d17C8j9Uj9pVHg==
X-Google-Smtp-Source: AGHT+IFuIR0PozaALdTktz0RC8fIYccw/jRyKrsINSs9PajgDaDaQtkTrrCuNk3pzOOO6fTxnqSLag==
X-Received: by 2002:a05:6000:701:b0:3a4:f722:a46b with SMTP id
 ffacd0b85a97d-3b619cc0dedmr1454189f8f.15.1752818817489; 
 Thu, 17 Jul 2025 23:06:57 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e7f4294sm69297695e9.3.2025.07.17.23.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 23:06:56 -0700 (PDT)
Message-ID: <5beaebe8-f5b6-4910-b648-c9d60c8c757c@linaro.org>
Date: Fri, 18 Jul 2025 08:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: remove `inline` from `smmu_iotlb_inv_vmid_s1`
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, mjt@tls.msk.ru, whollins@google.com,
 jansene@google.com, jpcottin@google.com
References: <20250717205735.2345674-1-rkir@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250717205735.2345674-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 17/7/25 22:57, Roman Kiryanov wrote:
> this function is declared in smmu-common.h without
> `inline`. It is also used outside of this file
> which causes linking errors because the non-inline
> version is not generated.
> 
> Signed-off-by: Will Hollins <whollins@google.com>
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   hw/arm/smmu-common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index f39b99e526..0dcaf2f589 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -319,7 +319,7 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
>       g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
>   }
>   
> -inline void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
> +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
>   {
>       trace_smmu_iotlb_inv_vmid_s1(vmid);
>       g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);

Already posted (but missed):
https://lore.kernel.org/qemu-devel/20250214072029.515379-1-jansef.jian@hj-micro.com/

