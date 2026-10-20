Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VlabgVrV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cNCJ0Cb5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJF85-000825-KR; Tue, 20 Oct 2026 15:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJF83-00081m-Oh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:04:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJF81-0005jY-GQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:04:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7IHN3460843
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YaT0wzCTVCaQdpo2CmB0FufjMHu3rOCF3i0cePBASOw=; b=VlabgVrVPisqMOlr
 1XVnkNQUu9Xv015npScWAW8HOpej7PjS0vtOquYmI4RXuqQzoEsdTxlsmcQZK1ge
 nVT6zKuopnM6SG3tO1eTIPz+74GOIhrbjEpqPGjhzd7ZAP4CPS4li3cfTAeLXuI4
 70xBF2Xs7Z1Sf5Q7LRjrkytz+jXxYt+U229zkCFvka4DqTKjEFAy2/FD6sUvjbIg
 bvhgHQQ1nLNCryaaDPzx58jsY1ZpKod5mB1WG4sz9uTEJq6KwoPq1oELRghITwkU
 F+w8gxYAnyAD7ELRnN+vdJH+KohG5Yu5yurAC2H6GBuGbdpr9nn5fLlNysqx/U3f
 F2+qRg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4r6qc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:04:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so7807585eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792523043; x=1793127843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YaT0wzCTVCaQdpo2CmB0FufjMHu3rOCF3i0cePBASOw=;
 b=cNCJ0Cb5uk5l5Amk8rJSQq/E3mMaFCmTxqHb+9v3ZHZEFa+anl9aY0hy9f8Hni8btS
 W6kP6JT/k7ihtByvo8DpjHfG8I/z8XeVOP+bMOhIIAHrCh3zZSaTP1e2st71f12p8R4B
 CFicEirdHEh2aZrJbZcHk7VYvbBcDqm9mVSiWCH/edJIZMC2vY/9cTdgF2/rqbvkBWH8
 1RQRUksAH0Nl2GsANtsDfA5QBw4t1inQNgRSKuaH7VuT57lk1/MkLwmZi17FyAnhp95N
 rU+mgkVWJPg4OWx6vxjwaY7JTiEiI/TpCwpYJfQVgVPbS9zam6/I9t9Icd5FYMVUIf32
 VQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792523043; x=1793127843;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YaT0wzCTVCaQdpo2CmB0FufjMHu3rOCF3i0cePBASOw=;
 b=psA6PH5Uy0M5fg75qndaiTPtLGnQ31zhSGSnksB0PWt6l/0VxOedFgHGrYkqbhetac
 fg7YNNK0G44k+GuQ3N3YQ9LUv4rFn9XPfNVay5outSZoxCZ7qWJSW2fK7PymP4S9GJvZ
 nwnsc0OVI2weOwm/ecRr2t0kppyMZkgup1W/v6jeSNWb8qYEy2z69V/qX20JOLU9r9t5
 Gj5WXGTyKsMIiXipZ6RvACvc3lW285fl/npTtJwbyM2KgqpcvxdBVKLWlWsoht4YwrD7
 /E3PmtPvnliM/6OlZPWnMWgvj9ImZleD0imnd+l5jzWxd85+HtZbznVE7h4ogCehIi+c
 kZfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBA9iAcV2cy17SH0albrMijSB++jc4eKTJf4QZTa0Hh+7iPl2DArJsq2hl2Kju/puOERJmeAoIyoSZ@nongnu.org
X-Gm-Message-State: AFq9FYJiWGH821QJyhudeCA++958ws3rkuhTiCf+lXsk5KahN2XkRgB1
 JjKl8FLUeHR9/O8xS3p3fMAOLWdMiiIzoI7KDY69zK20BjykxUoRn6wbhpLiTQ94LiiFg8j8QI0
 LwXNvJqRitS5ikpf6GA3vJS0Z+kIo0P26woEDzc9o3w8LF2mRTkozsUSs4w==
X-Gm-Gg: AYBFou2zDYlFt0pzbf7M1/hTFnLmTV2d/El19c4h5ESZVJ9aw+Smi+ftVzdkWlz92Bp
 O4odcEBtgXWxMbBdKkxqQ1SutBTK5vPEY5qA2KiSdVYulV3byJSc8PrN4hLbsjTVONgbHmZvgHo
 g814sZhaO/Lz8Jl1Sd6ok3Lm605LuVsNr8EeSxLlE2D0w5AWNt8f/4wFCYJl0ZPpwyXFxskHsuJ
 oKYZJajrZjX/+aojUXvYoVv2Y28TzTgqfk6GItX5tG8QsVI7uYb07aDkpCRpQ5mgfTNiPp3f5S4
 EiVT4WzT9r8et+peDCifj/tyA4os5ntTpz5YE7Uz2y4MSwVne1qz+1LXX7pHAIJd2VRMZjbPMYu
 Ob9H1QOHS+q3XbRbUOiuRYtX7DZuC30EZr48KfAygyxat7oO6YYeD/id83ZzKjS32BVoynQ==
X-Received: by 2002:a05:701b:2601:b0:151:f0c5:7a09 with SMTP id
 a92af1059eb24-18513b99fd0mr18679519c88.43.1792523042785; 
 Tue, 20 Oct 2026 12:04:02 -0700 (PDT)
X-Received: by 2002:a05:701b:2601:b0:151:f0c5:7a09 with SMTP id
 a92af1059eb24-18513b99fd0mr18679483c88.43.1792523042053; 
 Tue, 20 Oct 2026 12:04:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903a180ca2sm469807c88.6.2026.10.20.12.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:04:01 -0700 (PDT)
Message-ID: <a0c299e1-b2c7-4297-9b5b-23bac3eacfeb@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:04:00 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/27] cpus: Introduce CPUClass::exception_name() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
 <20261007094516.75732-3-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: buUuq2SZjCqtWX5vbu_69g4hPP5T3lAG
X-Proofpoint-GUID: buUuq2SZjCqtWX5vbu_69g4hPP5T3lAG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NSBTYWx0ZWRfX3ZnAHZWbETXn
 kzSQP/Rc27zR4FSDTJ+hlR7mF/lUQOc/bl+Yjvs34Y0MOhC2ivMIUZaV1htSGVsfX+rpzixrRtp
 x/hWGoz6qellAZTL+UGShKm8SjFD728=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad7bb23 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=2c55W8ngg7DRG4i12wEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NSBTYWx0ZWRfXwSdKbBiKxqni
 PxEwQFcOvFyWoMA4YtddgUCgz844pyZz2fTqfs8WUAfQKpbW8VYxoS9s1v3nXWfNokcBlgi2Nhj
 G+IWCofVr7y1UqfQ/wucv7ID04pgv9Fz2jGSY2reXvuU7fj1cyBx8KopeHBusGURWETSI7t1V9R
 RxvBUIxNv6oiVDcDXG+NOxXKucNV995shs9r9C518qJPqDmqjWNLnMWDVSp+xPWJQyDJJGnzzN8
 HJGS94ugdL/TWfCBhSRilTTTu1R/7BCYt+6ZT4/1hcmKHD07vIHR0u7fY9YHW1zStCPoGMnBE7Y
 LMLXyZxAqTbDSb3/QJG6sXlp9+gXpbYKvAHUx8noRrojg28IV+TQQDvBm3pw80mIyms8EY6d3Mw
 4arxUxkG5mz921RsGGKRoR47Yn2r/RweRH0umZKEsZ/gl+iRSM/i1FWZdBvWdVMhPGqwCcZqsMG
 T6kxjK0QrSsswoj3cKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200075
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
> Have targets register a helper to resolve their exceptions.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  include/hw/core/cpu.h       | 2 ++
>  accel/tcg/cpu-exec-common.c | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 328e30045ce..1d73cc69af8 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -105,6 +105,7 @@ struct SysemuCPUOps;
>   * @list_cpus: list available CPU models and flags.
>   * @parse_features: Callback to parse command line arguments.
>   * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
> + * @exception_name: Callback for getting architecture exception name.
>   * @memory_rw_debug: Callback for GDB memory access.
>   * @dump_state: Callback for dumping state.
>   * @query_cpu_fast:
> @@ -175,6 +176,7 @@ struct CPUClass {
>      const char * (*gdb_arch_name)(CPUState *cpu);
>      const char * (*gdb_get_core_xml_file)(CPUState *cpu);
>  
> +    const char *(*exception_name)(int exception);
>      void (*disas_set_info)(const CPUState *cpu, disassemble_info *info);
>  
>      const char *deprecation_note;
> diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
> index 2ac8380d0bb..12cac8aec3c 100644
> --- a/accel/tcg/cpu-exec-common.c
> +++ b/accel/tcg/cpu-exec-common.c
> @@ -117,6 +117,12 @@ static void log_raise_exception(const CPUState *cpu, int excp)
>      if (excp >= EXCP_QEMU_INTERNAL) {
>          qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal: %s)\n",
>                                     excp, qemu_excp_name(excp));
> +    } else {
> +        const CPUClass *cc = cpu->cc;
> +        const char *name = cc->exception_name ? cc->exception_name(excp)
> +                                              : "undocumented";
> +
> +        qemu_log_mask(CPU_LOG_INT, "raise exception: %d (%s)\n", excp, name);
>      }
>  }
>  

Bikeshedding: "undocumented", or "unknown" or no description if unknown?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


