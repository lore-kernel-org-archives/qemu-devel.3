Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F1FFF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVz-0007bq-0H; Tue, 07 Apr 2026 14:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wABTe-0002LR-Fq; Tue, 07 Apr 2026 14:48:43 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wA5JM-0006Qe-BV; Tue, 07 Apr 2026 08:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1775563998; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=Ubpy7oxA8mF91aQ5SYyTW31HR+wTIT6hL8nveIqBu2g=;
 b=PxY2MTlYiz++68jcS85Yy7aBKqYkNSd6UQrGofyXCkG6JnwgSGTBhi6w1mws8MUgBxowjlM9FOG7VoPXOVErgMHkEFKpf8gXamsffQ3PLJVQRisyOZsZGQNkBkzzsysr5MmD5Uofmpi+a3GviMQ8qZQrz3c+HGC1eVkkjapAl/s=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R401e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0X0bh4In_1775563997; 
Received: from 30.166.64.152(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X0bh4In_1775563997 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 07 Apr 2026 20:13:17 +0800
Content-Type: multipart/alternative;
 boundary="------------q0WZad0400yN686Sbso3QxAq"
Message-ID: <ce3cde01-d4cf-4e01-befb-e9631dcf7757@linux.alibaba.com>
Date: Tue, 7 Apr 2026 20:13:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/riscv: Use ELEN for Fractional LMUL check
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-6-alistair.francis@wdc.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260407043614.372871-6-alistair.francis@wdc.com>
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
--------------q0WZad0400yN686Sbso3QxAq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alistair,

On 4/7/26 12:36 PM, alistair23@gmail.com wrote:
> From: Alistair Francis<alistair.francis@wdc.com>
>
> The RISC-V spec states that
>
> """
> For a given supported fractional LMUL setting, implementations
> must support SEW settings between SEWMIN and LMUL * ELEN, inclusive.
> """

I think the meaning  of "must support"  in specification is "must at 
least support" instead of "must only support".

Sail or Spike have the same check as this patch to prevent user program 
can run on them, but
can't run on RTLs, as RTLs implementation may support SEW besides the 
SEWMIN and LMUL * ELEN range.

We can refer to discussion here: 
https://github.com/riscv-software-src/riscv-isa-sim/pull/620

In my opinion, we had better add a option such as "frac_sew_check" to 
make user set right value for their RTL implementation.

Otherwise,
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Thanks,
Zhiwei

> We were previously checking VLEN, instead of ELEN, so let's update to
> check ELEN instead of VLEN for fractional scaling.
>
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/3196
> Signed-off-by: Alistair Francis<alistair.francis@wdc.com>
> ---
>   target/riscv/vector_helper.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 83dd26314d..b4fc791eb7 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -47,18 +47,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       target_ulong reserved = s2 &
>                               MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                               xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> -    uint16_t vlen = cpu->cfg.vlenb << 3;
>       int8_t lmul;
>   
>       if (vlmul & 4) {
>           /*
>            * Fractional LMUL, check:
>            *
> -         * VLEN * LMUL >= SEW
> -         * VLEN >> (8 - lmul) >= sew
> -         * (vlenb << 3) >> (8 - lmul) >= sew
> +         * ELEN * LMUL >= SEW
> +         * ELEN >> (8 - vlmul) >= sew
>            */
> -        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
> +        if (vlmul == 4 ||
> +            (cpu->cfg.elen >> (8 - vlmul)) < sew) {
>               vill = true;
>           }
>       }
--------------q0WZad0400yN686Sbso3QxAq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Alistair,</p>
    <div class="moz-cite-prefix">On 4/7/26 12:36 PM,
      <a class="moz-txt-link-abbreviated" href="mailto:alistair23@gmail.com">alistair23@gmail.com</a> wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260407043614.372871-6-alistair.francis@wdc.com">
      <pre wrap="" class="moz-quote-pre">From: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>

The RISC-V spec states that

"""
For a given supported fractional LMUL setting, implementations
must support SEW settings between SEWMIN and LMUL * ELEN, inclusive.
"""
</pre>
    </blockquote>
    <p>I think the meaning  of "must support"  in specification is "must
      at least support" instead of "must only support".</p>
    <p>Sail or Spike have the same check as this patch to prevent user
      program can run on them, but<br>
      can't run on RTLs, as RTLs implementation may support SEW besides
      the  <span style="white-space: pre-wrap">SEWMIN and LMUL * ELEN range.</span></p>
    <p><span style="white-space: pre-wrap">We can refer to discussion here: <a class="moz-txt-link-freetext" href="https://github.com/riscv-software-src/riscv-isa-sim/pull/620">https://github.com/riscv-software-src/riscv-isa-sim/pull/620</a></span></p>
    <p>In my opinion, we had better add a option such as
      "frac_sew_check" to make user set right value for their RTL
      implementation.</p>
    <p>Otherwise,<br>
      Reviewed-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a><br>
      <br>
      Thanks,<br>
      Zhiwei</p>
    <blockquote type="cite"
      cite="mid:20260407043614.372871-6-alistair.francis@wdc.com">
      <pre wrap="" class="moz-quote-pre">
We were previously checking VLEN, instead of ELEN, so let's update to
check ELEN instead of VLEN for fractional scaling.

Resolves: <a class="moz-txt-link-freetext" href="https://gitlab.com/qemu-project/qemu/-/work_items/3196">https://gitlab.com/qemu-project/qemu/-/work_items/3196</a>
Signed-off-by: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>
---
 target/riscv/vector_helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 83dd26314d..b4fc791eb7 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -47,18 +47,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     target_ulong reserved = s2 &amp;
                             MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                             xlen - 1 - R_VTYPE_RESERVED_SHIFT);
-    uint16_t vlen = cpu-&gt;cfg.vlenb &lt;&lt; 3;
     int8_t lmul;
 
     if (vlmul &amp; 4) {
         /*
          * Fractional LMUL, check:
          *
-         * VLEN * LMUL &gt;= SEW
-         * VLEN &gt;&gt; (8 - lmul) &gt;= sew
-         * (vlenb &lt;&lt; 3) &gt;&gt; (8 - lmul) &gt;= sew
+         * ELEN * LMUL &gt;= SEW
+         * ELEN &gt;&gt; (8 - vlmul) &gt;= sew
          */
-        if (vlmul == 4 || (vlen &gt;&gt; (8 - vlmul)) &lt; sew) {
+        if (vlmul == 4 ||
+            (cpu-&gt;cfg.elen &gt;&gt; (8 - vlmul)) &lt; sew) {
             vill = true;
         }
     }
</pre>
    </blockquote>
  </body>
</html>

--------------q0WZad0400yN686Sbso3QxAq--

