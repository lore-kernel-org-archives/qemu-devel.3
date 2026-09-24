Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F09C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rIH-0002mJ-BX; Thu, 24 Sep 2026 17:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rIF-0002lv-HY
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:47:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rIC-0001ej-DD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:47:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdp272996587
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Auxxcg/ARS6AYfV2hi0+je6Se4/SSRep/fXN5YqUanM=; b=IGxjZ6VZoqQCEpfg
 sJ7zq0X+XOI+WrJGK4z951DWFqCWbcvUI5hBoL92xKISEQIm8orwWxDf8kHxYYah
 711qbuWdHO+K7MR+b6ujbAO+gCfhYzF7XRBoKUsdi2yen6fUDOrXpkT2gdAImzeZ
 f8cIEBtdn3h/hHD/i3CTM1SMkmL3gd/WecvMyYr7vwhhGSAd0+fxNMC3QiZLC2uU
 XTSgT8Gw51o03Us3wQMOwRtAoOYDgjjouk6MNC1YKoeX4dO7EoT77xLGK0ttbjvn
 U6vrUl7+x9m+L3QfhQaJE/QvykvsWwFNThV6sCgu19EajbWYSkm6mT6y1rlYJp5h
 rdYG6Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw465264y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:47:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d6fb956002so2415885ad.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 14:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790286465; x=1790891265; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Auxxcg/ARS6AYfV2hi0+je6Se4/SSRep/fXN5YqUanM=;
 b=RAutprQg/mP/oeCt1bHVqrxnXYTeuD/hrIPxt6CBXDnRxNFvQnSZN+kuIqVs37if2x
 8Uzi8GttrGGjXsu0GovPcgBbJEuS8EiYnAo/rfyztCgoaLjUnxGmU/d/+VDw02ssNtoc
 I7CtlQe5cAslAUcYU1lY/RAIPhXfEhwrT9fumXzd+/0s8M+34AAjIsO3+Si8XAx3Gh2X
 y/s2eH6xIE+6EEKTAfghwtZAG+JkHPiR1SnHJB6HufnSUOSmJARpI2oi7ze7BGXdNBls
 Cx+3Q87xa9m+cWu2pNDtn/VRrSLVLS90ilmwL7lwuQw8eSjaWy2dnK/pnvimb9/9dXRt
 nSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790286465; x=1790891265;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Auxxcg/ARS6AYfV2hi0+je6Se4/SSRep/fXN5YqUanM=;
 b=otMi8TIsd//DyF7CNsZjLFSJ22dyIXL+ATH3VP5Bw0ujYN7M++0Am2kp2hIF8ZC61S
 6f5is1+9IZy8kxxf+roo6an+/ufADz6UOqA2dNII2TvcW6eI96xWgBtHSNRbNFDISrOO
 A3oKIUyJgqZ6MBPYMT8n9VZeUe/9+LdO2qolZp8+azYa/25kb6QLJRLHTHKzevvmUBjO
 RhiB4DHb23jm1udYPmYIM6ymWU6j99GxwkyjYoLl9+WTnQfCZbWxjNUzdM2KCTnOo2Yo
 jlbN42LiyTEYnHPgyosWX6geiAACcWlxMKxQiaPUW4/HfqZLM820jpIg2KBNSrSvzf8r
 p0Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpXbjn1XII4xbfePi2kMhDeOSYHqaTjNHuijamnQJevLdomHv320EN90selODFUPfRI+g6jKvT7CIW@nongnu.org
X-Gm-Message-State: AFuF++m5eUUbACX05jAN39ivNSz6ZHMy0NMSZBdajPGtLCYGvqvuv+Jf
 mEMphsN16BE/5ktLMengsPnQevbbIF9zbnCKAehehIgp0kdaqMbqujxGN6CVuZX+hKlUEuwnIJf
 YBZwb5LXvNYMiFR5WOQaveI1dXBz/LwxFyJRMJzQpmzlqGYkZKD0BmFE6rw==
X-Gm-Gg: AYBFou08H6QxtCRUMytb1uIYKGnIKpP05tJadePaOSx6PvYju41vx/fBBMZw9QorOVH
 Jh2tV1t7f0im5RR/2WdxRqR/fWpuQMZh2YKzDr3VHPIIxF9tT3hxN0SuCJnEqyDPvGsU0R2nazv
 3rQ8zQlKHsDhGMA/nT40GG6xP9tGLTi7p1TJm2/N91hqPS3bXdqKscwSva85W14dWWyyyiZUDhB
 EM5RzzUHIiWhzi/ySZNP//wxjG72Qbm0vuGWBV0Rg+7/sGqHRl8sJPDe5Au+VOXcPHm8fLSLgyW
 OHi9uYXWZLDkMHwyhocLlRpe6yHgEDhfnamMtYiHSlhrXx/4uAdTJWe/Q2o6M9fwjSYqJNII3hR
 T/pjC0BX2/1zrKjgzzhc54/FEhkEfw9J/kIJpjQ+l4rNGWpTKXBODZ31qFp/Sw4pDuOw=
X-Received: by 2002:a17:90a:ec83:b0:39e:6c6a:4b77 with SMTP id
 98e67ed59e1d1-3a098e43948mr2914591a91.65.1790286465475; 
 Thu, 24 Sep 2026 14:47:45 -0700 (PDT)
X-Received: by 2002:a17:90a:ec83:b0:39e:6c6a:4b77 with SMTP id
 98e67ed59e1d1-3a098e43948mr2914577a91.65.1790286465014; 
 Thu, 24 Sep 2026 14:47:45 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b998e2bdsm582368a91.13.2026.09.24.14.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 14:47:44 -0700 (PDT)
Message-ID: <0b821f20-6674-4ebd-8df7-1f202dc06994@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 14:47:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 091/105] tests/tcg/x86_64: user tests
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Laurent Vivier
 <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-92-pierrick.bouvier@oss.qualcomm.com>
 <935e6ab6-5f86-4f1b-80ae-42c7219eec46@redhat.com>
 <5f719ab6-442a-4eb2-90cc-0475016a816b@oss.qualcomm.com>
 <3ea1a277-f291-4824-8969-1cd9784de1fd@oss.qualcomm.com>
 <54cb4411-70f2-4443-b96a-38e4891b64f2@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <54cb4411-70f2-4443-b96a-38e4891b64f2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab59a82 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8IUPdd87i_ACJ3aOz6kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: KVdZzJXBAz1HjIffc5xvXtpRcPBCI7I-
X-Proofpoint-GUID: KVdZzJXBAz1HjIffc5xvXtpRcPBCI7I-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX9Y307BOyxOUP
 iOfd6FKhXwqFG2+OEGtc6m/kZZpFYRAJmNdOH847kcTbeyTMaR//3d+ZmtnBPI7uYj8Le9pCXUv
 /klL+tJMRhchaxxCROhHhlHD+5qYLacksjdQ3x+fIC/ZqVgpEO+IJHLB6ZdGiFCZK0bzDmW4lBR
 wwF/WZjGMGdf7a9Hsc80rxfYRhvgb63icS7kljug5wzUCCbnXSMIIJnE8yZYzcvwaVidC3JcfP7
 hvD139H0ALaPkE3XOyRhvRkCA1L8s8wIaGH7hI1XF+FkJVAC/oLz0kWiTZcDOlXdPhB//pWFjuh
 HIu8R7v9EeSSqiTQVoSgA50oCg5wckSTwcPwmm1sv9xUrBV5hIoc4+Nyhc4TQ8vEBVfw+dSjzKf
 QAbAPnpCSb3SNo1EFOW21ms9e393YZoQ8wheUIy33XwnJPcyq5qA8jt9XziCuc952ARjY1FDOKV
 LO+7EyB8G7ZZyNl1gjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX7nGNqoRpa7AQ
 XBwLU88Lm0kKZfRiYzyELV6vjGSquQaN6C9xR3G1JU6gZcLZuZoaIvZhzwQ7l3QvSHo4YttvBpV
 2OWGbj2E5g7vojaHvRnQjHIX15y4f2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240088
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

On 9/24/2026 7:29 AM, Paolo Bonzini wrote:
> On 9/23/26 23:17, Pierrick Bouvier wrote:
>> What I proposed before (and let me know if it would work for you), was
>> to add cc_extra field as a list of compilers, and so we can cover names
>> for at least: debian, fedora, macos (homebrew linux cross toolchains).
>>
>>> In all cases, I can see to restore this behavior at configure level by
>>> setting --cross-cc-${arch} automatically based on host arch, and if gcc
>>> is installed. Would that work for you?
>>
>> Let me know if you prefer the option above, or just an additional part
>> in configure.
> What I would have preferred, is to leave the code in configure alone
> until its replacement is functionally equivalent; there was no reason to
> move container creation to Meson in the same step as the TCG tests, and
> "tests/tcg: run tests with meson" left out the rather important "... and
> kill a whole multitarget compilation infrastructure that worked".
>

I understand your frustration, and it was not my goal to break things.
I hope the advantages (syntax, correct dependencies, redetection at
every meson call, and builtin docker dependencies) are worth the trouble
it created.

> Anything that more or less reproduces the pre-existing logic for picking
> the host compiler, and has a  1:1 replacement for "make -C tests/tcg/
> x86_64-linux-user", is fine.
>

Please take a look at:
https://lore.kernel.org/qemu-devel/20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com/T/#t

I tested it on fedora, debian, archlinux and macos, for x86 and aarch64
hosts, it's solid. Also, it covers more things than only configure
solution (system tests only use case + macos).

Please note from cover letter that it's based on another series, so
don't forget to apply it first.

> Paolo
> 

Regards,
Pierrick


