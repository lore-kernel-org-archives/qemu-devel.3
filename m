Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F435C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLvp-0002xV-HX; Mon, 27 Jan 2025 05:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcLvn-0002ss-3D
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:01:23 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcLvl-0007Wn-AB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:01:22 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e399e904940so5591876276.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737972078; x=1738576878; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r5HShamqKRZpHpY9V5gNyVgPIE3a6AxZASXWABEGCbc=;
 b=sgQaB3poLwes5jW3uSnsCcSqTHMKuk4SaGyHDLHLJqyCO86dhF/cAOMxzfTBitHTtb
 6QqHNVtA0169yeuF2t8FWvMwGJwkapGfe0Jdi4xKbMohDw7OYL0/MNYZpXyil0Gr9xwO
 LJ0JtDT7WtF6UAdey+UlFgtjWtmD7L0LeBZzYgpnbAyxTZQCHDuuzX0dm4wBo1oiDkPg
 1Bw7+IyISwdQlFW9/nfLfQY+B8ETnwE2X6nmIKevl0Nkd05zKHnlyIOtGaNsEbqULbVz
 7lABd/srqUW6zvR5eOmu4JpmoNk0rSXNjfkhpOt0eSzzisyvcjwZXYdFb1IF0ow9cAvh
 RCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737972078; x=1738576878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r5HShamqKRZpHpY9V5gNyVgPIE3a6AxZASXWABEGCbc=;
 b=byKnHCSwzduvr3+K2BWQWFbzLieNdzTodGdyvayThLPM9COC0ez43813ZEFPCd5UPA
 YUg5yLVk1H3/jJms7D/fah1ucmmFqOxNKO1w6v+0JlGhrAFOOi++Y/QUlw1aNmEjSASw
 XKeTz6eGruHwjGNRLi2vGgiMDFrDk4jE41/iaspEl/Y525AIaL9a/qw4f0dcux1IqW7q
 W0fQYn2wkIPk1HbyVFU6W9aF7YzOGB5PC5jsMao8ZH9pgLDOYVxcNh1CIlJ+V7Xe2nOG
 yLdzp8oG8Tu9nQU+nOD57zXN0qc+YZa/JsmfzPPDDKmh/lkJI18hynDUvbhusKy8CPyu
 IRRA==
X-Gm-Message-State: AOJu0Yxr0ELh3vVdqUlTo7yNw+6x18XlIrV0zcTWwJRj9gx7dZkStKKg
 bhR0CObOuBDDcqHi7j43WCjz9pskV1UxCJE2ojJM6Ydsi6E0/skeMVdI+TFVxkqzhWVWEh8PVy4
 mO0V9K6bQgnnGwX+CwSsYr8fHsxrZ0oOTQe/ELw==
X-Gm-Gg: ASbGncu7pCVqHKSElQrzVMFXvqZKxALo33yEwZzCqhTQJ1+H2IJV4llFRrJozqVEOxW
 oKBOIPs9jBQ3Yd89+MqmUEEByi5P8M/VF1a9TnWof7+PY4Yi1mrK/jovlgXXN+0M=
X-Google-Smtp-Source: AGHT+IHUrqG5oRurGlu8NtxCpp42Wkz1eT1cG9NL6VCVDQs02e53Lpe77IRGXhMJNx7//e7NmbGLJeMEu/pRdxHsmIM=
X-Received: by 2002:a25:d34a:0:b0:e57:d22a:1914 with SMTP id
 3f1490d57ef6-e57d22a1a98mr20194732276.16.1737972077773; Mon, 27 Jan 2025
 02:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-25-peter.maydell@linaro.org>
 <d8d04708-ddc2-476e-9e17-8493f573d7a5@linaro.org>
In-Reply-To: <d8d04708-ddc2-476e-9e17-8493f573d7a5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 10:01:06 +0000
X-Gm-Features: AWEUYZmALvSCKtEz26pOJsY-LUFq82dSkiszHxj5pC_Id6D3fJAjOjZxv9_pG08
Message-ID: <CAFEAcA9c2WKA+z8d=Hp6Jp+3PYqQ5wuCxWL_fGzQxRfJKn+jEQ@mail.gmail.com>
Subject: Re: [PATCH 24/76] fpu: allow flushing of output denormals to be after
 rounding
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sat, 25 Jan 2025 at 16:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/24/25 08:27, Peter Maydell wrote:
> > Currently we handle flushing of output denormals in uncanon_normal
> > always before we deal with rounding.  This works for architectures
> > that detect tininess before rounding, but is usually not the right
> > place when the architecture detects tininess after rounding.  For
> > example, for x86 the SDM states that the MXCSR FTZ control bit causes
> > outputs to be flushed to zero "when it detects a floating-point
> > underflow condition".  This means that we mustn't flush to zero if
> > the input is such that after rounding it is no longer tiny.
> >
> > At least one of our guest architectures does underflow detection
> > after rounding but flushing of denormals before rounding (MIPS MSA);
>
> Whacky, but yes, I see that in the msa docs.
>
> > Add an ftz_detection flag.  For consistency with
> > tininess_before_rounding, we make it default to "detect ftz after
> > rounding"; this means that we need to explicitly set the flag to
> > "detect ftz before rounding" on every existing architecture that sets
> > flush_to_zero, so that this commit has no behaviour change.
> > (This means more code change here but for the long term a less
> > confusing API.)
>
> Do we really want flush_to_zero to be separate from ftz_detection?
>
> E.g.
>
> enum {
>    float_ftz_disabled,
>    float_ftz_after_rounding,
>    float_ftz_before_rounding,
> }

I did consider that, but on almost all targets the "before
or after rounding" setting is constant for the life of the
emulation, whereas turning ftz on and off via a status register
bit is common. I preferred to leave it so that you could continue
to write:
 set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status)
or whatever, rather than having to switch to
  (vscr >> VSCR_NJ) ? float_ftz_before_rounding : float_ftz_disabled.
which in addition to being more longwinded also means that the
"is this architecture ftz before or after rounding" setting is
scattered in multiple places, wherever it turns FTZ on or off.
And for Arm it gets more awkward, because the FZ bit is
"turn FTZ on or off, whatever its current semantics are", so
you end up needing "FZ ? AH ? after_rounding : before_rounding : disabled".

Keeping the on/off and the "what semantics is your architecture"
separate questions I think is simpler.

> BTW, I'm not keen on your "detect_*" names, without "float_" prefix like (almost?)
> everything else.

Yes, I'm not super enthused about them either. Happy to switch
to something else. We're not very consistent about 'float',
though: eg set_flush_to_zero, set_snan_bit_is_one,
set_flush_inputs_to_zero.

-- PMM

