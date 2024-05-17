Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92875C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 05:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qRN-0001mb-95; Fri, 17 May 2024 01:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7qRC-0001fn-19
 for qemu-devel@nongnu.org; Fri, 17 May 2024 01:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7qQy-0006us-3J
 for qemu-devel@nongnu.org; Fri, 17 May 2024 01:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715924831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DKjd35xR04Kp1yQZc+C8D52QfR2ztjpMEmNMSEWXFXg=;
 b=A2QneyRqYevZDlebeD4GQZbOanqT0MaBcdjx72IDMDlDreI6zZPVAiBh5Yg7Wmq+5MLvWD
 /97p9wHyXbbmnx3E7aajTgW5Tppl12K8kInGM/OCs0H487ZvC+JGEGaDMddKIsvADPPI1C
 y2LPPHGp7xW8uvFRl6lqJKSndJR1fPM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-_AAVzizkOeOpPh7eq4QtNg-1; Fri, 17 May 2024 01:47:09 -0400
X-MC-Unique: _AAVzizkOeOpPh7eq4QtNg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59aedbd9a9so615978266b.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 22:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715924828; x=1716529628;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DKjd35xR04Kp1yQZc+C8D52QfR2ztjpMEmNMSEWXFXg=;
 b=fHld2rZfnKnVUr+rXVy5IgSgYaDJ62IaqlzOk2bE6SV//x0gcyzqZkNrD+ZKXgUD3S
 TtrMomPbcLO21jQlfQLQOOCaHsto1gtX9ROrbNToGX/pra8EnWKb+6q9+z8nxyvSl1wJ
 cZJVUMMEqrU1LR5LZAvtgE3qHH1hUMFJ6Dzogmy26Opm5FDl4k8Dug278514wS3N1H5P
 66TRxeKh1LZ4i8yOlAJ2/e0OPQ6pvH+a9o8beHvNjtlfpMev8lsJF/2zHhfI4T8qAhOy
 JCm/g91gk5OLBHMKGCSZSkF5nPPDDm+rlZHCswp7slBH3ptUNaSfnpAZzLGnKh3hh7NI
 aAgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVkiQF2Matm0LPQL2mgmgTmg9OqBo54KRrMPCN/5+QgJc+qz7AjqwUCPCZSRzJ5aSbntvQmWdqPmFUav2pc3NVqM7utr0=
X-Gm-Message-State: AOJu0Yz6PMKgnu2wI3aFR1Yw8eTv2NJRoVCjuiLj8i2suDG1ofHf3AbN
 7KlYhyV+Qx6gTlydy+HqZhFR7MNY6bMPrfNRUdiSaLyCdh6oBI0I7wSGRtPtC5VAHc6b90CXSPq
 JZfDHMJl70dOVFn38HmlvBgx7Y0CK4tIKhYU3hioUJiKj8xqwt1Jr
X-Received: by 2002:a17:906:e945:b0:a59:a3ef:21f4 with SMTP id
 a640c23a62f3a-a5a2d66b514mr1314045266b.53.1715924828119; 
 Thu, 16 May 2024 22:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGNVK7ko+2ez8KDnvyIiW4oNxIupcdAiUsf+QLNTx4UwL4dXlUpMvD38QuhV7fQPyLvVm7DQ==
X-Received: by 2002:a17:906:e945:b0:a59:a3ef:21f4 with SMTP id
 a640c23a62f3a-a5a2d66b514mr1314043866b.53.1715924827682; 
 Thu, 16 May 2024 22:47:07 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-52.web.vodafone.de.
 [109.43.176.52]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1787c63bsm1069592366b.51.2024.05.16.22.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 22:47:07 -0700 (PDT)
Message-ID: <d0e2ad55-52fd-4be5-ba54-f3d437c1a10f@redhat.com>
Date: Fri, 17 May 2024 07:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] s390_flic: add migration-enabled property
To: Marc Hartmayer <mhartmay@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-3-pbonzini@redhat.com> <877cftvmx3.fsf@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: qemu-s390x <qemu-s390x@nongnu.org>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <877cftvmx3.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/05/2024 16.42, Marc Hartmayer wrote:
> On Thu, May 09, 2024 at 07:00 PM +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Instead of mucking with css_migration_enabled(), add a property specific to
>> the FLIC device, similar to what is done for TYPE_S390_STATTRIB.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   include/hw/s390x/s390_flic.h | 1 +
>>   hw/intc/s390_flic.c          | 6 +++++-
>>   hw/s390x/s390-virtio-ccw.c   | 1 +
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
>> index 3907a13d076..bcb081def58 100644
>> --- a/include/hw/s390x/s390_flic.h
>> +++ b/include/hw/s390x/s390_flic.h
>> @@ -47,6 +47,7 @@ struct S390FLICState {
>>       /* to limit AdapterRoutes.num_routes for compat */
>>       uint32_t adapter_routes_max_batch;
>>       bool ais_supported;
>> +    bool migration_enabled;
>>   };
>>   
>>   
>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>> index f4a848460b8..7f930800877 100644
>> --- a/hw/intc/s390_flic.c
>> +++ b/hw/intc/s390_flic.c
>> @@ -405,6 +405,8 @@ static void qemu_s390_flic_class_init(ObjectClass *oc, void *data)
>>   static Property s390_flic_common_properties[] = {
>>       DEFINE_PROP_UINT32("adapter_routes_max_batch", S390FLICState,
>>                          adapter_routes_max_batch, ADAPTER_ROUTES_MAX_GSI),
>> +    DEFINE_PROP_BOOL("migration-enabled", S390FLICState,
>> +                     migration_enabled, true),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> @@ -457,7 +459,9 @@ type_init(qemu_s390_flic_register_types)
>>   
>>   static bool adapter_info_so_needed(void *opaque)
>>   {
>> -    return css_migration_enabled();
>> +    S390FLICState *fs = S390_FLIC_COMMON(opaque);
>> +
>> +    return fs->migration_enabled;
>>   }
...
> This patch causes QEMU to crash when trying to save the domain state
> (e.g. using libvirt)

Oh, drat, that vmstate belongs to a ccw device, not to a flic device, so the 
"opaque" pointer in adapter_info_so_needed points to the wrong structure.

I guess the easiest fix is:

diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -459,7 +459,7 @@ type_init(qemu_s390_flic_register_types)

  static bool adapter_info_so_needed(void *opaque)
  {
-    S390FLICState *fs = S390_FLIC_COMMON(opaque);
+    S390FLICState *fs = s390_get_flic();

      return fs->migration_enabled;
  }

I'll send it as a proper patch...

  Thomas


