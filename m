Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEFAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oPD-0004yr-9i; Tue, 30 Apr 2024 10:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1oPA-0004yU-Bi
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1oP1-0007dv-BH
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714487054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kct1NqAqBgxk43O08pP+Qrn7gCN7biaBcNYB3Z+nVTY=;
 b=Gh8b6gCI2dz9HPUc0e+7FICsaWOcYP992309CvqKkfPN7csi3VA9eeqXkGQanCkoL3QMID
 k3yFe+gToLC2ZJtfXv4O+qRmRnGl/b+xfNcosZkm+jhcGpD/GaZGyUZc0ua8IpPyUWbDoO
 1EaNFGiT9w0gD4RA/b2MScybEESCd6s=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-JoHNlUoBMymwZlOcXYEpPw-1; Tue, 30 Apr 2024 10:24:12 -0400
X-MC-Unique: JoHNlUoBMymwZlOcXYEpPw-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6ef88ce1ef9so457873a34.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714487052; x=1715091852;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kct1NqAqBgxk43O08pP+Qrn7gCN7biaBcNYB3Z+nVTY=;
 b=J7A+S0QOw6J8mh2qS0QJ/h8CWCX46SOZZo1NPsUHvXFPnjEvZuDAi4bhxU3XvR7fn7
 //3HFd8DVO7p//TvKoFoewNYWY0KIQPMBgiyvAeaeBxxxq/u9TRiz03nMIqtfcFzrR4C
 r5wB9SFJOpjU4rfq21qrRIkNSHxrd08w7bsYKA9h2Ms/dQC6f3u9Xp77JzYHZAE0kmZ8
 CcbSoyFPZgU0veF45R9fRE7VxVLGdcxK+WEHRsi7hlAWIpdOWDNCFyYsmE6RT317uR3F
 AQoM0y3ItpKvKPCsX+9XJpAm2uGeZO5vbBjJIElHq+Fyos15zy6XIVlH3WlY43PZrZMs
 2iPQ==
X-Gm-Message-State: AOJu0Yzz3mptosVJJW3ox1yNFTKTSkXmxNvrG166jXu0e2YislX5dw4O
 gEx+wpYRTj6MvsLQG3pnkudK8YopkN8qtYokrBZXBnjbjSkYInuVmy6d3vCoYdhI/05V4n/xhuJ
 WQ2u/9Ejg9LYMLV5xo2GdlqgTY1k8P/NMH1fVcFCD69lyCnJCIdFr
X-Received: by 2002:a05:6830:2006:b0:6ee:29d3:81bc with SMTP id
 e6-20020a056830200600b006ee29d381bcmr7300324otp.2.1714487051787; 
 Tue, 30 Apr 2024 07:24:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVm5Dv43JAds6PsA9nLHnY/wEM6JGCxDZDRI338CkfI+F8zec30moWFUkJ9wEO7cTrbVxp1A==
X-Received: by 2002:a05:6830:2006:b0:6ee:29d3:81bc with SMTP id
 e6-20020a056830200600b006ee29d381bcmr7300303otp.2.1714487051522; 
 Tue, 30 Apr 2024 07:24:11 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 b10-20020a0cf04a000000b006986c3f3d21sm11417482qvl.116.2024.04.30.07.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 07:24:11 -0700 (PDT)
Message-ID: <f958af03-00d3-4d3a-b54b-f060c8fc70df@redhat.com>
Date: Tue, 30 Apr 2024 16:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Attach the sclpconsole to the /machine/sclp node
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240430080408.415890-1-thuth@redhat.com>
 <e6954259-a211-4fa3-9093-3675b97c4a5c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <e6954259-a211-4fa3-9093-3675b97c4a5c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/04/2024 13.58, Cédric Le Goater wrote:
> On 4/30/24 10:04, Thomas Huth wrote:
>> The sclpconsole currently does not have a proper parent in the QOM
>> tree, so it shows up under /machine/unattached - which is somewhat
>> ugly. Let's attach it to /machine/sclp instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   include/hw/s390x/sclp.h    |  2 +-
>>   hw/s390x/s390-virtio-ccw.c | 11 +++++++----
>>   hw/s390x/sclp.c            |  4 +++-
>>   3 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>> index b405a387b6..abfd6d8868 100644
>> --- a/include/hw/s390x/sclp.h
>> +++ b/include/hw/s390x/sclp.h
>> @@ -222,7 +222,7 @@ static inline int sccb_data_len(SCCB *sccb)
>>   }
>> -void s390_sclp_init(void);
>> +Object *s390_sclp_init(void);
>>   void sclp_service_interrupt(uint32_t sccb);
>>   void raise_irq_cpu_hotplug(void);
>>   int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code);
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 4dcc213820..e2f9206ded 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -237,11 +237,13 @@ static void s390_create_virtio_net(BusState *bus, 
>> const char *name)
>>       }
>>   }
>> -static void s390_create_sclpconsole(const char *type, Chardev *chardev)
>> +static void s390_create_sclpconsole(Object *sclp, const char *type,
>> +                                    Chardev *chardev)
>>   {
>>       DeviceState *dev;
>>       dev = qdev_new(type);
>> +    object_property_add_child(sclp, type, OBJECT(dev));
>>       qdev_prop_set_chr(dev, "chardev", chardev);
>>       qdev_realize_and_unref(dev, sclp_get_event_facility_bus(), 
>> &error_fatal);
>>   }
>> @@ -252,8 +254,9 @@ static void ccw_init(MachineState *machine)
>>       int ret;
>>       VirtualCssBus *css_bus;
>>       DeviceState *dev;
>> +    Object *sclp;
>> -    s390_sclp_init();
>> +    sclp = s390_sclp_init();
> 
> I would simply drop s390_sclp_init(), same for :
> 
>    void s390_init_tod(void);
>    void s390_init_ap(void);
>    void s390_stattrib_init(void);
>    void s390_skeys_init(void);
>    void s390_flic_init(void);
> 
> These routines all do the same and are not very useful TBH, and I would
> add pointers under the s390x MachineState possibly.

Some of them seem to do a little bit more things, like checking whether the 
feature is available or not, e.g. s390_init_ap() ... IMHO it makes sense to 
keep at least those?

But for s390_sclp_init ... it could be inlined, indeed, especially if we 
also switch the object_unref + qdev_realize in there into 
qdev_realize_and_unref. Let me try to do that in a v2 ...

  Thomas


