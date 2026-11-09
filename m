Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F03606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KzFdk6zx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=awm/84dh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVmf-0004xN-02; Mon, 09 Nov 2026 15:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVmS-0004m8-JV
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:16:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVmN-0005gi-S5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:15:51 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHOW8879869
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RW3qnab5AOBRB0GvhF+nu5x8zmUGAjJBDR3DkH5JbQ8=; b=KzFdk6zxl392XDF9
 68eA1aKRKgVqtah5IY27veNFwc8D96Ffd/0yfSVxo1ueTeU+IbytHDOsRclCzUkR
 vJIcj+zFPvO2HzjVqrXFvDKVNi/63YQ6/NmmJWTc0ZSyQgIG5JNSZPWIgKRrBGSy
 AGPU84+ZqTLgNDNGxB+T1IH28sGQiCApqtoeypBRGFl70VifBJx3vQlH4reIiTm3
 Pqynzp41LZNoF95iB7n8Kjbe1l8+f1BlQ0gcd2WTc8obdibkihpuJRtuom0KtdMB
 LiA0HNtqAJt2JfgT/AFdoFRjC4w6B/rgkwwOfpXXmpEQA6WmoIl9eTelEEhvSwTg
 WXezZA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5t0j6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:15:46 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91e8b51c11dso19514326d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794255345; x=1794860145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RW3qnab5AOBRB0GvhF+nu5x8zmUGAjJBDR3DkH5JbQ8=;
 b=awm/84dhxwv227RUG7rrdAMLJeNv5TUdzX/q8ON5Emms/yPASW0ffu8yxqw/PhDJlQ
 a2T2NmY7E51E2L6+KU48TBD9iI6qHCbe0fJdlC/mTVzPvAAjwkVoXuRlakOOIH9Hds/N
 Mrl51nvfQOmBrecBB+gCNS4BtytcVANjL/qr20YxYw7x2waMtuoMQ8DSKz0u5PvgoRjc
 xsYVqXfyKt8aaFRBk9XGJd1gaQVGgVIx5nslQV/5LnGRMVW8bXn8/s1FzDT0sZqHXDtN
 q5ndmrQ3a2PGBGC/Sq3TEKStCUTIxUVo5C0inShGgnSEKF46T5NT9ofpEQtMtauZLJ/+
 XmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255345; x=1794860145;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RW3qnab5AOBRB0GvhF+nu5x8zmUGAjJBDR3DkH5JbQ8=;
 b=L8I0gsN/kx/mDSUbW69goL3BkfgWwcaXIujHV9wQpSJp9PG9kUSRH5NYDG2/ANb70N
 xJzGnLomxMh3Wnh7/8s9t44FkbLDDMVshtNa7g7oTgvKPJBkwAriRoRa4qypszLHR1qw
 nEZgH3RBJ9kNs92LUk/VvfuxY0/FWy6CKTAniFxd1InSaYnJOSqD3yry6iULaHK4Yrgg
 2KP1NG7Z5nEjYF0zNC/gGSQbxtBClwgRFDOTWdM1I1X4XiFMx9be0kvo8L0+M9AxcP2C
 Jm4fEf9Eq+YP/ARLOgwefU/+jOeV1lnxeGdkKByy9RTLxhhMQM2SsWr/p6IVC33KU0KA
 29Zg==
X-Forwarded-Encrypted: i=1;
 AL+hErHdkkDn4J8XEqBoVQPLwPELMYPEhY6883yczl10Kf7yc1tSiKC1Sk6pJfPiwOVEN/azRUNF12tXcf8w@nongnu.org
X-Gm-Message-State: APuU4Z/l1LqQsju8vUYDhwM29ZuvCXXZEOEgd9wL/FlW+ZUk/iMGTTR6
 8aRMDPBaZcWAaDdIpS7dk2O9fPS+ApQyPKKUFomrdCZGlFRFwz8tVzETSn7UjFwebmBw8+KHUNd
 UMBRuRxcI103RaBY2IzY3QIHCBnmWBQNvStFTw/3uu0/WMIM7dmKbTa9N2w==
X-Gm-Gg: AYBFou00WEPHJRqmXlgSJFp5MTrJBCeLXnuwZcuSKlcv+33MKdK6zgfjO1RjYH77q2T
 UlwXU6R+8WUuBww70mxDB/3jcczq3AQGCkZJTXKgD3n7MJ+IF/MCvUiPzo3QnOTaelDWNVipaMw
 B+NGfJDqLxIj0gjiMth2aUrjfNV/iAECGIOGzE30ZAOqurbew/aaMyA04YniaREp+vNs5od2kif
 lJ6cPt8ioxt6jeEMmBy4c50+xaFd2JDQ4vwUrbiQ562cIQm6WF+0RckLXIbTkNCtcgdaOCTq934
 051wEMwzgaGkA5jB2lOYklwWgMX++pxNNgLybE96sAfcFWPX7AHorRPBO7gxVoCOBhGqCgomhuM
 TiRyv5zYhZDDIo8TBfJNTmt3gRr69+baOZca6EsDYYHGgYPlW36fI/X6t8rnyXUD8QeaB5aZc7w
 +uN90vyWmR
X-Received: by 2002:a05:6214:5402:b0:91c:50af:f6ad with SMTP id
 6a1803df08f44-91eef8c8121mr12698106d6.50.1794255345230; 
 Mon, 09 Nov 2026 12:15:45 -0800 (PST)
X-Received: by 2002:a05:6214:5402:b0:91c:50af:f6ad with SMTP id
 6a1803df08f44-91eef8c8121mr12697386d6.50.1794255344550; 
 Mon, 09 Nov 2026 12:15:44 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef0318890sm4197826d6.4.2026.11.09.12.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:15:43 -0800 (PST)
Message-ID: <a5464c41-a3b8-481d-adea-9524eb4b5b25@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:15:40 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/38] target/riscv: Add cfg property for Zvfqwdota8f
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
 <20261104194155.679241-16-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-16-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MCBTYWx0ZWRfX5RnIAivHQCxo
 XGHI9Kb67eDB3Cs4qYCnbCkcgPX1+BxKIjZJACK4lnDZ1wtG+wMrxy83cCpszihzrvW6ctbgFtS
 Cfn6lINVxvds3RaRvCtLpdCuTvvmMvQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MCBTYWx0ZWRfXwCL+QhS7y0u8
 SyB3LH3sKFYHUoPjIYQ1/+x9nEjFiMaIlFUoHZsCGlLMJvpInTkPIEnTydRnq7UVU67l8rxyay3
 ZyR2OTxRXL1kMPteZLeE6GmjMk3W4CafGP6eSvYIOtTWlS/djX+b8Vxtqib+XtkKoopB2aIVMq/
 aow78eksvgHW9LD2+Y9/xM0HK57jgkAP9nOzGhAlkS1poH5/vUA1oGCjarRlobLe31AEnjdiSZZ
 zrvrlqVFbsVKwbSPfRLABeXiszzhRoGq9i9r7ewo3uKjdOkiq5YmOooJLCEjQRRPYxwiEOQJnK0
 /gS9qJ+Rdfku0mccebqOnOtJPsr84Sb+sYLR61Ns28iDBCpNthI77wZD653X9LpKVPZKriqQrmn
 rpiIR30BrLUd13ows6hQRsyCatPTqmCjG/P+fg2PxN8pI74uV4tzLJMsDKd3YcSg4e4Qxlxtv+P
 xF8eHHvABFWmMgnQUDw==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af229f2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=ztSHzjHjys0sLfpQ3VQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: 0qBvvs73hwfzK4aiysP-bfTvUIypTvNs
X-Proofpoint-GUID: 0qBvvs73hwfzK4aiysP-bfTvUIypTvNs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add CPU configuration property of Zvfqwdota8f extension which depends on
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
> index 2d905a99d68..4f2e7a8faa9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -236,6 +236,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>       ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>       ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwdota8f, PRIV_VERSION_1_13_0,
> +                                    ext_zvfqwdota8f),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwdota16bf, PRIV_VERSION_1_13_0,
>                                       ext_zvfwdota16bf),
>       ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 30c404863c8..b18abdd8b9b 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>   BOOL_FIELD(ext_zvfbfwma)
>   BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfqwdota8f)
>   BOOL_FIELD(ext_zvfwdota16bf)
>   BOOL_FIELD(ext_zvqwdota16i)
>   BOOL_FIELD(ext_zvqwdota8i)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 91e009072e6..72ce0b4fbd0 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -706,6 +706,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvfqwdota8f && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfqwdota8f extension depends on Zve32f extension");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>           error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>           return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 5947427b6b4..a4c52ed296a 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>       target_ulong reserved = 0;
>   
>       if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
>           riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
>           riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>           riscv_cpu_cfg(env)->ext_zvqwdota8i) {
> @@ -92,6 +93,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       switch (vsew) {
>       case MO_8:
>           ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvfqwdota8f ||
>                           cpu->cfg.ext_zvqwdota8i);
>           break;
>       case MO_16:


