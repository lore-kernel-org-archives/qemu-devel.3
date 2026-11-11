Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15846606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 21:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UARW36wM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PrwqGCmb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRFr8-00010G-5w; Wed, 11 Nov 2026 16:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xRFr5-0000yN-2m
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 16:27:43 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xRFr2-0005ml-Nl
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 16:27:42 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABIpXxK2177112
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 21:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2vNgxrBXLUsVx1AlhgD9c+z/XOlEqj4wx8Rr7Mv5Qys=; b=UARW36wMSFGg5/xj
 O0OGPPzV+6gQ0KHR9DyeoziSQo2aP/LwovfCHQEfz8gYBM7NeTVJlauvZl47HB8X
 m2uRrHHS1O7faq/Spj+Ispy6KZXLQ42ltx7QiITAiMU3QPpoyQXW+HjbD3KzfqS+
 ivRj/wHYvil94aLnAVDNbDcjHgGZJe6N1/c43yKRUTblRT1lA/P3gOpPAIiNW8cy
 kK1ifFZJcu3W0mOGYbr/fkVvrMlsrNCQy+AGGaZYUFM+lloYAQ5XuIIWclLT/33J
 Pa421PifCPLXjbzo1DPAnVa0E7vxAUbLlf7Od+XdR9lAXYlj/4OuQPWqKkFlJR2c
 ACL49Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7pu9mf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 21:27:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-37549877380so3351888eec.0
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 13:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794432457; x=1795037257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2vNgxrBXLUsVx1AlhgD9c+z/XOlEqj4wx8Rr7Mv5Qys=;
 b=PrwqGCmbHVis5WW/+yzGcSVMbZEQtBDIJmMKyAsjEvE+1Y5+ClCrzEtFoiykhICLw1
 Aa4hE+cQwT8Un55lYj4Zb8siMR2XqkNdoG6zl4BEqtiBZDYs3uUEDFnNyugHHqbi8Edw
 nHBwAbtxSnszuXRVHHRvwxpODnvunm3GdFTXPFjbnDeUEuol5Cg4gMoq499OpDE2C9I4
 fxC8Mr+B0F6zvAlIli0cWjJbc6QRgmThJ95ia6KtXitGsR08uZbox/5qotFekOZ/X9T7
 238E+1o++IPZskWXWHbSDlvvhryATwdqbR5onSgajjkfxsvc8CYeSDGS0ZPczl4GK25A
 MmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432457; x=1795037257;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2vNgxrBXLUsVx1AlhgD9c+z/XOlEqj4wx8Rr7Mv5Qys=;
 b=uuN4SMroKst1z8rBvE6+wJoZP1zoSasvi8eqlgRTA16MbDwpgw+R2NlC3mj+qGK7RO
 0vct5CidVeXATOlX/MzqxW8/S9RRF8zBDlmKkq464UIM1Vv4Zc3qT/Hw5VGCBBGh4Qxe
 tv8pxnFYV/Jq5XYpLvpnrEnjvnwTLpJP0Quu1O2SpByS1PWYw/q/LmgJub+ckztgdSfx
 Srd2zgiyxNwsip3Rs+apw7+dEZi5wujtgG9MU/DMSqxUtdHf/LV3zXnfWfa9wCAqFw++
 sf8yGzXt05Fz4y2kQCs2JO+GEuVR7Y+28YMe/Q0JKJOoKXVv0dhxEmKDuJnkVfn0zj4g
 rbfw==
X-Forwarded-Encrypted: i=1;
 AL+hErGN0rV1ryB0kH2n/LxYDL4tcoYF3IGWY0ttfIL4C8a3ZPhjilbhhxEunJBifUyfcwTrn5e029+oivNM@nongnu.org
X-Gm-Message-State: APuU4Z8S+M/K+aCaFMTtlRDOsWcaG2aFM0L0QGtyWYrxIyqCfYRuhEvX
 tUf/A/j+VykARXs/dr4GmDKCtOAouBtYzcKA56vFKTWdIK63B89zY11Y0pN5fcE+1BEEo7k1CFN
 OCOkGUWpZ7w2NVNP8Uve0sC8OxHZCNAB+fbCYTDkj9e2rdRgvQHHRFVBpFg==
X-Gm-Gg: AYBFou28+ln9B7OMvnFallI2ykf53EVvHtcBRnxdBq28S3oi7+6yf4/4E4TwKrC4gk6
 AIa9j1Nn/BDU21Gy+g+hDEw47SM8fqDPjuVc/pjCnWABbhJBozoJHZSSHjX7LzDy+CPToy7ag6f
 NonmpzWBHG5o3LU7l45lSFY6cuQnAfSfzn+0WDeFm2jgQ+P2jlyV85ngNporEdFC+3YcMVdj2ax
 SgpDTuzptNEtQx/FV6f4eIduEYjhYAu2hT6qhq3WBUoiRFeL7EDSCr9VY7W3ny7PxtmhSYuZ9uU
 syiF1/QGD3t/kLkEizUGymdMjdqmUeoxuf7Mdhzy2zDYkLPvvYzxGQ9IypWsusFayQbiO55/B4j
 olpXnFOyVLLrvLTsDYULxsJxNU18UUe2x0Fesop6XPB62Hz+IS4reIcOPY8vmGbKztf6zLBZvJ2
 NYXqYZw0QCiNIa8o7hnuIgGlSnbyvptXKEdP84w8sGTww=
X-Received: by 2002:a05:7301:dd98:b0:369:d486:457f with SMTP id
 5a478bee46e88-37683861625mr4145679eec.2.1794432456552; 
 Wed, 11 Nov 2026 13:27:36 -0800 (PST)
X-Received: by 2002:a05:7301:dd98:b0:369:d486:457f with SMTP id
 5a478bee46e88-37683861625mr4145647eec.2.1794432455820; 
 Wed, 11 Nov 2026 13:27:35 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520cfdfc6sm21102393eec.17.2026.11.11.13.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 13:27:35 -0800 (PST)
Message-ID: <fab0d3ff-8f4a-42a1-af37-0f9c19d8eb52@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:27:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: avoid amocas.* x0 clobbering [GL3526]
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20261111205043.327652-1-daniel.barboza@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111205043.327652-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA4NSBTYWx0ZWRfX2CAwbxe13OUu
 Pn1ll9V3zYbovHvaYZ8FO2OAfDLefBSIkw3SgfXJPDQV+5aQmwLipoGUfYMn91uzV34VobiEC19
 S0AR8/6ujywxMYkGJqpHXl4Nj8s+9FI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA4NSBTYWx0ZWRfX0fy4dFfrq/Rm
 ygauIExjK3fA8FZj1L4ByblKsPi3tjXAwB/poLQSJbu/VpyKI2mYhw0N/QYDL4HbxeJpXVIFWMV
 N+/A0PMs2i7Bb9ykxIkAi/7jC3jtpikwv8bX+ad+id8hvo4F93WCwFJ3+hOIT+ZWrL7M8y9TGpR
 FIEC74zFC/HBWWGi7fuRyQ02hvy9cfLTAFOBdW89UDMRMXLd1oYfYQ+61W1aPXFGwgSaCd4M7av
 ktnGeFs9ojTfU8qtRVXzEX0l0YYk0zipRb01JoTDrc7V9557ntyVMQBMl7c2OqfIUaX0Ey9JlUF
 cPWemRFyD8euzDnEtK2PfgN29wB4+cYQ4onR2dYlxlZ5Xohlqx2QkmBaO1dJ7NsRye43vr4U4nT
 xNObnlQRA6naNRMdq9ApueTCA4lIg5QTxmo1n6chS7+3hFzzZa/BoRjl2FEZkL5wobWWbDTrL9T
 GiADnZUfffdHhcfoxgg==
X-Proofpoint-GUID: dD2DMGaasna4AJ1R20KxxCg1jbMGin5y
X-Proofpoint-ORIG-GUID: dD2DMGaasna4AJ1R20KxxCg1jbMGin5y
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af4ddc9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=Q7o18xxvtkWkwoK8JQMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 11/11/2026 12:50 PM, Daniel Henrique Barboza wrote:
> gen_cmpxchg* and trans_amocas_q() load amocas registers using get_gpr().
> When the register is x0/zero get_gpr() returns ctx->zero, the shared TCG
> constant that every x0 read uses.  As it is today, the amocas helpers
> uses tcg_gen_atomic_cmpxchg_* helpers using the dest register retrieved
> by get_gpr().
> 
> So, if we have something like:
> 
> amocas.d                zero,s0,(a0)
> 
> gen_cmpxchg() uses ctx->zero as 'dest' for tcg_gen_atomic_cmpxchg_tl(),
> which will end up clobbering it with whatever is in 'rs1'.  ctx->zero
> will be reset back to normal in init_disas_context(), but if there's
> something else that ends up reading it in the same TB, e.g.:
> 
> beqz                    a2,24
> 
> This will read a clobbered ctx->zero and then all bets are off.
> 
> The fix is to use a temp variable as 'dest' for gen_atomic_cmpxchg_*
> calls instead of the result of get_gpr().  We are already executing
> gen_set_grp() in all cases using 'dest', making this change a bit
> simpler.
> 
> Fixes: b52d49e97fc4 ("target/riscv: Add support for Zacas extension")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3526
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  .../riscv/tcg/insn_trans/trans_rvzacas.c.inc  | 15 ++++--
>  target/riscv/tcg/translate.c                  |  5 +-
>  tests/tcg/riscv64/system/meson.build          |  8 +++
>  tests/tcg/riscv64/test-amocas-x0.S            | 49 +++++++++++++++++++
>  4 files changed, 70 insertions(+), 7 deletions(-)
>  create mode 100644 tests/tcg/riscv64/test-amocas-x0.S
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
> index 79bca1e957..e908ed2377 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
> @@ -72,13 +72,14 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
>          return false;
>      }
>  
> -    TCGv_i64 dest = get_gpr_pair(ctx, a->rd);
> +    TCGv_i64 cmp = get_gpr_pair(ctx, a->rd);
>      TCGv src1 = get_address(ctx, a->rs1, 0);
>      TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
> +    TCGv_i64 dest = tcg_temp_new_i64();
>  
>      mop |= ctx->mo_endianness;
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> -    tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
> +    tcg_gen_atomic_cmpxchg_i64(dest, src1, cmp, src2, ctx->mem_idx, mop);
>  
>      gen_set_gpr_pair(ctx, a->rd, dest);
>      return true;
> @@ -117,15 +118,19 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
>      TCGv_i128 src2 = tcg_temp_new_i128();
>      TCGv_i64 src2l = get_gpr(ctx, a->rs2, EXT_NONE);
>      TCGv_i64 src2h = get_gpr(ctx, a->rs2 == 0 ? 0 : a->rs2 + 1, EXT_NONE);
> -    TCGv_i64 destl = get_gpr(ctx, a->rd, EXT_NONE);
> -    TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
> +    TCGv_i64 cmpl = get_gpr(ctx, a->rd, EXT_NONE);
> +    TCGv_i64 cmph = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
> +    TCGv_i64 destl = tcg_temp_new_i64();
> +    TCGv_i64 desth = tcg_temp_new_i64();
> +    TCGv_i128 cmp = tcg_temp_new_i128();
>      MemOp memop = MO_ALIGN | MO_UO;
>  
>      memop |= ctx->mo_endianness;
> +    tcg_gen_concat_i64_i128(cmp, cmpl, cmph);
>      tcg_gen_concat_i64_i128(src2, src2l, src2h);
>      tcg_gen_concat_i64_i128(dest, destl, desth);
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> -    tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx, memop);
> +    tcg_gen_atomic_cmpxchg_i128(dest, src1, cmp, src2, ctx->mem_idx, memop);
>  
>      tcg_gen_extr_i128_i64(destl, desth, dest);
>  
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index 79b0f444ef..b9f47a4fc2 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -1175,13 +1175,14 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>  
>  static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
>  {
> -    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
> +    TCGv cmp = get_gpr(ctx, a->rd, EXT_NONE);
>      TCGv src1 = get_address(ctx, a->rs1, 0);
>      TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
> +    TCGv dest = tcg_temp_new();
>  
>      mop |= ctx->mo_endianness;
>      decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
> -    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
> +    tcg_gen_atomic_cmpxchg_tl(dest, src1, cmp, src2, ctx->mem_idx, mop);
>  
>      gen_set_gpr(ctx, a->rd, dest);
>      return true;
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 3c8b018d9e..985c492a00 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -89,6 +89,14 @@ tests += {
>    }
>  }
>  
> +tests += {
> +  'test-amocas-x0.S': {
> +    'exe_name': 'test-amocas-x0',
> +    'cflags': cflags + ['-march=rv64gc'],
> +    'qemu_args': ['-cpu', 'max', qemu_args],
> +  }
> +}

Default exe_name is derived from source name by default, so no need to
add it here.

> +
>  if 'qemu-system-riscv64' in emulators
>    tcg_tests += {
>      'riscv64-softmmu': {
> diff --git a/tests/tcg/riscv64/test-amocas-x0.S b/tests/tcg/riscv64/test-amocas-x0.S
> new file mode 100644
> index 0000000000..d71814035c
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-amocas-x0.S
> @@ -0,0 +1,49 @@
> +/*
> + * Test if amocas.d will clobber x0.  Based on Gitlab 3526.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +	.option norvc
> +	.text
> +
> +	.global _start
> +
> +_start:
> +	li     t0, 5
> +	lla    t1, amo_target
> +	li     t2, 0
> +
> +	/* amocas.d zero, t0, (t1) */
> +	.word  0x2853302f
> +
> +        /* If x0 is clobbered this bnez will fail.  */
> +	bnez   t2, _fail
> +
> +	li     a0, 0
> +	j      _exit
> +
> +_fail:
> +	li    a0, 1
> +
> +/* Exit through the semihosting SYS_EXIT_EXTENDED call with a0 as the code. */
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	8
> +semiargs:
> +	.space	16
> +/* An amo target must be a valid, 8-byte aligned address.  */
> +amo_target:
> +	.dword	0x1234


