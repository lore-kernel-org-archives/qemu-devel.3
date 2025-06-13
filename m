Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BCAC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 10:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ1Hk-0005qO-RT; Fri, 13 Jun 2025 06:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ1Hi-0005ow-Vv
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:05:19 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ1Hg-00041a-9p
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:05:18 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e82278e3889so47277276.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 03:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749809115; x=1750413915; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ASLjwtRAxStQtF93rw6d34LHCm0nYZsuFqAZ+YyWvew=;
 b=QiuRuYy/AdFvKtvBBZJIBC7QI/eCi316N8JVPFLQZAJGWeFs1llouI6SCY428une74
 MfiX2UlOeYSBOL4WV5b6rEpj5mKU1jR5Cy0Kv6IdlisNCVnohHjQ/Sv5fa9AUAPEK+wc
 XHj3+kgNycuLzVFTqFJ6+SFYgyK6/lf5fZ4hRyI/L623Dts4rfllwJuEKqz+HDaeS7a+
 0C+BLuMu1GZkVKzX+0/eq92JkNpEOefx0JjGwR9zZf0m6R0WVkn+ysqpxumH6+inl7cj
 kkaeTzQsxfaziuQ84Fjr74XEHFNcJAxz8qiFdzEMTmY4OF/TaknhjB72ptYy0ekL+a2/
 SRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749809115; x=1750413915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ASLjwtRAxStQtF93rw6d34LHCm0nYZsuFqAZ+YyWvew=;
 b=W/OXSp2hEhHWjeuHe5H5qfbOpVwSmnugkN3yWgq6NIICHzAHOyhDzA4heEGLTyUfFD
 CZKAyHO317QXng/yEQoBSShdDjzwebbJy/DOkYBIiX244bQdOZ2ECQ8oXrLOpTH17L1O
 fJiwNRTFy1wz9+nUZP+Idd17QT9L7THaGpBkxNspfS4l/jLBC2Z5acmW7T59rRB6htKB
 1ffjT247qIrdb1SBgri44djsqbDhYHaYUBfEL+gdgcQiwXOyHLqBrrjLjS1hGEwMTFLo
 VaJLdi3QFRW1PkyugRcdwDdvNhGZI3JGuLASH6RxfudAljSDUvVxMa3WW0iBGrrXFL10
 Btvg==
X-Gm-Message-State: AOJu0Yx5ptOTwhHHLj+e1GWJrfD9/GB7IC9LJiGJN9/2Qoowi1/wAi2H
 WrjJT76W2PG3a9JyUOx6FJtCHkZWC6KSXpn11oH0MLDEciVZDgl+RlaboXdHNvj0TD7rtwRbZGY
 k8J+0wWL5KYu8O4bHRtZvF0DzKExE3JSZNaUjIRudLQ==
X-Gm-Gg: ASbGncvh7w7B2ofi5k0CQs/yynjM/oTkjkpWOsOyeDj4Tu0nSXujXoKr1FPtTnvljrG
 W5adtdVRfsbbfqHbD7mN8RhU36OnZ4K4iU7US2W4Hvlp1aCu21IR4y8FjVVAHgPNvx2u2c/qY6E
 Y0EH+TXwRFMDFXAEJNK47skv3ftLTbPTe5nS03/bPpAjVO9E5OwsAK80c=
X-Google-Smtp-Source: AGHT+IGDcGhHID6J71QVYJ0V9DPtc83AdWLXRf/upT8ihNxjZY38KW5jmz38woYhgdh6dPKQPXcPCW6ke10VvnU3Ry4=
X-Received: by 2002:a05:690c:688f:b0:70e:719e:754 with SMTP id
 00721157ae682-7116373c02fmr36974647b3.12.1749809114927; Fri, 13 Jun 2025
 03:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250531-clr-v3-1-377f9bf1746d@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250531-clr-v3-1-377f9bf1746d@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 11:05:03 +0100
X-Gm-Features: AX0GCFstQPogjqmGJNYjMdQCAK7CTApNPVQ5FToff6E_PxhfhErvGKtQYSTTm4M
Message-ID: <CAFEAcA9nrW7N0=FUqXJ9x_+kxC4Qt4QtPf2n4QY8Wh6S84QXBA@mail.gmail.com>
Subject: Re: [PATCH v3] target/arm: Define raw write for PMU CLR registers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Sat, 31 May 2025 at 13:11, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Raw writes to PMCNTENCLR and PMCNTENCLR_EL0 incorrectly used their
> default write function, which clears written bits instead of writes the
> raw value.
>
> PMINTENCLR and PMINTENCLR_EL1 are similar registers, but they instead
> had ARM_CP_NO_RAW. Commit 7a0e58fa6487 ("target-arm: Split NO_MIGRATE
> into ALIAS and NO_RAW") sugguests ARM_CP_ALIAS should be used instead of
> ARM_CP_NO_RAW in such a case:
>
> > We currently mark ARM coprocessor/system register definitions with
> > the flag ARM_CP_NO_MIGRATE for two different reasons:
> > 1) register is an alias on to state that's also visible via
> >    some other register, and that other register is the one
> >    responsible for migrating the state
> > 2) register is not actually state at all (for instance the TLB
> >    or cache maintenance operation "registers") and it makes no
> >    sense to attempt to migrate it or otherwise access the raw state
> >
> > This works fine for identifying which registers should be ignored
> > when performing migration, but we also use the same functions for
> > synchronizing system register state between QEMU and the kernel
> > when using KVM. In this case we don't want to try to sync state
> > into registers in category 2, but we do want to sync into registers
> > in category 1, because the kernel might have picked a different
> > one of the aliases as its choice for which one to expose for
> > migration.
>
> These registers fall in category 1 (ARM_CP_ALIAS), not category 2
> (ARM_CP_NO_RAW).
>
> ARM_CP_NO_RAW also has another undesired side effect that hides
> registers from GDB.
>
> Properly set raw write functions and drop the ARM_CP_NO_RAW flag from
> PMINTENCLR and PMINTENCLR_EL1; this fixes GDB/KVM state synchronization
> of PMCNTENCLR and PMCNTENCLR_EL0, and exposes all these four registers
> to GDB.
>
> It is not necessary to add ARM_CP_ALIAS to these registers because the
> flag is already set.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



Applied to target-arm.next, thanks.

-- PMM

