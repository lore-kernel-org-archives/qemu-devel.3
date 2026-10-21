Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF68606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=djoPnNOx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HgN3YI3D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZBx-00054I-5k; Wed, 21 Oct 2026 12:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJZBu-00053v-4c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:29:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJZBr-00063l-MW
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:29:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LG4BW92149265
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ov8JqJO6Sy0qwVvUvjfOx1LP7dRwuHpwF1QANQgVmyA=; b=djoPnNOx3hX5iQPn
 l4lGuVxkMUWqZdDS7F+joTgmckkq5vZmMH721pNg6k54GkCJTmKyohgq0XAqnKHR
 jYEDSBoXVen2ASxgjYiSrHIWYSzTM9M6F+EiL7PH8nwk2IIXBaLs4fqBBDmyxe0z
 UbD4peRpbW72ns6u5S5KbR91sSqv9DDzWX16FSX6Qz7NTvae/KMCLQW7SS4IDnJg
 KLaxpMY7wM6uZKSdhL1GWeVWCnUw0GEhKmRm8nq/XqAwdPeMTp3nivzKXkNqodtn
 0TLcrZ8Dfiqj/uKMz/6kJANjxhgSm/z73zHcjHDnWOLO3r8WP76ZjOXAHUhhSR6r
 Gb4hHg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke04rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:29:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb98809caso167399985a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792600160; x=1793204960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ov8JqJO6Sy0qwVvUvjfOx1LP7dRwuHpwF1QANQgVmyA=;
 b=HgN3YI3D5tVd1wPMAAuLTO8bwkNqBvwXyvBwqvJHmBuA684tn2/DRu47iuZ5/l9jU/
 TToq8hqQqoYz1hUH9p65hCWkrHx334eS+9r06yLR/oKi1WyjyAb5r1QTfmddsfuOPNXp
 SycN3zfGG71U9R0etBukEhzcD1cvR6NH/ctcPc4Az5w82TWuZwF0o1CB2aZh4PnWJIEF
 2y3UnuOkLitTXs4Pi4BswaviqUzWxSEz+G13AGxr9fpFVQ1ZjYmrUbKp6qI9VH9bY93F
 79fwW732Y0LeyLt6RY3ONkCMT4+tza8Mft/r1G1ntmCIgmITxiXGNxnvNUhUvbLeGmK+
 Dybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792600160; x=1793204960;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ov8JqJO6Sy0qwVvUvjfOx1LP7dRwuHpwF1QANQgVmyA=;
 b=mrmy5ibQHaDrF0cgbV6dyUrB0ns592aPZorKpATQzyHoJ08ZyXln1ig2CY06AcVhIA
 F19dgkF56LwEsAumo6s8D+cNVtmI9twov51yqyqm/wPT6Ov/VY/If/epwx48+7zxgwWd
 ODur0DDd9QILse9q5u12EiBbKfwK7Vkh2LOTN7VOBK5JJfZkoc2uR4jyx+ImpY9DmMI9
 eu4AmqK/A49/e6XCxbWHGV4AXwY2f2+ErtcdG3a4mFxnd+h0nHzOO71pBh8SVXQyVI/y
 3ua3hYNcd284pDrLieDH+XJA9SknyVn+H+QOghZU/TI5jcZaDNRDK1NhkOSzgv8wqelA
 Zh4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxazoeHh+Z6vX64jfPh+vpLS20NI0bY5aMFLyT7FGOgvjZhsHsx5gL6v38eNdZxU60mCa3H3FF8XPQt@nongnu.org
X-Gm-Message-State: AFq9FYLRJ7F7sHcGMFx9rLNaxfZiA7J4f4lnBuXPRHxRJrP6/7rkIjR/
 03zLiSji87GThPqvK1u0UpzZDBdIM/9EwVKS2Iw2O2fr3kBv9R1E6hbBCSXYg5HnzBBUqR1AJ0W
 YHThll5bayQdth8dVk8orerD5bwAGLu0xQfMkMXDCCvlDoAi3l1TrUefyfg==
X-Gm-Gg: AYBFou3pcneg9a4XDpGCEw56APYthxTkFY2K0VsEpSF84aGW0ptSEjSFtgx3eWLDLLf
 28ply4TJxMJaQ2abQrLsl1AsY05/y2uDpPq9v0PvEBG48zq2+zxJORf69d517ebjqB1X7urOOgu
 gLWdwLEg8ZSK4sWdl4LlIDLIaehvhKTct3P9359RLqhf3ocPSlUm80DGp3BNQpAe189AVye/JeJ
 j2cYwWSAZsXd5ntidm03QJ9r68+f4qOmUMue91bZt+iKqh+Qg5WqQxDpBqRmOuVHpRwvAiBYVVB
 CBKPm46s82jxg1sxrZ9OVFpvy7QzJD2ZGdevjWywTJXI0RZ3I0fyQ9WqLpZuxwXNnb+HZ382GNc
 ZMKuXfvcbHsEF7Pe1ZO4+usUmBpsOzgIb0A==
X-Received: by 2002:a05:620a:262a:b0:93c:5f3c:f485 with SMTP id
 af79cd13be357-93f57f9cd0emr482221985a.53.1792600160126; 
 Wed, 21 Oct 2026 09:29:20 -0700 (PDT)
X-Received: by 2002:a05:620a:262a:b0:93c:5f3c:f485 with SMTP id
 af79cd13be357-93f57f9cd0emr482216685a.53.1792600159245; 
 Wed, 21 Oct 2026 09:29:19 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581eedesm5945991f8f.14.2026.10.21.09.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 09:29:18 -0700 (PDT)
Message-ID: <75479248-0e8d-4198-b9e5-231df9816f1a@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 18:29:17 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] target/i386/tcg: fix EIP truncation for wrapping
 near branches
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: paul@galbraiths.ca, pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20260926235620.851099-1-richard.henderson@linaro.org>
 <20260926235620.851099-3-richard.henderson@linaro.org>
 <6080974b-f174-4e95-8846-26ed13202dcd@oss.qualcomm.com>
 <9c44d872-586c-41d3-906e-1a35aefa0bf5@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <9c44d872-586c-41d3-906e-1a35aefa0bf5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4Uc8tO4m7Px6v6A6lk7mKDwql1gzaHax
X-Proofpoint-ORIG-GUID: 4Uc8tO4m7Px6v6A6lk7mKDwql1gzaHax
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfXyafEO0nVjGnX
 Qt+2AJKSvgRtAeNal3ya/ylZ7vDtBuO40AjN8RFAUAflX1qMZsVX/oGSAem7sywjTjU3Jc6eGH3
 W7qQyMOsy+mSKfxqxrmquWhJY3T4p+Q=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad8e861 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=69wJf7TsAAAA:8 a=raqJFIpfAAAA:8 a=KKAkSRfTAAAA:8 a=4RfHsjFK4ncCdWmAhpQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=_hj11Ae09VJzK9KqwGmL:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NSBTYWx0ZWRfX7PwWxp5Te7EB
 ZFYLbVdUFwh7UU5v7JRUX9IUSkSVhd44qyTLQdQ3xKwYRmeVwbzkjPCi6iGQpQtEVh78NbA+ZyY
 VJe9F33yyuM4FXh+Lv3K251gWnACrHOedKyIFwWSPD5JqKz5VSMkzc72jEw5NspIjAGV9Qif4Mc
 cMyqhj09aFfYihdyQ/50h20N4pahCwKa2kCY6OhsSgHkgQeNrTxbTBATwj7ty+dux5/oRv7nVne
 MrE7+V2gTJrOLScaGaZIT7JdpAsULPbD84luuyRFpBikS3VGIepYyzIU5ZlZbI82Kmfx8yGAg97
 95v77zrGsdZVbetYec4+jMKkLhgw6FbJEwnhbloHEpCZb+/479qeoiiopRp9cZnpt6xYpYV4Vg/
 Ol3oaaS3cxiBFRpbLtgQRkMDWKbBgqIMn/e1v5hcgEvqsoQ/5JMs8mr1k9w5e/S9egy8zI2hFA8
 he06wc5r0yqfgXhqahw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/26 12:42, Richard Henderson wrote:
> On 10/21/26 10:50, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 27/9/26 01:56, Richard Henderson wrote:
>>> A 16-bit near branch that wraps through 0xFFFF must truncate EIP.
>>> TCG skipped this when the target was on the same page, which can
>>> happen when the CS base is not page aligned.
>>>
>>> There was an existing test for this further up that attempted to
>>> test this, but was restricted to a 16-bit branch in 32-bit mode,
>>> which can be subsumed.
>>>
>>> The previous test for pc being on the same page, rather than eip, is
>>> only relevant to using goto_tb not to eip wrapping.  There is another
>>> test for pc on the same page further down, via translator_use_goto_tb.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: e3a79e0e878 ("target/i386: Enable TARGET_TB_PCREL")
>>> Reported-by: Paul Galbraith <paul@galbraiths.ca>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/i386/tcg/translate.c | 24 +++++++++++++-----------
>>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
>>> index a38cc2c15d0..18706ec8a74 100644
>>> --- a/target/i386/tcg/translate.c
>>> +++ b/target/i386/tcg/translate.c
>>> @@ -2015,9 +2015,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp 
>>> ot, int diff, int tb_num)
>>>       if (!CODE64(s)) {
>>>           if (ot == MO_16) {
>>>               mask = 0xffff;
>>> -            if (tb_cflags(s->base.tb) & CF_PCREL && CODE32(s)) {
>>> -                use_goto_tb = false;
>>> -            }
>>>           } else {
>>>               mask = 0xffffffff;
>>>           }
>>> @@ -2025,15 +2022,20 @@ static void gen_jmp_rel(DisasContext *s, 
>>> MemOp ot, int diff, int tb_num)
>>>       new_eip &= mask;
>>>       if (tb_cflags(s->base.tb) & CF_PCREL) {
>>> +        assert(s->pc_save_valid);
>>>           tcg_gen_addi_tl(cpu_eip, cpu_eip, new_pc - s->pc_save);
>>> -        /*
>>> -         * If we can prove the branch does not leave the page and we 
>>> have
>>> -         * no extra masking to apply (data16 branch in code32, see 
>>> above),
>>> -         * then we have also proven that the addition does not wrap.
>>> -         */
>>> -        if (!use_goto_tb || !translator_is_same_page(&s->base, 
>>> new_pc)) {
>>> -            tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
>>> -            use_goto_tb = false;
>>> +
>>> +        if (mask != -1) {
>>> +            /*
>>> +             * If eip "page" doesn't change, then the addition cannot
>>> +             * leave [0, mask] on any rerun of this TB, which only
>>> +             * ever shifts EIP by whole pages.
>>> +             */
>>> +            target_ulong old_eip = s->pc_save - s->cs_base;
>>> +            if ((old_eip ^ new_eip) & TARGET_PAGE_MASK) {
>>
>> Is it OK to skip the previous ot == MO_16 and CODE32() checks?
> 
> Yes.
> 
>> The next patch only tests 16-bit, not 32-bit protected. Can we
>> complement with a 32-bit test? Since this is a qemu-stable@ fix,
>> can you better explain the "subsuming" and why we don't need this
>> safer check:
>>
>>                 if ((CODE32(s) && ot == MO_16)
> 
> Because this was trying to do exactly what...
> 
> 
>>                     || ((old_eip ^ new_eip) & TARGET_PAGE_MASK)) {
> 
> ... this does, but more accurately.

Bare with me, x86 is the architecture I have less interest in, I'm
looking at your patch because you are pinging for review since 1 month.

I couldn't grasp the "exactly that" so asked a LLM to trigger the path,
and it found a way updating test-branch-wrap16.S to use paging aliases
(see below).
I can not make sense of it, so feel free to disregard as slop :)

AI;DR;

1. No mask is emitted. The TB translated at linear 0x400100 (EIP 0x0100) 
contains only:
0x00400100:  66 e9 fc 00     jmp 0x400200
  add_i32 eip,eip,$0x100
  goto_tb $0x0
    There's no and and goto_tb is still used, as predicted.
2. The same TB is reused at a different EIP:
Trace 0: 0x3001dc200 [00400000/0000000000400100/...]   first run
Trace 0: 0x3001dc200 [00400000/0000000000410100/...]   reused at EIP 0x10100
3. The wrong target is reached. Execution continues at 0x410200 (EIP 
0x10200 instead of 0x0200), takes the failure branch at 0x0041022a, and 
prints FAIL: scenario 3.
4. Restoring CODE32(s) && ot == MO_16 || in front of the page check 
gives PASS.

-- >8 --
diff --git a/tests/tcg/i386/system/test-branch-wrap16.S 
b/tests/tcg/i386/system/test-branch-wrap16.S
index 9a64b4c6d04..7b7acd74b9a 100644
--- a/tests/tcg/i386/system/test-branch-wrap16.S
+++ b/tests/tcg/i386/system/test-branch-wrap16.S
@@ -1,20 +1,35 @@
  /*
   * SPDX-License-Identifier: GPL-2.0-or-later
   *
- * A 16-bit near branch must truncate EIP to 16 bits.
+ * A near branch with a 16-bit operand size must truncate EIP to 16 bits.
   *
- * The test jumps from IP 0xFFF0 to IP 0x0020 in 16-bit code. The jump
- * crosses 0xFFFF. For correct 16-bit behaviour the CPU should wrap the
- * target to 0x0020, rather than branching to 0x10020.
+ * Scenario 1 (16-bit code): jumps from IP 0xFFF0 to IP 0x0020 in 16-bit
+ * code. The jump crosses 0xFFFF. For correct 16-bit behaviour the CPU
+ * should wrap the target to 0x0020, rather than branching to 0x10020.
+ *
+ * Scenario 2 (32-bit code, data16 branch): jumps from EIP 0xFFF0 to
+ * EIP 0x0020 in 32-bit code with a 0x66 operand-size prefix (ot == MO_16
+ * in CODE32). EIP must again wrap to 0x0020.
   *
   * TCG used to skip the wrap when the untruncated target (CS base +
   * 0x10020) was on the same guest page as the jump. That only happens
- * when the CS base is not page aligned, so the code segment starts at
+ * when the CS base is not page aligned, so each code segment starts at
   * a page boundary plus 0x10.
+ *
+ * Scenario 3 (32-bit code, data16 branch, TB reuse): with CF_PCREL a TB
+ * is looked up by physical address, so a TB translated at EIP 0x0100 is
+ * reused at EIP 0x10100 when both linear addresses alias the same
+ * physical page. A data16 branch from 0x0100 to 0x0200 does not wrap at
+ * translation time, but on reuse it must still truncate 0x10200 to
+ * 0x0200. The target checks its own EIP with call/pop.
   */

  #define SEL_CODE32   0x08
  #define SEL_CODE16   0x18
+#define SEL_WR32     0x20
+#define SEL_ALIAS    0x28
+
+#define ALIAS_BASE   0x400000   /* linear base of SEL_ALIAS */

          .data

@@ -30,6 +45,14 @@ gdt16_code16:
          /* 16-bit code, 64 KiB limit; main fills in the base */
          .word 0xFFFF, 0
          .byte 0, 0x9b, 0x00, 0
+gdt16_wrap32:
+        /* 32-bit code, 64 KiB limit; main fills in the base */
+        .word 0xFFFF, 0
+        .byte 0, 0x9b, 0x40, 0
+gdt16_alias:
+        /* 32-bit code, 4 GiB limit, base ALIAS_BASE */
+        .word 0xFFFF, ALIAS_BASE & 0xFFFF
+        .byte (ALIAS_BASE >> 16) & 0xFF, 0x9b, 0xCF, ALIAS_BASE >> 24
  gdt16_end:

  gdtr16:
@@ -37,10 +60,28 @@ gdtr16:
          .long gdt16

  fail_msg:
-        .asciz "FAIL: branch left EIP untruncated\n"
+        .asciz "FAIL: scenario %d: branch left EIP untruncated\n"
  pass_msg:
          .asciz "PASS\n"

+        .balign 4
+scenario:
+        .long 0
+alias_runs:
+        .long 0
+
+        /*
+         * Page tables: 0-4 MiB identity mapped, and the two linear pages
+         * ALIAS_BASE and ALIAS_BASE + 0x10000 both mapped to alias_page.
+         */
+        .balign 0x1000
+alias_pd:
+        .fill 1024, 4, 0
+alias_pt0:
+        .fill 1024, 4, 0
+alias_pt1:
+        .fill 1024, 4, 0
+
          .section .text16, "ax"
          .code16

@@ -55,7 +96,7 @@ wrap16_cs_base:
          .skip 0x10
  wrap16_target:
          /* jmp lands here when EIP wraps to 0x0020 */
-        ljmpl $SEL_CODE32, $test_passed
+        ljmpl $SEL_CODE32, $test32_setup

          .org wrap16_cs_base + 0xfff0
  wrap16_entry:
@@ -73,6 +114,72 @@ wrap16_fail:
          /* jmp lands here when EIP does not wrap (0x10020) */
          ljmpl $SEL_CODE32, $test_failed

+        /*
+         * Second segment: 32-bit code, same non-page-aligned layout.
+         * The branch here uses a 0x66 prefix, i.e. ot == MO_16 in
+         * CODE32, which previously disabled goto_tb unconditionally.
+         */
+        .balign 0x1000
+        .skip 0x10
+wrap32_cs_base:
+
+        .skip 0x10
+wrap32_target:
+        /* data16 jmp lands here when EIP wraps to 0x0020 */
+        .code32
+        ljmp $SEL_CODE32, $test_alias_setup
+
+        .org wrap32_cs_base + 0xfff0
+wrap32_entry:
+        .code32
+        /*
+         * Same wrapping branch, but in 32-bit code with an operand-size
+         * prefix: data16 'jmp rel16'.
+         */
+        .byte 0x66, 0xe9                        /* o16 jmp rel16 */
+        .word wrap32_target - (. + 2)           /* cw: 16-bit offset */
+
+        .org wrap32_cs_base + 0x10020
+wrap32_fail:
+        .code32
+        /* data16 jmp lands here when EIP does not wrap (0x10020) */
+        ljmp $SEL_CODE32, $test_failed
+
+        /*
+         * Third segment: one physical page seen through SEL_ALIAS at
+         * EIP 0x0000 and EIP 0x10000.
+         */
+        .balign 0x1000
+alias_page:
+
+        .org alias_page + 0x100
+alias_entry:
+        .code32
+        /*
+         * data16 'jmp alias_target': does not cross a page at EIP 0x0100,
+         * so TCG may omit the truncation, but the TB is re-run at 0x10100.
+         */
+        .byte 0x66, 0xe9                        /* o16 jmp rel16 */
+        .word alias_target - (. + 2)            /* cw: 16-bit offset */
+
+        .org alias_page + 0x200
+alias_target:
+        call alias_eip
+alias_eip:
+        popl %eax
+        cmpl $(alias_eip - alias_page), %eax
+        jne 1f
+        incl alias_runs
+        cmpl $2, alias_runs
+        je 2f
+        /* Re-run the translated branch TB through the aliased page */
+        ljmp $SEL_ALIAS, $(alias_entry - alias_page + 0x10000)
+2:
+        ljmp $SEL_CODE32, $test_passed
+1:
+        /* EIP was 0x10205: the branch did not truncate EIP */
+        ljmp $SEL_CODE32, $test_failed
+
          .text
          .code32
          .globl main
@@ -82,10 +189,48 @@ main:
          shrl $16, %eax
          movb %al, gdt16_code16 + 4
          movb %ah, gdt16_code16 + 7
+
+        movl $wrap32_cs_base, %eax
+        movw %ax, gdt16_wrap32 + 2
+        shrl $16, %eax
+        movb %al, gdt16_wrap32 + 4
+        movb %ah, gdt16_wrap32 + 7
+
          lgdt gdtr16

+        movl $1, scenario
          ljmpw $SEL_CODE16, $0xFFF0

+test32_setup:
+        movl $2, scenario
+        ljmp $SEL_WR32, $0xFFF0
+
+test_alias_setup:
+        movl $3, scenario
+        xorl %ecx, %ecx
+1:
+        movl %ecx, %eax
+        shll $12, %eax
+        orl $3, %eax
+        movl %eax, alias_pt0(,%ecx,4)
+        incl %ecx
+        cmpl $1024, %ecx
+        jne 1b
+
+        movl $alias_pt0 + 3, alias_pd
+        movl $alias_pt1 + 3, alias_pd + (ALIAS_BASE >> 22) * 4
+        movl $alias_page + 3, alias_pt1
+        movl $alias_page + 3, alias_pt1 + 0x10 * 4
+
+        movl $alias_pd, %eax
+        movl %eax, %cr3
+        movl %cr0, %eax
+        orl $0x80000000, %eax
+        movl %eax, %cr0
+
+        /* First run: translate the branch TB at EIP 0x0100 */
+        ljmp $SEL_ALIAS, $(alias_entry - alias_page)
+
  test_passed:
          pushl $pass_msg
          call ml_printf
@@ -94,6 +239,7 @@ test_passed:
          ret

  test_failed:
+        pushl scenario
          pushl $fail_msg
          call ml_printf
          addl $8, %esp
---


