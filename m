Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9666C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x975W-0006DF-NN; Tue, 22 Sep 2026 16:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x972u-0002a8-US
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:57 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x972s-0000dt-O9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790108691; x=1790713491; i=deller@gmx.de;
 bh=Yqr/oNn+ys+Qv8MC86RQ4+JECRq2hYfljGigKX6SkS4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=T1XJf8Jr+NObcXlTlRno89qZz+0fJLG+BVVVbKD34JdUC5sZn0Vx66ORbaNOvnLx
 O9uoS+Xod18ZtP3bJEOSIuTKhnyRkw0E0Qpi3QCJAljonErgGoGxB+3j67n+aBcq2
 aNFf6FJAgQwk59eCElgV4KYQOQ7yeP/y4HsM0LHuS7GhQzTr+lgtv8WFvzqB2Z9Wa
 4vHd+KsmOVd4ZVNLw1xQ+3MBYtNSPuO0QK4TtEsB7hxxIpoK9HRfyK9o6v7KATD+d
 OUSJvlAYXr+bHnU+uIPtMEdNxuYUnxsqv9vwCf0OANBMjrKJG3jL/nai+TxWa8mKN
 C1Wcn+lVpSbBHj+7LA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKu0-1xK1AR1qJ6-00Wvlv; Tue, 22
 Sep 2026 22:24:51 +0200
Message-ID: <c641356d-9541-4db2-9b46-1c9448cf0a9b@gmx.de>
Date: Tue, 22 Sep 2026 22:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: implement mlock2(2) syscall
To: Michael Morrell <mmorrell@tachyum.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260914233204.314810-1-mmorrell@tachyum.com>
 <f1e132a7611c45f088ff2d7e07a3391e@tachyum.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <f1e132a7611c45f088ff2d7e07a3391e@tachyum.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WUjZ96PaPVVv/jPsjyV4gCugObq1LwiyZ51pY1hEJ+V8oWa5Rhf
 dBWUt2tizAgga0S+Kn6dgBUp3AGFPafdneZFT0UMkMwHMlCX0W+18RylJMau9FFcaCjTh9s
 tjg2vwbaRy37gnVVv04At1YgN30uSVgr/Mv6rXMCsK5JbJXzDfLeaUiLFyh0So1pMufAvvF
 jKLLHy4yQ2oDxz6pULxeg==
UI-OutboundReport: notjunk:1;M01:P0:lCjDgxHF05M=;60BabLTNEeADl8XTReQL6WlMnp7
 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
 Y7zRoAJQFQUlcpIK4atCdiF6kw==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/22/26 22:14, Michael Morrell wrote:
> ping

has been merged upstream already:
https://gitlab.com/qemu-project/qemu/-/commit/30fa3eb41f85e114765e8476dc9a=
32a890b2e78f

Helge


> -----Original Message-----
> From: Michael Morrell <mmorrell@tachyum.com>
> Sent: Monday, September 14, 2026 4:32 PM
> To: qemu-devel@nongnu.org
> Cc: Laurent Vivier <laurent@vivier.eu>; Helge Deller <deller@gmx.de>; Pi=
errick Bouvier <pierrick.bouvier@oss.qualcomm.com>; Michael Morrell <mmorr=
ell@tachyum.com>
> Subject: [PATCH v2] linux-user: implement mlock2(2) syscall
>=20
> TARGET_NR_mlock2 is defined for every target's syscall table (it has bee=
n available on all Linux architectures since it was added in kernel 4.4), =
and linux-user/strace.list already has an entry for it, but linux-user/sys=
call.c has no case handler for it. A guest mlock2() call therefore falls t=
hrough to the default case and gets -ENOSYS instead of being emulated, on =
every target.
>=20
> mlock2() differs from mlock() only by a third `flags` argument (MLOCK_ON=
FAULT). Add TARGET_MLOCK_ONFAULT and a case that validates the flags argum=
ent and forwards to the host mlock2(), mirroring the existing TARGET_NR_ml=
ock case immediately above it.
>=20
> Signed-off-by: Michael Morrell <mmorrell@tachyum.com>
> ---
>   linux-user/syscall.c      | 9 +++++++++
>   linux-user/syscall_defs.h | 4 ++++
>   2 files changed, 13 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c index cfa68dfbd=
b..9f454502cb 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11230,6 +11230,15 @@ static abi_long do_syscall1(CPUArchState *cpu_e=
nv, int num, abi_long arg1,
>       case TARGET_NR_mlock:
>           return get_errno(mlock(g2h(cpu, arg1), arg2));  #endif
> +#ifdef TARGET_NR_mlock2
> +    case TARGET_NR_mlock2:
> +        if (arg3 & ~TARGET_MLOCK_ONFAULT) {
> +            return -TARGET_EINVAL;
> +        }
> +        return get_errno(mlock2(g2h(cpu, arg1), arg2,
> +                                 (arg3 & TARGET_MLOCK_ONFAULT) ?
> +                                 MLOCK_ONFAULT : 0)); #endif
>   #ifdef TARGET_NR_munlock
>       case TARGET_NR_munlock:
>           return get_errno(munlock(g2h(cpu, arg1), arg2)); diff --git a/=
linux-user/syscall_defs.h b/linux-user/syscall_defs.h index e28853c93b..f5=
831a6bad 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2795,6 +2795,10 @@ struct target_mount_attr_ver0 {  #ifndef RESOLVE_=
IN_ROOT
>   #define RESOLVE_IN_ROOT         0x10
>   #endif
> +
> +/* flags for mlock2() */
> +#define TARGET_MLOCK_ONFAULT    0x01
> +
>   #if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
>       (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
>       defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) || \
> --
> 2.43.0
>=20
>=20
>=20


