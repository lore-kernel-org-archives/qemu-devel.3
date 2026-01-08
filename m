Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73655D1489E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 06:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdjB9-0001sS-Eg; Thu, 08 Jan 2026 01:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdjB7-0001rq-Mj
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdjB5-0004Vf-Sl
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767852442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RJUUY64kVWoX/4RPmptEtLxV18bmxi9plGKbGrYd9xc=;
 b=EqlDOQwAg/MiG7JZBfWAAqe0Em9wI4VwGiY7c3dH6YSOV/mFH9+vhONEYfvd2FZ8hevVzr
 5DMndnEEW7xTYlLZ9pgnScC1AHSC5MiTJyMko96RSFvEmuartGzhzNLWK9hZoEV+b+7rQQ
 txVdF97Nkeo7GdDMEGfJvI+ta7DprVk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-iiK5sOVfMCeMtHHsheiakg-1; Thu, 08 Jan 2026 01:07:21 -0500
X-MC-Unique: iiK5sOVfMCeMtHHsheiakg-1
X-Mimecast-MFC-AGG-ID: iiK5sOVfMCeMtHHsheiakg_1767852440
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b79ff60ed8eso114176266b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 22:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767852440; x=1768457240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RJUUY64kVWoX/4RPmptEtLxV18bmxi9plGKbGrYd9xc=;
 b=iXkSOfDuNGKbsnugFo2ChRhwoBtrGADfJMJvjjS278kqN73c0SHvG30w39F6tFUoMJ
 7xdOgKzubo9OnkYIyoWiCfKeMD6bC+aN9qtVW0RK8FSa4/SxvlGdBKt0oG0bViDvlXcd
 oWT3tcNk72zdiozCjlH7g2vrb6FzDwGxBKJYbd1lnQskisWB/sXZGxvGQ6pgf76HgNl+
 D2bZG+WamBjeOIGxQSsPkfsDC1BP91Sm1/+voc/sstzc1vRUsKqX0PvwQLh7Nxfok4PT
 8fT8srEVp1Y37t6rJeFQKXdGSt5S53XauPCAvjs+u3FGDX+HwiRX/Gu1sRpzD4c+QfHo
 mgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767852440; x=1768457240;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJUUY64kVWoX/4RPmptEtLxV18bmxi9plGKbGrYd9xc=;
 b=ELuOvrdsiljoevQfucwk0988z7qkIX2aPqmHDnAd4yRByl/7u9y8Tm/35RLyLtDSVK
 WVyFjZ7iObNPaES0y+oYoDj+aavceEgLE2VYuhLtbZl4aJ89o4xuGLLUi9L9qp+Wwic4
 0tybvHMbtVPIAY1EmoFW56IQqPi3VkeMlZrDjrrXkoNAkDXhqn5a5jd1e7gSbR3vaccu
 jYtTEkg4x2EJzkBo1WF4XBZ3fGE4FjhZr3vxEWiD+wlzCFdxjaWTlUqpjNSmhqwrzWDQ
 j9p56pZd4JBjzCtl0s0PZvkQlP45YzuudrGywmpNkdJEMBZL7lpgOz4IK8BJF2/SzXfg
 4hTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7vHyrbe2znF/FRAwqBX7Bk0182MIK0vEYYxQlM8APYabGnHazZhitJXtfFkSo45neoOIgw/b6/hu4@nongnu.org
X-Gm-Message-State: AOJu0Yz4000jdmjh9HFW+8jrnCpWoad9PtjjIzRwj3PBmiiETFZu74aI
 Fhmn6+9Vl7YHY766cS1EXniEcOjktXAv1RnEiCaSmN78LAX0R7kJfdcC6Z21KvPg89h3diZZ4D7
 vLwrEnX16DNLvt9TAd7j7uILSbKVkqYfLunuen9res5zuorPWcBJuDyKf
X-Gm-Gg: AY/fxX7Tgi48jLsWpz4Qh/zx5RFyRkWmZswIPHWvXlHFUkHHsJcTcPnYm0Z3EdmPshR
 bRDS3pvvjl3kHEu5wIABuOQ+B7Hb4g7Q4QSDrCN5iDXLJLqXyRBFjPMPjqYw2VJNRdNCZXMKYA9
 I+3HrFMDaneefKtlcDTAdgx68Idw/wq1iZ7oKnA5EmwAoA7wIxhIE2poLnqUKpZRvXji62zqcAQ
 JklN0OrZmU70dCp8Nc4f2v1ry+Xy5+xdRsppdFbOB/H57cYrui1Fy1qbwEB6evQgDUqBTJL0kw9
 SlujREs3PGcSip2cUC83ACBWnDmmwMISoypP44CnogPPBnym9PYNAvOMM6gBjej+caWmtk6iiUp
 kgvw078k=
X-Received: by 2002:a17:907:3e95:b0:b7a:39a2:7f50 with SMTP id
 a640c23a62f3a-b8445179f83mr514757566b.39.1767852440111; 
 Wed, 07 Jan 2026 22:07:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsRdQFL7KUmF5d1aoWobZZVfErk7OCX9sWWC5umqjpVqh3tHJqlaTPoyVdKuoGBnKTD8D4Hw==
X-Received: by 2002:a17:907:3e95:b0:b7a:39a2:7f50 with SMTP id
 a640c23a62f3a-b8445179f83mr514755366b.39.1767852439721; 
 Wed, 07 Jan 2026 22:07:19 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4d1c61sm702763366b.35.2026.01.07.22.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 22:07:19 -0800 (PST)
Message-ID: <09e21b07-922f-4829-8184-ba7dbcf7e838@redhat.com>
Date: Thu, 8 Jan 2026 07:07:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hw: Add "loadparm" property to PCI devices for
 booting on s390x
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-10-jrossi@linux.ibm.com>
 <5e764e58-022c-4d0b-81d3-0564a15dea41@redhat.com>
 <689115e6-c88d-4a43-81a2-a71180263bee@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <689115e6-c88d-4a43-81a2-a71180263bee@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/01/2026 19.46, Jared Rossi wrote:
> 
> 
> On 1/7/26 10:50 AM, Thomas Huth wrote:
>> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> The loadparm is required on s390x to pass the information to the boot loader
>>> such as which kernel should be started or whether the boot menu should be 
>>> shown.
>>>
>>> Because PCI devices do not naturally allocate space for this, the 
>>> property is
>>> added on an architecture specific basis.
>>>
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>> ---
>>>   include/hw/pci/pci_device.h |  3 +++
>>>   hw/pci/pci.c                | 39 +++++++++++++++++++++++++++++++++++++
>>>   hw/s390x/ipl.c              | 11 +++++++++--
>>>   3 files changed, 51 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>>> index 88ccea5011..5cac6e1688 100644
>>> --- a/include/hw/pci/pci_device.h
>>> +++ b/include/hw/pci/pci_device.h
>>> @@ -62,6 +62,9 @@ struct PCIDevice {
>>>       bool partially_hotplugged;
>>>       bool enabled;
>>>   +    /* only for s390x */
>>> +    char *loadparm;
>>> +
>>>       /* PCI config space */
>>>       uint8_t *config;
>>>   diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index b1eba348e0..1ea0d7c54c 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -36,6 +36,7 @@
>>>   #include "migration/qemu-file-types.h"
>>>   #include "migration/vmstate.h"
>>>   #include "net/net.h"
>>> +#include "system/arch_init.h"
>>>   #include "system/numa.h"
>>>   #include "system/runstate.h"
>>>   #include "system/system.h"
>>> @@ -2825,6 +2826,43 @@ int pci_qdev_find_device(const char *id, PCIDevice 
>>> **pdev)
>>>       return rc;
>>>   }
>>>   +static char *pci_qdev_property_get_loadparm(Object *obj, Error **errp)
>>> +{
>>> +    return g_strdup(PCI_DEVICE(obj)->loadparm);
>>> +}
>>> +
>>> +static void pci_qdev_property_set_loadparm(Object *obj, const char *value,
>>> +                                       Error **errp)
>>> +{
>>> +    void *lp_str;
>>> +
>>> +    if (object_property_get_int(obj, "bootindex", NULL) < 0) {
>>> +        error_setg(errp, "'loadparm' is only valid for boot devices");
>>> +        return;
>>> +    }
>>> +
>>> +    lp_str = g_malloc0(strlen(value) + 1);
>>> +    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
>>> +        g_free(lp_str);
>>> +        return;
>>> +    }
>>> +    PCI_DEVICE(obj)->loadparm = lp_str;
>>> +}
>>> +
>>> +static void pci_qdev_property_add_specifics(DeviceClass *dc)
>>> +{
>>> +    ObjectClass *oc = OBJECT_CLASS(dc);
>>> +
>>> +    /* The loadparm property is only supported on s390x */
>>> +    if (qemu_arch_available(QEMU_ARCH_S390X)) {
>>> +        object_class_property_add_str(oc, "loadparm",
>>> + pci_qdev_property_get_loadparm,
>>> + pci_qdev_property_set_loadparm);
>>> +        object_class_property_set_description(oc, "loadparm",
>>> +                                              "load parameter (s390x 
>>> only)");
>>> +    }
>>> +}
>>
>> Adding this unconditionally to each and every PCI device is a little bit 
>> ugly ... could we please limit this to virtio-blk-pci devices for now?
>> (or maybe check if there is a bootindex property, and only add it for 
>> devices with a bootindex property?)
>>
>>  Thomas
>>
> 
> Maybe I'm missing some nuance, but won't the check in 
> pci_qdev_property_set_loadparm() already enforce that this is only added to 
> boot devices?
> 
> Hmm... on second though, I guess the problem is that a loadparm property 
> will still be added (but not necessarily set) for all PCI devices?  I agree 
> that is not good.  I will limit what qualifies for the property to be added 
> in the first place.

Yes, the problem is that this shows up in the user interface, e.g. if you 
run QEMU with "-device qemu-xhci,help" to show the properties of the 
qemu-xhci device. Having a "loadparm" property there could cause quite some 
confusion for the users.

  Thomas


