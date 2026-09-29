Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DE5CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWZK-0003Vp-FQ; Tue, 29 Sep 2026 08:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWZG-0003VQ-KY
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:04:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWZD-0001QA-2e
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:04:18 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAigh53655035
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EmkWuB4erePbzms8NDgmUf+4ad+7cdJIBt+kGl/eR0k=; b=OfxAk25Snnjb4pZV
 J3xhKGUtlvm9dXN5maaFezXyWdWfImhRZbnJFUAHDtTt+mNql9G9TSmSvcVzkRS8
 183O+DtCt7Nb+4wMWSRHBk2gZ5iiiiIqcOx+8nMaOwJF7XMeqNDAvKZXMBCJ7fe6
 sbHvVeU74S6hqx8gotskwpiFTRcVaw2AzPHYMFodLoYXQmzOwvDhR2XwZz5vr9/9
 VCNE4HxThidZ8tPnXF6QUEirEFWyNmUpX0Sqy1B/WavPdCSr12jSdFprLO8pbUjP
 UBOFZ5evqrC2YgkMdI3ZC5vCYRDQuVemRC4yrHSO52MeBTgK3Ml+XapRAu1PE9qE
 YElXYw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1gbck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:04:10 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7baf8e6056fso1895137.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790683450; x=1791288250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EmkWuB4erePbzms8NDgmUf+4ad+7cdJIBt+kGl/eR0k=;
 b=BaL4DnHF9J25pjRZSb+clcZwmUn+4Hb6A3B3jrG3LYjUX1NdHNrvKsk98k1Vlyxgb5
 ZC81fD1wiGznHw4OVH2Ag4yBYhBnWYWEziC7AvuP/xSdtg+j5XYcy1VusKt2m7oNGtNB
 ElP0mQMUEEjXoPjDqvU/FWq8hbQQt2wRJtwS9MC3YRlofo6Y4IcHK3NxtEZ+HDq1BZBg
 JNaeh7GRY/7lTuSWkulKWKQNnLdZ2MEAoS+c6aP052sEjvozWTmiT87V1mY2M158xHpR
 6utaBanOH89Vh3w4vnudOgSOo+re1FQxLF+vFx4g7bnt8sMaJ/pBjtbN1YujaaGw/R8q
 /SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790683450; x=1791288250;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EmkWuB4erePbzms8NDgmUf+4ad+7cdJIBt+kGl/eR0k=;
 b=yVppUzJXE4rQvQ+/yUGW+MzZp1ATq5PxfJ7d/6ubyqSae7KZERo5LInHzEEvDvCGDx
 9fAOZY8qmdbhMQdXJ5LOP5n3tGjtyXWUOe/Dwr5fcbD9Q+YaosQiNwTSQQXZC3Piw0WA
 Q2IHMX+UhJguR/xlMr+UGmeycvkFMLgJ94ckoUQk/uG3vkuyFcsAHS/YbzCUlameiVB/
 FTVyWQV6ovjneNmJvfnqdIt5uF3EiUgfQZQbeEzlVaPEpy8VM39Mct/uRQkkjgaUajG5
 5pcU3pLneHrAruZ+Ch15mtu3retJbBCic0Xa9dJoe60XLBV/r4H1Ksn6V95FesPqzR87
 NpsA==
X-Gm-Message-State: AFq9FYIdlxFpWn7xAQodp2IEnsSAXmcw2G2zw1tr2/0Q1PFfcVE/S/j3
 qGpoG6IyNvgDXQOuepUfuhVSphRVXupk+zWuqImLuw5JA1TGuGceqOWXBBkwz4I4DbspBdGTAbM
 HboB71FLGpw9HuY6T4BYbvFubLqCzT4pGy+exPP1wgXA5ND4BINrLhdPMfA==
X-Gm-Gg: AYBFou1ynDvRNJ1LG53SWArl9D306ZjMV+J8+zHrJiVLbeCvx/xe2FPQfIEzsTQWgkO
 EdAzY9nOgQzad2AqgVaBfCDZet6DGEeB3DGwPwMK8vs0nnHOB9UCh0w5kyovwqej+Ki9mD0VLGc
 KKLWZnmhftlnzRSoYnWUtc5okOwkizKndW19Ks+zJZkGHFCX08oxwq+IXOB9p5fHjm68zhRCDCK
 ZK8QeV53qmlMSi9jy7TT0CejUlfoMVXyqZ19YJz4hFeGprk5jH+2f+4OyltP7S0ps0chLnEOKFO
 mpjs/m3Pwjf/QRhxgrfotFXj5vhxd5MSorOQsJjSj5DNiSAp1pMPE9yW2PRyt9V4fCi5WCcQdEi
 qpcXtt4vYR2HxnMgHQpcoS4tOcL70qUMNoA==
X-Received: by 2002:a05:6102:f0b:b0:7aa:7769:34e with SMTP id
 ada2fe7eead31-7af1c58fa74mr4679784137.4.1790683449578; 
 Tue, 29 Sep 2026 05:04:09 -0700 (PDT)
X-Received: by 2002:a05:6102:f0b:b0:7aa:7769:34e with SMTP id
 ada2fe7eead31-7af1c58fa74mr4679768137.4.1790683449084; 
 Tue, 29 Sep 2026 05:04:09 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af502fedasm3254518f8f.7.2026.09.29.05.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:04:07 -0700 (PDT)
Message-ID: <2c202493-cbe7-4fba-94b3-979c41df938d@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: add missing stub for
 vhost_user_has_protocol_feature()
Content-Language: en-US
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260929101623.1352299-1-dtalexundeer@yandex-team.ru>
 <aruTFz6mgOJpcQAi@sgarzare-redhat>
 <3cc370e8-a7f8-4285-b2b8-8e2bcef3e17d@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <3cc370e8-a7f8-4285-b2b8-8e2bcef3e17d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX6t1KD7pbPHHA
 QWqfLx4z7PznLMjZdvXH5SAlHr6AwcyuK9vVF2UAxr5nC3oSZAIrTiG5aH14A1BgmmsTfiBeHaw
 e/lmXw2CuJ6CFXYWJWk5L9lsFkX4ml8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX8oCoHlzMs/Xy
 xGktgmQKl5wf99IK0zL8Edp346FM8Rlx36GhHO3MDGGX89qvr18HP3KirHlro6se1PBXupNasnj
 J6aXLHk9zxSvz7WrQpOUUHXhjSGRD63ri59zb9yyr3aP80Ce7OdWEoFA3E5BSbNHSckdpnGqHu4
 poaQg2U1Y9yYiRugU+tD5JOd385qIQEL5E4wKqNw0V2v86Ha7br6zLEopdV/FA7t4wToTX30EgE
 JqJjb3uA85BaHZYf9ZUCjJAgerCic2Hd8MvGzS5lCf9KvpXjEuzSYVZ9CZUmGpsmp4sq7FNUbIY
 G+YvUY7jK69dGu7hmUip6KPPLz7g4sP85LpgNKuHCMOvLivIJalzEgTqoFWJRygOUaEjAzFrz9+
 +GSG5rQUY0uTbHl97AxS4fw2noMoHWqQdRhxLxOu1cB+fDePLqinEtOui3IbQAxR2M6kMdVbPS6
 itSeJ9T/z7skfC9D5hg==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abba93a cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=A8oJy8mYAAAA:8 a=6R7veym_AAAA:8 a=yoWn6u5s6PhttXcOcs4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=MasS0_dV9q-jaWZIey9J:22
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-ORIG-GUID: 1cOObpbTcSD3OchyYQvgx_ACYTLRhHvR
X-Proofpoint-GUID: 1cOObpbTcSD3OchyYQvgx_ACYTLRhHvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 29/9/26 13:51, Alexandr Moshkov wrote:
> 
> On 9/29/26 15:54, Stefano Garzarella wrote:
>> On Tue, Sep 29, 2026 at 03:16:23PM +0500, Alexandr Moshkov wrote:
>>> Currently, building with --disable-vhost-user fails to link when other
>>> vhost backends are enabled: vhost.c calls 
>>> vhost_user_has_protocol_feature(),
>>> but its implementation is not built.
>>>
>>> Add a stub returning false to fix the link error.
>>>
>>
>> Should we add Clément's tag?
>>
>> Reported-by: Clément Chigot <chigot@adacore.com>
>>
>>
>> Fixes tag?
>>
>> Fixes: 5eb2347867 ("vhost-user: add skip_drain param to 
>> do_vhost_virtqueue_stop")
>>
>>
>> Is this one, right? 
> 
> Thanks for reply! Yes, you right. Sorry, I forget about this tags..
> 
>>
>> Looking better at that commit, can we avoid to call 
>> vhost_user_has_protocol_feature() at all in do_vhost_virtqueue_stop() 
>> and put an assert in vhost_user_get_vring_base_skip_drain() to check 
>> that the feature is negotiated?

Yes please.

>>
>> That said, not sure if it should be an assert TBH.
>>
>> Thanks,
>> Stefano 
> 
> Thanks, I'll see what I can do.
> 
>>
>>
>>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>>> ---
>>> hw/virtio/vhost-user-stub.c | 5 +++++
>>> 1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/virtio/vhost-user-stub.c b/hw/virtio/vhost-user-stub.c
>>> index 45559788dd..9d2e521788 100644
>>> --- a/hw/virtio/vhost-user-stub.c
>>> +++ b/hw/virtio/vhost-user-stub.c
>>> @@ -4,3 +4,8 @@
>>> void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
>>> {
>>> }
>>> +
>>> +bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t 
>>> feature)
>>> +{
>>> +    return false;
>>> +}
>>> -- 
>>> 2.34.1
>>>
>>
> 


