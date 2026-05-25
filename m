Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC913CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdI3-0002m1-1u; Mon, 25 May 2026 17:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdI1-0002j6-Aa
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:56:49 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdHz-0007KJ-Qm
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:56:49 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a8ee4b703fso9019246e87.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 14:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779746206; cv=none;
 d=google.com; s=arc-20240605;
 b=cTxhCo459ES5lXJ3jmrZkDuzDryv/MyGxPzeRtHfHSXXRMVUvqaLyQTXY51Im6Pv7L
 9XhrPYBaPuRBhUmkmwHNiwblK8HyGUh8i4LWqdp6+oY4PxDXcCecSePUIjMmB/yCfP3t
 oivMUnjNLkeWfa1sUY3rKWIcLKm7yaKNnLES/VyfUftuuTVm3a3gk4Im4eEFOoEvPAeC
 MVa7C/qr0Fb2BNtAuQW+3DtNt1XXY1pU17fKQDoqM9v0Ot0Aelyp1D8hBMTDNhWNGo+S
 TKYI/tHdALWwnB4BGdYOYJmqqs5hrLSK3wI/gKRkE1oKQEjjcG+pW3zA9Py6G5Y22CUc
 f0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wRR0nZjKOSIOBD4AwROBbtqdfU10PU77vWkTVSLTDag=;
 fh=Ah4JAsVoaVA+rKM8Y0anFmtAiD8PMVd/TjZkyy++zwc=;
 b=dS0EIh7YQGf14c3Vrh5pUgNjeSX6eYuLlgPq29tOby1zVbQ1RaGIwmT9fp+w4+oxvo
 AuWxZl25amD64ZnzVnohnf6DeEI0yZlFd9qZ34KnUNNZXKLtWB5hKDFdztpsYyZyWX6B
 NI3pLpzC+RXfxChz6ctyETWmTtY26BXDlV53HE5HmKw3+7yQgGlZzAwqAKpK3EMrCPpw
 RtmKoy1eRBN142HKlqczJqaFNZG8yf0TxfnVLuc4f3ziyX5EBQETfvx0bYww8VT3g3+z
 Rj6jMnzSDRQKQeQVlWOJcI99IQqRTnSnjty6/HCb1l2c5b0fbgIrcWMmy3R77mb5Qz1S
 SAKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779746206; x=1780351006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRR0nZjKOSIOBD4AwROBbtqdfU10PU77vWkTVSLTDag=;
 b=jrXlzxBu/DEHP2KcBD4Ivukofd7Nnz3JbJVXfNLRpeHBHqqN26Qitu6ySRV3BUioB+
 EA9x/C1Vii5wxtNH3LMVt47/3n1iv5pDVzVQtEtxc9HlpFR1zAzeaTbmJVuRT8WmYcDE
 l1RqqW9sF4g7nlsnJXSAgrBxlDP0t40zUxPBp7ZUQbFx/ObRcX4pZUcmEVG77gMLD3yR
 a1upHHkJaGkK7/AlqY4dboJKzk4qRjupwve92hYO13oSFLRzT3/bU3DwkbTgCJh623ax
 AGxRX49Uzhr9Eqn6nrOl/XHvugrZSki0mJgpjicwmpPY3V2Yb+beL0yFa4mNO5LiiMpw
 wE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779746206; x=1780351006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wRR0nZjKOSIOBD4AwROBbtqdfU10PU77vWkTVSLTDag=;
 b=hQhLuvM8+BI7BtHxdiip3tWIXjJjZKzmxxyBweVhr6QjwNdm5FpFsG70TQ7DglhQyX
 WwEECC4yCj+Mvcgf17JN6QBpl8JeFd7z6JJYydnvDgbUnQClWZc1LRJ8u/QNkvZ8Je+o
 n3QZeSN6kfytI6jr7boyeTdZ5+2WqZvtgwwDAEK6v+A6UJrAiiBzun7Rfl18cBvLR2yw
 /i0OdktF84aI1tdPrzC7fU+EtIagkAzizU5vUHXXlrqVnzTWeBa+1TY53bWdwYanybn7
 0vbQ29JXoiSXcFBmsh4+JHu+GigddGOPwwjWed8itLF9nVGzlyijiDOH0X7YU3wuhkzD
 lxYA==
X-Gm-Message-State: AOJu0YxEYeC0qs5RbXDRbQftU8p4Gey57lTLstbdCpVIpz6owmrNEy1M
 t8fhlHm0Kl3cfb6AtB6yI5gD7QsEmP9C34ZrxpwPndMYTLnq7Ptd7jE0yeKPCxoxo56XtCSUJgT
 5n2dzwBdDe9coifLEPdwMldOiwSJiP57vxFKbX7c=
X-Gm-Gg: Acq92OGwJaYkKp93w1/r18051Au5P8KkYIEBLHxnrMhnz1tY2Gd7oe8YRnjt8EMH9xH
 21BXz7TuK/wT0uQbPrEEgOUpwxgooX6AUs5OxX3ASamhoPKYWLg/cLFNigGwqQ6Mt3zbBgGEf5J
 VGbIiCN243M3EOiGrxnmkyId4jkCasAg+OmYP9AgQuOn/hZksyIOh7JETRP1ih5k/ON0HqVjZF2
 C6NwAO6t4eB19SP1P3ajleCi0Od7x0T+pSeWYoHWeuBqnl2FW3hbA6vmao1i8Unuxx3krnW8rg8
 b17k7ixLTw==
X-Received: by 2002:a05:6512:3ba8:b0:5a8:f2ff:f501 with SMTP id
 2adb3069b0e04-5aa323d499fmr4034011e87.28.1779746205935; Mon, 25 May 2026
 14:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152427.4120785-1-mattst88@gmail.com>
In-Reply-To: <20260525152427.4120785-1-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 25 May 2026 17:56:32 -0400
X-Gm-Features: AVHnY4LeHIcj2ri-ms81jMsk-pkE-NO5jQUmvWwFACWE_tZqACATsCUjqM4OR0A
Message-ID: <CAEdQ38H0rZxzeEayGXKKJhiyb5sy+-um2M78f4sgYsC0tUKN0Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mips: save/restore FCSR across signal delivery
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 25, 2026 at 11:24=E2=80=AFAM Matt Turner <mattst88@gmail.com> w=
rote:
>
> QEMU keeps the MIPS FPU control/status register (FCSR, fcr31) in
> env->active_fpu.fcr31.  The rounding mode, flush-to-zero (FS), and
> NaN-2008 mode bits in fcr31 are reflected into the derived
> env->active_fpu.fp_status via set_float_rounding_mode() and friends;
> every architectural write to FCSR goes through helper_ctc1() which
> calls restore_fp_status() to keep the two in sync.
>
> Both target_sigcontext variants (O32 and N32/N64) have an sc_fpc_csr
> field that holds FCSR, but setup_sigcontext() never wrote it and
> restore_sigcontext() never read it.  As a result:
>
>   - The signal frame always delivered sc_fpc_csr =3D=3D 0 to the handler,
>     so sigaction(SA_SIGINFO) handlers that inspect the interrupted
>     context see the wrong FCSR.
>
>   - On sigreturn, active_fpu.fcr31 retained whatever value the signal
>     handler last installed (if any), and active_fpu.fp_status was
>     never resynced.  Interrupted code resumed with the wrong rounding
>     mode, FS flag, and NaN-2008 semantics.
>
> Fix setup_sigcontext() to save fcr31 into sc_fpc_csr.  Fix
> restore_sigcontext() to read it back (masked to fcr31_rw_bitmask as
> the kernel does) and call cpu_mips_restore_fp_status() to resync
> fp_status from the restored fcr31.
>
> Add cpu_mips_restore_fp_status() in target/mips/fpu.c (which already
> defines ieee_rm and includes fpu_helper.h), and declare it in cpu.h.
>
> Fixes: 084d0497a0 ("mips-linux-user: Save and restore fpu and dsp from si=
gcontext")
> Cc: qemu-stable@nongnu.org
> ---

Signed-off-by: Matt Turner <mattst88@gmail.com>

