Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B7DCD37AA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHjh-0008Un-49; Fri, 08 May 2026 05:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wLHje-0008U0-Nv; Fri, 08 May 2026 05:43:06 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1wLHjb-0004qq-V5; Fri, 08 May 2026 05:43:06 -0400
Received: from [10.213.20.8] (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowABXAm4bsP1p5_eZDw--.27208S3;
 Fri, 08 May 2026 17:42:51 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------X0RMCQiPY08ix5Q0TbOa0wjE"
Message-ID: <a9bea264-c02d-4ba6-b04d-8c48d53d017d@iscas.ac.cn>
Date: Fri, 8 May 2026 17:42:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/riscv: rvp: Add option defines and
 dependency check for packed simd extension
To: Kito Cheng <kito.cheng@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
 <20260417104652.17857-2-xiaoou@iscas.ac.cn>
 <336c0c4b-af67-4cb8-91f3-704348124f55@oss.qualcomm.com>
 <CA+yXCZDgpcUZSgy2bSnch7FMw6YmJC-8RTs=c-GcckSddGkP+g@mail.gmail.com>
From: Molly Chen <xiaoou@iscas.ac.cn>
In-Reply-To: <CA+yXCZDgpcUZSgy2bSnch7FMw6YmJC-8RTs=c-GcckSddGkP+g@mail.gmail.com>
X-CM-TRANSID: qwCowABXAm4bsP1p5_eZDw--.27208S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GrykCFW3tF1xJrykKw4UArb_yoWfArX_Gr
 4xtr97Jw1rAr4xKr45Crn3Jr97CFZIkF1Yga4Dtw429FyxWFWDC347Krnayr4xG3yfKryS
 kF15Xw1ay3Wa9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb78YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAv7VC0I7IYx2IY
 67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y4
 8IcVAKI48JMx8GjcxK6IxK0xIIj40E5I8CrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY
 0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r106r1rMI8I3I
 0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
 cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
 CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
 c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ov35UUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.998,
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
--------------X0RMCQiPY08ix5Q0TbOa0wjE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kito,

Thanks for review. This is because the P extension includes 
pseudo-instructions for |pack|,

while the trans function for |pack|checks for a dependency on |zbkb|.

Perhaps the dependency check in the |pack|function should first be 
adjusted to depend on either |zbkb|or |zbb|.

> static bool trans_pack(DisasContext *ctx, arg_pack *a)
> {
>     REQUIRE_ZBKB(ctx);
>     return gen_arith(ctx, a, EXT_NONE, gen_pack, NULL);
> }

Best regards,
Molly

在 2026/5/7 15:43, Kito Cheng 写道:
> Hi Molly:
>
>> +    if (riscv_has_ext(env, RVP) &&
>> +        !(cpu->cfg.ext_zba && cpu->cfg.ext_zbb && cpu->cfg.ext_zbkb)) {
>> +        error_setg(errp, "P extension requires zba, zbb and zbkb extensions");
>> +        return;
>> +    }
>> +
> zbkb should not in required extension according spec:
>
> https://github.com/riscv/riscv-p-spec/blob/master/P-ext-proposal.adoc#p-extension-for-packed-single-instruction-multiple-data
--------------X0RMCQiPY08ix5Q0TbOa0wjE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Kito,<br>
      <br>
      Thanks for review. <span>This is because the P extension includes
        pseudo-instructions for </span><code dir="ltr"><span>pack</span></code><span>,</span></p>
    <p><span>while the trans function for </span><code dir="ltr"><span>pack</span></code><span>
        checks for a dependency on </span><code dir="ltr"><span>zbkb</span></code><span>.</span></p>
    <p><span>Perhaps the dependency check in the </span><code dir="ltr"><span>pack</span></code><span>
        function should first be adjusted to depend on either </span><code
        dir="ltr"><span>zbkb</span></code><span> or </span><code
        dir="ltr"><span>zbb</span></code><span>.<br>
        <br>
        <blockquote type="cite">static bool trans_pack(DisasContext
          *ctx, arg_pack *a)<br>
          {<br>
              REQUIRE_ZBKB(ctx);<br>
              return gen_arith(ctx, a, EXT_NONE, gen_pack, NULL);<br>
          }</blockquote>
        <br>
      </span></p>
    <p><span>Best regards,</span><br>
      <span>Molly</span></p>
    <div class="moz-cite-prefix">在 2026/5/7 15:43, Kito Cheng 写道:<br>
    </div>
    <blockquote type="cite"
cite="mid:CA+yXCZDgpcUZSgy2bSnch7FMw6YmJC-8RTs=c-GcckSddGkP+g@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Hi Molly:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+    if (riscv_has_ext(env, RVP) &amp;&amp;
+        !(cpu-&gt;cfg.ext_zba &amp;&amp; cpu-&gt;cfg.ext_zbb &amp;&amp; cpu-&gt;cfg.ext_zbkb)) {
+        error_setg(errp, "P extension requires zba, zbb and zbkb extensions");
+        return;
+    }
+
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
zbkb should not in required extension according spec:

<a class="moz-txt-link-freetext" href="https://github.com/riscv/riscv-p-spec/blob/master/P-ext-proposal.adoc#p-extension-for-packed-single-instruction-multiple-data">https://github.com/riscv/riscv-p-spec/blob/master/P-ext-proposal.adoc#p-extension-for-packed-single-instruction-multiple-data</a>
</pre>
    </blockquote>
  </body>
</html>

--------------X0RMCQiPY08ix5Q0TbOa0wjE--


