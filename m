Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85F2E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJbH6-00081X-Kh; Fri, 06 Dec 2024 11:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJbH1-00080t-7I
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:33:48 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJbGx-0006LM-66
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:33:46 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30036310158so6723211fa.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733502821; x=1734107621; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cd47s1XqvUh+eK88VsUyMor47qzdCC6zvIBWVrU+HSg=;
 b=doV4ywHRxmFfVbvgbadKcLhGg696Hw0HsrpZQIyKhOcIxMD4VWPuZB9/PtyCtMxtkh
 gwiCZM88D/VsaO9FAjPnUG+xuRrOC2ThZDZ5jVDN+JTMh35afa+KF/Ae9hrUZYoEUqFk
 7TTOlnvH0XwQfB2FKqNkd6vmZM8I3b2+Qh0eDgQGg6i7opeXnL1XnYboaHPFfG4qWr9q
 OSB7HZq5NVQtUgpSDrGVN8hx3f3tYecBVhpKG3gSni57FWezPexfTb72BU3guj4HQDYw
 GsJemosOU9f/+B+lVkM5X5qI5kVIKFd69iqN1SPfRtK0Nl6+BXTmxPm7H7o68V6Vboo2
 wGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733502821; x=1734107621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cd47s1XqvUh+eK88VsUyMor47qzdCC6zvIBWVrU+HSg=;
 b=BetT8Ow7j3QUgKaa+66dN1CXZbMEFFZynbiE/EI0mEIXeauwTQj5aHADT7z/TQY5Pq
 3LlchhBBPN/2Llvoeote8Xla9bOtPayEE6sENo5eREK1XoTx+r524FaMbcXmque5Eir+
 ENrDl5hlaCq1wculs4DrEgrMEv5v0cwhaiVXmRH6ydmAF5pkg39RPFbPeOZIc+IN/1E/
 9e1O6BeGm28drQTxkQHZ2Kn8+MF1ZfXq9gBkHhOM7RZPxHmAiW7j/2kZ+DPKSsrm3UgV
 19iwIMlI55TAo2dWCsfkFiTJGMoj0wqXyeoXv4Nu5HxtToykNnae/Gm5nT+k4yfr2ENe
 2Jfg==
X-Gm-Message-State: AOJu0YyZWP5y+XWJ4fGWMQNyOV75bQWxsEFWhyGSChZlWg7BKjoWtC62
 PCaIeyxsIC0za2CfNNaeIdI7gQpxVFj6LsZ8EZ9nrpROMdJpcQscmP4+mJSOl9OVeQu6hZRTdsb
 wx6uRfsfJvH62dGZnn3yk7hv8pMKihNBuqyLMAw==
X-Gm-Gg: ASbGncvKzrPDzXBDBlJu6nC6Jj9NUOC0cXXLxLkEVM8GY+S66thlg8uaAmcnkTUymsr
 FNEGbpaWkKhGSfgLBCLJT9KI9Oci7iaYO
X-Google-Smtp-Source: AGHT+IG50I0JWhzz+YK3HKzL4tsq3+i40xFZtZQu9msuXb/5q4iHgooBbqm4vrGrsj1gvpEBMu+ruO5PKj2HQv1Kz6A=
X-Received: by 2002:a2e:a9a7:0:b0:300:3a15:8f04 with SMTP id
 38308e7fff4ca-3003a1592b0mr11510331fa.15.1733502820945; Fri, 06 Dec 2024
 08:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-68-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-68-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 16:33:30 +0000
Message-ID: <CAFEAcA_K-LAtk3_5ae75SEtzdz8syrtFf_dUMB+XtK49A7cN3A@mail.gmail.com>
Subject: Re: [PATCH 67/67] target/arm: Convert FCVTL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Sun, 1 Dec 2024 at 15:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove lookup_disas_fn, handle_2misc_widening,
> disas_simd_two_reg_misc, disas_data_proc_simd,
> disas_data_proc_simd_fp, disas_a64_legacy, as
> this is the final insn to be converted.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

