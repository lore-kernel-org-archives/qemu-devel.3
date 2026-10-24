Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA034606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=TgBKsoXl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKc6E-0001Op-NZ; Sat, 24 Oct 2026 09:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKc6D-0001Mn-DZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:47:53 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKc6B-0004uz-78
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792849665; x=1793454465; i=deller@gmx.de;
 bh=bFpEyfMoaVRFfWEc0u5+MOxCVt5UQ4vMkKgop3iRkeo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=TgBKsoXlkmd4c4XKLhhXioFZoLQp6RVt9QysOzhroM+ICfLhJEeQlYm7pRXewLfh
 zIPTrs8yQ8s35D2VPAVjKTiftkyxsTSYX549BT6vamOACTwPfpmE5LdiOJ10QHYja
 B0Q74mz0/Guk1uvP8UXdw5UtsiMOtpIzIOzd4klX+GimWX8oK6h0thaArQiqqAwuI
 iBZ2di9l16DTyxLLWza34OyK5zaATRR7EKS9ENtTHp30Z/ofhn114MePUE00S6w4j
 AiUjaiblF/rgH18GPhv/0A5BkNo5Z98HLlc1tVyHClcPrAPmtz0ILdSGzCAcRTJTz
 kzUv+vyee5xRGDqxVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1wWzdF1dYa-00tkBG; Sat, 24
 Oct 2026 15:47:45 +0200
Message-ID: <197b0089-56dc-4c4b-8f12-95bb4343978f@gmx.de>
Date: Sat, 24 Oct 2026 15:47:44 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/i386: reject bad CS/SS selectors on
 rt_sigreturn
To: TAKANO Mitsuhiro <takano32@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <c054bf9c-6cff-4532-83b3-c4fadce541ea@gmx.de>
 <20261024134118.474313-1-takano32@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261024134118.474313-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QBtB4KkZx36Pub8PcAIFoBD+5sVkTm4TyLqn+3hvqO7zKpe0taN
 LBt7XM5xYL9Wz5a0qloHKDWST9rqNRlowhGWsHPRfOa9GXc3aaO081eEzp7uMHvtO7AGihB
 QdQJegwpplhnIGmnQq8D5eDlLr60+YrZ6GO4WNqRCFzqqJAI/V0X+OL9JZWP0jpP0pg+DDa
 ldaI6aNHh2I93GEPFhUHw==
UI-OutboundReport: notjunk:1;M01:P0:ErabN8Q3KTI=;xmhZa7CuI4c0uWEPw/eJyBnUPVN
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 15:41, TAKANO Mitsuhiro wrote:
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

Is this "hello_srop" program from some specific testcase, where people
could test themselves? E.g. can it be found in some repository?
If so, please explain where it comes from....


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
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---
> v2:
>   - author and Signed-off-by now carry my real name (TAKANO Mitsuhiro)

Thanks for fixing!

Helge

