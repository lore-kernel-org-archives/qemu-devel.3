Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55B7C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 05:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5ITG-00061L-VF; Fri, 10 May 2024 01:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5ISr-0005x3-0k
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5ISn-0001Qy-6g
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715317585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w2m5DNLVEiWVj1ShvMgM77Yi4EjyMdQwLXJFXjNG2xM=;
 b=CqWBwPr4Wp6WqFhAdfqHcvdC45FJRP1ru6b4IWZEw6h/R2G0B2LCYW0DejLPYMpmeo+rLp
 UCQL/8Znb43e2jehIsxAFQxezc+P71SkuciQAmy+v/HGLwUq10ycQltHMzHxFumxqScKtf
 bJ9Vz0frbkRVbXFAuoKWlGp/ZpnyA0E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-xomTfvqOOAq0Zx7jgVU1FA-1; Fri, 10 May 2024 01:06:23 -0400
X-MC-Unique: xomTfvqOOAq0Zx7jgVU1FA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56e645a8762so1041071a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 22:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715317582; x=1715922382;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w2m5DNLVEiWVj1ShvMgM77Yi4EjyMdQwLXJFXjNG2xM=;
 b=CuwjPXvEyEfaCfo6nyISRWUd1K7G2GTkAdGTbZRrtwoYEvZBLVB95urq0rXiM1oKNd
 xSQzceFJRpaU3lMzOy64AiBvTxV7Gzymc6WWpkVDeicR6Y9p5lPepi34r8WUC3aBq1rq
 BZt85dePWIGi8THxI2qcSxMadEHNL7uJYCKL5w22jjAUNsqSmQ2VGWdldEaR63HCacWy
 Q5FIG3xui+9q0LoGMjLDpdoyrtR/K2VjRwWemq+42BjW7cA7fp9owRGj+Qr8Q8ywQgiT
 nK/Mds9WSvjyo8M3oJrQUZh4z0COWUVoD8gYAvNzG0l/OKdouO+rHQ0Dee2WHR079b1r
 DBbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiA4jU3cjaPPsYS3nkWPB2BCwUmq9OsxmkpP7sBvKUD3FqvZsAq8n3ZQWyL09hycx2ZtPVPGGWHec+bf9lUKNSEEYxZ8o=
X-Gm-Message-State: AOJu0Yyc13OduZPiGwJscojFM7XGI5QXqs/LUXCaunV7Oixn7V0O4BOh
 oKD0nDni/TEE85K8wUBgq4wO0IBXz4PgsxgSdDt48j9RaPn9gWBOF40AeD6C6XmFBOXIt5c5/jT
 wX5sElxXufjB1JYSWTlWN725R/79cykX9Ft54bkqUJaaBnCRtJaoQ
X-Received: by 2002:a50:8adb:0:b0:572:a22b:12db with SMTP id
 4fb4d7f45d1cf-5734d67f00fmr1063315a12.28.1715317582651; 
 Thu, 09 May 2024 22:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ9/YuWNtjvdxO8kIINpj75RSWtZZLHf1yHO6Tf7FJ9D7lGWlowLa+PMsQl8F+e2Yq9CJxWA==
X-Received: by 2002:a50:8adb:0:b0:572:a22b:12db with SMTP id
 4fb4d7f45d1cf-5734d67f00fmr1063301a12.28.1715317582233; 
 Thu, 09 May 2024 22:06:22 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2c7d58sm1418411a12.77.2024.05.09.22.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 22:06:21 -0700 (PDT)
Message-ID: <687bbd1b-2481-4044-a432-d786025a355b@redhat.com>
Date: Fri, 10 May 2024 07:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] s390_flic: add migration-enabled property
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-3-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240509170044.190795-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09/05/2024 19.00, Paolo Bonzini wrote:
> Instead of mucking with css_migration_enabled(), add a property specific to
> the FLIC device, similar to what is done for TYPE_S390_STATTRIB.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/s390x/s390_flic.h | 1 +
>   hw/intc/s390_flic.c          | 6 +++++-
>   hw/s390x/s390-virtio-ccw.c   | 1 +
>   3 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

(BTW: It's really good that Daniel's patch series is going to mark the old 
machine types as deprecated, too ... migration stuff has been so hacky in 
the 2.x days...)

> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
> index 3907a13d076..bcb081def58 100644
> --- a/include/hw/s390x/s390_flic.h
> +++ b/include/hw/s390x/s390_flic.h
> @@ -47,6 +47,7 @@ struct S390FLICState {
>       /* to limit AdapterRoutes.num_routes for compat */
>       uint32_t adapter_routes_max_batch;
>       bool ais_supported;
> +    bool migration_enabled;
>   };
>   
>   
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index f4a848460b8..7f930800877 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -405,6 +405,8 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
>   static Property s390_flic_common_properties[] = {
>       DEFINE_PROP_UINT32("adapter_routes_max_batch", S390FLICState,
>                          adapter_routes_max_batch, ADAPTER_ROUTES_MAX_GSI),
> +    DEFINE_PROP_BOOL("migration-enabled", S390FLICState,
> +                     migration_enabled, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -457,7 +459,9 @@ type_init(qemu_s390_flic_register_types)
>   
>   static bool adapter_info_so_needed(void *opaque)
>   {
> -    return css_migration_enabled();
> +    S390FLICState *fs = S390_FLIC_COMMON(opaque);
> +
> +    return fs->migration_enabled;
>   }
>   
>   const VMStateDescription vmstate_adapter_info_so = {
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index feabc173eb3..1383e47eeb5 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -1174,6 +1174,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
>       S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
>       static GlobalProperty compat[] = {
>           { TYPE_S390_STATTRIB, "migration-enabled", "off", },
> +        { TYPE_S390_FLIC_COMMON, "migration-enabled", "off", },
>       };
>   
>       ccw_machine_2_10_class_options(mc);


