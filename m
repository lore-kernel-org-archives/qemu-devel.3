Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C31CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWx2-00080r-2o; Tue, 29 Sep 2026 08:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWx0-00080i-A5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:28:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWwy-0004Zq-U8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:28:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCE6E2528969
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aSV6+7Tr/Dz/k+Q7k7+U1Y6ihV6WAYlQdMzeoOtkADg=; b=IigMzh/TEX7RNmFK
 1Qg5FYheNvEf0aAvuEi/CK+Ap3G6lIBDVWFajA3dVkyQov2LHr8Lq2lLjIPTa/P2
 8NlJaMsm2aj3zzEEqx4om/fP1rtS/8IjSlyBi9gPAqzzQpUmYinCFqL8hjWzXx7o
 2pQC/tMm2+KBQ92dbLYxrnuBhrRaLAyT5lcUJhB5sdM2SOhl7h0YxPknTQWntDu/
 UwSsjKW6yUG2fJ6SWmQS/5aT2USFP3K2wqWMQLZYT9wXMsk27I6N8kC8QLOwAmSh
 eebwUHaF1RqtItkBGr2Ko/eQlvUICN+8yZr569hNhgZgWZrBV2x5ULwLOXXtBSXW
 2dIfNA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew2dm3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:28:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93bfb2da664so1182805585a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684924; x=1791289724; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aSV6+7Tr/Dz/k+Q7k7+U1Y6ihV6WAYlQdMzeoOtkADg=;
 b=fiE3v9BQWJxou8Ea638yCtqYoA56Jy9HljUyW2BPqkes70I4quOSN94wltLXqF/Mt8
 4p0i+ShU0CaupW4xlZfvfe/nZuMMubgebvQ/RAp24n6WN42S31fhLEE1WUCdP3lwonOm
 UWrUksGbtYopPBXA7pIgP6YvqaRNmUczeHiyTE9rpSzXMZ5MsJd/y187ossT947KRA8f
 UG6LHZNKsvGw9+Fyieu8SofkDDOnj8QXt4Ohy7/MtUlDzaw4OgKC1Goq9VsPkq4glABH
 3K8HMJAgmP7dSTE+T/nvKU5FWy+nuhmP5ESW6beG+rXvj8WE56ErJlxH/mkhIbFn8n4c
 ning==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684924; x=1791289724;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aSV6+7Tr/Dz/k+Q7k7+U1Y6ihV6WAYlQdMzeoOtkADg=;
 b=pOcsIGAY6XAt2A6xy6qixeimAevVhUgPD05xLEQY3+VoigoNu9Tms1bEgutT1NxIzQ
 8aaxx1Ynkn2++YVlO37mGj4dgfrAVCGGEvWmYKSZjm/tlg+8Q78jztpBYSSQwCa/Sub1
 5sPm0/10TstSWPZQSsmFrSdYKn/v68KtmcZ87F/c5b7VgjeMNgnOj4NheR9A7Nk4Bi6Z
 pydfSVCE/dWWhr2X3Ke+Cec8Furkj6ED5nA5N3eAIoxjOM8pQl+iWjzY8XKWhVFIb3wS
 TdgzRtIDYgHCuCtCBH0BevhMDQmnM0PyuS6yB/aJMsbQq2sswGuZxADickCk56JxExQN
 iNSA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAorAI+L5L656sN9LKkAkDXQLHMZ01/JloZFNpzedjXgyRkl3lYXc+iJfP4hikbaUR47Ai4QcuEFbg@nongnu.org
X-Gm-Message-State: AFuF++k5CNgT2gT7apkPPL4BXxh5W/9EJxchaOgRcqd5VqPdH8fUntjU
 rQDhAZIAwkHnaghe4wX0BW3bekbM/8sde0oLe0OSaWkRtYu/4bAgSm5dnm0g/hsZ0ETT5/vuVcV
 JUf0LXn89lUySuBiXYtcD+SIcFJSBiLnyI1qrtY9OdrDaw6t3TsShOokLxA==
X-Gm-Gg: AYBFou3yI58qmk6Zl2paAhKA2sHDWnZmSL9aA4jIEiEC3Q/2zq/utUGD6upP42Aa1ag
 zVVVlsKMTKfAlVuE+EsZaamPiOXSIGVdRn8kpKsGBQAFsbqaHkYZSE3nKbkn0X5me2sCfof98Gt
 2ao8TPuPJMd1FgWWeanOVrPitI3O84xiTLypacTrGPRZwFZliuxLqqqSQcDrgbY4LrlHFFmS2e0
 0+Xdno3SXDhVtJ/dXdwwhAxgjXDO/bMAr9IyzWVLEv9JcKuYjJAbo3JQdhMAmBrDdRtXGHrahs5
 buWCkydbdvWzZl/a1wWpb2ugaCM1uS2yMG04ItOJChughOK/iF4bRFf6hpFqo/cBmHHbaCKDvhr
 N0LzCE4mvi8JBqLDb6hZaTijyoh33P8DO9w==
X-Received: by 2002:a05:620a:1789:b0:93b:d7a1:ba0e with SMTP id
 af79cd13be357-93c47554f65mr2564455885a.57.1790684924585; 
 Tue, 29 Sep 2026 05:28:44 -0700 (PDT)
X-Received: by 2002:a05:620a:1789:b0:93b:d7a1:ba0e with SMTP id
 af79cd13be357-93c47554f65mr2564452585a.57.1790684924220; 
 Tue, 29 Sep 2026 05:28:44 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af507f33fsm3730123f8f.24.2026.09.29.05.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:28:43 -0700 (PDT)
Message-ID: <fbbebff1-09a6-4223-98d0-49961b3d1541@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/19] tests/tcg/mips/include/wrappers_mips64r6.h: use
 proper types for parameters
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929074007.118970-14-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929074007.118970-14-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX41ha6iTMgT1h
 XBlTUmFguenSfGfZobezyaEvoJ7y5K2bXYb5Or+aACDJ0rtWnzoS92wnhdTA5Y4XayStRnZZuSn
 c5nWufPxaXZyXmC9qnlmA/0BfKy3Gm0=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abbaefd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX2qsg+ZeCgogO
 Q8dWX5uygZenUR/jIg6zxjd7UMv0OWe7rWVhMlpGpeNHP/PX7u2YoyxAETOCwpR5hp1FNQoQvji
 ixkDBENsSXLPMKZWMi1fgxon4nPpjuzQOfpE3alXPVJx9O4oowBRzGA8Z4DmnUOEQE5TKXKmR43
 7k5g0vzgtUlZ5Kt99a4BSQJyNGYUyAHVjyQBTUZb4aoys8OqfJNfEJGdt3NeKY63IfguQwP22rG
 v0e1EBGo0FzovX8/2idVjiIEmY3JR+zd8B+GrXw7VnHo0ynXUvSMsoNqHdEFmqyW7yIpMaIwazr
 laCRKWu8jPg48Ttmrfrks/+vTIQ0qUbjIto7N2ioeZ2Ee0TO2klA0tuCrGGBLrG/JL9cIk9SJ3V
 qHFuwl0EdRithvQVh/ZS/HvWwfTpyt/+0t5wQd1dzZTQc3esl4gDUgKRJAnEqfRJ+27pZ3VbPlq
 jVC3DLW/sKeOyyshaMA==
X-Proofpoint-GUID: EBOsZ51yKhruFJW1-lvgC9xDRSm8dr1S
X-Proofpoint-ORIG-GUID: EBOsZ51yKhruFJW1-lvgC9xDRSm8dr1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290049
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

On 29/9/26 09:40, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/mips/include/wrappers_mips64r6.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

