Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51177C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW87k-000469-Ip; Tue, 23 Jul 2024 01:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sW87V-0003UR-Tz; Tue, 23 Jul 2024 01:31:36 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sW87S-0001TI-O0; Tue, 23 Jul 2024 01:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721712677; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=xt7NhqdCFGA9tOVP6fxR51inD0AiGfOcS0dWC5UHZug=;
 b=d8dcNCN4rlVwr8dUKnu4QnA0n4vWVJh7aXNOvBCS36K8DdNT3PSxAmUcPNI1VOm9maW1VZRF63CCVeD4NOcEK3SMrqeFMN5gZWus6HNSkHV00xWstaJ28VGIMOU4OWwAdE9/WWWZe+3EXoKNgkRiDRV2Loc/QvDs50VaAnH5mAE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WB7yBSG_1721712675; 
Received: from 30.166.64.117(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WB7yBSG_1721712675) by smtp.aliyun-inc.com;
 Tue, 23 Jul 2024 13:31:16 +0800
Content-Type: multipart/alternative;
 boundary="------------EmMvZlHBlDO4OfDJHHtKPtvu"
Message-ID: <df37fdc2-79c6-420c-bcf4-e7c3649fe446@linux.alibaba.com>
Date: Tue, 23 Jul 2024 13:29:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: Remove redundant insn length check for
 zama16b
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
 <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
--------------EmMvZlHBlDO4OfDJHHtKPtvu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/7/23 10:11, Richard Henderson wrote:
> On 7/23/24 11:30, LIU Zhiwei wrote:
>> Both trans_fld/fsd/flw/fsw and gen_load/store will never be a
>> translation function for compressed instructions, thus we can
>> remove instruction length check for them.
>>
>> Suggested-by: Alistair Francis <alistair.francis@wdc.com>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>
> That is both false (trans_fld is used from trans_c_fld),
Yes. I will fix it later.
> and not the takeaway you should have gotten (the operation of "fld" 
> should not depend on the encoding

Do you mean c_fld 和fld both applies to zama16b?

> ).
>
> Perhaps FLD/FSD should depend on the ISA (RV32 vs RV64), but perhaps 
> not.  I cannot tell because I don't see a specification for Zama16b in
>
> https://wiki.riscv.org/display/HOME/RISC-V+Specification+Status

I think Zama16b first named in RVA23 profile as Alistair points out.

The more detailed information about its meaning is in priviledged 1.13 
specification. More exactly, in 3.6.4. Misaligned Atomicity Granule PMA.

The specification said:

"The misaligned atomicity granule PMA applies only to AMOs, loads and stores defined in the base
ISAs, and loads and stores of no more than MXLEN bits defined in the F, D, and Q extensions. For an
instruction in that set, if all accessed bytes lie within the same misaligned atomicity granule, the
instruction will not raise an exception for reasons of address alignment, and the instruction will give
rise to only one memory operation for the purposes of RVWMO—i.e., it will execute atomically."

That's the reason why I do not apply zama16b to compressed instructions.

Thanks,
Zhiwei

>
>
> r~
--------------EmMvZlHBlDO4OfDJHHtKPtvu
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
    <div class="moz-cite-prefix">On 2024/7/23 10:11, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org">On
      7/23/24 11:30, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">Both trans_fld/fsd/flw/fsw and
        gen_load/store will never be a
        <br>
        translation function for compressed instructions, thus we can
        <br>
        remove instruction length check for them.
        <br>
        <br>
        Suggested-by: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>
        <br>
        Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
        <br>
      </blockquote>
      <br>
      That is both false (trans_fld is used from trans_c_fld),</blockquote>
    Yes. I will fix it later.<br>
    <blockquote type="cite"
      cite="mid:dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org"> and
      not the takeaway you should have gotten (the operation of "fld"
      should not depend on the encoding</blockquote>
    <p>Do you mean c_fld 和fld both applies to zama16b?</p>
    <blockquote type="cite"
      cite="mid:dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org">).
      <br>
      <br>
      Perhaps FLD/FSD should depend on the ISA (RV32 vs RV64), but
      perhaps not.  I cannot tell because I don't see a specification
      for Zama16b in
      <br>
      <br>
        <a class="moz-txt-link-freetext" href="https://wiki.riscv.org/display/HOME/RISC-V+Specification+Status">https://wiki.riscv.org/display/HOME/RISC-V+Specification+Status</a>
      <br>
    </blockquote>
    <p>I think Zama16b first named in RVA23 profile as Alistair points
      out. <br>
    </p>
    <p>The more detailed information about its meaning is in priviledged
      1.13 specification. More exactly, in 3.6.4. Misaligned Atomicity
      Granule PMA.<br>
    </p>
    <p>The specification said:</p>
    <pre>"The misaligned atomicity granule PMA applies only to AMOs, loads and stores defined in the base
ISAs, and loads and stores of no more than MXLEN bits defined in the F, D, and Q extensions. For an
instruction in that set, if all accessed bytes lie within the same misaligned atomicity granule, the
instruction will not raise an exception for reasons of address alignment, and the instruction will give
rise to only one memory operation for the purposes of RVWMO—i.e., it will execute atomically."

</pre>
    <p>That's the reason why I do not apply zama16b to compressed
      instructions.</p>
    <p>Thanks,<br>
      Zhiwei<br>
    </p>
    <blockquote type="cite"
      cite="mid:dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org">
      <br>
      <br>
      r~
      <br>
    </blockquote>
  </body>
</html>

--------------EmMvZlHBlDO4OfDJHHtKPtvu--

