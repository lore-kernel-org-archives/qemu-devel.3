Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C51FC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 19:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYVgR-0007iS-8i; Thu, 16 Jan 2025 14:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYVgO-0007ho-Lo
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:37:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYVgN-0003le-3e
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737056254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YabawkxSaUY2jw0BC/Dz++v3lBMA8oku2NmzufIJgC4=;
 b=WKLoEmbGo4oTv86z1p1yOgQobntKZq5lFHyX2lmB0qJ6CtR4h+qpz+mriThfZVW/3eMy1H
 4UtQlvWN/9ACjAIvoGvUn5gS5Z3nRp3K7kSE9RtNghoPGL98NNlefUjB+0ZiKO6R4JCA4H
 06EIDaSiUg/hU4/ZFL6UrZ+TiBIl03o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-L6ubKVHqNSicQN2VNxmuFg-1; Thu, 16 Jan 2025 14:37:32 -0500
X-MC-Unique: L6ubKVHqNSicQN2VNxmuFg-1
X-Mimecast-MFC-AGG-ID: L6ubKVHqNSicQN2VNxmuFg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so3973905e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 11:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737056250; x=1737661050;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YabawkxSaUY2jw0BC/Dz++v3lBMA8oku2NmzufIJgC4=;
 b=ROZZKshV9rmK23PHERr/3xDGj56QKkNnHJTVY10HcnVaSIPdzAsSEa5P/g056vD65H
 AnnzaXlU9yltp1RPRE+2RcuFXowX+i16hGmotZ+1h6H4gHPAe9Ww1sXqZZRMATouUCd+
 iawX+E6bY/GIuBes8XpjPDVmwYC9rZH5oj1ZXfJb4DZx9DzvqMVvdkwIU9xqU+kXhbao
 tEpWDk/4vYcS7M8HIFFrI2KjWlDEf0uG9qzlHEQ7KbCqua5D624hBjSI6EOoMwd6tR+y
 QPrcwaQEeP1Ol8MwhWcXvC9P3WNJq8h0vjjpztoZLEFK+qN7ddM0TuAjPVJ2an9tgx9V
 biLw==
X-Gm-Message-State: AOJu0YyrLdfdmUPevrlZxMUNIFjH0TGBO+wWU2qMcSnftAacQkdNMEKj
 ui7ZXuXYJYzkyQXU+mXhAwZdEPjYP6Zv+CPw8dQ5OaE2pvqThRIvV3UpEEGe7kiAtExbNXB7uaI
 Ym/Rlks0n/n33V38BXW7JSsXtyzvx9sr6fS7eB+hEIN239JaISmGG
X-Gm-Gg: ASbGncvj0WI4XjH0IpMNjTK2lm15VlO7zQZ5avOyYBpf0WCy2a6Uafo1wDewsLsgCfq
 ifIPDySr3gIK+ckp4jVObQFd5l8YHen59nqW867sNw1kvpxTpoSerWdsdvHJNUsClGyUD2GPE8p
 YPe5eYLydHzp0HhNxRLindu9SkjPvOPWoLJKaHnXl6r54sMu3rpzyW7efvnEsyqkHlXBznrpVc1
 wzHrg+7GwsyvpxzyCbtQpOx/+/XxolsSaIbECE0bAUQa+YhyrHH3d10gDDB2EqjMNkbq4BCoj88
 242+sr7T0050
X-Received: by 2002:a7b:c006:0:b0:436:17a6:32ee with SMTP id
 5b1f17b1804b1-437c6b2dd0dmr78701985e9.10.1737056249955; 
 Thu, 16 Jan 2025 11:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtzkPg2BQHxfIvl/MqXq55oPXHk75mr0DSfQqitgWx2rp/iHnecSdVED/o7/JlWxcfNQGlAw==
X-Received: by 2002:a7b:c006:0:b0:436:17a6:32ee with SMTP id
 5b1f17b1804b1-437c6b2dd0dmr78701845e9.10.1737056249466; 
 Thu, 16 Jan 2025 11:37:29 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389046885esm8372795e9.36.2025.01.16.11.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 11:37:29 -0800 (PST)
Message-ID: <4a598e44-928b-4af5-8194-378e617aa9d3@redhat.com>
Date: Thu, 16 Jan 2025 20:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 03/13] hw/arm/virt: Remove
 VirtMachineClass::disallow_affinity_adjustment
To: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-4-philmd@linaro.org>
 <20250116-bf7d225d9fef8277a6315e63@orel>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250116-bf7d225d9fef8277a6315e63@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 16/01/2025 16.16, Andrew Jones wrote:
> On Thu, Jan 16, 2025 at 03:59:34PM +0100, Philippe Mathieu-Daudé wrote:
>> The VirtMachineClass::disallow_affinity_adjustment
>> field was only used by virt-2.6 machine, which got
>> removed. Remove it and simplify virt_cpu_mp_affinity().
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/arm/virt.h |  1 -
>>   hw/arm/virt.c         | 30 +++++++++++++++---------------
>>   2 files changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 27c5bb585cb..5d3b25509ff 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -117,7 +117,6 @@ typedef enum VirtGICType {
>>   
>>   struct VirtMachineClass {
>>       MachineClass parent;
>> -    bool disallow_affinity_adjustment;
>>       bool no_its;
>>       bool no_tcg_its;
>>       bool claim_edge_triggered_timers;
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 0080577e1a9..53f4a96e517 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1759,24 +1759,24 @@ void virt_machine_done(Notifier *notifier, void *data)
>>   
>>   static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>>   {
>> -    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
>> +    uint8_t clustersz;
>>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>>   
>> -    if (!vmc->disallow_affinity_adjustment) {
>> -        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
>> -         * GIC's target-list limitations. 32-bit KVM hosts currently
>> -         * always create clusters of 4 CPUs, but that is expected to
>> -         * change when they gain support for gicv3. When KVM is enabled
>> -         * it will override the changes we make here, therefore our
>> -         * purposes are to make TCG consistent (with 64-bit KVM hosts)
>> -         * and to improve SGI efficiency.
>> -         */
>> -        if (vms->gic_version == VIRT_GIC_VERSION_2) {
>> -            clustersz = GIC_TARGETLIST_BITS;
>> -        } else {
>> -            clustersz = GICV3_TARGETLIST_BITS;
>> -        }
>> +    /*
>> +     * Adjust MPIDR like 64-bit KVM hosts, which incorporate the
>> +     * GIC's target-list limitations. 32-bit KVM hosts currently
>> +     * always create clusters of 4 CPUs, but that is expected to
>> +     * change when they gain support for gicv3. When KVM is enabled
>> +     * it will override the changes we make here, therefore our
>> +     * purposes are to make TCG consistent (with 64-bit KVM hosts)
>> +     * and to improve SGI efficiency.
> 
> 32-bit KVM hosts are dead a long time, so we could definitely trim
> this comment to at least remove those sentences. We'd also have
> to double check arm64 KVM to see if the comment is still accurate,
> since the comment is so old. Or, we could just delete the comment.

I agree that this comment needs an update, but it could also be done in a 
separate patch later, so from my side for this patch here:

Reviewed-by: Thomas Huth <thuth@redhat.com>


