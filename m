Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196E1E9271A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 18:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZYxv-0002Yh-Vf; Sat, 27 Dec 2025 13:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vZYxt-0002Xe-Ni
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 13:24:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vZYxr-0002HJ-G8
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 13:24:33 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BRFgc9J272216
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 18:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ++/3M8iVUw2i57EOttze6YZsNUxFETvmghx2kzpBdWg=; b=MkiQhlbRo+42IcBS
 HPSutQNRKgmpwnmYnkcp/ULM1+Au2A913RNilXSVi8wSEszh7XdAqij7Ykb0QP6m
 FxyBVxBhRKyLWcKilt0I4buROAujUqK12LDqA5dMqT2mETa0lgjtxcXzzOkUYaOs
 NyOsjxKOvRRXzN12gjENk6pYnP8/wTXX7kkYKnyG120zCZiCleAf2XVUat1BwuCO
 Z+L5Snaxq4xHAcB7S/ESKJ8buNZDFfMSSv7gp5ccDjm7sHylm1Aqyv+I03uZ4J21
 /HpnQ5haWbbvr1VeSR9V+R+T4UDferVqdWiqeciGsa0SYeItPU94PslotUimKc6c
 RBJvaw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6dr120x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 18:24:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29f1f79d6afso115560235ad.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 10:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766859867; x=1767464667; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=++/3M8iVUw2i57EOttze6YZsNUxFETvmghx2kzpBdWg=;
 b=K4Ewb9Hvl1Vrfb7UqjnWym8wT/lcn6GOVMHkKUZ8TznVhDvy5leA9HLP7l8ChTXGVN
 20Nct5w9ww/e46ZGoFf6QLJImTkl7hYDiDvvEgf6856yluKreIe9rMihkptck0aRT6X1
 WlueR8nGMg51m3DhZ2nw8aeEXiA7Orc02dzgqrh9xdsaZaXBFQoUadYB07kZokgCHl71
 DRTi3XQA/XubOxd88luZP2Rec57+cshWn2ZYFCgs9ByhvVlbI+gQvbl/zZ92O4hDvMQ0
 7CyV7d4xXIYVOiRvXOyVrM8W60ovjtAqoX4yedJhTSrz05Ys6QdJLRTWoYVGWSjnchfm
 O+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766859867; x=1767464667;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=++/3M8iVUw2i57EOttze6YZsNUxFETvmghx2kzpBdWg=;
 b=T+ZD2rss6t9ldHlO6NR+zHDV8j1Q59MHRSc6MDQNA2052b/MLWhAS6pGSVm5k9Nu7W
 MSLHoM3MflU0/xEZBc2jXSJRoV/OaUB/c+VhObAQwgFqlyGpxZDNLBpY7uIxktNUjTnO
 0hBHC0RSkupM+3X46Jw1H+vvejT/1mXXdN476DL3UNT5QHpgCA/67vZLAUgI19ejTuDH
 jT+bIxUbpdsDexk+Ntb4gFIxbxnVNPa9rXsSvQeGPLejuJ1kPID7sbnPEkXwPN+cD7Jn
 cRXXqrOj1huayXTSmODsVttnHVyhJE/Z2MYGVlYaXxTWYqR++KN7pkEgLacQDOCkEJp+
 pLAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvWjnlNjREoXyWLqdXMCZ6DlICG7ZMgfGDFVP5/gf+IQZs5XfBP3w11bl9KHbZVYskMzxYvlb1PLK+@nongnu.org
X-Gm-Message-State: AOJu0Yw2nEJQOBuoc4H9cT01Vz0KhhVLadR/z7tlFnZOf9PSJoBZYs4v
 QNHjXHjtSlw397kQ4iPVrhyIwzkbr4DwKyBMBTU//mOcvb2a13vOJeynztkauS3CY/2NWtvlTGN
 urMN2m47J3QOJThzNJnSTmcJ8pok1lNb48Altc2sMFi/T0DHcDVwLdvqO9A==
X-Gm-Gg: AY/fxX6MV3fcb3bNOeglyUCDPpndn21T/aqaOwON6eqa5bu4jDO7DE/skLyrtcj2yAA
 zx97qNKyFpuPQeHajF7uZrrqC1gYbPJ+Z8Xe2TDpoRrqt0e64jFqnO4jeItWXkLjusdoRNW8wj8
 I/JX/n5bgu0MWOnvE98rxmgNTuAvbkkzjJk3+ijqsqwknvpXF7ZbA0GO4KgNsKVVhRUMfJ71nYN
 1Y498ekN5RF877kI7UUw8yMcRqdv8ys1Gpjju8QeaBunGE44K1QnFeZzLXkY9+8cLqhArZu0n7k
 smXkjItczzDDU7Xwt1Gx/pO8BlIQJefG2HWkW3hM/wBqCsYZHSJmUnLZp4NbEvCgVWcjIMiJv6Y
 mRLNKpd+Ysg2tj/kbCSwW8ZRwQQd2IofCtA==
X-Received: by 2002:a05:701b:2403:b0:119:e56b:91d1 with SMTP id
 a92af1059eb24-121721aaf82mr15650776c88.2.1766859867078; 
 Sat, 27 Dec 2025 10:24:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5JVSjAbGwJF/V5NmtSQLWR7h54TLlCmrKbqtXlEbe7Ou4SxYT+huq2rRZ9l/L9xM53jwICQ==
X-Received: by 2002:a05:701b:2403:b0:119:e56b:91d1 with SMTP id
 a92af1059eb24-121721aaf82mr15650761c88.2.1766859866386; 
 Sat, 27 Dec 2025 10:24:26 -0800 (PST)
Received: from [192.168.68.110] ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1217243bbe3sm103396800c88.0.2025.12.27.10.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 10:24:25 -0800 (PST)
Message-ID: <79d7c214-503c-4b17-85f4-2db0d55fc45e@oss.qualcomm.com>
Date: Sat, 27 Dec 2025 15:24:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Add data type views for vector registers in
 GDB
To: Jerry Zhang Jian <jerry.zhangjian@sifive.com>, alistair.francis@wdc.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, frank.chang@sifive.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20251224074335.571933-1-jerry.zhangjian@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251224074335.571933-1-jerry.zhangjian@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI3MDE3NCBTYWx0ZWRfX2FJ4orRQWR3l
 mj4uksswA0ZNJB3aSR6pvFBbvUyih/PT8+YGNyhwRzn1aaX4WVbl37nzOiZh4sTE+lC1tz/TcR2
 y07kHN7dGgvdCXtRlxS1s/Iey/Wkpd9QiPUVAD0nvboPPJEubMoBAY+jZLYfU9V1SC1JqeBYqkZ
 Yb8NvwAUYTM3NZluFrmezWbYgDGWrS3/AFdzclVWte1tzUR8sGK4wzSJR32ycZHelO/h6d64C4l
 6A8DVPsphb8bK2WgucLRjyjUdOsxmXN6FySEdPB4htL50dC6m3HRYOoWfZj4edux7Jl7xG1ZCAm
 Q27RXK0AAQIFe5h9tz3S+/MLQapo6+2g9tQqwEOxlVLA3u9Pc7vrtCKSjk4nrsJeNO8CoReZUFd
 yYn/JNIur/wc/Er5giZjT6Gb20G/wbg5KUO3mRkJ1IPkjulM+RZgOcxQYwep5y5mU6fP1J32TZo
 69T88sSvcsw9QgxxpeA==
X-Authority-Analysis: v=2.4 cv=VdP6/Vp9 c=1 sm=1 tr=0 ts=6950245c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8
 a=hhye3jXHg2gI-dfvFZwA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: QivfeSqz18Nmp7-pN9qGUdcfndKPJBik
X-Proofpoint-ORIG-GUID: QivfeSqz18Nmp7-pN9qGUdcfndKPJBik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-27_04,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512270174
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/24/25 4:43 AM, Jerry Zhang Jian wrote:
> Enhance the RISC-V GDB stub to support viewing vector registers in
> multiple data type formats. This allows GDB users to inspect vector
> register contents as different element types.
> 
> New type views using GDB builtin type names:
> - Integer types: uint8, int8, uint16, int16, uint32, int32,
>                   uint64, int64, uint128, int128
> - Float types (conditionally enabled based on extensions):
>    - fp64 (Zve64d)
>    - fp32 (Zve32f)
>    - fp16 (Zvfhmin)
>    - bf16 (Zvfbfmin)
> 
> Backward-compatible aliases are preserved:
> - b, s, w, l, q
> 
> Example GDB usage:
>    (gdb) print $v0.uint32
>    (gdb) print $v0.f32
>    (gdb) print $v0.w
> 
> Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/gdbstub.c | 120 +++++++++++++++++++++++++++++++----------
>   1 file changed, 92 insertions(+), 28 deletions(-)
> 
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 1934f919c0..89a3700508 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -21,30 +21,24 @@
>   #include "gdbstub/helpers.h"
>   #include "cpu.h"
>   
> -struct TypeSize {
> -    const char *gdb_type;
> -    const char *id;
> -    int size;
> -    const char suffix;
> +/*
> + * Vector lane type definitions for GDB target description.
> + * Uses GDB's builtin type names (uint8, int8, ieee_half, etc.)
> + */
> +enum RVVExtension {
> +    RVV_EXT_NONE = 0,   /* Zve32x (checked at call site) */
> +    RVV_EXT_ZVE64X,     /* 64-bit integer elements */
> +    RVV_EXT_ZVE64D,     /* Double-precision float */
> +    RVV_EXT_ZVE32F,     /* Single-precision float */
> +    RVV_EXT_ZVFHMIN,    /* Half-precision float */
> +    RVV_EXT_ZVFBFMIN,   /* BFloat16 */
>   };
>   
> -static const struct TypeSize vec_lanes[] = {
> -    /* quads */
> -    { "uint128", "quads", 128, 'q' },
> -    /* 64 bit */
> -    { "uint64", "longs", 64, 'l' },
> -    /* 32 bit */
> -    { "uint32", "words", 32, 'w' },
> -    /* 16 bit */
> -    { "uint16", "shorts", 16, 's' },
> -    /*
> -     * TODO: currently there is no reliable way of telling
> -     * if the remote gdb actually understands ieee_half so
> -     * we don't expose it in the target description for now.
> -     * { "ieee_half", 16, 'h', 'f' },
> -     */
> -    /* bytes */
> -    { "uint8", "bytes", 8, 'b' },
> +struct TypeSize {
> +    const char *gdb_type;        /* GDB builtin type name */
> +    const char *name;            /* Short name for union field (NULL = use gdb_type) */
> +    int size;                    /* Element size in bits */
> +    enum RVVExtension required;  /* Required extension, RVV_EXT_NONE if always enabled */
>   };
>   
>   int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
> @@ -300,6 +294,53 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
>       return &cpu->dyn_csr_feature;
>   }
>   
> +/*
> + * Vector lane types using GDB's builtin type names.
> + * Float types are conditionally included based on extension availability.
> + */
> +static const struct TypeSize vec_lanes[] = {
> +    /* 128 bit - requires Zve64x */
> +    { "uint128",     NULL,   128, RVV_EXT_ZVE64X },
> +    { "int128",      NULL,   128, RVV_EXT_ZVE64X },
> +    /* 64 bit - requires Zve64x */
> +    { "uint64",      NULL,   64,  RVV_EXT_ZVE64X },
> +    { "int64",       NULL,   64,  RVV_EXT_ZVE64X },
> +    { "ieee_double", "fp64", 64,  RVV_EXT_ZVE64D },
> +    /* 32 bit */
> +    { "uint32",      NULL,   32,  RVV_EXT_NONE },
> +    { "int32",       NULL,   32,  RVV_EXT_NONE },
> +    { "ieee_single", "fp32", 32,  RVV_EXT_ZVE32F },
> +    /* 16 bit */
> +    { "uint16",      NULL,   16,  RVV_EXT_NONE },
> +    { "int16",       NULL,   16,  RVV_EXT_NONE },
> +    { "ieee_half",   "fp16", 16,  RVV_EXT_ZVFHMIN },
> +    { "bfloat16",    "bf16", 16,  RVV_EXT_ZVFBFMIN },
> +    /* 8 bit */
> +    { "uint8",       NULL,   8,   RVV_EXT_NONE },
> +    { "int8",        NULL,   8,   RVV_EXT_NONE },
> +};
> +
> +/* Check if a vector lane type should be included based on CPU extensions */
> +static bool riscv_gdb_vec_lane_enabled(RISCVCPU *cpu, const struct TypeSize *ts)
> +{
> +    switch (ts->required) {
> +    case RVV_EXT_NONE:
> +        return true;
> +    case RVV_EXT_ZVE64X:
> +        return cpu->cfg.ext_zve64x;
> +    case RVV_EXT_ZVE64D:
> +        return cpu->cfg.ext_zve64d;
> +    case RVV_EXT_ZVE32F:
> +        return cpu->cfg.ext_zve32f;
> +    case RVV_EXT_ZVFHMIN:
> +        return cpu->cfg.ext_zvfhmin;
> +    case RVV_EXT_ZVFBFMIN:
> +        return cpu->cfg.ext_zvfbfmin;
> +    default:
> +        return false;
> +    }
> +}
> +
>   static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
> @@ -311,21 +352,44 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
>                                "org.gnu.gdb.riscv.vector", "riscv-vector.xml",
>                                base_reg);
>   
> -    /* First define types and totals in a whole VL */
> +    /* Define vector types for each lane type */
>       for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
> -        int count = bitsize / vec_lanes[i].size;
> +        const struct TypeSize *ts = &vec_lanes[i];
> +        if (!riscv_gdb_vec_lane_enabled(cpu, ts)) {
> +            continue;
> +        }
>           gdb_feature_builder_append_tag(
>               &builder, "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
> -            vec_lanes[i].id, vec_lanes[i].gdb_type, count);
> +            ts->gdb_type, ts->gdb_type, bitsize / ts->size);
>       }
>   
> -    /* Define unions */
> +    /* Create a single flat union with all type views */
>       gdb_feature_builder_append_tag(&builder, "<union id=\"riscv_vector\">");
>       for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
> +        const struct TypeSize *ts = &vec_lanes[i];
> +        const char *name = ts->name ? ts->name : ts->gdb_type;
> +        if (!riscv_gdb_vec_lane_enabled(cpu, ts)) {
> +            continue;
> +        }
>           gdb_feature_builder_append_tag(&builder,
> -                                       "<field name=\"%c\" type=\"%s\"/>",
> -                                       vec_lanes[i].suffix, vec_lanes[i].id);
> +                                       "<field name=\"%s\" type=\"%s\"/>",
> +                                       name, ts->gdb_type);
>       }
> +
> +    /* Add backward-compatible aliases for unsigned types */
> +    gdb_feature_builder_append_tag(&builder,
> +                                   "<field name=\"b\" type=\"uint8\"/>");
> +    gdb_feature_builder_append_tag(&builder,
> +                                   "<field name=\"s\" type=\"uint16\"/>");
> +    gdb_feature_builder_append_tag(&builder,
> +                                   "<field name=\"w\" type=\"uint32\"/>");
> +    if (cpu->cfg.ext_zve64x) {
> +        gdb_feature_builder_append_tag(&builder,
> +                                       "<field name=\"l\" type=\"uint64\"/>");
> +        gdb_feature_builder_append_tag(&builder,
> +                                       "<field name=\"q\" type=\"uint128\"/>");
> +    }
> +
>       gdb_feature_builder_append_tag(&builder, "</union>");
>   
>       /* Define vector registers */


