Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3312C98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 09:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAOvW-0006c7-HI; Sat, 26 Sep 2026 05:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOvU-0006b7-OS
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:42:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOvR-0001RU-Ie
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:42:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6PXZB3449303
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bCPZh9kQkoN5x81Ijt4ietD2HROuQY8JrqTamKeNAw8=; b=b3Nn2mqL3gGx+f4u
 0h9NY7BhsMScnggvOUePebyMdpJ8qX75NylsSKjwH3Q6t5MsT3XuaBPlY0vIbmTi
 rNYfe3qZiXylFnyLCQXNFGYUaaE9e9vw/9bWQp/Tms0UWKG/OP9hQYfj+iv9TTJ2
 WOVjLze+sGcrbHyu/J6taF1SfqI70sfcpuZnXUrCHdVjb9V8FoIq3zVXrf5LlIcL
 /s8ZF6va5FY4/QhFtBQi2dYnZKjH1ToMxs4zodF6zlvbOfCAPY3u6vnAxa+vKNJh
 f3UyDIuQJr+ZpJrvR2LGbajWjYWuNABD9UgWq2h/bjbq+hQv4S6Vnb+8qHp0M/Y2
 lN8zoQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6938k83-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:42:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5d7c4c26so70402585a.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790415751; x=1791020551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bCPZh9kQkoN5x81Ijt4ietD2HROuQY8JrqTamKeNAw8=;
 b=Gey0FzqPKT+r6AG5IJjclh33lwrO3OOt8XeIx54pA7lDu57cw/I7AvjSM7RiMuuXd4
 mOQdvQLCCn75lFvnSbM2przEVxdyNbMUKSSiOtnwEa2E75oNe1UKCej5+yPJ2mMzBOmj
 VGK7vFxlCWI0KMyaEB7QZ4Ingeq/n7viQGWv2hLpS6V8j2ieLmZcDuzh3+cKFKj2WgoP
 xEEFnzJoKgOLeeB7NS1cxmQNv/zjkpd2RqlqEiBgKG4xYrKEtLeK0whYCPAzWj6ekdar
 1Tl61FomiR0H6UcdQVDYiwLEbMZysfXMfThfau9OaOK1HDZ7tsT3hN/wjZPoxdDUBBaI
 dZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790415751; x=1791020551;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bCPZh9kQkoN5x81Ijt4ietD2HROuQY8JrqTamKeNAw8=;
 b=h7wRs/UFDiIEYXL+IJ9X9Z08pSgl5218gbhZ0o54yMgiUmvkHA3J8dmmqiljRB/ZYp
 Ys4XTpJusumqDhWQJwCpenEEjfAAO21RoPIHjjyk34UxOIni3JTGjRYvGN8pVeBm2XUw
 HFn5JFgxjBCwl8guCvgcrQ+cRr/ZLYiGhRHxdGVK0Akal2vUqhpZCo28YOuZlONVP8Pb
 g2VbN4Uo5UdngG3f9Me13caogA5uouwYF8ZVaeb3KloqDlIWEAuNWHcVHvUZECqBwa5H
 wMmJhMVefBbvyigMr+rZjYsLSrVn98HyvEUftuum9pybFcL3wEFsD/dw0Wd8ccx0xVl8
 NEuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2Cx3TqZus1/fZ36JKEqNtJfLuYsXJpWqTONLmdZs7eaQq1OVI8cCSEAWeMYEEjpu5wAzCQ7PhHsPq@nongnu.org
X-Gm-Message-State: AFuF++lOjzBFWz/HtLOQEujSVXXxbA1BB5Mt8psvghzwDqS8DQa8gMms
 FKFS2mQFGvLzmwrj7hnXaeiDhv8pV8syY+LCYsVoQeBIuiLkwOuhVpO+a2HT8Kjn+0IbNrdywOZ
 gyJkvFMjF215D3HsD76WN+7RZ9n1tsWXrNCDd1ToPvjPYPFEcYz81m2ll+A==
X-Gm-Gg: AYBFou1qgNZ2Vm06we2SBazBkNciYsa/1JeRWaKItKSKhlCZv42TVTxJ3lOhRnqnm6o
 B8s4G7W3RlUweJq7j3n2P+CbzxH2W2e76pJ/sZPKZ8UKRNeNYy3B4Yxge9thnpboHY38y4qAP73
 ceZfN8tTuX1EfK4rjBw8JOl5m+T2VRP1dOjOVigrMb+SpzXB64IAZ5hSZbiSqZi/U6NQlpyRJHO
 CxArf75KImDc3HyZM2S1Al2ryzMS5Mm88TBx75DbXPKpeoQZgF9dG7Kg4Gjijwedto3Dz1V7JPu
 oVj0Kuhv65XBHQFVWCxUVtR+zuYHk4+T+6gpKbjQgyj4ewsMWw0tcesGvy9v+2UlCLoPNGuHQRv
 0Go0FYIsdCL5hDEKjcCB0e4z8DdIkC7mpZw==
X-Received: by 2002:a05:620a:a7a0:10b0:93c:56a8:a0a1 with SMTP id
 af79cd13be357-93c56a8a319mr259718085a.58.1790415750633; 
 Sat, 26 Sep 2026 02:42:30 -0700 (PDT)
X-Received: by 2002:a05:620a:a7a0:10b0:93c:56a8:a0a1 with SMTP id
 af79cd13be357-93c56a8a319mr259717385a.58.1790415750208; 
 Sat, 26 Sep 2026 02:42:30 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm13434275f8f.12.2026.09.26.02.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 02:42:29 -0700 (PDT)
Message-ID: <52c613fd-41ca-45c0-9d74-faccb58c11cc@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 11:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/bcm2835_cprman: correct register index in test
 for mux update
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Jonathan Gilbert <logic@deltaq.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-trivial@nongnu.org, Luc Michel <luc@lmichel.fr>
References: <20260925100726.1546566-1-logic@deltaq.org>
 <507fb835-61a8-4e66-80f4-1ae6f07a5bf1@oss.qualcomm.com>
In-Reply-To: <507fb835-61a8-4e66-80f4-1ae6f07a5bf1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAzOCBTYWx0ZWRfX6LgA1vAwuulf
 cLj6kqRi203fRc01dVP/9mHz+rahLBpS8Jlr/qMiByK1EMJX9TZH6+NQquovcCxfYoRRgJvLPtD
 zE0KWnMrPPKhbiamgJ1wt1F0yjFKcRE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAzOCBTYWx0ZWRfX/Wvi4GnJ3dvA
 86Rdj7gjG568j9TyhHKERXR4t5AQAVWmGlzRF1AlqBw9EerA8VFnLAIJ/OxTK5s3MpKmswlp84j
 7RpyEEN9Dp2Mm3aIZxC4BKj9BG16Gq27/+v/m/h6QOg/VHug1C/1m0Dq7prZcF09Zdj/77mmhxB
 Qgmczy5IpPi0sbsjiltul/GPr9uptOXbzi6chmPRQZuoVbWUYpoQoUeVwL8YU6hvLpS+AhzTSvU
 0mNasV3XbbzYHpG/BD9dJ/YcY6ZTa1ILNimjz1S6y2Z2ZOOKEJ2k6VNwHqEmkAYl9Cn3hkDNVXU
 8KSyC7LTV/RAqlLCIUtVyDw5YAQmCasTNKEwKeECiV8xhDVV2ql4gpMNTvMbYMpQUVi6nLwzMIH
 pSs6MV+nX4Yy1MkXg03W4qsX+zvsdFW8H7VBolqyWIT6n2whNIkS5LFG4YLmLZBP2BcP6TdYu8D
 0MLulSyklZG2D1bRhNw==
X-Proofpoint-GUID: ejnRYCsDBSJD28JHnUrnxw87iOiIkqLF
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6ab79387 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=-ISfGIX_AAAA:8 a=KxR8Bmsjh7JHXhFszHQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=6K80JWTZPwV2TOQbRzu6:22
X-Proofpoint-ORIG-GUID: ejnRYCsDBSJD28JHnUrnxw87iOiIkqLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260038
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

On 26/9/26 11:30, Philippe Mathieu-DaudÃ© wrote:
> Cc'ing Luc
> 
> On 25/9/26 12:07, Jonathan Gilbert wrote:
>> After each register write handled by cprman_write, function update_mux
>> checks each of the clocks to see whether the supplied register index
>> applies to it, calling clock_mux_update if so. Each clock has two
>> registers, so it needs to check the base cm_offset for CM_CTL and then
>> the next slot for CM_DIV. But, it was checking for cm_offset plus 4, as
>> though it were a byte offset when it's a logical index.
>>

Fixes: 7281362484a ("hw/misc/bcm2835_cprman: clock mux skeleton 
implementation")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>> Signed-off-by: Jonathan Gilbert <logic@deltaq.org>
>> ---
>>   hw/misc/bcm2835_cprman.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
>> index 8220f7a6b4..f9a77ff9bb 100644
>> --- a/hw/misc/bcm2835_cprman.c
>> +++ b/hw/misc/bcm2835_cprman.c
>> @@ -508,7 +508,7 @@ static inline void 
>> update_mux_from_cm(BCM2835CprmanState *s, size_t idx)
>>       for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
>>           if ((CLOCK_MUX_INIT_INFO[i].cm_offset == idx) ||
>> -            (CLOCK_MUX_INIT_INFO[i].cm_offset + 4 == idx)) {
>> +            (CLOCK_MUX_INIT_INFO[i].cm_offset + 1 == idx)) {
>>               /* matches CM_CTL or CM_DIV mux register */
>>               clock_mux_update(&s->clock_muxes[i]);
>>               return;
> 
> 


