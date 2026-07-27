Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DFEC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJwd-0007qj-Gt; Mon, 27 Jul 2026 07:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1woJwb-0007kr-VF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:56:29 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1woJwa-0004Qd-4T
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1785153378; x=1785758178; i=laurent@vivier.eu;
 bh=vUH4lnqviwU9EowIFtNCFHWQ5B/XRfsIsDhh7db17iE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=woioXPFMXM5PAqnMpQinFe8lExlAebrDrn17RXYtxwviYV4CHVwgU1kEjxQfnPTU
 VosftTybmpxKqz3EfOzCxaath7hG52icVVimT+AX7yPMKsYYQkQfiWCd1iixplpCu
 G92vrlDi6cJP9k02ypE0d9o71S9o5Pe0UWVxIFa/yrg1/+YBrRzSjfkVKT6MbUjmW
 GkwKRurjgFGRjwwgQu9Ox2iaFR75HW0VhmpxjIbB+ubje9MiSG6l2mVWsV1sTk5QT
 BaE8L5ahKn42O7i/atBysDpSOZbjaxuzy0D/+oi3yP1cuSHkrdpll8crCfSMZEx7b
 HJSdWYwV+Zg46fz1Yg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1MkIAB-1xGp7z16RF-00cZvU; Mon, 27
 Jul 2026 13:56:18 +0200
Message-ID: <cb98e6fd-d343-4c45-b4a8-78b92fef8d66@vivier.eu>
Date: Mon, 27 Jul 2026 13:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/sh4: allow full 32-bit address space
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20260727114848.1041856-1-laurent@vivier.eu>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260727114848.1041856-1-laurent@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZYvlaY9uVrlPw/ggaMtY0bf+DFJ2vTqd01IMEifcMrcm+TsVaI5
 um5BLWkkfthNetJGH2y9MWyiIWSYaBeIyNt5kqAG7ep+hLR+lWuzTqa4qkhcVN7cT4QDNQe
 7qhr4SuYAG3GmAaJh5CpPuf/noikhHpsRSkDlY5aSWdm0S6rwNk8koWh5KdApX/YjuMMn5g
 drdnpYL00Wo9A0cd+6FGg==
UI-OutboundReport: notjunk:1;M01:P0:Ns1D2vDdcPE=;TB4ZU8OExopYU8bcNJluVP6waWV
 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
Received-SPF: pass client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Le 27/07/2026 =C3=A0 13:48, Laurent Vivier a =C3=A9crit=C2=A0:
> On real SH4 hardware, the address space is split between user mode
> (U0, 0x00000000-0x7fffffff) and kernel mode (P1-P4, 0x80000000-0xfffffff=
f),
> so TARGET_VIRT_ADDR_SPACE_BITS was set to 31 for CONFIG_USER_ONLY.
>=20
> However, qemu-user does not emulate the MMU, so this limit is not needed=
.
> The only effect is to restrict reserved_va to 2 GB, causing OOM failures
> for memory-intensive builds (e.g. webkit2gtk on Debian sh4 buildds).
>=20
> Set TARGET_VIRT_ADDR_SPACE_BITS to 32 unconditionally, like most other
> 32-bit targets. Also fix the TASK_UNMAPPED_BASE macro to use 1ull instea=
d
> of 1u to avoid undefined behavior when shifting by 32.
>=20

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4093

> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/sh4/target_mman.h | 2 +-
>   target/sh4/cpu-param.h       | 6 +-----
>   2 files changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/linux-user/sh4/target_mman.h b/linux-user/sh4/target_mman.h
> index dd9016081e9f..2d05837c2f36 100644
> --- a/linux-user/sh4/target_mman.h
> +++ b/linux-user/sh4/target_mman.h
> @@ -1,6 +1,6 @@
>   /* arch/sh/include/asm/processor_32.h */
>   #define TASK_UNMAPPED_BASE \
> -    TARGET_PAGE_ALIGN((1u << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
> +    TARGET_PAGE_ALIGN((1ull << TARGET_VIRT_ADDR_SPACE_BITS) / 3)
>  =20
>   /* arch/sh/include/asm/elf.h */
>   #define ELF_ET_DYN_BASE       (TASK_UNMAPPED_BASE * 2)
> diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
> index c3b8114e538b..d95827078260 100644
> --- a/target/sh4/cpu-param.h
> +++ b/target/sh4/cpu-param.h
> @@ -9,10 +9,6 @@
>   #define SH4_CPU_PARAM_H
>  =20
>   #define TARGET_PAGE_BITS 12  /* 4k */
> -#ifdef CONFIG_USER_ONLY
> -# define TARGET_VIRT_ADDR_SPACE_BITS 31
> -#else
> -# define TARGET_VIRT_ADDR_SPACE_BITS 32
> -#endif
> +#define TARGET_VIRT_ADDR_SPACE_BITS 32
>  =20
>   #endif


