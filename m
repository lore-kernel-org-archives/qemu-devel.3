Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D073EC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 15:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdWZW-0008HZ-34; Thu, 30 Jan 2025 10:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1tdWZT-0008Ex-Id
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 10:35:11 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1tdWZR-0002dr-IY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 10:35:10 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e58a90c6059so3096971276.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 07:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738251308; x=1738856108; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khdxrygc0UbnEaSQ+i8lvQlk5dxp6kRIEuw4dOemg9I=;
 b=cIhLK3OCfVfYJQc4g0jv7gXBISvStM+BAjeVoTmmwKGDJdxqKdo/ApzDnch7kO5jDo
 0NPlFDbFw0Y8qxn3QLAKGMRtR8kFX7JIenlQg1BxwjzxiewAP6vW+tCzZ8HwEd2xWmN7
 d8L2q9VL2/VaMDIhReYpLlgQRrwAo29ABBsipHTEmShCINkQvLtWM/uOPCs1ycn2fI+z
 ahEGelSELWxizfY1T+y3OCMylgGi0IOEcoNH8M1MkLJQUiwnTJdKt0dDsq4VzuVGZ0Mx
 0pCZFO8I60kB70923EtIqKpmbGx+XNAlJeCKhrqT0LREb/JSUc2JLWJhM4ijbUSbQ6M0
 qZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738251308; x=1738856108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khdxrygc0UbnEaSQ+i8lvQlk5dxp6kRIEuw4dOemg9I=;
 b=j8S4z/SxDWSDigQPEU80Y51VyDn96Yi7jD0DqPpfIad5Mjwo4OjK4QIqUJIjKkb82W
 pUbVwCgp4/KLO6hbuceFnBrqGqT/oMntOxne+p/ZHeFeZ8h9Hjb8CH/ERZ1zTqJNmHAo
 ErKKu4IFPzsnaUY9yy3jMMTSM9JYFKenBMbQwLsuIcLfVw4qpCsURLN5W6iRHITJ6p+H
 aoccpO/yWoX45Wr5nRysBw87OXOhsUdQq+dlDy8ElBP3/UmfN6f/7znp8/PO0noSTy2X
 G3YK1PtTY/V0XTNu0yrlmGH9ZJNFBFQbrzYxEgSVZ9oeLJlIe+sBQMGr2NJz5KD4aB8I
 r5NA==
X-Gm-Message-State: AOJu0Yz1O1Rwf+a2XL8bzVT14ES13IVXfgzy2+DsR1Ak1RSB1kihskFx
 1lIKl+PoaSV/fnZc0bsV0JK4Hgm5QXKQyI/FiFOUp/RyGPWC4zFsG28PfNJWIXHq7GGWZqchMJ0
 6Rp6gdCYt5mf+Wbt4+1s8kFCTBJ0=
X-Gm-Gg: ASbGncuE17fxEftaKs0bcD+puOM6GrOD/nbzeIHEiN4feAZQw+7FdVpW7jCq4um/dA3
 mmdtJhCZMNnoii+g1OfF7qeFjhmmlMAVMO89fnUcFT4a/lTQQDbWs/6PB5JZAfhbKJmnkcoUWiD
 /fz2n6pk14ogbsBzQpze5PnYAiz79hxg==
X-Google-Smtp-Source: AGHT+IGPucBakIJBBC3FsT/WeF4zAc729qDgOIPx00Vq0w4SRrCDCEy2VcUGlxe+AcIZJMN0CdgNmbUlSqHttTidzY8=
X-Received: by 2002:a05:690c:691:b0:6ee:8088:831d with SMTP id
 00721157ae682-6f8c195a6e9mr31554987b3.3.1738251307765; Thu, 30 Jan 2025
 07:35:07 -0800 (PST)
MIME-Version: 1.0
References: <CAM2a4uxJFhw71emxdZrB4SF-JSzJy_-bL=g9ke7OmjUoOXUDYQ@mail.gmail.com>
 <87jzbdv7wk.fsf@draig.linaro.org>
In-Reply-To: <87jzbdv7wk.fsf@draig.linaro.org>
From: Gautam Bhat <mindentropy@gmail.com>
Date: Thu, 30 Jan 2025 21:04:56 +0530
X-Gm-Features: AWEUYZmBXwo9I3cqbUqzG0ldQBggmDIH8bNjQglOEyblHBajKgWno2jRe4Wn754
Message-ID: <CAM2a4ux=SH+=qemf+kcf=GBJ_-R5Zj4t9hxTCwvqYhwqmDpQ5w@mail.gmail.com>
Subject: Re: How does "rsi" get set in x86 prologue?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=mindentropy@gmail.com; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 2, 2025 at 3:45=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
<SNIP>
> The call into the prologue comes from:
>
>   ret =3D tcg_qemu_tb_exec(cpu_env(cpu), tb_ptr);
>
> in cpu_tb_exec. With env in RDI and tb_ptr (the code address) being in
> RSI.
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

Thanks Alex. So this would be regular function calling conventions. I
thought there would be some inline assembly to the jump to the disas
rather
then a call to tcg_qemu_tb_exec(..)

I verified all of this in the gdb disas of the function.

-Gautam.

