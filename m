Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9801C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 20:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQBmm-0007dw-5s; Sat, 06 Jul 2024 16:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sQBmk-0007dC-0W; Sat, 06 Jul 2024 16:13:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sQBmh-0005qY-5f; Sat, 06 Jul 2024 16:13:28 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 43DB54E6005;
 Sat, 06 Jul 2024 22:13:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id fRS0oUd3Pp6t; Sat,  6 Jul 2024 22:13:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 487854E601B; Sat, 06 Jul 2024 22:13:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4682B746E3B;
 Sat, 06 Jul 2024 22:13:16 +0200 (CEST)
Date: Sat, 6 Jul 2024 22:13:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 33/43] target/ppc: Remove single use static inline function
In-Reply-To: <D2GKLJBBSWBH.2873DA1I8QJ9Q@gmail.com>
Message-ID: <dd077f40-4f90-4ad1-4c43-b98f62d1aed6@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <c30ddd4f433bbe60629d2be66c5214076f677fa9.1716763435.git.balaton@eik.bme.hu>
 <D2GKLJBBSWBH.2873DA1I8QJ9Q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 4 Jul 2024, Nicholas Piggin wrote:
> On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
>> The ger_pack_masks() function is only used once and the inverse of
>> this operation is already inlined so it can be inlined too in the only
>> caller and removed from the header.
>
> Is this needed for later patches? I might prefer to keep it, even

No, I think this patch can just be dropped then. I don't plan to make 
another version of it so just leave it out if you don't want to take it.

Regards,
BALATON Zoltan

> move it into vsx-impl.c.inc and pull its inverse out into its own
> function too even.
>
> Thanks,
> Nick
>
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/internal.h               | 9 ---------
>>  target/ppc/translate/vsx-impl.c.inc | 6 ++++--
>>  2 files changed, 4 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
>> index 20fb2ec593..8e5a241f74 100644
>> --- a/target/ppc/internal.h
>> +++ b/target/ppc/internal.h
>> @@ -293,13 +293,4 @@ FIELD(GER_MSK, XMSK, 0, 4)
>>  FIELD(GER_MSK, YMSK, 4, 4)
>>  FIELD(GER_MSK, PMSK, 8, 8)
>>
>> -static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
>> -{
>> -    int msk = 0;
>> -    msk = FIELD_DP32(msk, GER_MSK, XMSK, xmsk);
>> -    msk = FIELD_DP32(msk, GER_MSK, YMSK, ymsk);
>> -    msk = FIELD_DP32(msk, GER_MSK, PMSK, pmsk);
>> -    return msk;
>> -}
>> -
>>  #endif /* PPC_INTERNAL_H */
>> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
>> index 0266f09119..62950d348a 100644
>> --- a/target/ppc/translate/vsx-impl.c.inc
>> +++ b/target/ppc/translate/vsx-impl.c.inc
>> @@ -2819,7 +2819,7 @@ static bool trans_XXSETACCZ(DisasContext *ctx, arg_X_a *a)
>>  static bool do_ger(DisasContext *ctx, arg_MMIRR_XX3 *a,
>>      void (*helper)(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32))
>>  {
>> -    uint32_t mask;
>> +    uint32_t mask = 0;
>>      TCGv_ptr xt, xa, xb;
>>      REQUIRE_INSNS_FLAGS2(ctx, ISA310);
>>      REQUIRE_VSX(ctx);
>> @@ -2832,7 +2832,9 @@ static bool do_ger(DisasContext *ctx, arg_MMIRR_XX3 *a,
>>      xa = gen_vsr_ptr(a->xa);
>>      xb = gen_vsr_ptr(a->xb);
>>
>> -    mask = ger_pack_masks(a->pmsk, a->ymsk, a->xmsk);
>> +    mask = FIELD_DP32(mask, GER_MSK, XMSK, a->xmsk);
>> +    mask = FIELD_DP32(mask, GER_MSK, YMSK, a->ymsk);
>> +    mask = FIELD_DP32(mask, GER_MSK, PMSK, a->pmsk);
>>      helper(tcg_env, xa, xb, xt, tcg_constant_i32(mask));
>>      return true;
>>  }
>
>

