Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D1606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HGbVKSC5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gr5+z3l5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJF9U-0000Wo-53; Tue, 20 Oct 2026 15:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJF9S-0000RQ-PE
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:05:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJF9Q-0005zT-SC
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:05:34 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtWD31375701
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BV2luqTE5irsPzp2E2/Tfb8snSjqbZDzEdLhQpOPnA0=; b=HGbVKSC5nQv+2pI/
 1KljCpFZqqX/Pb2Kn6MDl6GZfafEaBo+AXVkYuULFBoJlC3sirNwpZbZbpE0/IOT
 v3eQan0kDh3deL38jR89jcWKhJCD3YIia/NndT6Q8OOIDp3LVD5KA7CEPfT1nXPp
 cbpwkoxylntc3D1iDa2pU2+S8bKwJ5sVkq6VUEDDDEBS/5kawZG+SrP63AgRTIOG
 0/IvRAWCzZRR7YChbFBSgNHxViNl6wG9uUUjp01prlEeOJ103YAwrZXJqpYBwXGI
 VQR12tFAKgyIAQE7XdMc+eEKIw/F76HY+UyniR2k+6RdUuZ6kjg1st9A8Mmwt3e9
 HZeAPg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hebyd0jum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:05:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso1597787eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523130; x=1793127930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BV2luqTE5irsPzp2E2/Tfb8snSjqbZDzEdLhQpOPnA0=;
 b=Gr5+z3l5oKh+n1xK5j/9hZxnB4W5JtAR2R5XYNlkiV/KojeVra4qp/TocLJdnNhdPY
 x2kJLcFqcTUai7IytHGWaL2qC36UYQcmXRMs3zw/m6n5wqrd77Ga7Dw8wskkOZuNrtcg
 6peVlT+pSdc9UZNk0bcGVv/J+Jz8VE186XMoefrrAeApa0akPZBlOFwkFnYkS5WKV730
 Kolr1I4OT2kYDYy0BV+32b6U6cLwRXjtfEODCfZMcgPKGgHHGhRaz/uJJc67DPBVbpNu
 9F459rnvLbRKApqCqTHCKuRVtUMeuXdMp9ca1/354lo5rkTHCUMbHbY9+UiddgWHQjJi
 4nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523130; x=1793127930;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BV2luqTE5irsPzp2E2/Tfb8snSjqbZDzEdLhQpOPnA0=;
 b=Qx9XSQzmxrz3+6eI6C4UPmFgV19+kIHuXHI4DYA5Yh8QHM05wKETAO+36LRufTk0iV
 Z0r1+rhokDXbXpCNdRvRyEQpBEtuokJyx1aglvTxrgHSwkJ9RP5fW/XM61qm/yJpvdra
 k7ul6n3IacM8shm14r9bGik58CqlsikY6gMRCcvdwWZuek/CThZYfoBAmer/KJHN2rjZ
 /M61Ypjfpk80OSAlc86pj6eppYhiUeQ7Jx3Wd7b8SN74KCiF4g3X65AqAlw/qFK8WuPa
 26Gk2QJ52MDWQFS1hnd+fAOyeuPMu7RnbBaVwO5MSUMndIHOIoqEeEIWSPFH2hT98R9N
 5mDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj/5WOggMAwixSHOKcMvwHfDE1s6fUhnUCfQXlSQpGOjOy6j8m5B0KgZEQVXWWQVUFioSJv2TaGsw8@nongnu.org
X-Gm-Message-State: AFq9FYJUJDKJ//RPAtWKw3Nvmg7trXvncO3iZMn0WPw9lW2O7QVKsI1+
 QZL0RWGQRixoPkg/QDEbiItEv+jGCkQ4id0+ZA18ONBH/42i5Rt0LZguDlQ+Zun563cz+4svETS
 hgr5vnaM33uKEYjWTmd7BlRd6H/PLagmStBoyZ9H75BnSg62g4qR3pf1ZOA==
X-Gm-Gg: AYBFou2ircD/6TA2JrY/+HY3cgUpgVA7FyssTQka7nc+nlpymiiiIR5SRARKe3mrSoa
 1HdRTPNDXzIg0V7vfOsy6MltkCodOcHuNdBNThC0gjdqn5EiGooh3yf6cN1YhMIzBtvHqqmf+jG
 a1vgsTTgdrIQsVx6yKWGxg9e5S39I1x15lt3WBxdfNQuMJpmWNsZwvFjOOOlr2/v3U6kl+vPx3q
 xJsRe7oiJS8PlQJKkkanKa0CM3qAT7gESTab8YJZgHXDBPq9ON0WNKrTRekMaNVMlDIn2qwnT5k
 W9ZHenTioJn9YZ0BAH0D2qWT+RRmk4E1wVlJBRjY0g/OemJPb+8/6Cff/AgzCvQSjNRMnEI1zQy
 QSQE0IQoZSgt8KEgj3bPXBn8XAVpMur2szMSU6DTL0PIha5d+bv7JcXzxkN8Wuq3qh5W+Ag==
X-Received: by 2002:a05:701b:4210:20b0:159:f192:5290 with SMTP id
 a92af1059eb24-18dbf218391mr3637574c88.13.1792523130218; 
 Tue, 20 Oct 2026 12:05:30 -0700 (PDT)
X-Received: by 2002:a05:701b:4210:20b0:159:f192:5290 with SMTP id
 a92af1059eb24-18dbf218391mr3637536c88.13.1792523129419; 
 Tue, 20 Oct 2026 12:05:29 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a74624csm520403c88.7.2026.10.20.12.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:05:28 -0700 (PDT)
Message-ID: <d994b82d-391e-4d5d-ad6c-faa3a1a2fe8b@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:05:28 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXyc73vjqltM61
 PfRIO/rrPxzlgnvaULkAPEH9zgfoN01+xO81APHiuKXsDItAuSxCmqWwQM2DKPwqohTni0E3jT+
 xd5n0pSZIn6vlW7ngzizEK0UBRy5gFzoq/HoS4fWa3aXh6BNkHAcJmMYIVyuSXRLnm2ASusjc+7
 QxMdwPdgx0Maj7hS/nbrKJolTsRFLutXnF1ATyEF743WgdRtCk778x7/Rog0LdDYdTkk7PWzBP7
 LIsuEJKjBVIfbKCc3tekgwtD1NmcwYO9quPJurnN7dlM3HxE2oXq0+pzmDmx2JmNyEh8+iod8th
 9iW2d61XQlZR0wmqvTvf1ukL6FESm8qOOIWSjQzV3q0Tk+WrQW5Jy5RlN9r87MFTC6DeVowJQ1s
 IDhRFLBE3TJShgD7O9xk4yRaoH13wDOjz4EB+zTTNdnFI67MSP+kzthXKCowtJcPb0brL3dvVw1
 +W+pc3AdRx7Iyp9+7Uw==
X-Authority-Analysis: v=2.4 cv=TdsDJhQh c=1 sm=1 tr=0 ts=6ad7bb7b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=SegdLkJV4aop_garrggA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: kyXHgMUkxO3Vtkua_xkXdMMNjeH22CQP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NiBTYWx0ZWRfXzSzMiZ8iu1Fp
 nHSkfovPyURUg+koBRvjuxeNcxYnXr55Nc4/U0xur+OJakFH8dKE/AyJYknpx8taIghv9EFWtVT
 C5gmlfddLp8/s/i9GbeDzmdCxFxdmJk=
X-Proofpoint-GUID: kyXHgMUkxO3Vtkua_xkXdMMNjeH22CQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200076
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

On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
> Factor alpha_exception_name() out of alpha_cpu_do_interrupt()
> and register it as the CPUClass::exception_name() handler, so
> the common exception logging can resolve Alpha exception codes
> to names.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/alpha/cpu.h    |  1 +
>  target/alpha/cpu.c    |  1 +
>  target/alpha/helper.c | 82 ++++++++++++++++++++++++-------------------
>  3 files changed, 48 insertions(+), 36 deletions(-)
> 
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 378bd96d941..8f780502476 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -284,6 +284,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
>  bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
>  #endif /* !CONFIG_USER_ONLY */
> +const char *alpha_exception_name(int exception);
>  void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>  int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
>  int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 12e86021663..f9936315fa2 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -283,6 +283,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, const void *data)
>                                      &acc->parent_realize);
>  
>      cc->class_by_name = alpha_cpu_class_by_name;
> +    cc->exception_name = alpha_exception_name;
>      cc->dump_state = alpha_cpu_dump_state;
>      cc->set_pc = alpha_cpu_set_pc;
>      cc->get_pc = alpha_cpu_get_pc;
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index c3614ecafda..cedb0006892 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -35,6 +35,51 @@
>  #define CONVERT_BIT(X, SRC, DST) \
>      (SRC > DST ? (X) / (SRC / DST) & (DST) : ((X) & SRC) * (DST / SRC))
>  
> +const char *alpha_exception_name(int excp)
> +{
> +    const char *name;
> +
> +    switch (excp) {
> +    case EXCP_RESET:
> +        name = "reset";
> +        break;
> +    case EXCP_MCHK:
> +        name = "mchk";
> +        break;
> +    case EXCP_SMP_INTERRUPT:
> +        name = "smp_interrupt";
> +        break;
> +    case EXCP_CLK_INTERRUPT:
> +        name = "clk_interrupt";
> +        break;
> +    case EXCP_DEV_INTERRUPT:
> +        name = "dev_interrupt";
> +        break;
> +    case EXCP_MMFAULT:
> +        name = "mmfault";
> +        break;
> +    case EXCP_UNALIGN:
> +        name = "unalign";
> +        break;
> +    case EXCP_OPCDEC:
> +        name = "opcdec";
> +        break;
> +    case EXCP_ARITH:
> +        name = "arith";
> +        break;
> +    case EXCP_FEN:
> +        name = "fen";
> +        break;
> +    case EXCP_CALL_PAL:
> +        name = "call_pal";
> +        break;
> +    default:
> +        name = "<unknown>";
> +        break;
> +    }
> +    return name;
> +}
> +
>  uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
>  {
>      return (uint64_t)env->fpcr << 32;
> @@ -343,43 +388,8 @@ void alpha_cpu_do_interrupt(CPUState *cs)
>  
>      if (qemu_loglevel_mask(CPU_LOG_INT)) {
>          static int count;
> -        const char *name = "<unknown>";
> +        const char *name = alpha_exception_name(i);
>  
> -        switch (i) {
> -        case EXCP_RESET:
> -            name = "reset";
> -            break;
> -        case EXCP_MCHK:
> -            name = "mchk";
> -            break;
> -        case EXCP_SMP_INTERRUPT:
> -            name = "smp_interrupt";
> -            break;
> -        case EXCP_CLK_INTERRUPT:
> -            name = "clk_interrupt";
> -            break;
> -        case EXCP_DEV_INTERRUPT:
> -            name = "dev_interrupt";
> -            break;
> -        case EXCP_MMFAULT:
> -            name = "mmfault";
> -            break;
> -        case EXCP_UNALIGN:
> -            name = "unalign";
> -            break;
> -        case EXCP_OPCDEC:
> -            name = "opcdec";
> -            break;
> -        case EXCP_ARITH:
> -            name = "arith";
> -            break;
> -        case EXCP_FEN:
> -            name = "fen";
> -            break;
> -        case EXCP_CALL_PAL:
> -            name = "call_pal";
> -            break;
> -        }
>          qemu_log("INT %6d: %s(%#x) cpu=%d pc=%016"
>                   PRIx64 " sp=%016" PRIx64 "\n",
>                   ++count, name, env->error_code, cs->cpu_index,

Any reason alpha can't have it's static table like others?

Regards,
Pierrick

