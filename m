Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444E6606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=sCnrVcD+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzKV-0000V4-Jy; Thu, 22 Oct 2026 16:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzKS-0000Sf-CF
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:24:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzKP-00075Q-OV
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=kWNAVCpsTRUJTFGWowVporJEDXoRVcyDi5vtSzmSGtk=; b=sCnrVcD+zOZF3gXz6wzwvr7zFW
 vPJlAmBb89UGGkceswt06vLmISFhsicPGwBOpIPv3bHZMoktrM3ZNrU/glZURuxkIleYognzWLbL2
 IYgsZR5JcYPWMssuuzQsgYUU6tToWZWNwRDqeXo9rSk45X/ljtiQdLgQWR5LUY+sIOQruA6x2uubz
 4/m/y7dFFsqpzuaBiQL/l9HYdqE5o4jGze7GXLH/VbDeZzT9vM2E0CJPGQqhdRzWDp+Hoo99HWCuU
 VwlocKxUyoWJQAbB4zwAPQRz0q5KLm292xYQfIs+mNi6rNbKW2BNxJ4PBMrEjMBnAe40gx25kPdsI
 t1KElUMIhIz7WrLBD3uVthgpgBZGe7WniECDyXZQ/vSTICrlarnKUd04pevPicvR/fK4y3fijrwOK
 CU9cenG8iBmkbQegV1gYH/o6vkoYF7lGQ6ZzMpZ19gdynYZYwX3kPO8SvM8Hh3b23PogtlAjv30Gm
 7Ld0BJ3+AKdQZlDSLEIrrOrOQTzj+mFgVQl9Cr/X9/CX5Hu2H555BqxDFYpgcb8kymkW4fx1QY8Xx
 hWzIGd1psrBUYLmcwmQ7QA8a2d4IY9Bi6+G8HD4Q/C+u8F25SNnqommoTIVKWgBY39gqG/NXQhvC3
 AcuRhesph/a7Iv1TW3HF2INaziVnSBVsIH/nYRShA=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzJf-003FK2-L5; Thu, 22 Oct 2026 21:23:12 +0100
Message-ID: <139ef7d4-6e28-44db-8ab7-92e62cde80f5@ilande.co.uk>
Date: Thu, 22 Oct 2026 21:23:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: dpim <sun4qemu@gmail.com>, qemu-devel@nongnu.org
References: <20260918105705.433093-1-sun4qemu@gmail.com>
 <ebea4a0e-3a70-4f6a-bd4e-0ab80f810e31@ilande.co.uk>
 <CAAM0arPaue5A331c7MSd_Z-C+tTZbNQes-9T-dX0Vmu8vmQyDQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <CAAM0arPaue5A331c7MSd_Z-C+tTZbNQes-9T-dX0Vmu8vmQyDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] target/sparc: implement TTE page-size for 32M/256M
 pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18/10/2026 12:03, Artyom Tarasenko wrote:

> Hi Mark,
> 
> вс, 18 окт. 2026 г., 11:23 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk 
> <mailto:mark.cave-ayland@ilande.co.uk>>:
> 
>     On 18/09/2026 11:57, dpim wrote:
> 
>      > Currently, the TTE's page-size field, Size, is 2 bits wide:
>      >
>      >      #define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
>      >
>      > That is the TTE of every UltraSPARC before UltraSPARC IV+.
>      > The JPS1 implementation supplements for UltraSPARC III and IV+
>      > describe the TTE word in tables F-1 and F-1-4 respectively, and differ
>      > in one bit:
>      > Before IV+ bit 48 is reserved and reads as 0, Size is 2 bits at 62:61;
>      > On IV+ bit 48 is Size<2>, which "is the most significant bit of the
>      > page size and is concatenated with bits <62:61>"
>      > On T1 the same split exists, szl at 62:61 and szh at 48 (T1 Supplement,
>      > sec. 13.1.2).
>      >
>      > QEMU models parts on both sides of that change (UltraSPARC III/IIIi/IV,
>      > IV+, T1, T2) with the III layout: Size<2> was never implemented.
>      > Bit 48 gets lost in more than one place:
>      >
>      > On sun4u the raw TTE word is stored as the guest wrote it, bit 48
>      > included, but TTE_PGSIZE() only reads bits 62:61: the bit survives in
>      > the TLB, it is just never decoded.
>      >
>      > On sun4v, sun4v_tte_to_sun4u() converts the incoming three-bit code
>      > (cpu.h defines TTE_PGSIZE_UA2005() for it, unused until now) but masked
>      > it to two:
>      >
>      >      sun4u_tte |= (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
>      >
>      > so the third bit was dropped before it was stored.
>      >
>      > demap_tlb() duplicates the same 2-bit math instead of calling
>      > TTE_PGSIZE(), so it misses bit 48 too, for a TTE from either origin.
>      >
>      > Either way 256M decodes as 64K and 32M as 8K; the guest faults on the
>      > first access past the truncated entry.
>      >
>      > This patch implements Size<2> at bit 48, where the hardware keeps it.
>      >
>      > TTE_PGSIZE() now reads bit 48 as the high bit; on parts that keep bit
>      > 48 reserved it reads as zero, so they decode as before.
>      > sun4v_tte_to_sun4u() stores the full three-bit code, and demap_tlb()
>      > now calls TTE_PGSIZE() instead of its own copy. dump_mmu() gains 32M
>      > and 256M labels.
>      >
>      > Link: https://lore.kernel.org/qemu-devel/20260727233646.332875-1-
>     sun4qemu@gmail.com/ <https://lore.kernel.org/qemu-devel/20260727233646.332875-1-
>     sun4qemu@gmail.com/>
>      > AI-used-for: code, analysis
>      > Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com <mailto:sun4qemu@gmail.com>>
>      > ---
>      > v2: described behaviour across sun4u/sun4v instead of the sun4v
>      > conversion; no functional change. QEMU_BUILD_BUG_ON and comments in
>      > cpu.h/ldst_helper.c are dropped.
>      >
>      > This email's text -- beyond the code and analysis the trailer above
>      > covers -- also had AI involvement: current policy (AGENTS.md)
>      > declines AI-derived content outright, and even the not-yet-merged
>      > llm-usage.rst RFC would require it to be human-written regardless of
>      > any trailer. Sending as-is rather than silently -- happy to hear if
>      > that's not acceptable here.
>      >
>      > Happy to run more tests or provide more evidence if this isn't enough.
>      >
>      > Guest is OpenSolaris snv_134 (osol-dev-134-ai-sparc.iso). Firmware is
>      > the S10image/ set from OpenSPARCT1_Arch.1.5.tar.bz2, which
>      > docs/system/target-sparc64.rst names for this machine, except the
>      > MD/hv-config pair (1up-md.bin, 1up-hv.bin), from the repo below. The
>      > archive's own config only boots disk.s10hw2, capped at 4M pages.
>      >
>      > Observed on upstream 5f664cd37a, with and without this patch -- same
>      > guest, firmware and RAM, plain `boot` at the `ok` prompt (occasionally
>      > hits an unrelated, pre-existing trap in OBP's loader phase before the
>      > kernel runs):
>      >
>      >    pristine: hangs after "Loading: /platform/sun4v/kernel/sparcv9/unix";
>      >              "info tlb" shows no 32M or 256M entry.
>      >    patched:  boots to "Enter user name for system maintenance";
>      >              "info tlb" shows 256M entries, e.g.
>      >              [17] VA: 600108b8000, PA: 140000000, 256M, priv, RW, ...
>      >    Full info tlb dumps:
>      > https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/
>     verification/0002-tte-size2/logs/pristine-plain-boot-tlb.txt <https://github.com/
>     unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/logs/
>     pristine-plain-boot-tlb.txt>
>      > https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/
>     verification/0002-tte-size2/logs/patched-plain-boot-tlb.txt <https://github.com/
>     unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/logs/
>     patched-plain-boot-tlb.txt>
>      >
>      > The reproduction as a script, verify.sh (fetches firmware, MD and
>      > ISO, checks their hashes, boots):
>      > https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/
>     verification/0002-tte-size2/verify.sh <https://github.com/unix0cc/qemu-
>     experimental-patches/blob/967a037/verification/0002-tte-size2/verify.sh>
>      >
>      > On sun4u the pre-extension page sizes are verified by
>      > make check-qtest-sparc64 and make check-functional-sparc64 (sun4u,
>      > tuxrun, migration), which pass on the patched build with logs:
>      > https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/
>     verification/0002-tte-size2/check-qtest-sparc64.log <https://github.com/unix0cc/
>     qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/check-qtest-
>     sparc64.log>
>      > https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/
>     verification/0002-tte-size2/check-functional-sparc64.log <https://github.com/
>     unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/check-
>     functional-sparc64.log>
>      > To check whether
>      > Size<2> is exercised at all, I added a temporary log in
>      > replace_tlb_entry() and ran both suites again: zero hits, as expected
>      > -- IIi predates IV+ and doesn't implement Size<2>, so the guest
>      > running under it never sets bit 48. Result:
>      > https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/
>     verification/0002-tte-size2/sun4u-bit48-probe/RESULT <https://github.com/unix0cc/
>     qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/sun4u-bit48-
>     probe/RESULT>
>      > Probe and logs:
>      > https://github.com/unix0cc/qemu-experimental-patches/tree/967a037/
>     verification/0002-tte-size2/sun4u-bit48-probe/ <https://github.com/unix0cc/qemu-
>     experimental-patches/tree/967a037/verification/0002-tte-size2/sun4u-bit48-probe/>
>      > 32M/256M on sun4u stays untested by this suite; that would need a guest
>      > running under Sun-UltraSparc-IV-plus.
>      >
>      > Overview of everything above (scripts, logs, README):
>      > https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/
>     verification/0002-tte-size2/README <https://github.com/unix0cc/qemu-experimental-
>     patches/blob/967a037/verification/0002-tte-size2/README>
>      >
>      >   target/sparc/cpu.h         |  4 +++-
>      >   target/sparc/ldst_helper.c |  9 +++++++--
>      >   target/sparc/mmu_helper.c  | 12 ++++++++++++
>      >   3 files changed, 22 insertions(+), 3 deletions(-)
>      >
>      > diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
>      > index 31a16c2af0..1ab420d831 100644
>      > --- a/target/sparc/cpu.h
>      > +++ b/target/sparc/cpu.h
>      > @@ -307,7 +307,9 @@ enum {
>      >   #define TTE_SET_USED(tte)   ((tte) |= TTE_USED_BIT)
>      >   #define TTE_SET_UNUSED(tte) ((tte) &= ~TTE_USED_BIT)
>      >
>      > -#define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
>      > +#define TTE_PGSIZE_HI_BIT   (1ULL << 48)
>      > +#define TTE_PGSIZE(tte)     ((((tte) >> 61) & 3ULL) | \
>      > +                             (((tte) & TTE_PGSIZE_HI_BIT) >> 46))
>      >   #define TTE_PGSIZE_UA2005(tte)     ((tte) & 7ULL)
>      >   #define TTE_PA(tte)         ((tte) & 0x1ffffffe000ULL)
>      >
>      > diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
>      > index 4ec8799d1f..142c1c24de 100644
>      > --- a/target/sparc/ldst_helper.c
>      > +++ b/target/sparc/ldst_helper.c
>      > @@ -186,7 +186,7 @@ static void demap_tlb(SparcTLBEntry *tlb, target_ulong
>     demap_addr,
>      >                   /* demap page
>      >                      will remove any entry matching VA */
>      >                   mask = 0xffffffffffffe000ULL;
>      > -                mask <<= 3 * ((tlb[i].tte >> 61) & 3);
>      > +                mask <<= 3 * TTE_PGSIZE(tlb[i].tte);
>      >
>      >                   if (!compare_masked(demap_addr, tlb[i].tag, mask)) {
>      >                       continue;
>      > @@ -217,7 +217,12 @@ static uint64_t sun4v_tte_to_sun4u(CPUSPARCState *env,
>     uint64_t tag,
>      >           return sun4v_tte;
>      >       }
>      >       sun4u_tte = TTE_PA(sun4v_tte) | (sun4v_tte & TTE_VALID_BIT);
>      > -    sun4u_tte |= (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
>      > +    {
>      > +        uint64_t pgsz = TTE_PGSIZE_UA2005(sun4v_tte);
>      > +        sun4u_tte |= (pgsz & 3ULL) << 61; /* TTE_PGSIZE bits 61-62 */
>      > +        sun4u_tte |= (pgsz & 4ULL) ?
>      > +            TTE_PGSIZE_HI_BIT : 0; /* TTE_PGSIZE bit 48 */
>      > +    }
>      >       sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_NFO_BIT_UA2005, TTE_NFO_BIT);
>      >       sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_USED_BIT_UA2005, TTE_USED_BIT);
>      >       sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_W_OK_BIT_UA2005, TTE_W_OK_BIT);
>      > diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
>      > index 07ba25dfce..8544de097d 100644
>      > --- a/target/sparc/mmu_helper.c
>      > +++ b/target/sparc/mmu_helper.c
>      > @@ -830,6 +830,12 @@ void dump_mmu(CPUSPARCState *env)
>      >               case 0x3:
>      >                   mask = "  4M";
>      >                   break;
>      > +            case 0x4:
>      > +                mask = " 32M";
>      > +                break;
>      > +            case 0x5:
>      > +                mask = "256M";
>      > +                break;
>      >               }
>      >               if (TTE_IS_VALID(env->dtlb[i].tte)) {
>      >                   qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
>      > @@ -869,6 +875,12 @@ void dump_mmu(CPUSPARCState *env)
>      >               case 0x3:
>      >                   mask = "  4M";
>      >                   break;
>      > +            case 0x4:
>      > +                mask = " 32M";
>      > +                break;
>      > +            case 0x5:
>      > +                mask = "256M";
>      > +                break;
>      >               }
>      >               if (TTE_IS_VALID(env->itlb[i].tte)) {
>      >                   qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
> 
>     Hi,
> 
>     I've run this over a few sun4u test images and it doesn't seem to introduce any
>     regressions. I just need to make sure there is no conflict with our AI policy here,
>     otherwise I'll queue it.
> 
> I don't think the AI policy might be relevant for such patches. Probably any human 
> would have done it precisely the same way. At least I'm sure I would.

Yes I believe it would be difficult to implement in another way, however the 
AI-user-for tag indicates it contains AI generated code and our current policy is not 
to accept such contributions: 
https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-content.

There is work underway to update the policy to bring it more in line with Rust and 
the kernel, however this won't be completed in time for the 11.2 release cycle.


ATB,

Mark.


