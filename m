Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D2606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f6B88Md3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKPJq-00044O-U2; Fri, 23 Oct 2026 20:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKPJn-00042K-6r
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:09:03 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKPJl-0001ah-Cr
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 20:09:02 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5bcdae234ecso1250724e87.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 17:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792800537; cv=none;
 d=google.com; s=arc-20260327;
 b=Iqa5LHzfp2sjhUWne19u8t+ej4ByaxcBReGVj2WjVY2Ej2AkNvvqbPgiBm5Cn4tM/F
 RmL0xVzj1ZrHgHy04S1SDtfRkWakKs8B7UdOZEwUiTziShbOpgixmB9DwuhrGrWTH9eM
 0M6mDmIaN4jOFFMMbGoZs4BgLnRhzqA/nrIyY+WGHF7yF2ID0dUT5kJoq2Sj1gWJhanq
 vrGY1SePJZXD6HFt/jzfnFU6QT+uWH1+6Fy0pBkN3lSx2GPZXYDeqK2eHaaKaHKK4dLO
 qMUczv593rbvYQoSUs9PaMdWy22zoR+KyWhQZwBFtQrF78cCo42r0BdaqYGWmQc3yjaZ
 ri7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PC9tn/+HBGcK27D1Qjs8sOrTYdZeuP9rzD6gk2bvsA8=;
 fh=A3eXLqTxov1QgBKhmCqYirDLHKLfA9cjz+R5xiEzdZI=;
 b=U0na6SVeds3jZbIm0dgt0VxV5n+7cMScTH0N7HOhVRS1EHVg3Z/1DQTZLLMdzvgqnV
 jgAUXNhGaX1A19Xn1FcPP1Z5Qso86zlNGqR5qfx7ZzWqToddWVP2MjQI7Np/Y72jmcE2
 JWERaDVOzvEdVF3IQ+UwOmLBBcsDnLbmQtYEfTNMruCWK0ccjREJ+3i/wEr5Z/V7THKl
 lDeTFJ81Ln1LIAhrsg5eWXcIMJ61C/hiLELuhXkYy2i27xdvk6AYqHkzx4u3nXPQ5Cn5
 3IUd4iT39nlhxu4DLCFp0xWfd1RB//Vbnr/lmycS0oms8044qQ4lwqDMLDbXoUjRz8KI
 668g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792800537; x=1793405337; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PC9tn/+HBGcK27D1Qjs8sOrTYdZeuP9rzD6gk2bvsA8=;
 b=f6B88Md3WaRIF12j2JxRfTDHIpf3foJ9WnypwIEYoh36MOdcG+vCnvfDYJjdP8W4qL
 ++VcnWvUkx7YGS5Y9ndtp+SYKFG12vnnupfYNCBUQVRcwkPA68/pZXiBy7B4DAOwR7fK
 faocQ3jv+WBqQxJHirtsr66cqxezl2K70rL70ZfM40WkDbCGsD6lohraHLPk8wtMjiYb
 NH6mm2W4ahBnN5kgIQ2qt9X1/oonxtXl+X5mv/AXEFMEj1isFug/TgeLfxHv9jlqZlF3
 gfVrQc0uai4GMUb/tE9d34RQIPiVCfp940RLzJMotJfaRJfZZDcZheOFZpln+qGJyE/u
 frPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800537; x=1793405337;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PC9tn/+HBGcK27D1Qjs8sOrTYdZeuP9rzD6gk2bvsA8=;
 b=RqVbcwM+WUVnspbi9eCmxEX3/lOVlSneQQG0L+wqkeirJBNoEd8tj+vXhZf/2V8CBK
 pmukzzuR9DKvDbx4YVZE884giCHPPBwxkKBwJ0LQ8SWkpgfnKbzG0UaErvIME7q3Z6ho
 HYwhU1UhquI1srbCmhsIFjKE6nBL2epSBL6dalACyiD7C8JeNAy2+aDqUYJTc7nKHkkH
 SkSJFrYUK2sWa6H14rRKy9Jj6NXnZncL+rpQMhICPmH9TmcwDo1RqKoH2tPp4CKy/4ah
 ytl5JXrWlCDKHYcjc9kIih910Nt/V+laBrQchVzScwdhIMeGLojeVlwGIWY1VXbqZvhr
 vFIA==
X-Gm-Message-State: AFq9FYI/lOm5iXn++1dMLDdG2BvUw7MXSHSolEqL/of8EqxSO0WlroMx
 0M/trqNjQy9/NLLB6S0RsBttXsodoRPXnkP5zNd3moc7M2EjRmTQpw+3dKa4IdAzm1E4DyqRgfC
 9Z1fq+kv3lG8V/cP2Fmc4qEL+5SqcDNo=
X-Gm-Gg: AYBFou2OWTXmnooHisgXsjyw85qGOzcwRQm8XVrG2S+P1tShug+rWrmJ6Myp80Ryss6
 /MNGIzH3SS1Z8lnbInvWMXRMQMC+0u05ExXUL5bjOIsK5I4QM/YWhmOTKSI0CwNYSqyiaXLMdu1
 +pd+wNhoS8eXZw21/RqANUy13aJn7RfbOrvngn61EY1LR3hWBHIDqfUR2DFVdi3V0zDBWySF7I+
 tkyWawXiZ9iU0E0W1S0qM80qFww1K3tyC3pBsRNzCV0HghX51/igbrZsnF+fBoYeOit+wz0XmG6
 GBYZVjGc+DTjrBGDaLKzIQkqcf5z65/LrJavWPbonFp32m/cg0X5LM6/dPxv4iO0Bjz+TExWXhQ
 2EHVnI3Gw5FCrQF3WIPLVX9S3Qk0RQR4+3LJKsHtHb32J3wPx/mZ+1G7Ga98l06dyNr53ip2ClU
 kRJdV1yhtkYXhm0DSvaZSySD+tTA1Zuh9lDBCsuAIucbxgvKz1KC/V0X/EXIrLroNQ7ynSDW0T4
 g==
X-Received: by 2002:a05:6512:398a:b0:5bf:b46e:6b11 with SMTP id
 2adb3069b0e04-5bfb71ca4bemr169837e87.14.1792800536675; Fri, 23 Oct 2026
 17:08:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023113245.562358-1-stian@itx.no>
In-Reply-To: <20261023113245.562358-1-stian@itx.no>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 23 Oct 2026 20:08:43 -0400
X-Gm-Features: AclHuK-uY4N7OqWW_TnDpFBk6tnFkxGsb1w24ijUCuoUnWsSBM1f2mS5ukhom4Q
Message-ID: <CAEdQ38HwH9=UfUsVZ68=K0ZPaq7dtgpCk=JK6TU6wb8nUd2X3Q@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Do not chain from a TB freed by tb_gen_code's
 flush
To: Stian Halseth <stian@itx.no>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 7:32=E2=80=AFAM Stian Halseth <stian@itx.no> wrote:
> In a serial context, tb_gen_code() flushes a full code buffer and
> retries in place. cpu_exec_loop() then chains its last_tb, now freed,
> into the new TB. When that TB is invalidated, tb_jmp_unlink() follows
> the stale entry and qemu crashes inside its SIGSEGV handler.
>
> Drop last_tb when tb_gen_code() has flushed.
>
> User-only builds hit this easily since cross-page goto_tb chaining,
> e.g. qemu-sparc64 -tb-size 1 on a program writing next to its PLT.
>
> Fixes: ebf7a5d294a3 ("accel/tcg: Improve buffer overflow in tb_gen_code")
> Fixes: 25e5c6a320db ("accel/tcg: Allow cross-page goto_tb chaining in use=
r-only builds")

Thanks for tracking this down.

I don't think the second Fixes tag is right. The stale chain comes
from ebf7a5d294 alone: any last_tb that exited through an unpatched
goto_tb slot gets chained after the flush, same page or not. Your
x86_64 observation fits that. 25e5c6a320 makes it much easier to
hit, which is worth saying in the commit message, but it didn't
introduce the bug. I'd drop that tag.

ebf7a5d294 has been in since v10.2.0, so this should go to stable:

Cc: qemu-stable@nongnu.org

> ---
> 25e5c6a320db is not in a release yet (v11.1.x does not have it), so the
> crash is new in the 11.2 cycle.

The easy sparc64 reproducer is new, but tb_add_jump() writing into
a freed and possibly reused TB is older than that.

[...]

> +                /* tb_gen_code may have flushed, freeing last_tb. */
> +                if (flush_count !=3D qatomic_read(&tb_ctx.tb_flush_count=
)) {
> +                    last_tb =3D NULL;
> +                }

The fix itself looks right to me. The parallel case already leaves
the loop through queue_tb_flush() and cpu_loop_exit(), so this is
the only place that needs the check.

With the Fixes tag fixed:

Reviewed-by: Matt Turner <mattst88@gmail.com>

If you have a small reproducer that runs with -tb-size 1, a test
under tests/tcg would be nice to have, but I wouldn't hold the
patch for it.

