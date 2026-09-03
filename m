Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6268C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DBU-0000Yo-K2; Thu, 03 Sep 2026 15:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2DBT-0000Ye-3y
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:33:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2DBR-00034e-Ct
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:33:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G34IW3958106
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HddOa8HUFwL0nxY8Z9jSG3bhJ4831tK9R/sNPCqydK4=; b=W3BBrERPBQZexwsn
 1gCOwrIQtdi38v0/ACquif+WApgQ6EzTfjCexKtJieMQu83y64VWEZ+YbmOY9fc3
 LqFjS8xxZsVnESeZfFzNfFsHqK7y3asMAqC4GrVe0OkxiRotooiiAls+EzWeZrdS
 zClP4vcEJNNRlP9nq/FRTMx/7TlWRxgeaIcy0vtVLC54dqedXD0+ZsuoAvgb6Od0
 gtf2YNr2KG7WCGY/VWWL/AycCXii46MM1ZP3AzSHjamNLlKhKFEkHRSr7r03A+7F
 6omA4FWUgWZZdXokH1V1h0mvNDQq/iJUvMLtjTpeu+r91eAS1ahmmO1qJ7WLRPQG
 Jj0BaA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d12w5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:33:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93494cce712so33612485a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788463990; x=1789068790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HddOa8HUFwL0nxY8Z9jSG3bhJ4831tK9R/sNPCqydK4=;
 b=PekkvWMxamLkrBCIKZk3/rOkklSZBqKYCRcsi8gct5M+KXFQwSmtoCfzmWgiHfJebn
 s81ZhLDsMO1h9BMuZhOWB0zzz3Zch5XeqAiSWqkL3u7AMLbGmIBMxP7lB9AgrMwHMXXp
 NYee46zD6oiBeLpmwvkGDQs+nsCLLcJKxPvy3mc5UZO5Lpo0ojdh8muVGDPywUPYlJNp
 TtKvQ0Bevo8IO3jIbe6IkC+oMuQ3VhKpdDXY9yIzVuOXhbx7ABJP/hOTlv3fiuwq9C/1
 Ev0Mn/t3Nrxpik6+9HSxku3UzHs+e7l1NAdtP/nanTPLfNUPUlr3CYVSuQIGGNUEsB93
 4YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463990; x=1789068790;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HddOa8HUFwL0nxY8Z9jSG3bhJ4831tK9R/sNPCqydK4=;
 b=MyX/oGittPtU6qe4O0RUfxNO0X+1JzyxJ67wRxvjBVGVOY4gJ4qovkhkStkGr4eHWM
 6AAYtdP2Y9k+b4GOsHd4beg3jAxhBOmDhJjhrKgLcZxZJtbfRob4N/eHFD0CRM2BkSPG
 x7n4i34Qb29lFkUw2A+7ZEDRrIKx9LPWJLfRekHUgPty7r1Hqx8WWKkbledmrN6IiR6Y
 cvNKanDBwuDFNQPpeyNWrjyM7DQ9aypjtZf8yaI3GTfPFPvpPkvxrNgW+d8yVq3argMN
 FsPTBM4tz0OWGZlgf1qZcI3QZ+txTaEkYytW1tuVVyFOLq3fsD/RQG9AmNAS5uZbkHUU
 P9fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+iiCvz2nVDDDBUwBzpkiLINPWwdj0qXRDrZUD8kmkaLmRg+STBS0doYPRVeY1d7PUtLwc/b7kHh5M@nongnu.org
X-Gm-Message-State: AFuF++lqLqVlk1NghkcSOZ5nzCGPx1xHbPQVQ1XLPm1rfNpbFNTh2KzQ
 vubrIkSgaLFuHErMwTenhLBTrPvM1yHCRHRbzmMbqdTf4Pgugmg2rUoSg/43D6rJ1/Tp9IbotEj
 xL0KToThzI0JP8B3L54Mxw4YxtdzIj5grnuHa1P4jZUfX/Zf44EknpIp22g==
X-Gm-Gg: AYBFou1+yNEBU/I2pYkM/fPWFxUsXU9SkaDc4qvAfiOCr/Vu0tUjZrPK5DNkdXsKJfr
 CLUW3yHTwYUPnEWxbF8SRjA8vzKUdE3ifyU+roqHUXY/J8Lhbgmmee8cZEmFcVvqG0DASvI54iO
 QjY6kkuRWBtruOklaEfmHPAfdyN3CU8FQzlP3KUc9IzOcXx4pL7/RgY84wsYvzdbqoAt/pK55W4
 kkx6K5sEOho7eYAWiJzWMti9t1nZkNuWDs5g04pDLtxxZmqtASSjoNyBFupU2IpkBpOEAtuQuNE
 3Cg+tFIOifEzUuOf+Ga95efTn8vgFuMtSKT56LoPVAvK9fzJVHQsnliudWifEwRHOno4lrzJRKw
 cTkqqh8BVNPwekEY42RTz63v722bLBXnoa6KIrBjQ0hFIZZJe0KRZIyVOM3bIzW/6
X-Received: by 2002:a05:620a:a518:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-93980434f3fmr85043885a.27.1788463989897; 
 Thu, 03 Sep 2026 12:33:09 -0700 (PDT)
X-Received: by 2002:a05:620a:a518:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-93980434f3fmr85034385a.27.1788463989235; 
 Thu, 03 Sep 2026 12:33:09 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fbe00f9sm39392685a.45.2026.09.03.12.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:33:08 -0700 (PDT)
Message-ID: <f7722094-9184-49e3-b249-af8851f61f54@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 14:33:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] hw/intc: clear pending bit on l2vic de-assertion
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Sid Manning <sidneym@quicinc.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
 <20260901173353.200474-4-brian.cain@oss.qualcomm.com>
 <c3f2f4e2-79e9-4b3f-8bae-88c669a34c0b@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <c3f2f4e2-79e9-4b3f-8bae-88c669a34c0b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfXwILQ+SBpeGRT
 teO3NiPLxogQ+nFu6auv73rnsuS6IA1NhvSS6ejGBvZdTR2R7zGn55GVD58UHT4excHrKddQZUc
 FK4XJeYpjhz9C+uM9mUnZmc2v7y5QHcmoDz12GqVGrGcpxhZfjWkxpM/kVbdnLmyoW5VDHNuR/O
 dFZIYSHh9AxDlATrhfFrPeER+L2GsWLKL8AprLJ9UHL0J69sR2tToOiaGLunMkkqQaVcFy27h+I
 QAl5K9aVWcpKlQ0rXH22P7nH1UAnx7SZl1COrtAwhqgretXcHraHPgHBOSYT5LTcTTO6UMsfdbb
 YV0cWfIE55rZn2aZQ0LXXEUawcZZkNaNe4o3woFFpiKFPQUmcB9TxRu62SVZJiJNlIe5HRADCSL
 1lU59rSfYvYLXwYssRxT/gF9zz2bKcsOWXZonsNMJ143+1DpBN6/FLTLdhJ+AkPtY1TkllNWRb4
 DDFI0rncSmEdazgj8ag==
X-Proofpoint-ORIG-GUID: 5ORj0OrctE7i0Sevz_G2AONc_qpPiDio
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX+2IvMd1GjXx7
 E6v5fHM8hw7HXa4zUUEA8GKDOV6tnNR/zTOF/PPVa0ystYLMoPTXSEDIsjnbQIkuSh/LyNiKGNB
 GQfbfuq0NZO1mGLLVNPmK0Y7sdynxws=
X-Proofpoint-GUID: 5ORj0OrctE7i0Sevz_G2AONc_qpPiDio
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a99cb76 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ADcBvOwrLhjZex7uqdMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030170
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


On 9/2/2026 4:30 PM, Philippe Mathieu-Daudé wrote:
> On 1/9/26 19:33, Brian Cain wrote:
>> From: Sid Manning <sidneym@quicinc.com>
>>
>> l2vic_set_irq() clears a level-triggered source's pending bit on
>> de-assertion, so a source that drops before it is latched into
>> int_status is not spuriously re-delivered on the next ciad.
>> Edge-triggered sources (int_type set) keep the pulse semantics they
>> already have via SOFT_INT/set_irq(level=1).
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   hw/intc/hex-l2vic.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
>> index f07ec850d49..a986f0bdf35 100644
>> --- a/hw/intc/hex-l2vic.c
>> +++ b/hw/intc/hex-l2vic.c
>> @@ -299,6 +299,8 @@ static void l2vic_set_irq(void *opaque, int irq, 
>> int level)
>>         if (level) {
>>           set_bit32(irq, s->int_pending);
>> +    } else if (!test_bit32(irq, s->int_type)) {
>> +        clear_bit32(irq, s->int_pending);
>>       }
>>       l2vic_update(s, irq);
>
> I'm confused with l2vic_update() logic which seems to
> duplicate a bit.
>
>>   }
>
> hw/intc/hex-l2vic.c-95-    /* Edge or Level interrupt */
> hw/intc/hex-l2vic.c:96:    DECLARE_BITMAP32(int_type, 
> L2VIC_INTERRUPT_MAX);
>
> Not obvious, so 0:edge and 1:level. Ah no...
>
> hw/intc/hex-l2vic.c-268-         * Only auto-disable for 
> edge-triggered interrupts (type=1).
>
> So 1:edge and 0:level?
>
> Tiny helpers can help to make the code more readable:


Agreed! I like this change.  Sent a follow up.


>
> static bool edge_triggered_irq(HexL2VICState *s, int irq)
> {
>     return test_bit32(irq, s->int_type) == 1;
> }

