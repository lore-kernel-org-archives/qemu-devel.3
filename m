Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A383CC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 11:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1m7x-0004Kt-0P; Tue, 30 Apr 2024 07:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s1m7v-0004Ke-I6
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 07:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s1m7t-0004lO-IS
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 07:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714478304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMYO88dnDswxzZi8KR/5yWkA1R9eesm5kjTFBTlE7tc=;
 b=OkuCbm+zFkANpuYljW3HcJN/Yn0ySMwJgpjiqGH2NH4y4nDF7JMri/BISq3YRLMjOSuquB
 +lICD2/XXXvo+9ppI+ZZA3aE0ruECc4rMo3Y/IGdbwm1w/sWA/Db9XgwJEpfKGLEcXriuD
 kdLnf9f/C9KhiWBeVV+9EUQwpUSAAog=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-4-J7MQxwPfi91Ubauxc77g-1; Tue, 30 Apr 2024 07:58:23 -0400
X-MC-Unique: 4-J7MQxwPfi91Ubauxc77g-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dcc0bcf9256so9162718276.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 04:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714478302; x=1715083102;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BMYO88dnDswxzZi8KR/5yWkA1R9eesm5kjTFBTlE7tc=;
 b=AC6Omb8woCIcicKsTJ0v4Vy9ILh0SV5x2EJ4rJQmXLiM/Hxfviz4yq6x2j6lXH3n0a
 tRDEk6LEA4NexBS4cvNfmKiK0F+YkADhYkratu+ftXpi/ZmjaOSOPyxDHqQOXgOuKcFi
 C3DUdEsZSASSti0pKzEYesBtEuXNllwzCqB6yaJnWjijdTdtf0KXAMQCSbhkmc0jAcZ3
 rwaefyTqyGXMNGszLduKxVsLA2NyZmXguBrzMmALbA2r761d3o9gXSfufcak2ZDnDwsG
 Q6zMxUXDUHxM7uB80b5UQUuyOngCd0l1IVZisPld4ONjQPIxK+uZiGOOoKc69CL2ISeP
 Yv5A==
X-Gm-Message-State: AOJu0YzMggYFmigng6IbJF7VHxJtFCj2MKITr3+IQ497QDrw3geRl4E7
 9VjtzVB4OuPyDzkad3QZvb4SrZZjMWTtna5Vyy13uDIzcWRYfx+znTZCdSzM1rrPUn4M4WhHbgM
 Jbkx0ppmVjMvS3kXZEyj9fDwa/A30sBlz5M3SW/SQfiv+Xo/zNNJv
X-Received: by 2002:a25:cecc:0:b0:dc6:ff32:aae2 with SMTP id
 x195-20020a25cecc000000b00dc6ff32aae2mr2154614ybe.63.1714478302425; 
 Tue, 30 Apr 2024 04:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOrRIJhFH5L2C/NHS9GadAE1fKyXJRFQ8+Al2JLxKPGu2ZM/GeNZZc4wp3SpeRPjN/mLiI0w==
X-Received: by 2002:a25:cecc:0:b0:dc6:ff32:aae2 with SMTP id
 x195-20020a25cecc000000b00dc6ff32aae2mr2154601ybe.63.1714478302030; 
 Tue, 30 Apr 2024 04:58:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h5-20020ac85485000000b00439cccb91b2sm7467581qtq.73.2024.04.30.04.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 04:58:21 -0700 (PDT)
Message-ID: <e6954259-a211-4fa3-9093-3675b97c4a5c@redhat.com>
Date: Tue, 30 Apr 2024 13:58:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Attach the sclpconsole to the /machine/sclp node
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240430080408.415890-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240430080408.415890-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/30/24 10:04, Thomas Huth wrote:
> The sclpconsole currently does not have a proper parent in the QOM
> tree, so it shows up under /machine/unattached - which is somewhat
> ugly. Let's attach it to /machine/sclp instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/s390x/sclp.h    |  2 +-
>   hw/s390x/s390-virtio-ccw.c | 11 +++++++----
>   hw/s390x/sclp.c            |  4 +++-
>   3 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index b405a387b6..abfd6d8868 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -222,7 +222,7 @@ static inline int sccb_data_len(SCCB *sccb)
>   }
>   
>   
> -void s390_sclp_init(void);
> +Object *s390_sclp_init(void);
>   void sclp_service_interrupt(uint32_t sccb);
>   void raise_irq_cpu_hotplug(void);
>   int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4dcc213820..e2f9206ded 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -237,11 +237,13 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
>       }
>   }
>   
> -static void s390_create_sclpconsole(const char *type, Chardev *chardev)
> +static void s390_create_sclpconsole(Object *sclp, const char *type,
> +                                    Chardev *chardev)
>   {
>       DeviceState *dev;
>   
>       dev = qdev_new(type);
> +    object_property_add_child(sclp, type, OBJECT(dev));
>       qdev_prop_set_chr(dev, "chardev", chardev);
>       qdev_realize_and_unref(dev, sclp_get_event_facility_bus(), &error_fatal);
>   }
> @@ -252,8 +254,9 @@ static void ccw_init(MachineState *machine)
>       int ret;
>       VirtualCssBus *css_bus;
>       DeviceState *dev;
> +    Object *sclp;
>   
> -    s390_sclp_init();
> +    sclp = s390_sclp_init();

I would simply drop s390_sclp_init(), same for :

   void s390_init_tod(void);
   void s390_init_ap(void);
   void s390_stattrib_init(void);
   void s390_skeys_init(void);
   void s390_flic_init(void);

These routines all do the same and are not very useful TBH, and I would
add pointers under the s390x MachineState possibly.

Thanks,

C.





>       /* init memory + setup max page size. Required for the CPU model */
>       s390_memory_init(machine->ram);
>   
> @@ -302,10 +305,10 @@ static void ccw_init(MachineState *machine)
>   
>       /* init consoles */
>       if (serial_hd(0)) {
> -        s390_create_sclpconsole("sclpconsole", serial_hd(0));
> +        s390_create_sclpconsole(sclp, "sclpconsole", serial_hd(0));
>       }
>       if (serial_hd(1)) {
> -        s390_create_sclpconsole("sclplmconsole", serial_hd(1));
> +        s390_create_sclpconsole(sclp, "sclplmconsole", serial_hd(1));
>       }
>   
>       /* init the TOD clock */
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 893e71a41b..75d45fb184 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -379,13 +379,15 @@ void sclp_service_interrupt(uint32_t sccb)
>   
>   /* qemu object creation and initialization functions */
>   
> -void s390_sclp_init(void)
> +Object *s390_sclp_init(void)
>   {
>       Object *new = object_new(TYPE_SCLP);
>   
>       object_property_add_child(qdev_get_machine(), TYPE_SCLP, new);
>       object_unref(new);
>       qdev_realize(DEVICE(new), NULL, &error_fatal);
> +
> +    return new;
>   }
>   
>   static void sclp_realize(DeviceState *dev, Error **errp)


