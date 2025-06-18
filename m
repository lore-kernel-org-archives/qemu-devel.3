Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625BAC7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 17:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRw97-0003CN-TV; Wed, 18 Jun 2025 13:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRw8x-0003Ao-OB
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 13:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRw8r-0000cO-Cz
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 13:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750266003;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzisyutyk+ywazoiQJehVSACU64Y35jwqVM47Qx80GU=;
 b=RNzN5ozd4k4lT+TpWpm5MV5JU3DwgZDONY+fWa07+TKC4kyHcM3u6a0RpfSQgDc84eIRQM
 MXKp40RqYOuj3cwrdULdMcOQPtZpl6xuPGgCAaZqwQU6XlLJQ+MjBxezDYQY/yXe0Wv06B
 6cYS0tfPxrcZZQ7LLGMWBKAe5oORur4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-9GgAI44WOO2cKqtCUTDk5Q-1; Wed, 18 Jun 2025 12:59:59 -0400
X-MC-Unique: 9GgAI44WOO2cKqtCUTDk5Q-1
X-Mimecast-MFC-AGG-ID: 9GgAI44WOO2cKqtCUTDk5Q_1750265998
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453080e4741so57802255e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 09:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750265998; x=1750870798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uzisyutyk+ywazoiQJehVSACU64Y35jwqVM47Qx80GU=;
 b=RE0Vaaq64Tnl4HVsYjgwTDIL4SvLMlZk/YSXjEGyzkizYHAhAVGNoPGrlc5vLv8tjC
 nCB7SXD5y15RT8JVdN7ADTSA0hmsQm8KWl36T8uMzjanA5xT993V3vROgUsFMZ9RZNNj
 YwPx27qMv67maMhqzrG0lJYPg49TkcYmskJQTBo483rset8Bpk3yzQksfGzFa7LPvml4
 PutvRFbpNGjmiYoAUy7OryD1v5xK9O+nI5n4YlUB5x+cakIsr86P4C1z+BSRS70Mxwn6
 HSaIaEn5HUy1Er4+FUlnLnz1V4Rye29ZxZguaZaBzABksYf6YqS/wECtSHSICdvcGGV+
 uLBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVw08C2I92MC4e0IlEplzC+1K8I0Fo6UpXeyUd0PC140/WdvJqjtklp0DhshByGGHtCejolw5lRaoE@nongnu.org
X-Gm-Message-State: AOJu0YyQX5SlXU2xyQlvcte3lBBOXYK81DHv/Z3V4u0WsfNwm0uCXTR9
 5QMUEdnxiehf3DxItmXQYa0X8UlK1bHPI8BwqqbOzo+BfLcikAjwltny+6h/4ae8e+fgL5kBWDv
 ntZaBlMA5uW9aEDQryFCrtHe5ZSSIkm5GzWE+YjAn8JKTJHm+xN4ITJAI
X-Gm-Gg: ASbGncueZpLDHQXc354B/J3bBi49o8ua8vrtgTEEfaYMdSkr3CWSE1ATjm5fR5+T/zh
 ui/VqXjESjaClhgizXjQgQ95ow4T3Dan144KcPGEhSUT7fjdCQlpqGWv5enobOBu4bj/ymEYPks
 7+xfwJLzU1Muuk+oAwZ5je9124j2eM5MjRd2nDdYaoCGLp3g1mqlR3KCC5xYuyvSTKBTJlPMnHw
 TwaP0EqRJ5AyqPAuLWSkX8JyRrDXKt490CouAgB9xPSaXZL0S2Uo8+b0gJ5Nn6dxgVrOtsfDdt5
 9WwA+xRrKx31MheZIuFTcCyQUpNjvA8IacIF2K7hLHH6l6mgd6fGvFEyTgysQgJSet5bhQ==
X-Received: by 2002:a05:600c:c117:b0:450:d4ad:b7de with SMTP id
 5b1f17b1804b1-4533cc69257mr157913895e9.3.1750265998176; 
 Wed, 18 Jun 2025 09:59:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRZ6E/N9BNqqe1FMZsd7Jh6SKAm5RA1LQ/Ws/agDjwbU4J/Uwhioic8WdlLCtF7icJ5K3oEw==
X-Received: by 2002:a05:600c:c117:b0:450:d4ad:b7de with SMTP id
 5b1f17b1804b1-4533cc69257mr157913605e9.3.1750265997739; 
 Wed, 18 Jun 2025 09:59:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b3c0d3sm17460155f8f.79.2025.06.18.09.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 09:59:56 -0700 (PDT)
Message-ID: <327b5515-467c-4666-86d6-fb2a99925a8c@redhat.com>
Date: Wed, 18 Jun 2025 18:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Linuxarm <linuxarm@huawei.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
 <20250616112019.00003bce@huawei.com>
 <fcd05844-d2d9-450e-b962-59b0f3964185@redhat.com>
 <20250617175247.00007d43@huawei.com>
 <49d4c4b73e9a44a783332ddfe9a2fbdf@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <49d4c4b73e9a44a783332ddfe9a2fbdf@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

Hi Shameer, Jonathan,

On 6/18/25 10:35 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Sent: Tuesday, June 17, 2025 5:53 PM
>> To: Eric Auger <eric.auger@redhat.com>
>> Cc: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; Linuxarm
>> <linuxarm@huawei.com>; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
>> nicolinc@nvidia.com; ddutile@redhat.com; berrange@redhat.com;
>> imammedo@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
>> smostafa@google.com; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe
>> Root Complex association
>>
>> On Tue, 17 Jun 2025 09:49:54 +0200
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> On 6/16/25 12:20 PM, Jonathan Cameron wrote:
>>>> On Fri, 13 Jun 2025 15:44:43 +0100
>>>> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
>>>>
>>>>> Although this change does not affect functionality at present, it is
>>>> Patch title says PCIe.  This check is vs PCI host bridge.
>>>>
>>>> No idea which one you wanted, but if it is PCIe needs to be
>>>> TYPC_PCIE_HOST_BRIDGE from pcie_host.h not the pci_host.h one
>>>> I think.
>>> I think we need TYPE_PCI_HOST_BRIDGE as we want to check against pxb
>>>
>>> pci-bridge/pci_expander_bridge.c:    .parent        =
>> TYPE_PCI_HOST_BRIDGE,
sorry but I still fail to understand why we can't just check against

TYPE_PCI_HOST_BRIDGE for making sure the SMMU is attached to PXB or GPEX. What does it fail to check? Why shall we care about PCI vs PCIe?

Thanks

Eric

>>
>> Hmm. That's awkward and I'd forgotten that wrinkle.
>> Need a stronger test but which one?  The PXB root bus has a parent of
>> TYPE_PCIE_BUS.  Maybe we can check that?
> Ok. How about we do something like below?
>
>
> @@ -925,6 +926,7 @@ static void smmu_base_realize(DeviceState *dev,
> Error **errp)
>  {
>      SMMUState *s = ARM_SMMU(dev);
>      SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(dev);
> +    PCIBus *pci_bus = s->primary_bus;
>      Error *local_err = NULL;
>
>      sbc->parent_realize(dev, &local_err);
> @@ -937,10 +939,31 @@ static void smmu_base_realize(DeviceState *dev,
> Error **errp)
>                                       g_free, g_free);
>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
>
> -    if (s->primary_bus) {
> -        pci_setup_iommu(s->primary_bus, &smmu_ops, s);
> -    } else {
> +    if (!pci_bus) {
>          error_setg(errp, "SMMU is not attached to any PCI bus!");
> +        return;
> +    }
> +
> +    /*
> +     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
> +     * root complexes to be associated with SMMU.
> +     */
> +    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
> +        object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
> +        /*
> +         * For pxb-pcie, parent_dev will be set. Make sure it is
> +         * pxb-pcie indeed.
> +         */
> +        if (pci_bus->parent_dev) {
> +            if (!object_dynamic_cast(OBJECT(pci_bus), "pxb-pcie-bus")) {
> +                error_setg(errp, "SMMU is not attached to pxb-pcie bus!");
> +                return;
> +            }
> +        }
> +        pci_setup_iommu(pci_bus, &smmu_ops, s);
> +    } else {
> +       error_setg(errp, "SMMU should be attached to a default PCIe
> root complex"
> +                  "(pcie.0) or a pxb-pcie based root complex");
>      }
>  }
>
> Please let me know if this is good enough or not.
>
> Thanks,
> Shameer
>


