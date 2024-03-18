Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D26C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9xJ-0004ZG-Gh; Mon, 18 Mar 2024 06:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rm9xG-0004Z1-PE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rm9x3-0006xH-FN
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710756639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZF5rzNT/xoilKozIzPZP/eiN9tDwgl+XmOm0IwZBIWI=;
 b=Mi01p0HbQtiBHCgJ2t2RWQikH+TEDaDgqDi4u4JGDARSvCXTgtXRzRyyO6AMjGueco47n2
 Bq+EwvT4iJl/ukI3UOQBs8VDtCun5aS1WvF7D/pC3J2+GWtbm1d8stZEwNEPXIdz8P6sub
 4IAoTFRqLhQu9YDwB7IIizBQgVk7xRI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-lwlesUZsOAy5-y_wmHSPmw-1; Mon, 18 Mar 2024 06:10:37 -0400
X-MC-Unique: lwlesUZsOAy5-y_wmHSPmw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41401f598cfso11797135e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756636; x=1711361436;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZF5rzNT/xoilKozIzPZP/eiN9tDwgl+XmOm0IwZBIWI=;
 b=ssvT/E8fy/trmY5lyprgf838C0DA9Mg9wMNbH2/30NasYTxs7p3FD3ZGpZScwk4k2T
 iAclVsrD/TEtvI6UnZgDKCT1FAvheidau/Mv98b6XtAS+aNx1mRRzZ4MFBaUXmtxy242
 8Eyc3wUzNO/uTUl5sg71n22KKf4Na5Kj9cN8z0H61E/V5pjFqtCQJuc++d2WzEVeVPN2
 rh2C6jv6AtRzu+2Q8tBEo7P5442tD+h+2ZXogJj0jJDt1v6wlP9L/vUnCtCHkEF6tQ2i
 gM0DNAaAOqPa/yGE+loEEf27y77V9vM5XfNQkfXlgiz4wm/RPwr9u3UI4nXw78B6YfC7
 txkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaOZP8/YunmUk4ADTgqqPCIjX3x5hb0fIv9i//oFAFA3CVM7UuDm+LVUKdN7SmMxMXv2pRsvYOl4s7ojhu2GwhE7PlVP8=
X-Gm-Message-State: AOJu0Yzc/TU54upY3o7IKNRlzow2ORlPzS/pmWS065ms5YbA4xC9ameb
 HszwAiZLw4puMUJfm9Gy5A2I3qIodMVxNWO/q2+PrACLebolZ8uYoSjXCqVdvDRCR3Du3MMXS4C
 A5xKmm3pUEgVO73gQITDmdlWSMObloc/RKyQaW/nuFbhGxXxVhN8b
X-Received: by 2002:a05:600c:6a95:b0:414:ff4:5957 with SMTP id
 jl21-20020a05600c6a9500b004140ff45957mr1858956wmb.5.1710756636624; 
 Mon, 18 Mar 2024 03:10:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgxtkp8gG5yZffyhnwC6RcEZuOwfDSRUMi2sPWaZCF6IVmESfe0K4Xu88/J7v6NkvYgXcZBg==
X-Received: by 2002:a05:600c:6a95:b0:414:ff4:5957 with SMTP id
 jl21-20020a05600c6a9500b004140ff45957mr1858931wmb.5.1710756636172; 
 Mon, 18 Mar 2024 03:10:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1f00:94ff:246b:30d0:686b?
 (p200300cbc7371f0094ff246b30d0686b.dip0.t-ipconnect.de.
 [2003:cb:c737:1f00:94ff:246b:30d0:686b])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b00412cfdc41f7sm4878206wms.0.2024.03.18.03.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 03:10:35 -0700 (PDT)
Message-ID: <4d7795bb-1dfa-40e7-a98e-4c0bafdf3db0@redhat.com>
Date: Mon, 18 Mar 2024 11:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] system/cpus: Fix pause_all_vcpus() under
 concurrent environment
Content-Language: en-US
To: Keqian Zhu <zhukeqian1@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>,
 jiangkunkun@huawei.com, salil.mehta@huawei.com
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
 <20240317083704.23244-2-zhukeqian1@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240317083704.23244-2-zhukeqian1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 17.03.24 09:37, Keqian Zhu via wrote:
> Both main loop thread and vCPU thread are allowed to call
> pause_all_vcpus(), and in general resume_all_vcpus() is called
> after it. Two issues live in pause_all_vcpus():

In general, calling pause_all_vcpus() from VCPU threads is quite dangerous.

Do we have reproducers for the cases below?

> 
> 1. There is possibility that during thread T1 waits on
> qemu_pause_cond with bql unlocked, other thread has called
> pause_all_vcpus() and resume_all_vcpus(), then thread T1 will
> stuck, because the condition all_vcpus_paused() is always false.

How can this happen?

Two threads calling pause_all_vcpus() is borderline broken, as you note.

IIRC, we should call pause_all_vcpus() only if some other mechanism 
prevents these races. For example, based on runstate changes.


Just imagine one thread calling pause_all_vcpus() while another one 
calls resume_all_vcpus(). It cannot possibly work.

> 
> 2. After all_vcpus_paused() has been checked as true, we will
> unlock bql to relock replay_mutex. During the bql was unlocked,
> the vcpu's state may has been changed by other thread, so we
> must retry.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>   system/cpus.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/system/cpus.c b/system/cpus.c
> index 68d161d96b..4e41abe23e 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -571,12 +571,14 @@ static bool all_vcpus_paused(void)
>       return true;
>   }
>   
> -void pause_all_vcpus(void)
> +static void request_pause_all_vcpus(void)
>   {
>       CPUState *cpu;
>   
> -    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
>       CPU_FOREACH(cpu) {
> +        if (cpu->stopped) {
> +            continue;
> +        }
>           if (qemu_cpu_is_self(cpu)) {
>               qemu_cpu_stop(cpu, true);
>           } else {
> @@ -584,6 +586,14 @@ void pause_all_vcpus(void)
>               qemu_cpu_kick(cpu);
>           }
>       }
> +}
> +
> +void pause_all_vcpus(void)
> +{
> +    qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
> +
> +retry:
> +    request_pause_all_vcpus();
>   
>       /* We need to drop the replay_lock so any vCPU threads woken up
>        * can finish their replay tasks
> @@ -592,14 +602,23 @@ void pause_all_vcpus(void)
>   
>       while (!all_vcpus_paused()) {
>           qemu_cond_wait(&qemu_pause_cond, &bql);
> -        CPU_FOREACH(cpu) {
> -            qemu_cpu_kick(cpu);
> -        }
> +        /* During we waited on qemu_pause_cond the bql was unlocked,
> +         * the vcpu's state may has been changed by other thread, so
> +         * we must request the pause state on all vcpus again.
> +         */
> +        request_pause_all_vcpus();
>       }
>   
>       bql_unlock();
>       replay_mutex_lock();
>       bql_lock();
> +
> +    /* During the bql was unlocked, the vcpu's state may has been
> +     * changed by other thread, so we must retry.
> +     */
> +    if (!all_vcpus_paused()) {
> +        goto retry;
> +    }
>   }
>   
>   void cpu_resume(CPUState *cpu)

-- 
Cheers,

David / dhildenb


