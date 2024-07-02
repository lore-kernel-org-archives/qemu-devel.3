Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BBBC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 01:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOSfQ-0000bH-8x; Mon, 01 Jul 2024 21:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOSfL-0000az-Hz; Mon, 01 Jul 2024 21:50:44 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOSfE-0008Iu-EJ; Mon, 01 Jul 2024 21:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719885021; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=MxDm+73p/7jDB68q0GPhmhL0g+5B8WPi1BLHFzKTuFY=;
 b=I5mhRHyIsGdj3OHiesf1EPXZL2cLuhfth2NX48iqm+L6HJF0y1Nd5FfqWUOTWQvbSSPffxWqzhvNJULL0tfbpHMJWm0fmKYQvts96ZFYa4/qGNHNLwJH5GgcAZBWxRzyjpQrUXOEiHziWSNe5KYwlvmUlgXULMQJmvIxlD24a3U=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067111;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W9gTA.K_1719885019; 
Received: from 30.166.64.126(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9gTA.K_1719885019) by smtp.aliyun-inc.com;
 Tue, 02 Jul 2024 09:50:20 +0800
Content-Type: multipart/alternative;
 boundary="------------060WPHF5PYBuFdTGReZUYvao"
Message-ID: <00f74b57-fe5b-4b34-89e7-f025a22252af@linux.alibaba.com>
Date: Tue, 2 Jul 2024 09:48:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/riscv: Correct SXL return value for RV32 in
 RV64 QEMU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240701033722.954-1-zhiwei_liu@linux.alibaba.com>
 <20240701033722.954-4-zhiwei_liu@linux.alibaba.com>
 <2ea8672a-cf36-45c3-850b-f7513e9052a6@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <2ea8672a-cf36-45c3-850b-f7513e9052a6@linaro.org>
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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
--------------060WPHF5PYBuFdTGReZUYvao
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/7/1 23:10, Philippe Mathieu-Daudé wrote:
> Hi Tiancheng, Zhiwei,
>
> On 1/7/24 05:37, LIU Zhiwei wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>
>> Ensure that riscv_cpu_sxl returns MXL_RV32 when runningRV32 in an
>> RV64 QEMU.
>>
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Fixes: 05e6ca5e156 ("target/riscv: Ignore reserved bits in PTE for 
>> RV64")
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   target/riscv/cpu.h | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 6fe0d712b4..36a712044a 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -668,8 +668,11 @@ static inline RISCVMXL 
>> riscv_cpu_sxl(CPURISCVState *env)
>>   #ifdef CONFIG_USER_ONLY
>>       return env->misa_mxl;
>>   #else
>> -    return get_field(env->mstatus, MSTATUS64_SXL);
>> +    if (env->misa_mxl != MXL_RV32) {
>> +        return get_field(env->mstatus, MSTATUS64_SXL);
>> +    }
>>   #endif
>> +    return MXL_RV32;
>
> Can we simplify the previous TARGET_RISCV32 ifdef'ry?

I think you mean the TARGET_RISCV32 macro here:

#ifdef TARGET_RISCV32
#define riscv_cpu_sxl(env)  ((void)(env), MXL_RV32)
#else
static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
{
#ifdef CONFIG_USER_ONLY
     return env->misa_mxl;
#else
     return get_field(env->mstatus, MSTATUS64_SXL);
#endif
}
#endif

I think it is better to keep it here for better performance(as a constant).

If you mean whether we  can simplify all the ifdef TARGET_RISCV32 in 
target/riscv or hw/riscv, IMHO, it depends. I git grep the 
TARGET_RISCV32 from target/riscv:

target/riscv/cpu-param.h:#elif defined(TARGET_RISCV32)

target/riscv/cpu.c:#ifdef TARGET_RISCV32

target/riscv/cpu.c:#if defined(TARGET_RISCV32)

target/riscv/cpu.h:#if defined(TARGET_RISCV32)

target/riscv/cpu.h:#ifdef TARGET_RISCV32

target/riscv/cpu.h:#if defined(TARGET_RISCV32)

target/riscv/cpu.h:#if defined(TARGET_RISCV32)

target/riscv/cpu.h:#ifdef TARGET_RISCV32

target/riscv/insn_trans/trans_rvzacas.c.inc:#ifdef TARGET_RISCV32

target/riscv/kvm/kvm-cpu.c:#if defined(TARGET_RISCV32)

target/riscv/translate.c:#ifdef TARGET_RISCV32

target/riscv/translate.c:#ifdef TARGET_RISCV32

target/riscv/translate.c:#ifdef TARGET_RISCV32

target/riscv/translate.c:#ifdef TARGET_RISCV32

target/riscv/translate.c:#ifdef TARGET_RISCV32

target/riscv/translate.c:#ifdef TARGET_RISCV32

target/riscv/translate.c:#ifdef TARGET_RISCV32

One case we can remove the TARGET_RISCV32 is in translate.c.

static void gen_set_fpr_hs(DisasContext *ctx, int reg_num, TCGv_i64 t)

{

     if (!ctx->cfg_ptr->ext_zfinx) {

         tcg_gen_mov_i64(cpu_fpr[reg_num], t);

         return;

     }

     if (reg_num != 0) {

         switch (get_xl(ctx)) {

         case MXL_RV32:

#ifdef TARGET_RISCV32

             tcg_gen_extrl_i64_i32(cpu_gpr[reg_num], t);

             break;

#else

         /* fall through */

         case MXL_RV64:

             tcg_gen_mov_i64(cpu_gpr[reg_num], t);

             break;

#endif

         default:

             g_assert_not_reached();

         }

     }

}

We can simplify this code by tcg_gen_trunc_i64_tl.

One case we can't remove the TARGET_RISCV32 is in cpu.c, where we define 
any or max cpu with the width depending on this macro.
I don't analyze all TARGET_RISCV32 using here.  We will upstream a 
standalone patch for validating all its using later.

Thanks,
Zhiwei

>
>>   }
>>   #endif
--------------060WPHF5PYBuFdTGReZUYvao
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
    <div class="moz-cite-prefix">On 2024/7/1 23:10, Philippe
      Mathieu-Daudé wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2ea8672a-cf36-45c3-850b-f7513e9052a6@linaro.org">Hi
      Tiancheng, Zhiwei,
      <br>
      <br>
      On 1/7/24 05:37, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">From: TANG Tiancheng
        <a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a>
        <br>
        <br>
        Ensure that riscv_cpu_sxl returns MXL_RV32 when runningRV32 in
        an
        <br>
        RV64 QEMU.
        <br>
        <br>
        Signed-off-by: TANG Tiancheng
        <a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a>
        <br>
        Fixes: 05e6ca5e156 ("target/riscv: Ignore reserved bits in PTE
        for RV64")
        <br>
        Reviewed-by: Liu Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
        <br>
        ---
        <br>
          target/riscv/cpu.h | 5 ++++-
        <br>
          1 file changed, 4 insertions(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
        <br>
        index 6fe0d712b4..36a712044a 100644
        <br>
        --- a/target/riscv/cpu.h
        <br>
        +++ b/target/riscv/cpu.h
        <br>
        @@ -668,8 +668,11 @@ static inline RISCVMXL
        riscv_cpu_sxl(CPURISCVState *env)
        <br>
          #ifdef CONFIG_USER_ONLY
        <br>
              return env-&gt;misa_mxl;
        <br>
          #else
        <br>
        -    return get_field(env-&gt;mstatus, MSTATUS64_SXL);
        <br>
        +    if (env-&gt;misa_mxl != MXL_RV32) {
        <br>
        +        return get_field(env-&gt;mstatus, MSTATUS64_SXL);
        <br>
        +    }
        <br>
          #endif
        <br>
        +    return MXL_RV32;
        <br>
      </blockquote>
      <br>
      Can we simplify the previous TARGET_RISCV32 ifdef'ry?
      <br>
    </blockquote>
    <p>I think you mean the TARGET_RISCV32 macro here:</p>
    <pre>#ifdef TARGET_RISCV32
#define riscv_cpu_sxl(env)  ((void)(env), MXL_RV32)
#else
static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *env)
{
#ifdef CONFIG_USER_ONLY
    return env-&gt;misa_mxl;
#else
    return get_field(env-&gt;mstatus, MSTATUS64_SXL);
#endif
}
#endif
</pre>
    <pre></pre>
    <p>I think it is better to keep it here for better performance(as a
      constant).<br>
    </p>
    <p>If you mean whether we  can simplify all the ifdef TARGET_RISCV32
      in target/riscv or hw/riscv, IMHO, it depends. I git grep the
      TARGET_RISCV32 from target/riscv:</p>
    <pre>target/riscv/cpu-param.h:#elif defined(TARGET_RISCV32)</pre>
    <pre>target/riscv/cpu.c:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/cpu.c:#if defined(TARGET_RISCV32)</pre>
    <pre>target/riscv/cpu.h:#if defined(TARGET_RISCV32)</pre>
    <pre>target/riscv/cpu.h:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/cpu.h:#if defined(TARGET_RISCV32)</pre>
    <pre>target/riscv/cpu.h:#if defined(TARGET_RISCV32)</pre>
    <pre>target/riscv/cpu.h:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/insn_trans/trans_rvzacas.c.inc:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/kvm/kvm-cpu.c:#if defined(TARGET_RISCV32)</pre>
    <pre>target/riscv/translate.c:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/translate.c:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/translate.c:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/translate.c:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/translate.c:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/translate.c:#ifdef TARGET_RISCV32</pre>
    <pre>target/riscv/translate.c:#ifdef TARGET_RISCV32</pre>
    <p>One case we can remove the TARGET_RISCV32 is in translate.c.<br>
    </p>
    <address>static void gen_set_fpr_hs(DisasContext *ctx, int reg_num,
      TCGv_i64 t)</address>
    <address>{</address>
    <address>    if (!ctx-&gt;cfg_ptr-&gt;ext_zfinx) {</address>
    <address>        tcg_gen_mov_i64(cpu_fpr[reg_num], t);</address>
    <address>        return;</address>
    <address>    }</address>
    <address>    if (reg_num != 0) {</address>
    <address>        switch (get_xl(ctx)) {</address>
    <address>        case MXL_RV32:</address>
    <address>#ifdef TARGET_RISCV32</address>
    <address>            tcg_gen_extrl_i64_i32(cpu_gpr[reg_num], t);</address>
    <address>            break;</address>
    <address>#else</address>
    <address>        /* fall through */</address>
    <address>        case MXL_RV64:</address>
    <address>            tcg_gen_mov_i64(cpu_gpr[reg_num], t);</address>
    <address>            break;</address>
    <address>#endif</address>
    <address>        default:</address>
    <address>            g_assert_not_reached();</address>
    <address>        }</address>
    <address>    }</address>
    <address>}</address>
    <p>We can simplify this code by tcg_gen_trunc_i64_tl.</p>
    <p>One case we can't remove the TARGET_RISCV32 is in cpu.c, where we
      define any or max cpu with the width depending on this macro.<br>
      I don't analyze all TARGET_RISCV32 using here.  We will upstream a
      standalone patch for validating all its using later.</p>
    <p>Thanks,<br>
      Zhiwei<br>
    </p>
    <blockquote type="cite"
      cite="mid:2ea8672a-cf36-45c3-850b-f7513e9052a6@linaro.org">
      <br>
      <blockquote type="cite">  }
        <br>
          #endif
        <br>
          </blockquote>
    </blockquote>
  </body>
</html>

--------------060WPHF5PYBuFdTGReZUYvao--

