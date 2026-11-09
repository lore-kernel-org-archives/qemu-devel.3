Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAC606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TilaU1ia;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fnt6+YU8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW4o-0007hT-3W; Mon, 09 Nov 2026 15:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQW3L-0006P9-Iv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:33:26 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQW3I-0007n7-Rc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:33:18 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9JfuU41830322
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vVaHhZtuYn3eGFHpSIWVgo4pRWYw/mhN2RLIPvYjJIg=; b=TilaU1iax7VAA7hb
 aD7PmgZx+7sTMVSpM21I60gW3o11Y0FbHO5Qj/ZqLi2CLDibTOuRUkIwMfNQ6euf
 582RnX3mac6G8i+89ZCEC9tLjWal5SBTlPNVc3MPIFLsnRaEFd+yb8xBWN1GcW3c
 aS4lzxXqUc0CEyJwynWwerGIx0BPrzNxgzK3vJiXEMrxNklHh3xcLXZreJSpznTk
 Qy0vrC5R077czv+ML97ts51+xH8CYlC+ItkeWwi0EPhyLiVq8opPM/SMtAhv+uWs
 hTZ1zGHvUABh4XivOMF0LJc9bs7j1UgvDYE+gDfThYLCApQmjK80JvRCn8Y3XlmK
 gVo3cw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg05c0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:33:06 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91eb556c8a0so26141966d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256386; x=1794861186; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vVaHhZtuYn3eGFHpSIWVgo4pRWYw/mhN2RLIPvYjJIg=;
 b=fnt6+YU8VEDlWTdbQ+aF+4ekG265aBSrNzM277mWEY5u9aQyZ8bmRF6rCaDxoR6/Ps
 kmUod9881GXii43QVjW2E4NnQRU9IEUYsm3opX5proIJXxlhoExkl53PX4U8rgpZvfYa
 ZEUng0jY3izhYAh9MW71O7h/MAgv0KsnlDddWh41qcxkEAXHvPEMnPeD1+QR73MY6Cgn
 AgvIsaMlfUdakQifNRzIwprvQIIO6XSKyrW5nELWdaVPezuyfEaBAuU4KxTF1ToX1WIi
 PQ9YlIJ9BH/7cxXcxKaEXIw3tgnzT8M02Bwf0/873feZqXPxYE3e6hpvdGsT5hzc5XXD
 Xl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256386; x=1794861186;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vVaHhZtuYn3eGFHpSIWVgo4pRWYw/mhN2RLIPvYjJIg=;
 b=ShmdYJ8Cfk2Yrz/AxbOIhi6yHup4/cUq4kqgpXZF96CY7fFB65LspPxfkOEKwL4QoB
 2ozjWGi08LyJH74m05WNijlRaYHdfn53IJEBGQd9GmZ0Nt88iBaJCc2VKNFocLgjAVul
 W/rmIpqmvCko+9p6s1pQLLtM/BZD2s55GdpEDieP0E/4VDB/YIxddvMTvVbVqFZe4sZd
 YcxQoFkomrKRIkSC4aQ6CRwfrBrUNKjuvfDPuDGcC11eygDcFClEo5Xmb6Bn0neQFK6Z
 PoB+hHg8MqRZRE3tOmxzg+Uy9SWzL0XYYA+8b6uvHvsOGtIUjvLWhmW4c6jH266Ujv8o
 o71Q==
X-Forwarded-Encrypted: i=1;
 AL+hErH5XGxq8KuEi7EieyKmRnsk9ggqh6Xi2ikyPD9EhdGJk7YfayyFqEkREFJuLQEgwlgxuDphiYXoE+KM@nongnu.org
X-Gm-Message-State: APuU4Z99Bu8B/AYskESze1hD7/mtZ8zChUpuiREt+oqMIrbLz6QdwYeL
 Ge6amQf0CYvlQmjOIWOJFy3Q/rMQ+HEuB7iV/iGmHD8wIsqJLBNIzhkQTiPcru8cKev2mjke01j
 EvFrfPLSFb262WUt20YXsWcU3hPufQlWuDTpMfz/7T6Ye9dFwX44NuTBRJw==
X-Gm-Gg: AYBFou3csTOxmx9QZyYtA70YaWxtDlHSxI3mLhYX63AGZblc3iTbwVRgvFvnpfKHsbH
 zsiAa2E+cNuRvtQMjSFhkoAU+XF8bg1pr5ALVRRBc3zhrp42dbFpE5/pd9i4H0tbEy/FpvOZEIx
 +bnUrxIlxUpNCAZimu5lljqFITuqKvzp2jubBAG/uA5blSHrk38XTNH8Vq/7jQ1Cm39OKK5CLYa
 K2cgsQ+HkmKNw36pGWEK4a+F+ua/pPiGxOYyMgakDXRb2jxB88VtIqTKDhlCKqBufw4RdxOd+vK
 /gnlHB+gY73rsEzp/qiZzXSiXS+pcjXhFhhGp76RLfBWqq2JUq7IGmyZ8RKUTGBDYBJJqUPpZ+2
 iBUD9NFC90PxA0QTRS2iogA6UqdhxEKXb0Tl/6CKm2x7TkVkeUKYIPGqfIVOC5eVCVlBLpgSJwg
 Q/pIgwjrl3
X-Received: by 2002:a05:6214:29ec:b0:91b:d5d7:8c84 with SMTP id
 6a1803df08f44-91eef5e13c5mr14247966d6.7.1794256385933; 
 Mon, 09 Nov 2026 12:33:05 -0800 (PST)
X-Received: by 2002:a05:6214:29ec:b0:91b:d5d7:8c84 with SMTP id
 6a1803df08f44-91eef5e13c5mr14247346d6.7.1794256385219; 
 Mon, 09 Nov 2026 12:33:05 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04b01c8sm4421376d6.10.2026.11.09.12.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:33:04 -0800 (PST)
Message-ID: <84403cca-b624-4ac5-9678-ffeceeb77c1d@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:33:01 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 23/38] target/riscv: Add cfg property for Zvqwbdota16i
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
 <20261104194155.679241-24-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-24-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfXyjfpPzN/JG8p
 LFsztlmdesYZLKFQ+oC7nYIeA9otzfF7GJhuFf9qsk2zaNSUwYyJH9NiNg9+vMFI8rrk8zD7chv
 5ddxqJmTR2uciqT+wEA3Sh585zZDvJ3kcRpWQDp6puvOa2CGQjNVcxovU7vSVn9O2t9Dba0nARQ
 JDviV468mIr6F0J8bsSxBSPnJeO2HWjHB+UkuuWYla+/xyCI+kZ70mjopsilL+XM+DmZe5JA1Cm
 nP1LiRiteCjqwtuouI1ihfg+fEv44i37NVcx8LBkxFuDoovMqsFA8JBX62QFoiQLWc/P9p32Yjb
 ug2Zd7YX689NWG8BjUe3Y0U/8iSwVRvLvr7XJ091WNZ9jEqUWpNzaKKnzyhdv++i36POg0gMucE
 4nTr+lBrUzyZ31lAP8u4KhhZM53aAyHBlXsttaU0kQ2eqyBNKVikdojnz/cba7oeZEZl3yUAc+g
 xOh5H0v6ZA6CFaBuyhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX7TVJZYAfVVPU
 /22/ohAK+EtLcX+TZG//ru1NsA8XlSi1ojXwLay+bpD24uXjcWF5GFXCX1JG05C5mYbQHWE5FLJ
 AxoYdwTP2urAY0GXVRWNebdVPFYlHU4=
X-Proofpoint-GUID: REzH8rKeyeasAZUe_9SowzUSFkTuIwVv
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af22e02 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=RypaF7NShuVFdLthz2oA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: REzH8rKeyeasAZUe_9SowzUSFkTuIwVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090081
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add CPU configuration property of Zvqwbdota16i extension which depends on
> the Zve64x extension per the specification.
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
> index 26d5ac69c75..99c82b898f0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -254,6 +254,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
>       ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
>       ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwbdota16i, PRIV_VERSION_1_13_0,
> +                                    ext_zvqwbdota16i),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwbdota8i, PRIV_VERSION_1_13_0,
>                                       ext_zvqwbdota8i),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvqwdota16i, PRIV_VERSION_1_13_0,
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 3d822432d48..83a3d8a7f9d 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -108,6 +108,7 @@ BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
>   BOOL_FIELD(ext_zvfqwdota8f)
>   BOOL_FIELD(ext_zvfwdota16bf)
> +BOOL_FIELD(ext_zvqwbdota16i)
>   BOOL_FIELD(ext_zvqwbdota8i)
>   BOOL_FIELD(ext_zvqwdota16i)
>   BOOL_FIELD(ext_zvqwdota8i)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 782e38b608e..8735cf94f35 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -716,6 +716,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvqwbdota16i && !cpu->cfg.ext_zve64x) {
> +        error_setg(errp, "Zvqwbdota16i extension depends on Zve64x extension");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>           error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>           return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 9e872eccaeb..5ea073b6d76 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -42,6 +42,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>       if (riscv_cpu_cfg(env)->ext_zvfbfa ||
>           riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
>           riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
> +        riscv_cpu_cfg(env)->ext_zvqwbdota16i ||
>           riscv_cpu_cfg(env)->ext_zvqwbdota8i ||
>           riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>           riscv_cpu_cfg(env)->ext_zvqwdota8i) {
> @@ -101,6 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       case MO_16:
>           ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
>                           cpu->cfg.ext_zvfwdota16bf ||
> +                        cpu->cfg.ext_zvqwbdota16i ||
>                           cpu->cfg.ext_zvqwdota16i);
>           break;
>       default:


