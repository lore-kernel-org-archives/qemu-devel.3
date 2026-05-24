Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2EFCD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8bQ-0004bL-UE; Sun, 24 May 2026 09:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wR8bJ-0004al-Bb
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:10:43 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wR8bG-0002sM-4R
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779628236; x=1780233036; i=deller@gmx.de;
 bh=pibHNxsiTAPyrTR2Nu10vw6jWmg9W0BTLD73zu08PQ4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=byE2BmwlTPh0mBcn0kzE8KBKx3XclTs4ewQPJ1CcGdwqkQCbNo7R6B5tfqSYMEvj
 nIsGvg3tV80IfXnh3yqyKQwvNij7z1qpmGQMgsyQHmhswQgS933tCYh00Au9B9/NJ
 VsSmFgnMMSUss8hFmcmW/k+rxYB6h4rR3qVLRmrGhCvBR9cj0SM0Or+k/Bl40eKle
 aIyA2k7BeBUufue0Yrhv9oyOY/t249Q3fpi/JvKbO9K7EyNbFSveORFPHcww4cswb
 ze3UPhOiAmdogEk5L1HfgL+FzNz7d4lrURVoERkAreuFmlJ3HypTMbM/3BNd3UW+0
 3SREtLkLd9IlwbBWXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1Obb-1xSPbT2t4d-00uFVt; Sun, 24
 May 2026 15:10:36 +0200
Message-ID: <518749d9-c924-4271-83bf-653d25373201@gmx.de>
Date: Sun, 24 May 2026 15:10:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/riscv: add coredump support
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260521184332.1633410-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260521184332.1633410-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:74y1eId1j8BFKfJhoEMTFsEPlFCeXLIYuHymgwrZS5HLSqLOsUs
 b9vkOurKD6Mqdqaoc889Hkctk65nbW3FmfBSzoIZ3w5m+bRLDMgEEilOGFWKXG69vm5G3JI
 NIGAIAT22eYMmOvzoZPloe9r0fbGF2z2pUtOVZMx2TtyD6yCeUKJU42AkGIPGnk4qNmMEoz
 dVBd2TLeo1d57tE4yTfkw==
UI-OutboundReport: notjunk:1;M01:P0:E+Dlsm5e+uo=;GKVTCYBrb6zNFQd88sYg3qjX/an
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/21/26 20:43, Matt Turner wrote:
> Define HAVE_ELF_CORE_DUMP and target_elf_gregset_t in target_elf.h,
> mirroring struct user_regs_struct: pc followed by x1 (ra) through
> x31 (t6).  Implement elf_core_copy_regs() in elfload.c to populate
> the gregset from CPURISCVState.
>=20
> Without this, bprm->core_dump is NULL for RISC-V targets.  When a
> guest signal goes unhandled, dump_core_and_abort() skips the core
> write and falls through to die_with_signal(), which re-raises the
> signal to the host.  The host kernel then writes an x86-64 core file
> for the qemu-riscv64 process instead of a RISC-V guest core.
> ---
>   linux-user/riscv/elfload.c    | 9 +++++++++
>   linux-user/riscv/target_elf.h | 7 +++++++
>   2 files changed, 16 insertions(+)


I added the missing
Signed-off-by: Matt Turner <mattst88@gmail.com>

and added the patch to linux-user-next git tree.

Thanks!
Helge

