Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866B01061B07
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7E6w-0001mD-4t; Mon, 30 Mar 2026 11:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1w7E6s-0001lg-7X; Mon, 30 Mar 2026 11:00:58 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1w7E6q-00071L-9m; Mon, 30 Mar 2026 11:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1774882845; x=1775487645; i=laurent@vivier.eu;
 bh=D3Txvpywx39/ry9p/RYEqdwXrp4uGqRB5FJe4V0Yclg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=2b5W9Z5pDGpNxxB6TnuU7mDJVjPnLhss7VHLa5jIWIyWRjLJKiPkbbTLLLnWwvuW
 5c8uMkct0wCTZYNwXQjuVHQkIl6dPZzV+OsRIl26rOq5WPhU/+5/FbuZsR+4Wrirg
 bk3M+Nivn18pq/se4sAnQdf0s/CVtGyW21n2w/GVmXboW6q/yC37aIhoPo+Lfye66
 A+X0mZDuJTr10l7GD0bqRKupVrSAtokeBUV3H81dwYSFzu4JSkrb4IEmqp5jpzLgO
 BL+DwpchpUMNNr4OSjvqAjfW+bs5TIcHqGGfH7ZR24DIl/xnrMW0uEMjzRVSbusVH
 lCEmS+ObvvCXchFaTA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.15.152]) with ESMTPSA (Nemesis) id 1M72wT-1wAFZS1zwd-0010AF; Mon, 30
 Mar 2026 17:00:45 +0200
Message-ID: <64cec2e2-97c2-45f7-9feb-0d341145b25f@vivier.eu>
Date: Mon, 30 Mar 2026 17:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include: Don't include guest-host.h in cpu-ldst.h
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
 <20260330143123.1685142-2-peter.maydell@linaro.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260330143123.1685142-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYfOjPbL+juxptyeFCuBkhSILZz9ahwI5TOnNEjOoUNyK5iiJux
 h+dBabarY8xjjtLZJf5VsKN1cngIul9o4kyRBQ7Fuzx3CxAB2mBDhDx06aQINTMpOwjx5b/
 FaPlFF+XbEDRfRpqsaVvvrMNW5wKWiwSNGAoMpORhDJWkTgydF60Lm/HybiLZQ71uT2dRGF
 PtE0cb3tX7OcVq3Lr24LQ==
UI-OutboundReport: notjunk:1;M01:P0:E4K+1M/BGws=;kY3YX/2NmpGTwsLicb1gnfayxCe
 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
 1qY1hXhmXWlrfzN6E5xHy0gH7l+4c=
Received-SPF: pass client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

Le 30/03/2026 =C3=A0 16:31, Peter Maydell a =C3=A9crit=C2=A0:
> We currently include user/guest-host.h from accel/tcg/cpu-ldst.h.
> However that file doesn't need anything from guest-host.h, since we
> removed the uses of g2h() in commit 9b74d403b30e ("accel/tcg: Move
> user-only tlb_vaddr_to_host out of line").
>=20
> Move the include of guest-host.h to where it's actually needed.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This isn't needed for the following bugfix patch, but it made
> it a bit easier for me to understand where we're actually using
> the functions.
> ---
>   bsd-user/qemu.h              | 1 +
>   include/accel/tcg/cpu-ldst.h | 4 ----
>   linux-user/qemu.h            | 1 +
>   3 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 2c586e546f..b0b2c249fb 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -27,6 +27,7 @@
>   #include "user/abitypes.h"
>   #include "user/cpu_loop.h"
>   #include "user/page-protection.h"
> +#include "user/guest-host.h"
>  =20
>   extern char **environ;
>  =20
> diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
> index a5711bc15a..ea2cbf40fe 100644
> --- a/include/accel/tcg/cpu-ldst.h
> +++ b/include/accel/tcg/cpu-ldst.h
> @@ -71,10 +71,6 @@
>   #include "accel/tcg/cpu-mmu-index.h"
>   #include "exec/abi_ptr.h"
>  =20
> -#if defined(CONFIG_USER_ONLY)
> -#include "user/guest-host.h"
> -#endif /* CONFIG_USER_ONLY */
> -
>   static inline uint32_t
>   cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr, int mmu_idx, uintp=
tr_t ra)
>   {
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 85e68eff7b..cfe5f45fc4 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -10,6 +10,7 @@
>   #include "syscall_defs.h"
>   #include "target_syscall.h"
>   #include "accel/tcg/vcpu-state.h"
> +#include "user/guest-host.h"
>  =20
>   /*
>    * This is the size of the host kernel's sigset_t, needed where we mak=
e

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

