Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB3606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 17:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNCXX-0002lR-KW; Sat, 31 Oct 2026 13:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xNCXR-0002jM-Cr; Sat, 31 Oct 2026 13:06:42 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xNCXP-0001ER-Bg; Sat, 31 Oct 2026 13:06:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1C40360C0F3;
 Sat, 31 Oct 2026 18:06:34 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id fr4sjKasLPmZ; Sat, 31 Oct 2026 18:06:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 04BE860C072; Sat, 31 Oct 2026 18:06:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0153713996F;
 Sat, 31 Oct 2026 18:06:31 +0100 (CET)
Date: Sat, 31 Oct 2026 18:06:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Yonggang Luo <luoyonggang@gmail.com>
cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>, 
 Felipe Balbi <balbi@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, 
 qemu-ppc@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, 
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Chao Liu <chao.liu@processmission.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
In-Reply-To: <CAE2XoE9cR_X0kkDfGTU4Mt_5Hc3WZ8K5rghw2AeL4Vh=eugGag@mail.gmail.com>
Message-ID: <bf45a858-db07-de03-70ea-ca0061d7a5d1@eik.bme.hu>
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
 <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
 <ba106173-fca3-6019-3028-122831887921@eik.bme.hu>
 <CAE2XoE9cR_X0kkDfGTU4Mt_5Hc3WZ8K5rghw2AeL4Vh=eugGag@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1954894860-1793466392=:93531"
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1954894860-1793466392=:93531
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 31 Oct 2026, Yonggang Luo wrote:
> On Sat, Oct 31, 2026 at 8:42 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Fri, 30 Oct 2026, Pierrick Bouvier wrote:
>>> On 10/30/2026 4:09 PM, BALATON Zoltan wrote:
>>>> On Fri, 30 Oct 2026, Yonggang Luo wrote:
>>>>> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo and the
>>>>> type_init
>>>>> function that calls type_register_static(). A later change needs to
>>>>> pass a
>>>>
>>>> That's the point of the macro to hide the boiler plate code.
>>>>
>>>>> target mask into that registration, and the macros have no parameter
>>>>> for it.
>>>>
>>>> Couldn't you just change the macros to take that parameter instead of
>>>> expanding it everywhere?
>>>>
>>>
>>> Problem of macros is that they don't have default parameters, so you
>>> need variants for everything:
>>>
>>> DEFINE_MACHINE
>>> DEFINE_MACHINE_EXTENDED
>>> DEFINE_MACHINE_WITH_INTERFACES
>>> DEFINE_MACHINE_WITH_INTERFACE_ARRAY
>>> and now would need a new variant, with variant for other existing ones.
>>>
>>> In the end, it's just simpler to remove this and add the boilerplate.
>>> It's written once and never modified, so using a macro just save typing
>>> those lines once.
>>>
>>>> Regards,
>>>> BALATON Zoltan
>>>>
>>>>> This series expands every caller first, with no behavior change, so the
>>>>> follow-up only replaces the type_register_static() call.
>>>>>
>>>>> Each machine file gains a class_init function, a TypeInfo, and a
>>>>> type_init
>>>>> function that calls type_register_static(). The last patch removes
>>>>> DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* from include/hw/core/boards.h.
>>
>> Macros help reading the code not saving typing. If the actual
>> functionality is buried in a lot of boiler plate it's harder to understand
>> and spot bugs so putting the unintresting boiler plate behind a macro is
>> better even if you need a separate version for different cases. Then the
>> code that uses the macro will be much more obvious and not just a lot of
>
> I think mainly because DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* are
> not defined properly
> that causes them to not be extended easily.
>
> DEFINE_TYPES is another example, use them can extend easily, how about
> always use DEFINE_TYPES?
> Or add a DEFINE_TYPE to replace DEFINE_MACHINE* and DEFINE_SECURE_MACHINE*?

Maybe I'm missing the problem but DEFINE_MACHINE macros are just 
convenience wrappers around DEFINE_MACHINE_EXTENDED. So why can't you add 
the needed parameter to DEFINE_MACHINE_EXTENDED and use that for machines 
that need it, or if it's needed by all machines then make the new 
parameter required and add it to all convenience wrappers too so you can 
keep using DEFINE_MACHINE* and just need to add one parameter to it in 
machines?

Regards,
BALATON Zoltan
--3866299591-1954894860-1793466392=:93531--

