Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A978606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCtWYEcG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6hj-0005MF-EU; Wed, 28 Oct 2026 12:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xM6hh-0005Lz-N8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:40:45 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xM6hg-000099-6w
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:40:45 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3ab4c608a6dso12319221fa.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793205642; cv=none;
 d=google.com; s=arc-20260327;
 b=HMr9Ee3FHF7OB16KQQCVRrPRyw/wf3Eo7tKG2lS28k6D1wOIwLAbeI+cz170G0++O5
 jk46Z35VcXtKCyLO67ESHxZRTOuX79tPP+gwHRkcXtkAjO4nCN9NK332/daFmPSQt86U
 iqxxpN5EsI+wDb77WW0tKdXrBogmm6cC9MrO9kQ72ZsiS4msjAb9IjfDmxs5SMZHxApd
 c67Zoi8I4uSFnPxOjsL+7JBIaE4mfyW35O7Ec+f+Zmd41dKzRgwHHU3xTK7gflo+eWeF
 UUtKD1BFoz1wdNXw+wEJFXn0fgT4/8rardTkKcrWA9RvEHY89RDknUYXqTmq0iJJwKFG
 wVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RquhL12cV7+iVlQhzFwnKfI46M04XDxUQHAVRxi/oE8=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=SbyPYa6GtQIcGEbJJ3UWSCNoNEOzVsBs6DyPv/wup++tUEi6V7DbOFSIaJsjj2L/+D
 xQtO816bEKSzPVsW/MIR1/mMOOcpPHKQd346SlpIKk/c5ylOvBRMXet3ubs5NXNwkE9b
 +1NKQT0NOX67AmCl0hdzfysTQYOOrkIg6XLz/8CeiVMfO8QutZsCuCISm4wGTKVe4Be6
 /2/8RmKxLnJKEMC+P6rFHWHmkvmCO5ytNUqkYn8z2hhg8dW6sM6EuqZ0gdybWSzERNgX
 uGdQFz3Gq693RXZrcv++OaI2Li5kBch7tDn9tIPtkr1U3+mVP5FZQNLtQyeWX44vhcDB
 aP+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793205642; x=1793810442; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RquhL12cV7+iVlQhzFwnKfI46M04XDxUQHAVRxi/oE8=;
 b=WCtWYEcGiQNceJuyx+ngLlfTYU7FsiXCevD1Qj4XUmvP3G54AWg1XJMkbWFTQqcD3V
 NzOXVO9hQGi3FhZHiju82Yhd7VllAbCHVkna7PIuvahpv3vxv7VgL0+RCJvWZEHSYhjP
 eZngi5jhqiStekgaZd3YOZqDxjZu+BAO620loIvRKFI7wdTPY296pYOLSO4PfY33+i+b
 BVh/sS7daGRTNdJEGfncGjdu1B5Tnq/Hw7DCpm+s1cUyz3bIU1IRiQtpky4tjIHV59dx
 nnJCaoqgCanqffYIa1kuvbmKc51DWlimhrmFAetDctjbAgCeXgabyRFu3qq4p8z5ELhx
 uTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205642; x=1793810442;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RquhL12cV7+iVlQhzFwnKfI46M04XDxUQHAVRxi/oE8=;
 b=PVZcDktajnXmt30F6bepBGYCr5JmiJrgqcqyuqR8yZR/NdYq2hGihdG8N7vJmbDInP
 L3aj/qSoqH87g4On3We2Y8Pyiz3HX39fXTDJorIZo20yv8IEttOfrwTocaa3ew27DxgG
 JvHAv/vKOAYDVKAaoz7WZLZVQAHEdhyXNCsb/qJ+9quWmSxITQ/E9iTGcIbUPcW9Rlet
 HybsdpWQ2914nUYM2yf1YzUpPwn5vDRL8CwNWR/XaiPYxNlLnawY/jgHlZN006Gvns7O
 E+AkjWaZb91fPEwrEiMLEnYHfJ0zUy6IRkqCRpArX6zyauSyajv7K2JYRb3JT1n2fiEm
 XLYA==
X-Gm-Message-State: AFq9FYI4GgtYdlymSp9aGV3ZPJ1gOGgvoc5TEQ/a/5ofoiApspBLLu9y
 G62Uka9LY3vJTkEaFiWzhfpMlljskd2afSgOJ1NRk4eg5ZIJC+LTomfG+AOdi0SP3iTcMTkztbL
 hBLIaoyeK+duShfrcoY5F7HifmfohmNk=
X-Gm-Gg: AYBFou2qgfKhVbbGD9gDHb9DZJfB3FNuhZ/I33Kao5JSOznZPkxvVsHc1C95I1qf/tN
 pZtqb9GccvQWb64Tb9veDSb6d3lM1PwOUSd3DurEjDa9d2d1lYm9jZCre1CVeI5unVaT4HJttvb
 Mv9fVR+taBgSS6gtttZfdfuFaXUg9nl1RTBnf3L7wHKlY+e9/koXdV8+u3FFNuieBBAIZ9FlTLK
 ohm5lDtrdKULLz9RHIEpDwhuxaiTfTjVyPNRX96oRPm+HJMU+5TS8rtz+C2CjJK45wyF7LqyJOX
 Ya/ckXgs1SSmmcZiqPRsL6LmINzY82MkwQ5cMYozCQv8z3A2fXYHjF+UGjSz9IOrk7M5QU9e153
 0l/wD7/16P4yRl0tTHHtm8N6dfXRFrRyz+z8+ZBTmLMZMH11Ny7uMlH47W7YnkQ/g+u/+u6drmu
 NLkrdn37GXw2zYVhshtG3AhgzLbuZbV8LoGJBbcwfVk9FXraignEUT
X-Received: by 2002:a05:651c:c90:b0:3a9:a2fd:5932 with SMTP id
 38308e7fff4ca-3ac9cf289a7mr6788561fa.5.1793205641607; Wed, 28 Oct 2026
 09:40:41 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028163245.1031673-1-richard.henderson@linaro.org>
 <20261028163245.1031673-3-richard.henderson@linaro.org>
In-Reply-To: <20261028163245.1031673-3-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 28 Oct 2026 12:40:27 -0400
X-Gm-Features: AclHuK92yT09npgp2s9LArf1NyRrBwzWbdTEzdqzQUvJQrKVZhM6vO6z-RjC1sI
Message-ID: <CAEdQ38G13HN0Le+sSmVXsv4WHYBD+-sM-VPAsYiEKgE4Qx7MUg@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] tcg: Add tcg_gen_lea_{i32,i64,tl}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x235.google.com
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 12:32=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> +    if (sh =3D=3D 0) {
> +        tcg_gen_add(type, dst, base, index);
> +    } else if (TCG_TARGET_lea_sh_valid(TCG_TYPE_I32, sh)) {

Shouldn't this be "type" rather than TCG_TYPE_I32?

As written, riscv64 never emits lea: its TCG_TARGET_lea_sh_valid
requires type =3D=3D TCG_TYPE_REG, so for I64 we always fall back to
shli+add and patch 15 is dead code. On aarch64 it also rejects
I64 shifts of 32..63.

It would also break the other way. A backend that allows a shift for
I32 but not for I64 would emit an op that trips the assert in
tcg_reg_alloc_op.

> +        tcg_gen_op_tttii(INDEX_op_lea, type, dst, base, index, sh, 0);

