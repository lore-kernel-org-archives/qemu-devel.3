Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C039C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBWR-0001gO-Nv; Tue, 21 Jul 2026 10:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmBVG-0001Pc-41
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:31:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmBV7-0007X1-9p
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:31:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDfwDx1912524
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 swbehnN9znk+AHcfcp1HGKo8NQ7tDcItafZZVxH+x6I=; b=IOzBpF+yqT0ah6TM
 6Xi51yWWZjTkgsjVqp5sYENO99J4dONxDmIelP1JJ9Zk8pRoL0Yi4xI/tOWDykcG
 U2YVgmGKlw1yPVSHQvA/tv1uy4QKQulIVaFblEnZ+DxGng/COm0zxxjhpVFb/fyv
 YHM0GPAgr5kYOOk7T50Cm6xgKbLSpzhUsZF2k0zAxRTdVfS0lF+Nkq7bxvBbVmcd
 UVc6z2PyUy8GqUOjaseTQ2GrfqrBU0uVLvzWBvdKKpA02wC2NjIM4CWdBeLci4Dk
 VFtbVHoROxKE+npPNH5CfCIO+vtcycN8ftMWsYcQKV9tlvuFRoYMEHACNRPuweWS
 pnXstg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1dujvas-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:31:15 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73986bb438eso13198093137.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784644275; x=1785249075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=swbehnN9znk+AHcfcp1HGKo8NQ7tDcItafZZVxH+x6I=;
 b=CTjbRTdFVSC8M5kAg6jR97L1WBgqSAfaYSdodLTk8iMixYZUQVNoyo1kS/ModU7zth
 blJFlhzo/T4k99y+CZGFUlVWV+bTfqe+TUZIkOwormDsODA8z+4mVaNYQRumc/2L/PsE
 EnP/0T7Zf7h7L7YXJfwVci+DH8kBuAC7gyNIvpp+STdxgH7KRlN1sMZZtlovmg3m6Xyf
 dSiRNxCcpgslCQcEP8QyAZQyA/ipfrTB3kxX2TF+8X/C+iWHvR5SaJdka5SfIDuFggO/
 8z8ZXVzoXI5L50c6lxEZPq+j29yOHraF8tT9wVJ/SfdKv8/jWU3JN+zz8OI5kKRq+XEU
 i1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784644275; x=1785249075;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=swbehnN9znk+AHcfcp1HGKo8NQ7tDcItafZZVxH+x6I=;
 b=e7X42cpCnOelnKuBT/pznadJoX3aoO8YWnpDygUka346rFqyECR8WIdTphZtwY2vm3
 tTru/GeJdIpr34k5Ugqrsnm0jyzwGXULDEqQyUObf+iMxvywDdeA5Edq62tkyRrrhV0G
 5ifmszPBFloJEWleP+IhPXNganN9cz48cBR3qbH8hsJmSnfTrjxMST/Me5QA0XXnUJ+z
 TiC/Sg7ZbBQXBU09EpTFAZf+eXlSMQV40BTsqsUdEueUkya5tKQMM35JI/Q5osdsdutt
 91HiVCseBeyZQQIdF2oY+22mzlvsmlHx4KxmxgrD9BJ9lv4mDzOH4E23FEvDLQYBH8J9
 tbkA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3fe49lkMNoLFR7fAY6PdHbtTK+gbegSsuY1GeB/bfdcOjDYTz6te1GQySLmB7OPx+txrDAjW/RnuM@nongnu.org
X-Gm-Message-State: AOJu0YwVYbWaaa7ccncF3KWV+FM4LVVBKou2hLTj42v0qNyk5zY0kBFn
 iQ5Ijq6aked6scb+u5woTnAiF6x0dBHj3OxytjsFAKwnyZl1hMnsZmk0eC+T1llGSZoztgUth0P
 tUZUarHfJO08+Fvavzr08GTwLDflaExCKo2cQ/FmcyoXB4AWkJ0lXsUiE6Q5raoigPA==
X-Gm-Gg: AR+sD13qm/6mVg5AM9hArMBVe09exHXGclEJ1d3QlZV2tnaPog/6uWjTtfU+8cVPcAa
 BLtGsXULdMs/HaILBH/2qY6JufmCMYYAoYNutll+nH+xjhyjsH5xzuqK27kEOR/7sZzvdOK4V+N
 aDr+opTeAW+p83MQeZBxNTa5jl5Ez0Zebti03VCd47b2P/sE4L02Yjx11FnufOO1HHoroqtThmQ
 JtyrgflXYBw2YXtoAadtlBGGB6/ypUxNMI5mTZKEwLguW9Fc2NClnk/u4xXXzpBTgQvRgLX4RO0
 PJlk2TXtA37eR6kJI/PGLrbNNlR+G3Yn/iQqjF7X3dv8dRv4i0GYKAx6Em9yoLBRV5y/qd6q+Hy
 vExMMXsmGHrxaTr1l5DHa3rTNKf9JM82xMnss/lYvoI2Bxg==
X-Received: by 2002:a05:6102:b13:b0:738:fd01:5b63 with SMTP id
 ada2fe7eead31-7475343a4eamr7219459137.4.1784644274875; 
 Tue, 21 Jul 2026 07:31:14 -0700 (PDT)
X-Received: by 2002:a05:6102:b13:b0:738:fd01:5b63 with SMTP id
 ada2fe7eead31-7475343a4eamr7219435137.4.1784644274320; 
 Tue, 21 Jul 2026 07:31:14 -0700 (PDT)
Received: from [10.131.142.220] (220.171.88.92.rev.sfr.net. [92.88.171.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956547319dsm73923305e9.5.2026.07.21.07.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 07:31:13 -0700 (PDT)
Message-ID: <7c3b30b7-bc55-417d-a36d-5b3b1ee61b7d@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1] virtio: avoid packed vring virtio_queue_empty()
 infinite loops (CVE-2026-16457)
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Anatol Belski <anbelski@linux.microsoft.com>
References: <20260721134424.196337-1-stefanha@redhat.com>
 <456ab3b5-a2c9-410b-91d0-f8b13fc0b542@oss.qualcomm.com>
In-Reply-To: <456ab3b5-a2c9-410b-91d0-f8b13fc0b542@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3GkpeSBXGy0qHhvkqBpHsegPTqOFCI0u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1NCBTYWx0ZWRfXzDabiMLXXhPu
 YBoLSeTb5a43rLr2dVKYC1WUr0BIeYuh16h8bNYzCX25WnnVTxXTFqWnyp2kT0hPDUMyWGbipxs
 osex8sqnRk87sWzasSfg89UXG1G9T5W8TNpszXps+iXl6es9wj82b8CxOoxuql2w7zOdMcSMm2Y
 wbuoMyy0XYIO/iAMxzCIXHU81M072rFR3FJ6gkoWgyugSkswUSB8jWQm0lrrdnP/DUMNxVLEpx9
 yAXZLW/sY+X8fbqO/NrOIcFQp0qs1vaz1ZLz6NBRa+AXN53zbQYtYIti8rKSfzbd+H7oDlGGOme
 +l8U4sUdi+IMahgrcFt+eI0GvhZ8XQNCQseRteL9jFMbABv/DR6l+6nMa0pJBojtnnzpfI/zEfT
 Ax/hsnKzhDWV9zP7lk+o2bmGXGR4p3K++l3v7/66LSwCnHCI4UmknFXgGjrFXLzGEdbl0Ea/1ZV
 gSdujcBGHNtn8bZdFNQ==
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a5f82b3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=HvFMDRKYglX6yPpWI6gtsw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=yMhMjlubAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=1AHBvL1_tL_KQbbGD-QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: 3GkpeSBXGy0qHhvkqBpHsegPTqOFCI0u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1NCBTYWx0ZWRfX+ncZ0ZnJWHSJ
 BXgPw0ZHOzd7mV4bTJ/5ybcXR2KsJqywWe7xWLWyugYVN4DJdwRKdmdK3t9p7bgvM4lMI1xHgbu
 TXnlRxLD6Nsn8fqWBmzHXeKO4fu+FL8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210154
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

On 21/7/26 16:26, Philippe Mathieu-DaudÃ© wrote:
> On 21/7/26 15:44, Stefan Hajnoczi wrote:
>> Virtqueue handler functions in device emulation code often look
>> something like this:
>>
>>    while (!virtio_queue_empty(vq)) {
>>        ...pop and process virtqueue element...
>>    }
>>
>> virtio-blk, virtio-scsi, virtio-crypto, and vhost-shadow-virtqueue use
>> this pattern.
>>
>> The device may break (i.e. hit an error that requires device reset)
>> during the loop. virtio_queue_empty() returns 1 for broken split vrings
>> but not for broken packed vrings, leading to an infinite loop.
>>
>> Adjust the packed vring behavior to match split vrings and avoid
>> infinite loops.
>>
>> Fixes: CVE-2026-16457
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3968
>> Reported-by: Anatol Belski <anbelski@linux.microsoft.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   hw/virtio/virtio.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index f4d86a36553..3795e3c8c68 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -763,6 +763,10 @@ static int 
>> virtio_queue_packed_empty_rcu(VirtQueue *vq)
>>       struct VRingPackedDesc desc;
>>       VRingMemoryRegionCaches *cache;
>> +    if (virtio_device_disabled(vq->vdev)) {
>> +        return 1;
>> +    }
> 
> Correct, so:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> But why not run this check in virtio_queue_empty() entry?

To be clear:

-- >8 --
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a36553..019c9c9e293 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -786,6 +786,9 @@ static int virtio_queue_packed_empty(VirtQueue *vq)

  int virtio_queue_empty(VirtQueue *vq)
  {
+    if (virtio_device_disabled(vq->vdev)) {
+        return 1;
+    }
      if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
          return virtio_queue_packed_empty(vq);
      } else {
---

Having:

static inline bool virtio_device_disabled(VirtIODevice *vdev)
{
     return unlikely(vdev->disabled || vdev->broken);
}

that would avoid the RCU_READ_LOCK access.

