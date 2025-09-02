Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2078CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIYd-0002cp-BR; Tue, 02 Sep 2025 00:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIYc-0002cW-A2
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:23:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIYa-00015i-CC
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:23:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rtdl015204
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +dySApDg8xu5H7CXLSDmFXCif6UpW+jUjSzaDhWYEjg=; b=PJqBzo1rqrzmGjuF
 fmkvfjZbyR/Rq3uqVjC6YjVeZXNDXiWG4GJ4wx3bo7tw5fWGBYQIVyJ57nU5glZY
 orfQpvy+RUAIZADNEB929K1Gi1Vp+bFx0rXBe6/h01LCGiJRUEzQu/SB3iDA9Iqh
 3zAeH9asBDMDsHzZ+7L1WCVVxAfd6R1ujwTKlQ3b/E4UfRxMWy7uOWpzNMpPu14X
 8knb/zbEH95GaqCtm44/0SSw7PKbJWLI4SuYADNlXALT72lk/xzHkJmwRiFHUGxb
 DykvxVAEvS/sJLp6s6uN/3LiYNc51IXGrhY/CLFpyELe3T82Onlk0eIcKF7+Z2kz
 LzlR0g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxfsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:23:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70faf8b375cso51871146d6.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787022; x=1757391822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+dySApDg8xu5H7CXLSDmFXCif6UpW+jUjSzaDhWYEjg=;
 b=Q3XRzTBXnzq0WB9Zz4wwXdjyRo/HTNgGv4Oel1L/Eatn0paJ4k9BdHrD6XOTsqWHPP
 2cK/orMvIwLORyI2baErp9E3MY3rwU75h58ychBnjdeeXHdIZTU6vXi0SoAPmXwngCW9
 CEidtjR6hXOT7S32coyATc1rpwNjQFNr2/N21nK17FH4Y23A3DM7ov4+PHakEv8vc6wz
 O8ds/0Nd7QGYwhyDFUyah6ebSFCs9uelpkFhiXinwJO71jI+EanZlhoDGp+KbwHx0hzN
 UxWmNpTKkk2chu1CU8xP8Q04f99zJBUBbwlasaVpLQXdUTXShOZ/exsLG0DyHPtOxlPh
 rXNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/wGsPseTFRA7b5GTVkU9w3o4xqRBkQBuSIHY63CuwlxYUYycbGuZzS5Cx8haA9/kdSu90MUNUKXE8@nongnu.org
X-Gm-Message-State: AOJu0Yy8LopJGPUQrJbv+ciYY0HPgx99RNLe3f7h91gAz4JSSXsEKBuZ
 ygTAXZEL98F184JrsouedTLa80PCqGSjdAQDOdxqVgHtfTpm8mLM0X3EsTziOHIpG6813/wsFll
 TmAp/uVahTUkIOnnSMHwpL3yWNVntSHVYJCZKfYaS1Ot98usIuh+VA/ULYQ==
X-Gm-Gg: ASbGncvZTjOqOoF4/1whUKs30IA2AgH2k2TB8Bha5vK8XQWXZh3MOk8sgCwAwzlks8V
 7xWFM02S0E8f1CgkxEKQLq8KJdLQk0XEWEmP5DbJ/Vj0pp8CZgCAR9oI3ZSkvXhZZkm7BGiGO5f
 jyVIRmIBxv+ca7lVMm2fOBA4Vvhzk2BjTnf653lvQGW4NDm8SmY5H2lMxoQqIqCHBq4mK6c6lZt
 LykGqZ3mQUYkMHorYkOdhkInEWzYNhsS9BQgZZD02ijuBMZSovyiWbaKL5luaEFmV2xIZ7EWCKb
 4Yl+0l2rWZQ1MH/uhbV/NxO5nyHtHh/u5/+Ju6AtqY2W+JEFUzRrNbHfDjLs3Q==
X-Received: by 2002:a05:6214:3d10:b0:710:e1bc:ae42 with SMTP id
 6a1803df08f44-710e1bcb2c6mr102602956d6.10.1756787021768; 
 Mon, 01 Sep 2025 21:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG50Sg4We0y5cfTI6Xdck4NAH7f+BOWmTIvcC/3aegAHOjr+MfZh5PRp2oN/ljjiu+qBRhGgw==
X-Received: by 2002:a05:6214:3d10:b0:710:e1bc:ae42 with SMTP id
 6a1803df08f44-710e1bcb2c6mr102602686d6.10.1756787021183; 
 Mon, 01 Sep 2025 21:23:41 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm17958390f8f.27.2025.09.01.21.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:23:40 -0700 (PDT)
Message-ID: <4f296987-64fd-46a4-8783-2536a01c2466@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:50:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/39] target/hexagon: Implement
 arch_{s,g}et_{thread,system}_reg()
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-11-brian.cain@oss.qualcomm.com>
 <017c01db9772$3f31b610$bd952230$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <017c01db9772$3f31b610$bd952230$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QN0VNhRQKLZ63neOCM9J9HypqX5y6un0
X-Proofpoint-ORIG-GUID: QN0VNhRQKLZ63neOCM9J9HypqX5y6un0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXy4kvq8ijUwEr
 4IL6scBHD497n+8MYmNOprR6iZ+FfRAU4xf1IG3PI8MYabgwNVd+BBD9G5eNL2C9xCf3d7d4A2j
 8zs/UO+pMGYiFacdKfH+IXklnQg/NKhy3HqVf5e69QX+JxeI3W3fFJ1pW7T8xC9oGK0/coOE6Jh
 zVbH7c/qUv/fmdYdCg1d+YISwgv8F7EeryhH8/AbN8ga2imR82SkIJLb97Cr7opfXptM2S5eJmO
 aKBpxVIRneLp/CLExxCG9QqYp8IsQ8Wob0i9Tvt2slROuO9hUCDU9NQGNT9psq/JTjq6XiBgiid
 LlNnYwUT/pChF8POFSdfSWS+Yvh2iYJXjVBjATafin9sBek81+zYLpZ9ocPWhkwVudorL3M/CbU
 xR9IWoi3
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b6714e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=NzjH97FNM7v7ZbvR8GsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/17/2025 2:24 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:28 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 10/39] target/hexagon: Implement
>> arch_{s,g}et_{thread,system}_reg()
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu_helper.h | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
>> index e8d89d8526..1cdf4f8dd0 100644
>> --- a/target/hexagon/cpu_helper.h
>> +++ b/target/hexagon/cpu_helper.h
>> @@ -26,20 +26,27 @@ static inline void
>> arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
>>                                          uint32_t val)  {
>>       g_assert(reg < TOTAL_PER_THREAD_REGS);
>> -    g_assert_not_reached();
>> +    env->gpr[reg] = val;
> Gotta be careful here.  Not all registers can be assigned directly.  Look at gen_write_ctrl_reg in genptr.c.
>
>>   }
>>
>>   static inline uint32_t arch_get_thread_reg(CPUHexagonState *env, uint32_t
>> reg)  {
>>       g_assert(reg < TOTAL_PER_THREAD_REGS);
>> -    g_assert_not_reached();
>> +    return env->gpr[reg];
> Ditto - look at gen_read_ctrl_reg in genptr.c
>
>>   }
>>
>> +#ifndef CONFIG_USER_ONLY
>>   static inline void arch_set_system_reg(CPUHexagonState *env, uint32_t
>> reg,
>>                                          uint32_t val)  {
>> -    g_assert_not_reached();
>> +    g_assert(reg < NUM_SREGS);
>> +    if (reg < HEX_SREG_GLB_START) {
>> +        env->t_sreg[reg] = val;
>> +    } else {
>> +        env->g_sreg[reg] = val;
>> +    }
> Be careful here too.  Look at gen_log_sreg_write.
>
>>   }
>> +#endif
>>
>>   uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg);
> Honestly, consider getting rid of these.  All the uses are a specific register number, so there's no benefit of things like g_assert(reg < TOTAL_PER_THREAD_REGS) or reg < HEX_SREG_GLB_START.  Also, keeping them runs the risk of not having all the proper checks inside.


I see your point.  We will take a look at this for v3.

>

