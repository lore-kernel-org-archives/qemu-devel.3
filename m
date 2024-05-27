Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998DFC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdAV-0005Hn-BU; Mon, 27 May 2024 12:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBdAT-0005HQ-TB
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:25:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBdAF-0004ne-MI
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:25:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4202ca70270so63686945e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716827134; x=1717431934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pHCRB1EKjD0Nhx9Lp4qHLpHLpjYqMbPoKLCmaUHOhBk=;
 b=N6jt3qm9Qwyzvfc590Ciub4socgShR5n73PMq8KPy9LH6QTRKrsXX4Fq9Gbfh2axVD
 h6F44D4G/gW3O3/PMhC7PvGUyRQkHUKkvrvDymsZdlWTi+GY9rdwnZ9nmBR7fCb0c7TB
 r6z34062lf9YeFxr7pOtk8e6whcToeMnf8xQa0RC/MhsDsceIraMdSRbH3nn7tjXU1iy
 A+VPlxTnQ0ivbDWdIR4NzO8rnBByTFCFj7ch1cEG9fAXQes0WAcrNOVS6eT4bTPRix/s
 5sA8yD9BI3qnpwpcuiv0GbDI93oc1mdg5n17g/iPGVjzVt9p4WTztMhtGlT6TcySg88T
 KE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716827134; x=1717431934;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pHCRB1EKjD0Nhx9Lp4qHLpHLpjYqMbPoKLCmaUHOhBk=;
 b=AYdwlpjgVf0Vo5Gw2cDAmPdAQYgvsXwQY99Z70c2fYrSUsh3079cEXPtYSoQBv1BlZ
 O/Pu3Og25qfFMOsVMbU34xROJJxtClqlrPwz2EY/5jJIB7+1oaswUHcNf1E5WDA6EZZt
 /MNoxB1ADTIL7eok1Ge0hvjcpr/AXxJtr2vHoZoZ08Vlg5Ap+ddjNWusX3Qx8xdjWrYk
 h4nwKTHZWS5Jk+7/mIMA/9dYDBG9s1cOt8jI6CHfSLbnL83LkImf0iUX6wIKyQpmMdyv
 FuTFSs4raV1oXB5twAC0kYMtKR05lwxdeJHgQ3/DeK/8IgHKZWf8FGLkMrsiqCX+yZB+
 Wylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVFJT9rsAIaGsFJ+NYutvtu7kv7qdhHvxh2S3NLaawOSGhvwwTFupZiWZhbVXal/xGpiiVKTI9W/EVtvs233ZG1OthlqM=
X-Gm-Message-State: AOJu0YxMJUMYENW61yxsH8mZTqfgysr6TqmhIm43JoYU51I0foPUjUAb
 qMaPdR6sV8KdBZnDTA/+gpRzXf33bj8GGaoh+WDAqbISbVyxECVkVgT913rsjANiGgSqnZhMdyd
 I
X-Google-Smtp-Source: AGHT+IH6WMXwWBG4+mCGuCUb/g8oSTSVIPe9BmZQhyjU+xKoK4iDxbkQ67gIKHpGtUg5mEm1R3VGJA==
X-Received: by 2002:a05:600c:138e:b0:41b:fa34:9e48 with SMTP id
 5b1f17b1804b1-42108a99ea9mr89258365e9.30.1716827133954; 
 Mon, 27 May 2024 09:25:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a08a8c9sm9425250f8f.40.2024.05.27.09.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 09:25:33 -0700 (PDT)
Message-ID: <4025f82f-242c-4c3e-952e-8ecf7a66838f@linaro.org>
Date: Mon, 27 May 2024 18:25:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] xen: Add xen_mr_is_memory()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 David Hildenbrand <david@redhat.com>, Anthony PERARD
 <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
References: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
 <20240524105152.1301842-4-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240524105152.1301842-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Edgar,

On 24/5/24 12:51, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Add xen_mr_is_memory() to abstract away tests for the
> xen_memory MR.
> 
> No functional changes.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/xen/xen-hvm-common.c | 10 ++++++++--
>   include/sysemu/xen.h    |  8 ++++++++
>   2 files changed, 16 insertions(+), 2 deletions(-)

To consolidate we could add:

   static MemoryRegion xen_memory;

   MemoryRegion *xen_mr_memory_init(uint64_t block_len)
   {
      assert(!xen_memory.size);
      memory_region_init_ram(&xen_memory, NULL, "xen.ram", block_len, 
&error_fatal);
      return &xen_memory;
   }

and remove the extern declaration.

> diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
> index 754ec2e6cb..dc72f83bcb 100644
> --- a/include/sysemu/xen.h
> +++ b/include/sysemu/xen.h
> @@ -34,6 +34,8 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
>   void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
>                      struct MemoryRegion *mr, Error **errp);
>   
> +bool xen_mr_is_memory(MemoryRegion *mr);
> +
>   #else /* !CONFIG_XEN_IS_POSSIBLE */
>   
>   #define xen_enabled() 0
> @@ -47,6 +49,12 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
>       g_assert_not_reached();
>   }
>   
> +static inline bool xen_mr_is_memory(MemoryRegion *mr)
> +{
> +    g_assert_not_reached();
> +    return false;

No need for the stub, just always declare xen_mr_is_memory() ...
> +}
> +
>   #endif /* CONFIG_XEN_IS_POSSIBLE */

... here.

>   #endif

Removing the stub:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


