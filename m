Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BED1C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD02g-0001Os-HA; Thu, 08 May 2025 08:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD02d-0001OV-VD
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:07:55 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD02c-0000im-6E
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:07:55 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e78f44034ffso426968276.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746706073; x=1747310873; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YL87FuhWDvRyv0KfIzORqijLk934LJSUMog7volKFdc=;
 b=oH2Il1FX4ZO9zRvppNOtiSK8d/0fJwSqUhhdZsZNqcH+oUrtiabfxbRkoY1o349TQE
 TNIWKbloIvXjqLPGOBCrSxVVJP/TR+dWP8tWCtWc5FpU+kPT5j2+bpwuUtzWQWTzLWTI
 DFa9kJWlc5VznKaDdj68FkON/mTMtdL+iQvmfpc+c3ij0O92B6lvAp3A1a1itXQP+QrL
 gY2r32J3/BuJc5EkoTLUFBZYcc1O+8zsGQn8NKt6QgWyF8aGU6M7SXECKORtCWo34DfK
 ZFiiA7yVXOUm27LJIUuICFFAdkfrK4NYUQcWD1Lv0loEw1aoKnZxbHoEdeQ5kJKFE0JT
 9QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746706073; x=1747310873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YL87FuhWDvRyv0KfIzORqijLk934LJSUMog7volKFdc=;
 b=avq37x4yTKqlWkk6LNf/W+sqCOuL8ldLFBFWXwDALZ6U+EJYQeaLM2Zr9X6LAyBQvL
 45yRiXfTT4UtpM8wsa5tIAxIrTb76x8hDx+1VLjbyLUwpTMJV3Q29xN+KZqdpTdFBZgm
 hc+pb60NVssuWEO3IRDBL/e6FIhRTTOy0bNjS1I4u8Ng2nv8KRMLTh7G9ZrY+HJJfUSM
 J9QJL2EDaFAUK/uDyvpeie+vgbtnD/Amg1WL1AqPA3lwi2JlKZKuLJZ3I2Lnw6sEBQWR
 3nl3jNDJjx7NRf2pxuudh0JutOo0z/CyCcZn76UJiGeymkpUjBE9JiGDUybZqHtfSn1U
 wJHw==
X-Gm-Message-State: AOJu0YzhHtSNr7Cr+Nggxp9iaKV9ZediapXqvOtInp214bYf+AqCxirh
 sIuvh1UMSmtDp93UqpYd8PxQFUCP33FztqN014esfWpzEIdGqoP0GX00jxFl5sU3sHUOR0rqBvz
 eov8HYy9cmsOtpZwFDNYRWnnt3QMFlHisHefsgg==
X-Gm-Gg: ASbGncvZ+OiBOWu1TwDEZAbsE8GFvigJkuSzuE26LxuJX2efqGW22u8lGezz5niSYzS
 ZnmXiYE2VOIztwn8TxILwjIgRAH5KB9oLCHOBmFE4V5VCC/YAZj0Ll0xnbwYndu3uEePW70oiHh
 YbPTM6RvbLmv24cn/+uHsrVFk=
X-Google-Smtp-Source: AGHT+IE5s+nuYHd6x2a6aCI7dtUK2PdHv+gp2usVJxorITTM1P4EYvIoJcl9QwMcbO2gplMF/xxze1IqiTWVweuX+Cg=
X-Received: by 2002:a05:6902:2b84:b0:e78:6954:49f1 with SMTP id
 3f1490d57ef6-e78ef5efa6dmr3846126276.4.1746706072667; Thu, 08 May 2025
 05:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250507165840.401623-1-alex.bennee@linaro.org>
 <CAFEAcA_0cf=XEbH9VQdTHqu1wekSmFDLdqnnzpcwnshCT-UUCg@mail.gmail.com>
 <87zffnmidy.fsf@draig.linaro.org>
In-Reply-To: <87zffnmidy.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 13:07:40 +0100
X-Gm-Features: ATxdqUHvqCH0dZwizDr8EfdhDc4AqOMpAhinqOWIMw7rKJfMVDevOb_UT-kHgyk
Message-ID: <CAFEAcA80-CWEQYwTQPziUxm5V1K93VZstLh2r9mTGkD5QueKoA@mail.gmail.com>
Subject: Re: [RFC PATCH] target/arm: allow gdb to read ARM_CP_NORAW regs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Julian Armistead <julian.armistead@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 8 May 2025 at 12:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Wed, 7 May 2025 at 17:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> Before this we suppress all ARM_CP_NORAW registers being listed under
> >> GDB. This includes useful registers like CurrentEL which gets tagged
> >> as ARM_CP_NO_RAW because it is one of the ARM_CP_SPECIAL_MASK
> >> registers. These are registers TCG can directly compute because we
> >> have the information at compile time but until now with no readfn.
> >>
> >> Add a .readfn to return the CurrentEL and then loosen the restrictions
> >> in arm_register_sysreg_for_feature to allow ARM_CP_NORAW registers to
> >> be read if there is a readfn available.
> >
> > The primary use case for NO_RAW is "system instructions" like
> > the TLB maintenance insns. These don't make sense to expose
> > to a debugger.
>
> I think we could re-think the logic:
>
>     /*
>      * By convention, for wildcarded registers only the first
>      * entry is used for migration; the others are marked as
>      * ALIAS so we don't try to transfer the register
>      * multiple times. Special registers (ie NOP/WFI) are
>      * never migratable and not even raw-accessible.
>      */
>     if (r2->type & ARM_CP_SPECIAL_MASK) {
>         r2->type |=3D ARM_CP_NO_RAW;
>     }

Well, we definitely don't want WFI or the DC ZVA etc
"registers" to be exposed to GDB or for us to try to handle
them in KVM state sync or migration... ARM_CP_NOP is less
clear because we use it pretty widely for more than one
purpose. The main one is "system instruction that we don't
need to implement". (CP_NOP + a readable register is a
questionable combination since the guest will expect it to
update the general-purpose destreg, not leave it untouched,
but we do have some.)

> > If we want the gdbstub access to system registers to be
> > more than our current "we provide the ones that are easy",
> > then I think I'd like to see a bit more up-front analysis of
> > what the gdbstub needs and whether we've got into a bit of
> > a mess with our ARM_CP_* flags that we could straighten out.
>
> Yeah - hence the RFC. CurrentEL is a super useful one to expose though
> when you are debugging complex hypervisor setups.

One problem with this patch is the one that the reporter of
https://gitlab.com/qemu-project/qemu/-/issues/2760 noted
in the conversation there: it will allow the debugger to
read registers which have a side-effect on read, like
ICC_IAR1_EL1: we almost certainly do not want to allow
the debugger to acknowledge an interrupt by doing a sysreg
read.

thanks
-- PMM

