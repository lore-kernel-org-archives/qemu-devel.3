Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B444FCCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHlUg-00055X-8o; Fri, 16 Oct 2026 13:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHlUe-00055O-MO
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:13:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHlUc-0007M0-Oi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:13:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE68nu2455291
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a0jC7HwUJwEvA1qIB69xUt2DGyoo6L3cNwsEuV6X/Fg=; b=QeBCe43ZPGSqOvCH
 ccdKXx8qG7KXxp8FV34Yr5jNKg3BezK+faJGrqNu5lM/oUv0TMHuXWtMWNRQ2fiD
 JEuu4xsSkb8gTO5H/YbxVqr32XSHzd4C07IkRtfU6FnMoUD9oKi8gik/LamgxX5G
 L6Ab6FkBgwgvGmtGBiVATmNCYazixXp/mUqLnZqJUdXtorpvvtFpM/eKeHC9FjtJ
 r1uZWlbLesFyfaiB3vQgbWcIneB+6LIy1ad53ljo3LYxH9VBxv6e0iV1Oxrv4BM6
 yQZB6bYWaU9R+GWPmlZ2PqZXS2EJPCJeSF8FLmi3KKXshePyvvP5PhQ0aaUGO85R
 Uh8o+Q==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbg5yt39f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:13:16 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1663fb7e005so115455c88.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792170796; x=1792775596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a0jC7HwUJwEvA1qIB69xUt2DGyoo6L3cNwsEuV6X/Fg=;
 b=N6FFz52SgYcF+Q7dHPjp3n+HZGy1SsJ/CaYsAGYtYeHfMN7WaBVUXu6pQkgBRojtat
 XsgtP3ZODyweXKll6KQiqMgoR0bF/MuFES782WhF7MngOF3zhCxJ/JM0g5jLzuIQAf0E
 DWiDi0OCySHgAI7jVUKDdwG3urvsWBG1wtyfvXyanEcvaq2oSE+O7QKAQ7M5dnyr6gl+
 O4YmXwFcmEd2k0/lbhNPw8EYUjmkKL3uN9Z+OpdANwF+hIsdVon6d4ZVMGAbZgU+W81M
 hAPA0yBEElQX2S5AdBK7n6ZURCM6gh/HCuzOOWW7fj/R5+bftnuWi0n1XIWauuS6Y0eB
 LA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792170796; x=1792775596;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a0jC7HwUJwEvA1qIB69xUt2DGyoo6L3cNwsEuV6X/Fg=;
 b=prmRjDdEtVj+PY3ofzGGsrPs0PoZi8L7OUftIKkBJH19FTvvdpekjbTcynCxjFMvk6
 JXjMJoeeDUol6WL/SZQRuoSS8pxcI9DWiyWFoAWt45xs/rZe+ud5b2fO9Bqr+DN2ZtN5
 gRsmbFGI4zCvzo6a+n7ns5yNmcHD89ntCFCWO3I3tA+W6jfay4J+X9lrorzIZBerMVU9
 RWvPc9JAl/YqkcJ7dfiGseBBHElEIe7+ALlTq4UtSmLyIzqwbbcobkZ3efNXxBPaaduz
 asosyCLz/HUV5ZWVdCwFmV1arGCwaH0oh+iM4JcgWJ86swg+93axl80hF8iwGOdzo5NL
 E0eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/o6mJ1XphQ/k1OpYX3LxoV0Xodsb2bNdWN64aZb1mLvBy0lVPMxPgnTGZ2TFYRtawbhPIdKDKoh9s@nongnu.org
X-Gm-Message-State: AFq9FYKsjVc4R0+k4eLdQW3lHwKbrNnr8srrhvtENn4qihsuZfHHAg6s
 pG4dbYgiXI2tPB7J8bU8QNKCXKNT/z8eux3SH8KJkmACkA3oRExFWlYjpqhKjyNfgd2zjwwodpn
 ffiFUwa0cWY1j0vVbDJFpLfQ4kLbijveLqYCmroUKR+ckLwLKNGdGOWiQJg==
X-Gm-Gg: AYBFou3JM2sWIS968C+xT+/J2M0GpMiW7zskzpEgowiweskdXO1YXYSwLXB3K/R6BcZ
 kDzHMmbefznSOpva1A8W3z4xa0QXkgrh2vpemgJoWVNX2sLHd2HvhEz6r5YIDkfH8+ugaMiEdk1
 MWBCWvqBqIaB4pwk2V7/WNgGblYkYjtkCbHNqJcMSCHROPAKfQtdF7oAg1KqL5b13yrDdhAJzA4
 M64rad6+M14uq95cMt+S3Zv5uCzQpWaQzsdzv5p+hFGANe1CgV54SPVLDsIWhSGJ01NqSzatR9t
 oMr5owEBipVGaO8PV5oD2N+0unfmyyy3CYL9pUAcr6ld/gZwmfSx+MRnrPq/6FqiGuqCtUAl5/q
 IOT64KFe2yOAwSVG5wXNVhu6hgxHuAJyv/2sAZvw/x8xLIKFsXAISyIyXIRpJiMgTfBNx5Q==
X-Received: by 2002:a05:701b:4291:10b0:166:9e0d:3b56 with SMTP id
 a92af1059eb24-18513e7c690mr619601c88.38.1792170795825; 
 Fri, 16 Oct 2026 10:13:15 -0700 (PDT)
X-Received: by 2002:a05:701b:4291:10b0:166:9e0d:3b56 with SMTP id
 a92af1059eb24-18513e7c690mr619543c88.38.1792170794836; 
 Fri, 16 Oct 2026 10:13:14 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831996071csm7407890c88.9.2026.10.16.10.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 10:13:14 -0700 (PDT)
Message-ID: <b887a67d-322a-4552-8bfc-f4c8f84ed01f@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:13:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] tests/tcg/hexagon: add v85 scalar tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-13-brian.cain@oss.qualcomm.com>
 <14457301-e847-4d71-b4cc-3405e29b744d@oss.qualcomm.com>
 <1c6f9535-a29e-4470-8456-549ac6281b50@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1c6f9535-a29e-4470-8456-549ac6281b50@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tmzKc4djtDS1bA_bWF4PMC3f6gyWHLY0
X-Authority-Analysis: v=2.4 cv=M+HYuCws c=1 sm=1 tr=0 ts=6ad25b2c cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qgPwcASoYHlPFrXJPr0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX4xsWaK27aLut
 CiG1VTJIiqqREhJG9RmA7Xn4jsamdRKFtPMQ9SYiOD8QD1/oCJla1nofA319pUdcTcZCPMPmGJS
 mF1v+a76w5OQoVbt/sbwro+84XBVu6c=
X-Proofpoint-GUID: tmzKc4djtDS1bA_bWF4PMC3f6gyWHLY0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX8AYMXqig8DeT
 Eg8UmEOGXF3okSapkPCTzXW7TCVoplENdhRoF22Zb+sIcFaPi7Ikr8XGM2JmMopOPfXRjLkAyeY
 VRgLWelzHkgtpFbUqEsP9NHCS+8N8VYiEwdJiqpHKqmsb6aYvWEB2OlvHLVrdUq4DiTssY8KinZ
 wCu8dR9pQ+/EalJ0NZwjy0Vl8/ngnf9nlDO38Cfn2SnQHSBkzCzvNplNoymseVIg/q0XhCd06Dk
 +X+7q7VwmVV1ZR5xpPg1hSVERqA5RB3vraoaMM9WLI8P0wB8sjXyyC/llVHXWhA8ZjuOgj/EuR8
 UVMk+hUHdUisNUOj77ux/Wkuhd+9oSXU9KfCFBpVGMQxzgwBotq+RGLlJO8lYbaMXOrPmnKUFq4
 9fWhWlsVN4Jo6UFPfcDETxIPShpce+cAWioJa3GXvj8LP6pIccY6F2wzB++TI1BThJm3tjRjTgL
 Sj3cCTScnS+VMd+KD1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/16/2026 10:05 AM, Brian Cain wrote:
> 
> On 10/14/2026 4:24 PM, Pierrick Bouvier wrote:
>> On 10/14/2026 12:52 PM, Brian Cain wrote:
>>> Add tests for: vallocframe, atomics, trap2, CFI/restricted branches, and
>>> scalar fp instructions.
>>>
>>> New instructions not yet supported by the toolchain are manually encoded
>>> with .word directives.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   tests/tcg/hexagon/cfi_tgts.h         |  16 +++
>>>   tests/tcg/hexagon/atomics.c          | 102 +++++++++++++++++
>>>   tests/tcg/hexagon/cfi_user.c         |  63 +++++++++++
>>>   tests/tcg/hexagon/check_rev_gating.c |  10 ++
>>>   tests/tcg/hexagon/invalid-encoding.c |  20 ++++
>>>   tests/tcg/hexagon/trap2.c            |  34 ++++++
>>>   tests/tcg/hexagon/v83_scalar_fp.c    |  98 +++++++++++++++++
>>>   tests/tcg/hexagon/vallocframe.c      | 111 +++++++++++++++++++
>>>   tests/tcg/hexagon/cfi_tgts.S         | 157 +++++++++++++++++++++++++++
>>>   tests/tcg/hexagon/meson.build        |  19 +++-
>>>   10 files changed, 628 insertions(+), 2 deletions(-)
>>>   create mode 100644 tests/tcg/hexagon/cfi_tgts.h
>>>   create mode 100644 tests/tcg/hexagon/cfi_user.c
>>>   create mode 100644 tests/tcg/hexagon/trap2.c
>>>   create mode 100644 tests/tcg/hexagon/v83_scalar_fp.c
>>>   create mode 100644 tests/tcg/hexagon/vallocframe.c
>>>   create mode 100644 tests/tcg/hexagon/cfi_tgts.S
>>>
>> ...
>>
>>> diff --git a/tests/tcg/hexagon/invalid-encoding.c b/tests/tcg/
>>> hexagon/invalid-encoding.c
>>> index 639d7f24959..7c4dd244559 100644
>>> --- a/tests/tcg/hexagon/invalid-encoding.c
>>> +++ b/tests/tcg/hexagon/invalid-encoding.c
>>> @@ -89,6 +89,25 @@ static int test_invalid_nonduplex(void)
>>>       return sig;
>>>   }
>>>   +/* L4_loadw_phys bit 7 was reserved beginning with v83. */
>>> +static int test_v83_loadw_phys_reserved_bit(void)
>>> +{
>>> +    int sig;
>>> +
>>> +    asm volatile(
>>> +        "r0 = #0\n"
>>> +        "r1 = ##1f\n"
>>> +        "memw(%1) = r1\n"
>>> +        ".word 0x9200e080\n"
>> Please add a comments saying which instruction this is encoding.
>>
>> ...
>>>     tests += {
>>> -  'atomics.c': {'cflags': cflags},
>>> +  # The cross assembler does not know v85; v85 instructions in
>>> atomics.c
>>> +  # are encoded with .word directives.
>>> +  'atomics.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
>>>     'brev.c': {'cflags': cflags},
>>> +  # The cross assembler does not know v83; cfi_tgts.S uses raw
>>> encodings.
>>> +  'cfi_user.c': {
>>> +    'cflags': [cflags, '-O0', files('cfi_tgts.S')],
>> -O0 is part of default flags for tcg tests, no need to set it here.
>>
>> ---
> 
> ^^ will fix these in v2.
> 
>>
>> Overall, looks good to me.
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> I guess we don't have yet a public toolchain available yet, but if there
>> is one (even without source code available), it would be better,
>> especially for cfi_tgts.S.
> 
> 
> Yeah it's unfortunate - these instruction encodings haven't landed in
> upstream LLVM yet.  When it lands, we can replace these encodings with
> the real mnemonics.
>

Ok, I was unsure if the recent llvm-23 had these. No worries, test can
be updated later.

> 
>> If there is a v85 toolchain available somewhere, feel free to update the
>> hexagon dockerfile as part of this series.
>>
>> Regards,
>> Pierrick

Regards,
Pierrick

