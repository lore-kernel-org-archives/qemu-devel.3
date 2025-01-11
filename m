Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45817E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 15:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWd7S-000395-ET; Sat, 11 Jan 2025 10:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWd7Q-00038x-O9
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 10:09:44 -0500
Received: from mailgate02.uberspace.is ([185.26.156.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tWd7P-0001Kc-1O
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 10:09:44 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 28C86180C42
 for <qemu-devel@nongnu.org>; Sat, 11 Jan 2025 16:09:34 +0100 (CET)
Received: (qmail 27451 invoked by uid 990); 11 Jan 2025 15:09:33 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sat, 11 Jan 2025 16:09:33 +0100
MIME-Version: 1.0
Date: Sat, 11 Jan 2025 15:09:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <ac8afd094ff19d2e3acf19d08a55f98815001318@nut.email>
TLS-Required: No
Subject: Re: [PATCH 22/22] accel/tcg: also suppress asynchronous IRQs for 
 cpu_io_recompile
To: "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, "Pierrick Bouvier"
 <pierrick.bouvier@linaro.org>,
 "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 "Thomas Huth" <thuth@redhat.com>, "Mahmoud Mandour"
 <ma.mandourr@gmail.com>, "Alexandre Iooss" <erdnaxe@crans.org>, "Richard 
 Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Laurent Vivier" <laurent@vivier.eu>,
 "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>
In-Reply-To: <20250109170619.2271193-23-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-23-alex.bennee@linaro.org>
X-Rspamd-Bar: -
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.936487) MIME_GOOD(-0.1)
X-Rspamd-Score: -1.536487
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=smNhWhLPld+rckYUnK1aTF/H/wy9s0DkJW/uRHlzZQY=;
 b=MQdyQC+xNjQ2jUWPDSV+0SKt3gJ/a+DLwSwsz3DD7aHmeEVvWjVuXPi4f9VSGAOCoxu1j2NdxN
 Z6M24P24l5nflIJth7te9dIYs+Tnxcl/QXs4+ZsANTDAVpVvN2tPioW53+9CzhFyhhDx7PBg0KrU
 aAOcQukbxHTJ8m2dqCDlgNeKqrfzbp0AG8AsfqBpcUrLbeMxcWgBHaoNFt5/s3UJsOq1gnVu1zKU
 5CATm3vPz+GqUuXfIYn18VfmbsoOc4LIB7YXWOjOFr/VGHExjoAeq9pu6dRcAQgyCZ+dLLsXnDc7
 cuLOi9E+3evvPSL4FqYUxtbJqmqJfGwfn4VbVQ7+aU0Bd2dY+siBeTWNvPUoYzefWyBoNak7mChG
 3fHCQbIqRW9DHNcln9kuuP28U4Mm6tXlTZ275kw90ZT1MT86W401sca0kJHfUjroZ5ySa7e0hJnM
 3OgoE+lWy4Rv9ySm+CI4dFIURVv3oZM7DosDijLsvxvnwc3cUUhjdrwLCDX8oJjdgb53ii4YL9uQ
 2AM+RGB+JJu14u6K2rCrYuy2SlKimw2GqP45eVYGh2DguBCMMn659n0dYYUB/oyDpJcP0mvzl/sm
 gMa8sVmdKpErOy/9j/ThkVXWjLQoOhdudMOxaOKhM3ENu3w+KdF6dV79rOZ+KdemXT3A3XLgGC0y
 8=
Received-SPF: pass client-ip=185.26.156.114; envelope-from=neither@nut.email;
 helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alex,

January 9, 2025 at 6:06 PM, "Alex Benn=C3=A9e" wrote:
> While it would be technically correct to allow an IRQ to happen (as
> the offending instruction never really completed) it messes up
> instrumentation. We already take care to only use memory
> instrumentation on the block, we should also suppress IRQs.
>=20
>=20Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Julian Ganz <neither@nut.email>
> ---
>  accel/tcg/translate-all.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
>=20diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 453eb20ec9..d56ca13cdd 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -633,9 +633,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t ret=
addr)
>  * Exit the loop and potentially generate a new TB executing the
>  * just the I/O insns. We also limit instrumentation to memory
>  * operations only (which execute after completion) so we don't
> - * double instrument the instruction.
> + * double instrument the instruction. Also don't let an IRQ sneak
> + * in before we execute it.
>  */
> - cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | n;
> + cpu->cflags_next_tb =3D curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | =
n;
>=20=20
>=20 if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
>  vaddr pc =3D cpu->cc->get_pc(cpu);
> --=20
>=202.39.5

Reviewed-by: Julian Ganz <neither@nut.email>

