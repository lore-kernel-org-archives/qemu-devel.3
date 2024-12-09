Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1242CE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKjyq-0006Dx-0F; Mon, 09 Dec 2024 15:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tKjyo-0006Dk-BF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:03:42 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tKjym-0007sF-Iy
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:03:42 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HtCSx023854
 for <qemu-devel@nongnu.org>; Mon, 9 Dec 2024 20:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k60kCWGYfR9tVA1UMMGxOqwnoZssErax0Wxo0/8+fyM=; b=oYLxuSyD1wNquTN0
 HbrYeK+VzuSu92DCo3sYGU7tl5SEq5RNN/JFgh7jyZtlUW0tTPLw0yWs73QxIWmt
 nUhscfCCzBIiR4ImnzNtGfEvgKO9piryUK43PgUIiGySeA4hnr2sufoX4dg+9fpt
 74rxwLJU/fDMoKR6xwsjKOH1MsAWQJudRkeQq+b5pgt4WcKGv8C5KQV9eb62sHtq
 x8AMEwqnahjNXb6FmPE/pBVNzN2U9zIPipP4RHlw986bC1n9Byf/RuZApwJR2f5g
 FOP40EXj9o0Msfb70W+296Tn47CkmyfFR8/7pZ9Be5cx5fHnt0V6a0VOOIZ4ijcB
 HQAlYw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e5c7ra4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 20:03:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4674a45cfffso68249101cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774617; x=1734379417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k60kCWGYfR9tVA1UMMGxOqwnoZssErax0Wxo0/8+fyM=;
 b=K9CGagbOshjzfwTeBKt5K+zhrfgoj/sknZz5qthxg7wT8eQDJVi1IVZfIvulw/+BWC
 3FG3da0OfxKZ+coNcQBQjQN1/IU1rQzQs/x7hjULDpUQpOTXJ9tCMKpiVz4zs4HGXH3X
 3UMi3kSXuwWnL9sbWdxozT/PvTHMJ6vX0O1v6URwww6RkHFolYd6MKQoGaI9V1i9fvFA
 p1c5BtU/T+qTdl2DZyceLS3s2Rner5sPWDSjODgCkrvwmPfRjFnyFyXqiYuPep8dMYlA
 frGLULxOPtBGHReBNi27LewuRNDAjrzwsdZSlCF/JPJSW+/wKgpkJSkHyogI2jHFlxtP
 ppqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQkmUomx2qPV8uFfOAxm2eURnGXQl895AgvSMd+vzH+g7NLgeiNizWVRxCca+WjYiuYTySSeRbbb6a@nongnu.org
X-Gm-Message-State: AOJu0YzioQnqpyRliUMc0DZxEkVMQkei0vXvpvuGT7M6034+xlzwHOnB
 AwibK+yEq3yy7HwwbcOMCmc2Tag4x+evoK+/j2OkLvVB/v4eNjCcWN48+fZQbGsF5Rwio75XQrS
 5zQvHwl3KNVFdQb66Q/n6lA8RIZeb30yfw/kO8kz0w0x4RrcCVSZMUA==
X-Gm-Gg: ASbGncup26pn4SA+vvSStF3eoXgj7sK62V7LsUbhVlWY1X5647MBlHobnzQ7kOObGrD
 WBqa9bXQ31B3728qz48vIabyXSeoDbQmrmaKcCFjDuZBdNX8XD9jvv++avwezIiH9MZI2xHXa6/
 KlYzTP+g8mtyPyVb5Ne6fTYxthvbFOGDBtP5DJ4foBVA73m2GdunVkzxG/Qvbapuwp68WeTyihD
 V8Pxp2s1ieghiBenWzh4z/6YirI/zVFAhORKbYNaZLxmh5O0IsX60u32sgYjvnKfSC+LSuuc4CO
 CPF/HyeSQxYe2qzvKf3BOF5P3wNXQipa
X-Received: by 2002:a05:622a:654:b0:466:954e:a89f with SMTP id
 d75a77b69052e-46771eb1ee0mr28231681cf.14.1733774617523; 
 Mon, 09 Dec 2024 12:03:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiXTRXNHhpxJNah80/ysZ1GokwVq4MCR8lTTGQymLb9AOUAviwOlbVVyaHmR0qqjXrzZFLUQ==
X-Received: by 2002:a05:622a:654:b0:466:954e:a89f with SMTP id
 d75a77b69052e-46771eb1ee0mr28231231cf.14.1733774617121; 
 Mon, 09 Dec 2024 12:03:37 -0800 (PST)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467550b2a37sm24514921cf.38.2024.12.09.12.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 12:03:36 -0800 (PST)
Message-ID: <447ee084-55ff-41e8-8d9b-6d85f176154a@oss.qualcomm.com>
Date: Mon, 9 Dec 2024 14:03:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update email address for Leif Lindholm
To: Leif Lindholm <quic_llindhol@quicinc.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <20241205114047.1125842-1-leif.lindholm@oss.qualcomm.com>
 <59d52f27-2374-414e-9aa9-6ffb0879f3fe@quicinc.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <59d52f27-2374-414e-9aa9-6ffb0879f3fe@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ytz79jT-Uj64GO_cdSJwkvRkJ3hw2qeV
X-Proofpoint-ORIG-GUID: ytz79jT-Uj64GO_cdSJwkvRkJ3hw2qeV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=754 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090155
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


On 12/5/2024 5:45 AM, Leif Lindholm wrote:
> (oops, +Marcin)
>
> On 2024-12-05 11:40, Leif Lindholm wrote:
>> From: Leif Lindholm <quic_llindhol@quicinc.com>
>>
>> I'm migrating to Qualcomm's new open source email infrastructure, so
>> update my email address, and update the mailmap to match.
>>
>> Signed-off-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
>
> Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   .mailmap    | 5 +++--
>>   MAINTAINERS | 2 +-
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 727ce204b2..5f6df414e1 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -87,8 +87,9 @@ Huacai Chen <chenhuacai@kernel.org> 
>> <chenhc@lemote.com>
>>   Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
>>   James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>>   Juan Quintela <quintela@trasno.org> <quintela@redhat.com>
>> -Leif Lindholm <quic_llindhol@quicinc.com> <leif.lindholm@linaro.org>
>> -Leif Lindholm <quic_llindhol@quicinc.com> <leif@nuviainc.com>
>> +Leif Lindholm <leif.lindholm@oss.qualcomm.com> 
>> <quic_llindhol@quicinc.com>
>> +Leif Lindholm <leif.lindholm@oss.qualcomm.com> 
>> <leif.lindholm@linaro.org>
>> +Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif@nuviainc.com>
>>   Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
>>   Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
>>   Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aaf0505a21..9ae6a78ae9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -915,7 +915,7 @@ F: include/hw/ssi/imx_spi.h
>>   SBSA-REF
>>   M: Radoslaw Biernacki <rad@semihalf.com>
>>   M: Peter Maydell <peter.maydell@linaro.org>
>> -R: Leif Lindholm <quic_llindhol@quicinc.com>
>> +R: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
>>   R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>   L: qemu-arm@nongnu.org
>>   S: Maintained
>
>

