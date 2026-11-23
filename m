Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06A606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rm/xBZSM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mj0qbtid
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXQ3-00055c-W4; Mon, 23 Nov 2026 12:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVXPs-0004kS-Kw
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:20 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVXPq-0007Yi-Qt
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:01:20 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGH12f2844425
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 StUgBFixpSxgq3zfud5N7ALSDdBCkiEZM2RFZZXiTs0=; b=Rm/xBZSMerAqh3FD
 bD3Je+T8mwsAwM42e83Cjh+4IgwlDGhbYIV2degW3+x6FqUPSD6xFkku+PUhdD9O
 EhJC4IEkuNpkAhyMyoqJkGRJIyrF6c5nTWq0kXsJrXr7usYiis8x3ZZKgzz1hQT1
 yelkJ+pqYX57An91sLFEgPbV4EW56F7QwJReIsap3xAWFM2F1knN/m+ldD4v4eFF
 7NvGiJOIHSydYvXKd6CqEp8Wa49Hi0rtDNepF0xSYaXiOQPWw7tAk8nAb5ItWhpL
 vIPEDAErEB2exB2VQDIRzmTQc/hahenzXGl1ZyAx3eI5GCqaWgKwMAF0QZ7ika/4
 kNZK9Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k2ftx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:01:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9213659143bso5756576d6.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795453274; x=1796058074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=StUgBFixpSxgq3zfud5N7ALSDdBCkiEZM2RFZZXiTs0=;
 b=Mj0qbtid0gPKVt8pxvdVP8cpseBwGGLFU+NTRhrXe2O1H25iWYeJfpa/+FcCkb7JC3
 ASSkvUiU95661pJY21vdwgYKvURz5G5nMQj7heiihsJJHkASGiqzuOdtgIprDMdWDtaY
 77X9/gLYV+SI0XtTajjy+8+TCo97YSHPcjxvf9rBohn3cE4HcT0zv244woxppd2AnbPW
 fXODw1/b94CS0YrR50FM2Y7fjk37jwFsvZ/6O3n6v7nDNyzizLtUPccizcD2kKtJblTU
 o0jLpROWodMuaC38xSxxPqTRUW0aF5ZgvddW9tgwyvj6Wy4tE/q7I0FkYQMYlRU2LnvN
 EjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795453274; x=1796058074;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=StUgBFixpSxgq3zfud5N7ALSDdBCkiEZM2RFZZXiTs0=;
 b=oiMhbZEQPYM3Mf0qpjDw5h5Z1iQeL1J61qKvKThS2RTKnd0W3Hg+ml6ao5fqFDGpzl
 LbvkzFP91yKIgCW6qfPre5gQwCbkaz+8Sx3mp/tctlkJdwrJ32mOiRxu9E+9/2OaztRW
 S4xCqYuS4OSFSOHitjRdwF5EEct1+TLP2RPXY4LzGBmtCtWC06fcwIBNPfwCJGGTg7WZ
 1p/xfjnZg/QmXbCY6jL7dehE2Eok5eX4cuLK1Sl8AGsa+mOSxk8SiBeIZuIPX/DmGNvR
 j77z6NTSMDH7yJNYKaNqG1PU2L/Xr0kX95pOTiJAGQCyrzS1K+xHldIjzNnPqbVodhQI
 Zw6g==
X-Forwarded-Encrypted: i=1;
 AL+hErHQExjQkirGbi+MicSv4NwLmDCkSFAOPE7V59bCqQz5fe86jege4a3h8fr6aNJus65kYupYzR4QKnBp@nongnu.org
X-Gm-Message-State: APuU4Z8V0fZWYJfvPjMkwPSybfPhYg77Xyhy1Q4TZ3NOlcvX5ReJEiPY
 v3ZOB0gssokiHxo6fSc+4gCOoc6BalSqbKmEPBZnsV70MCfZWeqjEeRph4uG+o/D+mPR2Qhc8cS
 trwacfDr2Enuyby2EUHOH60gDBoTZRX1cqQDqrj8NyeENhdq9VoHSe47deg==
X-Gm-Gg: AZFdTZcK0DoMCe8e5WLh+JzCTn15h6JdB1Gj7KNYI38P4cfnr4B7BHNlfknxVzy7tuF
 oFxzn1mux5yw7POIQDMX3qFooVf2w1/S82eHGFJwpBTJK2Ni/I64uzp8e9qlg2vDEn2Dm1nhzeu
 A+e8uKoJBeAvek28piv8oeQ48jrlnL8uOXzRn/pKYDa9DilfKo1Yn8yrsWlQ9UZHBqyNokA7XzC
 vQzPgJxYJw2Xz2M+ikV3S9xxbZRiG8kRx2Sj7a+I3Poygj8u2LeZPY5+UTHrrLsQAWBUEYLyN4l
 yPdWWzPeSA8WbSjJng7/0gae+rUGdrGS/qXkxIniB7PyBY3Ro9fdxNmRKBm1irbTL7SCmht2tcM
 LWgObAZoJjHWNlFFa17gGYvkGeXHmftI573vxaqjw1yoiPV/WsQy20yjWlOJVQj+cYoxJUBRUz6
 ltZqMgmMf/
X-Received: by 2002:a05:620a:1305:b0:937:6de8:b40 with SMTP id
 af79cd13be357-949ba9b3a2cmr1964636885a.15.1795453274279; 
 Mon, 23 Nov 2026 09:01:14 -0800 (PST)
X-Received: by 2002:a05:620a:1305:b0:937:6de8:b40 with SMTP id
 af79cd13be357-949ba9b3a2cmr1964627185a.15.1795453273577; 
 Mon, 23 Nov 2026 09:01:13 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb40efc4sm838933385a.36.2026.11.23.09.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:01:12 -0800 (PST)
Message-ID: <177600b6-c65b-4dba-ae3b-44e7e32cea96@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:01:10 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] target/riscv: Write zero into mtinst/htinst for
 SSAMOSWAP faults
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261117132638.1452474-1-alvinga@andestech.com>
 <20261117132638.1452474-2-alvinga@andestech.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261117132638.1452474-2-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2NyBTYWx0ZWRfXwymvpWhKLOWJ
 B5hURiyBY3TLKqJR6NHJmv5zQK1WS+KYD88FhAT8jHaPSRMGo4xoX7jm2L5P9pCBYmWxVy0vVgt
 XSDWRPQorgdEOIkiXEvDX0TZc/KMclQ=
X-Proofpoint-GUID: yH6tqkf8-HjvwfxzAlM7VEbhWnHLT4TA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2NyBTYWx0ZWRfX1cSpYkLOY/om
 9bbnVt3bOGCnOGC8pEMpfGH3TBsUWyA6mwtI1I3uovAbURFwvhjpSkVDlptmxOfYQxijotJixK4
 BCEH0ropSv5dgv9n0Up0GZe873Q9Q0Gm7OxCtlcbxN8hFy03AwCASlUbsrd3gassBePSuWyS2UG
 +coBv0WAszbK4drwOqdxI4C8+1u8w2+mfPs98dAN3Jnseb27dtBrF7HyOLxIvTXGFKMQ7zC2TcV
 7zbTl/paT2A+KS9CdDs4FeZEJ1Mjeos4Uwp5s8MHHc2J7USAPWYFOh/4filgrQny2Zcbs7w9mge
 YosJUSAGkHHYNPT/KXH4z/8lCJBXFoblg3DERugwBw7jW3Xdm7NuVVJrkDp3j8B/cwnt4vGf98S
 8p26Z0u3f7oI4xOX+Loebuj1ZurQqXpaJOknLdKsPCXKrc90tkukKX/GPORSMR4Jyz6Jxrd3wfD
 +0BvIHRX0cJh4qaOt/Q==
X-Proofpoint-ORIG-GUID: yH6tqkf8-HjvwfxzAlM7VEbhWnHLT4TA
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b04715a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=ZT-azI6cAAAA:8 a=EUspDBNiAAAA:8 a=1-oS70kicTKPYVcAC6AA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=MMnepr4wVL9Sz6vaZzge:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230067
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/17/2026 10:26 AM, Alvin Chang wrote:
> The privileged spec defines transformed instructions for standard AMO
> instructions which do not include SSAMOSWAP. The spec also says: "If a
> synchronous trap occurs for a standard instruction for which no
> transformation has been defined, the trap instruction register shall
> be written with zero".
> 
> So mtinst and htinst should be zero for SSAMOSWAP faults. The previous
> implementation only compares opcode which is not enough to distinguish
> SSAMOSWAP from standard AMO instructions. This commit further compares
> it with funct5.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4721
> Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/instmap.h        | 2 ++
>   target/riscv/tcg/cpu_helper.c | 9 ++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
> index f877530576..bddcf313df 100644
> --- a/target/riscv/instmap.h
> +++ b/target/riscv/instmap.h
> @@ -165,6 +165,8 @@ enum {
>       OPC_RISC_AMOMAX      = OPC_RISC_ATOMIC | (0x14 << 27),
>       OPC_RISC_AMOMINU     = OPC_RISC_ATOMIC | (0x18 << 27),
>       OPC_RISC_AMOMAXU     = OPC_RISC_ATOMIC | (0x1C << 27),
> +
> +    OPC_RISC_SSAMOSWAP   = OPC_RISC_ATOMIC | (0x09 << 27),
>   };
>   
>   #define MASK_OP_SYSTEM(op)   (MASK_OP_MAJOR(op) | (op & (0x7 << 12)))
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 58e98e975c..94e385261b 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -2078,9 +2078,12 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
>           /* Transform 32bit (or wider) instructions */
>           switch (MASK_OP_MAJOR(insn)) {
>           case OPC_RISC_ATOMIC:
> -            xinsn = insn;
> -            access_rs1 = GET_RS1(insn);
> -            access_size = 1 << GET_FUNCT3(insn);
> +            /* Exclude SSAMOSWAP.W and SSAMOSWAP.D */
> +            if (MASK_OP_ATOMIC_NO_AQ_RL_SZ(insn) != OPC_RISC_SSAMOSWAP) {
> +                xinsn = insn;
> +                access_rs1 = GET_RS1(insn);
> +                access_size = 1 << GET_FUNCT3(insn);
> +            }
>               break;
>           case OPC_RISC_LOAD:
>           case OPC_RISC_FP_LOAD:


