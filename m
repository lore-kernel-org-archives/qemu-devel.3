Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE78606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZMzHDgSr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jls1BHph
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWBH-0002Jf-Co; Mon, 09 Nov 2026 15:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWBF-0002Bi-Nc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:41:29 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWBD-0000GH-Ta
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:41:29 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHJq1899621
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8YWlIJvG5Z/EG5jma0xlouELQfwEMI50S4ps25Xw/Dk=; b=ZMzHDgSrMSV7wjdu
 49RJudBdsvZFsDNTOil0ZgKveP0VxTEubrTsGujLaaKmHkqFaunTg9jOureXoVDr
 QANsLAzVhJv0XZVqzk9dbq8/8nOYEUPfl0eUR/VZVYOb9KmAIIwHIe5X3HP7Eq9d
 1JltejLZRF8hjpFt3nYzNm36CHgd0my+Xk9HjbTKZ5TOK+9LZpRbldu0yoZkgyAI
 jGVOLwPAY0n6+aPmlxquUFrHlPNqADeT4d1SJqs23GpVMiDxuDeXy8XS2R94ZZEL
 N62ttqffxh/ENqM/0kwcSH46WWZBAErhORYZUqZC4MvKckivweLBBdocUjqyTViD
 GIHYYQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2kfjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:41:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1e62510cso267680185a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256886; x=1794861686; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8YWlIJvG5Z/EG5jma0xlouELQfwEMI50S4ps25Xw/Dk=;
 b=jls1BHph9nPUm/q2cqxA7v9+N3RmNr9LJeJxrt/t4jAZw+PlGxrYOzTX3IpsRN4+1I
 Abc5xuZ+5TFObcB1MAhCM4XqlrHF2jLSmPECVuInqkHiESFYlsnbp7K4HpMPRZfvTGSZ
 sZ51zCnxmVuPzSPGLlZVx1y8PV5f4PYjbvvJKb1Ej3FFgGYBraFkDIOdcM6YwQoirh+R
 v6l0ENQKOeVnOcdUiOGBPRxJVbFPSXDvmIgoOzjO8DRuFPwRcec4uhoFA5TUepuSPkmY
 xvEC3XkNn7+JsAQT1JKFgDrzFPlvTt/rKdyKV/yFfLGk3I4hI2OW5RV3FhbQWCGgIDdB
 nCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256886; x=1794861686;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8YWlIJvG5Z/EG5jma0xlouELQfwEMI50S4ps25Xw/Dk=;
 b=OHqvVFuD0WyQOBOFk/0EXPzhJRnP2ht7YHPuoEjH7xCNZG3G0/93VW6n1zeSXmqIFW
 i7+WBu5DuE/ZSikg9MMfRzpJPkkhDEYIDt7biMI6kszm3ciYzyBGRCZ5OyMNv54VvmHi
 LaSRQg+EVPR295s3oFzNoJ58TqsGS7lxgNUX1tWhwDrrW+mrQw43i+auddCypIp9zPfo
 txlAZ9hFnDl5jvd9HubRjbGQb0xlWlOMadMWiJZV3m5cw8jcUx6hoKSjLxiqxeyYANPf
 EaSrzI9x7Gnu7eiDl8F5gqdCupY+2uUAnBbhSLt1A9sy2XCbMfKkS2zPAj/Uca5DBW7j
 3/cQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGz0m9dxsKKkKF4GbpDIBlB+9ae88sZ6x/QYfKqShPkMFdzORNtwae2I/7J95oWYBWP0sosrsG6BWZD@nongnu.org
X-Gm-Message-State: APuU4Z/OK3pfU9JadsSS089yeHvGy7ji0gl20LqPWL1dPjwI2TLqWm1d
 mx1AQy0N9bA8inz3z1QibozWVpWWBn5NYghkn/koJH2PoARl1XG2FxEgPFhUnUIZYGpCT71HAZK
 QxX4dqvVqtTSDlam6WfGktSQGFr6Alnieu40XtiwC/9QrkYLlvlDwSnzm0Q==
X-Gm-Gg: AYBFou1nYAb/HX0T5ZsuKXekB7OGv14y9kWpU/pQjsB27EIocTQYM5it7xgg7i+6ggF
 4sI6p4l26o+/YHuYzOvirI4fcJY46VEmuD8H0uLhHQ+dKXSO0p9te+El1LxgEvUkY8HX4Mnl7JR
 W+6/Mz7ZyubgHo84R2LXQiRBq/6Ne8kdQghIhojvl/msFvqpnJ16yaJhIyHVl5KbuJM8b3/P5cg
 cWNlrwnJW24N3HrFxqMP+xH/SyyS75VNFAcna2O92e2aivCJA7MLWT+AdWhmOJ464dwhUfj09uf
 7wm1U6EdRa2Ix/0a8k9y/XWNbUDEAn7c6FVStelmZUdqtleeI92gFOrelFj9rEvVe9xyLZa0MBL
 jSzIoM5UBDxWESrkzd/d2kogJTydFZrdmRl2BucGi6o5gEl3ef3BkwX+q80dFt3iJEHkL9CoFZ9
 fALX83VPos
X-Received: by 2002:a05:620a:6c18:b0:93a:2150:ec06 with SMTP id
 af79cd13be357-9479f313e4cmr104505285a.31.1794256886069; 
 Mon, 09 Nov 2026 12:41:26 -0800 (PST)
X-Received: by 2002:a05:620a:6c18:b0:93a:2150:ec06 with SMTP id
 af79cd13be357-9479f313e4cmr104500985a.31.1794256885452; 
 Mon, 09 Nov 2026 12:41:25 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e7ce960sm59444385a.31.2026.11.09.12.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:41:24 -0800 (PST)
Message-ID: <34d55a17-5eb6-4b7c-8dc1-f29ea0d48896@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:41:21 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 30/38] target/riscv: Add cfg property for Zvfqwbdota8f
 extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-31-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-31-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af22ff6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=l5BtMwga8iY9Ej0hzdAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfXztI+cuILHeTG
 X3ZsI12Xbnta22bGyHSvHblr+PNOLdVKdgnMdgV2RCrSBKAILI7CwqFgeffhk7LY8ViOwGLM7k0
 cWWLvep7TlsgZcRovvxjBPtbmaMwZMG/xNaPp8umdgtjBXvrz6xEuiHerL6SFUHGE6Mu8l+K67r
 NwRWYI1E60loB8yhf1Pz6AwXaTzxqrdmIaDXGfpg1pmTF3y1CvaVW+1NvLRkvQu9w5JcO3ZOlet
 ezqRzvBMyOXDr6rZnkuLegzfkz+lrmPkHuIaFqQl6DEd7Z6D4MFIHYoyPtEcRLJMUnmBdXRbZg0
 2F53R5whAgn+G6uELUE+XnY0EICwuEl31mYCjRcYom9QYgZX/ETQFsFCqrff7pA7SZGm0bybFIg
 eklLeCLjutoPNiLaiQYPI8bCuui7dODzLk5ZFEbGOsoVr1lxKr5y+YjcPmJXLOVh6SP26+LO9Hx
 3lXFXtwRWtuHpR57LVw==
X-Proofpoint-GUID: FFRx0qF3unRSo68yNrbhBDrftAIFANzg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX/YmylITh4nnm
 AuX+6tcrdkMqxVaTBKbcX5JpjxNPTrcRxqBzDq49ZKvrrZtrfuN+qo8G4WXyKePcWIUuFOyyhir
 n5oL4moA5+oMbfHx5JAAHHPNyR8ncgs=
X-Proofpoint-ORIG-GUID: FFRx0qF3unRSo68yNrbhBDrftAIFANzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add CPU configuration property of Zvfqwbdota8f extension which depends on
> the Zve32f extension per the specification.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c                | 2 ++
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   target/riscv/tcg/tcg-cpu.c        | 5 +++++
>   target/riscv/tcg/vector_helper.c  | 2 ++
>   4 files changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 566e2e835ae..b4a9f2c3e30 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -236,6 +236,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>       ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>       ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwbdota8f, PRIV_VERSION_1_13_0,
> +                                    ext_zvfqwbdota8f),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwdota8f, PRIV_VERSION_1_13_0,
>                                       ext_zvfqwdota8f),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwbdota16bf, PRIV_VERSION_1_13_0,
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 80750db1ccd..0385b58de0a 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>   BOOL_FIELD(ext_zvfbfwma)
>   BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfqwbdota8f)
>   BOOL_FIELD(ext_zvfqwdota8f)
>   BOOL_FIELD(ext_zvfwbdota16bf)
>   BOOL_FIELD(ext_zvfwdota16bf)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 8684e4c709c..a52637f5ca9 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -726,6 +726,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvfqwbdota8f && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfqwbdota8f extension depends on Zve32f extension");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>           error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>           return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 51170625aad..6f3b666784e 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>       target_ulong reserved = 0;
>   
>       if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvfqwbdota8f ||
>           riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
>           riscv_cpu_cfg(env)->ext_zvfwbdota16bf ||
>           riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
> @@ -96,6 +97,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       switch (vsew) {
>       case MO_8:
>           ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvfqwbdota8f ||
>                           cpu->cfg.ext_zvfqwdota8f ||
>                           cpu->cfg.ext_zvqwbdota8i ||
>                           cpu->cfg.ext_zvqwdota8i);


