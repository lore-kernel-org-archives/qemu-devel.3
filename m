Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F19BC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welmk-0003pF-J4; Tue, 30 Jun 2026 23:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1welmf-0003p0-Bz; Tue, 30 Jun 2026 23:38:45 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1welmZ-00050a-93; Tue, 30 Jun 2026 23:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782877100; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=89Yjtthabyu7aqAaJwksUAvXmtc5nzkqaHsCrziG5oo=;
 b=dfHo1pDdu8p6MAeAZ2w9Yd5SkNBaIvUSglPTQk4H4+W/bgAdQ3wUwdQ9+f02XXQQTon3lWKFauzEIFHyWFA4Vu/CNPPELj4NMJsciURlsXiKuQImFVFBTLFLaHoZMjeQrEDQ3adPZyqANByVMxZLHGrEN+Xhy4Ngi7nbymT7SMM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R831e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0X62KYLp_1782877099; 
Received: from 30.166.81.28(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X62KYLp_1782877099 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 01 Jul 2026 11:38:20 +0800
Content-Type: multipart/alternative;
 boundary="------------KyCQT687kBOloGihfx5LzDB0"
Message-ID: <52ae2ac5-36ae-4df6-b69d-2954b56ac257@linux.alibaba.com>
Date: Wed, 1 Jul 2026 11:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] disas/riscv: Use extract helpers for operand fields
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org
References: <20260701-b4-disas-xthead-fix-riscv-next-v2-0-e6e4ff5a7847@linux.alibaba.com>
 <20260701-b4-disas-xthead-fix-riscv-next-v2-5-e6e4ff5a7847@linux.alibaba.com>
 <f4235288-ef5f-4ae1-b5fe-eafcf1d19dc2@linaro.org>
From: TianCheng TANG <lyndra@linux.alibaba.com>
In-Reply-To: <f4235288-ef5f-4ae1-b5fe-eafcf1d19dc2@linaro.org>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
--------------KyCQT687kBOloGihfx5LzDB0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/1 11:17, Richard Henderson 写道:
> On 6/30/26 18:51, TANG Tiancheng wrote:
>>   static int32_t operand_imm20(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 32) >> 44) << 12;
>> +    return extract32(inst, 12, 20) << 12;
>>   }
>
> sextract32.
>
|Yes, that is cleaner. operand_imm20 does not need sign extension, since 
it already places the top bit of imm20 at bit 31. But I will keep the 
style consistent with the other immediate helpers.|

>>     static int32_t operand_jimm20(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 32) >> 63) << 20 |
>> -        ((inst << 33) >> 54) << 1 |
>> -        ((inst << 43) >> 63) << 11 |
>> -        ((inst << 44) >> 56) << 12;
>> +    uint32_t imm = extract32(inst, 31, 1) << 20 |
>> +        extract32(inst, 21, 10) << 1 |
>> +        extract32(inst, 20, 1) << 11 |
>> +        extract32(inst, 12, 8) << 12;
>> +
>> +    return sextract32(imm, 0, 21);
>>   }
>
> You can use sextract32 on the first extraction, rather than 
> re-extracting at the end:
>
>     return sextract(inst, 31, 1) << 20 |
>            ...
>
>
|Yes, I will update the split signed immediate helpers that way.|
|||Regards, Tiancheng|

>>   static int32_t operand_simm12(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 32) >> 57) << 5 |
>> -        (inst << 52) >> 59;
>> +    uint32_t imm = extract32(inst, 25, 7) << 5 |
>> +        extract32(inst, 7, 5);
>> +
>> +    return sextract32(imm, 0, 12);
>>   }
>
> Likewise.
>
>>     static int32_t operand_sbimm12(rv_inst inst)
>>   {
>> -    return (((int64_t)inst << 32) >> 63) << 12 |
>> -        ((inst << 33) >> 58) << 5 |
>> -        ((inst << 52) >> 60) << 1 |
>> -        ((inst << 56) >> 63) << 11;
>> +    uint32_t imm = extract32(inst, 31, 1) << 12 |
>> +        extract32(inst, 25, 6) << 5 |
>> +        extract32(inst, 8, 4) << 1 |
>> +        extract32(inst, 7, 1) << 11;
>> +
>> +    return sextract32(imm, 0, 13);
>>   }
>
> Etc.
>
>
> r~
--------------KyCQT687kBOloGihfx5LzDB0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2026/7/1 11:17, Richard Henderson 写道:<br>
    </div>
    <blockquote type="cite"
      cite="mid:f4235288-ef5f-4ae1-b5fe-eafcf1d19dc2@linaro.org">On
      6/30/26 18:51, TANG Tiancheng wrote:
      <br>
      <blockquote type="cite">  static int32_t operand_imm20(rv_inst
        inst)
        <br>
          {
        <br>
        -    return (((int64_t)inst &lt;&lt; 32) &gt;&gt; 44) &lt;&lt;
        12;
        <br>
        +    return extract32(inst, 12, 20) &lt;&lt; 12;
        <br>
          }
        <br>
      </blockquote>
      <br>
      sextract32.
      <br>
      <br>
    </blockquote>
    <pre><code>Yes, that is cleaner.

operand_imm20 does not need sign extension, since it already places the
top bit of imm20 at bit 31.  But I will keep the style consistent with
the other immediate helpers.</code></pre>
    <blockquote type="cite"
      cite="mid:f4235288-ef5f-4ae1-b5fe-eafcf1d19dc2@linaro.org">
      <blockquote type="cite">    static int32_t operand_jimm20(rv_inst
        inst)
        <br>
          {
        <br>
        -    return (((int64_t)inst &lt;&lt; 32) &gt;&gt; 63) &lt;&lt;
        20 |
        <br>
        -        ((inst &lt;&lt; 33) &gt;&gt; 54) &lt;&lt; 1 |
        <br>
        -        ((inst &lt;&lt; 43) &gt;&gt; 63) &lt;&lt; 11 |
        <br>
        -        ((inst &lt;&lt; 44) &gt;&gt; 56) &lt;&lt; 12;
        <br>
        +    uint32_t imm = extract32(inst, 31, 1) &lt;&lt; 20 |
        <br>
        +        extract32(inst, 21, 10) &lt;&lt; 1 |
        <br>
        +        extract32(inst, 20, 1) &lt;&lt; 11 |
        <br>
        +        extract32(inst, 12, 8) &lt;&lt; 12;
        <br>
        +
        <br>
        +    return sextract32(imm, 0, 21);
        <br>
          }
        <br>
      </blockquote>
      <br>
      You can use sextract32 on the first extraction, rather than
      re-extracting at the end:
      <br>
      <br>
          return sextract(inst, 31, 1) &lt;&lt; 20 |
      <br>
                 ...
      <br>
      <br>
      <br>
    </blockquote>
    <pre><code>Yes, I will update the split signed immediate helpers that way.</code>
<code>
</code><code>Regards,
Tiancheng</code></pre>
    <blockquote type="cite"
      cite="mid:f4235288-ef5f-4ae1-b5fe-eafcf1d19dc2@linaro.org">
      <blockquote type="cite">  static int32_t operand_simm12(rv_inst
        inst)
        <br>
          {
        <br>
        -    return (((int64_t)inst &lt;&lt; 32) &gt;&gt; 57) &lt;&lt; 5
        |
        <br>
        -        (inst &lt;&lt; 52) &gt;&gt; 59;
        <br>
        +    uint32_t imm = extract32(inst, 25, 7) &lt;&lt; 5 |
        <br>
        +        extract32(inst, 7, 5);
        <br>
        +
        <br>
        +    return sextract32(imm, 0, 12);
        <br>
          }
        <br>
      </blockquote>
      <br>
      Likewise.
      <br>
      <br>
      <blockquote type="cite">    static int32_t operand_sbimm12(rv_inst
        inst)
        <br>
          {
        <br>
        -    return (((int64_t)inst &lt;&lt; 32) &gt;&gt; 63) &lt;&lt;
        12 |
        <br>
        -        ((inst &lt;&lt; 33) &gt;&gt; 58) &lt;&lt; 5 |
        <br>
        -        ((inst &lt;&lt; 52) &gt;&gt; 60) &lt;&lt; 1 |
        <br>
        -        ((inst &lt;&lt; 56) &gt;&gt; 63) &lt;&lt; 11;
        <br>
        +    uint32_t imm = extract32(inst, 31, 1) &lt;&lt; 12 |
        <br>
        +        extract32(inst, 25, 6) &lt;&lt; 5 |
        <br>
        +        extract32(inst, 8, 4) &lt;&lt; 1 |
        <br>
        +        extract32(inst, 7, 1) &lt;&lt; 11;
        <br>
        +
        <br>
        +    return sextract32(imm, 0, 13);
        <br>
          }
        <br>
      </blockquote>
      <br>
      Etc.
      <br>
      <br>
      <br>
      r~
      <br>
    </blockquote>
  </body>
</html>

--------------KyCQT687kBOloGihfx5LzDB0--

