Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD0AC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 18:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuDTo-0001lO-Kd; Wed, 12 Aug 2026 14:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wuDTn-0001lG-Fa
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 14:15:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wuDTb-00073Q-QR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 14:14:59 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CI8jpJ355315
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 18:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cAfNEci19ymkl7QLhxGW82gaA5iOorF7tRDvTwaKJ40=; b=ktPbQyQF37ePT5Ad
 Dvzw8vdbCcKvrC6Zu4/dF4aNmf8CEiK3AbJ6CNyjGQ/Wq+qkhRFIGpZd98e5A5Me
 sTEqesZbKb0ZKFj4fivuDq/WPO7YO4XFYOVwiiEvFo941fpuL50arsdS8aZdDV1O
 DsakPbMON2bMjAs7qbWKLOcoGvAzeGef8cgQ8rg6reqeKSmrNh1SoTkBd9jwFHHs
 F5CmkkouEfT0mogWIrQzUrSFm78BNcWGOL3ShqVuJ7atzMG5AeIHdAEj3YaJ/DMP
 KHfDWgIZvbt+NnsrMzbm7VYljr8TSIGMmFiOisbsvk3BIplSI9Cp1SVwpDopbtkZ
 JwTsxQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2uhn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 18:14:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a23afcbso17374891cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786558493; x=1787163293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cAfNEci19ymkl7QLhxGW82gaA5iOorF7tRDvTwaKJ40=;
 b=HSkJfH0DMUbWgVlYah7VuHYs/o28p8UsBa3zZ+LYQ9p9zWZ8Jx2hqNgsOwFu1UOmDF
 8wsKdYEN7jSjM3ywhp2LsEYOYTbZOGQZWVAI8UqsW9g23zs7wqZ+qa3srSZMdC7DMEOl
 bKpqZwG7whPv6r2W2VByQz75l0G+ZMGu7BU2NpDylA3wgr8PrW9lCM3Wz2e6OVW0kiXL
 9FMgDSjcdctrip2NGGAIxfvyRqhubcuW1OufzKB5pYKvoC48gv9VufQ/G9y5gqFLW993
 L+yrLDIzI+ejrS1FfMPjubrhykimVrKn98u++3WJQu3rpb1A+aAIBWmxwrWcxj19yXxg
 qHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786558493; x=1787163293;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cAfNEci19ymkl7QLhxGW82gaA5iOorF7tRDvTwaKJ40=;
 b=FSzdSRRLAtOFTLh0FR6hVUigZQc+RnFd+ITdPDVNkKqaNbXGqxYqmgZMUD+b7BVgDE
 otVi3A1o7uuvMUFMXKYIv2C60gaFVdNEFq5iCjPCVRXs3nw3f3XIM7MDX/Gf7ppFtzAw
 er1GKHczKhFEZ3yZenJ2ukyhSPLnYZDG+Pv4bIOQfjW497DtjIFgy1Odn7L4zj9E+PfY
 4mvuj02nZe8ERC2LK8O2k08Sp3jURAAa1/N2W/W8RiKTtxCuuhqMVgy51y/920B04n4R
 SbyC8eZomRCiP+OAUEo5VxInADNBRTLpIyib6Gg/bgkXZsaVyQguW2RYW4+SxrYxuHV5
 jx4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoebpEERizjqC7j9d4vMYW/RM3mKjvXNTGGHc2HfD9UlGLt7szApGX3geUFgQURu3ffVs0P7ikxyZ83@nongnu.org
X-Gm-Message-State: AOJu0Yxflxfrj0hALSOVhEzdaGLW9GayH6hJBDc32rcMRwVqwdvVU7do
 temogNVS9gG3OnQsjBH9iOGo2cEphoSj1W2qIyU+T1wzDFJvWk5ITGGRfLtBcMJ8ciWrIrUvfXm
 cOq//CofMZbidCbclNm3XAtDCWRPO7/g8ikPL1aM1kgvGfy8LlcKP1wr8JQ==
X-Gm-Gg: AR+sD10GSrPtjMWcY1FcFFmYXX+4xrz7IWFHwYz6ftuIlIfl5VEmS/vKLx85fOdrj50
 m5shbUYdWW1zdBTdirjOZJgg7vG6kBnXIQ82QbfVWVh02MQ7j0fyjRLXTo13t9ppzdgT6tB6uBJ
 cnvnFDaqpH81PaDBP1MCygH9DAzfi4uVK/eGrH1Zzl5fXgCdO2Lu/E8kmyAWDbb1gtpnQS/K2LH
 xAh6XnimY2ewg061dIzcOSwbInP6e6qLEFyphEtoqhlu2cqhBWX4w2RRiMAfs+OZns2LFUz37jf
 /NYM/bIERvQp90FTqiPciO2MeckvtIRC1xraCiB41OSAjMOOyidZq4mnlX3iGkc+xmfFK50KoYv
 yvheQVQaQcafLwsC53nTFZHgD4mE9vbRbtdPh
X-Received: by 2002:ac8:5715:0:b0:52c:dffc:4645 with SMTP id
 d75a77b69052e-52d73c1e4bbmr1271561cf.7.1786558493298; 
 Wed, 12 Aug 2026 11:14:53 -0700 (PDT)
X-Received: by 2002:ac8:5715:0:b0:52c:dffc:4645 with SMTP id
 d75a77b69052e-52d73c1e4bbmr1270711cf.7.1786558492737; 
 Wed, 12 Aug 2026 11:14:52 -0700 (PDT)
Received: from [192.168.68.100] ([177.198.100.18])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c395f07sm26610596d6.28.2026.08.12.11.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 11:14:52 -0700 (PDT)
Message-ID: <5ee50ad2-8db8-406d-8eb3-c373e1d47f72@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 15:14:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] target/riscv: rvv: Add SiFive custom int8 matmul
 instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20260812174417.2468981-1-max.chou@sifive.com>
 <20260812174417.2468981-5-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260812174417.2468981-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7cb81e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=el0UrXJS4K3zujXh0Vdy/w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=YEB5RgzmAAAA:8
 a=RevNUAzoITomSYMgp6oA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=oJz5jJLG1JtSoe7EL652:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: yOnk6toF4xcsQe_O3RKXBr_8c1VMkRR9
X-Proofpoint-GUID: yOnk6toF4xcsQe_O3RKXBr_8c1VMkRR9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfXw9p/WtaqmOtv
 48tquQaoaHQ74T6d3uIeKNYVI+1oZTyvMDvatDa0qWrsOn+7chsafDsDeWAvkzZ/tn5Y/J23yWD
 V8UKCY3mU0DMVWWNCJ93HKvyxJo/Y8c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfX754TzUYmFhJ9
 tBFK6V7aYtXWgxcSwfZYSiXGe2U7M3239c3yBCBwzMa5lYZBnUKTenKzzyfE62VuQZ49evgecZ+
 cGh5GjY2ql2FhZ07krNQn31QtaPO70AtS6B8z5XZLj78Lmqyhf3x2SX5v0L0zpGV3rhBmZfu9dh
 yHi//z4PwpHgyYL6QsVQ2Dp8uzP9IsmCbq8UQ+Me7pXlaZlggLCejNX5hJoRuHa3GmklXnpzU3V
 fFvAcBoSl/pQfyf4TJ8GIDzFGu5tbiYrO2nutAjwns44umu5OxVFxUB9oLmaA8bnx8Yln6W7FRA
 pwuotA0BqM1nr2nLMuN0GVmawGkKhRmahY7oHV7vqnwym7h0LcXQgEgJDggbcbsltxl86HGiOpO
 rHNSJPLngB3rfVCktec5e2x1DOxP9LXRDOPBKPJVDaIKUBW4jtzH8+0PnKoPqWMJhFdC97xq3dc
 HucRg2jQtmLWn0qXQIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120145
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/12/2026 2:44 PM, Max Chou wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add the 8 SiFive custom int8 matrix-multiply vector instructions:
> sf.vqmacc{u,,us,su}.4x8x4 and sf.vqmacc{u,,us,su}.2x8x2. Each name
> suffix encodes the signedness of vs1/vs2.
> The 4x8x4 forms multiply-accumulate a 4x8 by 8x4 int8 tile into a
> 4x4 int32 result; the 2x8x2 forms use a 2x8 by 8x2 tile producing a
> 2x2 int32 result. Both Xsfvqmaccqoq/Xsfvqmaccdod extensions are
> gated on vlenb >= 32, sew == 8 and vm == 1, per the SiFive Int8
> Matrix Multiplication Extensions Specification.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                                 |  8 ++
>   target/riscv/cpu_cfg.h                      |  5 ++
>   target/riscv/helper.h                       | 10 +++
>   target/riscv/meson.build                    |  1 +
>   target/riscv/tcg/insn_trans/trans_xsf.c.inc | 98 +++++++++++++++++++++
>   target/riscv/tcg/meson.build                |  1 +
>   target/riscv/tcg/translate.c                |  3 +
>   target/riscv/tcg/xsf_helper.c               | 87 ++++++++++++++++++
>   target/riscv/xsf.decode                     | 30 +++++++
>   9 files changed, 243 insertions(+)
>   create mode 100644 target/riscv/tcg/insn_trans/trans_xsf.c.inc
>   create mode 100644 target/riscv/tcg/xsf_helper.c
>   create mode 100644 target/riscv/xsf.decode
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 902db77218e..9c9f9bd645a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -391,6 +391,14 @@ F: target/riscv/XVentanaCondOps.decode
>   F: target/riscv/insn_trans/trans_xventanacondops.c.inc
>   F: disas/riscv-xventana*
>   
> +RISC-V SiFive (Xsf*) extensions
> +M: Max Chou <max.chou@sifive.com>
> +L: qemu-riscv@nongnu.org
> +S: Supported
> +F: target/riscv/xsf.decode
> +F: target/riscv/tcg/insn_trans/trans_xsf.c.inc
> +F: target/riscv/tcg/xsf_helper.c
> +
>   RENESAS RX CPUs
>   R: Yoshinori Sato <yoshinori.sato@nifty.com>
>   S: Orphan
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 211d0708ba4..d6db1cfb7cc 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -51,6 +51,11 @@ static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
>              cfg->ext_xtheadmempair || cfg->ext_xtheadsync;
>   }
>   
> +static inline bool has_xsf_p(const RISCVCPUConfig *cfg)
> +{
> +    return cfg->ext_xsfvqmaccdod || cfg->ext_xsfvqmaccqoq;
> +}
> +
>   #define MATERIALISE_EXT_PREDICATE(ext) \
>       static inline bool has_ ## ext ## _p(const RISCVCPUConfig *cfg) \
>       { \
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 542b7c264fc..4234f462716 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1358,3 +1358,13 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
>   
>   /* Zalrsc SC write probe */
>   DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
> +
> +/* SiFive Custom int8 Matrix-Multiply */
> +DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccus_4x8x4, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccsu_4x8x4, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccu_2x8x2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmacc_2x8x2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccus_2x8x2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(sf_vqmaccsu_2x8x2, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index 42d0f6d538a..c06526adb26 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -6,6 +6,7 @@ gen = [
>     decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decode=decode_XVentanaCodeOps'),
>     decodetree.process('xmips.decode', extra_args: '--static-decode=decode_xmips'),
>     decodetree.process('xlrbr.decode', extra_args: '--static-decode=decode_xlrbr'),
> +  decodetree.process('xsf.decode', extra_args: '--static-decode=decode_xsf'),
>   ]
>   
>   riscv_ss = ss.source_set()
> diff --git a/target/riscv/tcg/insn_trans/trans_xsf.c.inc b/target/riscv/tcg/insn_trans/trans_xsf.c.inc
> new file mode 100644
> index 00000000000..1677352689f
> --- /dev/null
> +++ b/target/riscv/tcg/insn_trans/trans_xsf.c.inc
> @@ -0,0 +1,98 @@
> +/*
> + * RISC-V translation routines for the SiFive vendor extensions (xsf*)
> + *
> + * Copyright (c) 2023 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +
> +/*
> + * SiFive Xsfvqmaccdod/Xsfvqmaccqoq custom int8 matrix-multiply extensions
> + */
> +static bool sf_int8_matmul_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           s->vstart_eq_zero &&
> +           (s->cfg_ptr->vlenb >= 32) &&
> +           (s->sew == MO_8) &&
> +           (a->vm == 1);
> +}
> +
> +static bool sf_int8_matmul_4x8x4_check(DisasContext *s, arg_rmrr *a)
> +{
> +    /*
> +     * vd  has EMUL=2*LMUL
> +     * vs2 has EMUL=LMUL
> +     * vs1 has EMUL=1
> +     * vd must not overlap vs1
> +     */
> +    return sf_int8_matmul_check(s, a) &&
> +           (s->cfg_ptr->ext_xsfvqmaccqoq) &&
> +           (s->lmul <= 2) &&
> +           require_align(a->rd, s->lmul + 1) &&
> +           require_align(a->rs2, s->lmul) &&
> +           require_align(a->rs1, 0) &&
> +           require_noover(a->rd, s->lmul + 1, a->rs2, s->lmul) &&
> +           !is_overlapped(a->rd, 1 << MAX(s->lmul + 1, 0), a->rs1, 1);
> +}
> +
> +static bool sf_int8_matmul_2x8x2_check(DisasContext *s, arg_rmrr *a)
> +{
> +    /*
> +     * vd  has EMUL=LMUL
> +     * vs2 has EMUL=LMUL
> +     * vs1 has EMUL=1
> +     * vd must not overlap vs1
> +     */
> +    return sf_int8_matmul_check(s, a) &&
> +           (s->cfg_ptr->ext_xsfvqmaccdod) &&
> +           require_align(a->rd, s->lmul) &&
> +           require_align(a->rs2, s->lmul) &&
> +           require_align(a->rs1, 0) &&
> +           !is_overlapped(a->rd, 1 << MAX(s->lmul, 0), a->rs1, 1);
> +}
> +
> +static bool sf_int8_matmul_op(DisasContext *s, arg_rmrr *a, uint8_t seq)
> +{
> +    static gen_helper_gvec_3_ptr * const fns[8] = {
> +        gen_helper_sf_vqmaccu_4x8x4, gen_helper_sf_vqmacc_4x8x4,
> +        gen_helper_sf_vqmaccus_4x8x4, gen_helper_sf_vqmaccsu_4x8x4,
> +        gen_helper_sf_vqmaccu_2x8x2, gen_helper_sf_vqmacc_2x8x2,
> +        gen_helper_sf_vqmaccus_2x8x2, gen_helper_sf_vqmaccsu_2x8x2,
> +    };
> +
> +    /*
> +     * The helper raises an illegal-instruction exception when vl is not a
> +     * multiple of the tile size; save the opcode so mtval/stval report the
> +     * faulting instruction if that exception is thrown.
> +     */
> +    decode_save_opc(s, 0);
> +
> +    tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
> +                       vreg_ofs(s, a->rs2), tcg_env,
> +                       s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, 0, fns[seq]);
> +
> +    finalize_rvv_inst(s);
> +
> +    return true;
> +}
> +
> +#define GEN_SF_INT8_MATMUL_TRANS(NAME, CHECK, SEQ)       \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)   \
> +{                                                        \
> +    if (CHECK(s, a)) {                                   \
> +        return sf_int8_matmul_op(s, a, SEQ);             \
> +    }                                                    \
> +    return false;                                        \
> +}
> +
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccu_4x8x4,  sf_int8_matmul_4x8x4_check, 0)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmacc_4x8x4,   sf_int8_matmul_4x8x4_check, 1)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccus_4x8x4, sf_int8_matmul_4x8x4_check, 2)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccsu_4x8x4, sf_int8_matmul_4x8x4_check, 3)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccu_2x8x2,  sf_int8_matmul_2x8x2_check, 4)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmacc_2x8x2,   sf_int8_matmul_2x8x2_check, 5)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccus_2x8x2, sf_int8_matmul_2x8x2_check, 6)
> +GEN_SF_INT8_MATMUL_TRANS(sf_vqmaccsu_2x8x2, sf_int8_matmul_2x8x2_check, 7)
> diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
> index a05ab642f41..86805b30cbc 100644
> --- a/target/riscv/tcg/meson.build
> +++ b/target/riscv/tcg/meson.build
> @@ -15,6 +15,7 @@ riscv_ss.add(files(
>     'vcrypto_helper.c',
>     'vector_helper.c',
>     'vector_internals.c',
> +  'xsf_helper.c',
>     'zce_helper.c'))
>   
>   
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index 9684dbe7528..41e3dd2fe21 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -1216,10 +1216,12 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>   #include "decode-xthead.c.inc"
>   #include "decode-xmips.c.inc"
>   #include "decode-xlrbr.c.inc"
> +#include "decode-xsf.c.inc"
>   #include "insn_trans/trans_xthead.c.inc"
>   #include "insn_trans/trans_xventanacondops.c.inc"
>   #include "insn_trans/trans_xmips.c.inc"
>   #include "insn_trans/trans_xlrbr.c.inc"
> +#include "insn_trans/trans_xsf.c.inc"
>   
>   /* Include the auto-generated decoder for 16 bit insn */
>   #include "decode-insn16.c.inc"
> @@ -1240,6 +1242,7 @@ const RISCVDecoder decoder_table[] = {
>       { has_xthead_p, decode_xthead},
>       { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
>       { has_xlrbr_p, decode_xlrbr},
> +    { has_xsf_p, decode_xsf },
>   };
>   
>   const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
> diff --git a/target/riscv/tcg/xsf_helper.c b/target/riscv/tcg/xsf_helper.c
> new file mode 100644
> index 00000000000..6e953d12493
> --- /dev/null
> +++ b/target/riscv/tcg/xsf_helper.c
> @@ -0,0 +1,87 @@
> +/*
> + * RISC-V translation helpers for the SiFive vendor extensions (xsf*)
> + *
> + * Copyright (c) 2023 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "exec/helper-proto.h"
> +#include "internals.h"
> +#include "vector_internals.h"
> +
> +#define QOP_SUU_B int32_t, uint8_t, uint8_t, int32_t, int32_t
> +#define QOP_SUS_B int32_t, uint8_t, int8_t, int32_t, int32_t
> +#define QOP_SSU_B int32_t, int8_t, uint8_t, int32_t, int32_t
> +#define QOP_SSS_B int32_t, int8_t, int8_t, int32_t, int32_t
> +
> +/* SiFive Custom int8 Matrix-Multiply */
> +/*
> + * vd may overlap vs2, we need to allocate an additional vd array
> + * to save temporary results of vd and write them back at the end.
> + */
> +#define GEN_VEXT_SF_INT8_MATMUL(NAME, TD, T1, T2, TX1, TX2,           \
> +                                HD, HS1, HS2, ROWS, COLS, TILE_SIZE)  \
> +void HELPER(NAME)(void *vd, void *vs1, void *vs2,                     \
> +                  CPURISCVState *env, uint32_t desc)                  \
> +{                                                                     \
> +    int it, il, in, im, ivd, ivs1, ivs2;                              \
> +    TD *vds;                                                          \
> +                                                                      \
> +    if (env->vl % TILE_SIZE) {                                        \
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC()); \
> +        return;                                                       \
> +    }                                                                 \
> +                                                                      \
> +    VSTART_CHECK_EARLY_EXIT(env, env->vl);                            \
> +                                                                      \
> +    vds = g_malloc0(sizeof(TD) *                                      \
> +                    ROWS * ROWS * (env->vl / TILE_SIZE));             \
> +                                                                      \
> +    for (it = 0; it < (env->vl / TILE_SIZE); it++) {                  \
> +        for (il = 0; il < ROWS; il++) {                               \
> +            for (in = 0; in < ROWS; in++) {                           \
> +                ivd = ROWS * ROWS * it + ROWS * il + in;              \
> +                vds[ivd] = *((TD *)vd + HD(ivd));                     \
> +                for (im = 0; im < COLS; im++) {                       \
> +                    ivs1 = il * COLS + im;                            \
> +                    ivs2 = TILE_SIZE * it + im * ROWS + in;           \
> +                    T1 s1 = *((T1 *)vs1 + HS1(ivs1));                 \
> +                    T2 s2 = *((T2 *)vs2 + HS2(ivs2));                 \
> +                    vds[ivd] += (TX1)s1 * (TX2)s2;                    \
> +                }                                                     \
> +            }                                                         \
> +        }                                                             \
> +    }                                                                 \
> +                                                                      \
> +    for (it = 0; it < (env->vl / TILE_SIZE); it++) {                  \
> +        for (il = 0; il < ROWS; il++) {                               \
> +            for (in = 0; in < ROWS; in++) {                           \
> +                ivd = ROWS * ROWS * it + ROWS * il + in;              \
> +                *((TD *)vd + HD(ivd)) = vds[ivd];                     \
> +            }                                                         \
> +        }                                                             \
> +    }                                                                 \
> +                                                                      \
> +    env->vstart = 0;                                                  \
> +    g_free(vds);                                                      \
> +}
> +
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccu_4x8x4, QOP_SUU_B, H4, H1, H1,
> +        4, 8, 32)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmacc_4x8x4, QOP_SSS_B, H4, H1, H1,
> +        4, 8, 32)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccus_4x8x4, QOP_SUS_B, H4, H1, H1,
> +        4, 8, 32)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccsu_4x8x4, QOP_SSU_B, H4, H1, H1,
> +        4, 8, 32)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccu_2x8x2, QOP_SUU_B, H4, H1, H1,
> +        2, 8, 16)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmacc_2x8x2, QOP_SSS_B, H4, H1, H1,
> +        2, 8, 16)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccus_2x8x2, QOP_SUS_B, H4, H1, H1,
> +        2, 8, 16)
> +RVVCALL(GEN_VEXT_SF_INT8_MATMUL, sf_vqmaccsu_2x8x2, QOP_SSU_B, H4, H1, H1,
> +        2, 8, 16)
> diff --git a/target/riscv/xsf.decode b/target/riscv/xsf.decode
> new file mode 100644
> index 00000000000..bb585046ab1
> --- /dev/null
> +++ b/target/riscv/xsf.decode
> @@ -0,0 +1,30 @@
> +#
> +# RISC-V translation routines for the SiFive vendor extensions
> +#
> +# Copyright (c) 2023 SiFive, Inc.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# Fields:
> +%rs2       20:5
> +%rs1       15:5
> +%rd        7:5
> +%vm        25:1
> +
> +# Argument sets:
> +&rmrr      vm rd rs1 rs2                           !extern
> +
> +# Formats:
> +@r_vm_1    ......  . ..... ..... ... ..... ....... &rmrr vm=1 %rs2 %rs1 %rd
> +
> +# *** Xsfvqmaccqoq: SiFive custom int8 matrix-multiply (4x8x4 tile) ***
> +sf_vqmaccu_4x8x4    111100 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmacc_4x8x4     111101 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmaccus_4x8x4   111110 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmaccsu_4x8x4   111111 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +
> +# *** Xsfvqmaccdod: SiFive custom int8 matrix-multiply (2x8x2 tile) ***
> +sf_vqmaccu_2x8x2    101100 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmacc_2x8x2     101101 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmaccus_2x8x2   101110 1 ..... ..... 010 ..... 1011011 @r_vm_1
> +sf_vqmaccsu_2x8x2   101111 1 ..... ..... 010 ..... 1011011 @r_vm_1


