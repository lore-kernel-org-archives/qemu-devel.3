Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29CEC5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthtE-0001JS-Rh; Tue, 11 Aug 2026 04:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wthtE-0001JG-31
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:31:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wthtC-0008GC-9e
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 04:31:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67B72aII3008599
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QtPUtPh7ZGfMExnBX9gkdHSlaXS+KyvLZTdXPU+Bqrw=; b=Wk5q4kqDKwuAEU+0
 1roIzrM4UuPxbu4VFfkvCji2NR30moOceXeS/XTZoPp3Egp7at61SsVc0bN6woj2
 vYfLgta5hTwrshKnHjFLVuIsqRN8drPxIjfZoO8QIfNZ0TpbtWNsgEGQa9lymHoT
 7wAzpPjUXOOGHmm3I+AuDuJYe+i3/arNPRG6+3ni6r5+tEq42z73pPMjEeUIX7P7
 QaJ698Fy6KqYTygG3WnA4/d1SfLrEG0pNUW4xOCyQIxFpyTuJxz537DL+Kmm7koq
 PLj0t8zXR/Gb28okpuAgg2tqoefofpr1fC72xg4+sIBd4OAa8Dw0QXpAfG9VJ3kW
 Off0nQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjtk5g6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:31:12 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ef8249f73fso51724546d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786437072; x=1787041872; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QtPUtPh7ZGfMExnBX9gkdHSlaXS+KyvLZTdXPU+Bqrw=;
 b=Xypv8qhlU0m2BFn69bObNXKMOvPdDq7AYWlJDFaGiBAPbWC1S/hZl5Sz0c1U6mV5vY
 HkC60XRGMKwNZhML+2bPAE5vOsVz6JsZ4PcSSRmZZAPyKywEZ9lqds3ttEdKcFJWBXfG
 gQajitCfW4XTrvDTJVJAxk6+pyS0C2zFuM/l8aHtCoycLM3MdTP2M0bHD7p5TNwL3ifZ
 JsQ+9JSlRdXXLeU72QiQFgV7ndMKCyPDLXOwfIyADBIE8+tfCo4uFrxiJEAKk4d2o1gB
 Z5ctKc/GQkmnhmWNdcXyvktNrg5Ie3nvzdmAfqvgRcSXvXAeezwbpaXcovuNgiFpXFr9
 Uwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786437072; x=1787041872;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QtPUtPh7ZGfMExnBX9gkdHSlaXS+KyvLZTdXPU+Bqrw=;
 b=Uosedmd2CsdRHSqiiR5MLdH0gQTHcqdlq1/j1ZkJrJMu1Fl9IvMgAs3H5sEpZnOof1
 bGZ8GIKC/I/AoGBIvVhGxiT5zdRRXr0Nwd7A+z1qO07Ksa6i/IIJGMZ2WxCsDR6zE5fL
 5yI+VnHHJZsln8H4MRQ4jlaZJjUIdQnS5h4Qz6mW5XI8qMwvaAX6/bArF76yty2/OU++
 TIq8117L7h/BXJLiyGZyNUG7fnOU/XO9slhl1PIwUtAy+rYbrgeEgrnuiXj7nU1+gpFB
 uL5sRkKeNa8YR9Dx0aHfr84oYxN6vODJWecHq+SgNwd9ZeSOhIiSMlmHOsnRg6/2K8ya
 /Okw==
X-Gm-Message-State: AOJu0YwYeSe+izhPQWicWd5d7RQhQoQf+ZtOlvDGmLd1fOJbs9OB95au
 y8trFXesZmLGvUd+BQoepeatJddm+gwMvB49QmhlHek0n+ubMBPfN1sVHqvKSHFhEYjwiT7FfOV
 edS9sba/haqEn4L46dYcCJ39npDze/V7MqdAlF+vT2UmPFHJR7XH/xXIVNQ==
X-Gm-Gg: AR+sD10f9faBKWBPi2y1IvU01RXgBOp99XWp6Dv9nsQtSEPoFWeOtay42eXDUIJrQFN
 ZlPkALeNMV7ApHepMhCcdFqZOp7i1qi1hvqHjNWt/2p124ZT1TVVprfy+GSbwS8XZCp4B8ZjX6b
 uLLrw5Sys3xPMLIcSvsyJLPUf0yvNBUbdU+AnNzxZt1N0sz7zy7rNF1ShmZzsi+TPK+0v77y0ze
 kM6M/Z7tMSOivN/PkxENRPhxfukVCXpRMgb/syI/51xFApABy+pCSvnd8UenqJamjgP6rvNfFbN
 e276iVh+YeX/dvSwNXX6OTuKqutv9v9IgzUM5umuijbpWi2f1Tcac4j1tT/iu3TSFwmuLOZxb9v
 lyR2OSzcfkZdD3OJF74u/rXpUzA1jFGS5Ih0=
X-Received: by 2002:a05:622a:408b:b0:517:9f43:4732 with SMTP id
 d75a77b69052e-52d584d56fdmr12348051cf.11.1786437072369; 
 Tue, 11 Aug 2026 01:31:12 -0700 (PDT)
X-Received: by 2002:a05:622a:408b:b0:517:9f43:4732 with SMTP id
 d75a77b69052e-52d584d56fdmr12347711cf.11.1786437071969; 
 Tue, 11 Aug 2026 01:31:11 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788a5bc5sm19367635e9.5.2026.08.11.01.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 01:31:11 -0700 (PDT)
Message-ID: <fc24bc74-445a-4021-8559-aa1783b2379d@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 10:31:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: add SPDM_SOCKET Kconfig dependency
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jesper Devantier <foss@defmacro.it>
References: <20260810214846.76805-1-stefanha@redhat.com>
 <anq_imtEJZ3XssyQ@AALNPWKJENSEN.aal.scsc.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <anq_imtEJZ3XssyQ@AALNPWKJENSEN.aal.scsc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA2OSBTYWx0ZWRfX/1Zwztx3oD7Q
 K3oIM7ax05T7BwTQgeUBytPlVD1tsAs7F2Ww+g3LRX9agDsDctJgusItmeyDtnuGtvsJ2VZVw5r
 2XKnR/abvp1T78K1I4Rm6dt6pkXDfMz56O4Zmccj5t7H+YxMLDDQQ7rC0phKWnxkgF8s+YRsmF+
 akYFvBuQiBOhwjzlyQ2X55VUS/XpBU3fUXrXVCV1+OLlt1MxD7WJOeVhxJbu+qAu/x8V1J5OOaB
 RpWeRC/7To0tCkb5kgOOW3zydww+EEczL/lEEvSa9/5JedGL0NngtPbEnCSkyCfv8vNUbdZYAL5
 FKsyAret6nfWaMNUOkLVh57AH0+z4DDvv8nsQNBpVxj6nD+Tr6J1aJi7WaDYDqpX+xtkNmqmoXN
 kLKGs2ZrLHXJwIz541RPOTInrtK6qQss2/sEj4MWPSagKx1FQeCgpKuycQAmihtG4QJgpd06gGJ
 2fkUWySMcAFLfXKj91Q==
X-Proofpoint-ORIG-GUID: Cf4OoEm_vlyqdyaIHw3oBRw8tMOhVBZ0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA2OSBTYWx0ZWRfXyeK22/g4+NPk
 3SS2IxJF8No6e3x9g/hcAsvUh1NtwLEYl5YjTtlw/gU9wB/2C7wmG8HD4jRRj/3HHXapcJ/jljI
 VIVuAolSaf0KkQjwIJc8siTD/Hu7hIQ=
X-Proofpoint-GUID: Cf4OoEm_vlyqdyaIHw3oBRw8tMOhVBZ0
X-Authority-Analysis: v=2.4 cv=JsHBas4C c=1 sm=1 tr=0 ts=6a7addd0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=hD80L64hAAAA:8 a=xKXOTrkg92ieU5iZuiEA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 11/8/26 08:22, Klaus Jensen wrote:
> On Aug 10 17:48, Stefan Hajnoczi wrote:
>> The NVMe emulation code unconditionally calls spdm_socket_*() APIs. Add
>> a Kconfig dependency to avoid build errors when NVME_PCI is enabled
>> without SPDM_SOCKET.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   hw/nvme/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
>> index cfa2ab0f9d5..cfeeed64cd7 100644
>> --- a/hw/nvme/Kconfig
>> +++ b/hw/nvme/Kconfig
>> @@ -2,3 +2,4 @@ config NVME_PCI
>>       bool
>>       default y if PCI_DEVICES || PCIE_DEVICES
>>       depends on PCI
>> +    select SPDM_SOCKET
>> -- 
>> 2.55.0
>>
>>
> 
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> 
> Stefan, Philippe,
> 
> Do you want to grab this through trivial fixes tree or should I send a
> pull?

Sure, queued via hw-misc, thanks!

