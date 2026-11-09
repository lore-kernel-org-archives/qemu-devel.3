Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC678606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UNeqSOM/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jIOgRfWB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXKO-00014s-VL; Mon, 09 Nov 2026 16:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQXKG-00013Q-EF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 16:54:57 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQXKE-00083d-9f
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 16:54:52 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9L9uhk1392230
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 21:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i70c+Zee1lZAtAxI6IGtaRyKUi0eJJ6JjXWPXcv+m6M=; b=UNeqSOM/5f15XAqN
 rA9uq0gU3/eMY0W0a7ILDENr50iArsY2prnq5SL8o0B2NX7tbyl9Rg1dr94TgkYM
 +A39NvXvLp0Co6+/G5XKqyeiw7F4tnPqGHZ3Rpmyhq+/fVfWBSHekxqXPFH/DNuw
 8/uWe31ixRD9PnGMerZ7o05vrL1oaD/7aqlpeO5+wlFN+ZFcgNDG4FHUPxodu/bm
 s5xVMHoBZM6FYz/xJgtPM5GqKygZKFdutGHtVtJesjcSou94y44X3xzbbO2txnWB
 aBu/Mkaw8AfiJ/6zO2aWsSi0dLNV8Iw2VatPts12Tb3HXUdUizD3l64QsHMgDvHJ
 9qamWg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5tawn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 21:54:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so288975185a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 13:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794261287; x=1794866087; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i70c+Zee1lZAtAxI6IGtaRyKUi0eJJ6JjXWPXcv+m6M=;
 b=jIOgRfWB2pvDkNN1c0SZg5YKECmNWZnhDI6rg0lfdCDS5FmbxUsih8aXx7wsBCN16i
 WRsqnbHmlUEFlqwjQf8cMSpEkBkyB/knQvVBnBdnCHsv+5Z1Q12sKKN9wQ3qpvW68odY
 057lA1fLR/7sGhqvaHhqueNlUvk8GMckuFnVU8VHjMzOxHDMll/JGBSM5aIn5ddwptZN
 jt9OYt+RtkPc/qhQmix1F9JgNwDRVWCImcj/4MlS05UT4HIbYOTY1rJNymt5kCKtQaWy
 cQeu0aLCn9yhIkRFdkFZeOtfvBuA+QkywF+FL5sY+cp0NxPtQQPyIAkUJA5pfLPMpjj+
 KQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261287; x=1794866087;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i70c+Zee1lZAtAxI6IGtaRyKUi0eJJ6JjXWPXcv+m6M=;
 b=cB6kHV/l4ImFnAB/11RIUoSMrLeP6QUn2DU3IVAYjqMG+k1p/0e2yCtvxlGZCR0LBi
 6ZfJNZAkJNie1VNuBEaJQW1jMOOLI9kmtzR36tScznI2lVmaJ/1NwsFODSI650TjmG4L
 dbwDLY4FBjAiH2rqyU8UU0PPYWkQBheslMiiVKsOCIlJQAbPy5KLAGveyeUyk1j0S6QT
 n16Qg8x4Xi6Hl1c1zb3eRKO0ZdRN06uR67i6ogyzV+rRiCeXzIs7lY3pbxkV6+KdewV7
 GTCDn5NfjGvab4GvttRH3F0PSdfeU1ajX+sZjqYYQ1scRtOTB2stP2xUHJ7IKU+I4kVF
 sv6g==
X-Forwarded-Encrypted: i=1;
 AL+hErFBoavXCtO85kyqujQugp3vtvuJpxNiZT5OI/kWgL1OjiCx4hfRO0E7aUdfbnh5/H5b8RVaDyVtZWtz@nongnu.org
X-Gm-Message-State: APuU4Z/OR1PNO2xau7x/q42rhT2Yq2vO1f/dcESWUVpw24XOS/0LOsC2
 8lYCwA98WW2rgGRaiK/mbrsuElH6qOiwfG8Xoet6y2WutWqWybMywrzoABqANrwQOnmYrH16w6B
 LsNxGcPLupzng9oR6D0kLtAngUxq+TxwgxlfApO41LYB9+nms3SZGObs+mZwgZht4Yw==
X-Gm-Gg: AYBFou3FXN+yfTDfAOz2PK2O/fUHftwPh2Lttafz56m1jGLZ5tWHyKiTVniZRdToMZK
 8tO6cm0woEQTLlM76ErmxPZk0AXyDf7yl7dUr7yd6z4bv6r/AfubvBHxF0vBW/cbIUmGS+9AUMp
 gA9Dh28UHBI8HAf+q0ORe4sudSjWuUQ3s8P6s+kQt6M4co9ueLoH30sgIVJHSr1piz7CKjapwau
 Upp7g8rkZ+u1XgwFgXr9OO8ngvYFc2gSv4tLpeu1i4F43hOdQuRZEEU/pTQ4nxnoxLR9wQQZUH7
 1QDPKgw2w4vp5r09HrvB2q1n2s1yQfJ+lzOMWp2yBREOQHlA3sC9WRTwdG7vm2VQ0fMcoIwILMI
 KQnzUuIWCKFnSajzAFZF0mxZ8f1J8+gEPvTjLVlYQGClMceusOYNUJCqQC7+x1+KyNcL80rjnXl
 ygoNGz2PDd
X-Received: by 2002:a05:620a:4804:b0:940:ed10:aedb with SMTP id
 af79cd13be357-9479f2b507bmr146084485a.30.1794261286634; 
 Mon, 09 Nov 2026 13:54:46 -0800 (PST)
X-Received: by 2002:a05:620a:4804:b0:940:ed10:aedb with SMTP id
 af79cd13be357-9479f2b507bmr146080785a.30.1794261285962; 
 Mon, 09 Nov 2026 13:54:45 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e4fa312sm77986185a.0.2026.11.09.13.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 13:54:45 -0800 (PST)
Message-ID: <71841993-e3d1-4e68-aeaa-23504ed30000@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 18:54:42 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: change mstatus bits for read-only if S ou U
 unsupported
To: "Christian S. Lima" <christianslima@proton.me>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20261104223049.86286-1-christianslima@proton.me>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104223049.86286-1-christianslima@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NyBTYWx0ZWRfX0VKZBWHbCDz2
 Ez37foCBo0MzPNcZfZZzRxmUf8urOX+Adpvp4H2uaONcbItBdmhcPPk1KphFL0Gt8JN7ByMjg5d
 8jPFnmvccMyR2Q2uiGuBThbMPJm4BK8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NyBTYWx0ZWRfX7xkgyLHnpFMG
 Zwmorl0qPKPybcloMTXHSokl0Vc6tWsU3BA8tBD0dSpbyzFtMBH3y1G8lW9BSCo1EJqGZ+pwrG+
 1OPm+GuWGNVbxUkFjRDTRRmfbW81w7pO/4MMHw+wd8QGMldIv9TKxDIr/zSN5ORtZNDnM0xEYsu
 zBQTEKZ5xv9pLNmzNvRzEf89OpVpLYbTx7pG1B0SUWIT+QsGOPbjOOAQuKAIi9hEnE0tleBvlnJ
 Z8OH9sZY28OjcqXrOCA4wNf6COOfLQ74dWDvohgxCrSH2PVIzeduuv1OjDgO6cVLAxAOYeWRbRL
 gtBp3dZI9disR2Vt04IBJ0zL+VOP7CV6dV+ILXMbwGOsrLcn+5yTAapUStkCqzagflKlLxxq+Az
 8OYWb7bVkDTirVTxfUZI8eo6PftMH5Iz9R4HAJV5RGwSYZc1/8hxFjv/cwas6hIS9HBN1yckMko
 Zuc+P26zpQry+NKTnlQ==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af24127 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=vj57d5e9NL1TrQ48-lsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: _rR10lDO0bI484bbO4GRPO82AmVOAXJ1
X-Proofpoint-GUID: _rR10lDO0bI484bbO4GRPO82AmVOAXJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090087
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 7:30 PM, Christian S. Lima wrote:
> The risc v privileged architecture says that mstatus.SXL, UXL, TSR,
> TVM and MPVR should be read-only when S-mode or U-mode are not present.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4456
> 
> Signed-off-by: Christian S. Lima <christianslima@proton.me>
> ---
>   target/riscv/cpu_bits.h |  4 ++--
>   target/riscv/tcg/csr.c  | 17 ++++++++++++-----
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 3579789a1f..ee7981c91e 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -668,8 +668,8 @@
>   #define MSTATUS_MPV         0x8000000000ULL
>   #define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
>   
> -#define MSTATUS64_UXL       0x0000000300000000ULL
> -#define MSTATUS64_SXL       0x0000000C00000000ULL
> +#define MSTATUS64_UXL       0x0000000200000000ULL
> +#define MSTATUS64_SXL       0x0000000A00000000ULL

Note that both values were correct - UXL is defined as 33:32 and SXL is 35:34.
If you had to change them to make this fix works this means that there's something else
missing.


I took a look to check if there were other places where they're used.  They are used
when setting the reset value of mstatus in target/riscv/cpu.c, riscv_cpu_reset_hold():

     if (env->misa_mxl > MXL_RV32) {
         /*
          * The reset status of SXL/UXL is undefined, but mstatus is WARL
          * and we must ensure that the value after init is valid for read.
          */
         env->mstatus = set_field(env->mstatus, MSTATUS64_SXL, sxl);
         env->mstatus = set_field(env->mstatus, MSTATUS64_UXL, uxl);



Note that there's no check if we have RVS or RVU before setting them.


If I squash this diff into this patch we can have the bug fixed without changing
these macros:

$ git diff
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 15c27f4ce4..4d42e20ce9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -997,8 +997,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
           * The reset status of SXL/UXL is undefined, but mstatus is WARL
           * and we must ensure that the value after init is valid for read.
           */
-        env->mstatus = set_field(env->mstatus, MSTATUS64_SXL, env->misa_mxl);
-        env->mstatus = set_field(env->mstatus, MSTATUS64_UXL, env->misa_mxl);
+        uint32_t sxl = riscv_has_ext(env, RVS) ? env->misa_mxl : 0;
+        uint32_t uxl = riscv_has_ext(env, RVU) ? env->misa_mxl : 0;
+        env->mstatus = set_field(env->mstatus, MSTATUS64_SXL, sxl);
+        env->mstatus = set_field(env->mstatus, MSTATUS64_UXL, uxl);
          if (riscv_has_ext(env, RVH)) {
              env->vsstatus = set_field(env->vsstatus,
                                        MSTATUS64_SXL, env->misa_mxl);
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ee7981c91e..3579789a1f 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -668,8 +668,8 @@
  #define MSTATUS_MPV         0x8000000000ULL
  #define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */

-#define MSTATUS64_UXL       0x0000000200000000ULL
-#define MSTATUS64_SXL       0x0000000A00000000ULL
+#define MSTATUS64_UXL       0x0000000300000000ULL
+#define MSTATUS64_SXL       0x0000000C00000000ULL

  #define MSTATUS32_SD        0x80000000
  #define MSTATUS64_SD        0x8000000000000000ULL


I.e keep MSTATUS64_UXL and MSTATUS64_SXL untouched and add the RVS/RVU checks in
reset_hold().


Everything else LGTM.  Thanks,

Daniel


>   
>   #define MSTATUS32_SD        0x80000000
>   #define MSTATUS64_SD        0x8000000000000000ULL
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index af444e3e6f..24eda54bac 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2081,18 +2081,25 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>           tlb_flush(env_cpu(env));
>       }
>       mask = MSTATUS_SIE | MSTATUS_SPIE | MSTATUS_MIE | MSTATUS_MPIE |
> -        MSTATUS_SPP | MSTATUS_MPRV | MSTATUS_SUM |
> -        MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
> -        MSTATUS_TW;
> +        MSTATUS_SPP | MSTATUS_SUM | MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TW;
>   
>       if (riscv_has_ext(env, RVF)) {
>           mask |= MSTATUS_FS;
>       }
>   
> +    if (riscv_has_ext(env, RVS) || riscv_has_ext(env, RVU)) {
> +        mask |= MSTATUS_MPRV;
> +    }
> +
>       if (riscv_cpu_cfg(env)->ext_zve32x) {
>           mask |= MSTATUS_VS;
>       }
>   
> +    if (riscv_has_ext(env, RVS)) {
> +        mask |= MSTATUS_TSR;
> +        mask |= MSTATUS_TVM;
> +    }
> +
>       if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
>           mask |= MSTATUS_SDT;
>           if ((val & MSTATUS_SDT) != 0) {
> @@ -2111,12 +2118,12 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>           if (riscv_has_ext(env, RVH)) {
>               mask |= MSTATUS_MPV | MSTATUS_GVA;
>           }
> -        if ((val & MSTATUS64_SXL) != 0) {
> +        if (riscv_has_ext(env, RVS) && (val & MSTATUS64_SXL) != 0) {
>               mask |= MSTATUS64_SXL;
>               val = riscv_write_uxl(env, val, MSTATUS64_SXL);
>           }
>   
> -        if ((val & MSTATUS64_UXL) != 0) {
> +        if (riscv_has_ext(env, RVU) && (val & MSTATUS64_UXL) != 0) {
>               mask |= MSTATUS64_UXL;
>               val = riscv_write_uxl(env, val, MSTATUS64_UXL);
>           }


