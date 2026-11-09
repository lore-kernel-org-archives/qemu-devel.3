Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28115606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aP0+LRV7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h25wNabD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVrI-0007dM-RH; Mon, 09 Nov 2026 15:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVrD-0007ZB-Qo
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:20:48 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVrB-0006Am-2Q
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:20:46 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHC2H370210
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bzcRB8nKNy3mBV+RhJ2V1h0b1+47IRFDCbAlwArYWnw=; b=aP0+LRV7i2SOVnwG
 lc0f/C1VfzQp//4+tA01WGdkY6JshHU/Rxy3zzn6LXbOTBIdkOnGdf3atm8twWv8
 2ZK5ya3K2KXYknZ1hJ+PNdMjlU3N68bC6Acll78tddx9Y5xNPsoHtMhwbA/dd+eY
 2RFw+kqffFe3vxdMlgbA4SC05x2R+SoJB2/VCe05O6yNc4VKpYmu/N3+dguHgGt9
 7d+CRqgg7VYTnPKxQllgUTPjprUbcxB2+3YtjuuoTghC3vUeOoirQNtOvOygELFz
 70A3hQms9PNJ0lnDG3QJfSB+gSf7ek6RdG3QqtVHYxNGahKiGKw2Yy6tEGw7Ivxq
 A79gLQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hua58an1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:20:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53395d51187so21921801cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794255642; x=1794860442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bzcRB8nKNy3mBV+RhJ2V1h0b1+47IRFDCbAlwArYWnw=;
 b=h25wNabD9OGmwi3+laJtCWjX8SMca4cdU0ZBGgqmIc6yzbcruPFaMG8a5338a5kprM
 WkNTZOrIRoFKy1a2B5/foUkwsftfwwCS0TNepSJDMQwPcj7XaewrcRBgAYZz94BUEYJL
 LWPr/rwpiIXVEB5EZlXnsETpMU9ajF4Q95iDZTQKjxC/7rgPANm/Y2SPgqwH3U/GZ3ii
 jjdkAmLO69rKuefZtuX0kJIpVOXySuE00pb3XS9/8hB56/eKj14XNV7EXDX8lUMo3y2B
 oKBmoJWTZXykgmIrG4t5Gk5vVdk+eyAPBKcTpbA5zXRkeGH09738NV2VftN+yCIhjWqo
 YoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255642; x=1794860442;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bzcRB8nKNy3mBV+RhJ2V1h0b1+47IRFDCbAlwArYWnw=;
 b=wARJpwpP2EDU/bI1camTnE1Qx/BjqpRujQlV3di3Gle0zAIxSu5eORdp9zIHP9Sx3I
 pMDdwu66LBjh3IxQh41xfGzFnPGVaMzDjRE83SfKYhBOgcAeC9KI/pBChNcFyacMJ0V/
 f4SRF0CYfyYet4liQ9NLm+Nl5JrprhAtCnfsN9YWJimHjAGbcWZCBynuhu+8xfIG2Aqo
 uMhrAslXcK+fsxjVGu/FlEZGp5J1jXm5nwJXhFMD/iFlSmzLPs8y7tZ67T24UWbCq3L4
 agzLuSnPf+j7OsKE3bKN5X8PwrIGXZnvgMemxFSjAuLER76Lmkf1wsxsz1OEyoOENh7K
 KNCg==
X-Forwarded-Encrypted: i=1;
 AL+hErGO64NFpEgUF7D+680NM3XT8C66jB0b/qjxUXvMI3PvyyWJGz6q6i7ERCLry/Els32Ld5/DMHFMSv6E@nongnu.org
X-Gm-Message-State: APuU4Z8acaCA3ITAQGicxFwDdlrIUOorrt4RTrzWdU28w5kobQu2sEvO
 XTsECIpQ02KW8r/sxgTxiyOjoD8saAn61ajMcd4DvoEIyp+OfYuldRE+qiBNe1+Uqzwtj+gub71
 igjAYbbJGUBMU68yl+44uwjBtj90Mqn08avBizixhdTAHvTKfZOrjfaKcrQ==
X-Gm-Gg: AYBFou0J4YyPVHynFJdbDxEEf23PZu34xC2j0quuN5Jo7IAjYOPPB84wBXDwUSspqGB
 CCIrgC7OttS81Ch2Sfo5/NPdxszoehCEPOpx4kgxIMPs64DFdb2UwFX2R3sIJIDKgMoShqVN1mH
 a/Q/dqdbmoNAtfS7f5ea1QBexdN+RaaOcevOZCWQeePW1Z4DoEvHs5fFO2T5X33OxxR1CFqFojZ
 lQmejNwwK4PBRo/SIUiDDgl9unOuCzHeAIafup3rOdSLSdqitS0TGQtIBGh9tv+hu6WqJ0CriOC
 pJXt/vnRwCExWbT6oTDLNi/AgUnlB3rBSxGD6CkVmDyQgKuo8sf8gHiPICwxx/s8jQHNWesC4WU
 CL+Cyz78T+YzfTFhmwfYEiBs48KNjwcomqrgYpCeYxYI2yAJpp/Ynynk5GRKYQZsvZyL5e97bDi
 WXZ5nI1lXX
X-Received: by 2002:ac8:5755:0:b0:535:2314:626d with SMTP id
 d75a77b69052e-55527133976mr7864281cf.13.1794255641935; 
 Mon, 09 Nov 2026 12:20:41 -0800 (PST)
X-Received: by 2002:ac8:5755:0:b0:535:2314:626d with SMTP id
 d75a77b69052e-55527133976mr7863831cf.13.1794255641347; 
 Mon, 09 Nov 2026 12:20:41 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550b942e83sm5744411cf.18.2026.11.09.12.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:20:40 -0800 (PST)
Message-ID: <c474fa18-4c4f-4c8f-b6bf-43f74284e1f5@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:20:36 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/38] target/riscv: Add cfg property for Zvqwbdota8i
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
 <20261104194155.679241-20-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-20-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfXx1/S6vXRUh69
 aC6mKMt8WTDa8J1rP5bXJdGHz+ZnCG4J2ct/B1p8GXKiINjUn2oUSxsIGpGYJbMgRdVRYJ+BAoA
 aLTT5vPCk7iQbrUlpvAqhyMuPUnkIwDGCdr+hPHlSRdRzhvNSmdJQ+kpCBR+zeU+2t2EgvO51Uo
 7kxd63o/szAfYnUrS1AeQIMGyGs1ZDSD1wqT2jOyTxo9X+N8aNHqR3Lw64v17xW7Ot42Ei1R5Qd
 y7sUVzRQp9XL6CcBknD+6ofgmCFCoBSOOGqj4zAzAsg7nEpvYANPG75HdMskYZ88Hq1a+4oR7pW
 PXhYjyMHbq+AL7ywfReRIC1lOhUyoEnuDOnqcFPJr33b9aat4jyUPgU5HgGA9w2Ik3/XpoddSQc
 2mpS+thtR/uZ0s4bCxn3W6b2bx7/x4YvUd/BjRALS4jSh4EeL+f8kCz147wNAkSlAqzU4iIrBHo
 Musomu1l2xf6y6JAwVw==
X-Proofpoint-ORIG-GUID: RtuPmudeT9_UbAu6VRg8P-Txwcxyjom1
X-Proofpoint-GUID: RtuPmudeT9_UbAu6VRg8P-Txwcxyjom1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfXz3+WwW4+wUgc
 PzpqLrviWwdrYssXYP3hRWeJJqkhgr8plDoLM6ClKgITL57RFsr9Vr9tpGOxYbXYrqSALwpvoiM
 8ceakTcLyL/Iao3dLhf1+8yy28I4rMc=
X-Authority-Analysis: v=2.4 cv=C9V8WgP+ c=1 sm=1 tr=0 ts=6af22b1b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=XBAgjMVXaL5moyl4Vc0A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090081
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
> Add CPU configuration for the Zvqwbdota8i extension which depends on the
> Zve32x extension per the specification.
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
> index 6c09685bd4b..9271f79d1b6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -254,6 +254,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>       ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwbdota8i, PRIV_VERSION_1_13_0,
> +                                    ext_zvqwbdota8i),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota16i, PRIV_VERSION_1_13_0,
>                                       ext_zvqwdota16i),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota8i, PRIV_VERSION_1_13_0,
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index b18abdd8b9b..3d822432d48 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -108,6 +108,7 @@ BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
>   BOOL_FIELD(ext_zvfqwdota8f)
>   BOOL_FIELD(ext_zvfwdota16bf)
> +BOOL_FIELD(ext_zvqwbdota8i)
>   BOOL_FIELD(ext_zvqwdota16i)
>   BOOL_FIELD(ext_zvqwdota8i)
>   BOOL_FIELD(ext_sdext)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 72ce0b4fbd0..782e38b608e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -711,6 +711,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvqwbdota8i && !cpu->cfg.ext_zve32x) {
> +        error_setg(errp, "Zvqwbdota8i extension depends on Zve32x extension");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>           error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>           return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 5cb44326200..b1ca584f9ef 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -42,6 +42,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>       if (riscv_cpu_cfg(env)->ext_zvfbfa ||
>           riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
>           riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
> +        riscv_cpu_cfg(env)->ext_zvqwbdota8i ||
>           riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>           riscv_cpu_cfg(env)->ext_zvqwdota8i) {
>           reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> @@ -94,6 +95,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       case MO_8:
>           ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
>                           cpu->cfg.ext_zvfqwdota8f ||
> +                        cpu->cfg.ext_zvqwbdota8i ||
>                           cpu->cfg.ext_zvqwdota8i);
>           break;
>       case MO_16:


