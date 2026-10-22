Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F76606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=AJVbHqyR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0Rt-0008BR-40; Thu, 22 Oct 2026 17:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0Rq-0008BJ-9O
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:35:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0Ro-0005hs-0g
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=UNH9kpP1MKcyIRwPQhQvNqbIJFZkrETLaX2Tx2H7rEU=; b=AJVbHqyRsj0U6uFct8IBj9hnig
 z7aXUymghSR3N/vO9lsDzJI+URleheReNR4fjDAz28Zz7XktU/t2eirdO6FFZo+m7z8okoaDb2OtZ
 MSY9P9oOFiPmY2jSP4IR5iAiHzgirmKkYrOpx9eYTfhr6OUX2Ot86aGKEgUTpxNtZxPbt8ingFcpA
 wWfAY8M7jtz3gmQ/yjydijj5oNo26L1j1WqfQnxpypMWl+O7piQnN0q9AMA4UKQcReEZmLCjljlV6
 OKiSobdREkIT5IU/nDSVh/4vhUkiONEzL8QMIPBjEY8pUXof0U3BwA1RNeOOulg3DesK/MqNAMVZo
 4mO/P3/EpiaMgZgkFqEt/NgiTxKT8jAvIH/9Fw/U8Eb1W9wB1VTR+XAvcoaoubZIuYQAxXJ/FDV0k
 HtT8drLb7cbWyS8Q+lEx8if6jgDamJffrjETDPSZ7Fx/bP/ppMl+0U2Q8o1FJt7IDQtASxrRFCm91
 KgyQ3goIWQ1M/uUsjXE3vc3BUiEPXnMRHNiG7CR0M+7/VzFbjJVc4ACeiNZIMiy+7nVKmabvcASc8
 szSvetsFf8XNvAEC18UQjk6O8znlHvmcy9XX3cCArFjFcS6aAeFckPrR/svt2CYD1znXCVgyiA5EH
 Td20lp3KyE0OsUXDhT5+aJVd7F9vsinTaD1AJscZU=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xK0R5-003Fql-Dx; Thu, 22 Oct 2026 22:34:56 +0100
Message-ID: <863cd051-1fb7-461f-aa04-64f941200077@ilande.co.uk>
Date: Thu, 22 Oct 2026 22:35:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Imre Kaloz <kaloz@kernel.org>, qemu-devel@nongnu.org
References: <20260928112935.19447-1-kaloz@kernel.org>
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
In-Reply-To: <20260928112935.19447-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/sparc/sun4m: Limit max_mem to what the memory
 controllers decode
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/09/2026 12:29, Imre Kaloz wrote:

> The SS-10, SS-20 and SPARCserver 600MP accept -m up to 60 GiB, and the
> LX, SS-4, SPARCclassic and Voyager accept 256 MiB, more than any of
> these machines could hold. On the SS-10, SS-20 and 600MP, sizes above
> the hardware limit fall into three ranges:
> 
> - Up to 4 GiB, QEMU maps the RAM, but no real machine could hold it.
> - From 4 GiB, the size wraps around in the firmware. QEMU passes it as
>    an 8-byte fw_cfg item, but the sparc32 OpenBIOS reads only its low
>    32 bits, so -m 5120 boots as if it were -m 1024.
> - Above about 56 GiB, the RAM also overlaps the SBus devices, which
>    start at 0xe20000000 (TCX).
> 
> Set each limit from the real hardware:
> 
> - The SS-10 and SS-20 memory controllers (EMC and SMC) decode eight
>    SIMM slots as 64 MiB windows from 29 DRAM address bits, 512 MiB in
>    total (Sun patent EP0571099).
> - The SPARCserver 600MP takes at max 1 GiB, onboard plus expansion
>    boards (SPARCsystem 600MP service manual, 800-5318).
> - The SS-4 takes at most 160 MiB in its five SIMM slots.
> - The LX and SPARCclassic use the microSPARC-I on-chip controller,
>    which decodes four 32 MiB banks, 128 MiB.
> - The Voyager has 16 MiB onboard and two slots for 16 or 32 MiB cards,
>    80 MiB. Its default RAM size becomes 80 MiB, so -M Voyager without
>    -m still starts.
> - The SPARCbook model gets 128 MiB, the decode limit of its
>    microSPARC-I. This keeps QEMU's default -m of 128 MiB working and
>    does not describe a real SPARCbook configuration.
> 
> Machines without ECC map an empty slot so that accesses to missing RAM
> do not fault. It now ends at iommu_base, where memory decode ends on
> those machines, rather than at max_mem.
> 
> Update the maximum memory sizes in docs/system/target-sparc.rst.
> 
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>   docs/system/target-sparc.rst |  6 ++++--
>   hw/sparc/sun4m.c             | 24 ++++++++++++++----------
>   2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
> index 4116cac493..de0acc76dc 100644
> --- a/docs/system/target-sparc.rst
> +++ b/docs/system/target-sparc.rst
> @@ -52,8 +52,10 @@ QEMU emulates the following sun4m peripherals:
>   -  CS4231 sound device (only on SS-5, not working yet)
>   
>   The number of peripherals is fixed in the architecture. Maximum memory
> -size depends on the machine type, for SS-5 it is 256MB and for others
> -2047MB.
> +size depends on the machine type: 512 MiB for the SS-10 and SS-20,
> +256 MiB for the SS-5, 160 MiB for the SS-4, 128 MiB for the LX,
> +SPARCclassic and SPARCbook, 80 MiB for the Voyager, and 1 GiB for the
> +SPARCserver 600MP.
>   
>   Since version 0.8.2, QEMU uses OpenBIOS https://www.openbios.org/.
>   OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 550acdff6d..c586b1c44e 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -840,10 +840,13 @@ static void sun4m_hw_init(MachineState *machine)
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
>   
> -    /* models without ECC don't trap when missing ram is accessed */
> +    /*
> +     * models without ECC don't trap when missing ram is accessed,
> +     * up to the end of memory decode at iommu_base
> +     */
>       if (!hwdef->ecc_base) {
>           empty_slot_init("ecc", machine->ram_size,
> -                        hwdef->max_mem - machine->ram_size);
> +                        hwdef->iommu_base - machine->ram_size);
>       }

It feels like this may be worth a separate commit, just in case there is any 
detectable behaviour change that needs to be bisected.

>       prom_init(hwdef->slavio_base, machine->firmware);
> @@ -1174,7 +1177,7 @@ static void ss10_class_init(ObjectClass *oc, const void *data)
>           .nvram_machine_id = 0x72,
>           .machine_id = ss10_id,
>           .iommu_version = 0x03000000,
> -        .max_mem = 0xf00000000ULL,
> +        .max_mem = 0x20000000, /* 512M: EMC has 29 DRAM address bits */
>       };
>   
>       mc->desc = "Sun4m platform, SPARCstation 10";
> @@ -1207,7 +1210,7 @@ static void ss600mp_class_init(ObjectClass *oc, const void *data)
>           .nvram_machine_id = 0x71,
>           .machine_id = ss600mp_id,
>           .iommu_version = 0x01000000,
> -        .max_mem = 0xf00000000ULL,
> +        .max_mem = 0x40000000, /* 1G: onboard plus expansion boards */
>       };
>   
>       mc->desc = "Sun4m platform, SPARCserver 600MP";
> @@ -1258,7 +1261,7 @@ static void ss20_class_init(ObjectClass *oc, const void *data)
>           .nvram_machine_id = 0x72,
>           .machine_id = ss20_id,
>           .iommu_version = 0x13000000,
> -        .max_mem = 0xf00000000ULL,
> +        .max_mem = 0x20000000, /* 512M: SMC has 29 DRAM address bits */
>       };
>   
>       mc->desc = "Sun4m platform, SPARCstation 20";
> @@ -1291,11 +1294,12 @@ static void voyager_class_init(ObjectClass *oc, const void *data)
>           .nvram_machine_id = 0x80,
>           .machine_id = vger_id,
>           .iommu_version = 0x05000000,
> -        .max_mem = 0x10000000,
> +        .max_mem = 0x05000000, /* 80M: 16M onboard plus two 32M cards */
>       };
>   
>       mc->desc = "Sun4m platform, SPARCstation Voyager";
>       mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
> +    mc->default_ram_size = 80 * MiB;
>       smc->hwdef = &voyager_hwdef;
>   }
>   
> @@ -1324,7 +1328,7 @@ static void ss_lx_class_init(ObjectClass *oc, const void *data)
>           .nvram_machine_id = 0x80,
>           .machine_id = lx_id,
>           .iommu_version = 0x04000000,
> -        .max_mem = 0x10000000,
> +        .max_mem = 0x08000000, /* 128M: microSPARC-I on-chip controller */
>       };
>   
>       mc->desc = "Sun4m platform, SPARCstation LX";
> @@ -1357,7 +1361,7 @@ static void ss4_class_init(ObjectClass *oc, const void *data)
>           .nvram_machine_id = 0x80,
>           .machine_id = ss4_id,
>           .iommu_version = 0x05000000,
> -        .max_mem = 0x10000000,
> +        .max_mem = 0x0a000000, /* 160M: 5 SIMM slots */
>       };
>   
>       mc->desc = "Sun4m platform, SPARCstation 4";
> @@ -1389,7 +1393,7 @@ static void scls_class_init(ObjectClass *oc, const void *data)
>           .nvram_machine_id = 0x80,
>           .machine_id = scls_id,
>           .iommu_version = 0x05000000,
> -        .max_mem = 0x10000000,
> +        .max_mem = 0x08000000, /* 128M: microSPARC-I on-chip controller */
>       };
>   
>       mc->desc = "Sun4m platform, SPARCClassic";
> @@ -1421,7 +1425,7 @@ static void sbook_class_init(ObjectClass *oc, const void *data)
>           .nvram_machine_id = 0x80,
>           .machine_id = sbook_id,
>           .iommu_version = 0x05000000,
> -        .max_mem = 0x10000000,
> +        .max_mem = 0x08000000, /* 128M: microSPARC-I on-chip controller */
>       };
>   
>       mc->desc = "Sun4m platform, SPARCbook";

This looks sensible to me. My only concern is if anyone is (ab)using this feature to 
create super-duper 32-bit SPARC machines that could never exist in real life? Adding 
these lower limits would effectively introduce a migration break, which although 
migration compatibility isn't guaranteed with the SPARC machines, can still be 
inconvenient at times.


ATB,

Mark.


