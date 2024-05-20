Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF749C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 14:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s93np-000309-OP; Mon, 20 May 2024 10:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s93nn-0002z7-QZ
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:15:48 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s93nk-0003i7-Ev
 for qemu-devel@nongnu.org; Mon, 20 May 2024 10:15:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-574b3d6c0f3so8124256a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716214541; x=1716819341; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ALlY3T5mHqa0dpyeVD3Hy5ttQjKpBHU5EMFvaAEy0dc=;
 b=FLKyk7Fy6oXKJZddCUEvZSXb/FB+70koGrm+s4oXbGG+2LtOlgzA97AimGEHBtnxXN
 vZ9WV7I+yplSmTVcYG1x7WrjyG9n/SihvJaMFw01bKkdopQKpj/Vnrd9oKics+grUK0I
 2OmjeKJDiLAYv3tvR4x9MrcL0UTBOJ047f5sdeNTxl26/FfBIh7HY0G4UQfvW8E2p2JG
 /a4C7kyJPaaBDEAYSdnWLrANETe1YLjPWi+jRosw+Dj0OJUa8hXIZG21vQNGYYNZf/je
 eevI2/B8XQ8IRu2M1YLCx2eqcbtpVOuN/zlHPOSyKV0lHUwkBO8O+DRzHOWj2J3ZdilP
 cBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716214541; x=1716819341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALlY3T5mHqa0dpyeVD3Hy5ttQjKpBHU5EMFvaAEy0dc=;
 b=r6iE+ZgdbHhZFeeUuK8qnd5huA9N3JtN6E7ZnNhZ59smJ+aSjCXfKtTd919D9saRWN
 zpfziGUmRPge29Cx2txM0e2MnJJr8vCycVncuYmB8YoS4FgbG9uhKtLoJ9GzvBKud7jl
 Q1WnE5QO08tys+2HYgcGnNWaOu2bDXmrJy06ZbukCciwUQNp42RqTfJtoLPTijMUGpb9
 q1vRFb6eKvswxUnEAvjYJTpzWc3RFoBtYoPsTy785S3Mn7Fb5O8UylUH+4ZBoGLQMhfA
 JCs+Gzzta6iovT8s3p5Sz2LGmdT0JdTyVsnau70t5LLwDSw0QHnMV6gwR3iRBycuXkRx
 fqzg==
X-Gm-Message-State: AOJu0Yw+Ye0Xkee86ff2D/oXgxHjepSlxyrWAVXHGJfk5d5dKVtwELaA
 lb3SrqiEY2ARLZZchZE0FRGI9e/kEc/eU7qomP2w/2os7skm7BhhxnzpSCEQ8U7PJ2GpQ0mXzeI
 zjbdrXeLaYSSjZANLBptSfZHdX7kDcQH6HqNBRA==
X-Google-Smtp-Source: AGHT+IGOYEJAnnGEkXA6yVYstYqGsJNjWpbIN8oGS8LnM2UhcAn8cfMYdtIlAhRMHgdZFYQna4jxqz9bfKJ36HilM9Q=
X-Received: by 2002:a50:d5dc:0:b0:56e:60d:9b16 with SMTP id
 4fb4d7f45d1cf-5734d5974e6mr19437342a12.6.1716214540992; Mon, 20 May 2024
 07:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240512085716.222326-1-rayhan.faizel@gmail.com>
In-Reply-To: <20240512085716.222326-1-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 15:15:29 +0100
Message-ID: <CAFEAcA_Aj49nB0HqteWpgRi83ZvVHTdUwma4PE4DDhhodB0omg@mail.gmail.com>
Subject: Re: [PATCH] docs/system: Remove ADC from raspi documentation
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 12 May 2024 at 10:00, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> None of the RPi boards have ADC on-board. In real life, an external ADC chip
> is required to operate on analog signals.
>
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>



Applied to target-arm.next, thanks.

-- PMM

