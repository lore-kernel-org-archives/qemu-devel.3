Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA6DC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt2Bw-0002Hq-9e; Fri, 14 Mar 2025 06:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt2Br-0002Gn-N4
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:22:55 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt2Bn-0004VP-D5
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:22:55 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e60cab0f287so1481045276.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741947768; x=1742552568; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OYkiyS1XYmvyCyxAfD7RScZbhCwAx/jD+RBZEwHgFeg=;
 b=u66VO1Wx6SD+99QiT+EsDUhMKsq/KYKmz/N2EGWVojRxexWsPXZ3j/uLxzMhF6g5Uc
 YFAjF7y/Nu1n4urMjICOvb+WWDTw3dGq/LvHUz4eU//U86e0InFrKPNQVXAgf05UAr3D
 3nKuI9/Wa8SZJ7VFEe/7/ngdPNlKDbL7G9wd7Suw5h0SttXXHJVCz/vAILIKc6L3cCXN
 19nc9GHYfRYEEU5+G4tOzAMkhwhPgz+oCuwoCxqG0OMGHphSJCa3G+bbekASng8M8FMT
 XgEyHEzElvyh6UIFc0d7CgKgQrZPeT9dAdSnpyHjPxIppD6u8DIbdIDQ6D7/EMgEwifW
 1PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741947768; x=1742552568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OYkiyS1XYmvyCyxAfD7RScZbhCwAx/jD+RBZEwHgFeg=;
 b=FCxxTTUc3wQ2+ey2z+gZRqfjcgy7rEfpncQA++4goFJPceio3/beGdPFvfzgwJxA7s
 k+XXY5UngLP8wTHm10Ut1gmWIgb2oPa8oRX3fuluyBWFyCz9PuUun/jzyiNtR4CHSoq+
 8GS/GOlIRgJcgOKbFNhb+jnDbPcTHpW94mUX5p8YniSMv0YqWG/iJdtxJQHf3yfhtwoq
 jQ5ruP+F+9/2nIg4FA2WcJttFC8Pby8EQkGM+Ho5Tq6DmZjAQbk4Ixbga5vUKQyEyEwP
 P16Eg3wER2EsKMK9dMtT9s/oIamvdqkWNzbiz9CaWhp2YNb2hilBg+csp7DZZrMWth0I
 xGJQ==
X-Gm-Message-State: AOJu0YyA0Vex2qcdTSV+7bX44iUWNNpyzTXklHuS5X+HQCSwe+7JbBu9
 wusQL+phV7naVYt1zAVUrg0Ou2s/Re1hFCA/ANVbhifsM5Rvf7WIjC5fAcIaDu6nGaXtRpWyqte
 2GuCuERn2zx4/+oWB13FzGR3WcITptnb7OM2s9Q==
X-Gm-Gg: ASbGncsDglc4NN3YxvZtb4bi/Dd4lIFSbOgGXpV7AG1N4AB/yb8QvvBbRIWGPB2Qlgl
 blpdR10P9NfAAy+yEzaH0lgQxlrRIfkIwfhQTC5d/d0sBORoA57zGjd58ta7N+GYFmP1QaklIIb
 W1xurNsufsl7rKP6fm0PLT03bzDVk=
X-Google-Smtp-Source: AGHT+IGsyg04OevbbkKLZAOsi1GJ4fhMSH8yrov91uooA5Jlw85nEWW4aFY9Xv7mPswQNobQ6jrWWqWRbzgoZp0t1gg=
X-Received: by 2002:a05:6902:dc9:b0:e5d:cdc6:7acf with SMTP id
 3f1490d57ef6-e63f65c5536mr2198074276.31.1741947768624; Fri, 14 Mar 2025
 03:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
In-Reply-To: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Mar 2025 10:22:37 +0000
X-Gm-Features: AQ5f1JpDZDzemazfQHx8KWpMLuRQEyUsTllxky7nainhk-4kLNIz4ejJ-itnIO8
Message-ID: <CAFEAcA9yKETtDhJroC7RD5itUjsYAkj0fVXHJaUxoU_bce7Gvw@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Define raw write for PMU CLR registers
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Fri, 14 Mar 2025 at 08:13, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Raw writes to PMCNTENCLR and PMCNTENCLR_EL0 incorrectly used their
> default write function, which clears written bits instead of writes the
> raw value.
>
> PMINTENCLR and PMINTENCLR_EL1 are similar registers, but they instead
> had ARM_CP_NO_RAW. target/arm/cpregs.h suggests this flag usage is
> inappropriate:
> > Flag: Register has no underlying state and does not support raw access
> > for state saving/loading; it will not be used for either migration or
> > KVM state synchronization. Typically this is for "registers" which are
> > actually used as instructions for cache maintenance and so on.
>
> PMINTENCLR and PMINTENCLR_EL1 have underlying states and can support
> raw access for state saving/loading. Flagging a register with
> ARM_CP_NO_RAW has a side effect that hides it from GDB.

No, the CLR registers don't have their own underlying state:
all the state is handled by the SET registers, and it just
happens that you can read it via the CLR registers.

> Properly set raw write functions and drop the ARM_CP_NO_RAW flag from
> PMINTENCLR and PMINTENCLR_EL1.

I think the correct fix is to mark all the CLR registers as NO_RAW.

thanks
-- PMM

