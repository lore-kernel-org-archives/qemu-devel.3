Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FC5FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABX0-0008M0-PR; Tue, 07 Apr 2026 14:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wABTp-0003Pl-Oz
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wA2t1-0003IY-FL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 05:38:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376f8oL3402359
 for <qemu-devel@nongnu.org>; Tue, 7 Apr 2026 09:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wY93mkuutKCGd+oRBLE++qvpS1/LodiZVWe0XmuFfF0=; b=YsoDgAs3o5JkX1G9
 jxYKFvm7B0WfLj/LFf/WeboPNngrXfKLUJy+BPO59ISnr02pCdkQMv8PbfmXZES/
 OTLcTROKuc3DvPB+9vLkhLsCsP1//XOurnR4JzTJqiT3s9RJ7b57GfhaqzHmj19U
 qPHusb03vmfg0Gq9MOvReKIIYxdD1W6DEs1zTWN1vksFn4Cl1lXKYiehjo3F2mjh
 Ki+pTz8Un9Byh4rja1kkA+hUFEiEr82VIxnHZt8sTr/R9F3AgZbJqEjdwNvDCNnn
 DPU+XgG9/srYTIU830TfhMUsnhFaOCBX2wzKaUZMfjzSRF4H9zShF+kHqfah0CeI
 Xv2Ahw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrht2xh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 09:38:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c68a134df8so4571503eec.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554697; x=1776159497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wY93mkuutKCGd+oRBLE++qvpS1/LodiZVWe0XmuFfF0=;
 b=GTUuDbBkZySDybGoJGAKFwntJbs11sGp2dLL83HTFHKcNevEqnlNoEzwP6neot6rdg
 8ef9HDGDz7mfjGbo/eG0oHbiZPrF5Sx9L453TOtqcpa5JoVYpYCG9zddLcC8NfZAQ3Zh
 I9X6WeQiSF2Qyx7S1lPlRhfdFDNnR6jLhgo13In3khF/VByNLvxf9K3Ny0TPdJVkUhDh
 7/dIbxgvq+3++NIoXNUbn5wuhwnuBbcrbtDvu5B2Dwl5ez/XX6cnofwVCK2DdEp+GmTw
 N1Owst2wwzsob8YAol14s/y3MJ0YvLpN5GtySdI1a/XAJIQJ7tC5QR3PE45gdQsyoV5I
 /tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554697; x=1776159497;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wY93mkuutKCGd+oRBLE++qvpS1/LodiZVWe0XmuFfF0=;
 b=pTmOn/cRDMZik5kn2mAcoMew88RqhMRcyY/y53ajdd4SxxBbyJnETuUifmogOGBOxy
 MLCOyuA8iW69e0yXtW96dGcoRwf3G5+/QEamzYzuZ+PoGy13vMad+wqqQpxr2SF3Sr8o
 40bK7aJyYXcwOMa9BVdJV2TPYjYhmM0m+qJwMAdOkgIHOdGkC1kJJRg0YqS72/ZGWspk
 gXqhH47lxEwy4jGUcqvxYO8yIKmxHpSRDbySlHo7WAspvsV3NUVSXB0UTm3eOXW+6wBR
 gtpbFLHmGrvkN1YoF775+lcc81JzEzk7HJaujJVPCWH/OOIgqgGCPff4SeNexDNcde76
 hmxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDfsiZcAl/2dvM+pB6C3EuMc11vsP8UqG4glfCMVNVVtEcQcix+PBWvho5zw88PuiL0dI1n9cNIfkm@nongnu.org
X-Gm-Message-State: AOJu0YzSRgOuzXi9E4KWWhHQteC/CO3B5TXj82lzGQeuKykkL2RcOE9B
 hZ/zSFF7dutCEttP+43H38/WDpUq5ULxm8zvne/ggIO2R8ycT27ZnOaAwda6S7EVH+jlp0zqNy8
 P0bwH2sfakLgf4Q/lRwfe+n9defdAhU8W+Erjd0ww9k2aw7qzbd5S5sk0mA==
X-Gm-Gg: AeBDietEVCfb2/ET0YIDOF+bOuFzkn5sf47D97ZXrvoAP+jBXxdG6QU4OTqV6YhxEzQ
 WWM9M/wSz7ItqEpX2UqERWItZV10pDBTJvbg8+P2/e3Kve5tU3Cr2mM/Wuwap6Y/0ev0YqbfFc6
 We3Kp8AqZzqRsghQPU+EYf+zl6z9QLLq/d3sSkVxE/4n6uv1eulKZW8BjB0iNNGGxB2dNSf5p+Q
 ei8ur8WWHBhXoENYHM2yM5rEZWcbutlWWMSwi9XwQ4YRs+oMfxJFGQadi771v8KvcDcGY57PrTx
 vguWRpQxUNepwKWKNWJ3BJ0N/Qhd5seNdroUp9GghUb98AxkoQeihipLk36NA6tscMUorOk0t22
 ru4n8FZrttFYDNCmrkdg+6DjmkLLETC74csQtTHoge5Yd7FNhkmNShzpE
X-Received: by 2002:a05:7301:1010:b0:2ba:a2fb:403f with SMTP id
 5a478bee46e88-2cbfb995d49mr7331317eec.21.1775554696650; 
 Tue, 07 Apr 2026 02:38:16 -0700 (PDT)
X-Received: by 2002:a05:7301:1010:b0:2ba:a2fb:403f with SMTP id
 5a478bee46e88-2cbfb995d49mr7331302eec.21.1775554696059; 
 Tue, 07 Apr 2026 02:38:16 -0700 (PDT)
Received: from [192.168.68.100] ([177.18.66.130])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cba5df5c24sm14048534eec.27.2026.04.07.02.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:38:15 -0700 (PDT)
Message-ID: <ad95d6bb-a483-4ef4-a217-a875b5f7a42f@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 06:38:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/riscv: Generate access fault if sc comparison
 fails
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-2-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260407043614.372871-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4OCBTYWx0ZWRfX+BfXsrxSBN/w
 HU+aCs1SYdU6noK9l6rPvTsgBBtjc0k4XOsBOPweudxk22UcIrOloLFpUSKA5YSmPQhMPtGGW0/
 yG0MgWmNiFuQYmlH22fYJqVDIX/alpl598sgBojnJcv0rI33lObO126+ZqzrdUFJKtuM5zAru3v
 4BvMkfcErk9qNidnDFG7lutqHFbGHZLAXZ9zOUI2zyUILvywcoUYdTmrXEuKEIgbinJPj1EMgX4
 j+JkuViLxTSs4JeF7ITLhQiC2wdwKvlbK1BoqDCSnnK13a4bOllHnn6vFKG9YSTjpQQr57L3UZs
 4OSvbeSYKUg14xESysN9VL37e5Hi8d9mkQeNPi5hFSm+pWqIr8k4gEvUL3HEDmyI1oMc6YtYS0F
 4pJXYvIFyZ2nfdQmJpA/0rylIEeftaempFeXH7H6gclu871e8zv281SEsATcX0dY/zy9Ovs2252
 qZn+1i0WxwBwTJLDzjg==
X-Proofpoint-GUID: _rc7IT3zOs2IPsg1jviTqMKQZRTvsvoJ
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4d089 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Wg2i10Q8swPuJs8jTFC2sw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8
 a=HP2WlKXDqiIK0ifKYkMA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: _rc7IT3zOs2IPsg1jviTqMKQZRTvsvoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070088
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V spec states:
> 
> "For the purposes of memory protection, a failed SC.W may be treated
> like a store."
> 
> So if the comparison in sc.w fails we should still check for alignment
> and do a probe access to check permissions.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
> Resoves: https://gitlab.com/qemu-project/qemu/-/work_items/3136

Typo: "Resoves"


Also, IIRC the bug URL that automatically closes Gitlab issues when
merging the patch is on the format:

"Resolves: https://gitlab.com/qemu-project/qemu/-/issues/(number)"


Maybe this URL with "work_items" also works, but even with the regular
URL Gitlab fails to autoclose the bug sometimes.  I suggest changing the
"work_items" to "issues" in all those URLs to be safe.


That said,


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/helper.h                   |  3 +++
>   target/riscv/op_helper.c                | 14 ++++++++++++++
>   target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index b785456ee0..af6cfcfc27 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1289,3 +1289,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_1(ssamoswap_disabled, void, env)
>   #endif
> +
> +/* Zalrsc" SC write probe */
> +DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 6ccc127c30..b569366369 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -281,6 +281,20 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
>       /* We don't emulate the cache-hierarchy, so we're done. */
>   }
>   
> +void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
> +                           target_ulong size)
> +{
> +    uintptr_t ra = GETPC();
> +    int mmu_idx = riscv_env_mmu_index(env, false);
> +
> +    if (addr & (size - 1)) {
> +        env->badaddr = addr;
> +        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra);
> +    }
> +
> +    probe_write(env, addr, size, mmu_idx, ra);
> +}
> +
>   #ifndef CONFIG_USER_ONLY
>   
>   target_ulong helper_sret(CPURISCVState *env)
> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
> index a7a3278d24..62c0fe673d 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -90,6 +90,12 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
>        */
>       TCGBar bar_strl = (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
>       tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
> +    /*
> +     * "For the purposes of memory protection, a failed SC.W may be treated
> +     * like a store." so let's check the write access permissions
> +     */
> +    gen_helper_sc_probe_write(tcg_env, src1,
> +                              tcg_constant_tl(memop_size(mop)));
>       gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
>   
>       gen_set_label(l2);


