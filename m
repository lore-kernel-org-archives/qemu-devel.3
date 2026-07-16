Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34FCC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMLE-0001HM-Kj; Thu, 16 Jul 2026 09:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkMLC-0001HA-I6; Thu, 16 Jul 2026 09:41:30 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wkML9-0006tM-Dn; Thu, 16 Jul 2026 09:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1784209284;
 bh=1/+hJS1P9hCFF18cLN7C33X7Q1eB7ahl43GUGhfx6oM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kiTdjwXAKF7+mJ3zYA+rJNcdqM2YI5Kl2az0I36F7UvVE7sv3wqYKrU42jZd6sbom
 7+uzXd5I+ih6ZMrGxew1HDUjPAGRDgX10w0snMlLJNz6VJY//aCRlu+w5pkMfLVLwQ
 17UanxJOV3Jeac8+sB5egWE6iZPjjwkwdYr/Sr/B1Z+tI/SXAZz6GDkP2tJ5A136R8
 DLuHn9IPbSjMLEU4qhqxt1WEGQvaLX5c1hpIXTWLRkn2mPttMersdMIbGzka+djdU7
 +z7wzt8i4I68bNpcks9liP4W5nvxbdhjYpJTjJ4cjieHlaXht4MmJkGJ9YV2FsnjC8
 Ft7vOVs5P2u+Q==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 46D5E40286;
 Thu, 16 Jul 2026 15:41:24 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 4233AFF861;
 Thu, 16 Jul 2026 15:41:24 +0200 (CEST)
Received: from [147.171.132.150] (naga.tima.u-ga.fr [147.171.132.150])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id E68CA400F9;
 Thu, 16 Jul 2026 15:41:23 +0200 (CEST)
Message-ID: <3bcc4074-eaac-4318-b572-bcd45e27786e@univ-grenoble-alpes.fr>
Date: Thu, 16 Jul 2026 15:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] disas/riscv.c: Correct indent for checkpatch
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: julien.thillard@univ-grenoble-alpes.fr
References: <20260715190737.1381701-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260715190737.1381701-4-frederic.petrot@univ-grenoble-alpes.fr>
 <c06253bf-6e56-4ef8-9fd0-43d8a062190e@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <c06253bf-6e56-4ef8-9fd0-43d8a062190e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks Daniel for the quick review.

The style issue is (I am afraid) due to your patch 9273cda7229 (indent of 3), 
but in your defense checkpatch didn't not catch it until I added the 'if ...'.

If that's ok with you, I'll send a v2 that first corrects the style issue
on the switch and then adds the rest.

Cheers,
Frédéric

On 7/16/26 15:21, Daniel Henrique Barboza wrote:
> 
> 
> On 7/15/2026 4:07 PM, frederic.petrot@univ-grenoble-alpes.fr wrote:
>> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
>>
>> Trival indentation patch on the cbo/lq relevant code.
>>
>> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
>> ---
> 
> As I said in patch 2 this patch is fixing style issues that patch 2 itself
> is introducing.  We want this patch squashed into patch 2.
> 
> 
> Thanks,
> Daniel
> 
>>   disas/riscv.c | 38 +++++++++++++++++++-------------------
>>   1 file changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/disas/riscv.c b/disas/riscv.c
>> index 831ff526ad..27bf4d9954 100644
>> --- a/disas/riscv.c
>> +++ b/disas/riscv.c
>> @@ -2887,25 +2887,25 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa 
>> isa)
>>               case 0: op = rv_op_fence; break;
>>               case 1: op = rv_op_fence_i; break;
>>               case 2:
>> -               /*
>> -                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
>> -                * with 'cbo' insns, but assumes rd != 0.
>> -                *
>> -                * cbo_inval  0000000 00000 ..... 010 00000 0001111
>> -                * cbo_clean  0000000 00001 ..... 010 00000 0001111
>> -                * cbo_flush  0000000 00010 ..... 010 00000 0001111
>> -                * cbo_zero   0000000 00100 ..... 010 00000 0001111
>> -                */
>> -               if ((inst >> 7) & 0b11111) {
>> -                  op = rv_op_lq;
>> -               } else {
>> -                  switch (inst >> 20) {
>> -                  case 0: op = rv_op_cbo_inval; break;
>> -                  case 1: op = rv_op_cbo_clean; break;
>> -                  case 2: op = rv_op_cbo_flush; break;
>> -                  case 4: op = rv_op_cbo_zero; break;
>> -                  }
>> -               }
>> +                /*
>> +                 * 'lq' shares the "(...) 010 ..... 0001111" opcode space
>> +                 * with 'cbo' insns, but assumes rd != 0.
>> +                 *
>> +                 * cbo_inval  0000000 00000 ..... 010 00000 0001111
>> +                 * cbo_clean  0000000 00001 ..... 010 00000 0001111
>> +                 * cbo_flush  0000000 00010 ..... 010 00000 0001111
>> +                 * cbo_zero   0000000 00100 ..... 010 00000 0001111
>> +                 */
>> +                if ((inst >> 7) & 0b11111) {
>> +                    op = rv_op_lq;
>> +                } else {
>> +                    switch (inst >> 20) {
>> +                    case 0: op = rv_op_cbo_inval; break;
>> +                    case 1: op = rv_op_cbo_clean; break;
>> +                    case 2: op = rv_op_cbo_flush; break;
>> +                    case 4: op = rv_op_cbo_zero; break;
>> +                    }
>> +                }
>>               }
>>               break;
>>           case 4:
> 
> 
> 
> 
> 

-- 
+---------------------------------------------------------------------------+
| Frédéric Pétrot,                        Pr. Grenoble INP-UGA@Ensimag/TIMA |
| Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angusta |
| http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.fr |
+---------------------------------------------------------------------------+


