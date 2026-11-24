Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1C606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PEa/jbQZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1fWy6mF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxCN-0004ex-QL; Tue, 24 Nov 2026 15:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVxCJ-0004d7-S3
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:33:04 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVxCH-0007hC-LV
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:33:03 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXOUB2036951
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 20:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7HCDt2wOjXFzVrYuY5wggoMlhoIXksCWbDDV9xZK/F4=; b=PEa/jbQZP5HUL+NL
 x1dLlKUH7JIjPjYQTpCXthfvnQVn8sYBn1rgjCeRvxa3cOzw0ULpENoyaZEbouGp
 86SxErn3vyPoEbAZRS9sxFDOBR/j6H4H8aBE24gTF1YX1Ee6U7ZdghWYildkPHHl
 +JATl6BtyJhCJ3kaUfmM7lnRBvltdql93aFSVOeSP4Z7OT2rDdDAbBsAxOr5d7Cg
 MgMuBYV0JDXKjb1YaSuUT4hey/8s2m+ArzZVpa8dQmxu7aCJgxtRPXrcgBnTHTXR
 nIocU1Yf5Oeiril5Q/qe/z7/FrA/Ob80JW5Pf6AMBEWvcwzfd/gdOs7d3ZfpbzE+
 hvhtdw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dngh82r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 20:32:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-92125ff2d08so31439356d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795552378; x=1796157178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7HCDt2wOjXFzVrYuY5wggoMlhoIXksCWbDDV9xZK/F4=;
 b=S1fWy6mFsM/H5jnRoeH9oc2HyBkFxAKK/v7MokcQHlIkZTMOBQ3xBTfLzgkIplbPgv
 apjsX/QXJfLUXg/qP4OH4yF1VZorKMcUfJI+KV0ne/DKZ4sEX70hO3I6lSPpHlXEKOGH
 ppc0lF3ajznQ1q98evBY/Xcbd30lOT5PsMJpocENDdA00uckf43AEwKEqeJtDvBZQwuS
 CVdXIYIfL6ryEHfYh1MqDH61wAKztukI4YAfATovZm3IvRYlctvCN5bFKAJUdbQdxyPP
 Hxc/AFaPNWUDK9L0ysIZUUv/RyQNmZx1V+ZkQILCjsvwyJn+s5yz7IN0wsY+wu5POWF+
 +rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795552378; x=1796157178;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7HCDt2wOjXFzVrYuY5wggoMlhoIXksCWbDDV9xZK/F4=;
 b=FhOGDBlY6A+/Zg9pJxo1O6cLuyLRdsUlglLHimh4hYa2Xhm2B005q+6I+v3h2kQg06
 HjJH6arWeBMy1T7pvyXZ3OJgyYTtMDfonyyPvJ5djdmvhBidaKF6CSHLUKQo2/zUILXE
 4hhLK7RTadTvXbMrwtj4xE5bTftGujC+6ADtFAVRS8hA1mEa/2BQCqSxaTHaPt92haBj
 qGkf/f72C1/MAJTsTp304IjbVCK6nRB6GSkaWBTKt4I/CvdH2k3ojz2ATA0Y5GCvX4ps
 3wOA3EsbGm8H/mdO6XCCIs24jeBLhjiXDuG5olyTjazbMCwtphQvW+lRBmjpW1/R0N/0
 JE9A==
X-Forwarded-Encrypted: i=1;
 AL+hErGCW5dCejnb1E9cui9s/9/44Cg/29zBha2kGYn0/6tzTmIWGZgXcQoxet87RcIbpdMcfNx+cs0r6AJc@nongnu.org
X-Gm-Message-State: APuU4Z/PHtZI7un/p78hi1CUvzd+NpKjns3bH6oRAuw6F1u1cVsNKbxY
 12M/Ob/MSyNbejeCZH54MSIPySbgEkgD8l4A9Pl8Oi+GbIURwNhg5jl6b8XxxtiNWuaO/LXapDz
 LNL2MRBV+WxiIs8uFrRktTQEwiztjSyZcGDA4d027ZA9A/mO23NWdoo6mAGeX89XZWg==
X-Gm-Gg: AZFdTZcmCMuW3LT76riookbbsgSiUoC8JrGUzUlCpaXMI+Uy7a/VrgK7GXA/Snn+W1U
 lgBUsECzkiIwlGlxXdebYrkLkOJjO4ta82LGpzDYzk78o7Ir5qUnG+KGiXCJo27nOL4Z18qOvOc
 VfoPk1kKDqsgwGK+iZ/iIPmFw+cJMEIjHJppSjw/lCH1hS1b82I7T9b/vi0PqFpIh2LAZyBBcHO
 JOluRQgJ65zhRptzrPS11S3uTuiExtTOGpKT1ao7vSHruvDV7q/CoRvYhQRnPIwEeOuc3TKEFtk
 mitWZ93losbl1/ZWLQwOgmaPtNBS7xl+5gn9/K2HY/s20PM8DAJM0przDICTLZ1zmX4gVZtTNUk
 rRmGnndZQaiEREtf4IPeZY96C2l8bqwStIp2reYF8D68ir17wQyQ94M/EYDGRE9/KiWXPfpCG0L
 tdd3QuaB2w
X-Received: by 2002:a05:6214:3d0f:b0:91e:aa6d:d415 with SMTP id
 6a1803df08f44-92134971a87mr279991506d6.5.1795552377881; 
 Tue, 24 Nov 2026 12:32:57 -0800 (PST)
X-Received: by 2002:a05:6214:3d0f:b0:91e:aa6d:d415 with SMTP id
 6a1803df08f44-92134971a87mr279990906d6.5.1795552377328; 
 Tue, 24 Nov 2026 12:32:57 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134796288sm142031056d6.6.2026.11.24.12.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 12:32:56 -0800 (PST)
Message-ID: <4b8b74c7-645c-42aa-8c3d-8214d5cebca1@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:32:53 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: use gen_goto_tb for vsetvli
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <20261111-research-vsetvli-direct-chain-20261104-v3-1-8d3a18474a68@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261111-research-vsetvli-direct-chain-20261104-v3-1-8d3a18474a68@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4MCBTYWx0ZWRfXxKXnpbU79w/A
 tC+E47DEuLzyB03RTlPsWxUdb7nMxp3D+/pNlTUBBEOUymfnaNZVip9rmlDjBg02aZehU9VFo9A
 zc5A4sitD/AvAE2lWAf3fEaV6doU+5Q=
X-Proofpoint-ORIG-GUID: CRp18X66hM0iOyXMtlgox4sgBkRetJov
X-Proofpoint-GUID: CRp18X66hM0iOyXMtlgox4sgBkRetJov
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4MCBTYWx0ZWRfX6X/e5bS8v8LB
 7Pw9EtNnON+B5WHBhIByt0QAfKr2+WHv7gnKN2aG5ZNt5bPrYR5G92ovQ50Mf2kMA30B7ljKwWY
 hkR24U3H74EaYGZWjhOtnUWxOYkHaP3qLmOB1hw6i0cTILzd+Xx4s2/cA0sUqhHFjXZgdWh/o2W
 +KSF9DYH4zr6YlTuTiEwYS01XmqblbsvJ0a86enjlRnAUbJA0iwk16ZhYQJLosDcqSViO7tQFWF
 UM3HfIHE8EMKGynLZ7f3UDSFZ3HF5GzYYokgBYGd3bZZ08oAn9oTlz9Ihim6yoP0QlG1zPTlDNp
 8iNNnZN9Mis1Qp6hy7LrMWhMz/3zZ8h0GRWmiHTp+rRbv/0LiyKDc/KwELtxxvjqOmp2cpDmsYA
 m41t08TaV1PA/ZkiezEhU65v5T+ZDToHwQFnDgo5/vz9xDklV7v7o+JW7U+pGLEAxB5mHE3VWVC
 SpnoFklh+QqKTEMsgIQ==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b05f47b cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=nKvrqBTjKRfVLtz3nkUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240080
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



On 11/11/2026 10:40 AM, WX Chen wrote:
> This patch uses gen_goto_tb() to reduce the overhead of the
> unconditional lookup_and_goto_ptr() exit currently generated
> for vsetvli.
> 
> When translating vsetvli, the immediate vtype provides information
> that can be used to optimize the exit generated by do_vsetvl().
> 
> For the vsetvli forms optimized by this patch, the immediate vtype and
> existing state update flow determine the other relevant translation state.
> Only VL_EQ_VLMAX can vary with AVL. This patch therefore uses separate
> jump slots depending on whether the returned VL equals VLMAX,
> enabling direct TB linking after vsetvli.
> 
> The register-vtype vsetvl instruction retains the existing lookup
> path, as its vtype is not known at translation time.
> 
> The package benchmarks measure build time with the RISC-V cc1 compiler running under QEMU,
> while the dedicated workload repeatedly executes two vsetvli instructions,
> alternating between VL = VLMAX and VL < VLMAX.
> 
> benchmark result:
> Dedicated workload:
> | Workload | QEMU | Runs | Median (s) | Min–max (s) | Wall change (s) | Wall change | Wall / baseline |
> | --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
> | vsetvli-chain | baseline | 5 | 2.154520 | 2.145543–2.173475 | 0.000000 | 0.00% | 1.000x |
> | vsetvli-chain | candidate | 5 | 0.492811 | 0.489481–0.499191 | -1.661710 | -77.13% | 0.229x |
> 
> Perf of dedicated workload:
> | Workload | QEMU | Event | Samples | Symbol | Symbol samples | Overhead |
> | --- | --- | --- | ---: | --- | ---: | ---: |
> | vsetvli-chain | baseline | cycles:u | 2151 | `helper_lookup_tb_ptr` | 2007 | 93.58%|
> | vsetvli-chain | candidate | cycles:u | 482 | `helper_lookup_tb_ptr` | 0 | 0.00% |
> 
> Package build benchmark
> | Package | QEMU | Runs | Median wall (s) | Min–max (s) | Stddev (s) | Wall change | Wall / baseline |
> | --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
> | lz4 | candidate | 3 | 79.506 | 79.000–80.063 | 0.532 | -1.25% | 0.987x |
> | zlib | candidate | 3 | 45.474 | 45.426–45.476 | 0.028 | -0.44% | 0.996x |
> | sqlite | candidate | 3 | 278.771 | 278.470–278.962 | 0.248 | -1.07% | 0.989x |
> 
> Signed-off-by: WX Chen <wxchen0913@gmail.com>


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> ---
> v3:
> - Expand the commit message to explain the optimization rationale,
>    following feedback from Sashiko AI review.
> - Add a benchmark result.
> - No code changes.
> v2:
> The overall structure is quite the same as v1 except that v2 considers the condition that QEMU forces
> `VL_EQ_VLMAX = false` when `maxsz < 8`, which reduces the number of `goto_tb` slots from two to one in
> some cases.
> 
> For `vsetvli` with `rd != x0 && rs1 == x0`, v2 also uses a single
> `goto_tb` slot because the successor TB lookup key is fixed for a given
> source TB.
> 
> Both changes follow Chao Liu's suggestions.
> 
> v2 patch link: https://lore.kernel.org/qemu-devel/20261110-research-vsetvli-direct-chain-20261104-v2-1-8e65aadfb6aa@gmail.com/
> benchmark link: https://github.com/zhenbaii/qemu-riscv-bench
> 
> To run the benchmark from the benchmark repository, pass the baseline
> and patched QEMU commit IDs to the vsetvli-v2 recipe:
> 
>    ./reproduce.sh BASELINE_COMMIT PATCHED_COMMIT --recipe vsetvli-v2
> ---
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 30 ++++++++++++++++++++++++-----
>   1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index 7e1295f33e7d4b7a2ff26cbf428f6b5d9eb682ff..17e8eb5ecaede655b58b5bdc9f10ff9284efc5b6 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -191,7 +191,8 @@ static bool require_noover(const int8_t dst, const int8_t dst_lmul,
>       return !is_overlapped(dst, dst_size, src, src_size);
>   }
>   
> -static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
> +static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2,
> +                      uint32_t vtype, bool vtype_is_imm)
>   {
>       TCGv s1, dst;
>   
> @@ -215,8 +216,27 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
>       gen_set_gpr(s, rd, dst);
>       finalize_rvv_inst(s);
>   
> -    gen_update_pc(s, s->cur_insn_len);
> -    lookup_and_goto_ptr(s);
> +    if (!vtype_is_imm || (rd == 0 && rs1 == 0)) {
> +        gen_update_pc(s, s->cur_insn_len);
> +        lookup_and_goto_ptr(s);
> +    } else {
> +        uint32_t vsew = FIELD_EX32(vtype, VTYPE, VSEW);
> +        int8_t lmul = sextract32(FIELD_EX32(vtype, VTYPE, VLMUL), 0, 3);
> +        uint32_t vlmax = vext_get_vlmax(s->cfg_ptr->vlenb, vsew, lmul);
> +
> +        if (rs1 == 0 || (vlmax << vsew) < 8) {
> +            gen_goto_tb(s, 0, s->cur_insn_len);
> +        } else {
> +            target_ulong pc_save = s->pc_save;
> +            TCGLabel *not_vlmax = gen_new_label();
> +
> +            tcg_gen_brcondi_tl(TCG_COND_NE, dst, vlmax, not_vlmax);
> +            gen_goto_tb(s, 0, s->cur_insn_len);
> +            s->pc_save = pc_save;
> +            gen_set_label(not_vlmax);
> +            gen_goto_tb(s, 1, s->cur_insn_len);
> +        }
> +    }
>       s->base.is_jmp = DISAS_NORETURN;
>       return true;
>   }
> @@ -244,13 +264,13 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
>   static bool trans_vsetvl(DisasContext *s, arg_vsetvl *a)
>   {
>       TCGv s2 = get_gpr(s, a->rs2, EXT_ZERO);
> -    return do_vsetvl(s, a->rd, a->rs1, s2);
> +    return do_vsetvl(s, a->rd, a->rs1, s2, 0, false);
>   }
>   
>   static bool trans_vsetvli(DisasContext *s, arg_vsetvli *a)
>   {
>       TCGv s2 = tcg_constant_tl(a->zimm);
> -    return do_vsetvl(s, a->rd, a->rs1, s2);
> +    return do_vsetvl(s, a->rd, a->rs1, s2, a->zimm, true);
>   }
>   
>   static bool trans_vsetivli(DisasContext *s, arg_vsetivli *a)
> 
> ---
> base-commit: a3565937b39779d4e3704298095f566e7559ad53
> change-id: 20261104-research-vsetvli-direct-chain-20261104-206bc2104ddb
> 
> Best regards,


