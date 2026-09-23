Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DF0C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9P3B-00059j-G4; Wed, 23 Sep 2026 11:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9P36-00059G-Iq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:38:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9P34-0007x6-Dr
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:38:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NDKpG22056305
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6pWQsOMHSEDRHb08r6+KlMXB6CTbxNriU7wPrhurRH0=; b=Ou9JLUlgTAnpoLbF
 zXTaE6jTUx073dV7RTtYP+Uvkb1D3TXUKKyBVLozqSFUgn36ep4f1XzIoUsT0Oed
 KSpCNag3/qiqfQbqX1RMzF0yqtWWb7q+2powSfLKp5BncaWsZN1UvpvKrliBkOlD
 C2gEHQh2lfoVaxY82+FypyMcGiiBvIONxv//jnY53a5TbDj26AQY1asO5ox8OKBb
 2Yy24/zRTPVzgZJ7oGYUusgj1fl/miwPNkutCuIYGTRLbSugCZjoX04r6AcD8HTG
 FeH4BEx7DFk+I22OFHumeIYck2qVi7TwLlXkiR4o4uXSoHo42XjHEvbXtIHLAgJV
 kdw07Q==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv0mva-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 15:38:16 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-86e8abd7136so17251597b3.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790177895; x=1790782695; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6pWQsOMHSEDRHb08r6+KlMXB6CTbxNriU7wPrhurRH0=;
 b=S8ZdTLRhVqhkqP4jFW/s3AxvNfsnc59HmEhI4grVCNpv4NR9YcczZ46wbOf9a/osJP
 9MCpUfkEKGgVpHBUk8o++SrhibASZYh8TnhRlDuSHRpuVuLZkZehKHIUxeeUPkbk50Cd
 YcUIQ/H9zU8aNYtQ4AVpjxJkQ4Bfg94DdXdtVRRylajUMxBAoRezC2P8VP/xHm7F/+kc
 EXIdC0lru72Kb6Mya0f1YSE1R1RtTlD1RGfGh8dLw2M6OyFoRLT9eTgsmMFYg8/isYWV
 MB7ZS4N6gYuESEAGLkOUDL2WsSXKCSENwXJGI0qGV+JUpxDVA1YFgn01tCs/dsHMIFQY
 Ojyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790177895; x=1790782695;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6pWQsOMHSEDRHb08r6+KlMXB6CTbxNriU7wPrhurRH0=;
 b=pSX+C2kcv29/cw20TzZf8PbND/yKlJszpRDedP8u7K/3K9siYEvYXP9jG3y87aZtkX
 b75hY4qS8E/+1ixJCeSqQm8zMgYQKaXWs00VbMbFWojpvlXBbVDJ0aVLIWm1m93bZw1g
 KTWN0nmvmgI4L5YjrXea2ZnW/zkcovE5RUEkkjeBfjXG6wd7NUiNTKgqVevB3X6zouUj
 vFnYp5kwkiMOX2jJp/Ldf5G+TTK5N0eLTkKP+TviTr24CdjTlu0fsAUHAdlp0iA1X6IZ
 SubBo44dJrMPh3TossZLBSsH4hCxfynlA2IqZRXjCdeBr5NwueDuPCCibb77Fe2xdZKp
 iQoQ==
X-Gm-Message-State: AFuF++lgfzJrfhpgK9wEc4aLmmPnx8R5QTbx3kPQYhvMkbp49ZS+TMXy
 N9cbZErtYAU2NW1kdWYNXzHCvyxp4VQfMKIFq8bpgzTLsJgaybCYf5fxwt3Uv3o/S8S9+HQ7KcL
 CNP3Oa843JTcGbJPxe7zVJvGKsamEYyF031Q/I389k9974VXlUmAe8ZWklg==
X-Gm-Gg: AYBFou3wbmhO+hfQqWOFAbfadXvdJhJXhJBBsM5Vc+mNco5SUGXfvfMpkK40Y8yrKiF
 ghwp1rrB7IxutCp8CWlmfBRCupGMKG9UmaVq1mhaeD0LHy0p+MfwRldp0M+qrWmQAc27EQVDXdT
 PXseTWVlTdxklZm7EK5zgK8aIuZhI8v8RBS9oFwbfj7xLm/HKN783pv5/2rSRqYkGtHm1qYlSQr
 19irpxobj/XscUlob3/eH9RkniEHoeZCPgf7UESol7Kv2ZyOWEbMYZpLO2ndopjjdZe6F/c4WiT
 lYwsMWsfdCwkbGAteJAxP+WeUo78/y6vVSnX47ZsFBRXYaEa1cd7gEIPJvfNJyC9ttjpNjr21JE
 vt1xzG6X04+9lQcpKRoj/e+ITSziqpBmn6XWdflqufNnto2Ikdi5NxAegyFyJPM9b
X-Received: by 2002:a05:690c:e3ca:b0:870:107b:6359 with SMTP id
 00721157ae682-8a45873855emr21785257b3.15.1790177895369; 
 Wed, 23 Sep 2026 08:38:15 -0700 (PDT)
X-Received: by 2002:a05:690c:e3ca:b0:870:107b:6359 with SMTP id
 00721157ae682-8a45873855emr21784757b3.15.1790177894824; 
 Wed, 23 Sep 2026 08:38:14 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9140c461672sm22561386d6.39.2026.09.23.08.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 08:38:13 -0700 (PDT)
Message-ID: <57bfbfff-6946-4c3d-9f1f-2d2d57af4d0e@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 10:38:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] target/hexagon: add directory semihosting
 operations
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
 <20260914223159.2735262-5-brian.cain@oss.qualcomm.com>
 <CAFEAcA-BeCMPhvHLG6Jkz9q68ZJUN36diepWvEbhN-+RxZtVQw@mail.gmail.com>
 <4f66ee58-7089-49ad-b839-e44a54bda86a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4f66ee58-7089-49ad-b839-e44a54bda86a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfX4prU1YGR6HUO
 8xHfLxHJeBCe9CGsInfaI+ekqNXH5/zqGcYbpujHubxj/qZXZcK1xmMuxQhh+uZJ7cAMK4IgyI1
 nVN/LF1pYx+wFigj1gpdMK5LgzehyrqAy2kehY3V5Lu7m0XPq5JXx+KwXvheNb6kdLMBLEUkObD
 CgKDkaVh5Zczgl4PVucxHjilF6hOqwQ5MI3y7Z/WnIdlXmVa5ZFkUsBMCkKCYf+kumgCWYYyYIu
 oyZ0eP1YLW0V8nYBFNaGK1PMpBhG8H6hHbVUKUM2QHNdtyqs6sjWXDGxK+g+z3lI5xmu4kipX3L
 I6BWrg6KPrPOkyN1rPshbYJsBtNOkfoCkwJiX79093deypTY1SuNKZQOXKryIxsT+zxzjwi57/g
 PlJpPKlDaMzfN/vI2BhvqFWXzwOgw8hcENBnjP5E+D8IWvnBwrDHVs8ln/I9fF3E3QGknP46H03
 YjmVuiNryXS24lqK2JA==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab3f268 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3jERnMMDuNRr-VQffmUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: 0ncpTdqz4HyUgML-tYH2B3Gn5kfN9rK9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfXz2iCuLVMBgEN
 ZTPiw0E58Z+FsmEflG5CbnvSe9IXKJmeuBWU4L7rxw8aHX4fvn/QYr9qn1KfU2nhaLOGPihLQYR
 AqexX2X5LWPUZ9OwRlQRSUYUu+kM6nM=
X-Proofpoint-ORIG-GUID: 0ncpTdqz4HyUgML-tYH2B3Gn5kfN9rK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230062
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


On 9/22/2026 8:52 PM, Brian Cain wrote:
>
> On 9/15/2026 8:07 AM, Peter Maydell wrote:
>> On Mon, 14 Sept 2026 at 23:32, Brian Cain 
>> <brian.cain@oss.qualcomm.com> wrote:
>>> From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
>>>
>>> Bare-metal Hexagon programs use OPENDIR, READDIR, and CLOSEDIR
>>> semihosting calls to enumerate host directories. Directory handles 
>>> are shared
>>> by CPUs in a cluster, allowing guest indices to resolve across calls.
>>>
>>> Use lock_user_string()/unlock_user() to read the OPENDIR path from 
>>> guest
>>> memory instead of copying it into a fixed-size buffer.
>>>
>>> CLOSEDIR clears its slot in the directory list, so a stale index 
>>> reports
>>> EBADF instead of dereferencing a freed pointer.
>>>
>>> Also add a functional test for the new semihosting operations.
>>>
>>> Signed-off-by: Matheus Tavares Bernardino 
>>> <matheus.bernardino@oss.qualcomm.com>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   include/hw/hexagon/hexagon.h              |  14 ++-
>>>   hw/hexagon/hex-subsys.c                   |  32 ++++---
>>>   target/hexagon/hexswi.c                   | 108 
>>> ++++++++++++++++++++++
>>>   tests/functional/hexagon/test_systests.py |  11 +++
>>>   4 files changed, 153 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/hw/hexagon/hexagon.h 
>>> b/include/hw/hexagon/hexagon.h
>>> index 62398eeb359..58bdcabe87e 100644
>>> --- a/include/hw/hexagon/hexagon.h
>>> +++ b/include/hw/hexagon/hexagon.h
>>> @@ -11,6 +11,7 @@
>>>
>>>   #include "system/memory.h"
>>>   #include "hw/core/boards.h"
>>> +#include "hw/cpu/cluster.h"
>>>
>>>   struct hexagon_board_boot_info {
>>>       uint64_t ram_size;
>>> @@ -159,6 +160,17 @@ struct hexagon_machine_config {
>>>       union hexagon_config_table cfgtable;
>>>   };
>>>
>>> +#define TYPE_HEXAGON_CLUSTER_STATE "hexagon-cluster-state"
>>> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonClusterState, HEXAGON_CLUSTER_STATE)
>>> +
>>> +struct HexagonClusterState {
>>> +    CPUClusterState parent_obj;
>>> +
>>> +    struct {
>>> +        GList *dir_list;
>>> +    } semihosting;
>>> +};
>> This looks very odd. Why do we need to track open directory handles
>> in this special per-cluster structure, but we don't need to do
>> that for e.g. open file handles returned by SYS_OPEN ? I can't
>> see anything in the semihosting specification that indicates
>> that SYS_OPENDIR has special behaviour like that.
>
> Here's where it was previously discussed:
>
> https://lore.kernel.org/qemu-devel/9823f67f-bfc6-40e2-ba3e-cb02e53a4004@oss.qualcomm.com/ 
>
>
> It's my understanding that unlike with file descriptors, we can't have 
> a host-portable way to provide directory entries spanning distinct 
> semihosting calls without keeping state like this.  If all host OSs 
> kept this state, we wouldn't need to.
>

If there's concerns/objections to the design here then I'll drop this 
patch from the series so it can focus on mitigating just the coverity 
finding(s).  And then I'd put the {open,read,close}dir revisions in its 
own series.


>
>>
>> thanks
>> -- PMM

