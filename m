Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97615606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QI5wTq8q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iXresc9v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHXe-0004AM-0V; Mon, 26 Oct 2026 06:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLHXb-00049y-4V
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:02:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLHXY-0000Zq-Qu
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 06:02:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q8xFKs1911554
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a09a3IoHyJ6DkvT6UHLooplI2/YT0tpKjIXapTejnx8=; b=QI5wTq8qu1gpQsLq
 nkccaBZoKBwVIquDGpCqOd2S9gzCFgNyLuQvUMqo21tOSsM/GOokRkXEmUv7sV0u
 IBUumkdD3v/07vEfyO9TASY88qMhPoCuLXbSAIDf3u4/ytlKrESBIQqTXBVSoH6g
 BNtV6gjXCc2+c7qQ8Jbv2kyZO7ShlFgcXabPiMUX2H3AYJ9BQ2PEh9Xj5JPwvMF2
 rB3j98pJ+xtZPmo+V0RRREK49uA8j9iSXR3IweSRIzrG/tiigKqwOwcf8SY6ebiT
 mCrjgWxbZSceD/5yVXewKe1togbNCw/4J5WDWsKPxoSxXYrjbXGzqqwZQmDXH2Ok
 kzLFpw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u607s6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:02:48 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eacd2f2229so4014932e0c.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793008963; x=1793613763; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a09a3IoHyJ6DkvT6UHLooplI2/YT0tpKjIXapTejnx8=;
 b=iXresc9vvjP1WETTbm5ZBsdrtRXTusCnYEHtNmZ8dDuo3ec+G/y3Lp4AfSbwlzCliL
 8StGuagVGVAtsMrOV3zUBmHYWzpftcFiQUFLmSHeEv8LBC4+WwPCnky6HCBKKxYnsGpN
 E9nLpOeTCdzdyh0XhI1ffIxih2F/PSoChpM8rp/sBJfgyTcfLGZAokMGfWSoGw46DK/5
 HySaRr89Uea8xNk0eJ9we5E+BMHsDvK6ix8mYUhOJrucL+NR3th2kIbaIzW6rfvLxsbW
 feW90sn5mudc2vZGtxAzTC1QNoz049aTOPqbnzLc0lYdNKvjh1jl2fjpqdKxpZG8uyvH
 LrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793008963; x=1793613763;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a09a3IoHyJ6DkvT6UHLooplI2/YT0tpKjIXapTejnx8=;
 b=qFH3iMqszJpioRX7WLjpW+i4ICtAWso2zEYfAn6YszWYLt+3t2cG0rAmgexkjo7L9b
 iP2QVs9xgWd9GeCBJoKd1RChoKzmA2onc73GYfq2t6WxNt+2FSSqhwDMzeG380yYR4eN
 Y89mowD+e0GKYz2nlhYA780radx/nBM1R3RseiQGZhqAGzdkL56t2Ic6P2+ZWfmoMZc/
 30qiMOHnuL0PfGr+Xwiq0w9OdzybLrXzic5PLliqUirvqw6r8tsc802KQA1rPT0flhf2
 oKazPw0sBaMsgsc3DTpiGJpj98j7WEAm/zxIB6jT+HrFKT4QpmPDmfWRz/6dRdlujDtA
 ZZSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxifM79mJED5klrEOEUmF3la3mLO2/NL0CoJlHhSukr+rkLOhWp08tvSkVRiNX+PumRTu+KNzFSiSjp@nongnu.org
X-Gm-Message-State: AFq9FYK1hNyOA0yc6NpYvio0GXpTM872hb1WaAozDR1kGdcz9as9o1z9
 oaCF3uIj2jM0wGfuUDe6DS+3LQ0czLFlIvBlxfdukcj100JixoNCGuol6QQBwScs3tEe6m7TZXC
 EJ13gitOaguGr3R0cbh3bsRWQ+zoegYmfNyr7i5E9ZvR+Q2D0gFOrFYIaMw==
X-Gm-Gg: AYBFou1RY6dJLUuvtmdwTv7kbvyhEW7tjyOO2C3s5/UI6zcfzebbGZAM/L/j74oqOFm
 BKuxYgl1f+WfLPvO0zUlgeTQQiw08Upg4DHVCMQHUrjPxVZQ55oqD35e7yD5Sx6pnhAv2HP4kNq
 GfiqnoUfaSeI4PJLo+YJsyD4whfZvVdHeKOlpX16O4yZDAuTxukrSU7WujjND2q6fsYmkPNPbCG
 ZYJl/tSBdhp8xWGWea5AHBeefO04ikfUvUSAwiMbhkZL5DLCWPlp1La+/PFG/Kam6NDT45Src5d
 XjkwQBWMcOjo1eurEmJhMi8D7iUzu266Yw9FAuD4xHz8USQEP9/w4p/6j4t+Cp+I46cUXSvkmhB
 Hm3txcMJI4SOOg4AE95fDQ5UvOQ4vXSb0nQ==
X-Received: by 2002:a05:6122:46a0:b0:5ea:98a7:3b56 with SMTP id
 71dfb90a1353d-5ec2323eb34mr2106497e0c.5.1793008961957; 
 Mon, 26 Oct 2026 03:02:41 -0700 (PDT)
X-Received: by 2002:a05:6122:46a0:b0:5ea:98a7:3b56 with SMTP id
 71dfb90a1353d-5ec2323eb34mr2106313e0c.5.1793008960929; 
 Mon, 26 Oct 2026 03:02:40 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3bdbsm12692865f8f.19.2026.10.26.03.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 03:02:39 -0700 (PDT)
Message-ID: <eaa3f3b5-a1af-4d8d-bca8-89fac69a0685@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:02:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch.pl: Don't complain about spaces before
 Fixes tags
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: Chao Liu <chao.liu@processmission.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20261023152357.1614817-1-peter.maydell@linaro.org>
 <3cd34f4a-ee45-428e-a4e0-55ed6aadce37@oss.qualcomm.com>
 <45364e55-9ac8-4d34-8a98-71bb9ed57937@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <45364e55-9ac8-4d34-8a98-71bb9ed57937@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6oo_X0jMM_7tgIz6y20rH4KvcxfTL1Nx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX1bdlRJWXrX2Y
 gYMtNIaghK8nmb0i/RL8utjR9t+rdJT0rwkSWL1aMMpDiESlnZXnR/24NiBOZNhkZoFeqF3V/RW
 1dD8AvDRiig6Hlecg2//Ya1SOTY6k7Bn05mAIlif9CEzku7A4hyrc2+7DXt6wWdMimmHcj8ShYG
 IA1vXcgNIBHyPDDuS2Tb8FJeCIjgqiZMXFOdNAGQSIwN6bktmefU+7m58qUq+6L2ely/YZPqugK
 ey3FfyuhQfrdcLQEwzcnzlqmVLyV/4Iy8ulmipb7wtGyCDdLG5Oovod8g6MJMiOTFaqTUf0hUBC
 AYtpm0lpyZvvz8nn4YtlCZ9gBLhS7Up4O+le/C2SqzW/q//4S3+JzG56qqb5Y2w9FrgwayLYSci
 NOKfyqYDO3SXRWdgkwumg9ZB5QVZZXnHY42vnCvkD1LltELgFYr5oMeiSgoqTHga+Q7iMlYxtof
 FDBOmgcKJEvXkzh9t1g==
X-Proofpoint-ORIG-GUID: 6oo_X0jMM_7tgIz6y20rH4KvcxfTL1Nx
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adf2548 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=QX7-ZrG9Lu9J3TIp27wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX995z0jUnzktT
 83FWEQrM+mh+TTOGJr6iGMQv/cx8LQUBKSauN5/sY3yrLzWuAN0tmWThgPmP73N0DhBDTmRdv49
 E8xDrXfgGPuQlxkNglhhGv8WQymigew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 26/10/26 09:40, CÃ©dric Le Goater wrote:
> On 10/23/26 17:59, Philippe Mathieu-Daudé wrote:
>> On 23/10/26 17:23, Peter Maydell wrote:
>>> The checkpatch.pl script insists that Fixes tags are at the start of
>>> each line of its input. Although this is where they ought to be
>>> in the commit message, it is not where the script will see them
>>> in common usage patterns like
>>>
>>>    git show <hash> | ./scripts/checkpatch.pl -
>>>
>>> because 'git show' prefaces each line of the commit message body with
>>> four spaces.  Allow spaces before the Fixes tag; this matches how we
>>> check for e.g.  Signed-off-by: tags.
>>>
>>> Reported-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Fixes: 910e1d41be6b2 ("scripts/checkpatch: validate Fixes: tag format 
>>> and commit ancestry")
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> I just ran into this myself today as well so wrote up the patch
>>> ---
>>>   scripts/checkpatch.pl | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> index 5df266acb17..82f62f60212 100755
>>> --- a/scripts/checkpatch.pl
>>> +++ b/scripts/checkpatch.pl
>>> @@ -1889,7 +1889,7 @@ sub process {
>>>               if ($line !~ /^\s*Fixes:\s+CVE/i) {
>>>                   my $tag_case = not ($tag eq "Fixes:");
>>> -                my $tag_space = not ($line =~ /^fixes:? [0-9a-f] 
>>> {5,40}/i);
>>> +                my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f] 
>>> {5,40}/i);
>>>                   my $id_length = not ($orig_commit =~ /^[0-9a-f] 
>>> {12,40}$/);
>>>                   my $id_case = not ($orig_commit !~ /[A-F]/);
>>
>> ERROR: line over 90 characters
>> #36: FILE: scripts/checkpatch.pl:1882:
>> +                my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f] 
>> {5,40}/i);
>> WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> 
>> ("<title line>")' - ie: 'Fixes: 471d4930470a ("target-alpha: Set 
>> fpcr_exc_status even for disabled exceptions")'
>> #24:
>>      Fixes: 471d493047 ("target-alpha: Set fpcr_exc_status even for 
>> disabled exceptions")
>>
>> $ git log -1 --format='Fixes: %h (\"%s\")%nCc: %aE' 471d493047
>> Fixes: 471d4930470 (\"target-alpha: Set fpcr_exc_status even for 
>> disabled exceptions\")
>>
>> Cédric, what is the format we have to use? (why mine default to 11
>> chars and yours to 12?)
> 
> 
> 12 chars is mentioned in the doc :
> 
> docs/devel/submitting-a-patch.rst:add an additional line with "Fixes: 
> <at-least-12-digits-of-SHA-commit-id

Figured it, we have to use --abbrev=12:

git log --abbrev=12 -1 --format='Fixes: %h (\"%s\")%nCc: %aE' 471d493047
Fixes: 471d4930470a (\"target-alpha: Set fpcr_exc_status even for 
disabled exceptions\")

Or simpler update .gitconfig:

$ git config core.abbrev 12

Kashyap, you added that requirement in commit cd6b1674d6112,
do you mind mention how to configure git-config too?

Regards.

Phil.

