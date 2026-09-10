Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AD9C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oDW-0006Lg-4H; Thu, 10 Sep 2026 19:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4mIY-00012D-Lx
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 17:27:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x4mIV-0002sI-Hb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 17:27:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AIRY8C1108949
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 21:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EBi0QU4yLO4lkP7QKzEpwJiY/b90oHg86k7lLHHsrVw=; b=H7e5bGfDRYYRs3XE
 U8S79oZRhx2Q7YFohou9YaAoxadx5rAPjME45N6peaHsV0lRJ1X0yoZ2Yx/yq3Ib
 ztKfmVGl1u6qRebo3A7vB/7D0YQ8zCmBrZ84HiB338qJL85JyM5hg52b+51QDg4W
 ZeMf3pufbR+k07WII7Nfoi/GbypYHjweaKuW7RYDxl72Sa8gOcJndvDZjP4pvGCu
 AFCjPKKOAJgrkrgsUXF0gStagcpVMgEfJ0Mfi1TZ9UgzM1eJpq8d2yqS16L2eyKe
 0sJUTjCToYti5q9KyjiN5PkoQuvGu4xXr0F5bsN6GLPrhgZdmfmtyD5hCCLN39T6
 uaNL6Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkxv79m3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 21:27:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90e7db8d191so3632166d6.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789075625; x=1789680425; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EBi0QU4yLO4lkP7QKzEpwJiY/b90oHg86k7lLHHsrVw=;
 b=Po+pWX2frB5mfcXLebJuUIzj/qK8jP2BM4AVUK0An9whC03MxeLbiIFx6xKloNxK1R
 +prAFFTuyQxySBvTGejTKfqwAPlz3AaoXQxTlKINM01bO4SkQx/Pd+/jB6Owf4Q3WU4N
 dZPJqdjZ4S5p2LiJEJxgbgrAwpgz7SJak/egrKHdXYkTOCIHmmn1mDZSogWkxpPQEWIP
 GorcRbWa/LnrrztF/40ov/0vWOxPwID3DpeWNXz9kH+/A3jR90HUVbPm0o1g6F73MN/4
 JSbGTBJxMV9fWRcVPzFo5I4+q6+sT477UNUgGsjYZVtxB5n767D0pqG4xx1lZzXENpsz
 bzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789075625; x=1789680425;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EBi0QU4yLO4lkP7QKzEpwJiY/b90oHg86k7lLHHsrVw=;
 b=oLoMjE55EQhUFNi3I7vaVfpTwcbjJiZzTvK85pSW2HHfxQpErSkMcQSAXa4nWF/b7H
 DYE9TUp8vhgd4QKllzXibeUKTCw1AU9uj54TqQrh5P7FayXzwtPJ4FSS/tFS8OJjfWDm
 23YmB5kSNBPR4cwgfWovn4YJ49vSiUEFqtLy7jMnnY54gIE6qPbLsfv0Y8ksunUHLE6o
 cKWM9uHZjcxIwyWtweERx8oLB/FQX1V0rbO18ilBdk2M85S7eDbUVU8jrn4Hd5DNhK66
 B3i/rlgfmYo9tB8Z0hZ6TzKTLNGAgB/XZCl1vovzwdL8FBVyzrxxWJM/L9AMMMZpAtuO
 mt8A==
X-Gm-Message-State: AFuF++lqoVl7iRN69zqhLrN0pG5V7nYc9wOxB/Lc0S3WUaFwVL3mJHIr
 dV+j30/AcdpP3+RLj3HNWXUFVHtXOtu3/NXDolHXDIG4q5UlgrTn7BYrrMbYPBmhT3d3/kyk8Bs
 5AhPPv9BbzWHWuIM708GXEBO0+TJXXda910DtbzqVbeYFKkXGBBZWxmMAQQ==
X-Gm-Gg: AYBFou3MBJiyezL4/Sno6kDqF8/UqCg7tY+o/qNb5OkfwuW0TO8Xt1l+TEYsatn6yqO
 HQsKGRP1K0GbC6S4D8Sumj0NWh8PfHGrTjuRXXh6Hvkw9uHQMqWntuWXiD5CLnsG+uFuaF5D5Hp
 u2k5QyrsdmWLy3qRIWQcWLB4fNLEd2/2ObhMMq4ID5RuHBAy9yXEsLwnKCoMHZFOtC3wgwY/NWJ
 Bi06jCdc17MIiKRuLLYSXr0lmB0gNRwiWm5j8kF92iPzcU5hoOevARdLGRO9uJvWjTNxVzlK18j
 mqFiydpUGnbSNywEyaFiXXVJyA6Jjyml1cwY2VeMVgo+taLAHqB8vxB4AtAEjBMtxYaoJe3110A
 9Ns6CHJatvduefXI1kribeZ++bHfjhqy5VaaGB45jtE61E/20xfkEFl6vIih9cAmI
X-Received: by 2002:a05:6214:4598:b0:912:db2:8b1b with SMTP id
 6a1803df08f44-91212081522mr11156576d6.9.1789075625077; 
 Thu, 10 Sep 2026 14:27:05 -0700 (PDT)
X-Received: by 2002:a05:6214:4598:b0:912:db2:8b1b with SMTP id
 6a1803df08f44-91212081522mr11156156d6.9.1789075624625; 
 Thu, 10 Sep 2026 14:27:04 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f49661asm5278256d6.30.2026.09.10.14.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 14:27:03 -0700 (PDT)
Message-ID: <cfb663ec-1a7b-47db-9c95-069e724b3476@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 16:27:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/hexagon: raise an exception for HVX with
 SSR:XE clear
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-5-brian.cain@oss.qualcomm.com>
 <CAJ+KCYPB8-coR8irYHZ3f9HqzH1EYyG_8ASSperhPkkj-g9zAQ@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYPB8-coR8irYHZ3f9HqzH1EYyG_8ASSperhPkkj-g9zAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI2NyBTYWx0ZWRfX2dxoB8vr1iBA
 YnDysiYeRuTJcaNHQUi2doT6mccHqSFwFHFN+HOM9SW9WQ4uVislGEsXmreeC/WNJcSS3EDhCXn
 tF9D8NeRYwPDX+uiSLRgrr0jDsQ/05g=
X-Proofpoint-GUID: AsznwEI0mpKnt5rLEYFwHDJNNfnMUysA
X-Authority-Analysis: v=2.4 cv=FPSOVOos c=1 sm=1 tr=0 ts=6aa320a9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=M3me8PUOhEkkHrOkbHcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI2NyBTYWx0ZWRfXymkcnk5Qg6ty
 H8Zz/c9DgYhfTzabrwpemSKoD20uT2YC0Q+udJX2cHkAA5yARSf5N5qQVoGHZmJAXz4Hr14QTte
 neAN/9tqHy2AWBW4mHO+yDVdYG8/qQsXo4dS9Zv5oYSqdtZA6+c9ijDKV868jW6OAS1a/RwVgLs
 VLXQA9TA/+DHfwtODO+BusnsS2h1Ztb9KNCfsPkjmgwiN94ccepZdNKtcqzjZPdny7GHMQa4unD
 c8KIN/mDfbIWZ9DEHepWx7n+XLEsWcRwYiP8FomLksE6Ci0Goii3enr+R6CkswaF/4yAg5HrZVK
 vqZ+sN++aXsbuMSq9OD3j6Tg7dquKopbTn2sIhJ1z41a/g0gaDBlL/ly90TJzYnAbszXtnLQhpp
 iBd4WIC/1lMMv/BGWccxCray3o8PSzp6LaCbF+jsTfr5Mf/aV1JqtJLR9Fcv5wqum/cLIH56fbQ
 pRu+c0nTVBNhaMWHb7g==
X-Proofpoint-ORIG-GUID: AsznwEI0mpKnt5rLEYFwHDJNNfnMUysA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_06,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100267
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


On 9/10/2026 3:15 PM, Marco Liebel wrote:
> On Thu, Sep 10, 2026 at 10:32 AM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> SSR:XE gates access to the HVX coprocessor: executing an HVX instruction
>> while it is clear must raise a precise exception with cause 0x16,
>> NO_COPROC_ENABLE.
>>
>> Carry SSR:XE in a TB flag and emit the exception for the
>> first HVX packet of a TB when the coprocessor is disabled.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h       |  1 +
>>   target/hexagon/translate.h |  2 ++
>>   target/hexagon/cpu.c       |  2 ++
>>   target/hexagon/translate.c | 11 +++++++++++
>>   4 files changed, 16 insertions(+)
>> +    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, HVX_COPROC_ENABLED,
>> +                           GET_SSR_FIELD(SSR_XE, env->t_sreg[HEX_SREG_SSR]));
> Is it safe to cache SSR.XE? What happens if a thread changes SSR.XE
> while executing the TB?


This mechanism leverages the translation cache.  Consider these flags 
like an index into that cache.  When it changes, we resolve to a 
different translation for a given block of code.  If it misses, we 
translate the code again with the given context.

SSR writes cause an end to a TB, so SSR writes cannot occur mid-TB.  The 
SSR register is local to each hw thread/vCPU.

So, I believe it is safe, yes.


-Brian


