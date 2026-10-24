Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07857606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XXOlBAL1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKbqI-0002hC-D5; Sat, 24 Oct 2026 09:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKbqE-0002go-Fk
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:31:24 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKbqC-00022e-80
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792848671; x=1793453471; i=deller@gmx.de;
 bh=UBRjRcnK4VlAMItSD06zF/yXr5H0Z2WMwJWPUwg3puk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XXOlBAL1AEyh9Pbl3+9m5sC2WhFciO7jRbji08+Poo1YvDj2RCNvrm9QheUB1+LL
 fel+sMEvYy9VSCzKdLkIQ2Ra+8MqX7ozeAeS28b3cW3BaaeT6BsMirMKCWAe/p5GN
 jw5mtHS5gVP0qge/3hbXz4jfx9bWXPEcNvGZ5t2AePw0L6SsLZxdlD8RodFLhvpka
 gCTZjfjakGjs6bA0RnCGcxvyebPqxHegUdZ/x6+u5W4dTKGJeYicBToPqWlVqRwUl
 Y+78QT/lKScaNkV9nHJNCFJOyDQUNM+j94zYtauUCMT0k02V2c4R8F+PyaS4MFo2L
 QZZLNXXqsEfcpEMbkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1wn9pg0Bln-00ZjhE; Sat, 24
 Oct 2026 15:31:11 +0200
Message-ID: <c054bf9c-6cff-4532-83b3-c4fadce541ea@gmx.de>
Date: Sat, 24 Oct 2026 15:31:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/i386: reject bad CS/SS selectors on
 rt_sigreturn
To: takano32 <takano32@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, pierrick.bouvier@oss.qualcomm.com
References: <20261020144406.2542302-1-takano32@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261020144406.2542302-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CSfXuRAXqIe0JmHZ51qOV6PiE03WSYlf5BfClqjeoQ3MDbAobxl
 25jrKRZNDZ3wkrro6ODsQ88JlCIIAQ2WjMG0GM6/wgEkuWuDDZ3+1ly/wuKP2sslixZfVHr
 l2aMMYVxQ0ipogjBbcv3L1CCTHLasIdIOeH09c1S9XBZYspTVqGrvDXWkZFoicGkmPCsr54
 8ARDFgeum+I6fuPKaHxQg==
UI-OutboundReport: notjunk:1;M01:P0:HfTyb3uq+tM=;NpjcjxaT9243TI3n1XtqXhJRUpi
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Takano32,

On 10/20/26 16:44, takano32 wrote:
> restore_sigcontext() handed cs/ss straight to cpu_x86_load_seg(). In
> protected mode that ends in helper_load_seg(), which raises #GP for an
> invalid selector and calls cpu_loop_exit_restore() -- a longjmp out of
> the syscall handler. Landing in cpu_exec() that way trips
>=20
>      g_assert(cpu =3D=3D current_cpu)
>=20
> in cpu_exec_longjmp_cleanup() and aborts the whole emulator.
>=20
> A guest that builds its own signal frame and executes rt_sigreturn
> (SROP) leaves cs/ss zeroed, so this is easy to hit:
>=20
>      $ qemu-x86_64 ./hello_srop < payload     # frame with cs=3D0, ss=3D=
0
>      ERROR:accel/tcg/cpu-exec.c:515:cpu_exec_longjmp_cleanup:
>        assertion failed: (cpu =3D=3D current_cpu)
>      Aborted
>=20
> x86 Linux does not validate the selectors either: restore_sigcontext()
> only does
>=20
>      regs->cs =3D sc.cs | 0x03;
>      regs->ss =3D sc.ss | 0x03;
>=20
> and a bogus value matters only on the way back to user mode, where it
> costs the task and not the kernel.  QEMU cannot be that casual, because
> the selector goes through cpu_x86_load_seg() while the syscall handler
> is still running.  So take the existing badframe path instead: accept
> the selectors the CPU is already running with and return false for
> anything else, which makes do_rt_sigreturn() raise SIGSEGV in the guest.
>=20
> Tested with an x86_64 guest on an aarch64 host, against qemu master plus
> this patch: a frame with cs=3D0x33, ss=3D0x2b restores and exits with th=
e
> requested code; a frame with cs=3D0, ss=3D0 now raises SIGSEGV in the gu=
est
> instead of aborting qemu (unpatched qemu 10.2.1 aborts with the
> assertion above).
>=20
> Signed-off-by: takano32 <takano32@gmail.com>

Can you please provide me with your real name when signing patches?

Anyone able to review this patch?

Helge


> ---
>   linux-user/i386/signal.c | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
> index 9650fac940..01d54be310 100644
> --- a/linux-user/i386/signal.c
> +++ b/linux-user/i386/signal.c
> @@ -775,8 +775,32 @@ static bool restore_sigcontext(CPUX86State *env, st=
ruct target_sigcontext *sc)
>       env->eip =3D tswapl(sc->rip);
>   #endif
>  =20
> -    cpu_x86_load_seg(env, R_CS, lduw_le_p(&sc->cs) | 3);
> -    cpu_x86_load_seg(env, R_SS, lduw_le_p(&sc->ss) | 3);
> +    /*
> +     * Validate the selectors before loading them.
> +     *
> +     * In protected mode cpu_x86_load_seg() ends up in helper_load_seg(=
),
> +     * which raises #GP for a bad selector and calls cpu_loop_exit_rest=
ore().
> +     * That longjmps out of the syscall handler while cpu_exec_longjmp_=
cleanup()
> +     * still expects the CPU it started with, so
> +     *
> +     *     g_assert(cpu =3D=3D current_cpu)
> +     *
> +     * fires and the whole emulator aborts.  A guest that builds its ow=
n
> +     * signal frame and executes rt_sigreturn (SROP) leaves cs/ss zeroe=
d,
> +     * so this is trivial to hit.  Linux treats such a frame as a bad f=
rame
> +     * and delivers SIGSEGV, so do the same and take the badframe path.
> +     */
> +    {
> +        uint16_t cs =3D lduw_le_p(&sc->cs) | 3;
> +        uint16_t ss =3D lduw_le_p(&sc->ss) | 3;
> +
> +        if (cs !=3D (env->segs[R_CS].selector | 3) ||
> +            ss !=3D (env->segs[R_SS].selector | 3)) {
> +            return false;
> +        }
> +        cpu_x86_load_seg(env, R_CS, cs);
> +        cpu_x86_load_seg(env, R_SS, ss);
> +    }
>  =20
>       tmpflags =3D tswapl(sc->eflags);
>       env->eflags =3D (env->eflags & ~0x40DD5) | (tmpflags & 0x40DD5);


