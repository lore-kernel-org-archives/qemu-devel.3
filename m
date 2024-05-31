Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1A6C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCx56-0006K9-L3; Fri, 31 May 2024 03:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCx55-0006JV-08
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:53:43 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCx53-0007pa-9R
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:53:42 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6269885572so337347166b.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717142019; x=1717746819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XbXaXxPiGMdCT/Gsc3w/U3K30kDtmtzKDlwzk58XY4Y=;
 b=TXvYhSwM8ZcxZfw9ujDx5fKxIl+OGBcfc+qjKCv29Bs2XMsSLq+NgUaZLi57/NR04v
 TF2rD2R0Zc+zAem/4bdVqFSh/VGpDwLYNq/x+gICa8dBVUtYSbjd9r/ZXZAJAzL69fnJ
 lmUL84mrxbHRTi77hHealZO6ap/o4dOeaSmy1yE0FfMG7mp/esVbKpoyAsxR6VNXva+8
 hjZsdaH1a7U1zC9IvWyuc1vRGB31QyL/cgNJ6G5V4sAfZ+CxWiigUv9fr5NEO9s+tr49
 N8Ha2FeLq/vfg33j4XyiH8eF3Q8s7qmBHv6qILBDKv74xCoVzyZlu5jbvVlJ4OYFqKlo
 F1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717142019; x=1717746819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XbXaXxPiGMdCT/Gsc3w/U3K30kDtmtzKDlwzk58XY4Y=;
 b=bmmKMXg3vDEcYnpOm44cW+3hRJCX2/EVq/YddPLxqVfC2rhbJgKukad9QU9oB06xJg
 bpaboQjlWvgv4WAJEsBwZIUvbVQjU2kZT9b0P9vMOapaYSBgD057Tb0n+Y0IqlE070Dv
 Hb2xjW+IdU6foCLrUDqA1juB7HZvums1Ar8BVDRzyytqsZmk3B4dlJvl4c84eBaJTarD
 sMi7hZN3CpUca7GoK84BFj2lN1NjgeYSAx42Mb3VSPe+6w7ruqVvt5ypoROTaKFNGE0z
 2QVXvPeQMLeO/LsdKHf41SWw4hM27KvIvyZtfVYfQ4NmEvxhGH2WZuRGQP9TuA3lM+u7
 cvzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPtS26LJT4o70WTSGyLGeFJuEXgjwHWedeqlU8N/ZcJX3feD0nzC396Z5jx65Bs67IBYN4DGhnILqRO+XFOt5sAI/jdwo=
X-Gm-Message-State: AOJu0Yx8mfTRvxrvSauIfONwER97Z8tVLaX01kGH963n7JHHuRxnDU8t
 ycM4HU81N9Mv7yKtrz72Nb60WvlP3HroI9OsRpEdUrfn7Gd8GAN8KqVmOX8Z2P8=
X-Google-Smtp-Source: AGHT+IHBrmXYoElIsDVHgfF4SK132dDJUYpyAJkEJaOIJh6aLd2yuVbKRinSdH6593U4w1cNRLCD1g==
X-Received: by 2002:a17:906:e907:b0:a5d:239:1a59 with SMTP id
 a640c23a62f3a-a65f0911017mr360576866b.3.1717142019265; 
 Fri, 31 May 2024 00:53:39 -0700 (PDT)
Received: from [192.168.69.100] (sml13-h01-176-184-15-35.dsl.sta.abo.bbox.fr.
 [176.184.15.35]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eb34449bsm57479566b.213.2024.05.31.00.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 00:53:38 -0700 (PDT)
Message-ID: <3ec04dc4-f837-419c-b83a-b82a484ab5df@linaro.org>
Date: Fri, 31 May 2024 09:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] backends/hostmem: Report error when memory size is
 unaligned
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, imammedo@redhat.com
References: <cover.1717140354.git.mprivozn@redhat.com>
 <58295d1f6c995c0c444e375348436e799689126c.1717140354.git.mprivozn@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <58295d1f6c995c0c444e375348436e799689126c.1717140354.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

Hi Michal,

On 31/5/24 09:29, Michal Privoznik wrote:
> If memory-backend-{file,ram} has a size that's not aligned to
> underlying page size it is not only wasteful, but also may lead
> to hard to debug behaviour. For instance, in case
> memory-backend-file and hugepages, madvise() and mbind() fail.
> Rightfully so, page is the smallest unit they can work with. And
> even though an error is reported, the root cause it not very
> clear:
> 
>    qemu-system-x86_64: Couldn't set property 'dump' on 'memory-backend-file': Invalid argument
> 
> After this commit:
> 
>    qemu-system-x86_64: backend memory size must be multiple of 0x200000
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   backends/hostmem.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 012a8c190f..5f9c9ea8f5 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -337,6 +337,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>       HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
>       void *ptr;
>       uint64_t sz;
> +    size_t pagesize;
>       bool async = !phase_check(PHASE_LATE_BACKENDS_CREATED);
>   
>       if (!bc->alloc) {
> @@ -348,6 +349,13 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>   
>       ptr = memory_region_get_ram_ptr(&backend->mr);
>       sz = memory_region_size(&backend->mr);
> +    pagesize = qemu_ram_pagesize(backend->mr.ram_block);
> +
> +    if (!QEMU_IS_ALIGNED(sz, pagesize)) {
> +        error_setg(errp, "backend memory size must be multiple of 0x%"
> +                   PRIx64, pagesize);

Can we use size_to_str() instead?

Also display backend name:

"backend '%s' memory size must be multiple of %s"

> +        return;
> +    }
>   
>       if (backend->merge &&
>           qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE)) {


