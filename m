Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8932C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvrqn-0008MZ-Kp; Mon, 17 Aug 2026 03:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wvrql-0008M4-JR; Mon, 17 Aug 2026 03:33:39 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wvrqi-00089G-Cj; Mon, 17 Aug 2026 03:33:39 -0400
Received: from [10.213.18.251] (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowAB34DpIuYJqDkD6BQ--.38540S3;
 Mon, 17 Aug 2026 15:33:28 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------5McWMhQUrrCWO309DCobSNE2"
Message-ID: <77a43a16-cd89-4145-bedf-f7128dd186d8@iscas.ac.cn>
Date: Mon, 17 Aug 2026 15:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] target/riscv: Add packed SIMD arithmetic
 instructions
To: Max Chou <max.chou@sifive.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <3935baa46fdc44f7b68e2b740c7bedf8b7c0b974.1784280142.git.xiaoou@iscas.ac.cn>
 <aoHkpCy_H-vhfcFY@sifive.com>
From: MOLLY CHEN <xiaoou@iscas.ac.cn>
In-Reply-To: <aoHkpCy_H-vhfcFY@sifive.com>
X-CM-TRANSID: zQCowAB34DpIuYJqDkD6BQ--.38540S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWxWw1fGF1xCFW8WFWkXrb_yoW5Ar4fpF
 18KrWrGr48ArWSy3WSvF1Uur13ZF4fCF4UW3s3XwsYvan8JrZ3AFsrK3yakryUAFZ5WFWY
 kaySka4UZ3y5A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487McIj6xIIjxv2
 0xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8Jw
 ACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCjr7xvwVCIw2I0I7xG6c02F41l
 c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUGVWUWwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxU70PfDUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.25; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.424,
 HK_RANDOM_FROM=0.999, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a multi-part message in MIME format.
--------------5McWMhQUrrCWO309DCobSNE2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

|Thanks for catching these too. I will fix these in the next version. 
Thanks, Molly|

在 2026/8/17 0:32, Max Chou 写道:
> On 2026-07-17 10:06, Molly Chen wrote:
>> Signed-off-by: Molly Chen<xiaoou@iscas.ac.cn>
>> ---
>>   target/riscv/helper.h                       |  41 ++
>>   target/riscv/insn32.decode                  |  63 +++
>>   target/riscv/tcg/insn_trans/trans_rvp.c.inc | 547 ++++++++++++++++++++
>>   target/riscv/tcg/psimd_helper.c             | 114 ++++
>>   target/riscv/tcg/translate.c                |   4 +
>>   5 files changed, 769 insertions(+)
>>   create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
> ...
>> diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
>> new file mode 100644
>> index 00000000000..056ccfb486e
>> --- /dev/null
>> +++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
> ...
>> +#if defined(TARGET_RISCV32)
>> +#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_OP(INSN, HELPER, VXSAT)     \
>> +static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
>> +{                                                              \
>> +    REQUIRE_32BIT(ctx);                                        \
>> +    REQUIRE_RVP(ctx);                                          \
>> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                    \
>> +        return false;                                          \
>> +    }                                                          \
>> +    TCGv src1_0 = get_gpr(ctx, (a->rs1) * 2, EXT_NONE);        \
>> +    TCGv dest_0 = dest_gpr(ctx, (a->rd) * 2);                    \
>> +    TCGv src1_1 = get_gpr(ctx, (a->rs1) * 2 + 1, EXT_NONE);        \
>> +    TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);                  \
>> +    TCGv src2   = get_gpr(ctx, a->rs2, EXT_NONE);              \
>> +    gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2);        \
>> +    gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2);        \
>> +    gen_set_gpr(ctx, (a->rd) * 2, dest_0);                     \
>> +    gen_set_gpr(ctx, (a->rd) * 2 + 1, dest_1);                 \
>> +    return true;                                              \
>> +}
> There is a read-after-write hazard on src2 when the destination pair
> overlaps rs2.
>
> get_gpr(*, EXT_NONE) returns cpu_gpr[n] itself (EXT_NONE takes no
> snapshot). And dest_gpr(ctx, rd) also returns cpu_gpr[rd] itself.
> So if rd*2 == a->rs2 (or rd*2 + 1 == a->rs2), dest_0/dest_1 and src2
> are the same TCG global, and the first gen_helper call op writes it
> before the second call op reads it as its source.
>
> I suggest that we could fix it by snapshot rs2:
>
>         TCGv dest_1 = dest_gpr(ctx, (a->rd) * 2 + 1);              \
>    -    TCGv src2   = get_gpr(ctx, a->rs2, EXT_NONE);              \
>    +    TCGv src2 = tcg_temp_new();                                \
>    +    tcg_gen_mov_tl(src2, get_gpr(ctx, a->rs2, EXT_NONE));      \
>         gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2);        \
>
>> +#if defined(TARGET_RISCV32)
>> +#define GEN_SIMD_TRANS_PN_OP(NAME, SRC2, VXSAT)            \
>> +static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
>> +{                                                           \
>> +    REQUIRE_32BIT(ctx);                                     \
>> +    REQUIRE_RVP(ctx);                                       \
>> +    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
>> +        return false;                                       \
>> +    }                                                       \
>> +    TCGv_i64 s1 = tcg_temp_new_i64();                       \
>> +    if (a->rs1 == 0) {                                      \
>> +        tcg_gen_mov_i64(s1, 0);                             \
> I think that we should use tcg_gen_movi_i64 here.
>
> rnax
>
>> +    } else {                                                \
>> +        get_pair_regs(ctx, s1, a->rs1 * 2);                 \
>> +    }                                                       \
>> +    TCGv src2 = SRC2;                                       \
>> +    TCGv dest = dest_gpr(ctx, a->rd);                       \
>> +    gen_helper_##NAME(dest, tcg_env, s1, src2);             \
>> +    gen_set_gpr(ctx, a->rd, dest);                          \
>> +    return true;                                            \
>> +}
--------------5McWMhQUrrCWO309DCobSNE2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre dir="ltr"><code>Thanks for catching these too. I will fix these in the next version.

Thanks,
Molly</code></pre>
    <div class="moz-cite-prefix">在 2026/8/17 0:32, Max Chou 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:aoHkpCy_H-vhfcFY@sifive.com">
      <pre wrap="" class="moz-quote-pre">On 2026-07-17 10:06, Molly Chen wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Signed-off-by: Molly Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaoou@iscas.ac.cn">&lt;xiaoou@iscas.ac.cn&gt;</a>
---
 target/riscv/helper.h                       |  41 ++
 target/riscv/insn32.decode                  |  63 +++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 547 ++++++++++++++++++++
 target/riscv/tcg/psimd_helper.c             | 114 ++++
 target/riscv/tcg/translate.c                |   4 +
 5 files changed, 769 insertions(+)
 create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">...
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
new file mode 100644
index 00000000000..056ccfb486e
--- /dev/null
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">...
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_OP(INSN, HELPER, VXSAT)     \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)    \
+{                                                              \
+    REQUIRE_32BIT(ctx);                                        \
+    REQUIRE_RVP(ctx);                                          \
+    if (VXSAT &amp;&amp; !prepare_rvp_vxsat(ctx)) {                    \
+        return false;                                          \
+    }                                                          \
+    TCGv src1_0 = get_gpr(ctx, (a-&gt;rs1) * 2, EXT_NONE);        \
+    TCGv dest_0 = dest_gpr(ctx, (a-&gt;rd) * 2);                    \
+    TCGv src1_1 = get_gpr(ctx, (a-&gt;rs1) * 2 + 1, EXT_NONE);        \
+    TCGv dest_1 = dest_gpr(ctx, (a-&gt;rd) * 2 + 1);                  \
+    TCGv src2   = get_gpr(ctx, a-&gt;rs2, EXT_NONE);              \
+    gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2);        \
+    gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2);        \
+    gen_set_gpr(ctx, (a-&gt;rd) * 2, dest_0);                     \
+    gen_set_gpr(ctx, (a-&gt;rd) * 2 + 1, dest_1);                 \
+    return true;                                              \
+}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
There is a read-after-write hazard on src2 when the destination pair
overlaps rs2.

get_gpr(*, EXT_NONE) returns cpu_gpr[n] itself (EXT_NONE takes no
snapshot). And dest_gpr(ctx, rd) also returns cpu_gpr[rd] itself.
So if rd*2 == a-&gt;rs2 (or rd*2 + 1 == a-&gt;rs2), dest_0/dest_1 and src2
are the same TCG global, and the first gen_helper call op writes it
before the second call op reads it as its source.

I suggest that we could fix it by snapshot rs2:

       TCGv dest_1 = dest_gpr(ctx, (a-&gt;rd) * 2 + 1);              \
  -    TCGv src2   = get_gpr(ctx, a-&gt;rs2, EXT_NONE);              \
  +    TCGv src2 = tcg_temp_new();                                \
  +    tcg_gen_mov_tl(src2, get_gpr(ctx, a-&gt;rs2, EXT_NONE));      \
       gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2);        \

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_PN_OP(NAME, SRC2, VXSAT)            \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    REQUIRE_RVP(ctx);                                       \
+    if (VXSAT &amp;&amp; !prepare_rvp_vxsat(ctx)) {                 \
+        return false;                                       \
+    }                                                       \
+    TCGv_i64 s1 = tcg_temp_new_i64();                       \
+    if (a-&gt;rs1 == 0) {                                      \
+        tcg_gen_mov_i64(s1, 0);                             \
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I think that we should use tcg_gen_movi_i64 here.

rnax

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+    } else {                                                \
+        get_pair_regs(ctx, s1, a-&gt;rs1 * 2);                 \
+    }                                                       \
+    TCGv src2 = SRC2;                                       \
+    TCGv dest = dest_gpr(ctx, a-&gt;rd);                       \
+    gen_helper_##NAME(dest, tcg_env, s1, src2);             \
+    gen_set_gpr(ctx, a-&gt;rd, dest);                          \
+    return true;                                            \
+}
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------5McWMhQUrrCWO309DCobSNE2--


