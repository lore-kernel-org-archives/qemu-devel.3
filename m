Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25D606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stKHs/yP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVNjb-0007Ed-R3; Mon, 23 Nov 2026 01:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xVNjR-0007E2-JB
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 01:40:54 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xVNjM-0003NT-2U
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 01:40:51 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ae1da332bcso1404009a91.2
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 22:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795416046; x=1796020846; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OQTBh4RkFv28G2ECotOS1L1P8TxPGOPGXXl+4AIervI=;
 b=stKHs/yP1PQYg8fY8AXQhAbObbO55bVBd9BS/RGqLSuk/pDg27yhkugtVWHzNDjhrw
 VsHVoTTZMKE6feswsxnz5RjJPk+Q1YkJGHc+zO1DC9tTjmK+eGEjLGsMl9NLUj80kqsm
 vjPvQUxs1Jty5GvXrG44oSdTy9ple85LjugXja9FS4FeRe7+8rglqTdZ0XjomWI4UFwO
 9Wp479WAbFdLZm0fts7nhE0eFqScEWtIu4UF1pjo0yVhn1bwvukWa5jMDFLuvRnmujYR
 67YQLG9Qcr2dSw84rECdav9zCZWlrwvLm8FtJmA2JLw8/XJs/a/R7iho++5eOW2bZJ5B
 5tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795416046; x=1796020846;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OQTBh4RkFv28G2ECotOS1L1P8TxPGOPGXXl+4AIervI=;
 b=MUw/DvZfHVgm9YYs2xA3ZduJ/xEIOEGl2jaRZO5cBTpL1JJCYU6NdvUy20bj5/NzJV
 waKsjvW5+K00K8M+MdtQHE6Ui8vWIGPiewEmZfckLedpbFR4syBZh1tiKjcANZnumEf+
 1YhWeRQgNJjmoa6XJPrW356k3VsiilsNqZ4L35+2nDfhGN/EP4W7uGbVU4J+kmEFXG3P
 sk3nMV3r3S4JuCCuhiMbIDxdXphTtMhqGrd8m1Ff3FuWKKFX4axUu0mWa3EuhsryQifs
 yUI5Zrl5kHTKwTzcIExzirhQr7AsDNg8HSbXGQum3y7gnZD8Z/QINVKPhA9H3rKmOrvI
 is+g==
X-Gm-Message-State: APuU4Z+EZT7gAkIgzzoyAaonB6UK+vu23Dgo9LGGYOTT894S2uJHv3Uj
 Up3qeURNPvjSZCBVcGq25RREIbTI08XCvDhizI9f9XQhMQr6V7+lg4vOi+GDiIcpRcYhD4qQ
X-Gm-Gg: AZFdTZfTGVbUR5WV1+RVucz0L2OfmO9hMIlI3+aIdxrmUYY/AUTcOWrQhRYjTP946Of
 TVkcfff8LAXGNGLyQWCKNoMSywERRHEMMTXIt9u7z1lXjq6euG6DukRPQCv58mxWOVWWVzKpRW9
 OuPXvHb45pBLgAV3J+12tmLs1Ns0KvZMqDEjf5MlkLTtb9czioZb1GrMOcPShFYcHXDFyyQgpPU
 /ivRN4mlma5ec2fLfMINqlWeuUiJh3DCLojmonUpjJcXbFt56WKGKwRy5QUeaKiDbuJu5wbztDv
 bZpwQQLvS/OuQsJZbipcxFs+jOzVK2ygcepNreAUqmByMZP6yWM+nxCDvT4xUTbY1sYn1fjsCZv
 N6tquVdd+cgYaXaiIkt4EGhzDX+BtwxlRCDXSDKZZe6qi76e2bDfxCT/6kDvpv6hHkikrj6tMIt
 QSeuLgz+cs+ckiKeWImCWi/ys9GxwPV7OdiQe0gkGySE133v8j/xz+i/A8/LZWfR6OQKs26mzHW
 X1BUKeoP7iwZ4qTkWqnF/UM+qba6Cyl9RRjdjE98bKSumg6lOq0axv90UKwQUpY5N3BFCat2zi/
 5SZvOzPl3vfYT4D6s1fHb5r1EWVOBERHNF6nf8TiygPxvKxji3QHyNitjo/L1PntGxen2wgggdT
 nNBcWYBj/jhOaQ7Iy
X-Received: by 2002:a17:90b:55c4:b0:3b0:a970:caad with SMTP id
 98e67ed59e1d1-3b41c92ce42mr9567189a91.28.1795416045630; 
 Sun, 22 Nov 2026 22:40:45 -0800 (PST)
Received: from [28.0.0.1]
 (ec2-52-221-205-137.ap-southeast-1.compute.amazonaws.com. [52.221.205.137])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad48786sm16526631a91.9.2026.11.22.22.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 22:40:45 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------2eaGnSJ71YYziOLL7eXI0ZTG"
Message-ID: <21d62cec-01fb-40d1-8de8-83bcb6fc7feb@gmail.com>
Date: Mon, 23 Nov 2026 14:40:36 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: use gen_goto_tb for vsetvli
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Tao Tang
 <tangtao1634@phytium.com.cn>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20261111-research-vsetvli-direct-chain-20261104-v3-1-8d3a18474a68@gmail.com>
Content-Language: en-US
From: WX Chen <wxchen0913@gmail.com>
In-Reply-To: <20261111-research-vsetvli-direct-chain-20261104-v3-1-8d3a18474a68@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=wxchen0913@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------2eaGnSJ71YYziOLL7eXI0ZTG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

|A gentle ping on this patch.

|

|Thanks,
Chen|

On 11/11/26 21:40, WX Chen wrote:
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
> Signed-off-by: WX Chen<wxchen0913@gmail.com>
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
> v2 patch link:https://lore.kernel.org/qemu-devel/20261110-research-vsetvli-direct-chain-20261104-v2-1-8e65aadfb6aa@gmail.com/
> benchmark link:https://github.com/zhenbaii/qemu-riscv-bench
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
--------------2eaGnSJ71YYziOLL7eXI0ZTG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><code>A gentle ping on this patch.<br>
        <br>
      </code></p>
    <p><code>Thanks,<br>
        Chen</code></p>
    <div class="moz-cite-prefix">On 11/11/26 21:40, WX Chen wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:20261111-research-vsetvli-direct-chain-20261104-v3-1-8d3a18474a68@gmail.com">
      <pre wrap="" class="moz-quote-pre">This patch uses gen_goto_tb() to reduce the overhead of the
unconditional lookup_and_goto_ptr() exit currently generated
for vsetvli.

When translating vsetvli, the immediate vtype provides information
that can be used to optimize the exit generated by do_vsetvl().

For the vsetvli forms optimized by this patch, the immediate vtype and
existing state update flow determine the other relevant translation state.
Only VL_EQ_VLMAX can vary with AVL. This patch therefore uses separate
jump slots depending on whether the returned VL equals VLMAX,
enabling direct TB linking after vsetvli.

The register-vtype vsetvl instruction retains the existing lookup
path, as its vtype is not known at translation time.

The package benchmarks measure build time with the RISC-V cc1 compiler running under QEMU,
while the dedicated workload repeatedly executes two vsetvli instructions,
alternating between VL = VLMAX and VL &lt; VLMAX.

benchmark result:
Dedicated workload:
| Workload | QEMU | Runs | Median (s) | Min–max (s) | Wall change (s) | Wall change | Wall / baseline |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| vsetvli-chain | baseline | 5 | 2.154520 | 2.145543–2.173475 | 0.000000 | 0.00% | 1.000x |
| vsetvli-chain | candidate | 5 | 0.492811 | 0.489481–0.499191 | -1.661710 | -77.13% | 0.229x |

Perf of dedicated workload:
| Workload | QEMU | Event | Samples | Symbol | Symbol samples | Overhead |
| --- | --- | --- | ---: | --- | ---: | ---: |
| vsetvli-chain | baseline | cycles:u | 2151 | `helper_lookup_tb_ptr` | 2007 | 93.58%|
| vsetvli-chain | candidate | cycles:u | 482 | `helper_lookup_tb_ptr` | 0 | 0.00% |

Package build benchmark
| Package | QEMU | Runs | Median wall (s) | Min–max (s) | Stddev (s) | Wall change | Wall / baseline |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| lz4 | candidate | 3 | 79.506 | 79.000–80.063 | 0.532 | -1.25% | 0.987x |
| zlib | candidate | 3 | 45.474 | 45.426–45.476 | 0.028 | -0.44% | 0.996x |
| sqlite | candidate | 3 | 278.771 | 278.470–278.962 | 0.248 | -1.07% | 0.989x |

Signed-off-by: WX Chen <a class="moz-txt-link-rfc2396E" href="mailto:wxchen0913@gmail.com">&lt;wxchen0913@gmail.com&gt;</a>
---
v3:
- Expand the commit message to explain the optimization rationale,
  following feedback from Sashiko AI review.
- Add a benchmark result.
- No code changes.
v2:
The overall structure is quite the same as v1 except that v2 considers the condition that QEMU forces
`VL_EQ_VLMAX = false` when `maxsz &lt; 8`, which reduces the number of `goto_tb` slots from two to one in
some cases.

For `vsetvli` with `rd != x0 &amp;&amp; rs1 == x0`, v2 also uses a single
`goto_tb` slot because the successor TB lookup key is fixed for a given
source TB.

Both changes follow Chao Liu's suggestions.

v2 patch link: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20261110-research-vsetvli-direct-chain-20261104-v2-1-8e65aadfb6aa@gmail.com/">https://lore.kernel.org/qemu-devel/20261110-research-vsetvli-direct-chain-20261104-v2-1-8e65aadfb6aa@gmail.com/</a>
benchmark link: <a class="moz-txt-link-freetext" href="https://github.com/zhenbaii/qemu-riscv-bench">https://github.com/zhenbaii/qemu-riscv-bench</a>

To run the benchmark from the benchmark repository, pass the baseline
and patched QEMU commit IDs to the vsetvli-v2 recipe:

  ./reproduce.sh BASELINE_COMMIT PATCHED_COMMIT --recipe vsetvli-v2
---
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 30 ++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index 7e1295f33e7d4b7a2ff26cbf428f6b5d9eb682ff..17e8eb5ecaede655b58b5bdc9f10ff9284efc5b6 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -191,7 +191,8 @@ static bool require_noover(const int8_t dst, const int8_t dst_lmul,
     return !is_overlapped(dst, dst_size, src, src_size);
 }
 
-static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
+static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2,
+                      uint32_t vtype, bool vtype_is_imm)
 {
     TCGv s1, dst;
 
@@ -215,8 +216,27 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
     gen_set_gpr(s, rd, dst);
     finalize_rvv_inst(s);
 
-    gen_update_pc(s, s-&gt;cur_insn_len);
-    lookup_and_goto_ptr(s);
+    if (!vtype_is_imm || (rd == 0 &amp;&amp; rs1 == 0)) {
+        gen_update_pc(s, s-&gt;cur_insn_len);
+        lookup_and_goto_ptr(s);
+    } else {
+        uint32_t vsew = FIELD_EX32(vtype, VTYPE, VSEW);
+        int8_t lmul = sextract32(FIELD_EX32(vtype, VTYPE, VLMUL), 0, 3);
+        uint32_t vlmax = vext_get_vlmax(s-&gt;cfg_ptr-&gt;vlenb, vsew, lmul);
+
+        if (rs1 == 0 || (vlmax &lt;&lt; vsew) &lt; 8) {
+            gen_goto_tb(s, 0, s-&gt;cur_insn_len);
+        } else {
+            target_ulong pc_save = s-&gt;pc_save;
+            TCGLabel *not_vlmax = gen_new_label();
+
+            tcg_gen_brcondi_tl(TCG_COND_NE, dst, vlmax, not_vlmax);
+            gen_goto_tb(s, 0, s-&gt;cur_insn_len);
+            s-&gt;pc_save = pc_save;
+            gen_set_label(not_vlmax);
+            gen_goto_tb(s, 1, s-&gt;cur_insn_len);
+        }
+    }
     s-&gt;base.is_jmp = DISAS_NORETURN;
     return true;
 }
@@ -244,13 +264,13 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
 static bool trans_vsetvl(DisasContext *s, arg_vsetvl *a)
 {
     TCGv s2 = get_gpr(s, a-&gt;rs2, EXT_ZERO);
-    return do_vsetvl(s, a-&gt;rd, a-&gt;rs1, s2);
+    return do_vsetvl(s, a-&gt;rd, a-&gt;rs1, s2, 0, false);
 }
 
 static bool trans_vsetvli(DisasContext *s, arg_vsetvli *a)
 {
     TCGv s2 = tcg_constant_tl(a-&gt;zimm);
-    return do_vsetvl(s, a-&gt;rd, a-&gt;rs1, s2);
+    return do_vsetvl(s, a-&gt;rd, a-&gt;rs1, s2, a-&gt;zimm, true);
 }
 
 static bool trans_vsetivli(DisasContext *s, arg_vsetivli *a)

---
base-commit: a3565937b39779d4e3704298095f566e7559ad53
change-id: 20261104-research-vsetvli-direct-chain-20261104-206bc2104ddb

Best regards,
</pre>
    </blockquote>
  </body>
</html>

--------------2eaGnSJ71YYziOLL7eXI0ZTG--

