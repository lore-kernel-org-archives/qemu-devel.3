Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651F7C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvz1-0003Aq-KZ; Fri, 28 Feb 2025 03:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnvyy-00031D-P6
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:44:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnvyw-0004PV-HG
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740732268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fLIVo/NHr99vRGZgjdqPyyn2qUcrsQ8XUSuMD4O56vE=;
 b=aOWmkf50ivJ+dEJqo0LHEMSUn9yzlSNlVgfNFRYva5nfwWk/Ps/+qU4f0fVOFWX9lrUaHl
 W9hNQTxZ/Rsz0xFi6sMZ9DCFpURX9eIxOCGEr7Bj+gbfCJuz0MqvSnqMNle2i4pimGkS/2
 Q0O03XLga2HoqkmdULICGw+wu+CRiuQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-lFDb382mOMyorg4xox88xg-1; Fri, 28 Feb 2025 03:44:25 -0500
X-MC-Unique: lFDb382mOMyorg4xox88xg-1
X-Mimecast-MFC-AGG-ID: lFDb382mOMyorg4xox88xg_1740732264
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390d5f1e05cso740693f8f.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 00:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740732264; x=1741337064;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLIVo/NHr99vRGZgjdqPyyn2qUcrsQ8XUSuMD4O56vE=;
 b=kjRWM9PxLRqAdzClRuBIQ49cyT02PyDYkiZ0HHlolMtioil0h6qn361yKdAk/h1gmF
 dsGslcR2+ohXe46VYPvSd0/gLzqsbVHV2DkJzkPsqYm9VOEsSHlCiZYPblYlhDI56zoX
 MZxk07PIboZgUlk1NuripuGPFiWphNqB9h6MM0gv5z/+c1rBVux5ciyj8mingl7sbzOB
 vJ0ElBDEtgL8Uwrv2RzT/2vSf3Y7vmlDCE8lsphxD2oF+KkzK+RNHEvYbP81MpbaQwBE
 6a5ui1F/MHHRaOGvb4PLmHHzfPYKOwbzcstQmmqmn4krFJi+jYh8yUH9ZliSCG/FJXlU
 v0Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJSWh7IqkcGRSnjKYdWwsEdvLH6R+ZWqfqc31WK0G78Vu+hB6xqrehFjqh8XZRh+0F6K/4KGy/hgYt@nongnu.org
X-Gm-Message-State: AOJu0YzhZVpQDZDzjrIecX21ZyOGfMC5B2bzV7x0oLZseQqGwKMcme7u
 RTGnq+VTcrPPNStLFfCoka/08Q5jst31qdDhZxu8bm/tdyRA7TiLY/Zce2/SN756uRlTSPQUnBq
 FSfs7KsbjUSpkovXjGAmSFBdBGFQXyUlt+1ZxfMg0Z83S8/AK4/uD
X-Gm-Gg: ASbGncufxe/gfi/avSBIDvK5ZgDnvM0HQ7gB1J4ReLOpm+MTFV1qKzUjybfxSiWbkRS
 s+XOqDEQxkW32OSbz6jODb3UOFPZajR2DTllBK0Brf2MSlGzRtwvoG9V9rZ3Zljd8+gbSzAZzaf
 REL5jyEi5Dbl2BI5+QrV3KXI97ojr1iHZz0SokV12TXsYR3voVejQ5GCfDlfFIKSGmEJYUESnyX
 1IIuITZ/I4ekhGTIRnuwMawM1sBJXOM6Q1ksl1CF5XX3/xOFR1FTZxm//QML54O66JYsCf0UYbC
 kDPhzcOlppZ0N8BtouiN24I1ZARVJEruqtPTTkjk/ZSozJlLdPaOk2ALnig=
X-Received: by 2002:a5d:64a6:0:b0:390:eb01:655b with SMTP id
 ffacd0b85a97d-390eca56475mr1949063f8f.54.1740732264109; 
 Fri, 28 Feb 2025 00:44:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFij/3RqNOMIe3TaNtwigj6JTZ5OKfygVP33rWEVnRZuQJY0yzjuRfD5Sa89vQL5HhyQ3gfkw==
X-Received: by 2002:a5d:64a6:0:b0:390:eb01:655b with SMTP id
 ffacd0b85a97d-390eca56475mr1949042f8f.54.1740732263755; 
 Fri, 28 Feb 2025 00:44:23 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba571274sm80487605e9.31.2025.02.28.00.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 00:44:23 -0800 (PST)
Message-ID: <a44145e8-b272-4b59-8b4e-f1b353a667b0@redhat.com>
Date: Fri, 28 Feb 2025 09:44:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 32/36] vfio/migration: Make
 x-migration-multifd-transfer VFIO property mutable
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <f558685fa2b2d82220d65120fb4bd9c77e28e2d4.1739994627.git.maciej.szmigiero@oracle.com>
 <4d8d1101-f0f4-4e9d-97dc-fe4e5a4b8f58@redhat.com>
 <62c96ca5-c3c5-491f-8b5d-b87cf7df1230@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <62c96ca5-c3c5-491f-8b5d-b87cf7df1230@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/26/25 22:05, Maciej S. Szmigiero wrote:
> On 26.02.2025 18:59, Cédric Le Goater wrote:
>> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> DEFINE_PROP_ON_OFF_AUTO() property isn't runtime-mutable so using it
>>> would mean that the source VM would need to decide upfront at startup
>>> time whether it wants to do a multifd device state transfer at some
>>> point.
>>>
>>> Source VM can run for a long time before being migrated so it is
>>> desirable to have a fallback mechanism to the old way of transferring
>>> VFIO device state if it turns to be necessary.
>>>
>>> This brings this property to the same mutability level as ordinary
>>> migration parameters, which too can be adjusted at the run time.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/pci.c | 12 +++++++++---
>>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 184ff882f9d1..9111805ae06c 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3353,6 +3353,8 @@ static void vfio_instance_init(Object *obj)
>>>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>>>   }
>>> +static PropertyInfo qdev_prop_on_off_auto_mutable;
>>
>> please use another name, like vfio_pci_migration_multifd_transfer_prop.
> 
> Done.
> 
>> I wish we could define the property info all at once.
> 
> I'm not sure what you mean here, could you please elaborate a bit more?

I meant :

     static const PropertyInfo vfio_pci_migration_multifd_transfer_prop = {
         .name = "OnOffAuto",
         .description = "on/off/auto",
         .enum_table = &OnOffAuto_lookup,
         .get = qdev_propinfo_get_enum,
         .set = qdev_propinfo_set_enum,
         .set_default_value = qdev_propinfo_set_default_value_enum,
         .realized_set_allowed = true,
     };

which requires including "hw/core/qdev-prop-internal.h".

I think your method is preferable. Please add a little comment
before :

     qdev_prop_on_off_auto_mutable = qdev_prop_on_off_auto;
     qdev_prop_on_off_auto_mutable.realized_set_allowed = true;

Thanks,

C.



