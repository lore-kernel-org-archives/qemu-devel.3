Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743CFCA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI5i-00070U-Oq; Mon, 01 Sep 2025 23:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI5W-0006qm-Vp
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:53:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI5S-0005Jj-Bb
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:53:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S42g013475
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sMPd4Ui1SSyFuOnaeujcwjy3UEIw0mtJ8/k3RlNxOfc=; b=eY/6V0tlpMyLBmJf
 bCGudy9u7K78VHdkzG0BGaEJ7kNHTFT+jgSxbKXJuaF0VaAwOa18HyiE02oXu3va
 MdGiJf+TXQWLYyr7S/sEMwBer+WNZ63YrITI1FWDP7gDpdSjaLaK62igldiza3oL
 DOfuxa4sURsLbHnu9/+r5dbqAYDp2ZUsMlwaOT8h3dQLZrhQCDgDqgU9ZrKV3Kfs
 8ZAbkhuBaLLszDtIW5i34/tWyNJdSFLCI9Ll5WeDkKUDkv0wrMTfc4LOoo7xolbl
 sj/YF053uQVPD5ENzhDfNsVAPF76bDYaTNu1OugST6nZxWom6scNsM1MDibfa2oD
 /KidEA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eejjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:53:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-248942647c5so65831515ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785215; x=1757390015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sMPd4Ui1SSyFuOnaeujcwjy3UEIw0mtJ8/k3RlNxOfc=;
 b=p3yK4x8uUYTNs8ZC3uzE8fVkmTLIIpx1zmcDTcOJ13JdpHLqPOROZeAcp15OeKurF8
 q3Krv5A3+3Q70iICwjHekbcXjFm18BUuBjorF3h0S+CAVLsMguxo7jP/Og/vsEOzXpnf
 m1++gYiKKcdgCMHCqMiAgBYd46B+cMAWkQNVE6ILBGcHjhtzHUAFCYOAiO5bSm5Ow7PM
 JamuVLKBI0CqI6sBPVY3CeSR7oi7QZWULioakEzCbsHCyEML8k69hnE0AHzl5xq1Pd6V
 0T/eNhCTL4c7LP2/t2++rT7nnz4yJfQVsHvat3VqKyQkamwRZm7L6Ll9ByqYV3hmo2rn
 k/OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrRanOVB0MR2vxXQY0qz+o7lpGHdXZxPqfwHtTA9xHUUQE1xmLdn1I9ZuDviQ64z8BuqJGAnGaKnxY@nongnu.org
X-Gm-Message-State: AOJu0YzOcf2pQ7wvgUtiAvPlIlYggfjb+4IYEfbzprVRrBNiO11I65Gr
 QkYVy1G791H5Oqo80WDNpuS41lIFO+1t72CJDuZqgzSWzfV9EY/eQJO5ha1krGvdxQZF5maU6e1
 vjxkC8gLVJhwOkl+aV/45F8B6rc/fX+g6LZfz2YnKwtDwcCGR4BkbXjQV5Q==
X-Gm-Gg: ASbGnctbwhUVs7+gzGQlYE0M3LQcLNiPupd+G2ZrhS2l+2lWi3GmyD6sxRayPR9EMrG
 p9FGEaJ0D9VclwoqvI9AQi9ETJ3o+ifBWeTAQANktEaNOJUJCwibTjkBqIqsKUHABMq+ibl72rG
 lLhO600s/SlWRgPBoP6+Vk3dxlGylrst8d0WkclHuYaYVIKat0iiTlWujPzXde2QQgFnYYKaCSH
 GLRdFBfjLF3GwGsO6EJqUSNCZzkd/W+h+8bD+WKdqKhLD5R3sLqn9vWiNF5vBCN8TnPubzscSha
 zXPh6xgrvedqAiex0MkMMmhw4zAm9oO3kDayituKgeKvQfIQOkfVEUjMzzOqZA==
X-Received: by 2002:a17:903:2287:b0:246:b5a3:134 with SMTP id
 d9443c01a7336-2493ef5007amr134341085ad.14.1756785214769; 
 Mon, 01 Sep 2025 20:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn9LNae1NAMGpQ7fK9kys8z+100JdHCw/ImyAMjS8W0XSgKJd3dUOUCwCNi/kmEDh7yxlgOQ==
X-Received: by 2002:a17:903:2287:b0:246:b5a3:134 with SMTP id
 d9443c01a7336-2493ef5007amr134340855ad.14.1756785214282; 
 Mon, 01 Sep 2025 20:53:34 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119295495ad.45.2025.09.01.20.53.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:53:34 -0700 (PDT)
Message-ID: <ae18e71a-4ead-4867-8ad0-02c3b0048d6d@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:41:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/38] target/hexagon: Implement do_raise_exception()
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-21-brian.cain@oss.qualcomm.com>
 <02ab01db8fa7$efe738e0$cfb5aaa0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <02ab01db8fa7$efe738e0$cfb5aaa0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Wb1hPQx_d36zfPv9onhexhDoM7FPwEhW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX6V+yV+/zkOL7
 8FZU6HsyRGjvyCEYG2LD93lCWYzuCB01+trzyRfLxcdsdB+SnqrVffgF13+r61bDBCESRNdXSOx
 ARUlaCPgzJWYCtu7WV+db9uXFOdTGjSkvGligdR0wAZH80JsOUvV9DemilENu1/8/ATRsBxTpWb
 eHUUpc9+u2zWGqvHPVfJW1HdAUbzuyw5+isoAu5GmW200R/tTPMisJqv/Lqj64o1h7loxsJfZNI
 6sy46h7gEum1feMOY3xvl0AAx8330Nl+aTd6BoumnXsnaRLBr2woIkK5vBlgXvco4C+6dikoEti
 h7CZRwHU94BUblD1E0KtvXUrwTOSDU9oxlf2lpi0JZekGLTPzvE98X8UDqcer1X7qBa+dhuJkq0
 wgVUcvev
X-Proofpoint-ORIG-GUID: Wb1hPQx_d36zfPv9onhexhDoM7FPwEhW
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b66a3f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=lWwt_1FQ3N104IbS1ZAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 3/7/2025 3:28 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 20/38] target/hexagon: Implement do_raise_exception()
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c index
>> ccd806836c..1aa5b32b1f 100644
>> --- a/target/hexagon/op_helper.c
>> +++ b/target/hexagon/op_helper.c
>> @@ -37,6 +37,26 @@
>>   #define SF_MANTBITS    23
>>
>>   /* Exceptions processing helpers */
>> +G_NORETURN
>> +void do_raise_exception(CPUHexagonState *env, uint32_t exception,
>> +                        target_ulong PC, uintptr_t retaddr) {
>> +    CPUState *cs = env_cpu(env);
>> +#ifdef CONFIG_USER_ONLY
>> +    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08x\n", __func__, exception);
>> +#else
>> +    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08x, @ %08" PRIx32 "\n",
>> +                  __func__, exception, PC);
>> +
>> +    ASSERT_DIRECT_TO_GUEST_UNSET(env, exception); #endif
>> +
>> +    env->gpr[HEX_REG_PC] = PC;
>> +    cs->exception_index = exception;
>> +    cpu_loop_exit_restore(cs, retaddr);
>> +    cs->halted = false;
> Shouldn't cs->halted be set before cpu_loop_exit_restore?


If anywhere - yes.  Instead, that's dead code and was removed for v2.  
Thanks for catching it.


>
>> +}

