Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F26C5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 02:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri3cy-0002Eb-Ag; Wed, 06 Mar 2024 21:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri3cw-0002EB-Nh
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 21:36:58 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri3cv-0006uc-Cf
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 21:36:58 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d130979108so199214241.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 18:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709779015; x=1710383815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKN02QWUK7eRP+K5/495X0tghPjz9s4bRbdbbUVpcoY=;
 b=OrxyqjGKnQ27b1oShXo5sSAoF+xIxE1PMtTUD/9KUwsBRhShryx2BU1rrZUDboTxUz
 x3dgy5u2v4jX3e9QTeyzziHVhtzf58+vqOg7aGPcHONWPw26DbUwlRnkVrrD/JuJbaBQ
 bOZkqrMcAb3/bRn/dT5VYNw28YKkR8zAJ9s80Jj7vwJDF8aGZFwtO721aI7b7BUvAHTL
 KxR/kIgD5gp0uLEjdiB1Miiyk5sFU8x8LpomLr7T3WFGoUUJ6IiW7q5ce2iSUyJr9yRK
 PUWdvxF1E8iHvQyb9aF2AShC16474rAeaXkltPSdvFaESRYDwB9avLLA/3lOKH4x0Bwb
 RuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709779015; x=1710383815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKN02QWUK7eRP+K5/495X0tghPjz9s4bRbdbbUVpcoY=;
 b=ZaPSksxIh8+CPOqmf5WY7DvqHlVMs23sqxz3QbTSztklj9fxCXaRK7J8z0jWkUZS34
 mIKlS8YjYzKokQgOC+bglhd2beiGf8AuwioozKVvqCA/Z9KbRPklGemLlScUfaKjCzMi
 A4ukW/cxYapdLdH+fDgh3nHve4dwAiXa+YIbov/68y7uI4KROyQ0EoH0uHo8LkHVBGEg
 pf8K6gPoJ3gTfJpEB7N3tRPbg1zGGUM4QgDA6ro/W3pxZkS1j7XShcNjs2g5xpSMgU+S
 MCcmzCHzj3FbQQ32eHfeiPHiNz56RAiOWxxDmpE1o+QC4PmEJoElXnfvC09lu9jjEBKv
 8yBw==
X-Gm-Message-State: AOJu0YzNavEo4wSh/DzwMf3euThhYhSHGSZkUb3+e1SAYoX32+k4Qf+m
 iKP8LT4jHtPP3gtoXfsCH88y9OlD+gLex4+KF1UahOXU/9FzS9IzNYdukNBTvhkIxIIDk5bZ2uz
 ciGXLObN374rMqfQG8FVpverKRl8=
X-Google-Smtp-Source: AGHT+IHQ4E34kR5XU+Ea2vBYeWXR8t4ySEjhltvkywayeTyCe5nCjIZqpBXOgdIrYnvKNuF4TCWrux4NAKEL6V1g46s=
X-Received: by 2002:a05:6102:5492:b0:472:60b3:d4a4 with SMTP id
 bk18-20020a056102549200b0047260b3d4a4mr8340979vsb.27.1709779015401; Wed, 06
 Mar 2024 18:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20240228081028.35081-1-hrak1529@gmail.com>
In-Reply-To: <20240228081028.35081-1-hrak1529@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 Mar 2024 12:36:29 +1000
Message-ID: <CAKmqyKP7-aCijmq-6fHo+omOaBN0wLf_oW1=76Lk95E1jeTXSA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix privilege mode of G-stage translation
 for debugging
To: Hiroaki Yamamoto <hrak1529@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 10:14=E2=80=AFPM Hiroaki Yamamoto <hrak1529@gmail.c=
om> wrote:
>
> G-stage translation should be considered to be user-level access in riscv=
_cpu_get_phys_page_debug(), as already done in riscv_cpu_tlb_fill().
>
> This fixes a bug that prevents gdb from reading memory while the VM is ru=
nning in VS-mode.
>
> Signed-off-by: Hiroaki Yamamoto <hrak1529@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d462d95ee1..6e13069da7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1212,7 +1212,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, =
vaddr addr)
>
>      if (env->virt_enabled) {
>          if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL=
,
> -                                 0, mmu_idx, false, true, true)) {
> +                                 0, MMUIdx_U, false, true, true)) {
>              return -1;
>          }
>      }
> --
> 2.43.2
>
>

