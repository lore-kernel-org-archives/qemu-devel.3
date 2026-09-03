Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C24C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEg-0001Ox-RT; Thu, 03 Sep 2026 15:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2DEe-0001Nu-Uw
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2DEb-0004Aa-S7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:31 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3FOY417509
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a0he1tBIGuZKfnTWJTXruyd/YwRB4gof6ljgXawSYaU=; b=pBFHeDAtZhNr/W4V
 DJr6VaNngfguWozxZH0serZNhPC+4ZrqDxHsT5BHFB9m3gKo0zMAqkuV+3702NPB
 eCTGB7Pn9BL8FapL4uDlfnj/596IO7+//Tpfii9VyEFbfBz/L62eW/Yhy0dsQmwq
 IolbeQsM43pGGvKWHspt/Zn4yoDt/g8uQwyx9ZWaDCBmQFZs/kQOvGcy4+ou79F8
 u9HJbgrW3K9hIjMCDqrJ6o5nLIwH1JwKisjsh+LKmKHdnpEYibWbk/elCalmTglx
 UZ6jpXKf7uUphr3vN2DqTRaDRrGMTFd3aThyFQOikR5Lzsrd1HEztUPP7fjaTSod
 hjsRhA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m33hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:36:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93771aa0379so46713785a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464187; x=1789068987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a0he1tBIGuZKfnTWJTXruyd/YwRB4gof6ljgXawSYaU=;
 b=QuKJaRLZz87lJ6vBrAcb6bFcU6xLymwm7fj6Y8ifYEYoJMcXkJWiF8C/zwJ0EVxFCq
 dLLU3FRilFntylBx0D+kEL2IIPIVov4GWBZNpDH+e/fFJzi/CSkpyPc+syEhMkCuifwm
 Z52LeoTvd4u2kSGMGZa6O+wtwflfmefTMRGtVJkVVZYhecf1cFF3d6yoDmUjIccglUw1
 DbAAWa3HiBl1WNSi1fWtmhexm0k0mCEuMUeXcCBYuAvVtBQ1HkHemX6q9SAguivKkgev
 9P+upLyTwH9JTMQq8eX99+HLKnx7smq6K3lyd638LyyqDBBvjBSqanV+xzq98DrxorEE
 5c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464187; x=1789068987;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0he1tBIGuZKfnTWJTXruyd/YwRB4gof6ljgXawSYaU=;
 b=arUGGpSgqzSuVC5vxwY7FNy4FycH4UGjvseomo6yS8bEHd++xt0r5p+nGqhSF0hOas
 DBeJ7MuDx4XZS2DCJFTqyKGzCVM8Kaet019IIkz7HHBrJfp3bOySUVefzXpADhZ4X07B
 LhzGN2UgZojTZgidUZVjBtyQa/2JMyRRoaQGDRBetAwkBOlWgHPSfH/NM358Zg+ADot3
 ZZgc+fzm3lZTU3woM8D59FtvKUd70Qq1MQFYzTIn6KFVQ+oIwKPvzr5Zkj8tvs+BIRWn
 SBuEzrHhakp4kDriPFk03c3lkVpJvPlnPynbDnTuCaX1vYCt1fhCSz5WUDrZNGW/JXip
 Hgkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxN3L6ljueNRXdQiQIBc6uWS/LCmqdz6WR3M06mYWm9Vnw4iKkFdNR5fix9C8KEsIc7/pXrcuzUwUn4@nongnu.org
X-Gm-Message-State: AFuF++msk7XVeJa2cu5yISo1agI8QCMbsGGIW1qKBbgqhYQRPPU6T2FQ
 NtqIrqBprWUFH/tcT2w97prK0CZYJMwP9f4vX0BK4+TlMQmUoikk/9++D767n/ozxSpKgScYZYU
 j1/kLjYORMen+QTzud3MDeQ4nVWwPsfSauTCM7bsnf1SaYZUTKU+hRfZG3w==
X-Gm-Gg: AYBFou3fcHk0YTtf2naNV+5wyjY7hs8Vp5oMiCKQ1soLQ+vr+F+5nubsPPRApF5k5VY
 YEReWBaeVtjytfcn5diU+CLs2kuamM3iKD4HlbO06/SIPX6IUGkbKOUX1irMXrm9+8YMbBEExJr
 t+/E6wz+aOBbJhR1i6ygpXSXQ7HzBSRxpTbLcOpPKRU0PVnU26W6Wj1whdeQGb49eoW2Kz/95A8
 MLQePCFCW5pewcI2J9DKswq4MHJ7TP7H+TFWzlk+Wnky0xldKiKg529IxBMkdSVX/BCTjR0dmKi
 t3bStJ4KqwPuG1kVrNeqpW9Gj24QK2g0A9yBg5wu5+vMnavLNmAeJaDvFVR8K2O15h1a9S/KKuu
 a/AG3BxKh8djQjLoZWiLUOq1zq0ihSYTLsj6LlWvNQWt3c3NegvKYyh9YpkTJoU7b
X-Received: by 2002:a05:620a:4105:b0:92e:4927:2002 with SMTP id
 af79cd13be357-9398045f7a9mr89187085a.39.1788464187088; 
 Thu, 03 Sep 2026 12:36:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4105:b0:92e:4927:2002 with SMTP id
 af79cd13be357-9398045f7a9mr89180385a.39.1788464186575; 
 Thu, 03 Sep 2026 12:36:26 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb70fbdsm38861085a.32.2026.09.03.12.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:36:25 -0700 (PDT)
Message-ID: <f06d81b1-35f8-4668-a92b-1d78c129d83c@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 14:36:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] target/hexagon: gate GPCYCLE guest register
 reads on SSR:CE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
 <20260901173353.200474-7-brian.cain@oss.qualcomm.com>
 <f7f34a43-c1cc-4dd8-a859-9ab72e1b015f@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <f7f34a43-c1cc-4dd8-a859-9ab72e1b015f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TcH0b91BwPvbsusme_9FBrXI1aZrsocQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX+aqq7KXpeP5z
 QwwK5kroCcS91RC/mR/pB8/kWoHC1NHpTENyOYaLyRrG39gye+X2BybKQ6Sag579OhaZCq3myqS
 wVxrtTbT9NPCSsMajL/GMmj4g0iMfV1w3NOZnkiMRyUD5suDneNdOLmSDvt9/PZFFxDF7y1gwso
 7sEkTnpMt4wJEMeA7Sl5qpFXTHyC7mY/syEazvATeQsir5VtHSkGrAl/xMpsj41NiMKJToDDaOX
 AndqbIsdZtN7PlcRp6gjZpIOHnJE0j020wTGdLO992a/tTOOMJCPfa3oVmQDaqUly2eYfwDKCUE
 DJgyZu4lKL3WOR6+K/Mu/On6ZQ4egqugx0YIFnM2hRXiYPwLvAPtBroPY+hTAeCm8EtIyUA4gb5
 n3MnreqVIlKsSpJtAlSWI70r3/w3ZyyfmlDnmhRqYODB+Ob8MtQxZmKLPl2NyuII7t+m286fil7
 TDejHd1sBk5elG6BbHA==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a99cc3c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jS4ZdgX6GO7JCDtNl-QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX5Cg4OSEJ+A7E
 0npgBPkpl+zQFPOo4a14EKqzIg2XtnCvteV4hxpO0xzcVMIT/q1Jh5FsoMgC8/wZ5I+L0g1r1YZ
 3PMlCP9yyq/zfjh3igu6ZyjOB32GBrQ=
X-Proofpoint-ORIG-GUID: TcH0b91BwPvbsusme_9FBrXI1aZrsocQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
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


On 9/2/2026 4:16 PM, Philippe Mathieu-Daudé wrote:
> Hi Brian,
>
> On 1/9/26 19:33, Brian Cain wrote:
>> GPCYCLELO/GPCYCLEHI read as zero unless the cycle counter is enabled
>> (SSR:CE), matching the hardware.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.c       | 7 +++++--
>>   target/hexagon/op_helper.c | 9 ++-------
>>   2 files changed, 7 insertions(+), 9 deletions(-)
>
>
>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>> index 23894ff3d28..2cea1927263 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -1912,13 +1912,8 @@ uint64_t 
>> HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
>>           return (uint64_t)(env->greg[reg]) |
>>                  (((uint64_t)(env->greg[reg + 1])) << 32);
>>       }
>> -    switch (reg) {
>> -    case HEX_GREG_GPCYCLELO:
>> -        return hexagon_get_sys_pcycle_count(env);
>> -    default:
>> -        return (uint64_t)hexagon_greg_read(env, reg) |
>> -               ((uint64_t)(hexagon_greg_read(env, reg + 1)) << 32);
>> -    }
>> +    return (uint64_t)hexagon_greg_read(env, reg) |
>> +           ((uint64_t)(hexagon_greg_read(env, reg + 1)) << 32);
>>   }
>
> Just curious, does greg_read_pair() work with impair %reg?


Not sure if I understand "impair %reg"?

But - if this refers to the odd-value pairs, then no - they don't.  The 
guest reg encoding only has the "g{odd}:{even}" designated by the even 
reg's value.  Sent a follow up patch to assert this in greg_read_pair().

-Brian


