Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7510606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S2FZ6nY5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YJHlNcv0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJLFP-0004YJ-1b; Tue, 20 Oct 2026 21:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJLEu-0004IC-Bw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:35:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJLEs-00039x-9N
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:35:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtcS33818474
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jqeZauEXIJyA3Fp2aygjS9N9Y/JIRfcjRQZIpQS4v2M=; b=S2FZ6nY5NDUyYT3X
 k/IcNRc9N7lbgppnY19WsWibGqcbuSscuPB2UWO2oO7F94Vr4lDg/untKYA2oYjQ
 BNGd6Gz1khEPkvcQM6IJAZm3a1l8+iAcP24USJahqd9UTCFnMzbNAIARyIiDqweg
 RqqZ1kwBitZ1aM9MAgg+Bp8xXaa8/E7mzeyZqstqmUI9KYrcNKqpUGq4A25ogvF6
 K0M30XPcRl1Aqxwa64G+6411JeLEp2SmPAch59oLtAAUvwvEOIcHLiBPYQr9rju+
 307+KeAYR8fA+KjjYJfJMpb2q8NzBsSoVVNqThY0Ly6zA+LG9JzcUNk1oWLepwCI
 fiQF9A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4sb05-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:35:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso480762a91.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792546532; x=1793151332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jqeZauEXIJyA3Fp2aygjS9N9Y/JIRfcjRQZIpQS4v2M=;
 b=YJHlNcv0ysj+qiM7+IXNn7jiCZAur8dIzBj8yzosJUdvKoIt6HuVAwJi4ivqBVhWTX
 IDuMklXxydiFn9L2ZOCfe0YKX5V+v6IsnL0D+TAVuePYZWrEEBXvOiBfvrt4Wjl5HgU9
 sZXdiiVe7z4XYitWHtxBlhoppursLkjkT8QcQLhjpVBVxo0RF7aYQ863vc84yl+BRqXG
 ZgNQsAk/3tiKFGVVaGZBgv+ccompSscJNv0B51ShW/TLUnOoGhfhyL5y2C+v0CGDrs8x
 zeWJak41oWett2+1qzbRExzeRAf/3m6VoCm0l1tJdLokZZwpF86aJHsTvrfAuouf2/bn
 uzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792546532; x=1793151332;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jqeZauEXIJyA3Fp2aygjS9N9Y/JIRfcjRQZIpQS4v2M=;
 b=TvZtVt3VunP5y1dfVtGhzaR37B2IK8jvaQF+u7EJJajIEukBLwJvbxz2o5EldQ8JET
 44KvxjDVyWvvOuSMn/+ZvP1eAe2xdS0ERyGqyWkqEk3zbVO7pyqDPVn1vH3ZIqiKRFbP
 ujiN1ZLtVFGarRY0pt2yHWhs1ZbBcf6jzGNmzCACXx9OM94TeRuXQLViO6LQLUF+nrgi
 mNxcrg+VTccJna9JhS21JeazewtoPwmWuFD/golPsaClY2I9Pvv0mBOvwTz6V7XfmlkE
 wnX00Jg698pfiai/6N5PRo4gh1ZFVrJ0FtmW/KU2+3FA3gRruyRDfA4QFmaT79ESC2D2
 x6bg==
X-Forwarded-Encrypted: i=1;
 AKwUvByWXOS2a0UpPFU3VmryEwxhbc0fIWWGiZtEaQPEhxZbdxJtf8GWg0b/npI7gVEBM+LRS9w2vbQl4AI/@nongnu.org
X-Gm-Message-State: AFq9FYJdKyhTrFeuhcpGHBnH6D32V2DrbgMeb0s004du37xiIp0fpLRd
 QoI7hNLGRiQMiYoN5DP+Dc/AWXemA7Odp6Oq0s3dIQzOkqNR8xic3kEXeRRGHC9Q5JQgXRi4oON
 YBiCZ2hnvEVPTpjYoVN06IQSuUvZlx7cauihx16rHW2ek2bpvAscFJfOQsQ==
X-Gm-Gg: AYBFou2n56+FczvrFegSj4VzfBd37tVGfkZo1ANFOGgNTmppk9IP994l/CCOgG9rvPv
 ufodoioeNJfSMWFGDJ03CTyibnUSaB4ieiaWzHUrUHbS7uFh+wDrYCIE43LZJUEbj3WRUEbX7oR
 STnijcKM429mQdbmqlepK+jgxrHtznSCnHiXIvd5clrVmlrgSqzGKu9TQ7L6Q50E9ufkg0LPkLN
 Hg5Y12zamRpEOIe3S4meJctO5z3kGH/PWfFKltdcbSZ2unvGE6mjHNe7DnfAbAMm8Cs4+FML5pK
 Fn6I2pLkeoyeE8fab9mnIH/0mRLENm+BuOpmFmWbLYTS+8A2TxPxvJZMuN3YmeBo7BsyBzQ/1KN
 asVFv/9cB+5hPhkr/UrLRIQNFb3dWepg4fWPbLeac2LZEin4z57cX4pUV
X-Received: by 2002:a17:90b:4483:b0:3ab:be66:ddb7 with SMTP id
 98e67ed59e1d1-3ad86f7a6aamr547752a91.47.1792546532124; 
 Tue, 20 Oct 2026 18:35:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4483:b0:3ab:be66:ddb7 with SMTP id
 98e67ed59e1d1-3ad86f7a6aamr547726a91.47.1792546531569; 
 Tue, 20 Oct 2026 18:35:31 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad8021d29bsm1767677a91.4.2026.10.20.18.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 18:35:31 -0700 (PDT)
Message-ID: <afdaf602-42be-4178-9638-29d587d95504@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 18:35:30 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] target/alpha: Register CPUClass::exception_name()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-4-philmd@oss.qualcomm.com>
 <d994b82d-391e-4d5d-ad6c-faa3a1a2fe8b@oss.qualcomm.com>
 <4adf8178-fb5d-4d45-982f-43e30be3c801@oss.qualcomm.com>
 <f122a975-7f6c-48c3-9748-2a42026aa210@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f122a975-7f6c-48c3-9748-2a42026aa210@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: URcm-k8KEqHjf4sHnlS6feXd8-Xz3UY5
X-Proofpoint-GUID: URcm-k8KEqHjf4sHnlS6feXd8-Xz3UY5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfXyJz3wMGcIIKh
 p5MScXZoUqAc9MSVhqjtTMSlXDlWFMthU+xL5ZYIEMaM/KG9VF2APBaFquU1Ht0pLUiTwN8Kgyq
 q3097j8GmhF3USnAdmSTyIC2RG6k3O4=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad816e4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=C-wAdP7ueti1xJikSDEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfX9Li1y/QKKm1q
 xlxDgbYzWpqx9Mt2WcP+OMxAFI+WS4QjmL+Fta6i3XWX2g+tuvO6HnPier97n19dg6yn2lULUFx
 B2Z6Tar7Y4aENoJfUavm71CwBOBVIUlImtmFOwgvgQBPohRRkqzgXcg/62XRYNBea1yC53JnPVD
 RfA1dGQk0bCJgSgPqCoNqFHMimXyjlzLEty3OBkBrTnfll7YcTb+JwN2ZaKss0CymkpESC18UGj
 TssgAIVuyTX8BHnm8RcX4kQ8BSzSSUyTQq38H/h8NCjYt9nVjIGRIljlFuLMrj9SOoshGlb22zd
 SzIdE+QQBkMnC9hC/i33tj/DMh52AWYSPcNEfT38O06XCoI+HuEeNfLMarVD3lJh5Ia5Yitg1Id
 VeSMuTwNuYVO+OYDBwwV6z1o99OmxwWwWAEG/jDtsI6XFEhvZ/aXlTFEdXJeueAKHptMjbeNAjm
 f6gE0vRWGKuI5LM6uWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210006
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

On 10/20/26 5:55 PM, Philippe Mathieu-Daudé wrote:
> On 20/10/26 21:15, Pierrick Bouvier wrote:
>> On 10/20/2026 12:05 PM, Pierrick Bouvier wrote:
>>> On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
>>>> Factor alpha_exception_name() out of alpha_cpu_do_interrupt()
>>>> and register it as the CPUClass::exception_name() handler, so
>>>> the common exception logging can resolve Alpha exception codes
>>>> to names.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> ---
>>>>    target/alpha/cpu.h    |  1 +
>>>>    target/alpha/cpu.c    |  1 +
>>>>    target/alpha/helper.c | 82 ++++++++++++++++++++++++-------------------
>>>>    3 files changed, 48 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
>>>> index 378bd96d941..8f780502476 100644
>>>> --- a/target/alpha/cpu.h
>>>> +++ b/target/alpha/cpu.h
>>>> @@ -284,6 +284,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
>>>>    bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
>>>>    hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
>>>>    #endif /* !CONFIG_USER_ONLY */
>>>> +const char *alpha_exception_name(int exception);
>>>>    void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>>>>    int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>>>>    int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>>>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>>>> index 12e86021663..f9936315fa2 100644
>>>> --- a/target/alpha/cpu.c
>>>> +++ b/target/alpha/cpu.c
>>>> @@ -283,6 +283,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
>>>>                                        &acc->parent_realize);
>>>>    
>>>>        cc->class_by_name = alpha_cpu_class_by_name;
>>>> +    cc->exception_name = alpha_exception_name;
>>>>        cc->dump_state = alpha_cpu_dump_state;
>>>>        cc->set_pc = alpha_cpu_set_pc;
>>>>        cc->get_pc = alpha_cpu_get_pc;
>>>> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
>>>> index c3614ecafda..cedb0006892 100644
>>>> --- a/target/alpha/helper.c
>>>> +++ b/target/alpha/helper.c
>>>> @@ -35,6 +35,51 @@
>>>>    #define CONVERT_BIT(X, SRC, DST) \
>>>>        (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
>>>>    
>>>> +const char *alpha_exception_name(int excp)
>>>> +{
>>>> +    const char *name;
>>>> +
>>>> +    switch (excp) {
>>>> +    case EXCP_RESET:
>>>> +        name = "reset";
>>>> +        break;
>>>> +    case EXCP_MCHK:
>>>> +        name = "mchk";
>>>> +        break;
>>>> +    case EXCP_SMP_INTERRUPT:
>>>> +        name = "smp_interrupt";
>>>> +        break;
>>>> +    case EXCP_CLK_INTERRUPT:
>>>> +        name = "clk_interrupt";
>>>> +        break;
>>>> +    case EXCP_DEV_INTERRUPT:
>>>> +        name = "dev_interrupt";
>>>> +        break;
>>>> +    case EXCP_MMFAULT:
>>>> +        name = "mmfault";
>>>> +        break;
>>>> +    case EXCP_UNALIGN:
>>>> +        name = "unalign";
>>>> +        break;
>>>> +    case EXCP_OPCDEC:
>>>> +        name = "opcdec";
>>>> +        break;
>>>> +    case EXCP_ARITH:
>>>> +        name = "arith";
>>>> +        break;
>>>> +    case EXCP_FEN:
>>>> +        name = "fen";
>>>> +        break;
>>>> +    case EXCP_CALL_PAL:
>>>> +        name = "call_pal";
>>>> +        break;
>>>> +    default:
>>>> +        name = "<unknown>";
>>>> +        break;
>>>> +    }
>>>> +    return name;
>>>> +}
>>>> +
>>>>    uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
>>>>    {
>>>>        return (uint64_t)env->fpcr << 32;
>>>> @@ -343,43 +388,8 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>>>>    
>>>>        if (qemu_loglevel_mask(CPU_LOG_INT)) {
>>>>            static int count;
>>>> -        const char *name = "<unknown>";
>>>> +        const char *name = alpha_exception_name(i);
>>>>    
>>>> -        switch (i) {
>>>> -        case EXCP_RESET:
>>>> -            name = "reset";
>>>> -            break;
>>>> -        case EXCP_MCHK:
>>>> -            name = "mchk";
>>>> -            break;
>>>> -        case EXCP_SMP_INTERRUPT:
>>>> -            name = "smp_interrupt";
>>>> -            break;
>>>> -        case EXCP_CLK_INTERRUPT:
>>>> -            name = "clk_interrupt";
>>>> -            break;
>>>> -        case EXCP_DEV_INTERRUPT:
>>>> -            name = "dev_interrupt";
>>>> -            break;
>>>> -        case EXCP_MMFAULT:
>>>> -            name = "mmfault";
>>>> -            break;
>>>> -        case EXCP_UNALIGN:
>>>> -            name = "unalign";
>>>> -            break;
>>>> -        case EXCP_OPCDEC:
>>>> -            name = "opcdec";
>>>> -            break;
>>>> -        case EXCP_ARITH:
>>>> -            name = "arith";
>>>> -            break;
>>>> -        case EXCP_FEN:
>>>> -            name = "fen";
>>>> -            break;
>>>> -        case EXCP_CALL_PAL:
>>>> -            name = "call_pal";
>>>> -            break;
>>>> -        }
>>>>            qemu_log("INT %6d: %s(%#x) cpu=%d pc=%016"
>>>>                     PRIx64 " sp=%016" PRIx64 "\n",
>>>>                     ++count, name, env->error_code, cs->cpu_index,
>>>
>>> Any reason alpha can't have it's static table like others?
>>>
>>
>> For rx, it makes sense since exception index list is sparse, but for
>> alpha it's not. For consistency with the rest of the series, it would be
>> nice to have this under a table.
> 
> I tried to keep the refactor to code movement, keeping each subsystem
> maintainer style. If these patches are correct, might I address your
> review requests as cleanup patches on top?

Yes sure, it doesn't change much to be honest, I was just surprised to 
see a switch used for this target.

In all cases, it's just a style thing:

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

