Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD9BC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 08:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sirci-00089b-2I; Tue, 27 Aug 2024 04:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sircd-00088J-M8; Tue, 27 Aug 2024 04:32:15 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sirca-0000AR-Ik; Tue, 27 Aug 2024 04:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724747524; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=pCWuAwlFoyd645PxAiTTMVlXstyaGWjfK1Ao7FI2DCE=;
 b=NfLCgMqJcDubeB5JAePsd0ciSOd3mg4uYYNwzDgT/Zu/AvBhARAIyZLE11BxfCXRHPo8kzwaam88HfGzPxDpdFuVGbCi8jFqj2En9uePR74MrRBtpKAI2CVMMRw5Z1lEXkPERLLmLVZqhlEI28It4YBWpLshYCrXDwedcwzc7ME=
Received: from 30.166.64.124(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDlr5NZ_1724747521) by smtp.aliyun-inc.com;
 Tue, 27 Aug 2024 16:32:02 +0800
Content-Type: multipart/alternative;
 boundary="------------Hdf91lLmLe4ymD0LAoBnHpGU"
Message-ID: <8883511a-fa31-4703-9302-5a7d511d2067@linux.alibaba.com>
Date: Tue, 27 Aug 2024 16:31:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/15] tcg/riscv: Enable vector TCG host-native
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-16-zhiwei_liu@linux.alibaba.com>
 <7eabd980-ec6c-4748-8ada-f9d6228ee2ef@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <7eabd980-ec6c-4748-8ada-f9d6228ee2ef@linaro.org>
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
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
--------------Hdf91lLmLe4ymD0LAoBnHpGU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/8/14 18:15, Richard Henderson wrote:
> On 8/13/24 21:34, LIU Zhiwei wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   tcg/riscv/tcg-target.h | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
>> index eb5129a976..fe6c50e49e 100644
>> --- a/tcg/riscv/tcg-target.h
>> +++ b/tcg/riscv/tcg-target.h
>> @@ -143,9 +143,13 @@ typedef enum {
>>   #define TCG_TARGET_HAS_tst              0
>>     /* vector instructions */
>> -#define TCG_TARGET_HAS_v64              0
>> -#define TCG_TARGET_HAS_v128             0
>> -#define TCG_TARGET_HAS_v256             0
>> +extern int riscv_vlen;
>> +#define have_rvv    ((cpuinfo & CPUINFO_ZVE64X) && \
>> +                     (riscv_vlen >= 64))
>> +
>> +#define TCG_TARGET_HAS_v64              have_rvv
>> +#define TCG_TARGET_HAS_v128             have_rvv
>> +#define TCG_TARGET_HAS_v256             have_rvv
>
> Can ELEN ever be less than 64 for riscv64?

I think so.  At least the specification allow this case. According to 
the specification,

"Any of these extensions can be added to base ISAs with XLEN=32 or XLEN=64."

includes zve32x, where ELEN is 32 and XLEN is 64.

> I thought ELEN had to be at least XLEN.
> Anyway, if ELEN >= 64, then VLEN must also be >= 64.
YES.
>
> In any case, I think we should not set CPUINFO_ZVE64X if the vlen is 
> too small. 
Agree.
> We can initialize both values in util/cpuinfo-riscv.c, rather than 
> initializing vlen in tcg.
>
>> +static void riscv_get_vlenb(void){
>> +    /* Get vlenb for Vector: csrrs %0, vlenb, zero. */
>> +    asm volatile("csrrs %0, 0xc22, x0" : "=r"(riscv_vlen));
>> +    riscv_vlen *= 8;
>> +}
>
> While this is an interesting and required datum, if ELEN < XLEN is 
> possible, then perhaps
>
>     asm("vsetvli %0, r0, e64" : "=r"(vl));
>
> is a better probe, verifying that vl != 0, i.e. e64 is supported, and 
> recording vlen as vl * 64, i.e. VLMAX.

We will use this one. But probe the vlen in util/cpuinfo-riscv.c has no 
meaning as we sometimes use the compiler settings or hw_probe API. In 
these cases, the vlen detected in util/cpuinfo-riscv.c is zero.

Thanks,
Zhiwei

>
>
> r~
--------------Hdf91lLmLe4ymD0LAoBnHpGU
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
    <div class="moz-cite-prefix">On 2024/8/14 18:15, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:7eabd980-ec6c-4748-8ada-f9d6228ee2ef@linaro.org">On
      8/13/24 21:34, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">From: TANG Tiancheng
        <a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a>
        <br>
        <br>
        Signed-off-by: TANG Tiancheng
        <a class="moz-txt-link-rfc2396E" href="mailto:tangtiancheng.ttc@alibaba-inc.com">&lt;tangtiancheng.ttc@alibaba-inc.com&gt;</a>
        <br>
        Reviewed-by: Liu Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@linux.alibaba.com">&lt;zhiwei_liu@linux.alibaba.com&gt;</a>
        <br>
        ---
        <br>
          tcg/riscv/tcg-target.h | 10 +++++++---
        <br>
          1 file changed, 7 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
        <br>
        index eb5129a976..fe6c50e49e 100644
        <br>
        --- a/tcg/riscv/tcg-target.h
        <br>
        +++ b/tcg/riscv/tcg-target.h
        <br>
        @@ -143,9 +143,13 @@ typedef enum {
        <br>
          #define TCG_TARGET_HAS_tst              0
        <br>
            /* vector instructions */
        <br>
        -#define TCG_TARGET_HAS_v64              0
        <br>
        -#define TCG_TARGET_HAS_v128             0
        <br>
        -#define TCG_TARGET_HAS_v256             0
        <br>
        +extern int riscv_vlen;
        <br>
        +#define have_rvv    ((cpuinfo &amp; CPUINFO_ZVE64X) &amp;&amp;
        \
        <br>
        +                     (riscv_vlen &gt;= 64))
        <br>
        +
        <br>
        +#define TCG_TARGET_HAS_v64              have_rvv
        <br>
        +#define TCG_TARGET_HAS_v128             have_rvv
        <br>
        +#define TCG_TARGET_HAS_v256             have_rvv
        <br>
      </blockquote>
      <br>
      Can ELEN ever be less than 64 for riscv64?
      <br>
    </blockquote>
    <p>I think so.  At least the specification allow this case.
      According to the specification,<br>
    </p>
    <pre>"Any of these extensions can be added to base ISAs with XLEN=32 or XLEN=64."</pre>
    <p>includes zve32x, where ELEN is 32 and XLEN is 64.<br>
    </p>
    <blockquote type="cite"
      cite="mid:7eabd980-ec6c-4748-8ada-f9d6228ee2ef@linaro.org">I
      thought ELEN had to be at least XLEN.
      <br>
      Anyway, if ELEN &gt;= 64, then VLEN must also be &gt;= 64.
      <br>
    </blockquote>
    YES.<br>
    <blockquote type="cite"
      cite="mid:7eabd980-ec6c-4748-8ada-f9d6228ee2ef@linaro.org">
      <br>
      In any case, I think we should not set CPUINFO_ZVE64X if the vlen
      is too small.  </blockquote>
    Agree.<br>
    <blockquote type="cite"
      cite="mid:7eabd980-ec6c-4748-8ada-f9d6228ee2ef@linaro.org">We can
      initialize both values in util/cpuinfo-riscv.c, rather than
      initializing vlen in tcg.
      <br>
      <br>
      <blockquote type="cite">+static void riscv_get_vlenb(void){
        <br>
        +    /* Get vlenb for Vector: csrrs %0, vlenb, zero. */
        <br>
        +    asm volatile("csrrs %0, 0xc22, x0" : "=r"(riscv_vlen));
        <br>
        +    riscv_vlen *= 8;
        <br>
        +}
        <br>
      </blockquote>
      <br>
      While this is an interesting and required datum, if ELEN &lt; XLEN
      is possible, then perhaps
      <br>
      <br>
          asm("vsetvli %0, r0, e64" : "=r"(vl));
      <br>
      <br>
      is a better probe, verifying that vl != 0, i.e. e64 is supported,
      and recording vlen as vl * 64, i.e. VLMAX.
      <br>
    </blockquote>
    <p>We will use this one. But probe the vlen in util/cpuinfo-riscv.c
      has no meaning as we sometimes use the compiler settings or
      hw_probe API. In these cases, the vlen detected in
      util/cpuinfo-riscv.c is zero.</p>
    <p>Thanks,<br>
      Zhiwei<br>
    </p>
    <blockquote type="cite"
      cite="mid:7eabd980-ec6c-4748-8ada-f9d6228ee2ef@linaro.org">
      <br>
      <br>
      r~
      <br>
    </blockquote>
  </body>
</html>

--------------Hdf91lLmLe4ymD0LAoBnHpGU--

