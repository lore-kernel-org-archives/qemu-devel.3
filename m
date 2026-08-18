Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B4BC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPqE-0006Hk-4m; Tue, 18 Aug 2026 15:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwPq5-0006CU-KV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:51:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwPq3-0004nT-8h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:51:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJZNB11847352
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A0xiVNNXIZFuEacXqHhPmD6wJZlaH+xB3ThI+6K6TOM=; b=CCpNGVE0zZ8+j2Me
 qws5dkzvAZ/a71sewLtW+13oWFZ19g2q8CIIJ2jJauj/Lc/M1rPOvAGYGBsBLWCu
 r4eiEDopmUj+3UlU5ruabaYGBpvOhZirKE3HjpcgbJ8R6fhMhiK+avt2Gmwhh4/A
 agPXpeoE8u0IrkYea0pnXv2PHE2ZPdjdEqXvkZaWZgIenM1in2OFAysVMn2+SvbW
 S87AND/vUJ+2iEYyD1XPIMU2CSnUOpdFvbii12psy8OaRh/q2yCblEgcmrX6Dkrk
 Ml23s9f578rvRsYsRl2mfxDmDwI8V9A5gXGtBLD2pOijGwmqdd0ABd5Q5ai2yMzG
 ONTdPQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uj1gsh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:51:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52d827597fbso2874771cf.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787082669; x=1787687469; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A0xiVNNXIZFuEacXqHhPmD6wJZlaH+xB3ThI+6K6TOM=;
 b=Mr7UehllqvS3LuXdOutFrf9ctnDsZtt124BVpyoytp95OteM19LNUdsMyqGhVBRmJP
 Akn/hn/EWjMqW4I6aqJozs0kENnCMMjK3rlQT1JcqrLZWHW+nd9eJEG7Hn8L6uk0QzBz
 HCHZNXZxsTEObcACuKe9Psat/FOxKnEn4tuSWgFF8sMHzCO6poC0LWYOyBfYckdi7WHL
 Y6h3AltYfsQLINB8GJT/4cd1LCleOFz2g1JFJdelSpJoNR6K06/r39IynJGrZL/XbmdW
 N87OlGPjE8j8we3gO4N3AhqAYdWL+wWT1HZqDW2YeIbyGEmdnEm0pUNUXFnjD8mLb8Z2
 gOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787082669; x=1787687469;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A0xiVNNXIZFuEacXqHhPmD6wJZlaH+xB3ThI+6K6TOM=;
 b=tSAZ1bTttl5s7wqMHBnruJtSW3YgZw/PPc5OdsRHLdC6BL+A2eR1WG+shGrK89vUmd
 5JoJjbU1eQM/hfpS84hkZCSAquen6sr5D+d2fRZlwjEoRQQsvchAMuruB185GvEblUIa
 PbQlkAvZ18fL7kN2eAvES7/lfC5NfKVklmnAmker7FdEKbLJkvd8Mya2GNy11whDBkGP
 ZHHx0rj5NbsIkYvDeY3NQ6b1wjS+OWnCheKgi1tzQndkdLnk24mkR/BrDzn2mTdCB9U7
 nrf20WmUJ1/cpg2VlwfF+iwwnealLdBeyecw0HQj37nKQ1+vqCO5MPKVsPjM2t2+g2m1
 baig==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW5erFWw6qeTfLdK5S/HUm7+1yRQ0KC4nfsm+SqYD+xGqs1mhhxdkMg1E6xQj5VaWZoeSxSD9ieBcj@nongnu.org
X-Gm-Message-State: AOJu0YzstR0gRoPJ4PonmI8bib+YXnBQOv53/QQpPydPy+YLLpIJgJeM
 I5nspGi8sE4KZsOQROl1+cxewEPOiMkzyTFINIojR4g6vY046b9lHJUh0gQvLlV6LmtFU3KrXfK
 VlYZtvT+oQ2z0mpcaPIdinQh8q0Ixhd6WtvzctfoSD6dlHazvzzzEHXZr/w==
X-Gm-Gg: AR+sD10Zd20aEXR1+heH/e4CT1nc7JebgfaX6FLDKInZh0AAZ4ceBE5xTe341yCKSXj
 LWs5IA3f4uAb9t+l1Td6u6ihyfu04C/PVrFf4HZWzcA1ioy1IArOjjPpGMQgbOus9z1QWMivEv5
 HObKC9vyFBjQ34e+jy2E3Pxag+RCtY5KKIlf5QEG7GRt8CDbPM8R7ulWXLQCOF2BfBaeO3xJeS5
 gDlTRcp/A2OrT3+7vhIFZQZuPEAiz/NG8PY2S3kicIlR3JnYhps6PO6ctZMEJBfOMbZfuRzFbc7
 7EMselEcwkBmXShgDnoRUxDJM1gW6nzA6yRxTHEhM0aS+qjuGJ5UaQrRl6uB/4uYAEzDkfO53Ik
 Xk4Ckyvby+9qjWESpp1mTsj26G94Clm/5M2NiCEWwmCpXL8x4R5yrjVuMiIxIzGIV
X-Received: by 2002:a05:622a:550a:b0:528:3157:7a8e with SMTP id
 d75a77b69052e-52dd308efdemr6711251cf.9.1787082669224; 
 Tue, 18 Aug 2026 12:51:09 -0700 (PDT)
X-Received: by 2002:a05:622a:550a:b0:528:3157:7a8e with SMTP id
 d75a77b69052e-52dd308efdemr6710601cf.9.1787082668627; 
 Tue, 18 Aug 2026 12:51:08 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db625afc2sm47015981cf.26.2026.08.18.12.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 12:51:07 -0700 (PDT)
Message-ID: <5a6e6e71-7c0e-4cdf-a578-efebcd1e1430@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:51:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] target/hexagon: Add sreg_{read,write} helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, philmd@mailo.org,
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
 <20260611052857.3911981-29-brian.cain@oss.qualcomm.com>
 <96255543-c899-48a7-882f-a436c3df7367@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <96255543-c899-48a7-882f-a436c3df7367@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GGdBc10l7GOhzm_xiNIwN6I53_u5fw_0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0NSBTYWx0ZWRfX+aoMpcneZQ/2
 gCakC+s2To/gvx4qBOC/O0b3CWwlRFi1u0KAEjRlA8KmZITUwaRDSo0trn2T6TGZ5yZq6zMd5qU
 3Z/uGyVD9Sn2IHxT6it/UhIYsnkZeus=
X-Proofpoint-ORIG-GUID: GGdBc10l7GOhzm_xiNIwN6I53_u5fw_0
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=6a84b7ad cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Pia8b_79TwnpVCiaBDIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0NSBTYWx0ZWRfXw3Cp64LV9FPx
 0ypU/bLlCfiS8Am8zZHZi5GSzGWTFq9fk7b41fTW1K/SLq6zgoYeDF0JeekAq29GU/mt7aCpre1
 8IF8NElY56452mYME0JpbajqNTMdYfD+PQO1Z2I8+4SwgW5jEdy1UFJOrz/gaKidElVZGhoZfQK
 nTQTMN0Z/H91meXm7vdbflAjRWPgDSea4C4EqDZIHTmfQKZ5EYoRIhUxXKl8kcz+xqtQuW1naE0
 Fc96V9zpGFHlLHFA62gmQ+s56qr7td88oGiDyj0U9OEtqM8x9dsbjkexamemKgeD/FP2S3aFjz8
 VH5a4JHQ3kqswKbpg3qT5hxX9IkuGXBIDsX8u9icU3zJ5RMTHM4ya8/0sBEzWOsXTDoZDutfyMp
 qPLV5GOOeTH73Zb78vKJ3eOAjsdkmHZ9m3zNkBxUIBKclou8eQGqXP1chMbWyLNpiHuloapvOBH
 LgSGEp2bi6KqH/hL5nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


On 8/14/2026 12:33 PM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> (merged as 9b63a54dd2c0ea9a667c9e9dc662755b9feffa7e)
>
> On 11/6/26 07:28, Brian Cain wrote:
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.c        |   1 -
>>   target/hexagon/cpu_helper.c | 354 ++++++++++++++++++++++++++++++++++++
>>   target/hexagon/op_helper.c  |  33 +++-
>>   3 files changed, 384 insertions(+), 4 deletions(-)
>>   create mode 100644 target/hexagon/cpu_helper.c
>
>
>> +static void hexagon_resume_thread(CPUHexagonState *env)
>> +{
>> +    CPUState *cs = env_cpu(env);
>> +    clear_wait_mode(env);
>> +    /*
>> +     * The wait instruction keeps the PC pointing to itself
>> +     * so that it has an opportunity to check for interrupts.
>> +     *
>> +     * When we come out of wait mode, adjust the PC to the
>> +     * next executable instruction.
>> +     */
>> +    env->gpr[HEX_REG_PC] = env->wait_next_pc;
>> +    cs = env_cpu(env);
>> +    ASSERT_DIRECT_TO_GUEST_UNSET(env, cs->exception_index);
>> +    cs->halted = false;
>> +    cs->exception_index = HEX_EVENT_NONE;
>> +    qemu_cpu_kick(cs);
>
> Why not call cpu_resume()?
>
> If you don't mind I'll send a patch to clean that up.

Sure - that seems reasonable.

Thanks!


>
>> +}
>

