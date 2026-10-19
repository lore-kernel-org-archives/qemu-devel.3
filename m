Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E3606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eWP8Dx+0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hhVLeGoX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIsfP-0002zL-Th; Mon, 19 Oct 2026 15:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIsfO-0002z0-Dn
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:05:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIsfM-00010U-9X
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:05:02 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFOsKw4180380
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 suYVWt+bVCPEGAUWmBr1sVbMBLzYGWy1+D2NFe2tdAY=; b=eWP8Dx+0HKWjyN9G
 kKxz6KQ1NWDnjEtw0tdiHcITWFJTB8lK39Il1q36wz2jaO2jQhPWX5qdiZJCwntN
 oexsE443Ng08JSjIH/qzl6S7HG2sZPdl9TnhwswHy9Bt1YTLwVhm0Hh4UusN4VBN
 OdCm9m+MJicKoc7wFu0fhXAHmKQXklZbotoA8umXzJtJ24a1iJTguE22d/FeQuy9
 YXJJ7PsvnSMAGpcxe5NnNyL13uyzXOfV1b0F5D7QWele1R+utm/TXMybtVvSP6/i
 5r2N+SRbiYxyWD3MIkQqrXWV61z4YQQJjFFjwSlrqRsSR4PbGBg0ipa5ktXlTgpw
 d/uIaw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3faug9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:04:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so5249323eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792436697; x=1793041497; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=suYVWt+bVCPEGAUWmBr1sVbMBLzYGWy1+D2NFe2tdAY=;
 b=hhVLeGoXxXxHwpXOWS6Bv22GHAPZVtoJJIE9CVSdX+k5WB9O4xrN2An1C10Nu/YYg3
 tbKKCrR6lClZ8FtrQmDshfuipVNgbDthteTdMvJV5hbzme1+57BCCvKc8pvcwASDo3hW
 NGvH9ClsdYDE1GS+L0ZoXNemPQkoRIn8LoMCXHw3JGJz56DmXyHYr65KCfRAt/8d3vca
 XsdhA/C5apdp4MqTwiZj2gVm3PJi4RJgNtMfIzjQFiZHT+FBjoytBcWIQbSOQPi4zJGH
 ePrwlJRtt0kasA/38kteu8VZjKbH0D4zB3EdAA82lawt6kFHuhSuOUMUMsqSwxpXefys
 9otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792436697; x=1793041497;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=suYVWt+bVCPEGAUWmBr1sVbMBLzYGWy1+D2NFe2tdAY=;
 b=2G2vqqBnxyCl/mc9S8vHV6/llEvisthQCtTtdWrWKdWXtvU19WqoW1qrl/T97flKbA
 FWRTVZ6Tj0O6B6UXE+k4Olc3NxLfeHHQUYnEETOWmKv7dr8bGfg3M5wtgqbOWUXotT5p
 3jq/Z5dRenVC24ypzoTEKsk9IbNqC6Db5/KhkiaN1WrFzjGsDRHIA7THIaK+Z+5UwdCx
 8lxUkat1lX1yqnDLfsTffL2QXDdZd36kZt+XkYKaCHRX1+gb2lCjxuY5k4Z6Q3Hol2dH
 aUWK5mxDQiyr6iO4p9cn2FGbDFjmY5gT0VHOr4TU4bbLl2JBpWB6EztZiUvR6kTCydO+
 xcqA==
X-Gm-Message-State: AFq9FYKV7YKHtGqKz3ZIvqrqjnDuA5qkOEzFJvB3xLEFkv9WMoiyalLp
 ueZCUyfEqzPT7Ntg82aoKHQpNjFWhvSvEbGjyTfuL5SR9NJ29zRQhg8ZomN0fHheV/xqFiFl3Be
 fVh614rVlmOWIpMjEGkMU3kTyTlybP0diTzXHFwzLrZRruEQw2egW/Yjdxw==
X-Gm-Gg: AYBFou0NB/9sPdCX+5eEzsau9CHVIArFVGmk10LPTcfaUDJgo2hQuIQukvx2i/Jwqik
 /5QSzmpZqPEhtODG18225FUaGGOp4KTBV7+byqCfvHnMyoTJd03ZeOShxj96mkqg3Pr6FEx0TQA
 hjTbNPJN+iAVsvoe0fzxKQWfppnTsBoOM0SlAyW4SgbH7/x7SKKgiih/nP2BHjl3rLVTb+qgoDq
 g4Gpfjo2TppWDGMC3QbZ4M5dFBdux1j4MD9L2wDl4E3NwIsPRmVt8YiKi5VXebMJ95VO2GIIjqZ
 C0ynx6yYPtsVOAJAijgBf7i7kZFyr+3el9F53xRhFrTA2QE/DUC8kOk7+UBiBLPwsfe1pvOEmwv
 m+MGpUlyLnwLWNKf9naqLitYwrMkNsYGAP0eiewm/AkARsH+ZE7TDOINNusENoyywqEkWGA==
X-Received: by 2002:a05:693c:20c6:10b0:365:d42a:f415 with SMTP id
 5a478bee46e88-365d42af6f4mr522235eec.12.1792436696971; 
 Mon, 19 Oct 2026 12:04:56 -0700 (PDT)
X-Received: by 2002:a05:693c:20c6:10b0:365:d42a:f415 with SMTP id
 5a478bee46e88-365d42af6f4mr522201eec.12.1792436696402; 
 Mon, 19 Oct 2026 12:04:56 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6ca5sm32266574eec.9.2026.10.19.12.04.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 12:04:55 -0700 (PDT)
Message-ID: <81cfdf46-571e-4810-b0cd-bf842292e177@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:04:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] hw/i386: ELF endianness fixes
To: Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
 <20261019151233.230172-2-farman@linux.ibm.com>
 <2be3455d-929e-46de-864c-09675ee9c71f@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2be3455d-929e-46de-864c-09675ee9c71f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tNYXfZ5KX44oIeepaqHuU80nCbQldUyo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NSBTYWx0ZWRfX0KxKm25W8C2N
 gBZNdfgXt9sREwL1u1uuf2BwINC9sIe+nIYzPgdHxHudPox/PZ0TANrYngWUwdoLfRAnr7vgxnT
 8bjyrGCV423h9OgeGa/+qE1ZDLkKsDJcMuD3LYBrmq9RRudLtpnWDIp/13W0g/JiZ3S4R4jBoG6
 RkyI7LSwDm9O1DxDJzDTIhDoIzfEInFblHjMEcZotyrF9zdB7ihRwyCAuBoYvfpzzxIoTgawItP
 clIYJZUPhvIndPjiNPGgvreGDI1s1o1sWWZHsSCZuAsxAsLdElrDIT+RCKKnH++Y0vWj9TT/Vz4
 VuT/Z4StlYtDnz5ZYsBXXPRsQY+ql6yAMcRIBOJGsiWtm7wkMdm0xPOHC1memIkstQzB4mjMxBC
 PpqacjPw51gqN08XPWa0PHYG8Tfy44z/PPajiauAwR2AZGw3M3DDk/k8YySG/omgABl7m2bCj/X
 VCgunxf5F7TPMD3nkwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NSBTYWx0ZWRfX8fJjbb23+cEr
 jPkuhZkFRQAatJKjWxrQuO7382LouiaZ7kE/IJHNJvFWwcb/RU8kXCZ5Wbr3UgVl/WRVunVotWG
 1spxjgZOoP1vL4GM2Ze3Qa5KxwCqbos=
X-Proofpoint-GUID: tNYXfZ5KX44oIeepaqHuU80nCbQldUyo
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad669d9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Wo-anEq9gCjtSUVyRZQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/19/2026 11:57 AM, Ilya Leoshkevich wrote:
> 
> 
> On 10/19/26 17:12, Eric Farman wrote:
>> Running make check-tcg-x86_64 on a big-endian host (e.g., s390x) fails
>> due
>> to problems reading/parsing the ELF data:
>>
>>    qemu-system-x86_64: Error loading uncompressed kernel without PVH
>> ELF Note
>>
>> There already exists logic in include/hw/elf_ops.h.inc to handle byte-
>> swaps
>> where necessary, but it does not perform this logic for ELF notes itself.
>>
>> Fixing that improves matters, but yields other errors: most of the tests
>> timeout while some generate confusing assertions. Both appear to be
>> related
>> to the data addresses in those notes, which are incorrect when running
>> on a
>> big-endian host.
>>
>> Adding tswap wrappers, which will conditionally swap if the host and
>> target
>> endianness don't match, fixes that such that check-tcg-x86_64 runs
>> cleanly
>> on an s390 host.
>>
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>>   hw/i386/x86-common.c     |  6 ++++--
>>   include/hw/elf_ops.h.inc | 20 ++++++++++++++++++--
>>   2 files changed, 22 insertions(+), 4 deletions(-)
> 
> This looks similar to [1], which I've been desperately pinging for a
> while.
> 
> [1] https://lore.kernel.org/qemu-devel/20240929180659.3598-1-
> ardb@kernel.org/

I'm not sure if that's the reason, but I noticed that the (common) email
workflow to add people in cc on an existing thread rarely works.

I suspect it's related to the fact that it's not possible to have an
email filter/rule that modifies a whole (parent) thread from a given
message.
In my case, I end up not seeing those cc most of the time, simply
because they are drowned into the noise of series for which I am not a
recipient from cover letter, and thus that I don't read/follow.
Or maybe people at the time were just too busy.

Anyway, there is another chance to review this today, and Richard and
Paolo are here also.

Regards,
Pierrick

