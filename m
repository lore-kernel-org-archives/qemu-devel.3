Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E825AC5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzZR-0005hd-Kt; Thu, 20 Aug 2026 06:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wwzZP-0005hG-E1; Thu, 20 Aug 2026 06:00:23 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wwzZK-0006Zk-Or; Thu, 20 Aug 2026 06:00:23 -0400
Received: from [10.213.18.251] (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowABXKu4m0IZqLK8hBg--.35485S3;
 Thu, 20 Aug 2026 18:00:06 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------VxBiBoWHxAm8TY48GO7wZgjL"
Message-ID: <b6d54543-bf3a-4ee3-aad5-a9edbd7a8240@iscas.ac.cn>
Date: Thu, 20 Aug 2026 18:00:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] target/riscv: Add packed SIMD shift instructions
To: Max Chou <max.chou@sifive.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1784280142.git.xiaoou@iscas.ac.cn>
 <193352ab49c6febc51250ececb4c431ffa165be6.1784280142.git.xiaoou@iscas.ac.cn>
 <aoXO5KIBKDQZSdd4@sifive.com>
From: MOLLY CHEN <xiaoou@iscas.ac.cn>
In-Reply-To: <aoXO5KIBKDQZSdd4@sifive.com>
X-CM-TRANSID: qwCowABXKu4m0IZqLK8hBg--.35485S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWfGFWUJF4UJw1fJw1DZFb_yoW5AFWfpw
 s3Kw13t397tFWfW3yfKF4UAa15Gr4rK3WYqwn7X34rZ398Xrs3ur1aqw4akF1UGFy8Jr1a
 ga12yr45uFWxZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAv7VC0I7IYx2IY
 67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7
 xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l7480Y4vEI4kI2Ix0rVAqx4xJMxkF
 7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
 8I3I0E5I8CrVAFwI0_JrI_JrWlx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
 xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
 8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
 aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
 uYvjxUz4SoDUUUU
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.711,
 HK_RANDOM_FROM=0.999, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--------------VxBiBoWHxAm8TY48GO7wZgjL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

on 2026/8/20 0:10, Max Chou wrote:

> On 2026-07-17 10:06, Molly Chen wrote:
>> Signed-off-by: Molly Chen<xiaoou@iscas.ac.cn>
>> ---
>>   target/riscv/helper.h                       |  43 ++++++
>>   target/riscv/insn32.decode                  |  57 ++++++++
>>   target/riscv/tcg/insn_trans/trans_rvp.c.inc |  43 ++++++
>>   target/riscv/tcg/psimd_helper.c             | 149 ++++++++++++++++++++
>>   4 files changed, 292 insertions(+)
> ...
>> diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
>> index 034afe5a054..8b106a336f5 100644
>> --- a/target/riscv/tcg/psimd_helper.c
>> +++ b/target/riscv/tcg/psimd_helper.c
>> @@ -1903,3 +1903,152 @@ GEN_PSIMD_BINOP(mslt, uint32_t, int32_t, uint32_t,
>>   GEN_PSIMD_BINOP(msltu, uint32_t, uint32_t, uint32_t,
>>                   EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_LT_MASK)
>>   
>> +/* Shift operations (immediate and register) */
>> +
>> +GEN_PSIMD_SHIFTOP(pslli_b, target_ulong, uint8_t, uint8_t,
>> +                  EXTRACT8, INSERT8, ELEMS_B, 0x07, PSIMD_DO_SLL)
>> +GEN_PSIMD_SHIFTOP(psll_bs, target_ulong, uint8_t, uint8_t,
>> +                  EXTRACT8, INSERT8, ELEMS_B, 0x07, PSIMD_DO_SLL)
> The spec instead specifies a uniform 5-bit mask (shamt = X[rs2][4:0]),
> regardless of element width.
> So the SHMASK should be 0x1f for PSLL/PSRL/PSRA.[BS|HS] instructions.
>
> ...

|You are right. The byte and halfword shift forms should both use the 
low 5 bits of rs2. I will change their SHMASK arguments to 0x1f in the 
next revision.|

>> +
>> +/**
>> + * SSHAR - 32-bit scalar variable shift with rounding and saturation
>> + */
>> +uint32_t HELPER(sshar)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
>> +{
>> +    int32_t a = (int32_t)rs1;
>> +    int8_t shamt = (int8_t)(rs2 & 0xFF);
>> +    int sat = 0;
>> +    int32_t res;
>> +
>> +    if (shamt >= 0) {
>> +        int64_t shifted = (int64_t)a << shamt;
>> +        res = signed_saturate_w(shifted, &sat);
>> +    } else {
>> +        int right = -shamt;
>> +        if (right >= 32) {
>> +            res = (a < 0) ? -1 : 0;
> According to the p ext isa spec, SSHAR here extracts a sign-filled
> 33-bit value and then applies RNU rounding. The result here should be
> 0 for both positive and negative inputs.

Yes, I will fix it.

>
>> +        } else {
>> +            int64_t rounded = ((a >> (right - 1)) + 1) >> 1;
> Here may has undefined behavior for negative sources at in-range
> amounts.

|Right-shifting a negative signed integer is implementation-defined, 
rather than undefined. QEMU already relies on the supported compilers 
performing an arithmetic right shift in this case. However, the 
expression does contain a real undefined-behavior case for a positive 
source: when e1 is INT32_MAX and right is 1, the addition of one 
overflows before the result is assigned to WTYPE. I will cast e1 to 
WTYPE before the first shift so that the shift and rounding addition are 
both evaluated in the wider type.|

>
> I think that we could extract the SSHAR implementation from
> GEN_PSIMD_VAR_SSHAR and share it between here and
> GEN_PSIMD_VAR_SSHAR.

|Good suggestion. I will extract the common SSHAR operation into a 
shared helper and use it for both implementations in the next revision.|
||
|Thanks for the review.|
Molly

--------------VxBiBoWHxAm8TY48GO7wZgjL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre dir="ltr">
on 2026/8/20 0:10, Max Chou wrote:</pre>
    <blockquote type="cite" cite="mid:aoXO5KIBKDQZSdd4@sifive.com">
      <pre wrap="" class="moz-quote-pre">On 2026-07-17 10:06, Molly Chen wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Signed-off-by: Molly Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaoou@iscas.ac.cn">&lt;xiaoou@iscas.ac.cn&gt;</a>
---
 target/riscv/helper.h                       |  43 ++++++
 target/riscv/insn32.decode                  |  57 ++++++++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc |  43 ++++++
 target/riscv/tcg/psimd_helper.c             | 149 ++++++++++++++++++++
 4 files changed, 292 insertions(+)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">...
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 034afe5a054..8b106a336f5 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -1903,3 +1903,152 @@ GEN_PSIMD_BINOP(mslt, uint32_t, int32_t, uint32_t,
 GEN_PSIMD_BINOP(msltu, uint32_t, uint32_t, uint32_t,
                 EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_LT_MASK)
 
+/* Shift operations (immediate and register) */
+
+GEN_PSIMD_SHIFTOP(pslli_b, target_ulong, uint8_t, uint8_t,
+                  EXTRACT8, INSERT8, ELEMS_B, 0x07, PSIMD_DO_SLL)
+GEN_PSIMD_SHIFTOP(psll_bs, target_ulong, uint8_t, uint8_t,
+                  EXTRACT8, INSERT8, ELEMS_B, 0x07, PSIMD_DO_SLL)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The spec instead specifies a uniform 5-bit mask (shamt = X[rs2][4:0]),
regardless of element width.
So the SHMASK should be 0x1f for PSLL/PSRL/PSRA.[BS|HS] instructions.

...
</pre>
    </blockquote>
    <pre dir="ltr"><code>You are right.  The byte and halfword shift forms should
both use the low 5 bits of rs2.  I will change their SHMASK arguments to
0x1f in the next revision.</code></pre>
    <blockquote type="cite" cite="mid:aoXO5KIBKDQZSdd4@sifive.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+/**
+ * SSHAR - 32-bit scalar variable shift with rounding and saturation
+ */
+uint32_t HELPER(sshar)(CPURISCVState *env, uint32_t rs1, uint32_t rs2)
+{
+    int32_t a = (int32_t)rs1;
+    int8_t shamt = (int8_t)(rs2 &amp; 0xFF);
+    int sat = 0;
+    int32_t res;
+
+    if (shamt &gt;= 0) {
+        int64_t shifted = (int64_t)a &lt;&lt; shamt;
+        res = signed_saturate_w(shifted, &amp;sat);
+    } else {
+        int right = -shamt;
+        if (right &gt;= 32) {
+            res = (a &lt; 0) ? -1 : 0;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
According to the p ext isa spec, SSHAR here extracts a sign-filled
33-bit value and then applies RNU rounding. The result here should be
0 for both positive and negative inputs.</pre>
    </blockquote>
    <pre>Yes, I will fix it.</pre>
    <blockquote type="cite" cite="mid:aoXO5KIBKDQZSdd4@sifive.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+        } else {
+            int64_t rounded = ((a &gt;&gt; (right - 1)) + 1) &gt;&gt; 1;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Here may has undefined behavior for negative sources at in-range
amounts.</pre>
    </blockquote>
    <pre dir="ltr"><code>Right-shifting a negative signed integer is implementation-defined,
rather than undefined.  QEMU already relies on the supported compilers
performing an arithmetic right shift in this case.

However, the expression does contain a real undefined-behavior case for
a positive source: when e1 is INT32_MAX and right is 1, the addition of
one overflows before the result is assigned to WTYPE.  I will cast e1 to
WTYPE before the first shift so that the shift and rounding addition are
both evaluated in the wider type.</code></pre>
    <blockquote type="cite" cite="mid:aoXO5KIBKDQZSdd4@sifive.com">
      <pre wrap="" class="moz-quote-pre">

I think that we could extract the SSHAR implementation from
GEN_PSIMD_VAR_SSHAR and share it between here and
GEN_PSIMD_VAR_SSHAR.</pre>
    </blockquote>
    <pre><code>Good suggestion.  I will extract the common SSHAR operation into a
shared helper and use it for both implementations in the next revision.</code>
<code></code>
<code>Thanks for the review.</code>
Molly</pre>
  </body>
</html>

--------------VxBiBoWHxAm8TY48GO7wZgjL--


