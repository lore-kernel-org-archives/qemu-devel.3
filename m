Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557FBCA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI4T-00038R-Lg; Mon, 01 Sep 2025 23:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI4L-0002sm-DG
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:52:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI4J-0005Dd-38
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:52:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S6px030135
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U23kYTVkFs5Mjawh84QDiZbkpQtrc9t6xEWngKe9Shc=; b=oNbHX/AHmf4TCL5Q
 JI6G4AHeEcNnmIH1SIIvshPccP+Q/unlAljKdf5Z7dzhPMbQEX7pAQbp22X1NGTf
 xH9I8BpbjPkooUvOUCZppJyuFLIPu1elcAffmM51Esr0jvsg2EYWvAMtu6YLGc8I
 UcdaqwEW1VZZ+seGsmyef66i2sysC8nL1Cn8iKLbS9TrV9GwWyTd5TjzsPbQX66Q
 zwJXns1hpEQFLW1vm/9TariCnfMkqD5pAJ8H571HhJlEgOpE9ByeYUjP/YXifCKh
 mhhvojocfKU9U/ScBhT3AtGxqnC23boHko6xEDE/bxksE8dS3H8/vG2Mbfhl5d8/
 oJjHcw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy2721-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:52:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4c73924056so2604844a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785145; x=1757389945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U23kYTVkFs5Mjawh84QDiZbkpQtrc9t6xEWngKe9Shc=;
 b=RUYXFAH+xIn8lNCQ2tFg6t4TCxdozEfSAiPE42fCcQ0wWhftKIuBTVgebPxRO3xzMQ
 DjqolHhj4J6tDRolOclR5w83BAEVoun2T4L14e/6ctWp3YRZW70w6Q3BaMWtMKfMrXid
 IIR0H2MOn+b5y8bIoNebIMvJ3roQK57yoz9BhNKYej2pcVFsJPSxH5CAh7YcAKkTyLr+
 yfPgcWBQlytd9kdJp4VFMvLQDSvB+wPtIggmQOePWqcR1NHCePtTkPyyeuVzEFszQG7j
 fjqbqcyntZNMt1RSDFj/VnH+4+TrG2hF3W+WxeqUM2kLllPuuHB1n0erIFEGEagYNJfw
 sxNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+BD24OEmZFc7oM5Jt8UtnHlPRayz2C9u8CtTIxFjxgCY2sqjIrYQxl8zOceQsZv6eiv9alZpXOsti@nongnu.org
X-Gm-Message-State: AOJu0Yy01D9mUHxsHXjb6tuBo4/+mmt2dpRtJ1Ka5hC0Eq+YczCSo9NR
 4YBpsbVP75TdaJpDFgTUwf3kFXf7cXYQdzg3M8JTr6Uq/NmT4fw6Ltz8qtPOTKIZXUElY0D54Gr
 SL7JKgNhMMbCDFBDEnL8HnPr5DJKua/P8TIYiWOZT3CkHmKRXLFcR3KtoSA==
X-Gm-Gg: ASbGnculF0fa8jJGeEkL81y4ptdQsVUSF5Lu0W7e72t8NdvlOcmXg9l7+pAmiuY0AHd
 FCeVjqlXv4NpyfagEHjH1mwIeGoHwQ9Vit62VDawK6lwrnVOAAfNNFP7LlLBKtCWLsrfJPa1r7X
 WEGEiBF6/mNE7XY4MPqOKouFDO7xpaBtjb2+SbYIcD/D64OTtxQRiK1WItnWloKpwhTz0l41B5n
 /9uKsYoLg4EiuK+6rl4pcT4IQdmmhkHZPucV77L9LmaWdag1+VLaILtSVPoDQSQpzeJt236z0FJ
 IBppIaQAnjoUL0Nq6+eHwg3KyqHzWM8b9TsJU73HfCWn0EjDHt4OCiokea/Cxg==
X-Received: by 2002:a17:902:f60a:b0:234:f4da:7eeb with SMTP id
 d9443c01a7336-249448709abmr133688895ad.7.1756785144900; 
 Mon, 01 Sep 2025 20:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFQyLWs5K83A0aIw5SPBvwuiZHROKUEv9MvcSb6vt2oowC/WWVzhvwtKFZiyB9JKz2b0u8pw==
X-Received: by 2002:a17:902:f60a:b0:234:f4da:7eeb with SMTP id
 d9443c01a7336-249448709abmr133688605ad.7.1756785144406; 
 Mon, 01 Sep 2025 20:52:24 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm119295495ad.45.2025.09.01.20.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 20:52:24 -0700 (PDT)
Message-ID: <8d73af2f-24d0-4a7a-9e28-7210a83d5d5c@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 19:28:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/38] target/hexagon: Add TCG values for sreg, greg
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-11-brian.cain@oss.qualcomm.com>
 <023e01db8ee0$1cdcc310$56964930$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <023e01db8ee0$1cdcc310$56964930$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b669fa cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=-0I2jZQW5GywFGCs9KsA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JFHK-Ua34Mu2wQdzojzN5ixA3C7w65kM
X-Proofpoint-ORIG-GUID: JFHK-Ua34Mu2wQdzojzN5ixA3C7w65kM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX7Yjsw+l7jD3W
 U6OGvziLSZiRvAFmyyGb2JaSYdizQWriKnc+ED8Tf/2en6Xk3ahWkItFjEIJvAiWeyC0LIdtkdQ
 spzq3F1jcqCetQ/wlSfiWADAX3U+Shz2T7QEmhZEvGmy9nqJrBINZZm0S7kvfZdCtKtSBs+TGsV
 PxkNAjoiWZGNwWMc1UqyKJt7OCcKs6jYadxelHEvFIXyM77/LQKokgt4ihSSI3uYsDDDhbb4Bm9
 FskMp/m8bqpxaXjMrL8LEn4zfbPAq0MLE6o+FFxt24lhlEM0TX8OtOU2nddg/1zuDLhZ9wqWHBb
 VutxcoJ/HmtLIk2q0eNn4bOKW2FHrVVerRNLuqcSHjgEQ5kJ0IL6U12j5RpOe6ZLXu0XTpas0OK
 848bWjca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 3/6/2025 3:38 PM, ltaylorsimpson@gmail.com wrote:
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
>> Subject: [PATCH 10/38] target/hexagon: Add TCG values for sreg, greg
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c index
>> 2e9a934fc6..71c137be30 100644
>> --- a/target/hexagon/translate.c
>> +++ b/target/hexagon/translate.c
>> @@ -61,6 +61,13 @@ TCGv hex_vstore_addr[VSTORES_MAX];  TCGv
>> hex_vstore_size[VSTORES_MAX];  TCGv
>> hex_vstore_pending[VSTORES_MAX];
>>
>> +#ifndef CONFIG_USER_ONLY
>> +TCGv hex_greg[NUM_GREGS];
>> +TCGv hex_t_sreg[NUM_SREGS];
>> +TCGv_ptr hex_g_sreg_ptr;
>> +TCGv hex_g_sreg[NUM_SREGS];
>> +#endif
>> +
>>   static const char * const hexagon_prednames[] = {
>>     "p0", "p1", "p2", "p3"
>>   };
> Is there code in a later patch to do the tcg_global_mem_new for all of these?  Go ahead and combine that patch with this one.


This was not addressed in the v2 patch series, so I will look at it for v3.


