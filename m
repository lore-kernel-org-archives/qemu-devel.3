Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5872EC0463
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM3x-0002Z2-PS; Tue, 03 Mar 2026 04:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxM3f-0002RC-Rq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:28:55 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vxM3d-0004o6-FS
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772530120; x=1773134920; i=deller@gmx.de;
 bh=qox1J1DiHZXQacI63lHI+uTKJjy5Y1xjZv0QROjqXPk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DgyDvacZqYExoM+dxUQ0MMwam+uk1mWQjLMo/siLCTMb9sKEjZUwWIOtwBrpxU2w
 nW1ab5YjHgTGq0ZLIXhGYpqEq0T2227JJGo/IesUAuSUDuOnzCLr/mfExTFzjcNPD
 Yh87RVbvihozvB6PpeWWHSqGq0R8358XaTTHpuuje9BtoqL37n6+TlYQkztp2nTVE
 9yZHfND/NX1xZ62kpvCfxnOetAmzFDpbTdkWjjL036lgKc46x1QJmVQbJ19NDv0r1
 TVrHitfSW2kx1RMbLuMgmOlRtzaDpr+75aAuyJGF0qwEDuC8Eufm/1xpnr17C9itF
 ehZS+LTQ+rn7jlq3sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXGvG-1wB9Yk07Dy-00J4ki; Tue, 03
 Mar 2026 10:28:40 +0100
Message-ID: <82aa1b68-3504-4276-ba5b-862b7bcbd7bb@gmx.de>
Date: Tue, 3 Mar 2026 10:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] hppa: Get physical address space bits from
 HPPACPUDef
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng>
 <20260302-hppa-c3600-v4-3-447a800da8cc@rev.ng>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260302-hppa-c3600-v4-3-447a800da8cc@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q6Zc7GA+nDikucLISJZMDD+G2XRFhqgVXPNXjqiCD0ogC8BgiiG
 iOkhBV7eQ2L2X4klbmCqSDWN8qEcHVUrYX5xXex/wl6MjhsuRJIPdjSH8uw/pMScZEqNYkI
 qUUy8WA3uesZq4hUUnbgncWHCqeTAiKB6eoQCdvBmGdTL3II6idbfQr1I51IpA27sccJ+6J
 ZRbk857b3NqNGim/4rzFA==
UI-OutboundReport: notjunk:1;M01:P0:GqoR3f4Dg1U=;0hwnrKScdJLqZow0PwGNyK7pymn
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/2/26 12:56, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/cpu.h        | 11 ++++++++---
>   hw/hppa/machine.c        |  4 ++--
>   hw/pci-host/astro.c      |  2 +-
>   target/hppa/mem_helper.c | 40 ++++++++++++----------------------------
>   4 files changed, 23 insertions(+), 34 deletions(-)
>=20
>...
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 9199d1e06a..4bd806a53f 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -29,29 +29,12 @@
>   #include "hw/core/cpu.h"
>   #include "trace.h"
>  =20
> -/*
> - * 64-bit (PA-RISC 2.0) machines are assumed to run PA-8700, and 32-bit
> - * machines 7300LC.  This should give 44 and 32 bits of physical addres=
s
> - * space respectively.
> - *
> - *   CPU model        Physical address space bits
> - *   PA-7000--7300LC  32
> - *   PA-8000--8600    40
> - *   PA-8700--8900    44
> - *
> - * FIXME: However, the SeaBIOS firmware that is that tested against
> - * uses 40-bit physical addresses, despite supposedly running a C3700
> - * with a PA-8700 cpu, so use 40-bits for 64-bit.
> - */
> -#define HPPA_PHYS_ADDR_SPACE_BITS_PA20 40
> -#define HPPA_PHYS_ADDR_SPACE_BITS_PA1X 32
> -
> -hwaddr hppa_abs_to_phys_pa1x(vaddr addr)
> +hwaddr hppa_abs_to_phys_pa1x(CPUHPPAState *env, vaddr addr)
>   {
> -    return extract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA1X);
> +    return extract64(addr, 0, hppa_phys_addr_bits(env));
>   }
>  =20
> -hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
> +hwaddr hppa_abs_to_phys_pa2_w1(CPUHPPAState *env, vaddr addr)
>   {
>       /*
>        * Figure H-8 "62-bit Absolute Accesses when PSW W-bit is 1" descr=
ibes
> @@ -64,11 +47,12 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
>        * Since the supported physical address space is below 54 bits, th=
e
>        * H-8 algorithm is moot and all that is left is to truncate.
>        */
> -    QEMU_BUILD_BUG_ON(HPPA_PHYS_ADDR_SPACE_BITS_PA20 > 54);
> -    return sextract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
> +    const uint8_t pa =3D hppa_phys_addr_bits(env);
> +    g_assert(pa <=3D 54);

This g_assert() is now a runtime check which adds cycles for every hppa_ab=
s_to_phys_pa2_w1() call,
while the previous QEMU_BUILD_BUG_ON() was a cheap compile-time check.
Can we change it, or simply drop it, because hppa_phys_addr_bits() anyways=
 return a constant?

Other than that:
Reviewed-by: Helge Deller <deller@gmx.de>


