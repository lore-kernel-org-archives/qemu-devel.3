Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E508606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LE5fklGw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OWfoXzdU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFJa-0006zu-TC; Tue, 20 Oct 2026 15:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFJV-0006zb-Fu
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:15:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFJS-000758-Dl
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:15:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGu0Yu1198911
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o00DHWshZZCXBm+0dy86+uXOsEIdyckrDHd+G6ddjEg=; b=LE5fklGwV9Ls47OZ
 dXk58Qek5Erl0WRquCAuegfOMpiwrk7I79UV7tEUvAcpySWNNDN8FAGAdZKVnKwW
 9NC6TEyOoOpmS81jYl6OlGksp146is3NndHWbtnXYy4yvw2ZE99ZrMmM+J75/swO
 k0fHsLQGdvoUOblrpXRNjY0XyPjFZ3bqOxLCYRxyLeaEuxF1zMRxqvy14z0itqxq
 veBivKUz9vQAIun6HMT69fDuM8i76ofYO8CHJCriMCLSunvXgQJu5R35hU8l63zC
 xDZTRsT6l4WPviYqI7McLqZHFpUGNPMistPn0pKhmw1yeqecceJCI7CgmX56WCza
 OKTBMA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5sv2sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:15:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35d4538fd74so11639790eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523743; x=1793128543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o00DHWshZZCXBm+0dy86+uXOsEIdyckrDHd+G6ddjEg=;
 b=OWfoXzdUhHD3SLbR1uuMTUsijeH5wpPl9BO5a6HY8IqWyIjyypU6jZ3ZeMmUf9PsWs
 vEiNvFDY+Esxz99MVHrYYsal02D0XryGJks0Hc3pJFl5rTpfMW5XhgxiJLgPv6PYxR7G
 CAh8/DwqAa9Wih0QLL7oW/RgZqbkCPNvMDLuznmcj2oEkSsr/a+b1UjBvAzTfN3iZ4MT
 MjeHijMR8pIBd3R/btiFJi6vliX6KUehGPNLkKLnjqNI+J03M6HvsVAkGg5w+aYpWgd+
 mIQy5BXRJAUaANbhIc8kBSpenSpsfn1GjU6LBqUA+wGIDVULNR32nPBtSvKTBuVAmTpB
 4nzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523743; x=1793128543;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o00DHWshZZCXBm+0dy86+uXOsEIdyckrDHd+G6ddjEg=;
 b=nOW9cn+ZfuJLWmV6xYS49BEvOhH9FjQP2dYDEk1119+L/2ZVzX68MxMcx0gEucor1E
 ADuUlD6As/GmkXf7dTCTTgcmiFIJUDEpiRovRySREg/FWYkflIk3EiJXZsCew3qWayWY
 G1AaUPb6adVF2/4DbfGSQVNK9oeDfM8WqmFx/KOJ9gZCTr1x1mAyk+H8b1M7XShw7X5z
 +LYAyRyQSe4K+OMpjqtQRDmVrqdcANE6otCmtjsnP3sfBd8giZP4lGfGaarRM9Opi62C
 PtezCV/SrWGFToEQlMGui05xFIs31uNYf2jN+WRcx35Pq8BUidL9PQ7+Zyo40JtfNzC5
 jxbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNfovMW9qVcUC+rvij7Siup3/aNJE0rh7oc8dwt80665yzp8z20ZuERI5x628Ede/eEtfrNvRCrrXO@nongnu.org
X-Gm-Message-State: AFq9FYJEVeW4FWOz34mpKVSN5OpQua9yQkANzAff+PSLMzt0RCkl8sYp
 nw1cdyPKW96I1SkPwy++nUcfgjLF4Am0IGA36nZfYknD0l8PRm7MbK+au6j2OwUHde4EUKN/Vhd
 wYuBntKBWy8n5weOJIVsIYlpo4JcXX0tq+RkGxvsTZ09KAO9oo1tWrtRBNA==
X-Gm-Gg: AYBFou1Wo4SmTv+BrMrbtFRNEcbdeU51SEpzKHTXzQ+kv/QHMTNqdoXtCt4/8QCSQVM
 2X8VjZRr9VimLg+Ql7CPAq/pnstrpS8WMgQg3md+RY3ooU3JxWF/0ywa/VDsScn4W6jJYaDcyfC
 A0uD282zwttn0nAW5k+7E/ytAuuWRGxquFBUTZDHuMoW5U973CX9uuAZ1aWcYZ0nUnP2FNgLogf
 5dDAvtx5rVuxzgdgyFvA8HyHZeSUe55grslYmcyA+hzoQbF4GtW1dAH/Q0XkE0JjJvZCTGTMIG9
 grafj6HlDGQksjIstMV7VNWRmmWDzhaBqQr3noW8Iv+pDytVpYhD8GmvxtBY9KtOOPBIRLJ0AvX
 3YoqZUhIDvMB+/goCAe7sphBzmd8XCGUiYaGJvhdxTO4z2lhnvQCy/cpvja5mX6oW6AibUw==
X-Received: by 2002:a05:693c:839a:10b0:351:45a4:7dd8 with SMTP id
 5a478bee46e88-367502fb26fmr244640eec.34.1792523742498; 
 Tue, 20 Oct 2026 12:15:42 -0700 (PDT)
X-Received: by 2002:a05:693c:839a:10b0:351:45a4:7dd8 with SMTP id
 5a478bee46e88-367502fb26fmr244595eec.34.1792523741907; 
 Tue, 20 Oct 2026 12:15:41 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc88b5sm603319eec.10.2026.10.20.12.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:15:41 -0700 (PDT)
Message-ID: <4adf8178-fb5d-4d45-982f-43e30be3c801@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:15:40 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] target/alpha: Register CPUClass::exception_name()
 handler
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-4-philmd@oss.qualcomm.com>
 <d994b82d-391e-4d5d-ad6c-faa3a1a2fe8b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d994b82d-391e-4d5d-ad6c-faa3a1a2fe8b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX5aLOWO5L75tu
 /U9E/B6aWcDzW5sGvBygRwaCoS2JP0E8akoNwWVDa37ncsnMtTadxNxA5HwfOCXqReTVgZ26l8H
 tQJ+WSU+DOgGAk3YE5zaUCVrk96PG3DyD3KyQubWoNDztLIQSLUcXqzvjlbKdXjaJCBbMVxaMrQ
 aSiRzuzpjxcpPwdkaiSrevKrFG3hdAWWgeyAnkOUlLji8lUT5MmrcebbXP8ILXIa6SnVvHQeYm0
 G/faonjAl1ruKPRRFJZNsziDR3smGVsySAn7CM8vDCPxI2mpSCDmn54iG3hXq14fgupGgCXTBzT
 S8TDhkthZk9FW7SlE0XaHy3bb3gthTAcNc+61zS8b0DOvgsw6Vb5qV/1eBXofBzThw67wOT8f5U
 Snkloo0kCfc/yPINIY9Py2TjK7g8chJcogw4iT9Z77RQFKxWJr3po7Seri9Gh5eDwjw8M1DvpzL
 fni7cV8ZQMb5sbZCTmg==
X-Authority-Analysis: v=2.4 cv=fIusTpae c=1 sm=1 tr=0 ts=6ad7bddf cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=6FG4gcsAvLbBQdk6P_MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: A28qMDZ1J5pTupmY6kKUeobe30dcNNPj
X-Proofpoint-ORIG-GUID: A28qMDZ1J5pTupmY6kKUeobe30dcNNPj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfX9icu2te28FwO
 +aqoCz6ghoOt3W6ivOcI/6hN0wmPvVbP7B2oCDiqa3YLxbVQQSz2IIDQaFvyDCMhtkqBGzpq6CY
 a+5QeKoP4+kQYYPnPtSngRTuvIFibbw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200076
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

On 10/20/2026 12:05 PM, Pierrick Bouvier wrote:
> On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
>> Factor alpha_exception_name() out of alpha_cpu_do_interrupt()
>> and register it as the CPUClass::exception_name() handler, so
>> the common exception logging can resolve Alpha exception codes
>> to names.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>  target/alpha/cpu.h    |  1 +
>>  target/alpha/cpu.c    |  1 +
>>  target/alpha/helper.c | 82 ++++++++++++++++++++++++-------------------
>>  3 files changed, 48 insertions(+), 36 deletions(-)
>>
>> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
>> index 378bd96d941..8f780502476 100644
>> --- a/target/alpha/cpu.h
>> +++ b/target/alpha/cpu.h
>> @@ -284,6 +284,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
>>  bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
>>  hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
>>  #endif /* !CONFIG_USER_ONLY */
>> +const char *alpha_exception_name(int exception);
>>  void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>>  int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>>  int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>> index 12e86021663..f9936315fa2 100644
>> --- a/target/alpha/cpu.c
>> +++ b/target/alpha/cpu.c
>> @@ -283,6 +283,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
>>                                      &acc->parent_realize);
>>  
>>      cc->class_by_name = alpha_cpu_class_by_name;
>> +    cc->exception_name = alpha_exception_name;
>>      cc->dump_state = alpha_cpu_dump_state;
>>      cc->set_pc = alpha_cpu_set_pc;
>>      cc->get_pc = alpha_cpu_get_pc;
>> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
>> index c3614ecafda..cedb0006892 100644
>> --- a/target/alpha/helper.c
>> +++ b/target/alpha/helper.c
>> @@ -35,6 +35,51 @@
>>  #define CONVERT_BIT(X, SRC, DST) \
>>      (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
>>  
>> +const char *alpha_exception_name(int excp)
>> +{
>> +    const char *name;
>> +
>> +    switch (excp) {
>> +    case EXCP_RESET:
>> +        name = "reset";
>> +        break;
>> +    case EXCP_MCHK:
>> +        name = "mchk";
>> +        break;
>> +    case EXCP_SMP_INTERRUPT:
>> +        name = "smp_interrupt";
>> +        break;
>> +    case EXCP_CLK_INTERRUPT:
>> +        name = "clk_interrupt";
>> +        break;
>> +    case EXCP_DEV_INTERRUPT:
>> +        name = "dev_interrupt";
>> +        break;
>> +    case EXCP_MMFAULT:
>> +        name = "mmfault";
>> +        break;
>> +    case EXCP_UNALIGN:
>> +        name = "unalign";
>> +        break;
>> +    case EXCP_OPCDEC:
>> +        name = "opcdec";
>> +        break;
>> +    case EXCP_ARITH:
>> +        name = "arith";
>> +        break;
>> +    case EXCP_FEN:
>> +        name = "fen";
>> +        break;
>> +    case EXCP_CALL_PAL:
>> +        name = "call_pal";
>> +        break;
>> +    default:
>> +        name = "<unknown>";
>> +        break;
>> +    }
>> +    return name;
>> +}
>> +
>>  uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
>>  {
>>      return (uint64_t)env->fpcr << 32;
>> @@ -343,43 +388,8 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>>  
>>      if (qemu_loglevel_mask(CPU_LOG_INT)) {
>>          static int count;
>> -        const char *name = "<unknown>";
>> +        const char *name = alpha_exception_name(i);
>>  
>> -        switch (i) {
>> -        case EXCP_RESET:
>> -            name = "reset";
>> -            break;
>> -        case EXCP_MCHK:
>> -            name = "mchk";
>> -            break;
>> -        case EXCP_SMP_INTERRUPT:
>> -            name = "smp_interrupt";
>> -            break;
>> -        case EXCP_CLK_INTERRUPT:
>> -            name = "clk_interrupt";
>> -            break;
>> -        case EXCP_DEV_INTERRUPT:
>> -            name = "dev_interrupt";
>> -            break;
>> -        case EXCP_MMFAULT:
>> -            name = "mmfault";
>> -            break;
>> -        case EXCP_UNALIGN:
>> -            name = "unalign";
>> -            break;
>> -        case EXCP_OPCDEC:
>> -            name = "opcdec";
>> -            break;
>> -        case EXCP_ARITH:
>> -            name = "arith";
>> -            break;
>> -        case EXCP_FEN:
>> -            name = "fen";
>> -            break;
>> -        case EXCP_CALL_PAL:
>> -            name = "call_pal";
>> -            break;
>> -        }
>>          qemu_log("INT %6d: %s(%#x) cpu=%d pc=%016"
>>                   PRIx64 " sp=%016" PRIx64 "\n",
>>                   ++count, name, env->error_code, cs->cpu_index,
> 
> Any reason alpha can't have it's static table like others?
>

For rx, it makes sense since exception index list is sparse, but for
alpha it's not. For consistency with the rest of the series, it would be
nice to have this under a table.

> Regards,
> Pierrick

