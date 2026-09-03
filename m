Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63362C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24cQ-0007aM-Uv; Thu, 03 Sep 2026 06:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24cO-0007Yt-SP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:24:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24cK-0002Nd-UJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:24:28 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH3W73720177
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C2oj6vUDeztD1oA91RWuYi+1yGYj4tKSTLkWJt3YfaQ=; b=Je7OxKur0p2Qf9eK
 wINu68pkd6ndSXQHgB5lkIudjb5Qa0Qd3HJcG8Btf3xYLi5MjKMoV9ABkS7+p2S7
 W6moUGr3jWOb+wGZFkzseZrRLweJVdJO7Po3ZV5SCZd+AB2lf9ZbvmNmJSy+QJF3
 pxZE07tmHrgsnKFHhc02Mmzm476WKmqfl1SLZOrRXw6D+8MejeAnimqelyuyBdVK
 1M/uT8UDj/cVUTHdqN2ImRdc+jCA1L3XbBtp/VDCKdbRhUNHVtGe4zhf8TmxbPB/
 EeZnOE+Qycp5JIXdXGHEx/+iCMigOYbOFxZsmsf7pdKVp5fuq0NuWMt8PqfJGWkk
 aX+E4g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf0gjsngj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:24:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e53b8a302so436902885a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788431062; x=1789035862; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C2oj6vUDeztD1oA91RWuYi+1yGYj4tKSTLkWJt3YfaQ=;
 b=V4ZURP9sx7YIZ/3Jn3usyimUJEpKkBdo+YBbG7XHoLDcD8W2fU1JALyEXurO5vRfMz
 JDcFFhMkLq3+NZ6lkl1DbIopcpBSp4+prC7MlpuNj7UNdn/XOqkI7QBEQEWf2Bo1fCCr
 R5MMFhJzr//UqRokeqxE/5r0oeG840gTbLy2CyUWk8pfOr4GtBBxpgoRD83c2omwHIoY
 u2cJveaULPDpxE9XJgWXIc+wo4H5gjbFqoJolD99ykDAYZQXpWY0z4fMWTEKzjhR2fOo
 ucSlWWpUnUqGHVujqdCza5bcsYpwElIPz2olsMaHgojAQsRdWac2xbTkjgs7iVPl1eyI
 dxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788431062; x=1789035862;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C2oj6vUDeztD1oA91RWuYi+1yGYj4tKSTLkWJt3YfaQ=;
 b=WseArdWbUzfDUpJ+Lb6oCEp1yjLn59o75JONly4hSKy4NI+BJVhtC6YnFFEmmr43zh
 IelY+EQLLw43HP9yTxpZgUduDw0cm7RtVLVmyqdec3QNM6pSr8uefqwNLyJnUUDDcJ0F
 lJJXqmIMa1ZoeXWgHPxespYhJUSB9t0B3GtS5HKb+VGNTd7mt2qIVUwpBlyeGEBVbsgr
 r8r7y3jE7vqUwil5V51YgYFxK9v7BlYDz+bz/8E2cNuYym+19p/YNEOmy4FGzg7panPl
 YMX785AC6z5i0s37mmBtpD7irgNf6Y5fdAzSyWiOJ2+mRZ0pn9z+L4KS67NzyVh6WRIy
 Dwaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwr1HcNLcnxbyHAZLPCR6w4+zZfuA3dyq5HQLULMcUAb97bnDD8QFW8SraGrvaq0TYm0++Q/DeEk3dD@nongnu.org
X-Gm-Message-State: AFuF++nJL2FwP0VBfCB3/OatvIiW4ow9EEexOIF7VKltfWySQgvcgNIl
 m18ZPjo60ENae5F4qjWCZdZ3rFClE0TUFlhn/q3wfWTrU2gxzQKEUsvzlIE+T84jjXJGSBhBtpv
 4D1hjU9Q5KRAbjPoKksaTD4fPIv+qk9gSTFD7bnQ3mXx2UCHhB8UfnfRhQQ==
X-Gm-Gg: AYBFou1jhEzA4byE9oVOTtz5TVlwaKsMvLqfHrmgtG3zO3dBkSHAKJWP7jyVEXNwRu3
 XqUIAxEnhXKfN3xzhVDBzlxitQ3x9H3knGU3qb6mEIqNUT6cenNUcC0pWCLTb9RsP0f2X/R2lo6
 P6qqS4blzZrIZqX5ToobwIiEYrfcAgyxFGjxitrwlcIe3D9pAr2m9s5AhQyJHzNRLxp+f+yArSb
 JLbiPaKJ9V3PhFSpLfjc1m+0XDIIRBu0625WbIZhut4LUW0h0l8OqrIZruqtd8UXkFkS0ZP6Gqy
 DnqTCgCGr8nuVpHniJTjoZ7C3g0o//91RqHm32tHskyhGBFGPnJzG7NYYET5Fupx2Mpx5n6++sC
 UrDgcLbNLBAZ8HlgKvKapR8mqOmi+V5UeQw==
X-Received: by 2002:a05:620a:f0d:b0:939:6dea:3749 with SMTP id
 af79cd13be357-9396dea3889mr545570985a.45.1788431062149; 
 Thu, 03 Sep 2026 03:24:22 -0700 (PDT)
X-Received: by 2002:a05:620a:f0d:b0:939:6dea:3749 with SMTP id
 af79cd13be357-9396dea3889mr545563385a.45.1788431061607; 
 Thu, 03 Sep 2026 03:24:21 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d5d12sm58603785e9.5.2026.09.03.03.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:24:18 -0700 (PDT)
Message-ID: <7babc6ed-f537-41ca-8017-3a1c2c48d691@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:24:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 15/15] hw/qdev: Prevent devices from being
 realized more than once
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <20260721-qdev-v3-15-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <356ebc59-d2cb-4c47-867e-8fc693b3a593@oss.qualcomm.com>
 <a5597a0e-c18c-4649-bfd1-20d77897ff88@rsg.ci.i.u-tokyo.ac.jp>
 <8d979f89-374a-4b86-93c8-9d7dcc311ca6@oss.qualcomm.com>
 <3a1e6538-2669-4e73-9855-e4b7f33604e7@rsg.ci.i.u-tokyo.ac.jp>
 <a79f2ad8-d1ad-4536-85d1-0a01ad2f9513@oss.qualcomm.com>
In-Reply-To: <a79f2ad8-d1ad-4536-85d1-0a01ad2f9513@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX3SUjZRZePRaW
 lVBe3PyJKGd0pCcqPD+dZ3HxYmRROHzH+QyEDq3dI2u+lbeM85yvMHUihrON/J6vaJbhiL0RslA
 n92doiANLRgGu6X5/ppAhhgLpX152dZKdlXblorqm7IZBNYd/p5dqJSPcGKeYLJxzSYsfSkbDNr
 t31YGnr2PWF1dexMx8hrxfUkE6Cnpl+dKNw75iUTtl4yWivuWqepe+S2y80ifuNnBIM/GExuUaZ
 ze6FfVT9ChjRwSW0xWIw96lp/MfK5iNUxZD5I5+lEK5fY2a8aEkbhIqUElBGPEs6tOL76+LDyB8
 MJ8qaQED4uIn7SN2D7rp4JUB6tp5P80GGu+j6790Rz/CCcu+hVvFM5qcjZ6awDiVIXwhWQPGJBX
 jeOhfcqRnZGcfUqSndPE/0oxKU2H+Oyv/JiGHdP/TbDgfR02ZtcDJlpKfwtFA4O84rmuaUaYZEu
 cBXwXbm4W0tSPlnh1WA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfXyNC/iwCtVFWI
 20K3j2R/7bdjf0po/p7BlCn0YrKzknsF65zL8Z3YXHyski9Xr3Nxlvwws/nyLh6UZPlmgv2f/FZ
 qpZBvXY6hLArlvlNAI7mvF0q90F1tJc=
X-Proofpoint-GUID: qUH7iWkcASHW7VnLWx2ZUfk6Wu6oho65
X-Proofpoint-ORIG-GUID: qUH7iWkcASHW7VnLWx2ZUfk6Wu6oho65
X-Authority-Analysis: v=2.4 cv=LZ4MLDfi c=1 sm=1 tr=0 ts=6a994ad7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=1bSrhWkXWGQrRwQRqCIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030089
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Akihiko,

Are we still waiting for feedback from Igor?

On 22/7/26 14:05, Philippe Mathieu-DaudÃ© wrote:
> On 22/7/26 13:08, Akihiko Odaki wrote:
>> On 2026/07/22 18:57, Philippe Mathieu-Daudé wrote:
>>> On 22/7/26 07:12, Akihiko Odaki wrote:
>>>> On 2026/07/22 5:11, Philippe Mathieu-Daudé wrote:
>>>>> Hi Akihiko,
>>>>>
>>>>> On 21/7/26 10:17, Akihiko Odaki wrote:
>>>>>> qdev currently permits reentrant realization of the same device. 
>>>>>> It also
>>>>>> permits another realization attempt after a device has been 
>>>>>> unrealized
>>>>>> or a previous attempt has failed. Either path can invoke
>>>>>> DeviceClass::realize() more than once. Supporting repeated 
>>>>>> realization
>>>>>> adds complexity to device implementations. It is untested and likely
>>>>>> broken.
>>>>>>
>>>>>> Replace the bool DeviceState::realized field with the enum-valued
>>>>>> DeviceState::phase field. The enum has four values:
>>>>>>
>>>>>> - initialized
>>>>>> - realizing
>>>>>> - realized
>>>>>> - retired
>>>>>
>>>>> Excellent.
>>>>>
>>>>> I have been working on something similar.
>>>>>
>>>>> I'd start the first patch only including:
>>>>>
>>>>> DEVICE_PHASE_UNREALIZED (false)
>>>>> DEVICE_PHASE_REALIZED (true)
>>>>>
>>>>> Then gradually rename DEVICE_PHASE_REALIZED -> DEVICE_PHASE_CREATED
>>>>> and add the DEVICE_PHASE_REALIZING and DEVICE_PHASE_RETIRED phases,
>>>>> so we can discuss them during the review process.
>>>>
>>>> A gradual conversion makes sense. I kept the "realized" phase as-is 
>>>> because it maps exactly to the current external behavior. This patch 
>>>> splits the internal "unrealized" state into three distinct phases, 
>>>> but the external concept of being "realized" remains unchanged. This 
>>>> allows us to avoid a tree-wide refactoring, which is also why 
>>>> qdev_is_realized() is preserved.
>>>>
>>>>>
>>>>>> Realization can start only in the initialized phase. It moves the 
>>>>>> device
>>>>>> to the realizing phase before invoking callbacks, preventing another
>>>>>> realization attempt. Successful realization moves it to the realized
>>>>>> phase; failure after realization has started moves it to the retired
>>>>>> phase. Unrealization also moves a realized device to the retired 
>>>>>> phase.
>>>>>
>>>>> So what is the difference between 'initialized' and 'retired'?
>>>>
>>>> The first statement in this paragraph differentiates 'initialized' 
>>>> from everything else: realization can start only in the initialized 
>>>> phase. A 'retired' device cannot be realized. This property avoids 
>>>> re- entrancy.
>>>
>>> But we do use unrealize -> realize again, in hotplug path.
>>>
>>> So we need to be able to move from 'retired' to 'realizing'
>>> again, thus my wonder what is the difference between 'realizing'
>>> and 'initialized'.
>>>
>>> I.e. this test should pass:
>>>
>>> static void test_qdev_realize_hotplug(void)
>>> {
>>>      Object *mt = object_new(TYPE_MY_DEV);
>>>
>>>      /* plug */
>>>      g_assert_false(qdev_realize(DEVICE(mt), NULL, NULL));
>>>
>>>      /* unplug */
>>>      qdev_unrealize(DEVICE(mt));
>>>
>>>      /* re-plug */
>>>      g_assert_false(qdev_realize(DEVICE(mt), NULL, NULL));
>>>      qdev_unrealize(DEVICE(mt));
>>>      object_unparent(mt);
>>>      object_unref(mt);
>>> }
>>>
>>> Maybe your 'retired' could be renamed as transient 'unrealizing',
>>> similar to 'realizing' phase, then we could transition to the
>>> 'unrealized' initial phase?
>>
>> I could not find an in-tree hotplug path that unrealizes and then
>> realizes the same DeviceState.
>>
>> In the normal device_del path, the unplug handler unrealizes the 
>> device, and completed unplug then unparents it. A later device_add 
>> calls qdev_new(), so it realizes a new DeviceState. Reusing an ID or 
>> slot does not reuse the object.
> 
> Igor, could you provide your advices here?
> 
>> The virtio-net failover path does retain and replug the same object, 
>> but it deliberately keeps the device realized. The partial-unplug path 
>> skips the unplug handler, and replug invokes the pre_plug and plug 
>> callbacks directly instead of qdev_realize().
>>
>> More generally, I believe same-instance unrealize -> realize is 
>> unsafe. Realize callbacks may create QOM children whose lifetime is 
>> tied to the DeviceState rather than its realized state [1]. For 
>> example, memory_region_init() initializes an embedded QOM object and 
>> adds it as a child of the device. Unrealizing the device does not 
>> generally finalize that MemoryRegion, so a second realization may try 
>> to initialize the same object again.
> 
> I totally concur here.
> 
>>
>> So introducing an unrealizing -> unrealized transition would require 
>> every realize/unrealize pair to restore the state of a fresh instance. 
>> That contract is not tested, and is the complexity this series is 
>> meant to remove.
>>
>> [1] https://lore.kernel.org/qemu-devel/64bc4a38-f1d2-45ff-8f4c- 
>> c941d6a41e18@rsg.ci.i.u-tokyo.ac.jp/
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>>>
>>>>>
>>>>>> The QOM realized property is an internal lifecycle property, not for
>>>>>> end users. Replace it with the enum-valued phase property.
>>>>>>
>>>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>>> ---
>>>>>>   qapi/common.json          |  19 ++++++++
>>>>>>   include/hw/core/qdev.h    |  12 ++---
>>>>>>   hw/core/qdev-clock.c      |   4 +-
>>>>>>   hw/core/qdev-properties.c |   4 +-
>>>>>>   hw/core/qdev.c            |  98 +++++++++++++++++++++++++ 
>>>>>> +--------------
>>>>>>   hw/scsi/scsi-bus.c        |   4 +-
>>>>>>   qom/qom-qmp-cmds.c        |   2 +-
>>>>>>   system/qdev-monitor.c     |   5 ++-
>>>>>>   tests/unit/test-qdev.c    | 112 ++++++++++++++++++++++++++++++++ 
>>>>>> + + + + +++++++++-
>>>>>>   9 files changed, 212 insertions(+), 48 deletions(-)
>>>>>>
>>>>>> diff --git a/qapi/common.json b/qapi/common.json
>>>>>> index af7e3d618a7c..88a308cbd172 100644
>>>>>> --- a/qapi/common.json
>>>>>> +++ b/qapi/common.json
>>>>>> @@ -7,6 +7,25 @@
>>>>>>   # *****************
>>>>>>   ##
>>>>>> +##
>>>>>> +# @DevicePhase:
>>>>>> +#
>>>>>> +# An enumeration of the device phases
>>>>>> +#
>>>>>> +# @initialized: the initial phase
>>>>>> +#
>>>>>> +# @realizing: the phase during realization
>>>>>> +#
>>>>>> +# @realized: the phase after realization
>>>>>> +#
>>>>>> +# @retired: the terminal phase entered when unrealization begins or
>>>>>> +#           realization fails after starting
>>>>>> +#
>>>>>> +# Since: 11.1
>>>>>> +##
>>>>>> +{ 'enum': 'DevicePhase',
>>>>>> +  'data': [ 'initialized', 'realizing', 'realized', 'retired' ] }
>>>>>> +
>>>>>
>>>>>
>>>>>> @@ -477,10 +477,10 @@ bool qdev_unplug_blocked(DeviceState *dev, 
>>>>>> Error **errp)
>>>>>>       return false;
>>>>>>   }
>>>>>> -static bool device_get_realized(Object *obj, Error **errp)
>>>>>> +static int device_get_phase(Object *obj, Error **errp)
>>>>>
>>>>> DevicePhase
>>>>
>>>> device_get_phase() must return int to match the getter type required by
>>>> object_class_property_add_enum():
>>>>
>>>>      int (*get)(Object *, Error **)
>>>>
>>>> Using DevicePhase there would not match the callback type.
>>>
>>> Ah right.
>>>
>>>>
>>>>>
>>>>>>   {
>>>>>>       DeviceState *dev = DEVICE(obj);
>>>>>> -    return dev->realized;
>>>>>> +    return dev->phase;
>>>>>>   }
>>
>>
> 
> 


