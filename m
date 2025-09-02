Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08AFCA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIa0-0004ZT-Ta; Tue, 02 Sep 2025 00:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIZp-0004Ed-84
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:25:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIZn-0001Bi-CL
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:25:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rnhj020757
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 572yDz5gdmSjF8J7pzmJkjSWBFoqtnZUo6EgbeAUMbs=; b=gjFDL5Sd6tWwIQ3r
 KZI0eUoknKvTY+jHhi+B5AmRU3EYNUUvZkT5+ruYsIHxoxkxSRTj+b87GYM5GrmY
 uiSkoH2ja4cg9tf9DVOwFa/zGxTlbV0TFYjC9va5eL5ST0Gg6P7dMDssEJdvKZIw
 KBasJ80LWUcIXrNV8mdN8j/RYPRbLFOtSiaOcpfLjeUbaDJ0q1ZTE0g3uJW9fQKj
 Kw1avoTpQP6zlbrKH0Z0ZWL2CAA0AW/1N3E7Gw9iKHuGeUzRwYF2oufD1Xqz//pW
 RLpBIy5c2W0sB6sozlkQxY4wZJWzurbRF5Srpg6bEipvH1EM6O7qLfPJmANm7UGK
 uBzhaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rxhhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:24:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b32a58c3f9so44548641cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787096; x=1757391896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=572yDz5gdmSjF8J7pzmJkjSWBFoqtnZUo6EgbeAUMbs=;
 b=GFk0A8Thk0YejyKqCZiwYSKM7SuBkB6Z6oxaMl+TNMJeomel/Gb70W990g2yvoxnhw
 6rwN736BeEpJOf+LCanaJFD7A9ZhB3vXBGy568oDRECcXoDFMfP7hMttVYDhiRGpJfIN
 YHd7QNZEzrlxFQ3ouLJuvfJJfVzqUtyoX5nnONDwPakSQuhIyrgwHqFmzI3E91fGH73k
 5TYuY18Qj2F7idFAqCYeN9Rz9rfrnCmiv2ONQIKR/QJbfbAjVeuuH1XixVJCuI6XXSS3
 X1g7Led1CynapKCEYbBm3W76wYSxsSDPBtNbuIuwIrDCFidnG/8Qk16iXf7U724BRBej
 MuNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZYb7JrhVs4hj1eW5x0xFQhgxNzfVJPaNKrfnsUGqkI41oqwSV5+TOjojVjWz2GLugMVH5RLgN2zx9@nongnu.org
X-Gm-Message-State: AOJu0YzZwH96JEugSMShKiN1+bPfegrQb5ecvoOA9hPUDi3n3I+k/bFG
 G6d4hwpi6d0ytQwzHcxj4KAzXl0EJTtFXWD8doolel13/WwkzU3hb+NWP9nQjQX6sm13Gm7IdoV
 9G2WqCmI8yAJqR32K4siVoIfyo3TczBaRsOuM3UPt4X4CSkLaSme7aF1eAA==
X-Gm-Gg: ASbGncvION1YRywNGofzkHpZRbjBc96c4dIWJOaEh6DzUDHbRgi8UqtISI5fQzT+/xh
 6HyBav7SvRIDIcKTZqTfztkOQ431Gc02Z+PlyPRspc3X6WqKj41lCFkiFhcSB5kcP63vMh8M6Us
 lf4eJd360uxTRbsUNfUb821+nYnfcsqdCGYwqqq6ctqJ25mjBeAU5mVsWi/HooVzRT6iYZlPg7c
 1sRchwqdmXXqtCxok80zXksQwvDjTquC4m4ni6SNXB6BWGwKw0W8YpkF0dsE3EHc/ZywJd5Tlrh
 cmRrCgUoohbHVh+M3B0ZWeM0H/cAhgFIyzo3GLQgu2TRX2NdmYrl3xfpIsqVdw==
X-Received: by 2002:a05:622a:1394:b0:4b2:8ac5:25a3 with SMTP id
 d75a77b69052e-4b31dcbcc9amr127247851cf.76.1756787096626; 
 Mon, 01 Sep 2025 21:24:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCVSWtndf5s+796GYlwewpF6F98Ep5dMdOX7UrbBZSdkK0GO6mHRhefF6zO6Ow6AQL3pm6OA==
X-Received: by 2002:a05:622a:1394:b0:4b2:8ac5:25a3 with SMTP id
 d75a77b69052e-4b31dcbcc9amr127247611cf.76.1756787096074; 
 Mon, 01 Sep 2025 21:24:56 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm17958390f8f.27.2025.09.01.21.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:24:55 -0700 (PDT)
Message-ID: <439dbebe-759f-444c-8e2b-8acd8b5ce5df@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 21:08:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/39] target/hexagon: Implement setprio, resched
To: ltaylorsimpson@gmail.com, 'Sid Manning' <sidneym@quicinc.com>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org,
 "'Matheus Bernardino (QUIC)'" <quic_mathbern@quicinc.com>, ale@rev.ng,
 anjo@rev.ng, "'Marco Liebel (QUIC)'" <quic_mliebel@quicinc.com>,
 alex.bennee@linaro.org, "'Mark Burton (QUIC)'" <quic_mburton@quicinc.com>,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-23-brian.cain@oss.qualcomm.com>
 <03a101db99d0$8c67c5e0$a53751a0$@gmail.com>
 <IA0PR02MB9486BDD73D3CBCD3468C367FBED82@IA0PR02MB9486.namprd02.prod.outlook.com>
 <03aa01db99e7$6f8a20a0$4e9e61e0$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <03aa01db99e7$6f8a20a0$4e9e61e0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXxWKsaoFSSgdN
 1Bb/HP6diUMGByMm1lwbMrc/4YcXDMOXW/GztZ7W1K3coJqXX6YPbjUDLonHeJy1qahnkXwddes
 Mx8VMojtTj05JNJ+OG0anO9QNHhxVyJIImxoFRrzqOu9JHAxttnSHb2YKxrHORNuK37VhD+ubb0
 8I0i0duDPUtCCmNlqfyAA8XiQ4kwOJBIZVJkRlWJww+gOKm6JLDozvyAfDiidq0PUOdf0E5yt/w
 c6poXJPuYJlVAtnI9rR5skzDBrK4FnDqeM/RxJmfXfnH3Nnk60JzhMJLZDPyCygtA9/7lMfwR/1
 Ho5aCVVQ8qWzmpHA2Ldq0SDcBt1s/sxNQDW8K6fhVdAcxqFMbiMmiGh7ofKvGhXysqHhG+AxMWK
 NJcjKL0M
X-Proofpoint-GUID: yVHe-HRGEMC4b_fhU2LisKNjlkuRj7ct
X-Proofpoint-ORIG-GUID: yVHe-HRGEMC4b_fhU2LisKNjlkuRj7ct
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b6719a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=cwRB2rIEbE6GN1lDXnkA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 3/20/2025 5:28 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Sid Manning <sidneym@quicinc.com>
>> Sent: Thursday, March 20, 2025 3:26 PM
>> To: ltaylorsimpson@gmail.com; 'Brian Cain'
>> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
>> Cc: richard.henderson@linaro.org; philmd@linaro.org; Matheus Bernardino
>> (QUIC) <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; Marco
>> Liebel (QUIC) <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; Mark
>> Burton (QUIC) <quic_mburton@quicinc.com>; Brian Cain
>> <bcain@quicinc.com>
>> Subject: RE: [PATCH 22/39] target/hexagon: Implement setprio, resched
>>>> +    if (lowest_th_prio > best_prio) {
>>>> +        qemu_log_mask(CPU_LOG_INT,
>>>> +                "%s: raising resched int %d, cur PC 0x" TARGET_FMT_lx "\n",
>>>> +                __func__, int_number, arch_get_thread_reg(env,
>>> HEX_REG_PC));
>>>> +        SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTWAIT_PRIO,
>>>> 0x1ff);
>>> What is the significance of 0x1ff?  The field is 10 bits, so this
>>> isn't setting all the bits.
>>> Should this be lowest_th_prio?
>> [Sid Manning]
>>
>> Hi Taylor,
>>
>> The value 0x1ff is correct but it does look like BESTWAIT_PRIO is not, it should
>> be 9 not 10 target/hexagon/reg_fields_def.h.inc
>>
>> It looks like it was added in "PATCH 19/38 target/hexagon: Define register
>> fields for system regs"
>> I will make a fixup to that patch and correct the value.
> I see.
> If the intent is to set all the bits in the field, then use ~0.
This didn't make it into v2 but it's a simple fix - will add it for v3.
> Taylor
>
>

