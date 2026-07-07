Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5894DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1OC-00051d-Jg; Tue, 07 Jul 2026 04:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1O8-0004x9-Vo
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:42:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh1O7-0005lv-EM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:42:44 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678EBlY3231398
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 08:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mDejdOdSbMeLqP/ap1e/QjSjKqGw81Mb0HAwhsn4krA=; b=Zk8ZnXD8wZpDtLYQ
 2xhp5ND/JebYdC+B04U8dAShgKHG0kJts0eCdyRfNnBQWTvdcqZ6RneQlOO85lMT
 5t5y8g70WrUQVDP+KQvnq6XmyvuRFpRHXMVK6XITr/1IYjl8+UVSjKRg7dnXek+m
 8ZTxa0gUYawz/4MQ6YqI1vf4DW7akDCYUHGyrF3lAfNCaDxQdTr8v20Qjhr3nIHb
 T4GZ/NUzLS+hg/qNZxtiXjJkeocBH8IupSF6A8eu+6KmWK8Eg1LttKk+V5bA93OL
 RcaMrJiGkih5BLTaJ7HKaU0lWKsfgYIU5t/B9dfxHhMqr5Tzwb5g1YJpRM/q5X+U
 ZVJY6A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj79h7n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:42:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c12e43b98so48509601cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783413761; x=1784018561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mDejdOdSbMeLqP/ap1e/QjSjKqGw81Mb0HAwhsn4krA=;
 b=P5/EJAv14tYvclhrfqzkaEOQLECOwl6UK57LHSg6+sHNkrgQFPqzcD/XhZry1V7zTh
 Zy/gQw1/L57a+GWkzy9YGYgBi5/DeH70SKz6Ft4yz4llKNW/Xuro7FM7V7c6gtuCCa84
 bMkcfOOKz78POFdMP9XNs9jejU8BrjXehK5radUWm9hezwqajenAgDHplXzG03nnjhWF
 toBEDx0DVqRvW10KEJuj/jUqVsagQBRxdNRbSzLGQjevHfdCXZMKmnZCyNjwdzXbo2uo
 56SCQPEkNVdBCV32ui4D9gBjZCrbHJlP4cfJaSnN5PDtslmscnMC0Gebj7s1t7Qxj/2a
 vsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413761; x=1784018561;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mDejdOdSbMeLqP/ap1e/QjSjKqGw81Mb0HAwhsn4krA=;
 b=KErYJ1tXy6mm9g9v7b2E+GLyVPkHsfZTARcgpqg683/UwjryaIvODHr0gPQSkafJV7
 +fGRMQK9NgBYYrzBdnNVuVgi5vGqvTgqpyU9YCGmNzB/4Q+JswvXzUP4LzykwXMLX7qC
 l8tAoNQWhgx3hNhKuU8+xs8tRFXYR+oLVLQgpxYG0VcV6Vii5Pnqy8mIZRFtTepleeeX
 PAGIBnAbx3xlNcXMcUTzGNCr0ARGmJT7nKNA2JswKfmVdOlOsYiVPojaiswqLt7lvgRe
 DM91sg/p72VtYx3IfNFyU4jgL9w1Vfm5l5wLGz6ZKb1dKhNCwXduVn86bEKIrsRMAByK
 bL9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCj96ZSAJ2FjsJx3Cqb8Wv1d5YZrmCMMvnEqD4xyOT68wbBtlmXErPG4XINnZwpLqIkX1tEhC1kA1I@nongnu.org
X-Gm-Message-State: AOJu0YxEfDoiPmiI+3W91GkoghIv3/KLbus9nYJ8MyYnqg/uj/Z8/E5o
 XIaYKHUq1GeH/TCRc71CdA8c7uwuFBEtt7+UejvGUKFwcwr3zqIwOlNaVsXSPQfcNR2IKqeXwZj
 9wxqqq18W55O8ow0zpxtcogQmAmYIzOKMjNNkKVlm0V/OXuyZZNKqHu6MNQ==
X-Gm-Gg: AfdE7cnk2W15N3DGmVTxo/AO9f1s1ymjj1sE5nY/uZKzXH2F8Omv2dOwZ9uJI/0vLdr
 /r/lh3dJ4Is51+FNjZ7vX5A02bZQpxZL8ZpXqQUG46x8x5Io402xqdFIIIm5cuaRHsoUK1wHBDc
 X++CJxd/Gc+bQgyeSQsA9IOHelBJkDQkcq4eSSpugaOjsuK39GBA6eOtciUT+TgMV0WIzjwvxjB
 m1znz5T7STpI9PUVqiDS/BjBY+WL60w6LDdKd+yTHLeh3uliUq1qw7dtOnh3EPtO0zvMW8HT8wQ
 hrEN2xFAXS6Ik1gv2dm9d7tuJFX4aTFbwQsZtkU4KwekyIdNj70tvjDLRlex48x74iwQiZF8f2f
 apd2Ra6+sCyPr2liYkOa7EgnJ0ZYjyvdx65klTVvgGPWv8HzJ+SUMgkRilC+i3A==
X-Received: by 2002:a05:622a:34a:b0:509:3cd:b22f with SMTP id
 d75a77b69052e-51c747beb3emr48443741cf.23.1783413761225; 
 Tue, 07 Jul 2026 01:42:41 -0700 (PDT)
X-Received: by 2002:a05:622a:34a:b0:509:3cd:b22f with SMTP id
 d75a77b69052e-51c747beb3emr48443641cf.23.1783413760789; 
 Tue, 07 Jul 2026 01:42:40 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada04d04sm82653366b.47.2026.07.07.01.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 01:42:40 -0700 (PDT)
Message-ID: <e89903bb-d866-45ed-b5f5-fa0a6ef1a0c7@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:42:39 +0200
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
 <a60309be-c514-4b22-8970-ecfcf2b4fde7@oss.qualcomm.com>
 <c7b0d42c-4243-4f52-88ec-7f1deac160fc@ilande.co.uk>
 <fdb45ef0-a709-413a-bc55-1bfcab648033@oss.qualcomm.com>
In-Reply-To: <fdb45ef0-a709-413a-bc55-1bfcab648033@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: T8ZP2kK9eMLFQzQYAkkcbNk49Ln460Kl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX8rGOg0WZb3/b
 gLcxhWjWl863pbWFYISOxlKQ43xATt++hcMF7oIzqinT1vdQn1jT4UK9hrM5jjvBKG2EMA6f/Fb
 /3+Kw8IJvL7a4PvC9LHdDE3jyNa6pL0MN+ZjD/SX+ZvvEQCHa440zlBYuCq+v9idY2phFkg0Krw
 gvpb+fBY4NNZqt1LoVHxdQp6hGVX/9621aEPtubM17J1K6V3/XSyjZ0kIwsjcDMpk6JA/lUTqOV
 L1r4jIpkNboSPjMrTA+T6bS8ErC4F90qruxL52xQl+xVR/HIawZKWtMfFoLjs5O8m1ndPK3xPq2
 0n3RFhu3LkHQwr9UFOlJ2zrH0583Q7VoPuvJZv3ecdkrJieoSuncASmyp2tuD9tQZ+Vw1FAVZt8
 byk+qafy+nZ9jB5+eZzzpk/UNQ7ZV+rRujsgQqlpvpEktlAvJBumjcC8ap1DouiiL//pPcVVByS
 WtRu7JU7cuzE7FV6F6g==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4cbc01 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6aw1dEGQIrAIlxKPOMMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4MyBTYWx0ZWRfX5OL6Zk5mfCf0
 HgcurQrfBCAsCx/rnTo2oYGgPxu77cE2ntwLrqejdLuqmgLilHslA1L+7dmwOo1vr6NwW6G1LX1
 SEL01MyiVmCO4MInnG0yM7GpHDfn36c=
X-Proofpoint-GUID: T8ZP2kK9eMLFQzQYAkkcbNk49Ln460Kl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070083
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

On 6/7/26 23:19, Philippe Mathieu-DaudÃ© wrote:
> On 6/7/26 23:16, Mark Cave-Ayland wrote:
>> On 06/07/2026 21:29, Philippe Mathieu-Daudé wrote:
>>

>>>> -    pci_bus = PCI_HOST_BRIDGE(sabre)->bus;
>>>>       pci_busA = pci_bridge_get_sec_bus(sabre->bridgeA);
>>>>       pci_busB = pci_bridge_get_sec_bus(sabre->bridgeB);
>>>>
>>>> -    /* Only in-built Simba APBs can exist on the root bus, slot 0 
>>>> on busA is
>>>> -       reserved (leaving no slots free after on-board devices) 
>>>> however slots
>>>> -       0-3 are free on busB */
>>>> -    pci_bus_set_slot_reserved_mask(pci_bus, 0xfffffffc);
>>>> +    /*
>>>> +     * Slot 0 on busA is reserved (leaving no slots free after on- 
>>>> board
>>>> +     * devices) however slots 0-3 are free on busB
>>>> +     */
>>>>       pci_bus_set_slot_reserved_mask(pci_busA, 0xfffffff1);
>>>>       pci_bus_set_slot_reserved_mask(pci_busB, 0xfffffff0);
>>>>
>>>> ---
>>>>
>>>> I'm still looking at the 2nd part, the reserved slots.
>>>
>>> (Because with this patch, the test passes as we can plug devices from
>>> the command line, but they end plugged on pciA instead of pciB -- thus
>>> the 2nd part missing).
>>
>> Thanks for taking a look, Phil. IIRC the reason I added 
>> slot_reserved_mask was so that it was possible to populate pciA 
>> programatically in sun4uv_init(), and then enable the mask so that 
>> specifying an additional PCI device using -device on the command line 
>> without an explict PCI bus would cause the automatic allocation to 
>> place the device on pciB.
> 
> The slot_reserved_mask calls make sense, but AFAICT they don't work as
> expected, since CLI devices are added on pciA. If you want to have a
> look on top of this snippet, be my guest! Otherwise I'll continue
> debugging that tomorrow, long day and late here :\

Generic PCI fix posted here:
https://lore.kernel.org/qemu-devel/20260707084050.32137-1-philmd@oss.qualcomm.com/


