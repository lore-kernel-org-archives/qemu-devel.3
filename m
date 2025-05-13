Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D829C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEr5m-0004UT-C1; Tue, 13 May 2025 10:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEr5j-0004Tr-Iv
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEr5h-0002Pm-O0
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747148324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x1vufKv0U2HdDN3hTmD6ObRWeRBVUzANgRpBYBzNHPY=;
 b=fRTQsSOg5L+Rwrfc9Ccbzn+adJ3Qs8VmgBIPivm+ZAR7NGehItrm/qixxtY+H2x73Ujx3g
 8h1o75TjRJfxkN3komNc4Fh5NmUVfFlzYXoKzU+jBeRi63o52+BXYWNpoTPwFfBjBiVmmp
 /CzbQx0kLGxVXOli5xTgRR+WBEJfuog=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-hS45rK_hPsi3BWWCrQAwMA-1; Tue, 13 May 2025 10:58:43 -0400
X-MC-Unique: hS45rK_hPsi3BWWCrQAwMA-1
X-Mimecast-MFC-AGG-ID: hS45rK_hPsi3BWWCrQAwMA_1747148323
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442ccf0eb4eso42439525e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747148322; x=1747753122;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x1vufKv0U2HdDN3hTmD6ObRWeRBVUzANgRpBYBzNHPY=;
 b=RE96xuqHdGsi0TnGp56Kpd30tFsD82N1fKcNbL8mw2h4WO9uydsn6l0cwxyEytXWDp
 TmfBjF0ahaM1z1aCCNe5IZFDEpBN+e1lv45Q1VHWxnZF63lLLj+WcTcDQ+S/l/ZDYlu0
 JE1bn+4GJTT5IMs1970ybsnUaHzvclflaTu/yVLtAErs07yq01ljJ5vt2Brl4A2GJGtm
 9X+7NsNxm+a0mdBxivhAFu2YOtYLcu9tsi7Hvb6a18gBhv3TO22ACZeKUM/1XO9rU60k
 PRwFp80C6/kF6yWk8Co3wEDeAtr8zaVP5ENGfkBJ2GzmGOzPzE8KJRGz5mFKV0XARLc4
 yUBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtt7aIsWYUnhaWNOa6FKydJP0MpE5pwFxfRLciC5RVAiPG0oaL6qCsoqc5ypnHXH9HzaVtSQpnbkbx@nongnu.org
X-Gm-Message-State: AOJu0Yx/QBEidTZbJokEM+B5FDn3wFcg47dGyhi6hR40CSp442TJ0hwt
 giFX8NyV/L0ADDUsL4kWrQhiTeyDUyzRPRzZmx//5fTz9nuIOE7rbFDwd+7mo1Pub6WrC2X4Fl9
 wLNo8O9rUnXGu79XeccEVZ/DrKKqSHqAivz/B7Qw/1kL/ScxaIijP
X-Gm-Gg: ASbGncvsypFOJHFO7bINT3bKU4CtwMVtGWO+n87JaDrNpzwvB1y9W9CkPaM891J/83B
 A552GlENygMYzsruqo/nDISPtbVmkRGePBUcQFpY66Zzgy2ITRAIHkm3rW9ZuJOSoaXwj8JpdBN
 H9AQdVM8r08wwTGA5MOg+21LlJ4/F1QfTdhF4Z9F9D66Wov24QY+De6J7jR90dvJqwi9LiiiggY
 +ZM2sZbsah9k47BNj9N4p9kcnQidUeX0yv1PMMGF2ecGBkmdg9e4KJT8cwW602MshXh5p5qiXO7
 N0fTksjAfKsHqMdKayPq+7PtCa9/9HZdHtfLvf/yR/8=
X-Received: by 2002:a05:600c:8707:b0:43c:fd72:f039 with SMTP id
 5b1f17b1804b1-442d6d3e13bmr140888715e9.11.1747148322513; 
 Tue, 13 May 2025 07:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw505m/XwZgZRp1on7wjlNFJBV38/M/wnlZOc6aEs17DgYP3cEuiP8RUozsJLgBsBEpykqjg==
X-Received: by 2002:a05:600c:8707:b0:43c:fd72:f039 with SMTP id
 5b1f17b1804b1-442d6d3e13bmr140888485e9.11.1747148322106; 
 Tue, 13 May 2025 07:58:42 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-129.web.vodafone.de.
 [109.42.48.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67ed1bcsm168438245e9.18.2025.05.13.07.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 07:58:41 -0700 (PDT)
Message-ID: <16b58a8b-38ef-4a78-b3c1-103d69b56af4@redhat.com>
Date: Tue, 13 May 2025 16:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/25] Add -boot-certificates to s390-ccw-virtio
 machine type option
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-2-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250508225042.313672-2-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi!

On 09/05/2025 00.50, Zhuoying Cai wrote:
> Add -boot-certificates as a parameter of s390-ccw-virtio machine type option.

> The `-boot-certificates /path/dir:/path/file` option is implemented
> to provide path to either a directory or a single certificate.

Nit: Remove the "-" before "boot-certificates" now in the patch description 
and in the patch subject since this is not a stand-alone option anymore.

> Multiple paths can be delineated using a colon.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++++++
>   include/hw/s390x/s390-virtio-ccw.h |  1 +
>   qemu-options.hx                    |  7 ++++++-
>   3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 192feb128b..f82f78255a 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -824,6 +824,22 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
>       s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
>   }
>   
> +static inline char *machine_get_boot_certificates(Object *obj, Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +
> +    return g_strdup(ms->boot_certificates);
> +}
> +
> +static void machine_set_boot_certificates(Object *obj, const char *str,
> +                                          Error **errp)
> +{
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +
> +    g_free(ms->boot_certificates);
> +    ms->boot_certificates = g_strdup(str);
> +}
> +
>   static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -878,6 +894,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
>               "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
>               " to upper case) to pass to machine loader, boot manager,"
>               " and guest kernel");
> +
> +    object_class_property_add_str(oc, "boot-certificates",
> +                                  machine_get_boot_certificates,
> +                                  machine_set_boot_certificates);
> +    object_class_property_set_description(oc, "boot-certificates",
> +            "provide path to a direcotry or a single certificate for secure boot");

s/direcotry/directory/

>   }
>   
>   static inline void s390_machine_initfn(Object *obj)
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index fc4112fbf5..ed25939243 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -31,6 +31,7 @@ struct S390CcwMachineState {
>       uint8_t loadparm[8];
>       uint64_t memory_limit;
>       uint64_t max_pagesize;
> +    char *boot_certificates;
>   
>       SCLPDevice *sclp;
>   };
> diff --git a/qemu-options.hx b/qemu-options.hx
> index dc694a99a3..e592f6a757 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>   #endif
>       "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>       "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
> -    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
> +    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
> +    "                boot-certificates='/path/directory:/path/file' provide a path to a directory or a boot certificate\n",
>       QEMU_ARCH_ALL)
>   SRST
>   ``-machine [type=]name[,prop=value[,...]]``
> @@ -200,6 +201,10 @@ SRST
>           ::
>   
>               -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
> +
> +    ``boot-certificates='/path/directory:/path/file'``
> +        Provide a path to a directory or a boot certificate on s390-ccw host.

"s390-ccw" does not make too much sense when talking about the host. I'd 
maybe rather say "on the host [s390x only]" instead?

  Thomas


