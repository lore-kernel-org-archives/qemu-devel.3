Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D66C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyDN-0007ny-4E; Tue, 12 Mar 2024 05:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=j0G5=KS=kaod.org=clg@ozlabs.org>)
 id 1rjyDL-0007nh-SO; Tue, 12 Mar 2024 05:14:27 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=j0G5=KS=kaod.org=clg@ozlabs.org>)
 id 1rjyD6-0001CW-8b; Tue, 12 Mar 2024 05:14:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tv7Hf70PBz4wyy;
 Tue, 12 Mar 2024 20:14:06 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv7Hc27jTz4wyt;
 Tue, 12 Mar 2024 20:14:03 +1100 (AEDT)
Message-ID: <53a990d6-b583-4143-ae21-cbb2a1527350@kaod.org>
Date: Tue, 12 Mar 2024 10:14:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
Content-Language: en-US, fr
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-9-npiggin@gmail.com>
 <1f4b97ec-2cf0-4619-a3d1-6aae6e609ec3@kaod.org>
 <CZRN8BK2A5HZ.2BLTSYG9MLSEP@wheely>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CZRN8BK2A5HZ.2BLTSYG9MLSEP@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=j0G5=KS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/12/24 09:54, Nicholas Piggin wrote:
> On Tue Mar 12, 2024 at 6:06 PM AEST, Cédric Le Goater wrote:
>> On 3/11/24 19:51, Nicholas Piggin wrote:
>>> Copy the pa-features arrays from spapr, adjusting slightly as
>>> described in comments.
>>>
>>> Cc: "Cédric Le Goater" <clg@kaod.org>
>>> Cc: "Frédéric Barrat" <fbarrat@linux.ibm.com>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    hw/ppc/pnv.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>>    hw/ppc/spapr.c |  1 +
>>>    2 files changed, 66 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 52d964f77a..3e30c08420 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -332,6 +332,35 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
>>>        }
>>>    }
>>>    
>>> +/*
>>> + * Same as spapr pa_features_300 except pnv always enables CI largepages bit.
>>> + */
>>> +static const uint8_t pa_features_300[] = { 66, 0,
>>> +    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
>>> +    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
>>> +    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
>>> +    /* 6: DS207 */
>>> +    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
>>> +    /* 16: Vector */
>>> +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
>>> +    /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
>>> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
>>> +    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
>>> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
>>> +    /* 32: LE atomic, 34: EBB + ext EBB */
>>> +    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
>>> +    /* 40: Radix MMU */
>>> +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
>>> +    /* 42: PM, 44: PC RA, 46: SC vec'd */
>>> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
>>> +    /* 48: SIMD, 50: QP BFP, 52: String */
>>> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
>>> +    /* 54: DecFP, 56: DecI, 58: SHA */
>>> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
>>> +    /* 60: NM atomic, 62: RNG */
>>> +    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>>> +};
>>> +
>>>    static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>>>    {
>>>        static const char compat[] = "ibm,power9-xscom\0ibm,xscom";
>>> @@ -349,7 +378,7 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>>>            offset = pnv_dt_core(chip, pnv_core, fdt);
>>>    
>>>            _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
>>> -                           pa_features_207, sizeof(pa_features_207))));
>>> +                           pa_features_300, sizeof(pa_features_300))));
>>>        }
>>>    
>>>        if (chip->ram_size) {
>>> @@ -359,6 +388,40 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
>>>        pnv_dt_lpc(chip, fdt, 0, PNV9_LPCM_BASE(chip), PNV9_LPCM_SIZE);
>>>    }
>>>    
>>> +/*
>>> + * Same as spapr pa_features_31 except pnv always enables CI largepages bit,
>>> + * always disables copy/paste.
>>> + */
>>> +static const uint8_t pa_features_31[] = { 74, 0,
>>> +    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
>>> +    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
>>> +    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
>>> +    /* 6: DS207 */
>>> +    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
>>> +    /* 16: Vector */
>>> +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
>>> +    /* 18: Vec. Scalar, 20: Vec. XOR */
>>> +    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
>>> +    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
>>> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
>>> +    /* 32: LE atomic, 34: EBB + ext EBB */
>>> +    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
>>> +    /* 40: Radix MMU */
>>> +    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
>>> +    /* 42: PM, 44: PC RA, 46: SC vec'd */
>>> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
>>> +    /* 48: SIMD, 50: QP BFP, 52: String */
>>> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
>>> +    /* 54: DecFP, 56: DecI, 58: SHA */
>>> +    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
>>> +    /* 60: NM atomic, 62: RNG */
>>> +    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>>> +    /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
>>> +    0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
>>> +    /* 72: [P]HASHCHK */
>>> +    0x80, 0x00,                         /* 72 - 73 */
>>> +};
>>> +
>>>    static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>>>    {
>>>        static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
>>> @@ -376,7 +439,7 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
>>>            offset = pnv_dt_core(chip, pnv_core, fdt);
>>>    
>>>            _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
>>> -                           pa_features_207, sizeof(pa_features_207))));
>>> +                           pa_features_31, sizeof(pa_features_31))));
>>>        }
>>>    
>>>        if (chip->ram_size) {
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 128bfe11a8..b53c13e037 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -233,6 +233,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>>>                                     PowerPCCPU *cpu,
>>>                                     void *fdt, int offset)
>>>    {
>>> +    /* These should be kept in sync with pnv */
>>
>> yes. In that case, the array definition should be moved under target/ppc/.
>> May be under PowerPCCPUClass ?
> 
> Yeah PowerPCCPUClass might be a good idea, although I'm not quite
> decided whether it's best to just store the arrays there, or make a
> list of features in another format and have a builder function to
> turn that into the dt array. 

That would be very nice to have. The pa_features array is cryptic and
error prone.

> There's also a few differences between
> spapr and pnv that I haven't worked out a nice way to handle yet.
> I have a pi-features property to add too which is similar.
> 
> So yes this is a bit ugly but we're already duplicating and open coding
> arrays so I'd like to just get this in to fix the missing P10 bits,
> and refactor it afterwards.

OK.

Thanks,

C.




