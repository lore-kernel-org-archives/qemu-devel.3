Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0A7C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWwh-0001yY-TR; Fri, 07 Mar 2025 07:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWw2-0001Uc-69
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:36:18 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWw0-0006l5-BZ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:36:13 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fec3176ef3so2717330a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741350970; x=1741955770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Svi8si5AgIWAzn8KakdjibLEMeLRU22Y0nQmKDEIb8s=;
 b=m9jrpaBoaVLfBWgXuc25MtLVJA2LmEoPc2MWfIg3sMJucQSVSqQLjMzbWKnmMNo/ce
 UuZBP/4bPrwztHuToFcJWmEEHv4varGPv1uxbeRK6v4RvXSqxJ6iBFbVlbOXMjo+HJpI
 JNQoA0l2ad/7xCP5g4r4Q/kONYNbRzZsePRvLtSv0s6gwIIS0OnaaSAQ7v/wfrSpQW2f
 pMe9F7Fkwzr8CbLuJMD+dteheuCt+Gs5DTZLczIcqTLf8P9sOSeZp0LMzxA29tIXkkCN
 c5s6OokV1d1iOnHQVta086Fcn3+cUousZX+A8R5kCqWQjyzvroOxjg1t4mWwxDEYBees
 7QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741350970; x=1741955770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Svi8si5AgIWAzn8KakdjibLEMeLRU22Y0nQmKDEIb8s=;
 b=smsAHV7ejAEfjht0zNX0MiOYoToq+oy9+C8G+w2ZPETwNNksmhJa63ftNhFtElMDfy
 LnxE036/VvOAQGGUTOIXW5X6mg2QBySLz2L96Sce8xrYr6E52fqSu2a1YoXMO2SrB7l2
 uFf27CvheZtQtTp5yonBMw/g+kYMbK8IuBJ9EPVH91TxzdD9SLlrfZPP9aHrqD5/OI8b
 wdTWfSSJDT2xUnRsycYOBriBFokOqUmdMeI4kyHj3lJEP1DqCCTHTvptmYWZ5S8f7uxB
 MdZo9eIeVD25TwbyGTNFM+Zr1NhDK6vVFRLNjq/DG1XEAm+miwdNAsGjbwRAm4OM8Nz5
 2HRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuZMGOcuixvWYBkL6f9ftO29g3tQ2J4LDYPhhbb/31/B2Vz1nBVn1jL6JfkG8kNfyYBnyNVitwFNxU@nongnu.org
X-Gm-Message-State: AOJu0YzHo+3AYO+O5osVpJ2vgJ68qliPxpe0ff14/wv9Ldq08F/svo2m
 bZSMsZn3Yj+jmdlfrTRneRURSpyRRoL+/eJwUtSpPpaHFBOSpVJ/MgF/s0uXeJQDcJ8pNQD8qfc
 j
X-Gm-Gg: ASbGncvQHhm1a9nxFBM5mSZvifp5TEmi7JleVkITauj40X8aotzfyFw8/hS411ADIee
 NoNUfPIOT3lQzl1ECNKj4e8sTYhbGQQJm+9jGcHfnZn+8K/Sk6DWKk7Lxf+oMWWqoPhRXKPOG+l
 qI0FMYvmKEz4iJfGBNibSXxA70BHO+LJ97R3eIGWnYQ47gZPlPIwPmTKDwt8TFfCS4zHIuel5+G
 g2p2mhmGaOwvDTEFbEbUMbloT6R8TwnT3Cpooe8+w+Z+lL/BM4WFGL6FuQ3CF0eDEbxfnWowWE+
 Bz5H3eorh5EZEv0G7ibsbFrXTWn2cj8veiFNhvXjfMe2BXEF/Zb0CDMKit8=
X-Google-Smtp-Source: AGHT+IEKXaHmTMrBjbpVdUm8g7ch+PMR4TdGjjkAbeZQhgn8pl6/jPFVXj/lpiR8IDl/NunmMB7bhQ==
X-Received: by 2002:a17:90b:3d8a:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2ff7cd44ab7mr6228811a91.0.1741350970567; 
 Fri, 07 Mar 2025 04:36:10 -0800 (PST)
Received: from [192.168.68.110] ([177.170.118.40])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693f6bd8sm2929537a91.41.2025.03.07.04.36.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:36:10 -0800 (PST)
Message-ID: <043c02d4-d973-49da-8521-77f17f25c860@ventanamicro.com>
Date: Fri, 7 Mar 2025 09:36:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/riscv/riscv_iommu: Remove the "bus" property
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250302091209.20063-1-jason.chien@sifive.com>
 <20250302091209.20063-4-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250302091209.20063-4-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1033.google.com
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



On 3/2/25 6:12 AM, Jason Chien wrote:
> This property was originally intended to set the bus number for non-root
> endpoints. However, since the PCIe bus number is assigned and modified
> at runtime, setting this property before software execution is incorrect.
> Additionally, the property incorrectly assumes that all endpoints share
> the same bus, whereas no such restriction exists.
> 
> With the IOMMU now retrieving the latest device IDs from memory attributes,
> there is no longer a need to set or update device IDs.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/riscv-iommu.c | 7 -------
>   hw/riscv/riscv-iommu.h | 1 -
>   2 files changed, 8 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index b72ce8e6d0..1ca85b95ac 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1197,9 +1197,6 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
>   {
>       RISCVIOMMUSpace *as;
>   
> -    /* FIXME: PCIe bus remapping for attached endpoints. */
> -    devid |= s->bus << 8;
> -
>       QLIST_FOREACH(as, &s->spaces, list) {
>           if (as->devid == devid) {
>               break;
> @@ -2261,9 +2258,6 @@ static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
>           return MEMTX_ACCESS_ERROR;
>       }
>   
> -    /* FIXME: PCIe bus remapping for attached endpoints. */
> -    devid |= s->bus << 8;
> -
>       ctx = riscv_iommu_ctx(s, devid, 0, &ref);
>       if (ctx == NULL) {
>           res = MEMTX_ACCESS_ERROR;
> @@ -2498,7 +2492,6 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
>   static const Property riscv_iommu_properties[] = {
>       DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
>           RISCV_IOMMU_SPEC_DOT_VER),
> -    DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
>       DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
>           LIMIT_CACHE_IOT),
>       DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index a31aa62144..655c0e71a8 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -34,7 +34,6 @@ struct RISCVIOMMUState {
>       /*< public >*/
>       uint32_t version;     /* Reported interface version number */
>       uint32_t pid_bits;    /* process identifier width */
> -    uint32_t bus;         /* PCI bus mapping for non-root endpoints */
>   
>       uint64_t cap;         /* IOMMU supported capabilities */
>       uint64_t fctl;        /* IOMMU enabled features */


