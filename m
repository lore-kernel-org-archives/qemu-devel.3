Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C484ECA5FCC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC1Xk-000753-45; Wed, 30 Sep 2026 17:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xC1Xi-00074v-Ls
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:08:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xC1Xg-0008GI-2M
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:08:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHfp7F239300
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZXiCHHnfcGSVEOHo9dd9akEQMJchAEM1OjF8CsTO6Z0=; b=kMcRYEHyXnHsBFY+
 oDX9Vf0a9bc6V2vtbXFZDbkQFEpMGDi/v29DGP8eIGd5Cr/CNM+rGLfIZOJFiFZA
 aJY27+Ypbvurwsa8KOVzyV9lAwCP8Lqy3hJ08ZnTUDEfiLKkj0UzlhB7nYxsPUAp
 RrBhiXwkg/ILzWD1zOnsMzTXoNy+Nnw317ppadUIxRPiIcfZUCDfuAIb93JYt7+r
 D1M3AwXPOKzJN4JSvi2d1GsQbl6LO3SlNmYQ93jGbLe30zag3NjxYXynU03kNr8p
 eunFkqlJyIRebvTXcdZopo2Ky60TkEaSp4dq+MqswO8gnYyNqnWablq99x18a0sd
 /4S+xQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0w143teg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:08:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5337f26ee19so18718971cf.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790802520; x=1791407320; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZXiCHHnfcGSVEOHo9dd9akEQMJchAEM1OjF8CsTO6Z0=;
 b=VyW6pMRJJj8FViGjjP+Heo+nrr71kQqynzm+XXmyHSYktWRV/N12C1qab6HVT7hIgz
 N7N4SVz2GveXmFKHxzmTACee+z3IUBTGuPRpvbtquMgTMKu2SQWKEefKBZG7m6K2bflT
 5z8iQwCTAVn3WgOX9Jsopa+snM6gGfMLpip2XM1iWoOfAHmydyNc+lm+j9bubRnqySil
 BAz+FURZHv2cLWTMNvMo/e6gNMmoWlVepsn0S3hpo4Dr3CvuGt71IGkjs7mV1C6xcwZi
 nej5Uy8OKYqpf3vRXmycgjH4vNJDejHO4bb3enWBgWzGn/USadnykZ+KHE3chiqr+z86
 5nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790802520; x=1791407320;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZXiCHHnfcGSVEOHo9dd9akEQMJchAEM1OjF8CsTO6Z0=;
 b=gCwiLnMTUJqj7XjwgeZFPQtWZ5M5SG9yFRZQiMBRxMchjZKn4nvMczfbSuu15qvh0p
 uYhCkrwn0++dxTcW9y3YRJcG9aRaBMxhbZNt5KOSpnIhpTAAVif3MDZ3jkvFYKTyHBo7
 oivRp3QpXvP2o6uzQM67ToRbhpWJihAVnN0aMq16TbNr891uVBtqAAmIejWXvc3UQY5y
 IS5qLicGIoIrV6Dsp7Bcgn+FgKLKDgqEbdClFg/4kcTssmkSAZySbYxk3oIpO6bNUnQz
 xDsVfJKNLhHaE/LfUxR9hZ7veyoDjf/0ExWnh4wPSmtdmuVlAdp8ze98SwL5hqiPimL9
 i/Nw==
X-Gm-Message-State: AFuF++k+UjplZ9vvmAaYz8PXZMggVKjUPMCOBVccTm3KkKpdUnKRFzks
 5CINxTmndsdtwCvLZ9CQB5kPwz31MfB4JdOik+7UZuMfK1vr917FnjnxUBWJqO2knKzO8rxfZOK
 /OxVl4D+HTQ/I5VyyDehB8/FMJxi62m1VeEPWMJyalu/ZUwt00Ul1WjeEpg==
X-Gm-Gg: AYBFou28vcjfr8VLTzsMuTFw22TbPCE/nJanr9+FFaAyteijquKRewI/cSLgp0gscOu
 xM1jzJH0aLioCfZJccMq9Jhuhdo0R9JO7AYvpfqDlCVsal8LFJQA7e2J1XjOROitb6qez7TuMmQ
 S9XfN5PzbliNgPV+xtHmCJC5YAmHOZAGqE334qzlfKyBobxynSu06CK6AdF90lLD4Xv1UPURgSw
 dKg2feoH9ql0xJyTKT9QeIi5iW2Kbwh3I9ecffoO83h2V1qes19jx+KeG+UpU3UTB1t2/ECRHh+
 UPfLYT2LTYT54XA1VhFU/lYAjkQl91POzWteh9Zj6ixUfZoNFpYJb4SElmsQm7D2dPVrOpaA81E
 1nx89rq9VuUjeLYB5X4/g+DLDrqhU3SNV3XGQedmDBPvinhr9oo7KeHIduUHdxF1l
X-Received: by 2002:a05:622a:2609:b0:533:3af3:43b4 with SMTP id
 d75a77b69052e-5337447ff73mr51497631cf.45.1790802519642; 
 Wed, 30 Sep 2026 14:08:39 -0700 (PDT)
X-Received: by 2002:a05:622a:2609:b0:533:3af3:43b4 with SMTP id
 d75a77b69052e-5337447ff73mr51497101cf.45.1790802519138; 
 Wed, 30 Sep 2026 14:08:39 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-533861a483fsm2512031cf.19.2026.09.30.14.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 14:08:38 -0700 (PDT)
Message-ID: <1bd1a198-2f49-4a37-a23d-a9ec85eed10f@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 16:08:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/hexagon: reserve internal HVX vector state
 for QFloat
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-7-brian.cain@oss.qualcomm.com>
 <CAJ+KCYPENyZkgspL-a1C=8gAtpqfNTe5k91h835vqCHt_x0brQ@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYPENyZkgspL-a1C=8gAtpqfNTe5k91h835vqCHt_x0brQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4NiBTYWx0ZWRfX9174U79OL/yK
 hYKgt2P3nNfoBLy3ZjwPdf0Kuypoayb0Wwvf2pkdYDT+J03S9lM1i2CRfnwqkp5wQiAOMdWlCyH
 36usx14JWKGumMpqD3gsEBL9V6YVilU=
X-Proofpoint-GUID: OjtKFHnn7EGY1YPjqrBGGQiA5AzQR1DV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4NiBTYWx0ZWRfXyUSPSCqvUH2X
 VKBPE430yjRicDonBx3UEjuAaspxkcdpWVZd6flMvhHS1FbEpYILq1ZSF4PiaRtQYDoVPPLGP5a
 VvOWYUyGI9PjbLZhdSRM79i6rg8heUVq/r3YJf7RKATSOMt79i+QM3tbV1/X20fyolgEKe9a2PL
 2dI0d7TqCi8PYTNpvtQ4gW7NBbjCPZl2TWTqxDJCEu6KYRfecgM7FuFtvte7rIbbRDBjBs8H3ir
 OAndw3Nq66cJHoOMn7One6D3zgKCqHWkQ7972qLOyptQokl/km4qLV1bRI0JOGJbfqx55gSXscd
 cLIq+S8l6zWJHPiq5KuoQSTJbnHYBnSM8vsAey6pWQwdM3uxPWhz3J1iX+n+TpyCAfULk/8Wu8i
 +YJJWC0sKMXHgyqkZt7RQ7zaL2d6I95mq3HWM2n3HRCea0i+cuWX15rlBc54WphtuKHc70kgVBJ
 ynLt5dZkeBkjOWXWy3Q==
X-Authority-Analysis: v=2.4 cv=J8Q/fwnS c=1 sm=1 tr=0 ts=6abd7a58 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=6dohkdjVqM2vCpG2ZacA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: OjtKFHnn7EGY1YPjqrBGGQiA5AzQR1DV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300086
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 9/30/2026 1:23 PM, Marco Liebel wrote:
> On Sat, Sep 26, 2026 at 2:23 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/mmvec/mmvec.h     | 55 ++++++++++++++++++++------------
>>   hw/hexagon/hexagon_hvx_context.c |  5 +++
>>   target/hexagon/hex_common.py     | 29 +++++++++++++++++
>>   3 files changed, 68 insertions(+), 21 deletions(-)
>>
>>   /* gvec needs VRegs/QRegs 16-aligned within the struct. */
>> @@ -26,6 +30,7 @@ static const VMStateDescription vmstate_mmvector = {
>>       .minimum_version_id = 1,
>>       .fields = (const VMStateField[]){
>>           VMSTATE_UINT64_ARRAY(ud, MMVector, MAX_VEC_SIZE_BYTES / 8),
>> +        VMSTATE_UINT8_ARRAY(ext, MMVector, MAX_VEC_SIZE_BYTES / 4),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
> Does the version id need to be updated?


yes -ish...

I deliberately omitted it because it seemed like a lot of churn to keep 
updating the version IDs among all of the different features impacted 
with the upstreaming work going on.  I'd hoped/expected I could make a 
single update to all of the vmstate-impacted structures for 11.2 rather 
than incremental ones each time they changed.  Not sure if there's a 
best practice here.


