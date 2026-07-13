Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0657AC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFV3-0000oZ-Gn; Mon, 13 Jul 2026 08:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjFV0-0000o9-TH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:11:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjFUz-0006dH-1P
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:11:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9RAr41122973
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ++CTcPEgNp9u0LBfWzgu3ue0NvUSQ3WiOpSOdNWCYAM=; b=UnJKdHWBHR8yPFmP
 lSaYn2yvQ/jHEZo0q0J/M9UZ34mUpKyLl51s8GFNXzCgVZpxI+YPTW2Mpfy3O//J
 AX4yp1J2xjsjt1NreTGTUa45EblIzlX5B14B9uRVm6kFMLQN89g4xIY4YexpmEar
 XTaOEg8O13AhZf9UTkwaN5o8wEHYjMG7Z9tRrojKkGje3G0Etrepmr4RhATysCWW
 iqtWmXo94FrP4JbIoqlEgESVgcmFNhLOhuwcmYoyaLlUqa2FmwpwXqLAwzO++rvp
 voh5RqQhXatSKBWsrn5z7xjMeZgJEV9oKxS0DsuRoR7rbEE41nez2Sg/IVpfbNKU
 Ebv28g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda0k68-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:10:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso30307481cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783944659; x=1784549459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=++CTcPEgNp9u0LBfWzgu3ue0NvUSQ3WiOpSOdNWCYAM=;
 b=XRdqIrDr01oUwPTEEOcq/XlaoN2UUBE1Wea0hbn3MbGykZykauzRMSxtPC6Z5SPtte
 fzIyOuPN0mKmFMdwbn6PJ79lmSlU9/ebddN4xdnDYeHIwUrIsa2IFGRlzTeD+75fF7RU
 u1OsVPJ3TMK8B2hbhqRPezCmzgmNQjyNUqjA0K5TFb962OHSLYLbCCC80knW1kSYjmwk
 p44W1ZIBlgUVj5KAa5zxEH/gZ6wSjXweD1W33eSTcNXEO4l+L9Mdqr4vAKTKhR+Ex5fS
 OFQGuPO0FG2F3jzMPLdUcNpr+EBpDejObvI88l54IsuHPlsMgFHAjudtxQszTRugFZ9e
 14Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944659; x=1784549459;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=++CTcPEgNp9u0LBfWzgu3ue0NvUSQ3WiOpSOdNWCYAM=;
 b=jzwtL1Z0kaBWX029LevrHR/9+O45iX0Kt3MNtfNEds/A0IJ3XvZQfgBAUmNBVTIV8X
 rWdkkvY57DlmFT0IVmTP7AImKO+PZg4uKYqb8P5Bkd0GWFM1zw9oM/1ZWb1EcHIwPx97
 57WmHvvhyUbh+29w6ZoBdFL+6T7AjxrQ7YJHTzwcY1id03/MPR0UbWm51WKDfT2YJTio
 47sM4c2B9/wLsXJE8T5I6fMm85av/ZkaGvSgrlMHoV9cK1GqZWiGY5Wnl21rZ/Qv11d2
 FMGZAxYaE+yCIguBHZ/fc2V4AK601DkJgQ0txNNK8TUt46XFkGVfQY7ncTsnhceAfa1Z
 LMjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyzIj9i/8BwStlZYpEvipEutzIsRvo5lLQIxmevhUNRRJsQEtr0SdhiXGtwd3p25nuqern6PxYcpD3@nongnu.org
X-Gm-Message-State: AOJu0YxT6dUxCVWt2xLH1ANdagFe/5VKFT+ntRpByU+zFwffy03gYLcO
 ePcxr/t9T6hzPOJdJrJ7Hhk0qmMLOOcp0cZMnmFGCqovRWp97hDmylH+0RU0UX4jRLRKEILb1kY
 eZkLisDsIBwPnalOk2t4vZ9FUVjP6MJnifL7gSbEchUVwUvCA+9YXGqX3MA==
X-Gm-Gg: AfdE7ckcXCODSA+/2VabZShDQquia7cLNN9PIK/aHFRc1cSITG+oWZbOOYvf9d7LoE6
 We3fS7GQkZhhYlhd5l/2ePURgTbufH8/k8o1//enQgSjeorC81xSgxrD/nChPEcqqc2h8/qIs0A
 qU1NTMvkJCjdAeahERjvvIaLeZRO2MDS0xujJmDG8ECPcgX7Qtm4r8COtPQUMrQ8fgh4qgQQ+9d
 erOLjVHoxto3I6cfkrWIdc/b6V0L6AT0pOvdjfUKtCKbanjGGMdDYE4W3dasqmi3VpiUvRtpdAt
 bbj6okNZHSytu3UGgJpzsnth616EvUGBUhbHtsF3tJeK/XFeeqj4za21o58BGUbg8mG3iU6iF4G
 pLON5/Cp3pOp16vvt+To+JaLEzG/05TQdAvReoOxgWojHu9BKdjptmG1hbrDeSQ==
X-Received: by 2002:a05:622a:1813:b0:51a:8691:4427 with SMTP id
 d75a77b69052e-51ca9eb3ad7mr134654021cf.0.1783944658629; 
 Mon, 13 Jul 2026 05:10:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1813:b0:51a:8691:4427 with SMTP id
 d75a77b69052e-51ca9eb3ad7mr134653721cf.0.1783944658124; 
 Mon, 13 Jul 2026 05:10:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm84127537f8f.14.2026.07.13.05.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 05:10:57 -0700 (PDT)
Message-ID: <d1a5abca-18c2-4b07-ac77-cc8f9a4fefc1@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
References: <20260309181452.83702-1-thuth@redhat.com>
 <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
 <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
 <fcbe3d7f-64d4-4b13-b930-a81e77db4784@ilande.co.uk>
 <df7a091c-a8a1-416a-acf3-28a0cbd8dd2f@redhat.com>
 <c7d6b801-449e-4f55-9c1d-ebec7a0e9595@redhat.com>
 <c0cd50bd-e054-48b6-af54-1050e13bb720@ilande.co.uk>
 <baf0b727-d53c-4717-b4e8-9c8603b2fa75@oss.qualcomm.com>
In-Reply-To: <baf0b727-d53c-4717-b4e8-9c8603b2fa75@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfX2/bfgQq+SK+5
 wWfQtINW4wNnduIdNnGMbV1vkaG/nXQeV68zpbkl2n/zDZIksigT9OGsljylpT8+n3RVyjjCMAB
 ku0W+1mF5ovQo7CNJ15E7oK0I1Wh+Os=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a54d5d3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=4xvnQyb7TYxaWbKgc8MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: vVHAZ-OZOTwUBJByV-ao5asOwIBE2ZUA
X-Proofpoint-ORIG-GUID: vVHAZ-OZOTwUBJByV-ao5asOwIBE2ZUA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfX6Vh7dljnAolQ
 yZZgh4++kctJ58IXmOMl2dlB1uA/fhvwHSnHTfo4W8Vodd6mr9CqKjhHahRZRfzbuMD5oIyUvUi
 OC5R0KnmQW/t8y6MJCqt/1eOvJddJnBhii16sMXH9gNOcgR0FXvPi2xU18VGj3M+HU6D55pOPYO
 907Xx9klRJnlgzoZAzwBrwkV36kS+ku3uIEp640FGCLBiMyTI1fOs8gmCKyra2G1e3jB34yOKx+
 kbzJNRSM7N8CmTb3NFHSv0YelkBvbTPpJJg2MhNZlICQVe/iYCf0mHMA8OELO1ZN+kPXPJwKgGU
 7cf9kdXET7qe3DJ8+dMpku+rczxFsQtfeRexuFAswXk1M1vZujOqy4a8IAHJVrFIKqeUP1rOXmA
 H9h8ViLaMQR1c4joS7zn8ly21k+BlrWRUj71betYKZiawhbS/Dxrykrq6o9zLM3EHdW0GCramnP
 P6YaoL8oicUBMvpVF3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130127
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/7/26 19:29, Philippe Mathieu-DaudÃ© wrote:
> Hi,
> 
> On 30/6/26 00:20, Mark Cave-Ayland wrote:
>> On 29/06/2026 14:43, Thomas Huth wrote:
>>
>>> On 09/06/2026 08.02, Thomas Huth wrote:
>>>> On 08/06/2026 23.29, Mark Cave-Ayland wrote:
>>>>> On 08/06/2026 09:26, Michael Tokarev wrote:
>>>>>
>>>>>> On 30.04.2026 12:50, Thomas Huth wrote:
>>>>>>> On 09/03/2026 19.14, Thomas Huth wrote:
>>>>>>>> From: Thomas Huth <thuth@redhat.com>
>>>>>>>>
>>>>>>>> When trying to plug a PCI device to a Sparc64 machine, you 
>>>>>>>> currently
>>>>>>>> have to specify the right bus ("bus=pciB"), otherwise you get 
>>>>>>>> this error:
>>>>>>>>
>>>>>>>>   $ qemu-system-sparc64 -device virtio-scsi-pci
>>>>>>>>   qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/ 
>>>>>>>> function
>>>>>>>>   available for virtio-scsi-pci, all in use or reserved
>>>>>>>>
>>>>>>>> This is quite annoying for the unexperienced users, and it also 
>>>>>>>> breaks
>>>>>>>> e.g. the iotests ("make check-block") when running with qemu- 
>>>>>>>> system- sparc64.
>>>>>>>>
>>>>>>>> Mark the non-usable PCI busses as full now, so that QEMU can 
>>>>>>>> automatically
>>>>>>>> plug new PCI devices to the right "pciB" bus.
>>>>>>>>
>>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>>> ---
>>>>>>>>   v2: Do the change in the machine code, not in the sabre device
>>>>>>>>
>>>>>>>>   hw/sparc64/sun4u.c | 7 +++++++
>>>>>>>>   1 file changed, 7 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>>>>>>> index b8bda1eb816..37539535c6c 100644
>>>>>>>> --- a/hw/sparc64/sun4u.c
>>>>>>>> +++ b/hw/sparc64/sun4u.c
>>>>>>>> @@ -723,6 +723,13 @@ static void sun4uv_init(MemoryRegion 
>>>>>>>> *address_space_mem,
>>>>>>>>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
>>>>>>>>       qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
>>>>>>>> +
>>>>>>>> +    /*
>>>>>>>> +     * Mark internal PCI busses as full so that the plugging of 
>>>>>>>> additional
>>>>>>>> +     * PCI devices happens on the right bus that still has free 
>>>>>>>> slots:
>>>>>>>> +     */
>>>>>>>> +    qbus_mark_full(&pci_bus->qbus);
>>>>>>>> +    qbus_mark_full(&pci_busA->qbus);
>>>>>>>>   }
>>>>>>>>   enum {
>>>>>>>
>>>>>>> Friendly ping!
>>>>>>
>>>>>> This, being a simple change, somehow has not been reviewed still, so
>>>>>> it's sitting in the queue...
>>>>>
>>>>> Yes, apologies - I've been absolutely flat out recently, and I've 
>>>>> got a note to take a look at this and Peter's patch as soon as I can.
>>>>>
>>>>> Is this fixing an urgent issue with "make check-block" or similar?
>>>>
>>>> It's not urgent since this has been broken forever, but yes, it 
>>>> fixes "make check- block" for the case where sparc64 is the only 
>>>> available target during "configure -- target-list=sparc64-softmmu" 
>>>> and thus the iotests run with qemu-system-sparc64.
>>> Ping!
>>>
>>> While it's not urgent, soft-freeze date is in a week, so it would be 
>>> nice to get this merged before it misses another release ... WDYT?
>>
>> Hi Thomas,
>>
>> I'm still playing catch-up a bit here, but I can't immediately find my 
>> notes on using pciA under QEMU. I think if it fixes the iotests then 
>> go ahead and merge it for now, which gives me time in freeze to 
>> investigate any reported issues.
> 
> I wasn't sure whether merging this patch now or wait for your update
> during the freeze so hold my PR for a bit; today I looked a bit at it.
> 
> Some notes:
> 
> - pci_bus_*_slot_reserved_mask() API isn't much used. I supposed it
>    worked for a pair of corner cases but doesn't scale (I expect it
>    to be called in more code paths).
> 
> - Bus capacity is odd. We have a generic Bus-class @max_dev field but
>    do not use it with PCI variants. If set, it limit the instances
>    capacity. The capacity is tracked in the instance state, and when
>    no @max_dev is set the only way to mark a bus full is using the
>    qbus_mark_full() helper. Then if we remove devices, the bus remains
>    full, and there is no helper to restore available slots.
> 
> 
> Anyway, back to the problem here, the first part is indeed as noticed
> Thomas to use qbus_mark_full() for the root bus:
> 
> -- >8 --
> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
> index cd2328ad53f..6a8d0b6c6d2 100644
> --- a/hw/pci-host/sabre.c
> +++ b/hw/pci-host/sabre.c
> @@ -400,6 +400,9 @@ static void sabre_realize(DeviceState *dev, Error 
> **errp)
>       s->bridgeA = PCI_BRIDGE(pci_dev);
>       pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
>       pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
> +
> +    /* Only in-built Simba APBs can exist on the root bus */

Per the manual "Up to four Advanced PCI Bridge ASICs (APB)s may be used
with the UltraSPARC-IIi".

> +    qbus_mark_full(&phb->bus->qbus);
>   }


