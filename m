Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9E0C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmsZ-0006fp-Jl; Mon, 11 Mar 2024 17:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rjmsV-0006eq-JG; Mon, 11 Mar 2024 17:08:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rjmsQ-0003go-JT; Mon, 11 Mar 2024 17:08:10 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 639694E601F;
 Mon, 11 Mar 2024 22:07:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 6DM-IeAD8Ze7; Mon, 11 Mar 2024 22:07:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 63B934E6012; Mon, 11 Mar 2024 22:07:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 61A147456B4;
 Mon, 11 Mar 2024 22:07:57 +0100 (CET)
Date: Mon, 11 Mar 2024 22:07:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Benjamin Gray <bgray@linux.ibm.com>
Subject: Re: [PATCH 06/13] ppc/spapr: Add pa-features for POWER10 machines
In-Reply-To: <020a53d8-3b90-4b30-b0c7-862951fbef43@linaro.org>
Message-ID: <ef4c48d1-9e11-d6af-d4cc-3ae6c567f098@eik.bme.hu>
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-7-npiggin@gmail.com>
 <020a53d8-3b90-4b30-b0c7-862951fbef43@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-835033333-1710191277=:50025"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-835033333-1710191277=:50025
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 11 Mar 2024, Philippe Mathieu-Daudé wrote:
> On 11/3/24 19:51, Nicholas Piggin wrote:
>> From: Benjamin Gray <bgray@linux.ibm.com>
>> 
>> Add POWER10 pa-features entry.
>> 
>> Notably DEXCR and and [P]HASHST/[P]HASHCHK instruction support is
>> advertised. Each DEXCR aspect is allocated a bit in the device tree,
>> using the 68--71 byte range (inclusive). The functionality of the
>> [P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
>> bit 0 (BE).
>> 
>> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
>> [npiggin: reword title and changelog, adjust a few bits]
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>> 
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 247f920f07..128bfe11a8 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -265,6 +265,36 @@ static void spapr_dt_pa_features(SpaprMachineState 
>> *spapr,
>>           /* 60: NM atomic, 62: RNG */
>>           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>>       };
>> +    /* 3.1 removes SAO, HTM support */
>> +    uint8_t pa_features_31[] = { 74, 0,
>
> Nitpicking because pre-existing, all these arrays could be static const.

If we are at it then maybe also s/0x00/   0/ because having a stream of 
0x80 and 0x00 is not the most readable.

Regards,
BALATON Zoltan

>> +        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 
>> */
>> +        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
>> +        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
>> +        /* 6: DS207 */
>> +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
>> +        /* 16: Vector */
>> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
>> +        /* 18: Vec. Scalar, 20: Vec. XOR */
>> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
>> +        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
>> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
>> +        /* 32: LE atomic, 34: EBB + ext EBB */
>> +        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
>> +        /* 40: Radix MMU */
>> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
>> +        /* 42: PM, 44: PC RA, 46: SC vec'd */
>> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
>> +        /* 48: SIMD, 50: QP BFP, 52: String */
>> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
>> +        /* 54: DecFP, 56: DecI, 58: SHA */
>> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
>> +        /* 60: NM atomic, 62: RNG */
>> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
>> +        /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
>> +        0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
>> +        /* 72: [P]HASHCHK */
>> +        0x80, 0x00,                         /* 72 - 73 */
>> +    };
>>       uint8_t *pa_features = NULL;
>>       size_t pa_size;
>>   @@ -280,6 +310,10 @@ static void spapr_dt_pa_features(SpaprMachineState 
>> *spapr,
>>           pa_features = pa_features_300;
>>           pa_size = sizeof(pa_features_300);
>>       }
>> +    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, 
>> cpu->compat_pvr)) {
>> +        pa_features = pa_features_31;
>> +        pa_size = sizeof(pa_features_31);
>> +    }
>>       if (!pa_features) {
>>           return;
>>       }
>
>
>
--3866299591-835033333-1710191277=:50025--

