Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2627ACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnpR-00030h-P7; Tue, 12 May 2026 10:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wMnpJ-0002zm-QG
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wMnpE-0004MP-8W
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778595066;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUE9BrfvgANCe3PYuItXPVWdLqAc8hiA/X97MqevMTg=;
 b=FNwbG783JeqzXkFusH34m6206S/d1eJtm1Gh8CPZm886UP7IJXDo+wqlDZ9r6BJqtbZPEY
 /o4xAzXzX8GDCYq0BgWsoFk7hatSB45DTCnCSQd+Wu/51MSFq9FvUk0UyQB41cUVMBo7+J
 e8/OXWbSrqzDCzJcBCrOTKBX9n7XBUo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Zi36SRUUOQq5MYY9HdP9OA-1; Tue, 12 May 2026 10:11:04 -0400
X-MC-Unique: Zi36SRUUOQq5MYY9HdP9OA-1
X-Mimecast-MFC-AGG-ID: Zi36SRUUOQq5MYY9HdP9OA_1778595064
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48e51dc35a3so43931135e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 07:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778595063; x=1779199863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUE9BrfvgANCe3PYuItXPVWdLqAc8hiA/X97MqevMTg=;
 b=PDwkm32PwvP+Ob7bBjx530/InZGVYiaUWsWv0F8WFGJWybdRb34Bsa9tHKvlEtC+IB
 4ju3TQq0nH3vdpKv+vpD1EC3ufSUV/AuCeAuO5xiqog3mHeZTYWwOP+TEeVjoDiASyhv
 rUnGstNm9gV9hvncp5q1PfJWjFfH6yxgPJzhAq+9AD51iOPAjRKH/PoIsCJnbXz+UHxQ
 HrMmu6anGw27/CWZFhRvxIonfFNkStBLpOrevybi38ypqtpqQtyyP+W0o3MELfAkh5m2
 +VTLEFaJMUshYVGypY//T4G9+sKgFzqeBEEovxY4LDMbNshA7mnvQU1Q2VUHgRHskycY
 /OLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Mg8OsvhoSFWfTgYtvAFdWfYhRhPoK/62QyPWrn/4F96NiZ4smYRqZL6pvQ6nbSVvkuFnJtkL0+wzN@nongnu.org
X-Gm-Message-State: AOJu0Yx7zgqkyqURfXbUwf0DpKy2dOX7jp4KeIip9vSsyrS5lSnBVSBq
 aIEuAN4CJObUKoNSLHivW4ANHaVx+1sVioAERi5eXXb8cCET4ZvVExRCd7uT9HI7UwR5q/jQpyY
 87jaAB9dH4IoZM/NDj2kC8xzGV3BgdNRWA8w+m6nF9hmM0P9Ijm7nQJL+w7yANsXl
X-Gm-Gg: Acq92OHV/hSWXPyfAg6kzuRE6jGo5vWBGA92MMTz9CIsOMGvZetueTSRJi/VjyaR9wW
 OvufWLSr1JLaO6hsCpRanyZ9dWvI44XM2xsKBX+ORFcNvWrlEyFlB4Qvr3hXojnFzbRoznefVP5
 r4/PP/2z95dxg+IRZO2sr2IioA3265oHNG0UUgQLMzBPb4Gt5Ltg9ZgvHLnk390TOoXFC0AARr0
 6jTV7BO3UrKwcqC+iAXUWepZ01Q9cKSADfRNV8WzCRVahdC3ksuWa+2SlZKd9KNEW02zHzn5mva
 KBV11khXd1hYgyi/WMllQqf31iiKLHFpKuZrTdJK63rbrIoJNKTwY/HeCsZxR61JEqDs8ze8Qzk
 s7BJAc8r8EdIoIo+6+A2gGjQI/eex6GL9a/zYl3qWHwab0kX3tOsBct0MQAt46sNp0CBJ8A==
X-Received: by 2002:a05:600c:5250:b0:48f:99a9:bbed with SMTP id
 5b1f17b1804b1-48f99a9be7cmr9306075e9.22.1778595063416; 
 Tue, 12 May 2026 07:11:03 -0700 (PDT)
X-Received: by 2002:a05:600c:5250:b0:48f:99a9:bbed with SMTP id
 5b1f17b1804b1-48f99a9be7cmr9305505e9.22.1778595062933; 
 Tue, 12 May 2026 07:11:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f3e7829sm29426115e9.4.2026.05.12.07.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 07:11:02 -0700 (PDT)
Message-ID: <5101bb04-8acf-4d3b-8db6-701d7c41d5c2@redhat.com>
Date: Tue, 12 May 2026 16:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/17] target/arm/cpu-sysregs.h.inc: Update with
 automatic generation
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260503073541.790215-1-eric.auger@redhat.com>
 <20260503073541.790215-4-eric.auger@redhat.com>
 <CH3PR12MB7548C2AB4989FEF96C247D47AB3C2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <c7bfd8f7-3e3f-49fe-a8f4-ac0212a1762b@redhat.com>
 <CH3PR12MB7548FB661824C44F18C72A01AB392@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548FB661824C44F18C72A01AB392@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Hi Shameer,

On 5/12/26 11:41 AM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 12 May 2026 07:39
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
>> eric.auger.pro@gmail.com; qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org; kvmarm@lists.linux.dev; peter.maydell@linaro.org;
>> richard.henderson@linaro.org; cohuck@redhat.com; sebott@redhat.com;
>> philmd@linaro.org
>> Cc: maz@kernel.org; oliver.upton@linux.dev; pbonzini@redhat.com;
>> armbru@redhat.com; berrange@redhat.com; abologna@redhat.com;
>> jdenemar@redhat.com
>> Subject: Re: [PATCH v4 03/17] target/arm/cpu-sysregs.h.inc: Update with
>> automatic generation
>>
> [...]
>
>>>> +DEF(MPIDR_EL1, 3, 0, 0, 0, 5)
>>> Do we need MPIDR_EL1 as well? Is this considered as a feature ID
>>> register and is writable? I don't think so.
>> MPIDR_EL1 is part of the ID regs range defined in the kernel doc
>>
>> op0 = 3, op1 = {0,1,3}, crn = 0, crm within [0, 7], op2 within [0, 7]
>>
>> That's why the python script extracts it. Effectively it is not writable yet.
>>
>> I can exclude it from the automatic generation but do we really need to? Any
>> specific reason?
> No specific reason. The only thing is it's not really a feature ID register but
> a topology register and is not writable now.  I leave that to you.

noted. I leave it as is for now and we will decide upon further reviews.

Thanks

Eric
>
> Thanks,
> Shameer
>


