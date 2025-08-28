Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E391CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgGk-0004LZ-CK; Thu, 28 Aug 2025 13:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureOj-0000aN-FC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:18:47 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureOd-0006q0-Ms
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:18:44 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71d60110772so8109547b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394316; x=1756999116; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SC9ieBT6oErkVAUY8fikH7bENWmv/d/KOFD4WLwEkRI=;
 b=RUv9OCJq5p7ZF6JzN3J9vT4f392iFWT6ahrfYbLMJzSuiWZXFTWUbtMfZICQFqMspX
 29rpjUdod3T3sweUAJAKOQVBcjoTyRhjuAZnGnOO2CEMMTPbHLw93rpGVKiQqJNU3wBh
 aNcOKRFDsYJk8/qS2tuzIuPhPUyhJIcNkbw8rHD5+J2xhwWr3bpp1nWNujLvboGdirb9
 vRaEWiWBbRIRt0JDSrG941Yjs0m+xhsa8xI9SwfJVCSHwe6pihNBkETZgtlSCIFlOmDH
 fcu86CFfvUbkr8gXahmx9kZK5q72irEoMHoy4pKR4m1BqOwEO/7JeTomSK7BTUw8vDQC
 Mu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394316; x=1756999116;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SC9ieBT6oErkVAUY8fikH7bENWmv/d/KOFD4WLwEkRI=;
 b=NK0HmmJAO8X45A79rrbX/5luGRweTk4RNLWM5yH1OYOUAPZVs2279qPWznv5k0sG4E
 nrnUcUMOTMBZYrExf5ob6Jp3hf2ULl/dcUtrxCbnDQQjTtBdujMmT12k0Xafw6JFrl99
 ZhLysSXHeHUdPHsgS4MqIJu14faGaSCndB8gO1gPzpXlj8x52L2SX/fPDhl8SN4B4oUA
 iaOWmOJVoP2cWKcAcgH9odj638C5C8XIc8slz4rjvqdBqNcZDHIslTgCq7lc+LYOkJna
 K8YegWDrze178SEXOY9rftpOzmAkPK6DlmAC/JkmaUZXEs7GozfoiaOZoGeSw2oZoe5/
 1ZHg==
X-Gm-Message-State: AOJu0YxAFTMnZbR+f6rMolp+HoTau9bS9kyP2ACnzojVsgI3m+In/hrF
 VEjDlFxtvP2ieO7ZW6YwtASeHn3uBciR5sZjbVYuI9f3xybOfmwL9d5oVGfXKo/2MVjsAiWwfl8
 DQF1500Pm4T5WQfdWfEBVnPKaHFKeyZGLqC3bM7crAg==
X-Gm-Gg: ASbGnctjXkN+PmDGlQJ9Yt2+2HyCizZ+G37h43M+wMt1uD7VWWwFyYxfPyad1jBk//S
 33mW3YcEx7KwhD3IKEXkQzgpvxCET7PL16hW0LNDm/rrAW8NS4SWihOk46o5MpzrIlLfGyhGb49
 xpiZ/xcV8Almym53a8rceZDGsKXactQtec03i/0NlGXLfeur/9NWdqtCtgrOYcWGTpIMXeLtKrr
 F3cQKtx
X-Google-Smtp-Source: AGHT+IGeHANuc2qzXaMzkaxKylD0EBFR+RUli331tb1g1K2ChDfPvriCz/U6cm/8JDXyYgnaE6JVzREmSQfS2UaS+LI=
X-Received: by 2002:a05:690c:7444:b0:721:28ef:a9b0 with SMTP id
 00721157ae682-72128efabe1mr127901687b3.9.1756394316303; Thu, 28 Aug 2025
 08:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-56-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-56-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:18:25 +0100
X-Gm-Features: Ac12FXzYkYcQdxAOm5eyf483XlI5zOZOMAwI1TLQg7q0y_ckSMYkaiMnY6jkk3M
Message-ID: <CAFEAcA-DHz6dfp2KFN9N9izapoW0vObb6tCsr9u16WrLbTXKrw@mail.gmail.com>
Subject: Re: [PATCH v3 55/87] linux-user/xtensa: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove the target_pt_regs; add target_use_pt_regs to

"user"

> target_ptrace.h, which matches what is actually used.
> Remove xtensa_reg_t and xtregs_opt_t.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/xtensa/target_ptrace.h  | 22 +++++++++++++++++++
>  linux-user/xtensa/target_syscall.h | 35 ------------------------------
>  2 files changed, 22 insertions(+), 35 deletions(-)
>  create mode 100644 linux-user/xtensa/target_ptrace.h
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

