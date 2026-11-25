Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F4606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJufOZQM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW2j2-0005BB-Pz; Tue, 24 Nov 2026 21:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xW2j0-0005Af-TX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:27:10 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1xW2ix-0004sY-Sv
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:27:10 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cde827b7b95so1402643a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795573621; x=1796178421; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/6o2RNI6ZoPYdJI2KfVrgcbjwgrjSzvcbICAvHxdrIs=;
 b=kJufOZQMe4PfXgnTih+tcRBj5V/13lC5ZTAZGfD1Ab90dkQrP3T3SuAp83lZ+yPJ+k
 ohxCaMpxfOphMTsx4LiOKR2+mACYn4HLObAShWosOAGpWC018Juwcxccmy6tpO/jVWJ1
 UvTzb4E+GRyNkzEh4IUg8yP7pEY+B/icsVQVOwXuN6S4gjkB99IaGpEDEJ/kAwjIIzBk
 f8qQ9ESxifOCva0gJwNU5y1oLxgEF/ZWzrPDeE48gbfHHSZtpyX3qVhDC08H3cSI+Zac
 Xe4FwA/saVtiDYgplVlJuu31Fg2F7KwtupPKLCYkBaXKNA6N7rirBUICi3l1L/nxJ6kx
 rBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795573621; x=1796178421;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/6o2RNI6ZoPYdJI2KfVrgcbjwgrjSzvcbICAvHxdrIs=;
 b=yJko/RnGhvpfnDczDQ7imbrLoqHJYQOzJLvyKcnkRUOU/92d4noaGJquqnnxuxgJ0r
 OiXtNVecmQZirQcVtCYP9C6u1C0c8IHeHa7YiwQdAitQDSiV5ZKIxbhsBnqVtDdZhgtt
 9i9mDo22bz1z3oj9NX0xFxhLOSI9jX4c6tIL4ZLfMt1WnAmoCf0lxvqBQcgekDAe1uYw
 rCYdV05woR1eG67dx5n7JfXBfwP/wSqho4vxQWtkjlXovYPg+NQQGgb935rCdJvRtALV
 uIDJ/0Q4i0PIHm7iFJi8+JlBy/by+nRVzeyRRW/ZsNC79yKvCK34SlXzwbK74WargNy3
 C56Q==
X-Gm-Message-State: APuU4Z+1qZatzdu736dmDoeT+DW637rHJ8YU/+L+AE3dImuceNUgYBFv
 60Q2bxcr+DjfK6rJV4dTQJPC9aH4ir2e98+UzC/C7Lae7sRi/W421afL
X-Gm-Gg: AZFdTZeReoQ6XUR74JcapAQd+tIUcGTLTuHbgmR5q8JII8eGUk0pSyhvzTa2rLa+roM
 k4NZytPkJL4aD/qOgrl3TThpuv1TYxqOpLyuKcpVSZrCDxLqnOun0qvslWkv15CJ0xtBZ4eCdW1
 VwjujGWSUZFYO+w//xvPDaVYYSY/J8Xuw9ZrORhaP8WTnYVK5cesLMWMMQx2PsNAhEvmhC8SBq5
 k6xwCa1lJ1y6Kuvomm2gqmD0HecMRp8FgK0qHKdsI17+ebd1/933iuaoKkfdb10jelQROLt0JQg
 LkbcOC0sf/5sedbqQov1+c2KSty8IHWVqZBW3htSnDgdzE0lUXmpuISTJa/rwHl28wum4+SYaL2
 jB8U6qWsOtuNPrn47TvCbtU9LvLsZnlp1l8wo0qOjK68JpzztU22ujeOAKrv1MSWBd0TB6I+cg5
 b0Ir+vQAJTnxp6Ov9GIqnxzMX69qiEvMFZ6jYf7ewYKFV73damQteP2tUxzpbpN4TtGa/w6uoPq
 f8Bsn7objBRXoY5GiKAAOrc4INRLH5NMMZUJOqoLney6SSvQ5BAU3A69vJ+ER8ytID6HSuSpR/d
 0qAJYlMc7hCMa11Q5vRsuZ7r/7VhNBTuMJA=
X-Received: by 2002:a05:6a20:a10d:b0:3fa:cfec:2286 with SMTP id
 adf61e73a8af0-4014db58d6fmr15120932637.64.1795573621403; 
 Tue, 24 Nov 2026 18:27:01 -0800 (PST)
Received: from [192.168.200.201] ([14.19.29.210])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde797af60dsm6407200a12.29.2026.11.24.18.26.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 18:27:01 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------9aaOkj0L0FGI041Lqwv0S9Po"
Message-ID: <03a8bf21-05a1-4408-99ea-c681e0a5acc3@gmail.com>
Date: Wed, 25 Nov 2026 10:26:56 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Provide weaker memory ordering for RISC-V guest FENCE
 instructions.
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Tao Tang <tangtao1634@phytium.com.cn>
References: <20261125015206.92299-1-chao.liu@processmission.com>
Content-Language: en-US
From: WX Chen <wxchen0913@gmail.com>
In-Reply-To: <20261125015206.92299-1-chao.liu@processmission.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=wxchen0913@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
--------------9aaOkj0L0FGI041Lqwv0S9Po
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,
     Thanks for the comment!

On 11/25/26 09:52, Chao Liu wrote:
> On Fri, 20 Nov 2026 17:34:54 +0800 WX Chen<wxchen0913@gmail.com> wrote:
>
>> Currently, they are implemented as full memory barriers, which may introduce stronger host barriers than the guest actually requires.
> Please wrap the commit body at 76 columns.
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html
>
> Thanks
> Chao

|Thanks for pointing this out. I'll wrap the commit body at 76 columns 
in v2. Thanks, Chen |

>> Signed-off-by: WX Chen<wxchen0913@gmail.com>
>> ---
>>   target/riscv/tcg/insn_trans/trans_rvi.c.inc | 36 +++++++++++++++++++++++++++--
>>   1 file changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>> index 4784ea1607e74eb5b0076425a732b5d3817b3482..6e094e5886360c2f9f7c187e82e6f60da36b84e4 100644
>> --- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>> +++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
>> @@ -968,8 +968,40 @@ static bool trans_pause(DisasContext *ctx, arg_pause *a)
>>   
>>   static bool trans_fence(DisasContext *ctx, arg_fence *a)
>>   {
>> -    /* FENCE is a full memory barrier. */
>> -    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>> +    /*
>> +     * FENCE.TSO orders all R/W pairs except W -> R.
>> +     * For TSO, the pred and succ should all be RW,
>> +     * otherwise it should be treated as normal FENCE.
>> +     */
>> +    if ((ctx->opcode & 0xf0000000) == 0x80000000 &&
>> +        a->pred == 3 && a->succ == 3) {
>> +        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_SC);
>> +        return true;
>> +    }
>> +
>> +    /* Reserved case, choose the strongest ordering.  */
>> +    if (ctx->opcode & 0xf0000000) {
>> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>> +        return true;
>> +    }
>> +
>> +    /* Normal FENCE. I/R for BIT 3/BIT 1, O/W for BIT 2/BIT 0 */
>> +    TCGBar ordering = 0;
>> +    if ((a->pred & 0xa) && (a->succ & 0xa)) {
>> +        ordering |= TCG_MO_LD_LD;
>> +    }
>> +    if ((a->pred & 0xa) && (a->succ & 0x5)) {
>> +        ordering |= TCG_MO_LD_ST;
>> +    }
>> +    if ((a->pred & 0x5) && (a->succ & 0xa)) {
>> +        ordering |= TCG_MO_ST_LD;
>> +    }
>> +    if ((a->pred & 0x5) && (a->succ & 0x5)) {
>> +        ordering |= TCG_MO_ST_ST;
>> +    }
>> +    if (ordering) {
>> +        tcg_gen_mb(ordering | TCG_BAR_SC);
>> +    }
>>       return true;
>>   }
>>   
>>
>> ---
>> base-commit: 08ed97c33c3818ef51a7c852347a28e9f66807b5
>> change-id: 20261120-fix-riscv-fence-20261119-10a425b78673
>>
>> Best regards,
>> -- 
>> WX Chen<wxchen0913@gmail.com>
>>
>>
>>
> Sent using hkml (https://github.com/sjp38/hackermail)
--------------9aaOkj0L0FGI041Lqwv0S9Po
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi,<br>
          Thanks for the comment!</p>
    <div class="moz-cite-prefix">On 11/25/26 09:52, Chao Liu wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20261125015206.92299-1-chao.liu@processmission.com">
      <pre wrap="" class="moz-quote-pre">On Fri, 20 Nov 2026 17:34:54 +0800 WX Chen <a class="moz-txt-link-rfc2396E" href="mailto:wxchen0913@gmail.com">&lt;wxchen0913@gmail.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Currently, they are implemented as full memory barriers, which may introduce stronger host barriers than the guest actually requires.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please wrap the commit body at 76 columns.

<a class="moz-txt-link-freetext" href="https://www.qemu.org/docs/master/devel/submitting-a-patch.html">https://www.qemu.org/docs/master/devel/submitting-a-patch.html</a>

Thanks
Chao</pre>
    </blockquote>
    <pre dir="ltr"><code>Thanks for pointing this out. I'll wrap the commit body at 76 columns
in v2.

Thanks,
Chen

</code></pre>
    <blockquote type="cite"
      cite="mid:20261125015206.92299-1-chao.liu@processmission.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: WX Chen <a class="moz-txt-link-rfc2396E" href="mailto:wxchen0913@gmail.com">&lt;wxchen0913@gmail.com&gt;</a>
---
 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 36 +++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index 4784ea1607e74eb5b0076425a732b5d3817b3482..6e094e5886360c2f9f7c187e82e6f60da36b84e4 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
@@ -968,8 +968,40 @@ static bool trans_pause(DisasContext *ctx, arg_pause *a)
 
 static bool trans_fence(DisasContext *ctx, arg_fence *a)
 {
-    /* FENCE is a full memory barrier. */
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+    /*
+     * FENCE.TSO orders all R/W pairs except W -&gt; R.
+     * For TSO, the pred and succ should all be RW,
+     * otherwise it should be treated as normal FENCE.
+     */
+    if ((ctx-&gt;opcode &amp; 0xf0000000) == 0x80000000 &amp;&amp;
+        a-&gt;pred == 3 &amp;&amp; a-&gt;succ == 3) {
+        tcg_gen_mb(TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST | TCG_BAR_SC);
+        return true;
+    }
+
+    /* Reserved case, choose the strongest ordering.  */
+    if (ctx-&gt;opcode &amp; 0xf0000000) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+        return true;
+    }
+
+    /* Normal FENCE. I/R for BIT 3/BIT 1, O/W for BIT 2/BIT 0 */
+    TCGBar ordering = 0;
+    if ((a-&gt;pred &amp; 0xa) &amp;&amp; (a-&gt;succ &amp; 0xa)) {
+        ordering |= TCG_MO_LD_LD;
+    }
+    if ((a-&gt;pred &amp; 0xa) &amp;&amp; (a-&gt;succ &amp; 0x5)) {
+        ordering |= TCG_MO_LD_ST;
+    }
+    if ((a-&gt;pred &amp; 0x5) &amp;&amp; (a-&gt;succ &amp; 0xa)) {
+        ordering |= TCG_MO_ST_LD;
+    }
+    if ((a-&gt;pred &amp; 0x5) &amp;&amp; (a-&gt;succ &amp; 0x5)) {
+        ordering |= TCG_MO_ST_ST;
+    }
+    if (ordering) {
+        tcg_gen_mb(ordering | TCG_BAR_SC);
+    }
     return true;
 }
 

---
base-commit: 08ed97c33c3818ef51a7c852347a28e9f66807b5
change-id: 20261120-fix-riscv-fence-20261119-10a425b78673

Best regards,
-- 
WX Chen <a class="moz-txt-link-rfc2396E" href="mailto:wxchen0913@gmail.com">&lt;wxchen0913@gmail.com&gt;</a>



</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Sent using hkml (<a class="moz-txt-link-freetext" href="https://github.com/sjp38/hackermail">https://github.com/sjp38/hackermail</a>)
</pre>
    </blockquote>
  </body>
</html>

--------------9aaOkj0L0FGI041Lqwv0S9Po--

