Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20F9C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjApg-0000nd-9D; Mon, 13 Jul 2026 03:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjApI-0000my-UK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:11:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjApH-0007Rk-51
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:11:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6O02D618137
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 07:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UOux+gfYDB/athIATxfWWzN7ePScEoTb/XlaAPO8vfM=; b=KVGSDlaaKCd/PgZc
 Zlsf5gwky58bREzaxm+VEBgD+uGT7pP5hxXN6AW0+tKVyrsyJGvt2KwWYtvZTxdW
 1HvAsJODj8a684KzDxDkmP6RHhRmckhg7pETNC6E7iYtrjuHEmi+dWOAApnzVmU4
 AH/OFEf+LAEBvJ7wEoD5vbRZ8bO5ZvH2nAJNIbUx8ysm3ItiChRr5ysw++yp4QXa
 wGtUt51/U8RaGQ9XD59f5tSE4l8zHjeJi4GiG8BR5qZFxyesI0x1SEnu5Z7XLoM5
 Qih6UBNdmak5f7IT71Ge7yI86ZoIYpJ+INMmRtob6O2gtGCOWelZ2VfO/wMCB+iK
 MsnGfQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamvwhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 07:11:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bec738909so23154351cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 00:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783926697; x=1784531497; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UOux+gfYDB/athIATxfWWzN7ePScEoTb/XlaAPO8vfM=;
 b=Fwo6urkZipbTmSU7olERNd7hfvI8U60mxX4VhNlZlH76YKMquFn7BGFf7zDwkh9nd4
 sUDZqdGQ1St0UlrcCx0h85KbwUtUQocSBDJXA3HpLVzWHB15pRUU3zZkpgAlCl9ZY13H
 CNpdlU5h5yDjuYuroHCWzDxeKHqfJNlSqyWp0bBByrHJXolEkXGi7rR+hz3shnZ/dtbZ
 e5etDbRmMtGn0+uMsz/YlRV8ScUxonTIedGR8+rePbuBttMhfDyfWYAygi3OiFXZsJVT
 0cBSdn5MjjppZSyNh7qNwbPs1lqWhXphcoX3un1hEC9xjEzdL3ycRfOJ51ex3CKMkzJ3
 GtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783926697; x=1784531497;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UOux+gfYDB/athIATxfWWzN7ePScEoTb/XlaAPO8vfM=;
 b=na6OF1K48avNt91nnFFyCv0zCnKOTnG7HuKuRUq7dato4iljI79nPumr9DiwjlTafE
 5IW6XvEW0tyhSWCesF9v3lk+0GLDUVbvC3DUBQwHpyM7+c9HdzNk8AdEAizoGj3L0fD6
 fX1lfQgKFjyJO4naS4K0tGQXFlYGLpPpk9DX8qYKBvExAWdPyNc0YKTpNb+OlbvGSGse
 l2wnwrEmXWc2Qh/yKqTBt5agWwmCivpQs7LCIJ9mcRdYKVGf5GTrAcS6J7puh2sNyj+W
 Lgnblk8ufQgwcFOzUFNFyMxZskjrGbxJ7+LG5Eq3/exBy7eIrrDqKSZFLGMXW7WYbR0i
 jgzA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1MOiyam/1yeoyO4c/Vj2QMIVginHvK2qtaNlVJ7ZqJY9HZhV+b7ROSwyZQMXbKh7vYJ4rA4DkhimW@nongnu.org
X-Gm-Message-State: AOJu0YzxGUA/L/lkb2ZpSH0BXd2IRBkbpdShdz8lkkvl4XvFRMgRjz+M
 RI6JgeCEVHMpSwWF0QKCllCIr3AZxr0FFL5FfEa9mIEbnO/nqjOqUO6jHUgIFrATmfH3WjeFS0x
 x5Cj59IbMKBFyPrX66TbaV13l8MKj5KsADCVPX36Mh5Y6dB6d79utGRZbfw==
X-Gm-Gg: AfdE7ckITRkcErKFZvdr6QKdF02nGABAAE1x4V5uVNStZZqv3TRhi8fUDoYtp7RiXy4
 5RdI779I/tzU1IXul74A4IZkOJo7EcvCmc7Zvfcf7cdd4Qv23UWNVxvaVh9UCvPWTaZLQq68III
 94O+6TFm/HDIrS0Q+uNVuqsuQC0QqDOFf23egZAIJZweDMuzXwrt25OVR7wegRbcxjHiqSsw4ZV
 7bQ/sTa06/4XKpXMR4IcZWKPQZPnbZxAYq/KFJsxITvUIuVgve08QDtXDKMgwrhdAdbZlTi9xE0
 1M4s/WyW7rX4JBQ4iOgn0aR5B78dJ+kfvmJ8jzwTZpIQ7Bll2yDueA/Bep2hEOfrwOIMCUL7J70
 taX2HDJEg+e88JQ2o0dGiie/2w/y3USI54BYi0XtIsLJBxF4iDwmUhg3DXwT1mA==
X-Received: by 2002:a05:622a:5513:b0:517:87bc:9b47 with SMTP id
 d75a77b69052e-51cbf140e43mr75364591cf.39.1783926696729; 
 Mon, 13 Jul 2026 00:11:36 -0700 (PDT)
X-Received: by 2002:a05:622a:5513:b0:517:87bc:9b47 with SMTP id
 d75a77b69052e-51cbf140e43mr75364481cf.39.1783926696349; 
 Mon, 13 Jul 2026 00:11:36 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm569297455e9.14.2026.07.13.00.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 00:11:35 -0700 (PDT)
Message-ID: <650b9d5c-ca79-447c-b91d-a83d017f42a6@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 09:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark "vhost-user-scmi" orphaned
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 alistair23@gmail.com, qemu-riscv@nongnu.org,
 bin.meng@processmission.com, mzamazal@redhat.com, sgarzare@redhat.com
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-3-armbru@redhat.com>
 <20260711035848-mutt-send-email-mst@kernel.org>
 <65079ad4-3ab9-4ad6-b683-09d46c72b266@oss.qualcomm.com>
 <20260713025003-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713025003-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3MiBTYWx0ZWRfXwQ/ZJJKbmNKe
 GweLD7xGYn4OqSzJOOb9jyijk02PUOMjeMoZvnZMRP1ZZCCKio33sp2yqRrmzltYxjfZTO2tJJ+
 gkLGZy+HXpX2JGfWlUaJjuZPh1ZDWlM=
X-Proofpoint-GUID: 6lK99CdeoEnTE9OAeAaScEV60a4pLF4A
X-Proofpoint-ORIG-GUID: 6lK99CdeoEnTE9OAeAaScEV60a4pLF4A
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a548fa9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=39ZlauuWbp4OStpUMHcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3MiBTYWx0ZWRfX8HpEjQYSuqEs
 kytKw+z4T6969qUITY0P8XJRC7LKkVDCcPzezNZhcoqXKwZ33WFV/OTVc3bM53ahPG6pqZXVnX9
 4cdkUfpRTR+SjgtceuF3v1g+Z1cCnNWcJd+39ZjQhtSUDxpFKoagLbUzS86F5icyGszSPwOPhHb
 tb9B6z0al3hhz9negTBKYoWJ1Ldfz8+Qi2AGnG9Cn7TRHSeatYUJUzyKwfUpZS8edR5n4MCVZPe
 ZJJju+TlD3IsKe4jFXQH4AZe+fVd7E7AJxFhYG3Cm/KHPYTFWJmxytUKHDX74LGTf8bJuqbRT2t
 0YhLHmdxxP3l0dMTZiuFB5cTgUh9y0div9cDo8QuSeBnzGdwr7H37F/CJqjoc0QKkCISPXuXtnr
 rqG2VG7u076/C67wyAl1xDIi9kI4rw6+gUxur6ccbj3XP1k18y34DmJPNZYtnqUAAJI7cVvKC50
 fFKsQMhX/sO/cV6zIeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130072
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

On 13/7/26 08:52, Michael S. Tsirkin wrote:
> On Mon, Jul 13, 2026 at 08:13:38AM +0200, Philippe Mathieu-Daudé wrote:
>> On 11/7/26 10:00, Michael S. Tsirkin wrote:
>>> On Fri, Jul 10, 2026 at 01:43:05PM +0200, Markus Armbruster wrote:
>>>> Commit a5dab090e1 (hw/virtio: Add boilerplate for vhost-user-scmi
>>>> device, 2023-06-28) added the section with S: Supported, but no M:.
>>>> This makes no sense.  Downgrade to S: Orphan.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>
>>>
>>> No, this makes sense. The reason this section was added is so that Milan can
>>> get copied on vhost-user-scmi but not other virtio stuff:
>>>
>>> ./scripts/get_maintainer.pl -f hw/virtio/vhost-user-scmi.c
>>> Milan Zamazal <mzamazal@redhat.com> (reviewer:vhost-user-scmi)
>>> "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>>> Stefano Garzarella <sgarzare@redhat.com> (reviewer:vhost)
>>> qemu-devel@nongnu.org (open list:All patches CC here)
>>>
>>> Pls drop this patch.
>>>
>>>> ---
>>>>    MAINTAINERS | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index aa2df9cbe3..4d558ddee9 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2622,7 +2622,7 @@ F: include/hw/virtio/vhost-user-snd.h
>>>>    vhost-user-scmi
>>
>> So what we want is to add here:
>>
>>    M: Michael S. Tsirkin <mst@redhat.com>
>>    R: Stefano Garzarella <sgarzare@redhat.com>
> 
> But these files already get M from the match against hw/virtio/ -
> what am I missing?

Yeah, just trying to make Markus script happy ;)

> 
>>>>    R: Milan Zamazal <mzamazal@redhat.com>
>>>> -S: Supported
>>>> +S: Orphan
>>>>    F: hw/virtio/vhost-user-scmi*
>>>>    F: include/hw/virtio/vhost-user-scmi.h
>>>>    F: tests/qtest/libqos/virtio-scmi.*
>>>> -- 
>>>> 2.54.0
>>>
>>>
> 
> 


