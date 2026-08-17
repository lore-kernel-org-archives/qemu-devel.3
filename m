Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27261C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvrjk-0006vk-DY; Mon, 17 Aug 2026 03:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wvrjd-0006us-0I; Mon, 17 Aug 2026 03:26:17 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wvrjZ-00075E-NE; Mon, 17 Aug 2026 03:26:16 -0400
Received: from [10.213.18.251] (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowAB34TuJt4Jqbx36BQ--.41835S3;
 Mon, 17 Aug 2026 15:26:01 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------4Ir5QP8u7QDWcXDPRAIWP5eM"
Message-ID: <eae12997-3efb-40c7-a1d2-5dbbfa40862d@iscas.ac.cn>
Date: Mon, 17 Aug 2026 15:26:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/18] target/riscv: Add packed SIMD helper framework
To: Max Chou <max.chou@sifive.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <e3775ec9235fa974e9a318edf1836cdaab197e27.1784280142.git.xiaoou@iscas.ac.cn>
 <aoHbEVwVvB9BMSpW@sifive.com>
From: MOLLY CHEN <xiaoou@iscas.ac.cn>
In-Reply-To: <aoHbEVwVvB9BMSpW@sifive.com>
X-CM-TRANSID: zQCowAB34TuJt4Jqbx36BQ--.41835S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4fXr4kWF4rWw1fXw4ktFb_yoW5GFy7pr
 4kGasIkr95J3yIgw43Ca1UAr15ZrWrCF4YgFn7Xr1UJws8ta4xZFs3Kr45KF1DG348Wr12
 9FWI9ry3C3Z5CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21lYx0E2Ix0cI8I
 cVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4
 x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mx8GjcxK6IxK0xIIj40E5I8CrwCY
 1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r106r1rMI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
 ZEXa7IU1QVy7UUUUU==
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
--------------4Ir5QP8u7QDWcXDPRAIWP5eM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

|Hi Max, ||You're right. For a rounding right shift at or beyond the element 
width, the shift amount should be clamped to the element width so that 
the result is determined by rounding the element's MSB. Returning zero 
unconditionally when `right > BITS` is incorrect when the MSB is set.||I will use the suggested `MIN()` approach in the next version. Thanks, 
Molly|

在 2026/8/16 23:49, Max Chou 写道:
> On 2026-07-17 10:06, Molly Chen wrote:
>> Signed-off-by: Molly Chen<xiaoou@iscas.ac.cn>
>> ---
>>   target/riscv/tcg/meson.build    |    3 +-
>>   target/riscv/tcg/psimd_helper.c | 1656 +++++++++++++++++++++++++++++++
>>   2 files changed, 1658 insertions(+), 1 deletion(-)
>>   create mode 100644 target/riscv/tcg/psimd_helper.c
>>
> ...
>>   riscv_system_ss.add(files(
>> diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
>> new file mode 100644
>> index 00000000000..2948bbb2a86
>> --- /dev/null
>> +++ b/target/riscv/tcg/psimd_helper.c
> ...
>> +#define GEN_PSIMD_VAR_USHLR(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,   \
>> +                            ELEMS, BITS, SAT_FN)                          \
>> +RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
>> +{                                                                         \
>> +    RTYPE rd = 0;                                                         \
>> +    int elems = ELEMS(rd);                                                \
>> +    int sat = 0;                                                          \
>> +    int8_t shamt = (int8_t)(rs2 & 0xff);                                  \
>> +                                                                          \
>> +    for (int i = 0; i < elems; i++) {                                     \
>> +        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
>> +        ETYPE res;                                                        \
>> +                                                                          \
>> +        if (shamt >= 0) {                                                 \
>> +            WTYPE shifted = (shamt >= (BITS)) ?                           \
>> +                            ((WTYPE)e1 << (BITS)) :                       \
>> +                            ((WTYPE)e1 << shamt);                         \
>> +            res = SAT_FN(shifted, &sat);                                  \
>> +        } else {                                                          \
>> +            int right = -shamt;                                           \
>> +            if (right > (BITS)) {                                         \
>> +                res = 0;                                                  \
> Here may has an issue that a rounding right shift past the element
> width does not degenerate to zero -- it saturates to the rounding of
> the element's MSB.
>
> According to the P ext isa spec:
>
>    "The SSHLR instruction performs an unsigned variable shift of `rs1`
>     using the signed shift amount in `rs2[7:0]`. Right shifts are
>     rounded, and left shifts saturate to the signed 32-bit range."
>
>      if sshamt < 0:
>          // arithmetic right shift with rounding
>          x  = zero_extend(64, s1) @ 0b0            // 65-bit
>          y  = (sshamt <= -32) ? x[64:32]
>                               : (x >> (0 - shamt)[4:0])[32:0]
>          X[rd] = (y + 1)[32:1]
>
> The operation Sail code shows that every right shift at or beyond
> the element width collapses to the same x[64:32], which is the
> element's MSB, and then still gets the (y + 1) >> 1 rounding.
> PSSHLR.HS and PSSHLR.WS have the identical construct at the 16- and
> 32-bit boundaries.
>
> Maybe we could fix it liked:
>
>             } else {                                                          \
>                 int right = MIN(-shamt, (BITS));                              \
>                 WTYPE rounded = ((WTYPE)e1 >> (right - 1)) + 1;               \
>                 res = (ETYPE)(rounded >> 1);                                  \
>             }                                                                 \
>
>
> rnax
>
>> +            } else {                                                      \
>> +                WTYPE rounded = ((WTYPE)e1 >> (right - 1)) + 1;           \
>> +                res = (ETYPE)(rounded >> 1);                              \
>> +            }                                                             \
>> +        }                                                                 \
--------------4Ir5QP8u7QDWcXDPRAIWP5eM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre dir="ltr"><code>Hi Max,

</code><code>You're right. For a rounding right shift at or beyond the element
width, the shift amount should be clamped to the element width so that
the result is determined by rounding the element's MSB. Returning zero
unconditionally when `right &gt; BITS` is incorrect when the MSB is set.</code><code>
I will use the suggested `MIN()` approach in the next version.

Thanks,
Molly</code></pre>
    <div class="moz-cite-prefix">在 2026/8/16 23:49, Max Chou 写道:<br>
    </div>
    <blockquote type="cite" cite="mid:aoHbEVwVvB9BMSpW@sifive.com">
      <pre wrap="" class="moz-quote-pre">On 2026-07-17 10:06, Molly Chen wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Signed-off-by: Molly Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaoou@iscas.ac.cn">&lt;xiaoou@iscas.ac.cn&gt;</a>
---
 target/riscv/tcg/meson.build    |    3 +-
 target/riscv/tcg/psimd_helper.c | 1656 +++++++++++++++++++++++++++++++
 2 files changed, 1658 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/tcg/psimd_helper.c

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">...
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> riscv_system_ss.add(files(
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
new file mode 100644
index 00000000000..2948bbb2a86
--- /dev/null
+++ b/target/riscv/tcg/psimd_helper.c
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">...
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+#define GEN_PSIMD_VAR_USHLR(NAME, RTYPE, ETYPE, WTYPE, EXTRACT, INSERT,   \
+                            ELEMS, BITS, SAT_FN)                          \
+RTYPE HELPER(NAME)(CPURISCVState *env, RTYPE rs1, RTYPE rs2)              \
+{                                                                         \
+    RTYPE rd = 0;                                                         \
+    int elems = ELEMS(rd);                                                \
+    int sat = 0;                                                          \
+    int8_t shamt = (int8_t)(rs2 &amp; 0xff);                                  \
+                                                                          \
+    for (int i = 0; i &lt; elems; i++) {                                     \
+        ETYPE e1 = (ETYPE)EXTRACT(rs1, i);                                \
+        ETYPE res;                                                        \
+                                                                          \
+        if (shamt &gt;= 0) {                                                 \
+            WTYPE shifted = (shamt &gt;= (BITS)) ?                           \
+                            ((WTYPE)e1 &lt;&lt; (BITS)) :                       \
+                            ((WTYPE)e1 &lt;&lt; shamt);                         \
+            res = SAT_FN(shifted, &amp;sat);                                  \
+        } else {                                                          \
+            int right = -shamt;                                           \
+            if (right &gt; (BITS)) {                                         \
+                res = 0;                                                  \
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Here may has an issue that a rounding right shift past the element
width does not degenerate to zero -- it saturates to the rounding of
the element's MSB.

According to the P ext isa spec:

  "The SSHLR instruction performs an unsigned variable shift of `rs1`
   using the signed shift amount in `rs2[7:0]`. Right shifts are
   rounded, and left shifts saturate to the signed 32-bit range."

    if sshamt &lt; 0:
        // arithmetic right shift with rounding
        x  = zero_extend(64, s1) @ 0b0            // 65-bit
        y  = (sshamt &lt;= -32) ? x[64:32]
                             : (x &gt;&gt; (0 - shamt)[4:0])[32:0]
        X[rd] = (y + 1)[32:1]

The operation Sail code shows that every right shift at or beyond
the element width collapses to the same x[64:32], which is the
element's MSB, and then still gets the (y + 1) &gt;&gt; 1 rounding.
PSSHLR.HS and PSSHLR.WS have the identical construct at the 16- and
32-bit boundaries.

Maybe we could fix it liked:

           } else {                                                          \
               int right = MIN(-shamt, (BITS));                              \
               WTYPE rounded = ((WTYPE)e1 &gt;&gt; (right - 1)) + 1;               \
               res = (ETYPE)(rounded &gt;&gt; 1);                                  \
           }                                                                 \


rnax

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+            } else {                                                      \
+                WTYPE rounded = ((WTYPE)e1 &gt;&gt; (right - 1)) + 1;           \
+                res = (ETYPE)(rounded &gt;&gt; 1);                              \
+            }                                                             \
+        }                                                                 \
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------4Ir5QP8u7QDWcXDPRAIWP5eM--


