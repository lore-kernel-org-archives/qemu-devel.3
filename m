Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB4FCCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 05:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDz3e-0000jC-HQ; Wed, 29 Oct 2025 01:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDz3b-0000ia-9b
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 01:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDz3Q-00040T-6S
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 01:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761716941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xYR3B3TiIvJS4F7Ao0pvqXQy69kfGfibOZ6NDWzYlZ0=;
 b=BZXglE6xS1ug2tjhZsh7UwmWG3ZmmnlArZge2VLiYKKxfoRhoaRe1lNuEWeUYKWFr+ySIU
 eF+lG10QtXJXK8WeG5thr1iAfK0d6Nk463Sf2M6vcezPVDiL6TSRpr/lAG9w5khVxmlh/m
 HVpg0WNIkCULPnP4ZdW6jswKc030DTA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-zP2JxPMzP56cxOyUNQqGgg-1; Wed, 29 Oct 2025 01:48:59 -0400
X-MC-Unique: zP2JxPMzP56cxOyUNQqGgg-1
X-Mimecast-MFC-AGG-ID: zP2JxPMzP56cxOyUNQqGgg_1761716938
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b6d58291413so732260966b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 22:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761716938; x=1762321738;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYR3B3TiIvJS4F7Ao0pvqXQy69kfGfibOZ6NDWzYlZ0=;
 b=OFDb9Ycf15cjxrDVcW26Ulv9059Kmbgc3UVJOuB2ntPsZxxbk4zEN5AYIGAolmHh7V
 xC16jcYebd5gUpM53RwKdwUFl/HjoacrGcQR+aUhbdTy4xSj5mDUllyObxHaJvyCq5mf
 gR5VbR6sUQg9otl0HIzX+N0YPAOizr4Bffs/xfQvJ6g8YddBWsM5YDjySWZLqHlujeyw
 JtbUU3qHNQSHynwv1SgmFUr3rlr4ZLG2I5gKBxzBd7YJ/kQ6hg9o5TLuHMeEzRLBWWR3
 NKax6CXoMkK6XRyAYGkRb+nRJzu7ZmsszudMtsFhDngnu2+zWdteGaVno9J8CN/3UsCE
 h/kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp6C1xliiLQiEpsfK91N8ezTfjm8UL2yS0AugXAE+EyWBIr1VA9BIs13TSrDH5IiHriw1njnoD49K9@nongnu.org
X-Gm-Message-State: AOJu0Yw1Cg2anakkXZ4gXUazUcyXqiFz26Zl5Bp1rXUgu82FXwRONkH1
 xbqhlNMdacs7pzPeB/ziUGQIRB9z4LBjy+xznE66irFtgl4S8g8MEdCVsNtgwgazeJfchAPQlFu
 8bFitCqn+XB3gVdvL40/6GsdfDRwVlCPllX/ASCSyo7+YaTdsvRWjAD2j
X-Gm-Gg: ASbGncsQuEH7v3RcNKAxlGa7EgeGY82Il9TYQEnciQbOipXPvYycYV9nGKChZawf/qp
 bYox43LHJG+9NxTdpvTPKq8MnyJEY7XAFykzZVcyL80ucxfceKT1LG9oapUMntWXyly3fq8MFna
 0FQRSX5CVjNDnrq3VIPFF0KWTHwqlmZJGIhxqhP2WC1T2VoEXK0A7m36YH/aQFR89SIRFQYtr6j
 4wXjB3LF5eX1iI1q4MRA26Iu86RCEn8IGu5IOi2UPVmhhKaW0eUSvfblNdylvt09cyvdjx6/R9S
 /4H9DgIPGCbMUllg5PoclxjnnySrxAHzSIvmvtICk/kNlYRsjIfM9coboUPD19SEVqRdAaM=
X-Received: by 2002:a17:907:749:b0:b53:e871:f0ea with SMTP id
 a640c23a62f3a-b703d57269amr156348766b.56.1761716938534; 
 Tue, 28 Oct 2025 22:48:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO3Vp5ADjeCuxdZpUZ5hkPxmAAvCD6ptEhfbC9hiTItYvCJLrpJWdqZfGyJzKSGfdOo3qZYw==
X-Received: by 2002:a17:907:749:b0:b53:e871:f0ea with SMTP id
 a640c23a62f3a-b703d57269amr156347366b.56.1761716938163; 
 Tue, 28 Oct 2025 22:48:58 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853696a3sm1302412366b.27.2025.10.28.22.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 22:48:57 -0700 (PDT)
Message-ID: <b2916e5c-41d3-4562-9d12-6f39f3d2e4fa@redhat.com>
Date: Wed, 29 Oct 2025 06:48:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/25] system/memory: Have memory_region_size() take a
 const argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-11-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028181300.41475-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 28/10/2025 19.12, Philippe Mathieu-Daudé wrote:
> Since the @mr argument is not modified, it can be const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/memory.h | 2 +-
>   system/memory.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 3bd5ffa5e0d..45de6946812 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1776,7 +1776,7 @@ Object *memory_region_owner(MemoryRegion *mr);
>    *
>    * @mr: the memory region being queried.
>    */
> -uint64_t memory_region_size(MemoryRegion *mr);
> +uint64_t memory_region_size(const MemoryRegion *mr);
>   
>   /**
>    * memory_region_is_ram: check whether a memory region is random access
> diff --git a/system/memory.c b/system/memory.c
> index 8b84661ae36..d1c060b2b50 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1870,7 +1870,7 @@ void memory_region_unref(MemoryRegion *mr)
>       }
>   }
>   
> -uint64_t memory_region_size(MemoryRegion *mr)
> +uint64_t memory_region_size(const MemoryRegion *mr)
>   {
>       if (int128_eq(mr->size, int128_2_64())) {
>           return UINT64_MAX;

Reviewed-by: Thomas Huth <thuth@redhat.com>


