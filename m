Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406D1CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqIa-0001SD-04; Mon, 05 Oct 2026 17:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqIX-0001S4-Kn
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:32:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDqIV-0001t4-Mx
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 17:32:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695KMeiC3967439
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 21:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JqIvNeJo1TRvmOA3Ji6HptxJEvMNpH8HRbQ9HYZMwRw=; b=ILVKdXW5tf3z+6vq
 HYI9zjSc7NxTvnFbhC7TNdgRaJXdUTJ8d1PCAhSDNKTr7TzzTWP3PnrxlUfWeS1o
 WdnNIvLl8gLDrJ6O1g9lxp3qFMlxinluuEkhrAl50fYp7js2/eZUmLdVnYqxDXJf
 3qL1AlcVCVNpGDRKj5g1lkNfm4WPWmcxvSaMu/Ms+BkgcTjBLJYrTi/gTjmijyhh
 jIIGhzlkwR859J5re+WCqPdxzoopH89hZRQnjllf4Mf3ljICdTz26UIrbgQWje7X
 ik23v7lGYrVNlcAgbK864yFiHqb2zg55HkHxSpWY5ljalVbp9lZK75kkyuHXZKVZ
 m2RAvQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cuu1sd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 21:32:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2468936eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791235953; x=1791840753; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JqIvNeJo1TRvmOA3Ji6HptxJEvMNpH8HRbQ9HYZMwRw=;
 b=WA2lk6cZBh1Mj0ec3UKtkrs6ooWN7J1G4qMHfgzw9trE804RUVkNWT9o/nLpnb3FKb
 +5Dj4Ev5ehzHT5m8z3oIVDEZmf5Sf2Ylf8CqEYaqljdieUvjYrCT99CxRYLe45MN2Def
 Fsfv1fkGz+sofcnKUnpcDMFIuF8N0cXEaQqCoDha5mwrKqgcKxe2lkYYMVmUqMV0LaBe
 XFpDHTvx64O4LZJA33a5BIL9lfTs6ix2PnvcEgdyanMGk2MGYUb/pkxGYa6EKbwfxR/4
 gSfxs4dlI/MTtaedueRwnwU/+c6vTlb40Mh9bZr3EJAtNGNXJrMFKVE+zQO9uePvNFoM
 Mx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791235953; x=1791840753;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JqIvNeJo1TRvmOA3Ji6HptxJEvMNpH8HRbQ9HYZMwRw=;
 b=KO8ZpEbC9zckVq95Iv9Fh6UXnge0I5XA5VMcesiivptRTVleHO0NMXq25VcDUKxZtL
 YUqSbNyEXfG6SooElAbkrZFE1dmh6VHgLLbPARttdguvGJR4hXuPa+/pB7+q7EpITM91
 06QLuq4+Nwnx8tindLnzB/r0/rjroL2uG5wKasknFcp7w1TD95QDV8HfAapxkPs0nMRI
 sjEpTfqwQMHRwJk5dVivfGi+/dEIkMEbcKEsBCXw4+ZACcLMhV2Xke92/2OK0Ktkrgr4
 uW10fpLe5kfenm+xxfnsxg+ZKiGG/OTpZ3toXR2J4O2LElu/6oHR/KYNy6VS2djbxtWv
 EN7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0r01xTtj5EZE0KtoOBqctUYWZ0eUgWvpr3gGCt9hzj30WRHNPPxMFwsA2US27yekzbl61ZcKVoPBE@nongnu.org
X-Gm-Message-State: AFuF++ke1bS4AnE4lBDcNUTvybnaedBEyQ6t06k85i0NrCNjfIKLRq1M
 1ejolIGpQFEpCUexOnuX2ZdHMtR4YwkU76g60a8oMw6yYg8aDFeCM0BYADglGFatAzrFzZiYEeX
 4R+aWSqmuJscL1ca8rTsPulTUoVHX5gybYLi2uLYh6HBxIF0QphzYtuObGw==
X-Gm-Gg: AYBFou3TRnGsHQCjEcRpNnb1nP7qsqHWKTfrxMZQftColynfpdvBKnTkFlAlodNY/Nk
 KozsyZ8osoERnhG0XBQQsQZd9wEjMFOsQlVdZzfsBxsplRb/WL46mczndGuh/vAcBKDTQ4gItsa
 efYJEyB2NVk0HLEZpI5vA293uT7kaqhWIzHUn/e73S8rHhsbCaOlMibxm1tgWGPJeAO5/W5hWtA
 UiXvpDN3BBmcT8wLcCQYsJHjLhVfgPtEw+/9y5GEjMtWr4Kp0+hYtKTChZsJ5/tkkD5xqdUpLNx
 7MpJfL1h+Ts4Byo20ifn0qSVoGoNMNlMA0im//DAKyMmlG+AT5QS9Ejo9l0dXBaEkg/ekLIv8pS
 BF7Mxhll9mo+QzjfPxUcMIfzPo3T0Mkmx/Py9V7anG1FykCP0DCT/RDgoJiFA0+DRgSb5Pg==
X-Received: by 2002:a05:7301:4246:b0:351:1f6c:2a85 with SMTP id
 5a478bee46e88-3511f6c2e75mr8210622eec.14.1791235952543; 
 Mon, 05 Oct 2026 14:32:32 -0700 (PDT)
X-Received: by 2002:a05:7301:4246:b0:351:1f6c:2a85 with SMTP id
 5a478bee46e88-3511f6c2e75mr8210600eec.14.1791235951900; 
 Mon, 05 Oct 2026 14:32:31 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35146a4fde1sm935501eec.16.2026.10.05.14.32.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 14:32:31 -0700 (PDT)
Message-ID: <87fd92fd-395d-4753-b8fe-8dcab705cc9f@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 14:32:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hexagon: yield on system-mode pause
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261005194519.2945862-1-brian.cain@oss.qualcomm.com>
 <20261005194519.2945862-2-brian.cain@oss.qualcomm.com>
 <c87183cf-bb24-42be-a51c-d700ff6b8a1f@oss.qualcomm.com>
 <6c2b3716-e2cb-487d-97ec-af4951eaf8b6@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6c2b3716-e2cb-487d-97ec-af4951eaf8b6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX/q1ipMo3nyox
 PBp0q2qJuzOYAUiNBWSqGFAshv/EMqnfFpuBnxLjywYSgkrRXut4rkfIvFtBZGIaymmIkF+ZdMV
 O4ntY9gacVQ93ScxaY80lwUTXT3vCDo=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ac41771 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=EC9J58q6VzLsxnWW_dEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 3X8m7J6Za7ST_TEHDoGTbNm3d6W21Fsa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NCBTYWx0ZWRfX3LzZ2N5AeHfV
 rcjyirp7L8O98M1G7gdDF/SG0C0etImo+iaa7qtIWv5pLgIM5SVn6ByZGTCfIaQMpEE9EZpJVLj
 BXJkq2ciDAICreOoJLLQ9q6kB3IpiLeG3Jm571HfT+ru675qiJIyBqYd9JqoKEY7nWivIg90Cvl
 vajmUFumWO16pEFG2HOMVWgNCyUFCYFCv29Lnb4qdE9xqppfyt3K7vHuOSOfXR6tTlpAx5OJtQM
 d3VPC4AFal7K2jtjNDLOAC1rNlPUO0U0YRp2+uaM6yr6Gdg3nUisclsSya3+OM0Qg4cRceJV2qG
 tL13cS6MUrs5fsr2ZqPweYqiphUeq/c2IrH45b0YVoRYVhP4i326C3Ar3wnllrjt67j8QqUT/Ao
 6Qh2J/5moqnLDy/ai8sF87QjzhrjXpw2GF/6eKX6+KEkpxdEIGrCaQYZZOfKnlAIV1Vl6d9dJOZ
 yl6eUlyfPT2n61kPbOw==
X-Proofpoint-GUID: 3X8m7J6Za7ST_TEHDoGTbNm3d6W21Fsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050084
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/5/2026 2:28 PM, Brian Cain wrote:
> 
> On 10/5/2026 4:10 PM, Pierrick Bouvier wrote:
>> On 10/5/2026 12:45 PM, Brian Cain wrote:
>>> System-mode pause currently advances the PC and continues execution
>>> instead
>>> of yielding the vCPU. Raise EXCP_YIELD with the next packet PC so
>>> execution
>>> returns to the CPU loop and another hardware thread can run. Keep the
>>> linux-user behavior unchanged.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/gen_tcg.h | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
>>> index 5f7df66ae67..80d8a7b6bac 100644
>>> --- a/target/hexagon/gen_tcg.h
>>> +++ b/target/hexagon/gen_tcg.h
>>> @@ -1125,11 +1125,21 @@
>>>   #define fGEN_TCG_Y2_break(SHORTCODE)
>>>   #define fGEN_TCG_J2_unpause(SHORTCODE)
>>>   +#ifdef CONFIG_USER_ONLY
>>>   #define fGEN_TCG_J2_pause(SHORTCODE) \
>>>       do { \
>>>           uiV = uiV; \
>>>           tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC); \
>>>       } while (0)
>>> +#else
>>> +#define fGEN_TCG_J2_pause(SHORTCODE) \
>>> +    do { \
>>> +        uiV = uiV; \
>>> +        gen_helper_raise_exception(tcg_env, \
>>> +            tcg_constant_i32(EXCP_YIELD), \
>>> +            tcg_constant_i32(ctx->next_PC)); \
>>> +    } while (0)
>>> +#endif
>>>     /* r0 = asr(r1, r2):sat */
>>>   #define fGEN_TCG_S2_asr_r_r_sat(SHORTCODE) \
>> How is this working at the moment?
>> In system mode, if a given cpu never really yield, a given "thread"
>> could keep it spinning with a busy loop forever.
> 
> The wait() instruction is the instruction that halts-until-an-
> interrupt.  That instruction has a working implementation already.
> 
> This instruction, pause(), resembles the x86_64 pause / arm yield
> instructions.  It delays a number of cycles (based on the reg operand)
> before continuing execution.  The baseline's nop behavior is arguably
> fine/correct.  But this behavior is better - especially for round-robin.
> 
> In practice, few if any of the tests we're running so far make use of
> the pause() instruction or spin loops.  But some of the soon-to-be-
> enabled tests do use it, so that's some of the incentive to implement it
> here.
> 

Sounds good, thanks.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


