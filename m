Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9664BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 16:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIUKS-0008OX-Ab; Mon, 10 Nov 2025 11:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vIUKL-0008Gf-3B
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:01:10 -0500
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1vIUKH-0003Lg-I5
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 11:01:08 -0500
Received: from [192.168.1.4] (unknown [117.133.64.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id C8F33459DF;
 Mon, 10 Nov 2025 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1762790453; bh=YPcN6OmI9H/Th0Em+ryYlKFOXrNSrN4UY39LvRIARhI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ke+YcOMLW1gSXjmE0Tv0j/qGb5qCFN84Yx7m251jByw7e4XNXHKF1BjfJvb515EVP
 5aGgdzrv7mWbNURgTeCF9zoBxK+9yQK5yjIcPuDdoFpUIOqUhdSdMAyweIGaBWwUqs
 BeEtMIzmXinS7rn7fGqQ4DojUCvroAYZFsU2NaXg=
Content-Type: multipart/alternative;
 boundary="------------OVwiMiIR0z3BuTgw6a09OEQs"
Message-ID: <c70df121-ed67-403c-ab5c-c541b9eed38b@jia.je>
Date: Tue, 11 Nov 2025 00:00:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add LoongArch v1.1 instructions
To: gaosong <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, bibo mao <maobibo@loongson.cn>
References: <20231023153029.269211-2-c@jia.je>
 <bce33bc2-60f9-41ee-856c-d76682c185f0@linaro.org>
 <1af667c0-f1ba-4538-9aec-8232397dd3c5@jia.je>
 <a1784c3c-b00e-4cb6-a262-96e6cbaa5c30@jia.je>
 <70260625-5981-40f3-a189-afddac2a6dfa@linaro.org>
 <062ee798-c112-46d4-82b8-983e85ffe2ed@jia.je>
 <6482c6cf-1f4b-a7b9-d106-4c687360e810@loongson.cn>
 <ae3088b6-f472-4dd2-a5bc-9effb61ffaa0@jia.je>
 <b03d1fa3-b553-734b-7adf-839dc67a2dd5@loongson.cn>
 <603b8709-4288-4268-abd4-642366b0b7e2@jia.je>
 <798c78df-cc9d-78dd-5bbd-0de2ead0eb1f@loongson.cn>
 <5cffe61f-6aac-4765-a39b-68f1c90daa09@jia.je>
 <cd422828-dce0-f54e-5c05-e6afd7c850a6@loongson.cn>
 <4f03d60c-cea4-4576-be1f-758c46706087@jia.je>
 <aa59dc19-d01a-e160-38fa-928881fa2ee3@loongson.cn>
Content-Language: en-US
From: Jiajie Chen <c@jia.je>
In-Reply-To: <aa59dc19-d01a-e160-38fa-928881fa2ee3@loongson.cn>
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--------------OVwiMiIR0z3BuTgw6a09OEQs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reply below.

On 2025/11/10 11:42, gaosong wrote:
> 在 2023/10/31 下午7:10, Jiajie Chen 写道:
>>
>> On 2023/10/31 19:06, gaosong wrote:
>>> 在 2023/10/31 下午5:13, Jiajie Chen 写道:
>>>>
>>>> On 2023/10/31 17:11, gaosong wrote:
>>>>> 在 2023/10/30 下午7:54, Jiajie Chen 写道:
>>>>>>
>>>>>> On 2023/10/30 16:23, gaosong wrote:
>>>>>>> 在 2023/10/28 下午9:09, Jiajie Chen 写道:
>>>>>>>>
>>>>>>>> On 2023/10/26 14:54, gaosong wrote:
>>>>>>>>> 在 2023/10/26 上午9:38, Jiajie Chen 写道:
>>>>>>>>>>
>>>>>>>>>> On 2023/10/26 03:04, Richard Henderson wrote:
>>>>>>>>>>> On 10/25/23 10:13, Jiajie Chen wrote:
>>>>>>>>>>>>> On 2023/10/24 07:26, Richard Henderson wrote:
>>>>>>>>>>>>>> See target/arm/tcg/translate-a64.c, gen_store_exclusive, 
>>>>>>>>>>>>>> TCGv_i128 block.
>>>>>>>>>>>>>> See target/ppc/translate.c, gen_stqcx_.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The situation here is slightly different: aarch64 and 
>>>>>>>>>>>>> ppc64 have both 128-bit ll and sc, however LoongArch v1.1 
>>>>>>>>>>>>> only has 64-bit ll and 128-bit sc.
>>>>>>>>>>>
>>>>>>>>>>> Ah, that does complicate things.
>>>>>>>>>>>
>>>>>>>>>>>> Possibly use the combination of ll.d and ld.d:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> ll.d lo, base, 0
>>>>>>>>>>>> ld.d hi, base, 4
>>>>>>>>>>>>
>>>>>>>>>>>> # do some computation
>>>>>>>>>>>>
>>>>>>>>>>>> sc.q lo, hi, base
>>>>>>>>>>>>
>>>>>>>>>>>> # try again if sc failed
>>>>>>>>>>>>
>>>>>>>>>>>> Then a possible implementation of gen_ll() would be: align 
>>>>>>>>>>>> base to 128-bit boundary, read 128-bit from memory, save 
>>>>>>>>>>>> 64-bit part to rd and record whole 128-bit data in llval. 
>>>>>>>>>>>> Then, in gen_sc_q(), it uses a 128-bit cmpxchg.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> But what about the reversed instruction pattern: ll.d hi, 
>>>>>>>>>>>> base, 4; ld.d lo, base 0?
>>>>>>>>>>>
>>>>>>>>>>> It would be worth asking your hardware engineers about the 
>>>>>>>>>>> bounds of legal behaviour. Ideally there would be some very 
>>>>>>>>>>> explicit language, similar to
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I'm a community developer not affiliated with Loongson. Song 
>>>>>>>>>> Gao, could you provide some detail from Loongson Inc.?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> ll.d   r1, base, 0
>>>>>>>>> dbar 0x700          ==> see 2.2.8.1
>>>>>>>>> ld.d  r2, base,  8
>>>>>>>>> ...
>>>>>>>>> sc.q r1, r2, base
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks! I think we may need to detect the ll.d-dbar-ld.d 
>>>>>>>> sequence and translate the sequence into one 
>>>>>>>> tcg_gen_qemu_ld_i128 and split the result into two 64-bit 
>>>>>>>> parts. Can do this in QEMU?
>>>>>>>>
>>>>>>>>
>>>>>>> Oh, I'm not sure.
>>>>>>>
>>>>>>> I think we just need to implement sc.q. We don't need to care 
>>>>>>> about 'll.d-dbar-ld.d'. It's just like 'll.q'.
>>>>>>> It needs the user to ensure that .
>>>>>>>
>>>>>>> ll.q' is
>>>>>>> 1) ll.d r1 base, 0 ==> set LLbit, load the low 64 bits into r1
>>>>>>> 2) dbar 0x700　
>>>>>>> 3) ld.d r2 base, 8 ==> load the high 64 bits to r2
>>>>>>>
>>>>>>> sc.q needs to
>>>>>>> 1) Use 64-bit cmpxchg.
>>>>>>> 2) Write 128 bits to memory.
>>>>>>
>>>>>> Consider the following code:
>>>>>>
>>>>>>
>>>>>> ll.d r1, base, 0
>>>>>>
>>>>>> dbar 0x700
>>>>>>
>>>>>> ld.d r2, base, 8
>>>>>>
>>>>>> addi.d r2, r2, 1
>>>>>>
>>>>>> sc.q r1, r2, base
>>>>>>
>>>>>>
>>>>>> We translate them into native code:
>>>>>>
>>>>>>
>>>>>> ld.d r1, base, 0
>>>>>>
>>>>>> mv LLbit, 1
>>>>>>
>>>>>> mv LLaddr, base
>>>>>>
>>>>>> mv LLval, r1
>>>>>>
>>>>>> dbar 0x700
>>>>>>
>>>>>> ld.d r2, base, 8
>>>>>>
>>>>>> addi.d r2, r2, 1
>>>>>>
>>>>>> if (LLbit == 1 && LLaddr == base) {
>>>>>>
>>>>>>     cmpxchg addr=base compare=LLval new=r1
>>>>>>
>>>>>>     128-bit write {r2, r1} to base if cmpxchg succeeded
>>>>>>
>>>>>> }
>>>>>>
>>>>>> set r1 if sc.q succeeded
>>>>>>
>>>>>>
>>>>>>
>>>>>> If the memory content of base+8 has changed between ld.d r2 and 
>>>>>> addi.d r2, the atomicity is not guaranteed, i.e. only the high 
>>>>>> part has changed, the low part hasn't.
>>>>>>
>>>>>>
>>>>> Sorry,  my mistake.  need use cmpxchg_i128.   See 
>>>>> target/arm/tcg/translate-a64.c   gen_store_exclusive().
>>>>>
>>>>> gen_scq(rd, rk, rj)
>>>>> {
>>>>>      ...
>>>>>     TCGv_i128 t16 = tcg_temp_new_i128();
>>>>>     TCGv_i128 c16 = tcg_temp_new_i128();
>>>>>     TCGv_i64 low = tcg_temp_new_i64();
>>>>>     TCGv_i64 high= tcg_temp_new_i64();
>>>>>     TCGv_i64 temp = tcg_temp_new_i64();
>>>>>
>>>>>     tcg_gen_concat_i64_i128(t16, cpu_gpr[rd], cpu_gpr[rk]));
>>>>>
>>>>>     tcg_gen_qemu_ld(low, cpu_lladdr, ctx->mem_idx, MO_TEUQ);
>>>>>     tcg_gen_addi_tl(temp, cpu_lladdr, 8);
>>>>>     tcg_gen_mb(TCG_BAR_SC | TCG_MO_LD_LD);
>>>>>     tcg_gen_qemu_ld(high, temp, ctx->mem_idx, MO_TEUQ);
>>>>
>>>>
>>>> The problem is that, the high value read here might not equal to 
>>>> the previously read one in ll.d r2, base 8 instruction.
>>> I think dbar 0x7000 ensures that the 2 loads in 'll.q' are a 128bit 
>>> atomic operation.
>>
>>
>> The code does work in real LoongArch machine. However, we are 
>> emulating LoongArch in qemu, we have to make it atomic, yet it isn't 
>> now.
>>
>>
> Hi, jiajie
>
> Could you help refresh this series ?
>
> Thanks.
> Song Gao


I am busy with my research these days, until around mid December. After 
that I may try to implement following idea:


    https://developer.arm.com/documentation/ddi0487/latest/
    B2.9.5 Load-Exclusive and Store-Exclusive instruction usage
    restrictions

    But you could do the same thing, aligning and recording the entire
    128-bit quantity, then extract the ll.d result based on address bit
    6. This would complicate the implementation of sc.d as well, but
    would perhaps bring us "close enough" to the actual architecture.

    Note that our Arm store-exclusive implementation isn't quite in spec
    either.  There is quite a large comment within translate-a64.c
    store_exclusive() about the ways things are not quite right.  But it
    seems to be close enough for actual usage to succeed.


    r~


Best regards,

Jiajie Chen


>>> Thanks.
>>> Song Gao
>>>>> tcg_gen_concat_i64_i128(c16, low, high);
>>>>>
>>>>>     tcg_gen_atomic_cmpxchg_i128(t16, cpu_lladdr, c16, t16, 
>>>>> ctx->mem_idx, MO_128);
>>>>>
>>>>>     ...
>>>>> }
>>>>>
>>>>> I am not sure this is right.
>>>>>
>>>>> I think Richard can give you more suggestions. @Richard
>>>>>
>>>>> Thanks.
>>>>> Song Gao
>>>>>>
>>>>>>> Thanks.
>>>>>>> Song Gao
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> For this series,
>>>>>>>>> I think we need set the new config bits to the 'max cpu', and 
>>>>>>>>> change linux-user/target_elf.h ''any' to 'max', so that we can 
>>>>>>>>> use these new instructions on linux-user mode.
>>>>>>>>
>>>>>>>> I will work on it.
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>> Song Gao
>>>>>>>>>>>
>>>>>>>>>>> https://developer.arm.com/documentation/ddi0487/latest/
>>>>>>>>>>> B2.9.5 Load-Exclusive and Store-Exclusive instruction usage 
>>>>>>>>>>> restrictions
>>>>>>>>>>>
>>>>>>>>>>> But you could do the same thing, aligning and recording the 
>>>>>>>>>>> entire 128-bit quantity, then extract the ll.d result based 
>>>>>>>>>>> on address bit 6. This would complicate the implementation 
>>>>>>>>>>> of sc.d as well, but would perhaps bring us "close enough" 
>>>>>>>>>>> to the actual architecture.
>>>>>>>>>>>
>>>>>>>>>>> Note that our Arm store-exclusive implementation isn't quite 
>>>>>>>>>>> in spec either. There is quite a large comment within 
>>>>>>>>>>> translate-a64.c store_exclusive() about the ways things are 
>>>>>>>>>>> not quite right.  But it seems to be close enough for actual 
>>>>>>>>>>> usage to succeed.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> r~
>>>>>>>>>
>>>>>>>
>>>>>
>>>
>
--------------OVwiMiIR0z3BuTgw6a09OEQs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Reply below.</p>
    <div class="moz-cite-prefix">On 2025/11/10 11:42, gaosong wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:aa59dc19-d01a-e160-38fa-928881fa2ee3@loongson.cn">在
      2023/10/31 下午7:10, Jiajie Chen 写道:
      <br>
      <blockquote type="cite">
        <br>
        On 2023/10/31 19:06, gaosong wrote:
        <br>
        <blockquote type="cite">在 2023/10/31 下午5:13, Jiajie Chen 写道:
          <br>
          <blockquote type="cite">
            <br>
            On 2023/10/31 17:11, gaosong wrote:
            <br>
            <blockquote type="cite">在 2023/10/30 下午7:54, Jiajie Chen 写道:
              <br>
              <blockquote type="cite">
                <br>
                On 2023/10/30 16:23, gaosong wrote:
                <br>
                <blockquote type="cite">在 2023/10/28 下午9:09, Jiajie Chen
                  写道:
                  <br>
                  <blockquote type="cite">
                    <br>
                    On 2023/10/26 14:54, gaosong wrote:
                    <br>
                    <blockquote type="cite">在 2023/10/26 上午9:38, Jiajie
                      Chen 写道:
                      <br>
                      <blockquote type="cite">
                        <br>
                        On 2023/10/26 03:04, Richard Henderson wrote:
                        <br>
                        <blockquote type="cite">On 10/25/23 10:13,
                          Jiajie Chen wrote:
                          <br>
                          <blockquote type="cite">
                            <blockquote type="cite">On 2023/10/24 07:26,
                              Richard Henderson wrote:
                              <br>
                              <blockquote type="cite">See
                                target/arm/tcg/translate-a64.c,
                                gen_store_exclusive, TCGv_i128 block.
                                <br>
                                See target/ppc/translate.c, gen_stqcx_.
                                <br>
                              </blockquote>
                              <br>
                              The situation here is slightly different:
                              aarch64 and ppc64 have both 128-bit ll and
                              sc, however LoongArch v1.1 only has 64-bit
                              ll and 128-bit sc.
                              <br>
                            </blockquote>
                          </blockquote>
                          <br>
                          Ah, that does complicate things.
                          <br>
                          <br>
                          <blockquote type="cite">Possibly use the
                            combination of ll.d and ld.d:
                            <br>
                            <br>
                            <br>
                            ll.d lo, base, 0
                            <br>
                            ld.d hi, base, 4
                            <br>
                            <br>
                            # do some computation
                            <br>
                            <br>
                            sc.q lo, hi, base
                            <br>
                            <br>
                            # try again if sc failed
                            <br>
                            <br>
                            Then a possible implementation of gen_ll()
                            would be: align base to 128-bit boundary,
                            read 128-bit from memory, save 64-bit part
                            to rd and record whole 128-bit data in
                            llval. Then, in gen_sc_q(), it uses a
                            128-bit cmpxchg.
                            <br>
                            <br>
                            <br>
                            But what about the reversed instruction
                            pattern: ll.d hi, base, 4; ld.d lo, base 0?
                            <br>
                          </blockquote>
                          <br>
                          It would be worth asking your hardware
                          engineers about the bounds of legal behaviour.
                          Ideally there would be some very explicit
                          language, similar to
                          <br>
                        </blockquote>
                        <br>
                        <br>
                        I'm a community developer not affiliated with
                        Loongson. Song Gao, could you provide some
                        detail from Loongson Inc.?
                        <br>
                        <br>
                        <br>
                      </blockquote>
                      <br>
                      ll.d   r1, base, 0
                      <br>
                      dbar 0x700          ==&gt; see 2.2.8.1
                      <br>
                      ld.d  r2, base,  8
                      <br>
                      ...
                      <br>
                      sc.q r1, r2, base
                      <br>
                    </blockquote>
                    <br>
                    <br>
                    Thanks! I think we may need to detect the
                    ll.d-dbar-ld.d sequence and translate the sequence
                    into one tcg_gen_qemu_ld_i128 and split the result
                    into two 64-bit parts. Can do this in QEMU?
                    <br>
                    <br>
                    <br>
                  </blockquote>
                  Oh, I'm not sure.
                  <br>
                  <br>
                  I think we just need to implement sc.q. We don't need
                  to care about 'll.d-dbar-ld.d'. It's just like 'll.q'.
                  <br>
                  It needs the user to ensure that .
                  <br>
                  <br>
                  ll.q' is
                  <br>
                  1) ll.d r1 base, 0 ==&gt; set LLbit, load the low 64
                  bits into r1
                  <br>
                  2) dbar 0x700　
                  <br>
                  3) ld.d r2 base, 8 ==&gt; load the high 64 bits to r2
                  <br>
                  <br>
                  sc.q needs to
                  <br>
                  1) Use 64-bit cmpxchg.
                  <br>
                  2) Write 128 bits to memory.
                  <br>
                </blockquote>
                <br>
                Consider the following code:
                <br>
                <br>
                <br>
                ll.d r1, base, 0
                <br>
                <br>
                dbar 0x700
                <br>
                <br>
                ld.d r2, base, 8
                <br>
                <br>
                addi.d r2, r2, 1
                <br>
                <br>
                sc.q r1, r2, base
                <br>
                <br>
                <br>
                We translate them into native code:
                <br>
                <br>
                <br>
                ld.d r1, base, 0
                <br>
                <br>
                mv LLbit, 1
                <br>
                <br>
                mv LLaddr, base
                <br>
                <br>
                mv LLval, r1
                <br>
                <br>
                dbar 0x700
                <br>
                <br>
                ld.d r2, base, 8
                <br>
                <br>
                addi.d r2, r2, 1
                <br>
                <br>
                if (LLbit == 1 &amp;&amp; LLaddr == base) {
                <br>
                <br>
                    cmpxchg addr=base compare=LLval new=r1
                <br>
                <br>
                    128-bit write {r2, r1} to base if cmpxchg succeeded
                <br>
                <br>
                }
                <br>
                <br>
                set r1 if sc.q succeeded
                <br>
                <br>
                <br>
                <br>
                If the memory content of base+8 has changed between ld.d
                r2 and addi.d r2, the atomicity is not guaranteed, i.e.
                only the high part has changed, the low part hasn't.
                <br>
                <br>
                <br>
              </blockquote>
              Sorry,  my mistake.  need use cmpxchg_i128.   See
              target/arm/tcg/translate-a64.c   gen_store_exclusive().
              <br>
              <br>
              gen_scq(rd, rk, rj)
              <br>
              {
              <br>
                   ...
              <br>
                  TCGv_i128 t16 = tcg_temp_new_i128();
              <br>
                  TCGv_i128 c16 = tcg_temp_new_i128();
              <br>
                  TCGv_i64 low = tcg_temp_new_i64();
              <br>
                  TCGv_i64 high= tcg_temp_new_i64();
              <br>
                  TCGv_i64 temp = tcg_temp_new_i64();
              <br>
              <br>
                  tcg_gen_concat_i64_i128(t16, cpu_gpr[rd],
              cpu_gpr[rk]));
              <br>
              <br>
                  tcg_gen_qemu_ld(low, cpu_lladdr, ctx-&gt;mem_idx,
              MO_TEUQ);
              <br>
                  tcg_gen_addi_tl(temp, cpu_lladdr, 8);
              <br>
                  tcg_gen_mb(TCG_BAR_SC | TCG_MO_LD_LD);
              <br>
                  tcg_gen_qemu_ld(high, temp, ctx-&gt;mem_idx, MO_TEUQ);
              <br>
            </blockquote>
            <br>
            <br>
            The problem is that, the high value read here might not
            equal to the previously read one in ll.d r2, base 8
            instruction.
            <br>
          </blockquote>
          I think dbar 0x7000 ensures that the 2 loads in 'll.q' are a
          128bit atomic operation.
          <br>
        </blockquote>
        <br>
        <br>
        The code does work in real LoongArch machine. However, we are
        emulating LoongArch in qemu, we have to make it atomic, yet it
        isn't now.
        <br>
        <br>
        <br>
      </blockquote>
      Hi, jiajie
      <br>
      <br>
      Could you help refresh this series ?
      <br>
      <br>
      Thanks.
      <br>
      Song Gao <br>
    </blockquote>
    <p><br>
    </p>
    <p>I am busy with my research these days, until around mid December.
      After that I may try to implement following idea:</p>
    <p><br>
    </p>
    <blockquote>
      <p><a class="moz-txt-link-freetext" href="https://developer.arm.com/documentation/ddi0487/latest/">https://developer.arm.com/documentation/ddi0487/latest/</a>
        <br>
        B2.9.5 Load-Exclusive and Store-Exclusive instruction usage
        restrictions
        <br>
        <br>
        But you could do the same thing, aligning and recording the
        entire 128-bit quantity, then extract the ll.d result based on
        address bit 6. This would complicate the implementation of sc.d
        as well, but would perhaps bring us "close enough" to the actual
        architecture.
        <br>
        <br>
        Note that our Arm store-exclusive implementation isn't quite in
        spec either.  There is quite a large comment within
        translate-a64.c store_exclusive() about the ways things are not
        quite right.  But it seems to be close enough for actual usage
        to succeed.
        <br>
        <br>
        <br>
        r~
        <br>
      </p>
    </blockquote>
    <p><br>
    </p>
    <p>Best regards,</p>
    <p>Jiajie Chen</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:aa59dc19-d01a-e160-38fa-928881fa2ee3@loongson.cn">
      <blockquote type="cite">
        <blockquote type="cite">Thanks.
          <br>
          Song Gao
          <br>
          <blockquote type="cite">
            <blockquote type="cite">tcg_gen_concat_i64_i128(c16, low,
              high);
              <br>
              <br>
                  tcg_gen_atomic_cmpxchg_i128(t16, cpu_lladdr, c16, t16,
              ctx-&gt;mem_idx, MO_128);
              <br>
              <br>
                  ...
              <br>
              }
              <br>
              <br>
              I am not sure this is right.
              <br>
              <br>
              I think Richard can give you more suggestions. @Richard
              <br>
              <br>
              Thanks.
              <br>
              Song Gao
              <br>
              <blockquote type="cite">
                <br>
                <blockquote type="cite">Thanks.
                  <br>
                  Song Gao
                  <br>
                  <blockquote type="cite">
                    <blockquote type="cite">
                      <br>
                      <br>
                      For this series,
                      <br>
                      I think we need set the new config bits to the
                      'max cpu', and change linux-user/target_elf.h
                      ''any' to 'max', so that we can use these new
                      instructions on linux-user mode.
                      <br>
                    </blockquote>
                    <br>
                    I will work on it.
                    <br>
                    <br>
                    <br>
                    <blockquote type="cite">
                      <br>
                      Thanks
                      <br>
                      Song Gao
                      <br>
                      <blockquote type="cite">
                        <blockquote type="cite">
                          <br>
<a class="moz-txt-link-freetext" href="https://developer.arm.com/documentation/ddi0487/latest/">https://developer.arm.com/documentation/ddi0487/latest/</a>
                          <br>
                          B2.9.5 Load-Exclusive and Store-Exclusive
                          instruction usage restrictions
                          <br>
                          <br>
                          But you could do the same thing, aligning and
                          recording the entire 128-bit quantity, then
                          extract the ll.d result based on address bit
                          6. This would complicate the implementation of
                          sc.d as well, but would perhaps bring us
                          "close enough" to the actual architecture.
                          <br>
                          <br>
                          Note that our Arm store-exclusive
                          implementation isn't quite in spec either. 
                          There is quite a large comment within
                          translate-a64.c store_exclusive() about the
                          ways things are not quite right.  But it seems
                          to be close enough for actual usage to
                          succeed.
                          <br>
                          <br>
                          <br>
                          r~
                          <br>
                        </blockquote>
                      </blockquote>
                      <br>
                    </blockquote>
                  </blockquote>
                  <br>
                </blockquote>
              </blockquote>
              <br>
            </blockquote>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------OVwiMiIR0z3BuTgw6a09OEQs--

