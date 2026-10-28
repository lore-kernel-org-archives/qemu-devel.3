Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD42606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bB3m8yzi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EIQ6xDHx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuao-0008Hc-P5; Tue, 27 Oct 2026 23:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLuam-0008HQ-VO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:44:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLual-0005wr-6c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 23:44:48 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S0j4Fg113370
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 03:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3yxPXpLYE4on78oqQNQS3jOmWuJWspVElxxktVyfUs4=; b=bB3m8yziYJ97GbB7
 E1Fovnoly65PLaOHD91r6L/swZJtkBkAtRrPU9R0qMSdDKkomQqVXWKJSo5QnjY9
 Pmwe2TeWsIpZBGU47B5uzfAWmcf59b7t1PSuB8YeNtxWdRI33q4E/5Ob5g+1I1Rp
 KZ4s/kK9+itg2ZsFuYCu4ifept3eOwnOnzjmXhPYx8z5SBHpZKquLUoezZXC50e7
 2LZQ6r/MU8ABvG5rQtPgA6kGhoFTYaMFSjlc9G+YGLv60n5mGxl9+LLIWWwnSI76
 /BvHPPK+cwKLjUMW/Uyoi+8EKJG8F6dNlHasSLOjajyvJkwdIKu5d+PZaSW+G2A0
 LcNdAA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk2qe1au6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 03:44:45 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35cbea41088so741415eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793159084; x=1793763884; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3yxPXpLYE4on78oqQNQS3jOmWuJWspVElxxktVyfUs4=;
 b=EIQ6xDHxz3Ru3ZFVqL9mswGrFuApR/FcAqrI41zYkE4acIArnBHIFCRoD0hmvdXee3
 U0TYm22JSDu0vgB8gPu5sRCEzO15KLwFwapp9aaPLunonRX03pblhbhI9ETHtDdg/gJq
 5H+fXf7cdBwseu8s297WR00/2FT4gPUyovC5svfts2g7jpFmIMP/LBPy5ZoRzAXo0WK/
 9XjOcSvLeqZDYEjWiNfGuACVQQdwPEiNWJmWunRxlf4VNxfiCVQd/TjvF4XcWH343Kzc
 7H1cfZwdloP1eY+QAG1AcbFEtVEJP+/2yHr1P23l4xn1ttzstXLOnjfopamkRiuOoMPq
 d9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793159084; x=1793763884;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3yxPXpLYE4on78oqQNQS3jOmWuJWspVElxxktVyfUs4=;
 b=ZdZ+I9Z774LI/UT5WA+lsRJW0mnmc7RnPyATNqx+UUFLjqgO71rz/HBuKIynh7xtZ8
 WSk7k6x35qVzzWhh6XexofRyYJlJYq3G9H4MkPoTSTdAM4KLrh/IJbQmVo0nrnhDgSZn
 NDvQe1Nxa4aZOTe8XctynAWXDbY/OVeyLQ+0Vxbkqm1Wy6i+19qbLuhY3owbzB6tW047
 aOGHmu2EgRRNlvF/Nt7EdLoV6MxvByRFggFO5wP1vQBOQe5+7ZQwAkioRHMqj9SD763s
 cnmCHGMQyJGqX1k1w5DCza9W4DtZdVPazreKip3ge+Eo1sdxrfd/QoDle2/ZqhrzX6rb
 wvdw==
X-Gm-Message-State: AFq9FYKeuojw9lBW0agVQtYFkXvOtWYBdysd6mWy+SUYvZJeSuwRp/fC
 stt4gAGW9S85IgGZmyhU4YrT/heSGbjoWFEvhjSLoSIi7JREw80rolDQ2WRrhUbn/1AUsNqJqbY
 StXl3bCvmp0G/PUAOzv6N6uigdo29pVt1hJ+0NLs86idsHVekOiYwbaT5hg==
X-Gm-Gg: AYBFou3DjNoNXspQ/V9YErXvnaJmooJY8cHbha+WGYIfiYb9FlClJw/GXRkko9wJ4HJ
 jy6Rv/kX43uq+ZZ1XtbE+TUJYHlWarGS3LsCvNhfp9G9FcjbpynQtM8dM3/GzVZJZqVLxIEgCPa
 4NXdrYslazpa4YmXfDh7Kw2vtq2+s1JZx/Ob7RufrQUFvGx7M5pp0G2VW27dgU09EEq1XuXnqNw
 LMaMf28XgFcWhIUM1329Wxm4JsZsT0EdoKZCoknNqApu8Fz74pgjhHQj0L3k/FVvLxGfL/viUap
 bgGH+UgMvMw3EhGju4XUdc9xwem5zFkX4P+KAS4S/jppU11bM5aWeE8iEopLDQjMkHXd/zWCeBr
 +cePJvWT97jseVr6sm5IIDGi7yocJ61SS2L+fwg9QiFdAaFjvUwDpPsmJxBCELsiGy+a585hsPv
 UZa/poX21brL5vdeYJ2egWOg3DzTPYIe16PRAV+bEZsSo=
X-Received: by 2002:a05:7300:d0aa:b0:36a:1cbc:1093 with SMTP id
 5a478bee46e88-36a200ee11emr1591730eec.30.1793159084397; 
 Tue, 27 Oct 2026 20:44:44 -0700 (PDT)
X-Received: by 2002:a05:7300:d0aa:b0:36a:1cbc:1093 with SMTP id
 5a478bee46e88-36a200ee11emr1591694eec.30.1793159083670; 
 Tue, 27 Oct 2026 20:44:43 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a238d9a21sm1830686eec.4.2026.10.27.20.44.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 20:44:42 -0700 (PDT)
Message-ID: <6d8ba256-cd79-4ce6-963c-105610e497e3@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:44:41 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel: register CPU parent for each target
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Philippe Mathieu-Daude <philmd@mailo.com>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20261027054026.2184-1-luoyonggang@gmail.com>
 <20261027054026.2184-3-luoyonggang@gmail.com>
 <d001a2c6-79ab-4f75-8c00-ae0c43a67d2f@oss.qualcomm.com>
 <CAE2XoE8BD6kaC+055N3EJvUM_5SQo93SNjQsjHHciVkNaST7kw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8BD6kaC+055N3EJvUM_5SQo93SNjQsjHHciVkNaST7kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SYC94bUzLGDYN4j7ttDZG9aRiltFiuyC
X-Authority-Analysis: v=2.4 cv=YuGa1IYX c=1 sm=1 tr=0 ts=6ae16fad cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=0r4tXO3xKrh-mr6aoOQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAxNCBTYWx0ZWRfX9xUW8/xIIig/
 JbV1OU0qm7EqnYW07mUATvj3MHMVomfOd6DYSUIue1v22b3UneYhV3x2ue9Katds7R01Pv35vAS
 2P/J9J8V4IiG+QzleBrkJVpiZsNUong=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAxNCBTYWx0ZWRfX2hY9j6yOJG6l
 j0eWYZuzfDzROYDZDP++W8d/E2+jysTElxil03hEsyEgTB6Mxa5j7e+LFjbVKe1gBFw6xepFe46
 h9iUJDnawACEWjz5Exus7jYeybU1YeJM/maoYMcFgktKUB5UDhDQlZw6CKsEIyG+TVzR8YKA6VZ
 2CUgr4XN6Lxg2brcj0UqovIK9I5gY7wl/2PIuCH9Le9yN6+YQn3SZ3RajihhVZ9iK5fGs8EeCjx
 TtUVlUDoTwkNdPlJ1htoWIE8/gnUuQgZhNWUlMhPcpWoxUzIMMbHWpRJWgOGx1fwp5QsDxthad4
 X5S3/SWvTfT5wmwtbKeOOOAIpCg6I0DyHMiU+/u/qJpZFfuIuZE6Fg2Ojde5glyo5bsjewMrimd
 xPph8pbYi1odF1fZm/8sbJJg+w1Zu5rYR3WLVRAudtgeeppW9v1cf9e20nZvJgnFcZNffouKGxn
 /qJdfv6M/VPNu8ct38g==
X-Proofpoint-ORIG-GUID: SYC94bUzLGDYN4j7ttDZG9aRiltFiuyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280014
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/2026 7:03 PM, Yonggang Luo wrote:
> On Wed, Oct 28, 2026 at 2:31 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/26/2026 9:40 PM, Yonggang Luo wrote:
>>> Now we need use the prepared target-list to register different accel-$cpu_type
>>> parent QOM type. So that multi-target won't error missing parent for different
>>> accel for different arch.
>>>
>>> Also add a test for it in test-multi-target.c
>>>
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> ---
>>>  accel/accel-common.c           |  6 ++----
>>>  accel/accel-internal.h         |  1 +
>>>  accel/accel-system.c           | 24 ++++++++++++++++++++++++
>>>  accel/accel-user.c             |  7 +++++++
>>>  tests/unit/test-multi-target.c | 15 +++++++++++++++
>>>  5 files changed, 49 insertions(+), 4 deletions(-)
>>>
>>
>> An alternative would be to keep a target specific accel file
>> (accel-target.c), which only contains code registration for accel type,
>> and no global symbols.
>>
>> This way, the type is correctly present for all targets, without needing
>> to iterate list of targets explicitly, as build system includes what is
>> needed directly.
>>
>> IMHO, it would be simpler and better.
>>
>> What do you think?
> 
> I am fine with this, I also consider this, I have avoided this because
> I am thinking
> there won't any target-specific files except target-info-def.c in the
> remote future.
> Now I think a small set of this type(target-specific) of files is also
> acceptable,
> I'll go this way, much simpler.
>

Sounds good.
As long as a file does not introduce global symbols, it's not really a
problem to have target-specific files.

>>
>>
>> Regards,
>> Pierrick
> 
> 
> 


