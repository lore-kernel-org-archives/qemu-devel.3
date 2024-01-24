Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E06EC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 14:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSdwM-0001Jo-F5; Wed, 24 Jan 2024 09:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSdwL-0001Jd-41
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 09:09:17 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSdwI-00082s-Ee
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 09:09:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so59826455e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 06:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706105352; x=1706710152; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hMpoMnQIlEpaRr0/5XClGONtW8gGQ7ZA0gSck2S1TUo=;
 b=cqjT0syGQl0NLEKAFZysrzokBkva+a6wgAOUMdVM72WXsuPx/xQfd3boKTHfbqr84p
 DwWguEqYKfCDththsiIFYfvsyTrIjCYUISZbW/3lTdqry99wGJ5lRINSgJnthdo3GGJ3
 f6dmOS6BOoWfs/LFs0Lbm84mIm68MRxhWNlnIse1GYS9k6YdYQ2pSeNJHNSzOmniHcVN
 82Sh0Am3D9xhFm1MvWyikQMvbmj31JFky0akQA6D40UE2OiTwRFDst+JroBEziSSsweu
 sITUzP7ze3z9JdCly+3Gl0dNQcio7q2pAobceRQxV9vcIhv1qeaSfNI4IbB5RlkVQEdT
 7TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706105352; x=1706710152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hMpoMnQIlEpaRr0/5XClGONtW8gGQ7ZA0gSck2S1TUo=;
 b=w8c10b0rttJktM915cZiSfF1LC7CKMw9V1qkBV2NgcPqVuMTMQt3QvS3kWyBzdrC2F
 XVMtmub9Me26+VaZ6T2fzedBIl4qdrR1AOWAYNt4Cy3PQYMi44ShJ1fEHXr1lTVfoFXa
 2uRLGbc0Q/oO9Y3hjXSWNh14xj1mXw+blpGYdVILL96T182BhSWEmCQuNpHC6v7RDAsA
 5rkS5spqYkfaL2sU9Fs7qc8iv2lgDWUWgpQv6lTzp+tnvKohpsYbXHaFV71s0hiJ4sCG
 q/6armmg7Jrk1uwAnYgqtLc9/4c/7UNu1HckmRh4ChUZcTdgC2MIg0mzgNb1YImdKpx2
 EGhw==
X-Gm-Message-State: AOJu0YzZG7+TcCfgi8GMxRxSscJAgkNT1qV0qFvbcXOSPaBnr5MaDNb9
 XhnLBWKdZwfbv6BMhv0t3Y43cGRbEwmPs3Hi2RwpZrI2ILp9YbeMAO7QGGyhmoE=
X-Google-Smtp-Source: AGHT+IHD/25cP2db0IdFfXzIWztEylqwEa90lf3/q9QtHHyBNr3qk5kilJTUGWPwT9KGou6Rm7EH3A==
X-Received: by 2002:a05:600c:1994:b0:40d:7fbe:e966 with SMTP id
 t20-20020a05600c199400b0040d7fbee966mr1191788wmq.40.1706105352277; 
 Wed, 24 Jan 2024 06:09:12 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c19cd00b0040e451fd602sm49602477wmq.33.2024.01.24.06.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 06:09:11 -0800 (PST)
Message-ID: <887a8b74-423f-4c4c-8cdd-d29fcb4f14b8@linaro.org>
Date: Wed, 24 Jan 2024 15:09:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/vfio/common: Use RCU_READ macros
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C_=C3=A9_dric_Le_Goater?= <clg@redhat.com>
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-6-philmd@linaro.org> <7reip.7d0x82au0t9p@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7reip.7d0x82au0t9p@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 24/1/24 10:25, Manos Pitsidianakis wrote:
> On Wed, 24 Jan 2024 09:42, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>> Replace the manual rcu_read_(un)lock calls by the
>> *RCU_READ_LOCK_GUARD macros (See commit ef46ae67ba
>> "docs/style: call out the use of GUARD macros").
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/vfio/common.c | 34 ++++++++++++++++------------------
>> 1 file changed, 16 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 4aa86f563c..09878a3603 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -308,13 +308,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier 
>> *n, IOMMUTLBEntry *iotlb)
>>         return;
>>     }
>>
>> -    rcu_read_lock();
>> +    RCU_READ_LOCK_GUARD();
>>
>>     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>         bool read_only;
>>
>>         if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>> -            goto out;
>> +            return;
> 
> Since this is the only early return, we could alternatively do:
> 
> -         if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
> +         if (vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
> 
> remove the goto/return, and wrap the rest of the codeflow in this if's 
> brackets. And then we could use WITH_RCU_READ_LOCK_GUARD instead. That'd 
> increase the code indentation however.

If the maintainer agrees with the style & code churn, I don't
mind respining.

> 
>>         }
>>         /*
>>          * vaddr is only valid until rcu_read_unlock(). But after
>> @@ -343,8 +343,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier 
>> *n, IOMMUTLBEntry *iotlb)
>>             vfio_set_migration_error(ret);
>>         }
>>     }
>> -out:
>> -    rcu_read_unlock();
>> }

> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks!

