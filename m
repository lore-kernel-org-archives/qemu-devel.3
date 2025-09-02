Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F22ECA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIan-0007Uc-3t; Tue, 02 Sep 2025 00:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIal-0007UO-Iw
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:25:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIaj-0001SE-Qu
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:25:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RlZO029772
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yI+CBiLGCDPDnL8zvmKucsqmRS5PWbEdaT8IUg+dwn0=; b=DBFs/IK65m/3j1IG
 o74ehacVlo20cnAjISnpeLQTu4rtejltnMUIG1M+1WdZhp4sSnOIqwUB7UW0raoQ
 Py34S9j2NeICPc7Mo40mmwsu6UytfhkQ5cAfgT5EDzgdptbapsUaWNroZsZNh90c
 iLNETiB3pc3Yj2R+c3kduT87Q8QNQ3mConJsL/fYGmNYpszlMaOmI/Ogv8XYIRo5
 5BRBLdpIouyCRkFN3CSFbsZVMgR3tvTtLECWSc1EDWs1fcYLc8JL1QoeV3t4Rxeo
 LhWdvHxDo/ylmAea0lzlEjwiYkaqmS8ItBKUOXa1iH4LwlPjGbmtVL08z/yQpo0L
 AVSeJg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xd2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:25:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b3415ddb6aso12938071cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787155; x=1757391955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yI+CBiLGCDPDnL8zvmKucsqmRS5PWbEdaT8IUg+dwn0=;
 b=MtKe999d32DPCtIZZfvdJD2+z2In5de2x/5GA8DV1fa2hg7zVNW7GueYn5ifn0/Luz
 cbIHK3rasq4uj6avQ46Ua8zD8qvAGYVdALTkW93oA6dMzoNlUj8WMErYNXG/VvT3YBeR
 w3GgQJz+GbTNJ+teTzpmiwqipF5QWnuR9QgZz45nrAjH0Yy3hOwb7OT5+gM4Is3cS/2o
 2NvLW/xWj6yWDJGse8cJJjTWOcFzd1I8FsgJtDvni7tUhbS8LnODRyMgeDamdP4pefQD
 IQJNwUkkia8SysXtfjJTp5cx0rJurEYbH0a8tb0uTO8QtJd9T3KFpBpyzTGthaaIRQaB
 oTBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp4k51zmJ5HLFxAgtS8pcpibU2sbpcWHTO1fME2SHSwV0hG2k1KeaENdxR0AjhXZzf4OT/Mn0Ejrl/@nongnu.org
X-Gm-Message-State: AOJu0Yx7RuFujRkRukLyoYBI++tuFsGmUsyH0vNmkRP1xUbVNOuKojW/
 Fx44SHvsyYKGhV4Nc833X4qzfp6rkPeMOp+h75H76JYaRRt47FXMYGV+F+u8bATcyjdwVhORtNH
 FgGMIuSrDwWK7xNMW4HREtri+jnZvM/iY6Tgs5hi5cFgGjlYZeGQqA5Jmbg==
X-Gm-Gg: ASbGncsKctZCAan4Luust3MvrOgK+qNmBXDpKS4qJABCsunEXVmm8PRO1ryAJJmFw57
 DiEI/jCpRkPNjSQc/XVQNMMTSS4N9O0ZV836auDXV76B9ZVAeYmNToED78oMM3Dqw+sRpfiKWNU
 vEgwMGftCtneWfFcrF6edHVfTlj9kokSm6Az+d21jBgsCMqTQk/N0NjSluttA5yBrBOdRD5sQc9
 O1WH6uKTEbMd0V65B/ELvrsXG7jwYkwVGCeU3eBeuoHNTYdqQ8Sa2hpeGu/oCQDw+05pcCdGEHD
 SNa0CL/l/pwlYs3tVV5YwvQCoQTf4G5+L4das8h2+vTPxI9dkgIBPbaggVqQmg==
X-Received: by 2002:ac8:5903:0:b0:4b0:6a6c:c8cf with SMTP id
 d75a77b69052e-4b31b88d01dmr116881601cf.15.1756787154950; 
 Mon, 01 Sep 2025 21:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK0ZoMQYOeyMAMyHoI1Uvt/JBl7K4TkvHe+JBEm4WsxrIRjwyz3TqZWhX0YhPjU0/zxi3jmw==
X-Received: by 2002:ac8:5903:0:b0:4b0:6a6c:c8cf with SMTP id
 d75a77b69052e-4b31b88d01dmr116881411cf.15.1756787154311; 
 Mon, 01 Sep 2025 21:25:54 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b88007a60sm65955265e9.8.2025.09.01.21.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:25:53 -0700 (PDT)
Message-ID: <69aa8dfc-b2bc-471f-b451-c86ad32e28c4@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 21:40:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 38/39] target/hexagon: Add guest reg reading functionality
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-39-brian.cain@oss.qualcomm.com>
 <02cb01db98fd$e067d2d0$a1377870$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <02cb01db98fd$e067d2d0$a1377870$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXxR4MbXqJwRio
 g0rrv5w1fQdDB7ELxzTIbFQTk/dUBD26n4JhXssrJWHP7th318g7mmXDQUvF7vZFAMYob2SSY8m
 Amg/PW0ruDsRa3uaZbJX9rDRQ+V7KhT7zmfUEY1cW6p+U14TOdz2xdt+QsxC7Tt43uvmV6l62So
 ljhcaVKYRLpFUJmvmDChgQp9IXpNOgbbA/UrNJI5ekKuoxHdSrvhMRLKs6exrE2jPqVHTjai/L+
 HICemnwGxIVYOdPwYMEz5gDDtTZG4+vmQmAFzZXNnnX7gMGrcaDdhDoDuUeiLHlcWCt6SUPkpX0
 A2ABQPwyzzS8XVlbWwKLAQp6eKfu9ttAha6OciO87qaSFq3CFNHPymJ/t3SRQ2qHNbLKhTyIOTZ
 JERBzsBS
X-Proofpoint-ORIG-GUID: NzimyDYB5NEHfrw_drpcGlS4DT2lm03E
X-Proofpoint-GUID: NzimyDYB5NEHfrw_drpcGlS4DT2lm03E
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b671d4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=nSbkxruZzk8VLyp4TkcA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032
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


On 3/19/2025 1:36 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:29 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com
>> Subject: [PATCH 38/39] target/hexagon: Add guest reg reading functionality
>>
>> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>>
>> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>> ---
>>   target/hexagon/cpu.c       | 19 ++++++++++++++++++-
>>   target/hexagon/op_helper.c | 19 +++++++++++++++++--
>>   2 files changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
>> 3c4776232e..80f5e23794 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -739,7 +739,24 @@ static void hexagon_cpu_class_init(ObjectClass *c,
>> void *data)  #ifndef CONFIG_USER_ONLY  uint32_t
>> hexagon_greg_read(CPUHexagonState *env, uint32_t reg)  {
>> -    g_assert_not_reached();
>> +    target_ulong ssr = arch_get_system_reg(env, HEX_SREG_SSR);
>> +    int ssr_ce = GET_SSR_FIELD(SSR_CE, ssr);
> Consider moving this check into hexagon_get_sys_pcycle_count*
Ok, will fix this in v3.
> Otherwise
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>
>

