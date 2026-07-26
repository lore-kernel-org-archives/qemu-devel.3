Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032EBC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 13:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnyWM-0004Dy-GK; Sun, 26 Jul 2026 09:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wnyWF-0004C0-02
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 09:03:51 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wnyWD-0008GV-2A
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 09:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785071026; x=1785675826; i=deller@gmx.de;
 bh=XCQM1DMZlCuVy/vVrw8QtI+zrczZ0jk9IFaSR0oi4x8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nBIrHmgn1xgXOwvgrpZf6Ii/3egyUzmbamcXzxpi7eXc/57o0ojMzhFsPGhUM5C+
 Gb6XJo0JXyyxCLq1xFN9qZ0M74gweptBZUZVWeA8OvSKCGJm5wmwyql5ZfPHqFvMF
 MIoik+xYusruBDzuXtH2Xv3VSgUQY1xIIIjL/XWubpMjsQw//gninIPBAWSNNoj0X
 v9fJpIsiZUo+AT0XF3wBhvX483AMhbQWqQblcR3sSlKy6PkDzhU/AXwkU4PF2FJPt
 84jyF6JOiQUcTLy30lYl2VKlZWSxx6iLYXyXh9UthMzV16BlvZyFpDwIjhLi8b7qU
 n3iMg5Qp6enlgJoIgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5rO-1warVi0i2a-00RrZu; Sun, 26
 Jul 2026 15:03:46 +0200
Message-ID: <bb368e28-c009-47ce-ba74-83104a9e6af0@gmx.de>
Date: Sun, 26 Jul 2026 15:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix guards for the fsmount(2) syscall series
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260726005527.2513254-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260726005527.2513254-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/fKxIQEz4DbVYUk41wA7k40i5mr1mL0uR2LT8K1X+qjwxntI6aK
 MW7kBuuyrBtAy1HNcWqI51HKVaBhvocDFINZkcNIRE4u8I1B/Y6fKTi4c8Upzx2MU0Z5O9b
 JQial9AMRoKgf7TfSWOf+nQrW7Gk4I6Q8uOu5b61Vs+V2og+LXOvi9V+t471uecJGK+NR4o
 6Xca6WzVL8HhK9wcV1OSQ==
UI-OutboundReport: notjunk:1;M01:P0:/zBvii5dHDc=;epoQ+KET0jo/sjXubCrSxQjLaY+
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
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

On 7/26/26 02:55, Matt Turner wrote:
> The fsopen(), fsconfig(), fsmount() and fspick() implementations are
> guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No such
> macro exists, so the guard is never true and the entire series compiles
> out. Guests calling any of the four get -ENOSYS, which for example makes
> systemd's credential setup fail with EXIT_CREDENTIALS for most units.
>=20
> The strace bits for fsconfig() have the same typo.
>=20
> Fixes: 767c32fe6983 ("linux-user: implement fsmount(2) series of syscall=
s")
> Fixes: 6e0aa9f6c731 ("linux-user/strace: add fsmount series of syscalls"=
)
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   linux-user/strace.c    | 2 +-
>   linux-user/strace.list | 2 +-
>   linux-user/syscall.c   | 4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git ./linux-user/strace.c ./linux-user/strace.c
> index 3a81cc95f4..d861f311f6 100644
> --- ./linux-user/strace.c
> +++ ./linux-user/strace.c
> @@ -4344,7 +4344,7 @@ print_statx(CPUArchState *cpu_env, const struct sy=
scallname *name,
>   }
>   #endif
>  =20
> -#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
> +#ifdef TARGET_NR_fsconfig

Your patch is basically correct.
But I think instead of removing the (wrong) NR_fsconfig, we should
instead depend on the (possibly existing) __NR_fsconfig.

Reason is, that if __NR_fsconfig doesn't exist on the host machine, the
constants used in print_fsconfig() like FSCONFIG_SET_FLAG aren't known eit=
her,
leading to build errors if we don't check against __NR_fsconfig.

I change the patch accordingly.

Helge

>   static void
>   print_fsconfig_cmd_name(int cmd)
>   {
> diff --git ./linux-user/strace.list ./linux-user/strace.list
> index e363892e0a..3a366b8cac 100644
> --- ./linux-user/strace.list
> +++ ./linux-user/strace.list
> @@ -1725,7 +1725,7 @@
>   #ifdef TARGET_NR_fsopen
>   { TARGET_NR_fsopen, "fsopen", "%s(%s,%d)", NULL, NULL },
>   #endif
> -#if defined(TARGET_NR_fsconfig) && defined(NR_fsconfig)
> +#ifdef TARGET_NR_fsconfig
>   { TARGET_NR_fsconfig, "fsconfig", NULL, print_fsconfig, NULL },
>   #endif
>   #ifdef TARGET_NR_fsmount
> diff --git ./linux-user/syscall.c ./linux-user/syscall.c
> index 3da5530d42..740142825d 100644
> --- ./linux-user/syscall.c
> +++ ./linux-user/syscall.c
> @@ -9740,7 +9740,7 @@ _syscall5(int, sys_move_mount, int, __from_dfd, co=
nst char *, __from_pathname,
>              int, __to_dfd, const char *, __to_pathname, unsigned int, f=
lag)
>   #endif
>  =20
> -#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
> +#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
>   #define __NR_sys_fsopen __NR_fsopen
>   _syscall2(int, sys_fsopen, const char *, fs_name, unsigned int, flags)=
;
>   #define __NR_sys_fsconfig __NR_fsconfig
> @@ -14485,7 +14485,7 @@ static abi_long do_syscall1(CPUArchState *cpu_en=
v, int num, abi_long arg1,
>           return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
>   #endif
>  =20
> -#if defined(TARGET_NR_fsopen) && defined(NR_fsopen)
> +#if defined(TARGET_NR_fsopen) && defined(__NR_fsopen)
>       case TARGET_NR_fsopen:
>           {
>               p =3D lock_user_string(arg1);


