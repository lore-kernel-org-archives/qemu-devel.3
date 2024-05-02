Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4C9C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 07:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2RK2-0005vD-Ga; Thu, 02 May 2024 03:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s2RJv-0005tJ-Fk
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s2RJq-0003KL-SL
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714636649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjnV+aAwgTElHzDp5N/p+uQ6DcDbydhs0bhvq7UkLMY=;
 b=fDpSuq9DNBQYILRkfCmJkGqV42W5lSYOcbYybo75h4XSOzk6nNwBSohEi1mUKLX7SEANl+
 XbMSXd+mzuwGx2WUJR8908ScPsm45Ouk+qs79QJlSgVbe5+oe+o1xltxyHvTZP8g9uuwc0
 isphMa2HdWFScgk4WTZcKfeKbNT2Kvg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-HiAFUq0OO5eWHPes2-o7jA-1; Thu, 02 May 2024 03:57:28 -0400
X-MC-Unique: HiAFUq0OO5eWHPes2-o7jA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5192d01f465so7500327e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 00:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714636646; x=1715241446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fjnV+aAwgTElHzDp5N/p+uQ6DcDbydhs0bhvq7UkLMY=;
 b=MtvxuiBO6QbpO3WqT3xE4oa4w4ip7AC1i1MRwFQzRgmYoOIFcIm/bEe8YWrkUqWH4I
 D4anPO+hDFC5V+KmsUlZE7ZGDYrVVfKzRJnw3ychilsVejkzDt40vM90TGVf6G26ZBSj
 9pg1GQulUTe6bMGJOoCkbYD0eUMAlTTBOYBT/c5eFv932kpmlak8UQEhKtmhmi3w569d
 yKk3rPEbJZYaoMsr7/DBG2YPgmQOqiT+a1+EQVR4vripdF/egC5jQT7ToiEM16Ocudyc
 wzFmbQumUwDhOlwNo9vKc118un2Ram7Sy4osGhJTKM4xhNP0I3wGWMh9F/u2py+WOXhm
 rd/g==
X-Gm-Message-State: AOJu0Yx39+dmJ7m4sXx157LKIUEZJpuO+MrRvgmX7U5Vra/Tp/H9baRg
 ukOJyildmCtYAIIB8b7dBV8EES6uGCaWUfjzo1Cum0HGlClVencTFtcep0XMhtMpkyZUOCD1maU
 sscwZkuFlrZ46w9OIrrT2CBK8mYihE/OWDEcVcZQJuOa0f5mL0j6g
X-Received: by 2002:a05:6512:1042:b0:51d:9e46:6cfe with SMTP id
 c2-20020a056512104200b0051d9e466cfemr3049657lfb.42.1714636646569; 
 Thu, 02 May 2024 00:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPrrWhi6qxUPQ+ykDuuIMUGuxdG5LlFkYS6ZYGzX+hVUhy+mRxG2d5FHdfzAuDzotrAqmoCw==
X-Received: by 2002:a05:6512:1042:b0:51d:9e46:6cfe with SMTP id
 c2-20020a056512104200b0051d9e466cfemr3049634lfb.42.1714636646145; 
 Thu, 02 May 2024 00:57:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 dn2-20020a0560000c0200b0034e14d59f07sm594369wrb.73.2024.05.02.00.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 00:57:25 -0700 (PDT)
Message-ID: <d4aa4852-196f-42bd-884f-5234f72bfad8@redhat.com>
Date: Thu, 2 May 2024 09:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/s390x: Attach the sclpconsole to
 /machine/sclp/s390-sclp-event-facility
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240430190843.453903-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240430190843.453903-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 4/30/24 21:08, Thomas Huth wrote:
> The sclpconsole currently does not have a proper parent in the QOM
> tree, so it shows up under /machine/unattached - which is somewhat
> ugly. We should rather attach it to /machine/sclp/s390-sclp-event-facility
> where the other devices of type TYPE_SCLP_EVENT already reside.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

> ---
>   hw/s390x/s390-virtio-ccw.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 5c83d1ea17..41be8bf857 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -242,11 +242,13 @@ static void s390_create_virtio_net(BusState *bus, const char *name)
>   
>   static void s390_create_sclpconsole(const char *type, Chardev *chardev)
>   {
> +    BusState *ev_fac_bus = sclp_get_event_facility_bus();

This routine sclp_get_event_facility_bus() which scans all the machine
could be avoided and even removed. For that, SCLPDevice should be an
attribute of the machine. This means reshuffling definitions and
object instanciations a little in the code. Would you be OK with that ?

Other machine units/models could undergo the same kind of changes.

Thanks,

C.

>       DeviceState *dev;
>   
>       dev = qdev_new(type);
> +    object_property_add_child(OBJECT(ev_fac_bus->parent), type, OBJECT(dev));
>       qdev_prop_set_chr(dev, "chardev", chardev);
> -    qdev_realize_and_unref(dev, sclp_get_event_facility_bus(), &error_fatal);
> +    qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
>   }
>   
>   static void ccw_init(MachineState *machine)


