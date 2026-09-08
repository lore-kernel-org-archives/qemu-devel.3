Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA0DC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 21:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4348-0002XW-3W; Tue, 08 Sep 2026 17:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4346-0002XD-Qq
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 17:09:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4345-00010s-2h
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 17:09:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FdX8S3964188
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 21:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LCbxiyNti63SWiGfEQEBqS8j7G+uOvzWWSkEcL7K3r4=; b=O0YooWJDbVVbtcmv
 t8Xu4i/8UaT+EF2WaMlwzL1ihIrrjR57fAhzVtKe+q51K/ly5HibXLXxvbt+0q2n
 NpfX3qiN3rP0pthmzKcb1r+/01ipoD4k3EgKl42JbqG2t+xwCbkI3U1PRFN/Nrwd
 RDC8GaF3b8JSiRnhJXj/obNp2S8aSIthKkCXbMvf9XZmSptYbQ8fHJH8abDoMC5y
 0CeGtVT7+ICiuV6a+Xe4XBcJJPhBlqOK2oGOp4roc6XGIQmd+8pzVrZocO41e2ql
 Qt1QkT/luDspn2jSTGOlDq21JU6wVnlgbOvDdo9yYqGSLLmz4WGbL1j9CutXs/QM
 CYyLuQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjfp4b45g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 21:09:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9393ac4961fso465932085a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 14:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788901751; x=1789506551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LCbxiyNti63SWiGfEQEBqS8j7G+uOvzWWSkEcL7K3r4=;
 b=Y1hOksIsvJDmhhwf1az7qbYtnTZWI4/hYMBnz+fxfhP2FlJvYx6P7/8yVfTKUpvHbr
 pAVyAMsJIO2X5AmHtXnUuE0NbWbQ3nE5C6CDgG22oeHzbT1Vky1WDvTfAmVbqHC4jnvN
 5gsfnT+xKastBQxgyaEigLqzxsBonzcou+g7SRgzmf4O2jbdNvBz5VxxO24vfQIb3gKa
 7GcTbliBYKTi4e4BC3AbxXSmyQiyWNDdE7pJ/WgI8Me9EokOnAOOgHPO2y0/NxVfe7CN
 zXG4oV8rE08e6lLg/iwP3ubeWRrWuzShcNJ0f/WqQiOhEe5aS9fA1qNMsRA9sLSjQ6sn
 SSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788901751; x=1789506551;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LCbxiyNti63SWiGfEQEBqS8j7G+uOvzWWSkEcL7K3r4=;
 b=dI/LDbY8DN9T5h43p+Z5Yx+1gkD0plU8fO7znKAm7duUZcMbn1HUkJeOodE/EYZEnA
 EprakNzc/0t/OW14O6g8B+TWV2iH0BqhwXog++ThGbXTKseS07XbqLD9gAEo0Qg23Xu0
 EQoayPNb6oESOX8YYqSEOl2/bQXI2IpWDdhj/WnyQa+6duOYemNg/rAWuW77PzGsUpnW
 XzZSf+lffrDWfHqCgLG3+xDSo4Eo6smffq//3Uw+c9+Iio+4l4GX7Wcw2ojdZIBtuVn9
 9OcumIwIsONlTgSAe7Am70IgXvaUesPRUyizH+OuXOD7XI/uaMyYV959DAaSwzoE35iC
 zlqw==
X-Gm-Message-State: AFuF++nBIw9FRIhpiYYMPzGU++aWDkFl5SJkHKqHAxoXl3D1toEzd6Tq
 hsmg9HWIrsuuDf7WxiWA+bKh0bpVLHigub0A7Urt4n2cdS8EHS0q8c7U8bvcyQwIF+WaG3Tqrw9
 mKwpQRJP9VibQvMHeeDqTihDI5+0qgbUiknHJKhFwFVes9qf0xuKVOIgmqw==
X-Gm-Gg: AYBFou1DBz28kn2tjNMQMVdGdeR4Slkq3XnhuxUwIVVAerev0sH8JaHvT7gE+tJmzj8
 CXik73AZFFKb+uStzqX3AlaG+LSwMfgqNPBZ6udEcZ9uSZIui4qjXeyt3jrSHZuvHHlDhDWzBjb
 Qum3zPJMLChWRMdHgwrLFcJOu0/1s5tEAd+A4s4Q4H5BRwzUA5X9yE0aNaJv6MIWi5oULJR3Ixz
 YKRZqMVzbw4mCZmNmMTQvlCrPS7SbGHPOJM7JFTHmG9VHUvryd+V0StlaWl7yIK7a6rqvDZ1WPh
 eq4ZG+eJdZlZ+n8mcgHPBwcl7VF4svu6By4OLTRT61C8eAF3e/EIqZ7wQpAMlsH8NmPa0rRf2un
 fIcwPHfYgmBe86+0rA+WdVsQI6wJL/w5hOQbabtZsaCY1P+OF7u3IaWQVR3wB3DMSvKRoS8lnud
 Zt55GD
X-Received: by 2002:a05:620a:370a:b0:939:15e:1a5 with SMTP id
 af79cd13be357-93980528e01mr3625803785a.35.1788901750717; 
 Tue, 08 Sep 2026 14:09:10 -0700 (PDT)
X-Received: by 2002:a05:620a:370a:b0:939:15e:1a5 with SMTP id
 af79cd13be357-93980528e01mr3625796885a.35.1788901750249; 
 Tue, 08 Sep 2026 14:09:10 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939a3b906b8sm697866385a.38.2026.09.08.14.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 14:09:08 -0700 (PDT)
Message-ID: <5cdd8f9a-b4ac-4f3e-801a-de7bc1442f00@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 16:09:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/hexagon: add the V81DGB_1 and V81QA_1 machines
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
 <20260908133512.2353957-6-brian.cain@oss.qualcomm.com>
 <CAJ+KCYNWJEOL+Qg7gBLrMj6J25A_F4ArjJ0vOM44LNCB92O6UQ@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYNWJEOL+Qg7gBLrMj6J25A_F4ArjJ0vOM44LNCB92O6UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Qu9uG1yd c=1 sm=1 tr=0 ts=6aa07977 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=NWWRDZ9NuYtrfvLP1qEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: x_XlAWS4cWDjsnXWVktt_bgU49lsyOvD
X-Proofpoint-GUID: x_XlAWS4cWDjsnXWVktt_bgU49lsyOvD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIzMSBTYWx0ZWRfXxkcBD4O1vIPf
 /7kMD7++peOjcj7JgM3y2ROJdbxDhXQme5cLHtf9vTLd7th3Yvj5xTxf2XGiIlIBoX+d0FLG+hT
 CLgRiL9tz3Y/2A2oOUMmLkU9ssnUltOtmkGzJkKobl2yzHjhaHQZsWvK7HM08vlSUEX+rbole5A
 iaXdRJJKoZ759c67FSebU6wm+o5cWfRqUFa0ZfdONgv+Y7j/l54dM+DvrBL0Oc82cZLsbEjyibH
 50Ul73MTTTHDSyniLfjHuuIYtl5NgfgZl3I6kqJyZF085uyEGSjhBrGVUWK7F7SU42CAFpPHLO4
 KIl4cW4CO7kiGwkZj7m8oHWpr1m5wMccSrt7EyL1oqmyOfrrZhGeuhP6MPwGDtnbMnI+a6rawAM
 sjp1VyLLzmPbLvuStiVx9wINpiv9ff79QtNxsqtbcIgDq22BnJIrZSbcxadSnfdyELyW6Xu05Od
 60fU5T1B1lVqi2KSDrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIzMSBTYWx0ZWRfXwVb7qnXaL9Kq
 YY5Dpn2kdVSjrskFJju5V6ELKReoQgBsXqMEKt/plihX1pTCodlWtQBsugRaxh1DFFIAl4e3hVY
 mVHnJsaXTzjWZE7Flwex3fhIySYrWUQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080231
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/8/2026 4:05 PM, Marco Liebel wrote:
> On Tue, Sep 8, 2026 at 8:35 AM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> Add these new machines that correspond to the hexagon-sim machine types.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   include/hw/hexagon/hexagon.h          | 11 ++++
>>   target/hexagon/cpu.h                  |  2 +-
>>   hw/hexagon/machine_cfg_v81dgb_1.h.inc | 73 +++++++++++++++++++++++++++
>>   hw/hexagon/machine_cfg_v81qa_1.h.inc  | 73 +++++++++++++++++++++++++++
>>   hw/hexagon/hexagon_dsp.c              | 46 +++++++++++++++++
>>   5 files changed, 204 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/hexagon/machine_cfg_v81dgb_1.h.inc
>>   create mode 100644 hw/hexagon/machine_cfg_v81qa_1.h.inc
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
>> index 8a4a81dc26c..719979d6c31 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -50,7 +50,7 @@ typedef struct HexagonGlobalRegState HexagonGlobalRegState;
>>   #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>>   #define VSTORES_MAX 2
>>   #define MAX_TLB_ENTRIES 1024
>> -#define THREADS_MAX 8
>> +#define THREADS_MAX 16
> MODECTL_E\W and SCHECFG_INTNO need updates to handle the increased
> number of threads too.

I'd intended to follow up with another set of patches including some 
v81-specific changes like that. But on second thought they do belong 
with this series.

I'll make a v2 with those missing patches.


