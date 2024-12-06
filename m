Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FFDE7716F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 04:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJQ7i-0008BF-Ud; Thu, 05 Dec 2024 23:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tJQ7g-0008B0-KQ; Thu, 05 Dec 2024 23:39:24 -0500
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1tJQ7X-00042j-S4; Thu, 05 Dec 2024 23:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1733459945; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=WexzTEMmtpSkRCf6g9ZxgBJnl1Ej5Zz+xUkMUl4uGsE=;
 b=VVTSnzgmhsrqNh9o01AksaXA0aQ/sC2JZLg0LzZONCqleUNZPqwfcwzgV3EAm2CGYHyjjEGBbGr2dFPkCyzsQGjkYorbBdzsVMlK3jJr17DcmkFFZbXIneVaR1p/Jgq1rBAy9bAyHsIU+ynZ/l2SfhTMLagJFm7zHxDb0rMtMwg=
Received: from 30.166.64.70(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WKvIBcQ_1733459943 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 06 Dec 2024 12:39:04 +0800
Content-Type: multipart/alternative;
 boundary="------------0fzTgg4J99MRJQeoQilasba0"
Message-ID: <5536d7c4-c3df-4cac-900b-bbb3cb2a8c4d@linux.alibaba.com>
Date: Fri, 6 Dec 2024 12:39:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] disas/riscv: Guard dec->cfg dereference for host
 disassemble
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20241206032411.52528-1-zhiwei_liu@linux.alibaba.com>
 <79a76786-9ba7-4c04-8c11-52c92376e6df@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <79a76786-9ba7-4c04-8c11-52c92376e6df@linaro.org>
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -94
X-Spam_score: -9.5
X-Spam_bar: ---------
X-Spam_report: (-9.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
--------------0fzTgg4J99MRJQeoQilasba0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/12/6 11:36, Richard Henderson wrote:
> On 12/5/24 21:24, LIU Zhiwei wrote:
>> For riscv host, it will set dec->cfg to zero. Thus we shuld guard
>> the dec->cfg deference for riscv host disassemble.
>>
>> And in general, we should only use dec->cfg for target in three cases:
>>
>> 1) For not incompatible encodings, such as zcmp/zcmt/zfinx.
>> 2) For maybe-ops encodings, they are better to be disassembled to
>>     the "real" extensions, such as zicfiss. The guard of dec->zimop
>>     and dec->zcmop is for comment and avoid check for every extension
>>     that encoded in maybe-ops area.
>> 3) For custom encodings, we have to use dec->cfg to disassemble
>>     custom encodings using the same encoding area.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>
> ...
>
>> @@ -5112,28 +5112,28 @@ static GString *format_inst(size_t tab, 
>> rv_decode *dec)
>>               g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
>>               break;
>>           case '3':
>> -            if (dec->cfg->ext_zfinx) {
>> +            if (dec->cfg && dec->cfg->ext_zfinx) {
>>                   g_string_append(buf, rv_ireg_name_sym[dec->rd]);
>>               } else {
>>                   g_string_append(buf, rv_freg_name_sym[dec->rd]);
>>               }
>>               break;
>>           case '4':
>> -            if (dec->cfg->ext_zfinx) {
>> +            if (dec->cfg && dec->cfg->ext_zfinx) {
>>                   g_string_append(buf, rv_ireg_name_sym[dec->rs1]);
>>               } else {
>>                   g_string_append(buf, rv_freg_name_sym[dec->rs1]);
>>               }
>>               break;
>>           case '5':
>> -            if (dec->cfg->ext_zfinx) {
>> +            if (dec->cfg && dec->cfg->ext_zfinx) {
>>                   g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
>>               } else {
>>                   g_string_append(buf, rv_freg_name_sym[dec->rs2]);
>>               }
>>               break;
>>           case '6':
>> -            if (dec->cfg->ext_zfinx) {
>> +            if (dec->cfg && dec->cfg->ext_zfinx) {
>>                   g_string_append(buf, rv_ireg_name_sym[dec->rs3]);
>>               } else {
>>                   g_string_append(buf, rv_freg_name_sym[dec->rs3]);
>
> These are the only tests of cfg that are required.
> None of the other standard isa extensions overlap.

Both zcmt and zcmp are not compatible with Zcd, as they reuse some encodings from c.fsdsp.

Zimop or Zcmop also overlap with other isa extensions, as they are maybe-ops. Other extensions
such as zicfiss will reuse their encodings.

I think we had better disassemble them to zicifss if it has been implemented on the target cpu. Otherwise
we disassemble them to maybe-ops.

>
>> @@ -5439,7 +5439,8 @@ static GString *disasm_inst(rv_isa isa, 
>> uint64_t pc, rv_inst inst,
>>           const rv_opcode_data *opcode_data = decoders[i].opcode_data;
>>           void (*decode_func)(rv_decode *, rv_isa) = 
>> decoders[i].decode_func;
>>   -        if (guard_func(cfg)) {
>> +        /* always_true_p don't dereference cfg */
>> +        if (((i == 0) || cfg) && guard_func(cfg)) {
>
> This should be i == 0 || (cfg && guard_func(cfg)).

OK. Although I think they are both right.

Thanks,
Zhiwei

>
>
> r~
--------------0fzTgg4J99MRJQeoQilasba0
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
    <div class="moz-cite-prefix">On 2024/12/6 11:36, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:79a76786-9ba7-4c04-8c11-52c92376e6df@linaro.org">On
      12/5/24 21:24, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">For riscv host, it will set dec-&gt;cfg to
        zero. Thus we shuld guard
        <br>
        the dec-&gt;cfg deference for riscv host disassemble.
        <br>
        <br>
        And in general, we should only use dec-&gt;cfg for target in
        three cases:
        <br>
        <br>
        1) For not incompatible encodings, such as zcmp/zcmt/zfinx.
        <br>
        2) For maybe-ops encodings, they are better to be disassembled
        to
        <br>
            the "real" extensions, such as zicfiss. The guard of
        dec-&gt;zimop
        <br>
            and dec-&gt;zcmop is for comment and avoid check for every
        extension
        <br>
            that encoded in maybe-ops area.
        <br>
        3) For custom encodings, we have to use dec-&gt;cfg to
        disassemble
        <br>
            custom encodings using the same encoding area.
        <br>
        <br>
        Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
        <br>
        Suggested-by: Richard Henderson
        <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
        <br>
      </blockquote>
      <br>
      ...
      <br>
      <br>
      <blockquote type="cite">@@ -5112,28 +5112,28 @@ static GString
        *format_inst(size_t tab, rv_decode *dec)
        <br>
                      g_string_append(buf,
        rv_ireg_name_sym[dec-&gt;rs2]);
        <br>
                      break;
        <br>
                  case '3':
        <br>
        -            if (dec-&gt;cfg-&gt;ext_zfinx) {
        <br>
        +            if (dec-&gt;cfg &amp;&amp;
        dec-&gt;cfg-&gt;ext_zfinx) {
        <br>
                          g_string_append(buf,
        rv_ireg_name_sym[dec-&gt;rd]);
        <br>
                      } else {
        <br>
                          g_string_append(buf,
        rv_freg_name_sym[dec-&gt;rd]);
        <br>
                      }
        <br>
                      break;
        <br>
                  case '4':
        <br>
        -            if (dec-&gt;cfg-&gt;ext_zfinx) {
        <br>
        +            if (dec-&gt;cfg &amp;&amp;
        dec-&gt;cfg-&gt;ext_zfinx) {
        <br>
                          g_string_append(buf,
        rv_ireg_name_sym[dec-&gt;rs1]);
        <br>
                      } else {
        <br>
                          g_string_append(buf,
        rv_freg_name_sym[dec-&gt;rs1]);
        <br>
                      }
        <br>
                      break;
        <br>
                  case '5':
        <br>
        -            if (dec-&gt;cfg-&gt;ext_zfinx) {
        <br>
        +            if (dec-&gt;cfg &amp;&amp;
        dec-&gt;cfg-&gt;ext_zfinx) {
        <br>
                          g_string_append(buf,
        rv_ireg_name_sym[dec-&gt;rs2]);
        <br>
                      } else {
        <br>
                          g_string_append(buf,
        rv_freg_name_sym[dec-&gt;rs2]);
        <br>
                      }
        <br>
                      break;
        <br>
                  case '6':
        <br>
        -            if (dec-&gt;cfg-&gt;ext_zfinx) {
        <br>
        +            if (dec-&gt;cfg &amp;&amp;
        dec-&gt;cfg-&gt;ext_zfinx) {
        <br>
                          g_string_append(buf,
        rv_ireg_name_sym[dec-&gt;rs3]);
        <br>
                      } else {
        <br>
                          g_string_append(buf,
        rv_freg_name_sym[dec-&gt;rs3]);
        <br>
      </blockquote>
      <br>
      These are the only tests of cfg that are required.
      <br>
    </blockquote>
    <blockquote type="cite"
      cite="mid:79a76786-9ba7-4c04-8c11-52c92376e6df@linaro.org">None of
      the other standard isa extensions overlap.
      <br>
    </blockquote>
    <pre
style="color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">Both zcmt and zcmp are not compatible with Zcd, as they reuse some encodings from c.fsdsp.

Zimop or Zcmop also overlap with other isa extensions, as they are maybe-ops. Other extensions
such as zicfiss will reuse their encodings.

I think we had better disassemble them to zicifss if it has been implemented on the target cpu. Otherwise
we disassemble them to maybe-ops.

</pre>
    <blockquote type="cite"
      cite="mid:79a76786-9ba7-4c04-8c11-52c92376e6df@linaro.org">
      <br>
      <blockquote type="cite">@@ -5439,7 +5439,8 @@ static GString
        *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
        <br>
                  const rv_opcode_data *opcode_data =
        decoders[i].opcode_data;
        <br>
                  void (*decode_func)(rv_decode *, rv_isa) =
        decoders[i].decode_func;
        <br>
          -        if (guard_func(cfg)) {
        <br>
        +        /* always_true_p don't dereference cfg */
        <br>
        +        if (((i == 0) || cfg) &amp;&amp; guard_func(cfg)) {
        <br>
      </blockquote>
      <br>
      This should be i == 0 || (cfg &amp;&amp; guard_func(cfg)).
      <br>
    </blockquote>
    <p>OK. Although I think they are both right.<br>
    </p>
    <pre
style="color: rgb(0, 0, 0); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
Thanks,
Zhiwei</pre>
    <p></p>
    <blockquote type="cite"
      cite="mid:79a76786-9ba7-4c04-8c11-52c92376e6df@linaro.org">
      <br>
      <br>
      r~
      <br>
    </blockquote>
  </body>
</html>

--------------0fzTgg4J99MRJQeoQilasba0--

