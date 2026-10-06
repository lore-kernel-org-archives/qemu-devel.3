Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED35ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN1r-0000rC-Hs; Wed, 07 Oct 2026 04:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHnb-0006fT-5X
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:54:43 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHnJ-00054Y-Ui
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:54:21 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 193C21D00055
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 10:12:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 06 Oct 2026 10:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791295968; x=1791382368; bh=Ku+FShd97Z8GIdc6H4jX9T0ge6Ksa+NO
 IljxqbfRl2c=; b=L5hx/c9mTFxzhpDnhuLSvqP04V/fRzJnDmkvHLY3SLDC2gZK
 UUlJ4gscHyfBG/De1ORSh4kN239rVbazgACvUU84kOKzaEmfd/LklYkqajBkXEXR
 n0TNKak8lWzdMkawrckbM7quz3CgmKRyqKtNY69GPrg0xLDD/MqSDuoowfwSHuvB
 8diAS3z4tYLsuTr3cbKfL72nM+oTYwKcz7wRRbVjiwALvrvzBQQvxEOfTztK0Kqk
 zmHaWmq9daI+yuhlCBmgmv/sNNzOZRACSWqFUHeoyRoc6IUqRJT9qtyz6JpPRNqG
 EpBncU2zI1UMBZHSgJoHNrCLVORV3FaBZJz0Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791295968; x=
 1791382368; bh=Ku+FShd97Z8GIdc6H4jX9T0ge6Ksa+NOIljxqbfRl2c=; b=R
 CiFrXpJ9vH7iTNnbKni8LxTWOLscKkMQie8FQFoODIAEjNmcRbYFtPu+x/i76ALA
 dKyLhl74TrVPWliODGaB9e/JgywUV6vXSig4GVnv/WVX2pIicjmSChyHnwxhodIg
 v0Ka1OG3voWPEhakWjDAkm65lXLhWHHE/ryZPsnvrX0WYoImq1a8q9UqcAfPmWcc
 POzFdf8wHfUaPNBGwFqc+cheM4iL4ZuIIkrKqyC4BXw82oWJuw+YUZgwZyAU1f15
 8XGOAFuCJtNZllMnUfXYIy/9RSHlBQtB+Z22X1BEaoDF6Fd1NKkoBSquKaYO9PG4
 ST26ctJ2KJcpX+GchKGmQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791295968; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:GK3QJyEyEPhlCQKKvlS/iPBmOuVXZSjPgkm4h4X1u3eeLb+
 0FcF1ZrHA6sIISOhFTsVJJh8Zlo4EkWsrKfGJX8PwYLsfNWx7j2MH1A4lJOorUCt
 hLIbumtWN2ysseBtkoledelWDeMcgcLQ8rgDKFNJKIdD867rG5oC7+lAaLbW4Qdy
 V3xIjr/LNWHLt2eCiCqvMa6Jdifa8HoEsQfhCtaes6HlrVkKgEXR+GhNPjJKG19b
 x6E5szqob+3c9FKacb7zx0WokPFNtv0fJgeL/ntY1oXCVBvEiUV78NCMsCaviXr3
 79BCFiXRBBA3S4Zgi0N/2G0g/RHcNkpfR/ur9/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:qclJibrKl5LTi9MNY1/I06MpmGBFwzy4VU/AWqEOYvI=:Ku+FShd97Z8GIdc6H4jX9T0ge6Ksa+NOIljxqbfRl2c=;
X-ME-Sender: <xms:3wHFalHXXfl_jpvgI6zWpsQe4Bke-hM7-Q7adohDUYAK5drJAmXh2g>
 <xme:3wHFapyXelRs8B9BjdGR9NTmEStUdtrzfwD0WnzZGZMj5KXdsu_C5KVh5g3_fRQ8Z
 56JgWWkvNT-Bxi77vqCDo1DK9qvC9AbtVoVh2hYwP6DputlWpH5dm4U>
X-ME-Received: <xmr:3wHFaoO6Y7xhA0fIZE32-uUX7SKvsV0OQVX3wiMfWf2lpkU8CukjYAfWaxYQ5KsC2WT9-DGHMgFz>
X-ME-Proxy-Cause: dmFkZTFxqHYTKRl/L7pWp0NwajphLbAf6X8Q98mv4H/w2zetb58HZQiAfH3fvMjzU71VwK
 /69V4vIpaQ23VucguPwcWHew+aDFzqddPZfxDk/G4cLCck6M0O1D7VwemDfpC/QBpXmseK
 RAe3+C0DLpKATIzQ/G5WpjJdOrT8fqsYuObKw5HTbY4LEkltAkLt7jEyQTePRkQOpXmH/g
 DcnGFE+XyyyXzZMYd35hQmfkUZMdop7RpzmW70f7EXF7EJeGj+uHzqGW+Dx/llGQsG2bAd
 pE3gII90zVTRLKsY63fGF3Fu4q15xJMiPcYc7mdFHsMnGu/1sm3k7LRPUrpoKpgAg/4aKj
 Xa65y3XS4AL9p2Rp1Kz4Wsf3UNZOsBclkx8tS1tKHmvDy8feLlVTovfJXo124b+w74OUQ9
 iLNuqeaFqRVnWf5QJkaP7fWf67WK0Ift167yMjfK0IEKiVBzMsNUyiazl1qETh9LRYZ0Dg
 79RSucc6aru4LgeKuOLWuBAakGiMu0BJD8Qq7aVpKjfqywzLA9HPrVXqe2q+7qtWU+lZhk
 KRxQyGZxqDV90TBx/FkdsGCzk31msh+reeiQMxwiuU0cVtLm4VDS2Y5WmzugTJhmMu33/v
 RPs/fyQLJbA6WIcM+KOrEX4D39cveHiilRlg1C4PsyIUANHpKr9kIkdV9zDw
X-ME-Proxy: <xmx:3wHFavaOdo7SkKmL3a3kDnI3cgRjVNL54O3OEJI9iLy0ltXo93AXIw>
 <xmx:3wHFavBSl6xFOPLnh5ZP-N6gdGahOK1Ofnd-rY5ZHU2R-9Ot7tRqNw>
 <xmx:3wHFatG_w1xT26VUpzmilaqGKrla5q126aPu28I7ZZb_-kNOr5SyIg>
 <xmx:3wHFaqN8BYv2K6Xkza-W0bF_x8wNum4zneAwEU1NcUl0Rk5jwKhlEQ>
 <xmx:4AHFaikqW59tXxWgqnBXsbUrjWrOXnMx3h8qNctZbaymPhst3nb5vWiu>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 10:12:37 -0400 (EDT)
Message-ID: <d411823f4237d390e83cb7208ddba79d2babfa16.camel@alistair23.me>
Subject: Re: [PATCH v4 1/3] hw/misc: Add Tenstorrent Atlantis PRCM model
From: Alistair <alistair@alistair23.me>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman	 <mpe@kernel.org>, Portia Stephens
 <portias@oss.tenstorrent.com>, 	qemu-riscv@nongnu.org, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu	 <chao.liu@processmission.com>
Date: Wed, 07 Oct 2026 00:12:32 +1000
In-Reply-To: <20261001-atlantis_prcm-v4-1-95d33c470eeb@oss.tenstorrent.com>
References: <20261001-atlantis_prcm-v4-0-95d33c470eeb@oss.tenstorrent.com>
 <20261001-atlantis_prcm-v4-1-95d33c470eeb@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.146;
 envelope-from=alistair@alistair23.me; helo=fout-b3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thu, 2026-10-01 at 08:52 -0500, Anirudh Srinivasan wrote:
> This device present in Tenstorrent Atlantis has registers that
> control
> clocks, reset and other misc functionality in the SoC. This commit
> adds
> models for the RCPU, HSIO, PCIE, MM and 2 DDR PRCMs.
>=20
> Co-developed-by: Portia Stephens <portias@oss.tenstorrent.com>
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0hw/misc/meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0hw/misc/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0hw/misc/tt_atlantis_prcm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 428
> +++++++++++++++++++++++++++++++++++++
> =C2=A0include/hw/misc/tt_atlantis_prcm.h |=C2=A0 51 +++++
> =C2=A05 files changed, 486 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f524d90523..b6cc077602 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1830,7 +1830,9 @@ R: Portia Stephens
> <portias@oss.tenstorrent.com>
> =C2=A0L: qemu-riscv@nongnu.org
> =C2=A0S: Supported
> =C2=A0F: docs/system/riscv/tt_*.rst
> +F: hw/misc/tt_*.c
> =C2=A0F: hw/riscv/tt_*.c
> +F: include/hw/misc/tt_*.h
> =C2=A0F: include/hw/riscv/tt_*.h
> =C2=A0F: tests/functional/riscv64/test_tt_*.py
> =C2=A0
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 54e07aacda..11b9593e03 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -39,6 +39,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true:
> files('sifive_e_aon.c'))
> =C2=A0system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true:
> files('sifive_u_otp.c'))
> =C2=A0system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true:
> files('sifive_u_prci.c'))
> =C2=A0system_ss.add(when: 'CONFIG_K230_DECOMP_GZIP', if_true:
> files('k230_decomp_gzip.c'))
> +system_ss.add(when: 'CONFIG_TENSTORRENT', if_true:
> files('tt_atlantis_prcm.c'))
> =C2=A0
> =C2=A0subdir('macio')
> =C2=A0
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 0b8be3d0f2..8b80b71107 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -452,3 +452,7 @@ launch_update_write(void) ""
> =C2=A0vmlaunch_reset_enter(void) ""
> =C2=A0vm_launchupdate_finalize(void) ""
> =C2=A0restore_host_x86_igvm(void) ""
> +
> +# tt_atlantis_prcm.c
> +tt_atlantis_prcm_read(uint32_t domain, uint64_t offset, uint64_t
> data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> +tt_atlantis_prcm_write(uint32_t domain, uint64_t offset, uint64_t
> data) "domain 0x%02x offset 0x%" PRIx64 " data 0x%" PRIx64
> diff --git a/hw/misc/tt_atlantis_prcm.c b/hw/misc/tt_atlantis_prcm.c
> new file mode 100644
> index 0000000000..31caca08fc
> --- /dev/null
> +++ b/hw/misc/tt_atlantis_prcm.c
> @@ -0,0 +1,428 @@
> +/*
> + * PRCM (Clock and Reset Controller) in Tenstorrent Atlantis SoC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2026 Tenstorrent
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "hw/misc/tt_atlantis_prcm.h"
> +#include "trace.h"
> +
> +#define TO_REG(offset) ((offset) >> 2)
> +
> +#define PLL_LOCK_BIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 31
> +#define PLL_FBDIV_LSB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14
> +#define PLL_POSTDIV2_LSB=C2=A0=C2=A0=C2=A0 11
> +#define PLL_POSTDIV1_LSB=C2=A0=C2=A0=C2=A0 8
> +#define PLL_REFDIV_LSB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
> +#define PLL_BYPASS_BIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
> +
> +#define PLL_RESET_VAL(BYPASS, REFDIV, POSTDIV1, POSTDIV2, FBDIV,
> LOCK)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0 ((LOCK << PLL_LOCK_BIT) | (FBDIV << PLL_FBDIV_LSB)
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0 (POSTDIV2 << PLL_POSTDIV2_LSB) | (POSTDIV1 << PLL_POSTDIV1_=
LSB)
> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> +=C2=A0=C2=A0 (REFDIV << PLL_REFDIV_LSB) | (BYPASS << PLL_BYPASS_BIT))
> +
> +#define RCPU_PLL_RCPU_CFG=C2=A0=C2=A0 TO_REG(0x000)
> +#define RCPU_PLL_NOCC_CFG=C2=A0=C2=A0 TO_REG(0x004)
> +#define RCPU_NOCC_CLK_CFG=C2=A0=C2=A0 TO_REG(0x008)
> +#define RCPU_RCPU_DIV_CFG=C2=A0=C2=A0 TO_REG(0x00c)
> +#define RCPU_RCPU_BLK_CG=C2=A0=C2=A0=C2=A0 TO_REG(0x014)
> +#define RCPU_LSIO_BLK_CG=C2=A0=C2=A0=C2=A0 TO_REG(0x018)
> +#define RCPU_RCPU_BLK_RST=C2=A0=C2=A0 TO_REG(0x01c)
> +#define RCPU_LSIO_BLK_RST=C2=A0=C2=A0 TO_REG(0x020)
> +#define RCPU_PLL_RCPU_EN=C2=A0=C2=A0=C2=A0 TO_REG(0x11c)
> +#define RCPU_PLL_NOCC_EN=C2=A0=C2=A0=C2=A0 TO_REG(0x120)
> +#define RCPU_PLL_MM_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TO_REG(0x124)
> +#define RCPU_PLL1_MM_EN=C2=A0=C2=A0=C2=A0=C2=A0 TO_REG(0x128)
> +#define RCPU_PLL_HSIO_EN=C2=A0=C2=A0=C2=A0 TO_REG(0x12c)
> +#define RCPU_PLL_PCIE_EN=C2=A0=C2=A0=C2=A0 TO_REG(0x138)
> +#define RCPU_PLL_I2S_EN=C2=A0=C2=A0=C2=A0=C2=A0 TO_REG(0x13c)
> +#define RCPU_PLL_MM_CFG=C2=A0=C2=A0=C2=A0=C2=A0 TO_REG(0x19c)
> +#define RCPU_PLL_HSIO_CFG=C2=A0=C2=A0 TO_REG(0x1a0)
> +#define RCPU_PLL_PCIE_CFG=C2=A0=C2=A0 TO_REG(0x1ac)
> +#define RCPU_BOOT_MODE_CFG=C2=A0 TO_REG(0x1b0)
> +#define RCPU_PLL_I2S_CFG=C2=A0=C2=A0=C2=A0 TO_REG(0x1f4)
> +#define RCPU_I2S_DIV_CFG=C2=A0=C2=A0=C2=A0 TO_REG(0x1f8)
> +#define RCPU_BUS_CFG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TO_REG(0x=
1fc)
> +#define RCPU_PLL1_MM_CFG=C2=A0=C2=A0=C2=A0 TO_REG(0x2a4)
> +
> +#define HSIO_HSIO_DIV_CFG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TO_REG(0x0=
0)
> +#define HSIO_HSIO_DIV_CFG1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TO_REG(0x04)
> +#define HSIO_HSIO_BLK_CG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TO_RE=
G(0x08)
> +#define HSIO_HSIO_BLK_RST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TO_REG(0x0=
c)
> +#define HSIO_HSIO_GMAC_DIV_CFG=C2=A0 TO_REG(0x10)
> +
> +#define PCIE_SUBS_RST_CTL=C2=A0=C2=A0 TO_REG(0x0)
> +#define PCIE_SUBS_CG_CTL=C2=A0=C2=A0=C2=A0 TO_REG(0x4)
> +#define PCIE_SUBS_CK_CTL=C2=A0=C2=A0=C2=A0 TO_REG(0x8)
> +
> +#define MM_MM_CLK_GATE_CFG=C2=A0 TO_REG(0x008)
> +#define MM_MM_CLK_DIV_CFG=C2=A0=C2=A0 TO_REG(0x00c)
> +#define MM_MM_CLK_SEL_CFG=C2=A0=C2=A0 TO_REG(0x010)
> +#define MM_MM_RSTN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 TO_REG(0x014)
> +#define MM_MM_CLK_DIV_CFG1=C2=A0 TO_REG(0x130)
> +
> +#define DDRC_STAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 TO_REG(0x10014)
> +#define DDRC_DFISTAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TO_REG(0x=
10514)
> +#define DDRC_SWSTAT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TO_R=
EG(0x10c84)
> +
> +#define PLL_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(0)
> +#define RCPU_PLL_BUS_CG_EN=C2=A0 BIT(7)
> +#define HSIO_PLL_BUS_CG_EN=C2=A0 BIT(3)
> +#define PCIE_PLL_BUS_CG_EN=C2=A0 BIT(1)
> +#define NOCC_PLL_BUS_CG_EN=C2=A0 BIT(0)
> +
> +#define RCPU_BOOT_MODE_UART=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0 << 4)
> +#define RCPU_BOOT_MODE_NOR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x1 << 4=
)
> +#define RCPU_BOOT_MODE_SD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x2=
 << 4)
> +
> +#define RCPU_DOMAIN_SIZE=C2=A0=C2=A0 0x10000
> +#define HSIO_DOMAIN_SIZE=C2=A0=C2=A0 0x510
> +#define PCIE_DOMAIN_SIZE=C2=A0=C2=A0 0x100
> +#define MM_DOMAIN_SIZE=C2=A0=C2=A0=C2=A0=C2=A0 0x1000
> +#define DDRC0_DOMAIN_SIZE=C2=A0 0x101000
> +#define DDRC1_DOMAIN_SIZE=C2=A0 0x101000
> +
> +static uint64_t tt_atlantis_prcm_read(void *opaque, hwaddr offset,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 unsigned size)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS=
(s);
> +=C2=A0=C2=A0=C2=A0 uint32_t data;
> +
> +=C2=A0=C2=A0=C2=A0 if (offset >=3D c->regs_size) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_GUEST_ERROR=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: Out-of-bounds r=
ead at offset 0x%"
> HWADDR_PRIx "\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, offset);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 data =3D s->regs[TO_REG(offset)];
> +
> +=C2=A0=C2=A0=C2=A0 trace_tt_atlantis_prcm_read(c->domain, offset, data);
> +=C2=A0=C2=A0=C2=A0 return data;
> +}
> +
> +static void tt_atlantis_prcm_write(void *opaque, hwaddr offset,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t data, un=
signed size)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS=
(s);
> +
> +=C2=A0=C2=A0=C2=A0 if (offset >=3D c->regs_size) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_GUEST_ERROR=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: Out-of-bounds w=
rite at offset 0x%"
> HWADDR_PRIx "\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, offset);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 trace_tt_atlantis_prcm_write(c->domain, offset, data)=
;
> +
> +=C2=A0=C2=A0=C2=A0 s->regs[TO_REG(offset)] =3D data;
> +}
> +
> +static void tt_atlantis_prcm_rcpu_write(void *opaque, hwaddr offset,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 uint64_t data, unsigned
> size)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(opaque);
> +=C2=A0=C2=A0=C2=A0 uint32_t pll_reg_offset;
> +
> +=C2=A0=C2=A0=C2=A0 tt_atlantis_prcm_write(opaque, offset, data, size);
> +
> +=C2=A0=C2=A0=C2=A0 switch (TO_REG(offset)) {
> +=C2=A0=C2=A0=C2=A0 case RCPU_PLL_RCPU_EN:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pll_reg_offset =3D RCPU_PLL_R=
CPU_CFG;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case RCPU_PLL_NOCC_EN:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pll_reg_offset =3D RCPU_PLL_N=
OCC_CFG;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case RCPU_PLL_HSIO_EN:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pll_reg_offset =3D RCPU_PLL_H=
SIO_CFG;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case RCPU_PLL_PCIE_EN:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pll_reg_offset =3D RCPU_PLL_P=
CIE_CFG;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case RCPU_PLL_MM_EN:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pll_reg_offset =3D RCPU_PLL_M=
M_CFG;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case RCPU_PLL1_MM_EN:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pll_reg_offset =3D RCPU_PLL1_=
MM_CFG;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case RCPU_PLL_I2S_EN:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pll_reg_offset =3D RCPU_PLL_I=
2S_CFG;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 default:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 if (data & PLL_EN) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[pll_reg_offset] |=3D =
BIT(PLL_LOCK_BIT);
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs[pll_reg_offset] &=3D =
~BIT(PLL_LOCK_BIT);
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +static const MemoryRegionOps tt_atlantis_prcm_ops =3D {
> +=C2=A0=C2=A0=C2=A0 .read =3D tt_atlantis_prcm_read,
> +=C2=A0=C2=A0=C2=A0 .write =3D tt_atlantis_prcm_write,
> +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> +=C2=A0=C2=A0=C2=A0 .valid.min_access_size =3D 1,
> +=C2=A0=C2=A0=C2=A0 .valid.max_access_size =3D 4,
> +};
> +
> +static const MemoryRegionOps tt_atlantis_prcm_rcpu_ops =3D {
> +=C2=A0=C2=A0=C2=A0 .read =3D tt_atlantis_prcm_read,
> +=C2=A0=C2=A0=C2=A0 .write =3D tt_atlantis_prcm_rcpu_write,
> +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
> +=C2=A0=C2=A0=C2=A0 .valid.min_access_size =3D 1,
> +=C2=A0=C2=A0=C2=A0 .valid.max_access_size =3D 4,
> +};
> +
> +static void tt_atlantis_prcm_realize(DeviceState *dev, Error **errp)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> +=C2=A0=C2=A0=C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS=
(s);
> +
> +=C2=A0=C2=A0=C2=A0 assert(c->domain < TT_ATLANTIS_PRCM_DOMAIN_COUNT);
> +
> +=C2=A0=C2=A0=C2=A0 s->regs =3D g_new0(uint32_t, TO_REG(c->regs_size));
> +
> +=C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, OBJECT(s), c->ops, s,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 TYPE_TT_ATLANTIS_PRCM, c->regs_size);
> +=C2=A0=C2=A0=C2=A0 sysbus_init_mmio(sbd, &s->mmio);
> +}
> +
> +static void tt_atlantis_prcm_reset_hold(Object *obj, ResetType type)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_GET_CLASS=
(s);
> +
> +=C2=A0=C2=A0=C2=A0 memset(s->regs, 0, c->regs_size);
> +}
> +
> +static void tt_atlantis_prcm_rcpu_reset_hold(Object *obj, ResetType
> type)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> +=C2=A0=C2=A0=C2=A0 tt_atlantis_prcm_reset_hold(obj, type);
> +
> +=C2=A0=C2=A0=C2=A0 /* Reset values come from Datasheet */
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_RCPU_CFG] =3D PLL_RESET_VAL(1, 0, 4,=
 0, 100, 1);
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_NOCC_CFG] =3D PLL_RESET_VAL(0, 2, 2,=
 2, 267, 1);
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_NOCC_CLK_CFG] =3D (0x25f31 << 1) | BIT(0=
);
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_RCPU_DIV_CFG] =3D (0xb8c2 << 1);
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_RCPU_BLK_CG] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_LSIO_BLK_CG] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_RCPU_BLK_RST] =3D 0xffffffff;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_LSIO_BLK_RST] =3D 0xffffffff;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_RCPU_EN] =3D PLL_EN;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_NOCC_EN] =3D PLL_EN;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_HSIO_EN] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_MM_EN] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL1_MM_EN] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_I2S_EN] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_PCIE_EN] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_HSIO_CFG] =3D PLL_RESET_VAL(0, 1, 2,=
 1, 50, 0);
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_PCIE_CFG] =3D PLL_RESET_VAL(0, 2, 3,=
 1, 250, 0);
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_BOOT_MODE_CFG] =3D RCPU_BOOT_MODE_SD;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_MM_CFG] =3D PLL_RESET_VAL(0, 1, 2, 1=
, 50, 1);
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL1_MM_CFG] =3D PLL_RESET_VAL(0, 1, 2, =
1, 50, 1);
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_PLL_I2S_CFG] =3D PLL_RESET_VAL(0, 1, 6, =
6, 33, 0);
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_I2S_DIV_CFG] =3D 0xde69ad31;
> +=C2=A0=C2=A0=C2=A0 s->regs[RCPU_BUS_CFG] =3D NOCC_PLL_BUS_CG_EN | HSIO_P=
LL_BUS_CG_EN;
> +}
> +
> +static void tt_atlantis_prcm_ddrc_reset_hold(Object *obj, ResetType
> type)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> +=C2=A0=C2=A0=C2=A0 tt_atlantis_prcm_reset_hold(obj, type);
> +
> +=C2=A0=C2=A0=C2=A0 /* Reset values come from Datasheet */
> +=C2=A0=C2=A0=C2=A0 s->regs[DDRC_STAT] =3D 0x1;
> +=C2=A0=C2=A0=C2=A0 s->regs[DDRC_DFISTAT] =3D 0x1;
> +=C2=A0=C2=A0=C2=A0 s->regs[DDRC_SWSTAT] =3D 0x1;
> +}
> +
> +static void tt_atlantis_prcm_hsio_reset_hold(Object *obj, ResetType
> type)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> +=C2=A0=C2=A0=C2=A0 tt_atlantis_prcm_reset_hold(obj, type);
> +
> +=C2=A0=C2=A0=C2=A0 /* Reset values come from Datasheet */
> +=C2=A0=C2=A0=C2=A0 s->regs[HSIO_HSIO_DIV_CFG] =3D 0x20821731;
> +=C2=A0=C2=A0=C2=A0 s->regs[HSIO_HSIO_DIV_CFG1] =3D 0x8;
> +=C2=A0=C2=A0=C2=A0 s->regs[HSIO_HSIO_BLK_CG] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[HSIO_HSIO_BLK_RST] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[HSIO_HSIO_GMAC_DIV_CFG] =3D 0;
> +}
> +
> +static void tt_atlantis_prcm_pcie_reset_hold(Object *obj, ResetType
> type)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> +=C2=A0=C2=A0=C2=A0 tt_atlantis_prcm_reset_hold(obj, type);
> +
> +=C2=A0=C2=A0=C2=A0 /* Reset values come from Datasheet */
> +=C2=A0=C2=A0=C2=A0 s->regs[PCIE_SUBS_RST_CTL] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[PCIE_SUBS_CG_CTL] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[PCIE_SUBS_CK_CTL] =3D 0x44908;
> +}
> +
> +static void tt_atlantis_prcm_mm_reset_hold(Object *obj, ResetType
> type)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(obj);
> +=C2=A0=C2=A0=C2=A0 tt_atlantis_prcm_reset_hold(obj, type);
> +
> +=C2=A0=C2=A0=C2=A0 /* Reset values come from Datasheet */
> +=C2=A0=C2=A0=C2=A0 s->regs[MM_MM_CLK_GATE_CFG] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[MM_MM_CLK_DIV_CFG] =3D 0xddc8312;
> +=C2=A0=C2=A0=C2=A0 s->regs[MM_MM_CLK_SEL_CFG] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[MM_MM_RSTN] =3D 0;
> +=C2=A0=C2=A0=C2=A0 s->regs[MM_MM_CLK_DIV_CFG1] =3D 0x333;
> +}
> +
> +static void tt_atlantis_prcm_unrealize(DeviceState *dev)
> +{
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMState *s =3D TT_ATLANTIS_PRCM(dev);
> +
> +=C2=A0=C2=A0=C2=A0 g_free(s->regs);
> +}
> +
> +static void tt_atlantis_prcm_class_init(ObjectClass *klass,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const void *data)
> +{
> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(kla=
ss);
> +
> +=C2=A0=C2=A0=C2=A0 dc->realize =3D tt_atlantis_prcm_realize;
> +=C2=A0=C2=A0=C2=A0 dc->unrealize =3D tt_atlantis_prcm_unrealize;
> +=C2=A0=C2=A0=C2=A0 dc->desc =3D "Tenstorrent Atlantis PRCM Controller";
> +=C2=A0=C2=A0=C2=A0 rc->phases.hold =3D tt_atlantis_prcm_reset_hold;
> +=C2=A0=C2=A0=C2=A0 c->ops =3D &tt_atlantis_prcm_ops;
> +}
> +
> +static void tt_atlantis_prcm_rcpu_class_init(ObjectClass *klass,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *data)
> +{
> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(kla=
ss);
> +
> +=C2=A0=C2=A0=C2=A0 dc->desc =3D "Tenstorrent Atlantis RCPU PRCM Controll=
er";
> +=C2=A0=C2=A0=C2=A0 rc->phases.hold =3D tt_atlantis_prcm_rcpu_reset_hold;
> +=C2=A0=C2=A0=C2=A0 c->domain =3D TT_ATLANTIS_PRCM_DOMAIN_RCPU;
> +=C2=A0=C2=A0=C2=A0 c->regs_size =3D RCPU_DOMAIN_SIZE;
> +=C2=A0=C2=A0=C2=A0 c->ops =3D &tt_atlantis_prcm_rcpu_ops;
> +}
> +
> +static void tt_atlantis_prcm_hsio_class_init(ObjectClass *klass,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *data)
> +{
> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(kla=
ss);
> +
> +=C2=A0=C2=A0=C2=A0 dc->desc =3D "Tenstorrent Atlantis HSIO PRCM Controll=
er";
> +=C2=A0=C2=A0=C2=A0 rc->phases.hold =3D tt_atlantis_prcm_hsio_reset_hold;
> +=C2=A0=C2=A0=C2=A0 c->domain =3D TT_ATLANTIS_PRCM_DOMAIN_HSIO;
> +=C2=A0=C2=A0=C2=A0 c->regs_size =3D HSIO_DOMAIN_SIZE;
> +}
> +
> +static void tt_atlantis_prcm_pcie_class_init(ObjectClass *klass,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *data)
> +{
> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(kla=
ss);
> +
> +=C2=A0=C2=A0=C2=A0 dc->desc =3D "Tenstorrent Atlantis PCIE PRCM Controll=
er";
> +=C2=A0=C2=A0=C2=A0 rc->phases.hold =3D tt_atlantis_prcm_pcie_reset_hold;
> +=C2=A0=C2=A0=C2=A0 c->domain =3D TT_ATLANTIS_PRCM_DOMAIN_PCIE;
> +=C2=A0=C2=A0=C2=A0 c->regs_size =3D PCIE_DOMAIN_SIZE;
> +}
> +
> +static void tt_atlantis_prcm_mm_class_init(ObjectClass *klass,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *data)
> +{
> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(kla=
ss);
> +
> +=C2=A0=C2=A0=C2=A0 dc->desc =3D "Tenstorrent Atlantis MM PRCM Controller=
";
> +=C2=A0=C2=A0=C2=A0 rc->phases.hold =3D tt_atlantis_prcm_mm_reset_hold;
> +=C2=A0=C2=A0=C2=A0 c->domain =3D TT_ATLANTIS_PRCM_DOMAIN_MM;
> +=C2=A0=C2=A0=C2=A0 c->regs_size =3D MM_DOMAIN_SIZE;
> +}
> +
> +static void tt_atlantis_prcm_ddrc0_class_init(ObjectClass *klass,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *data)
> +{
> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(kla=
ss);
> +
> +=C2=A0=C2=A0=C2=A0 dc->desc =3D "Tenstorrent Atlantis DDR Memory Control=
ler 0 PRCM";
> +=C2=A0=C2=A0=C2=A0 rc->phases.hold =3D tt_atlantis_prcm_ddrc_reset_hold;
> +=C2=A0=C2=A0=C2=A0 c->domain =3D TT_ATLANTIS_PRCM_DOMAIN_DDRC0;
> +=C2=A0=C2=A0=C2=A0 c->regs_size =3D DDRC0_DOMAIN_SIZE;
> +}
> +
> +static void tt_atlantis_prcm_ddrc1_class_init(ObjectClass *klass,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const void *data)
> +{
> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +=C2=A0=C2=A0=C2=A0 TTAtlantisPRCMClass *c =3D TT_ATLANTIS_PRCM_CLASS(kla=
ss);
> +
> +=C2=A0=C2=A0=C2=A0 dc->desc =3D "Tenstorrent Atlantis DDR Memory Control=
ler 1 PRCM";
> +=C2=A0=C2=A0=C2=A0 rc->phases.hold =3D tt_atlantis_prcm_ddrc_reset_hold;
> +=C2=A0=C2=A0=C2=A0 c->domain =3D TT_ATLANTIS_PRCM_DOMAIN_DDRC1;
> +=C2=A0=C2=A0=C2=A0 c->regs_size =3D DDRC1_DOMAIN_SIZE;
> +}
> +
> +static const TypeInfo tt_atlantis_prcm_types[] =3D {
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TT_ATLANTIS_PR=
CM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_SYS_BUS_DEVI=
CE,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(TTA=
tlantisPRCMState),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init =3D tt_atlantis_p=
rcm_class_init,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_size =3D sizeof(TTAtla=
ntisPRCMClass),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .abstract =3D true,
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TT_ATLANTIS_PR=
CM_RCPU,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_TT_ATLANTIS_=
PRCM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init =3D tt_atlantis_p=
rcm_rcpu_class_init,
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TT_ATLANTIS_PR=
CM_HSIO,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_TT_ATLANTIS_=
PRCM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init =3D tt_atlantis_p=
rcm_hsio_class_init,
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TT_ATLANTIS_PR=
CM_PCIE,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_TT_ATLANTIS_=
PRCM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init =3D tt_atlantis_p=
rcm_pcie_class_init,
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TT_ATLANTIS_PR=
CM_MM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_TT_ATLANTIS_=
PRCM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init =3D tt_atlantis_p=
rcm_mm_class_init,
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TT_ATLANTIS_PR=
CM_DDRC0,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_TT_ATLANTIS_=
PRCM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init =3D tt_atlantis_p=
rcm_ddrc0_class_init,
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TT_ATLANTIS_PR=
CM_DDRC1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_TT_ATLANTIS_=
PRCM,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init =3D tt_atlantis_p=
rcm_ddrc1_class_init,
> +=C2=A0=C2=A0=C2=A0 },
> +};
> +
> +DEFINE_TYPES(tt_atlantis_prcm_types);
> diff --git a/include/hw/misc/tt_atlantis_prcm.h
> b/include/hw/misc/tt_atlantis_prcm.h
> new file mode 100644
> index 0000000000..4b72618346
> --- /dev/null
> +++ b/include/hw/misc/tt_atlantis_prcm.h
> @@ -0,0 +1,51 @@
> +/*
> + * PRCM (Clock and Reset Controller) in Tenstorrent Atlantis SoC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright 2026 Tenstorrent
> + */
> +
> +#ifndef TT_ATLANTIS_PRCM_H
> +#define TT_ATLANTIS_PRCM_H
> +
> +#include "hw/core/sysbus.h"
> +
> +#define TYPE_TT_ATLANTIS_PRCM "tt.atlantis.prcm"
> +#define TYPE_TT_ATLANTIS_PRCM_RCPU "tt.atlantis.prcm.rcpu"
> +#define TYPE_TT_ATLANTIS_PRCM_HSIO "tt.atlantis.prcm.hsio"
> +#define TYPE_TT_ATLANTIS_PRCM_PCIE "tt.atlantis.prcm.pcie"
> +#define TYPE_TT_ATLANTIS_PRCM_MM "tt.atlantis.prcm.mm"
> +#define TYPE_TT_ATLANTIS_PRCM_DDRC0 "tt.atlantis.prcm.ddrc0"
> +#define TYPE_TT_ATLANTIS_PRCM_DDRC1 "tt.atlantis.prcm.ddrc1"
> +OBJECT_DECLARE_TYPE(TTAtlantisPRCMState, TTAtlantisPRCMClass,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TT_ATLANTIS_PRCM);
> +
> +
> +enum {
> +=C2=A0=C2=A0=C2=A0 TT_ATLANTIS_PRCM_DOMAIN_RCPU =3D 0,
> +=C2=A0=C2=A0=C2=A0 TT_ATLANTIS_PRCM_DOMAIN_HSIO =3D 1,
> +=C2=A0=C2=A0=C2=A0 TT_ATLANTIS_PRCM_DOMAIN_PCIE =3D 2,
> +=C2=A0=C2=A0=C2=A0 TT_ATLANTIS_PRCM_DOMAIN_MM =3D 3,
> +=C2=A0=C2=A0=C2=A0 TT_ATLANTIS_PRCM_DOMAIN_DDRC0 =3D 4,
> +=C2=A0=C2=A0=C2=A0 TT_ATLANTIS_PRCM_DOMAIN_DDRC1 =3D 5,
> +=C2=A0=C2=A0=C2=A0 TT_ATLANTIS_PRCM_DOMAIN_COUNT =3D 6
> +};
> +
> +struct TTAtlantisPRCMState {
> +=C2=A0=C2=A0=C2=A0 SysBusDevice parent;
> +
> +=C2=A0=C2=A0=C2=A0 MemoryRegion mmio;
> +
> +=C2=A0=C2=A0=C2=A0 uint32_t *regs;
> +};
> +
> +struct TTAtlantisPRCMClass {
> +=C2=A0=C2=A0=C2=A0 SysBusDeviceClass parent_class;
> +
> +=C2=A0=C2=A0=C2=A0 uint32_t domain;
> +=C2=A0=C2=A0=C2=A0 uint32_t regs_size;
> +=C2=A0=C2=A0=C2=A0 const MemoryRegionOps *ops;
> +};
> +
> +#endif

