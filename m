Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01ADCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 04:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEJWp-0005te-6T; Wed, 07 Oct 2026 00:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEG4m-0000Cm-Uc
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:04:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEG4g-0001Xy-7q
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:04:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6963AKId2981696
 for <qemu-devel@nongnu.org>; Tue, 6 Oct 2026 04:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2Hq82m2Dt3etdgXyoSxVtFjs0qwqCRn85g4f1qXbS8w=; b=NtDhDEcGoKNZSTdU
 oiLhy+4OZVFMZeL2znDN1UuwGXVb9NUs/b7URWh6Nj/MfDdeGbd7v/FRh8thkSgW
 TwthSVEiSuxmyzyNjZSOaXwedpo2mSbBucCF8hJtjMJaNMeyCJND/GRsMVKaFGWy
 O+Ko7I7JkjAosyUEA0wPqqaPi2gWq+aRw2GIuoR2tCBgzSQA6jeES32a1aPlmXNT
 Stpm91QqLBD61sS8yFT4s4lqxQudPnFNIbMUiEuvgi3dJHbTZ8MG00kzhcTNKtry
 YdbLGMt+srrwB++gWwHWwBRhBW8RTu7KrrwFICJOo9uBBMZjVNv0OWS3CGn+8Yoc
 PNULnQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cvnjwf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 04:08:43 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9179524bf03so46724326d6.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791259722; x=1791864522; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2Hq82m2Dt3etdgXyoSxVtFjs0qwqCRn85g4f1qXbS8w=;
 b=GjM+joRf+coBlsOVwXVMG5HzIabWAR0i2AubHJ39ezvNc80vAhnbmEbQtGgUs7Am3S
 //heHA1o/E9SfwhvRF1+GcWATbSV5AC/oAzGk9b8HaiJSyT2FFyGlqd7Gz4Z/Ul5zpCs
 jO+iBOfqQm5ToX0ZGVfpkHKAwftRu8PNurHbT5Tiw69ajTEgN2dO+0gpt3RAWwno3gwp
 rMiJ5thwl7j4gRzDMxxiw0lLoR0IAD/O70cyzEQ07jNyZdLz6ut/7I6boda9kyWwh3Lx
 haDbvEvu/YjJbuPSemtSVTyE4iDB/hYFjXdJzj7OPqQPrePtb+5RR+sJwRiBcOw37eoe
 LFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791259722; x=1791864522;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Hq82m2Dt3etdgXyoSxVtFjs0qwqCRn85g4f1qXbS8w=;
 b=o2TWr9P817G5w1m8cv1pCfvj8R5JvVltBBmdfRzEWabUTsqP1joPolViHq+/dpLS+M
 7jRjqH7Tgo3qCQjhzyKmJ2ZQqFwr6BllPf55CjNsiEzd8ZVAZl2amBQ2lZ1ljOJqn5xS
 5A9B4ECwycR/UrSut5XMquYH7lQHp7T+Bru5DxzdhmNp1aua19GZfqKcTSioeeDfHFTg
 HCl5Riq6bLG8R3L0xd5JnSlKLff27QVNdMxKtvILJZZvKwBfNFkWoDEwBxc+LDVmmeKi
 DLWZpbeRZyNX/YFRJKGCOd+A3xOobPlD3R7aT2KDmyD58V5GD2I64Mkkb6x1Kt6ttFQJ
 yb0g==
X-Gm-Message-State: AFuF++mwdbMlcXN/wzVIekTvPn8+ofcDVl/P7zaQLTmhma4oKteFXfHJ
 YdwYEcQiTyG6d74j0YawjleF4unhZwZxs3TgpDmfdR+SL8fw5rm13b/OKSZrN0nLZBOfm8JQhjX
 0R7EUL0NBjRaPC9p6vNRVYafsPBmQTm77iUm6Enlb2Spxz8YAq7qG3goyBA==
X-Gm-Gg: AYBFou2Ebjw31YZiLCMz6K/O/KjrqO9aNTbH1yj99Le0NXr1UqlKbYRtwjfXC2bpNHs
 pDCkS0g0Krc9yDRe5mmpcBhIDdmB6lq4Z5uCJBhV6Cf8I0KCmb9pCdlMbXQC6cfmWsFLCF0Oyqe
 JnAc7YVtWxnrq0aM58sSS/yIwr7fwctsOhcE8S3pnE68ujt67KtvZAvvwDazYr+tlnMR4V5Ciex
 VKnigxN8uOqMpAHuj+cOzmwh0dgDxt0ZtbaMPBJ16U8mGlBqZU23CyF14La5Aisy/7EFTWxOK2s
 uB1j7P0EcfYDsUintp8e6X28dmfqgip+AGZngyF+nv2YePtw96qLs2h/qMdLx4Qp0BIrsc7IZjy
 kYR/pZTYsJrvNg12FCZBnqmEKO728Ws2LtH0wvBN3fC9peTt8SE4/AI4o8ku5mA732HT8POPAz4
 +bloo=
X-Received: by 2002:a05:622a:4cc8:b0:535:19e2:6b6 with SMTP id
 d75a77b69052e-53566910aa9mr1338951cf.18.1791259722041; 
 Mon, 05 Oct 2026 21:08:42 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc8:b0:535:19e2:6b6 with SMTP id
 d75a77b69052e-53566910aa9mr1338721cf.18.1791259721459; 
 Mon, 05 Oct 2026 21:08:41 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398bf8196sm115364401cf.22.2026.10.05.21.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 21:08:40 -0700 (PDT)
Message-ID: <4eb0a728-db10-4537-aa47-489a1e32b515@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 23:08:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] target/hexagon: add directory semihosting
 operations
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260923153516.3615007-1-brian.cain@oss.qualcomm.com>
 <20260923153516.3615007-5-brian.cain@oss.qualcomm.com>
 <CAFEAcA9tY8in5QSuwbqxAyUxYySBWDVWdhJmCswt=zoR33ne9Q@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAFEAcA9tY8in5QSuwbqxAyUxYySBWDVWdhJmCswt=zoR33ne9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3WREL5Wfs0wP-uj1R7YdtDg6iUqtEykq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAxNiBTYWx0ZWRfX+XeuJU0xV3SB
 va90pF2DeoihFvgtS8/eAAo9PiMUx2So8bWg3TGVoZKVn9BjrU9fE3Rb2mu4IgF+h5jevlc2++c
 hXORE8c3PJSaDMsocPmzIlDKZe17aTweAtyIBVscPIxnZ7ViKoQDr0UqG/6nCksQ1wGj3MU53IK
 HuUO4jtlvE4fhKq2ia4vOg2IfBTs+JQA49Uiwh+Xtg6QJ/erlttRKLKuWlI+rVLyFT0G3/U29aM
 oWZ2cK3HnpF82PTAapD4mkGYKeYhXEuEMFcFNDJ/gREJ39jBor9PXyAY4C5BMCI36dAcieGybX0
 gk4r9ZenjaAN5Qrh3FLGgR7xQIkT1MjjQAEtj9szDNkpnGJEdb40JBXMPBxBalRzPK8FIjgVoMk
 uO34Zl+Brb8mdGVgHs9EEQdp0RbizmQDJWwWAtm4wR5P3052KNNy1svWbAjZqsaI1s+Wbia/tjE
 kcZIMQd/iFbRetaiaMQ==
X-Proofpoint-GUID: 3WREL5Wfs0wP-uj1R7YdtDg6iUqtEykq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAxNiBTYWx0ZWRfX+tUZzLRdrAM/
 dJa9FMEy4vhym23UtItwOsoDc4V33JWahaUFmrVNAwP+9nEwU/cmvHeJNHIhLT3Wq6R6Z3Xz4sZ
 f5SdEGJG/9jQagHJIP8oBITr4tAku7E=
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6ac4744b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=CwRCHdthjbWYiqAQ5FsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_01,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060016
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


On 9/28/2026 5:14 AM, Peter Maydell wrote:
> On Wed, 23 Sept 2026 at 16:35, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>>
>> Bare-metal Hexagon programs use OPENDIR, READDIR, and CLOSEDIR
>> semihosting calls to enumerate host directories. Directory handles are shared
>> by CPUs in a cluster, allowing guest indices to resolve across calls.
>>
>> Use lock_user_string()/unlock_user() to read the OPENDIR path from guest
>> memory instead of copying it into a fixed-size buffer.
>>
>> CLOSEDIR clears its slot in the directory list, so a stale index reports
>> EBADF instead of dereferencing a freed pointer.
>>
>> Also add a functional test for the new semihosting operations.
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   include/hw/hexagon/hexagon.h              |  14 ++-
>>   hw/hexagon/hex-subsys.c                   |  32 ++++---
>>   target/hexagon/hexswi.c                   | 108 ++++++++++++++++++++++
>>   tests/functional/hexagon/test_systests.py |  11 +++
>>   4 files changed, 153 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
>> index 62398eeb359..58bdcabe87e 100644
>> --- a/include/hw/hexagon/hexagon.h
>> +++ b/include/hw/hexagon/hexagon.h
>> @@ -11,6 +11,7 @@
>>
>>   #include "system/memory.h"
>>   #include "hw/core/boards.h"
>> +#include "hw/cpu/cluster.h"
>>
>>   struct hexagon_board_boot_info {
>>       uint64_t ram_size;
>> @@ -159,6 +160,17 @@ struct hexagon_machine_config {
>>       union hexagon_config_table cfgtable;
>>   };
>>
>> +#define TYPE_HEXAGON_CLUSTER_STATE "hexagon-cluster-state"
>> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonClusterState, HEXAGON_CLUSTER_STATE)
>> +
>> +struct HexagonClusterState {
>> +    CPUClusterState parent_obj;
>> +
>> +    struct {
>> +        GList *dir_list;
>> +    } semihosting;
>> +};
> I still don't think we should be holding this semihosting
> specific information in a struct in the hardware-emulation

I tossed this patch in to the series here, thinking it was fully-baked 
and ready-to-roll and relevant to the series.  But I agree with your 
assessment, it doesn't make sense to put this state here, even if 
Hexagon would be the only architecture to leverage it.

I'll drop this patch from future revisions of this series and revisit 
the design before sending it for review on its own.  For now, the 
remainder of the patches can proceed with review focused on the coverity 
issues reported.


> side of the code. File descriptors aren't per-cluster, they're
> shared across all of QEMU (i.e. you can open a file in
> one cluster and read it from another), so opendir handles also
> should have the same semantics. That also means the code for
> them can be in the semihosting related files, and not spill
> out into the hardawre-emulation files.
>
> Compare semihosting/guestfd.c, where we handle filedescriptors
> for the guest by tracking them in a file-scoped global variable.
>
> -- PMM

