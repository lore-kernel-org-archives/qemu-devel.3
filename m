Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91932C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PIz-00076l-Vo; Wed, 09 Sep 2026 16:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4PIx-00076G-MZ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:54:03 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4PIv-0006LX-Is
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1788987238; x=1789592038; i=deller@gmx.de;
 bh=3B/4BCKWYFrAbo9IM3RMdUnbQ0OqQ7gmKQ1/wEuXs18=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YXQrWzy1fKtqabgenDr/yy5SYbrhi9j/X63iyFr1klKxFHlmU+Y/hbqc670+RiYE
 F07CXa+fzpm8/L/2W/jnpNzdHUC3B/CyZFu6oVq8EcaAEfiuQUOGtEEgvrq2AOaoX
 uFMX2oTCIN8+CFleuanzauRVdJs9L3RxWT2hE0RNNjyoYgqVrmhWZkT1ENLJmwKVd
 aZq/G7ctTpVXGlKq6p3jC3UWK3LXO40jdDId+7HrOeMlVXu5rLc2sSCP+HCw/16Ci
 Mrbgc4UJdgNRAqSApkiZNbr/CSDymXyfIDzuPzdCX/APVK3kG1zo0qHt4lxHy0J18
 4kQPqAWJo+Yo3zD3Lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1wVLOw47hT-00cRVQ; Wed, 09
 Sep 2026 22:53:58 +0200
Message-ID: <738b16bf-cdac-4101-b3cd-65d7b08ddb89@gmx.de>
Date: Wed, 9 Sep 2026 22:53:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/i386: report the real trap number in
 sigcontext.trapno
To: Nat Brown <natbro@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260824021308.26600-1-natbro@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260824021308.26600-1-natbro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jle3itFqbd8u/j407NywMyRV6+rERqyjykTzKn+CL1F6KXihx+u
 SovB1BEK/+9oy1AnDZL1VoGPFl6X88RgnTXc3KzV7S6Q7LeIdG/E/KakjmROpfpTXNpUlfd
 3QC1k3RFOmq85jHn+NqFc/5LjVKNoRIwv/1QznWRd7CObid/warkDE+B7S2fu5ijFaTYGTS
 gph0JMKj0E3I1aPZMGGXQ==
UI-OutboundReport: notjunk:1;M01:P0:cLr4EiK/OzU=;3L40R8kPj6Ifp1KflWj2Jk7yZ1m
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

On 8/24/26 04:13, Nat Brown wrote:
> setup_sigcontext() fills sigcontext.trapno from CPUState::exception_inde=
x, but
> by the time a signal frame is built that field has already been reset to=
 -1:
> cpu_exec() copies the exception number into its return value and clears
> exception_index before returning to cpu_loop(), which is where the signa=
l is
> queued.  Guests therefore see trapno =3D=3D -1 for every cpu exception.
>=20
>    #include <signal.h>
>    #include <stdio.h>
>    #include <ucontext.h>
>=20
>    static void h(int sig, siginfo_t *si, void *uc_)
>    {
>        ucontext_t *uc =3D uc_;
>        printf("sig=3D%d trapno=3D%d err=3D%#x\n", sig,
>               (int)uc->uc_mcontext.gregs[REG_TRAPNO],
>               (unsigned)uc->uc_mcontext.gregs[REG_ERR]);
>        fflush(stdout);
>        _exit(0);
>    }
>=20
>    int main(void)
>    {
>        struct sigaction sa =3D { .sa_sigaction =3D h, .sa_flags =3D SA_S=
IGINFO };
>        sigaction(SIGSEGV, &sa, 0);
>        *(volatile int *)0 =3D 1;
>    }
>=20
> Natively this prints trapno=3D14 err=3D0x6; under qemu it prints trapno=
=3D-1 err=3D0x6.
> A SIGILL likewise reports -1 instead of 6, and SIGFPE -1 instead of 0.  =
Both
> qemu-i386 and qemu-x86_64 are affected, and both report the expected 14/=
6/0
> with this patch applied.  Only trapno is wrong; error_code lives in
> CPUX86State and survives.
>=20
> x86_cpu_record_sigsegv() already notes the coupling, observing that we c=
annot
> let the caller clobber exception_index "short of inventing a new place t=
o store
> the trapno".  Invent it: record the exception in env->trap_nr, mirroring=
 linux's
> thread.trap_nr, which is exactly what the kernel reports in sigcontext.t=
rapno
> and which likewise persists beyond the exception that set it.  Only hard=
ware
> vectors are recorded; the EXCP_* values at 0x100 and above are emulation
> internals and never appear in a signal frame.
>=20
> This matters to wine, whose segv_handler() dispatches on the trap number=
 and
> cannot service a fault it sees as -1, so 32-bit module loading fails und=
er
> qemu-i386.  The equivalent 64-bit handler dispatches the same way, so th=
e same
> failure is expected under qemu-x86_64.  Discussed at
> https://gitlab.winehq.org/wine/wine/-/merge_requests/11737 , where the
> suggestion was that qemu is the right place to fix this.
>=20
> Signed-off-by: Nat Brown <natbro@gmail.com>
> ---
>   linux-user/i386/cpu_loop.c         |  9 +++++++++
>   linux-user/i386/signal.c           |  6 ++----
>   target/i386/cpu.h                  | 10 ++++++++++
>   target/i386/tcg/user/excp_helper.c |  8 ++++----
>   4 files changed, 25 insertions(+), 8 deletions(-)
Reviewed-by: Helge Deller <deller@gmx.de>

