Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FA8C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpe94-0005Mg-2p; Tue, 04 Mar 2025 21:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpe8N-0005Ei-NO
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:05:27 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpe8K-00028i-SK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:05:19 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6836A4E6027;
 Wed, 05 Mar 2025 03:05:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id WAMaR6hbDdsA; Wed,  5 Mar 2025 03:05:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7F01D4E601A; Wed, 05 Mar 2025 03:05:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7D83574577C;
 Wed, 05 Mar 2025 03:05:09 +0100 (CET)
Date: Wed, 5 Mar 2025 03:05:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 10/11] qemu: Introduce qemu_arch_name() helper
In-Reply-To: <19ec9924-5011-4bae-945a-2442f518865a@linaro.org>
Message-ID: <2dd4e227-1d4a-b4c4-9ceb-6c72d66a7688@eik.bme.hu>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-11-philmd@linaro.org>
 <774c4a7a-c8e0-8bb2-0e40-a34886fcc7ed@eik.bme.hu>
 <19ec9924-5011-4bae-945a-2442f518865a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2045484394-1741140309=:73150"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-2045484394-1741140309=:73150
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 5 Mar 2025, Philippe Mathieu-Daudé wrote:
> On 5/3/25 02:32, BALATON Zoltan wrote:
>> On Wed, 5 Mar 2025, Philippe Mathieu-Daudé wrote:
>>> Introduce a generic helper to get the target name of a QemuArchBit.
>>> (This will be used for single / heterogeneous binaries).
>>> Use it in target_name(), removing the last use of the TARGET_NAME
>>> definition.
>>> 
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> include/qemu/arch_info.h |  2 ++
>>> arch_info-target.c       | 34 +++++++++++++++++++++++++++++++++-
>>> 2 files changed, 35 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/include/qemu/arch_info.h b/include/qemu/arch_info.h
>>> index 613dc2037db..7e3192f590f 100644
>>> --- a/include/qemu/arch_info.h
>>> +++ b/include/qemu/arch_info.h
>>> @@ -46,6 +46,8 @@ typedef enum QemuArchBit {
>>> #define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
>>> #define QEMU_ARCH_ALL           -1
>>> 
>>> +const char *qemu_arch_name(QemuArchBit qemu_arch_bit);
>>> +
>>> const char *target_name(void);
>>> 
>>> bool qemu_arch_available(unsigned qemu_arch_mask);
>>> diff --git a/arch_info-target.c b/arch_info-target.c
>>> index 61007415b30..9b19fe8d56d 100644
>>> --- a/arch_info-target.c
>>> +++ b/arch_info-target.c
>>> @@ -24,9 +24,41 @@
>>> #include "qemu/osdep.h"
>>> #include "qemu/arch_info.h"
>>> 
>>> +const char *qemu_arch_name(QemuArchBit qemu_arch_bit)
>>> +{
>>> +    static const char *legacy_target_names[] = {
>>> +        [QEMU_ARCH_ALPHA] = "alpha",
>>> +        [QEMU_ARCH_BIT_ARM] = TARGET_LONG_BITS == 32 ? "arm" : "aarch64",
>>> +        [QEMU_ARCH_BIT_AVR] = "avr",
>>> +        [QEMU_ARCH_BIT_HEXAGON] = "hexagon",
>>> +        [QEMU_ARCH_BIT_HPPA] = "hppa",
>>> +        [QEMU_ARCH_BIT_I386] = TARGET_LONG_BITS == 32 ? "i386" : 
>>> "x86_64",
>>> +        [QEMU_ARCH_BIT_LOONGARCH] = "loongarch64",
>>> +        [QEMU_ARCH_BIT_M68K] = "m68k",
>>> +        [QEMU_ARCH_BIT_MICROBLAZE] = TARGET_BIG_ENDIAN ? "microblaze"
>>> +                                                       : "microblazeel",
>>> +        [QEMU_ARCH_BIT_MIPS] = TARGET_BIG_ENDIAN
>>> +                             ? (TARGET_LONG_BITS == 32 ? "mips" : 
>>> "mips64")
>>> +                             : (TARGET_LONG_BITS == 32 ? "mipsel" : 
>>> "mips64el"),
>>> +        [QEMU_ARCH_BIT_OPENRISC] = "or1k",
>>> +        [QEMU_ARCH_BIT_PPC] = TARGET_LONG_BITS == 32 ? "ppc" : "ppc64",
>>> +        [QEMU_ARCH_BIT_RISCV] = TARGET_LONG_BITS == 32 ? "riscv32" : 
>>> "riscv64",
>>> +        [QEMU_ARCH_BIT_RX] = "rx",
>>> +        [QEMU_ARCH_BIT_S390X] = "s390x",
>>> +        [QEMU_ARCH_BIT_SH4] = TARGET_BIG_ENDIAN ? "sh4eb" : "sh4",
>>> +        [QEMU_ARCH_BIT_SPARC] = TARGET_LONG_BITS == 32 ? "sparc" : 
>>> "sparc64",
>>> +        [QEMU_ARCH_BIT_TRICORE] = "tricore",
>>> +        [QEMU_ARCH_BIT_XTENSA] = TARGET_BIG_ENDIAN ? "xtensaeb" : 
>>> "xtensa",
>>> +    };
>>> +
>>> +    assert(qemu_arch_bit < ARRAY_SIZE(legacy_target_names));
>>> +    assert(legacy_target_names[qemu_arch_bit]);
>>> +    return legacy_target_names[qemu_arch_bit];
>>> +}
>>> +
>>> const char *target_name(void)
>>> {
>>> -    return TARGET_NAME;
>>> +    return qemu_arch_name(QEMU_ARCH_BIT);
>>> }
>> 
>> Why two functions that do the same? Do you plan to remove target_name later 
>> or it should just do what the new function does?
>
> target_name() is a no-op for current binaries, where one binary include
> a single target.
>
> The "single binary" will include multiple targets. We plan to symlink it
> to the previous binaries and use argv[0] to mimic previous behavior.

This didn't answer the question for me why this would need target_name() 
and qemu_arch_name() which are the same function with two names. If these 
do the same why not only have one of them?

Regards,
BALATON Zoltan
--3866299591-2045484394-1741140309=:73150--

