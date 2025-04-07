Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4622C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 17:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1px2-0006Rc-3K; Mon, 07 Apr 2025 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1pwj-0006M6-GC
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u1pwg-0000eJ-2E
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 13:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744045656;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYx00fL9p3RfzTeWpSCN7DRF/JOCgoJvvZoYrvR1YSI=;
 b=be/gkqqtZIL3chx1NwneVNLsPXtKQs1dXoUAj0wEwYhryHBjO6bfPAJtcVemgoNh6H/5RD
 vzk5/aYaq53+iBdg062VpwR3Wp2z22/5zM7lvBGKvvh0HSH/vbEhNY3zgIHmPYoXGjVDgA
 5qMSRBDFiMm5rIZ4oV9mbhTWIQGgfew=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-UycLL7yXMsStTB7KzRwtKg-1; Mon, 07 Apr 2025 13:07:33 -0400
X-MC-Unique: UycLL7yXMsStTB7KzRwtKg-1
X-Mimecast-MFC-AGG-ID: UycLL7yXMsStTB7KzRwtKg_1744045652
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso32495835e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 10:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045652; x=1744650452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HYx00fL9p3RfzTeWpSCN7DRF/JOCgoJvvZoYrvR1YSI=;
 b=X7BawsDfscvH7TzknKTNCyjSslHzm5GI1tmuW2VXp2+ACd8uRzRHBzlDZZ6S8vrMrd
 fmBs/a2+PXJ19FpQuu3Gs0zvnxLojriqAR2oUnl+yKMQ969Nc3xYHp5uBsDutNJDVdsA
 /L/fBheB34ffZtvFMcNqxZQOJJrYWf7raSQ260Gw83MnCBiO+lauN4uxvvW5dHXHK9Gh
 czo5JOP21D2yGAhb2wamsKTns58JIF1d3q+Nl2WT+HLSq8afilvxrUYFpk2yB0E2JgBu
 H11f2OVFsATFfruYXZRU9kksuucxpZ5Nwx5HkJ2hxFGKbCSalw7XfEYih3vBF16XtgJJ
 zkjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKKv80ZYKnmQ2kqB5/ut+tKPfNSrGC2yxmbAWuZkcnCkNppsSPim+fCunwBApI03y98JtS96fUWKCo@nongnu.org
X-Gm-Message-State: AOJu0Yx7Zcwk0QN6hHOfqleVkVbMwlifMGnsvete7RGc/drVZ4scbfkQ
 t2CLuEboLhJo19Pr0cJ8IDUVPXKoMLs5E16mAzRjnCZPnROdO5uPHxx3EprljtggFVMpXdVtDUq
 WN32GY6JgeJo7ygqGM1+MyhxqkKNIEz0xyCmANBY6AT1uc8FEwMcL
X-Gm-Gg: ASbGncsKLJnOwuavYttlsrgihsGWu4qJzTtQpa6BGMW6onmqCT91z6x+Tup88o4J5ZE
 4PseP2k9llsXa3uBAsiexcu1pt8CU0d7M2ZHzkOZX59NxeUSV3U/WW1Vi4v5l+eaMEqXrCMhuhp
 ZdQonkzimD9jQfUttEj/v+Nw18vCeJOZA+oG7WMqrWUrXrgM31Rz5Of7ynWFpvUmUe1hJz8c31L
 6MlszRzfQndpilx+u5d+K+qgMHBG7nBDAhUFd4r+v/g5RaH4d/mQHNYOL/G0PKAnf02K/8umTZd
 IKgihCugCMQCrz1fazbIukXzTNd238bQusaQpVb7DqcfP6M1gKGRM1kMCAPoqcg=
X-Received: by 2002:a05:600c:3103:b0:43d:300f:fa4a with SMTP id
 5b1f17b1804b1-43ecf89dd3emr136726175e9.12.1744045652462; 
 Mon, 07 Apr 2025 10:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTxRJaAKmZS4FVHeavpnCtqRF9n+PEcwzV2Mrjbp6ceZ4zVHUMy14Qq4WBCU+9FeowyNYzVQ==
X-Received: by 2002:a05:600c:3103:b0:43d:300f:fa4a with SMTP id
 5b1f17b1804b1-43ecf89dd3emr136725765e9.12.1744045652047; 
 Mon, 07 Apr 2025 10:07:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a8d67sm136321765e9.12.2025.04.07.10.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 10:07:31 -0700 (PDT)
Message-ID: <a66d6212-55bf-4d34-8e98-0e0df1a96da0@redhat.com>
Date: Mon, 7 Apr 2025 19:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/6] target/arm/tcg: increase cache level for cpu=max
Content-Language: en-US
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: mst@redhat.com, zhao1.liu@intel.com, dapeng1.mi@linux.intel.com,
 armbru@redhat.com, farman@linux.ibm.com, peter.maydell@linaro.org,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, jonathan.cameron@huawei.com,
 jiangkunkun@huawei.com, yangyicong@hisilicon.com, linuxarm@huawei.com
References: <20250310162337.844-1-alireza.sanaee@huawei.com>
 <20250310162337.844-2-alireza.sanaee@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250310162337.844-2-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Ali,

On 3/10/25 5:23 PM, Alireza Sanaee via wrote:
> This patch addresses cache description in the `aarch64_max_tcg_initfn`
> function for cpu=max. It introduces three layers of caches and modifies
> the cache description registers accordingly.
>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  target/arm/tcg/cpu64.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 29ab0ac79da9..1405506594c2 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1086,6 +1086,19 @@ void aarch64_max_tcg_initfn(Object *obj)
>      uint64_t t;
>      uint32_t u;
>  
> +    /*
> +     * Expanded cache set
> +     */
> +    cpu->clidr = 0x8200123; /* 4 4 3 in 3 bit fields */
 /* 4 4 3 in 3 bit fields */ was not obvious to me at the first reading.
I guess it means unified for L2 and L3 (0x4) and separate I&D for L1
> +    /* 64KB L1 dcache */
> +    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
> +    /* 64KB L1 icache */
> +    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
> +    /* 1MB L2 unified cache */
> +    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
> +    /* 2MB L3 unified cache */
> +    cpu->ccsidr[4] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 2 * MiB, 7);
> +
Out of curiosity how did you come up with those values? Is it an
arvbitrary choice?

Thanks

Eric
>      /*
>       * Unset ARM_FEATURE_BACKCOMPAT_CNTFRQ, which we would otherwise default
>       * to because we started with aarch64_a57_initfn(). A 'max' CPU might


