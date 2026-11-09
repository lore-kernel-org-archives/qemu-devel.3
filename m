Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3668606A33D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZTQUpej0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Msi5bAZh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVUU-0002R7-Lg; Mon, 09 Nov 2026 14:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVUB-0002KL-Ld
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:57:06 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVU8-0003vR-T9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:56:58 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH6KW846225
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 19:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hB2uILwlIfhAgLGWgsF46CoVXLx8/88jFlsXBTkMwow=; b=ZTQUpej0zhqaVqoK
 iAXlO6QUeUpBmev/CxNTQ7d1dYqYCsVF/4i0SJ2PDo58/SXReUIy0Qyn7mQUTnjJ
 MZFfAe+0+moOEN2tc5adBh6z5/kGMddF38OJjdWntniNvtLBl0g+w0Iy0+4LCzWW
 dstgI8XL0NT8L9U/C9uyATbjYiGo4047WsysbiB31CazVDSj5JOYVqjH0NM946lY
 PckqCQQsOJ7Vz+BoO5X36JzVFRk5kGbnR+8rPqRsmof4bHZPdJ+S59npvy055UaC
 bXaaYkglCfKG/FmKvwQJj3S7iIzJtlQtWXawKmuBsgyS5rqRmj5D1z+QbTnhsDBj
 Sqvh8Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucapa1f4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 19:56:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f62934ef6so294511385a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254212; x=1794859012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hB2uILwlIfhAgLGWgsF46CoVXLx8/88jFlsXBTkMwow=;
 b=Msi5bAZhy7hHUetMu98LNqTjFAd3jdnFoXFrhjOLw9m9JKydUqWBLPGS4rOYzow3Zi
 cAWchuJaWbzUVsPoUvGHYSeTmNd+PFn9znudYmAltqlfolXAVzwNkFvwyiSCL866hbA5
 Sa6VW22KByjaZuU4Z56hpIAem19F/yecfyzgeAxJV8j8Ni8FxwlyjNWnPd0yxCoMT/Xz
 AvH6OoptIEk5vHvIA2ZtJL8HAxkPW6xY+dWKk8bzKaugLOiEr318KuPOXHbL8gz7yhYO
 zasMYRL45CdRoTgalsETqa8l4nHvtZSdFQ2JOd1mLj3hWi0zWrsR3rewInvsbIQcR50H
 fKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254212; x=1794859012;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hB2uILwlIfhAgLGWgsF46CoVXLx8/88jFlsXBTkMwow=;
 b=vwXJ4GBxVT/ViPKNHpioZ9eJ0nvPtiYU3j4kXu9XpfueWThen746LP+mOcO5yyNEYl
 BSXSPcpqjxBC+NNeRgiKoaXYQHvtMO6aNC4GxjWbDkBB28Pofn8cCJXTRjf2iWucehuM
 oycDu6T8mo5zAx0JU3hsv6HRxc6ZuVWgXEGwsvtle0IrtS1nR8Ev6uUbq7NgBhRkseFz
 ko5dYxNBlVH9Ny0s+yOxTkzRzKkmXsCQFqjyOc1AfzAuNQIQkKclZXtxFP5Ie4Y+QvYg
 nOKsH9Ei5b+nkz6BzAWTHsnt/q9eDesgC06t34FwWYD+m4Rn80OqLgTnqHgcmLno2Ocp
 x+dA==
X-Forwarded-Encrypted: i=1;
 AL+hErFsaZ2weYqKXasVfwVbPhuZ4rx6QhSAUZnBXxs5i3e/qlAs22K15IkH+DFLhGd7qL8JhDHGa90j66nD@nongnu.org
X-Gm-Message-State: APuU4Z8oDDEcYyUOVP+lz5P36hZoVONDDg8Jve8enX0ofdzTApSBnlUz
 PsBUzpRPqdOeNHRC9as9unjLWU8MyaFSzYxS9Xk9rP6GuxnpZ5IgLmLhn6o51wye67PGYSN1rP7
 7klL5+oVIBH+anIVpTgnEqDz7hpHB/4/fk8KbubXi0rFlr/jCUon0caEyXQ==
X-Gm-Gg: AYBFou2bewcSb2O+kuYS488jDlW5FD97No8OvVcQXb+Ih5aluR2HP3RhCwUrZ7ehPW6
 czJFR51KwxW2QE+s47YleBe561R1I8mxvA4jC6Wag2F4gNOWAsPHlO38elkYCnIUCKs3RSpVvg/
 E3Gcl7reWXgy98GeynKyuiUkxVVABzUDCoiohdq5I0W4X7vmZE5xPnq3vxqxcz4cwWCA42iGLYM
 R1p54lGQHlaUz6JeYbNHIPxZ/+J6M0nn1x2GNhAX4m3+7+hvSYk0KmHLM89bmFxRqb2v9t65T/u
 esU9YgLYXa+BxRD+uNsRll70sCd1CPRreaW0DI9wM2h1n3osqbR+m5+NuoCJ0Gsg/whnLAo7+0h
 V8WuYp1hXc4A0xMbVLmF4XIft+cvdtp4Ib3ZM5lpKbkHLTEapyiTSv8du71KeRn5nbmKWDuWaXi
 0HyF9brNnJ
X-Received: by 2002:a05:620a:178d:b0:93f:3795:e8ca with SMTP id
 af79cd13be357-9479f31bf64mr94982385a.21.1794254212518; 
 Mon, 09 Nov 2026 11:56:52 -0800 (PST)
X-Received: by 2002:a05:620a:178d:b0:93f:3795:e8ca with SMTP id
 af79cd13be357-9479f31bf64mr94979285a.21.1794254212077; 
 Mon, 09 Nov 2026 11:56:52 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef051dc5esm3656006d6.34.2026.11.09.11.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:56:51 -0800 (PST)
Message-ID: <e9cc6744-d005-480a-a778-23d2549ec2f0@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:56:48 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/38] target/riscv: Add cfg property for Zvqwdota8i
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
 <20261104194155.679241-5-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfXx7fF/KRnRITc
 fwphdw/QqMaFp2aPp4ns+igUuSbQ0c9Rm62mX6oM/93yk1gzcsQfbXmEwYk3ZWYd2EsZCBWcEJK
 2fZOU4PXvXSW/RCvraA3tiPG0j5AB63vos/HyCOHfA+nmDy1mPL3pcvGsX/pDeJj+EkOZ42BA0I
 O4NuTDgOkq2OplW8qgOSzfpgda4GPKB9jfxtyiXXIFDO/0TaQe1m8iV+TfeZn6NEe9ufGDwVirb
 DAIGUKbg74Hp2AWCVizVLPxtkmvkVH3H099XX/3Fyrw3o4WfQOzlVB90/w3ZzzDrv/z31Xz2/Bh
 5ruGoCGG8XhHrbJsSpCvbN2jJu7rMyW5sHv4vp3I3te7Qsk8I/Xz4QGGOS3gsl74fVg8V4IVke7
 WAsA8KuHcjA2UPADlUUcg6wrO6ZbpUd7WDvg+xElL2FVs1Xox1ot7eFI070Y1lVQqnkSMTLUjBN
 LgaqL+lAL9N4dL0a2WQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX+4rP+t8aWl3f
 dcNosWBpXOkFfHkwAOUDPR85IvPGECHNVPlwXDYIoGwhbuPujeLmpf2JA88dUYyZyBcfkdgLqMQ
 1DxAa4TM5afBhmecfTyhFGnvQiZtqK8=
X-Proofpoint-ORIG-GUID: WHUW2-AERpz6FjcKCClaag7oDHXnxGDq
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af22585 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=59soux2idswOs06-gvkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: WHUW2-AERpz6FjcKCClaag7oDHXnxGDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Add CPU configuration for the Zvqwdota8i extension which depends on the
> Zve32x extension per the specification.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c                | 2 ++
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   target/riscv/tcg/tcg-cpu.c        | 5 +++++
>   target/riscv/tcg/vector_helper.c  | 6 ++++--
>   4 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 53ecce8c398..96a1d76c5a2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -250,6 +250,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>       ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota8i, PRIV_VERSION_1_13_0,
> +                                    ext_zvqwdota8i),
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>       ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 85fc3ad8bb8..0c08d688ac1 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>   BOOL_FIELD(ext_zvfbfwma)
>   BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvqwdota8i)
>   BOOL_FIELD(ext_sdext)
>   BOOL_FIELD(ext_sdtrig)
>   BOOL_FIELD(ext_smaia)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 5834ec1524f..1c51ea94489 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -691,6 +691,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           }
>       }
>   
> +    if (cpu->cfg.ext_zvqwdota8i && !cpu->cfg.ext_zve32x) {
> +        error_setg(errp, "Zvqwdota8i extension depends on Zve32x extension");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>           error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>           return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 172ae0f11dc..4ba0a89f4b5 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -39,7 +39,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>       int xlen = riscv_cpu_xlen(env);
>       target_ulong reserved = 0;
>   
> -    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
> +    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvqwdota8i) {
>           reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                              xlen - 1 - R_VTYPE_RESERVED_SHIFT);
>       } else {
> @@ -88,7 +89,8 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>   
>       switch (vsew) {
>       case MO_8:
> -        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> +        ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvqwdota8i);
>           break;
>       case MO_16:
>           ill_altfmt &= !(cpu->cfg.ext_zvfbfa);


