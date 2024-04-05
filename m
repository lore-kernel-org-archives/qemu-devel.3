Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F876C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 23:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rssw1-0006RH-H2; Fri, 05 Apr 2024 19:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rssvy-0006Qu-V2
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 19:25:23 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zack@buhman.org>) id 1rssvv-0000Pn-5I
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 19:25:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 6ED5911400A6;
 Fri,  5 Apr 2024 19:25:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 05 Apr 2024 19:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=buhman.org; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1712359514; x=1712445914; bh=6FCB+7nAKc
 Vdt0zrG5gQFTwT/5dczxNIQqh1yGPZW0E=; b=a7jQ6JGyoUF7Khm6wi2xhs4Bk4
 n7Y1MlL+kMnTmGzy/TA5Pe2d/jenD9MXXjNXbg5wp01ldehoag5ddRuWv8uj6vAR
 /r7qbnQaPQ7M3eNcl2OyMPw4d6NJaOEaUMQFah+aZoR3ZzYgtDOvFZMRR/BjoDS0
 G0bDVsyWi1QqSP/17SbfUSSN0X9DPOzRkEOTjTL+Y6RRtLTdF9412KLQAlfno5lG
 LqfCQQh6jjXrluUrvaub+nqqXWYbTAlnFOUp0md8jbVC8FSGy+EpFMeKd5ASmzfU
 NGoUcXCzkGFCElgnjriwvSmpY/swK/E7zg0DBsU5peDYNfEL/43UUW9iRLww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712359514; x=1712445914; bh=6FCB+7nAKcVdt0zrG5gQFTwT/5dc
 zxNIQqh1yGPZW0E=; b=UBKNrQsMf2TP6u5AnZUwcx0KhmvmCVGmqILQeAbxCbOH
 Oc1T3HO6i+S7nYaSaGFSt752gIGSGBYpjJ7vYlv5RXjfQnfkhbwSgMxsGDqtNYnu
 tUJ+8ff2dTW1oVPLXGayZ199dBldiqzy+eWeLTo/fAtWB7FsoenxLdvgRrcUGfmL
 KaW6girJ8CzAn+Bg63XAUmT/2+wKgLQBos+S/tT+8SDKqy8dWXz0OuJYaVb8BJMN
 3TLihtVfcrLhHIbiQBjH84JIp7qYTEXV0Q+NssdkIZfVrHz7xnIFRQGMg+F4xqj5
 QvIsZUy34GQaqK4E7zBzKybYk8l3XgEp8yHKzEWwKw==
X-ME-Sender: <xms:WYgQZuO2Xbv5SlRK1k9A4qw_-65uIWhM2SyCJSBmrVWtscUjjt8QzA>
 <xme:WYgQZs_scLSynFgODcAJWnTn7FYtC6q_EDFzQVSXEmw3hP5DGXyDhGs5qa7yM1blL
 ov_pzVI9HYJpCPh2UI>
X-ME-Received: <xmr:WYgQZlQmCxHkYnQPGlEg26NEQFF-7GL6bdKQ6kurICMeqdoTTKVD-OyEs48u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeguddgvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepkggrtghk
 uceuuhhhmhgrnhcuoeiirggtkhessghuhhhmrghnrdhorhhgqeenucggtffrrghtthgvrh
 hnpeejveejfffhteelvdehiedvieetteetudelgffhgeettddugeegudeugfdutefgkeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiirggtkh
 essghuhhhmrghnrdhorhhg
X-ME-Proxy: <xmx:WYgQZus1griCK66GAbDw7ssqJ5rW7tZMkFQNtQF_EzZlXz3Jf74Tmg>
 <xmx:WYgQZmfbyUYSTuUuMKK5xJxjgep6rRDumyBLOud6mXMJ-M4xvr6RKA>
 <xmx:WYgQZi2R65TpqBLymtypnIOmCpNB3x83CiHnZaIA7NcpEZwyzVAnVQ>
 <xmx:WYgQZq_P1FqtGG2-Hz_czjy5PZoA8LwT87n3aBUu6A360nmVLUtP4A>
 <xmx:WogQZl4Fqezojqz3_SAn6YVk9XwtkfY5wPYG4M2LnLTvqKTrmaLflQwo>
Feedback-ID: i1541475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 19:25:11 -0400 (EDT)
References: <20240405075404.2122-2-zack@buhman.org>
 <CAFEAcA93s+=sHFNU0duK8--3GhUg1tZ+n+UhiGeFErJoY5_+jQ@mail.gmail.com>
User-agent: mu4e 1.10.6; emacs 28.2
From: Zack Buhman <zack@buhman.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH] sh4: mac.w: implement saturation arithmetic logic
Date: Sat, 06 Apr 2024 07:19:51 +0800
In-reply-to: <CAFEAcA93s+=sHFNU0duK8--3GhUg1tZ+n+UhiGeFErJoY5_+jQ@mail.gmail.com>
Message-ID: <ygdcyr3pf2n.fsf@localhost.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=103.168.172.159; envelope-from=zack@buhman.org;
 helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 5 Apr 2024 at 08:55, Zack Buhman <zack@buhman.org> wrote:
>>
>> The saturation arithmetic logic in helper_macw is not correct.
>>
>> I tested and verified this behavior on a SH7091, the general pattern
>> is a code sequence such as:
>>
>>         sets
>>
>>         mov.l _mach,r2
>>         lds r2,mach
>>         mov.l _macl,r2
>>         lds r2,macl
>>
>>         mova _n,r0
>>         mov r0,r1
>>         mova _m,r0
>>         mac.w @r0+,@r1+
>>
>>  _mach: .long 0xffffffff
>>  _macl: .long 0xfffffffe
>>  _m:    .word 0x0002
>>         .word 0
>>  _n:    .word 0x0003
>>         .word 0
>>
>> test 0:
>>   (mach should not be modified if an overflow did not occur)
>>
>>   given, prior to saturation mac.l:
>>     mach = 0xffffffff ; macl = 0xfffffffe
>>     @r0  = 0x0002     ; @r1  = 0x0003
>>
>>   expected saturation mac.w result:
>>     mach = 0xffffffff (unchanged)
>>     macl = 0x00000004
>>
>>   qemu saturation mac.w result (before this commit):
>>     mach = 0x00000001
>>     macl = 0x80000000
>>
>>   In the context of the helper_macw implementation prior to this
>>   commit, initially this appears to be a surprising result. This is
>>   because (prior to unary negation) the C literal `0x80000000` (due to
>>   being outside the range of a `signed int`) is evaluated as an
>>   `unsigned int` whereas the literal `1` (due to being inside the
>>   range of `signed int`) is evaluated as `signed int`, as in:
>>
>>     static_assert(1 < -0x80000000 == 1);
>>     static_assert(1 < -1 == 0);
>>
>>   This is because the unary negation of an unsigned int is an
>>   unsigned int.
>
> So we could also fix this by getting the C literals right
> so that they are correctly the signed 64 bit values that
> the author intended, right?

Making -0x80000000 signed as intended, as a standalone change without
the other aspects of this patch, would not yield a completely correct
mac.w implementation. For example, in saturation mode, the following
logic does not exist prior to this patch:

- MACH must not be overwritten if an overflow did not occur

- MACH must not be included in the addition/accumulation operation (it
  is simply a 32-bit + 32-bit = 33-bit addition of MACL and the
  multiplication result)

>
>>   In other words, if the `res < -0x80000000` comparison used
>>   infinite-precision literals, the saturation mac.w result would have
>>   been:
>>
>>     mach = 0x00000000
>>     macl = 0x00000004
>>
>>   Due to this (forgivable) misunderstanding of C literals, the
>>   following behavior also occurs:
>>
>> test 1:
>>   (`2 * 3 + 0` is not an overflow)
>>
>>   given, prior to saturation mac.l:
>>     mach = 0x00000000 ; macl = 0x00000000
>>     @r0  = 0x0002     ; @r1  = 0x0003
>>
>>   expected saturation mac.w result:
>>     mach = 0x00000000 (unchanged)
>>     macl = 0x00000006
>>
>>   qemu saturation mac.w result (before this commit):
>>     mach = 0x00000001
>>     macl = 0x80000000
>>
>> test 2:
>>   (mach should not be accumulated in saturation mode)
>>   (16-bit operands are sign-extended)
>>
>>   given, prior to saturation mac.l:
>>     mach = 0x12345678 ; macl = 0x7ffffffe
>>     @r0  = 0x0002     ; @r1  = 0xfffd
>>
>>   expected saturation mac.w result:
>>     mach = 0x12345678 (unchanged)
>>     macl = 0x7ffffff8
>>
>>   qemu saturation mac.w result (before this commit):
>>     mach = 0x00000001
>>     macl = 0x7fffffff
>>
>> test 3:
>>   (macl should have the correct saturation value)
>>
>>   given, prior to saturation mac.l:
>>     mach = 0xabcdef12 ; macl = 0x7ffffffa
>>     @r0  = 0x0002     ; @r1  = 0x0003
>>
>>   expected saturation mac.w result:
>>     mach = 0x00000001 (overwritten)
>>     macl = 0x7fffffff
>>
>>   qemu saturation mac.w result (before this commit):
>>     mach = 0x00000001
>>     macl = 0x80000000
>>
>> All of the above also matches the description of MAC.W as documented
>> in cd00147165-sh-4-32-bit-cpu-core-architecture-stmicroelectronics.pdf
>>
>> Signed-off-by: Zack Buhman <zack@buhman.org>
>> ---
>>  target/sh4/op_helper.c | 41 +++++++++++++++++++++++++++++++----------
>>  1 file changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
>> index ee16524083..b3c1e69f53 100644
>> --- a/target/sh4/op_helper.c
>> +++ b/target/sh4/op_helper.c
>> @@ -187,20 +187,41 @@ void helper_macl(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
>>
>>  void helper_macw(CPUSH4State *env, uint32_t arg0, uint32_t arg1)
>>  {
>> -    int64_t res;
>> +    int16_t value0 = (int16_t)arg0;
>> +    int16_t value1 = (int16_t)arg1;
>> +    int32_t mul = ((int32_t)value0) * ((int32_t)value1);
>>
>> -    res = ((uint64_t) env->mach << 32) | env->macl;
>> -    res += (int64_t) (int16_t) arg0 *(int64_t) (int16_t) arg1;
>> -    env->mach = (res >> 32) & 0xffffffff;
>> -    env->macl = res & 0xffffffff;
>> +    /* Perform 32-bit saturation arithmetic if the S flag is set */
>>      if (env->sr & (1u << SR_S)) {
>> -        if (res < -0x80000000) {
>> -            env->mach = 1;
>> -            env->macl = 0x80000000;
>> -        } else if (res > 0x000000007fffffff) {
>> +        const int64_t upper_bound =  ((1ul << 31) - 1);
>> +        const int64_t lower_bound = -((1ul << 31) - 0);
>
> UL is usually the wrong suffix to use (and more generally,
> in QEMU the "long" type is rarely the right type, because
> it might be either 32 or 64 bits depending on the host).
> Either we know the value fits in 32 bits and we want a 32-bit
> type, in which case U is sufficient, or we want a 64-bit type,
> in which case we need ULL.
>
>> +
>> +        /*
>> +         * In saturation arithmetic mode, the accumulator is 32-bit
>> +         * with carry. MACH is not considered during the addition
>> +         * operation nor the 32-bit saturation logic.
>> +         */
>> +        int32_t mac = env->macl;
>> +        int32_t result;
>> +        bool overflow = sadd32_overflow(mac, mul, &result);
>> +        if (overflow) {
>> +            result = (mac < 0) ? lower_bound : upper_bound;
>> +            /* MACH is set to 1 to denote overflow */
>> +            env->macl = result;
>>              env->mach = 1;
>> -            env->macl = 0x7fffffff;
>> +        } else {
>> +            result = MIN(MAX(result, lower_bound), upper_bound);
>
> Maybe I'm confused, but result is an int32_t, so when can it
> be lower than lower_bound or higher than upper_bound ?

Correct, this MIN(MAX(...)) is a no-operation in this case. I will send
[PATCH v2] with this removed and your other suggestions included.

>
>> +            /* If there was no overflow, MACH is unchanged */
>> +            env->macl = result;
>>          }
>> +    } else {
>> +        /* In non-saturation arithmetic mode, the accumulator is 64-bit */
>> +        int64_t mac = (((uint64_t)env->mach) << 32) | env->macl;
>> +
>> +        /* The carry bit of the 64-bit addition is discarded */
>> +        int64_t result = mac + (int64_t)mul;
>> +        env->macl = result;
>> +        env->mach = result >> 32;
>>      }
>>  }
>>
>
> thanks
> -- PMM


