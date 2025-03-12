Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D77C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOcv-0001Jm-Dw; Wed, 12 Mar 2025 12:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOcg-0001BS-S8
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsOcf-00086T-7E
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741795676;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1SBYqX0kE3/4QZuDXZSGhhQS3YjWMXj8gtvzLqz968=;
 b=jM+sbmOw5GmXCPY4BXlkGSsr5QRI+aO42mSrBPfSwxfhlHHPp4ESgHmXD6pjLMyD/VSwmm
 dV+e9ekFQ5dXPGgyJqLBRGWyLGOpSirKvc1LTJXyWgcLK1E2J+kv4eUUK1C3YlBm2vnest
 bBQ0KvNL9X457LT2taHa6Kukavb79MQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-tWFq47JqOyWSSxXF3tfr9w-1; Wed, 12 Mar 2025 12:07:51 -0400
X-MC-Unique: tWFq47JqOyWSSxXF3tfr9w-1
X-Mimecast-MFC-AGG-ID: tWFq47JqOyWSSxXF3tfr9w_1741795671
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c544d2c34fso769277085a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741795671; x=1742400471;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1SBYqX0kE3/4QZuDXZSGhhQS3YjWMXj8gtvzLqz968=;
 b=v33aifqd9RvvK9hfwzjgyB0EfCtcrgQD0FLULVOItVH2CUnWz42633E20JykVfifGu
 au1MpF1FJB8ecZI+7U+b4JQEHbX5qjvi6QJaf/v2jaPIqHhCLUmlW8oHsDJaQ9lQaW7z
 WmjXbyZ3IZ+pROmqzWsY1D1BdaZ2zTFXNoYOA/qIRpklvp6XYqlhkuop0hJIr+XxT0NV
 Q3eVPjcSI9wLgPoUE/nbU3xuXLFQWZdxVEld7AOVjrx6v5LWtdUrZKYEWAKunWIlnHlW
 lA1dovvQ5+JA49fNT1yuXdysv6XDXLJfXZHFK9tgoL9f70nguZpNo0JyeWMQF0hgJpGF
 hg5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVrLZ29JWgBc5/dEg19F4H+wEYMGRptMTsdMbXzDTOevylxMX6FYWwzeZOFJfbGJI9dStuyXLswvWK@nongnu.org
X-Gm-Message-State: AOJu0YxekN1XW0VumEAqzkofIEeU4cc8Lhs5JJIRd2ivJ9En6LXIUa7G
 2PdU3K2YfQzWu3ygWYjllYs52aTAkhnMlz8J7RSx79WAioXbbhozKA+Rjt+sjW5Ez9DYmvm7XwR
 cfpcIZheqsxevLn05nToqG2eZK0OOpc2mKz7quzOsFUKKdxm9n0ra
X-Gm-Gg: ASbGncsnAAyexViDlMgKiig0sbrmfUopB9OLwae/83r9b6D1s5MJO29DpCpTM3u372a
 RO9J8nfSnX4m82jKOS+UHR3ib7n0e0WeFZriSnRycoglddd2AIK0HH4x3bP3ZV2mDDUF5Bw3pUM
 LctiUP1JzzdixPFBOpnhkjc4R/bqwdZbUJTCOA8vz12SrK3UggNuUiDTlG4nUVFdYmuXXaMosID
 AmH6TXZavUZVmkN87zRZ9CwBS2vej5ZoK6xVuD6h7mzZcvMNtfwfuczhGi25dtzY6pIjKE1L1Zj
 +ZZ/vy4dG09mpGxyKtKe4soGrlSGEBzexrUr75AW2HZ0gUPbbM8hjA+9kD/dF7o=
X-Received: by 2002:a05:620a:488c:b0:7c5:3b8d:9f29 with SMTP id
 af79cd13be357-7c53b8d9f66mr3110151185a.21.1741795670756; 
 Wed, 12 Mar 2025 09:07:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG736XIFE5+oFEaWfFJkNw2hngbSVBRghw6pT5xpOWYE8vQ9J4mo52h1yFetb7Q8CuKo7x8JA==
X-Received: by 2002:a05:620a:488c:b0:7c5:3b8d:9f29 with SMTP id
 af79cd13be357-7c53b8d9f66mr3110147085a.21.1741795670455; 
 Wed, 12 Mar 2025 09:07:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c53df21c89sm706935085a.38.2025.03.12.09.07.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 09:07:49 -0700 (PDT)
Message-ID: <79bcc36c-1a12-4b18-a54c-afe734d6bef0@redhat.com>
Date: Wed, 12 Mar 2025 17:07:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,


On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> User must associate a pxb-pcie root bus to smmuv3-accel
> and that is set as the primary-bus for the smmu dev.
why do we require a pxb-pcie root bus? why can't pci.0 root bus be used
for simpler use cases (ie. I just want to passthough a NIC in
accelerated mode). Or may pci.0 is also called a pax-pcie root bus?

Besides, why do we put the constraint to plug on a root bus. I know that
at this point we always plug to pci.0 but with the new -device option it
would be possible to plug it anywhere in the pcie hierarchy. At SOC
level can't an SMMU be plugged anywhere protecting just a few RIDs?
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-accel.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index c327661636..1471b65374 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -9,6 +9,21 @@
>  #include "qemu/osdep.h"
>  
>  #include "hw/arm/smmuv3-accel.h"
> +#include "hw/pci/pci_bridge.h"
> +
> +static int smmuv3_accel_pxb_pcie_bus(Object *obj, void *opaque)
> +{
> +    DeviceState *d = opaque;
> +
> +    if (object_dynamic_cast(obj, "pxb-pcie-bus")) {
> +        PCIBus *bus = PCI_HOST_BRIDGE(obj->parent)->bus;
> +        if (d->parent_bus && !strcmp(bus->qbus.name, d->parent_bus->name)) {
> +            object_property_set_link(OBJECT(d), "primary-bus", OBJECT(bus),
> +                                     &error_abort);
if you want to stop the recursive search I think you need to return
something != 0 here.

I don't really understand why we don't simply set the primary-bus to
<bus> where -device arm-smmuv3-accel, bus=<bus>? or maybe enforce that
this bus is an actual root bus if we really need that?
> +        }
> +    }
> +    return 0;
> +}
>  
>  static void smmu_accel_realize(DeviceState *d, Error **errp)
>  {
> @@ -17,6 +32,9 @@ static void smmu_accel_realize(DeviceState *d, Error **errp)
>      SysBusDevice *dev = SYS_BUS_DEVICE(d);
>      Error *local_err = NULL;
>  
> +    object_child_foreach_recursive(object_get_root(),
> +                                   smmuv3_accel_pxb_pcie_bus, d);
> +
>      object_property_set_bool(OBJECT(dev), "accel", true, &error_abort);
>      c->parent_realize(d, &local_err);
>      if (local_err) {
> @@ -33,6 +51,7 @@ static void smmuv3_accel_class_init(ObjectClass *klass, void *data)
>      device_class_set_parent_realize(dc, smmu_accel_realize,
>                                      &c->parent_realize);
>      dc->hotpluggable = false;
> +    dc->bus_type = TYPE_PCIE_BUS;
shouldn't it below to 3/20? It is not really related to primary_bus
setting? Thanks Eric
>  }
>  
>  static const TypeInfo smmuv3_accel_type_info = {


