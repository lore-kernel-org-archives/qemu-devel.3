Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445EAC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 14:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmZk7-0000vF-5d; Mon, 24 Feb 2025 09:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmZjy-0000tk-Ou
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 09:47:26 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmZjw-0007rx-Ja
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 09:47:25 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6fb7c373416so35443107b3.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740408443; x=1741013243; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vaCwfjXRWYgdOrjWq1KNN6uPPUv1FI8JvSotyLevqRE=;
 b=j/4tCP72cJbAH9cmR06lV4KqlqKAJ8RMEE2Didcf+uKsGfho3HHwgYKlu99TBUH9SU
 NW5uJ1Kotk0Gb3k4VefpSKVE5xBZkYI73p75noOxIAx3DCjiX56ucC3dWX56jQejgrRa
 7KihorBCvEG1MGCdBnprgmvQkxGXkN61qFcB/mZFuV0pEIp/8q/rMXhjCUllO1LuU2ru
 HLrbPcHom60GhkEfozkuOP5TuGCA0tWSsupmZ+zbTlEjDilBB+QAhrLAJ5yHi18/1awg
 7ytB0/5vCwHpmNWxDYDccQlU1xqPARysJvsOpjxUW0/kX0UE9xIYB8k/snrlrusJ0gou
 +Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740408443; x=1741013243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vaCwfjXRWYgdOrjWq1KNN6uPPUv1FI8JvSotyLevqRE=;
 b=NPIZ/ZAM5kZNZvLgsEUAgU1eW5Nwfzi02kXrEM9KmX2FfXLp7k1qq7EVJYnIQU4vf9
 7nHZju8AaeLT0dQHmkLMOofUyRZHqfRp7dcMSDzjUdTW6HUBEosRIoyFTbs0UliVUPuZ
 bT2WfzxPU7y1EUNxmUTD7A++khE9zzDmrYFmRcUALCXaaRBnW/n5VbpUY3+JW/GoDv0T
 VuJW2uwC3dvJxW00z/rPnrfaLMKr4uMYex9mzxU35s4bN0aDc+yRMljxprvV3MnOtN8i
 w0hA8+JdNpjNDCk87Pni+mvum8iE0JAhg7UeUeIVjeJfE12vCTUXFBFTABiTaILbd/Gu
 DG9A==
X-Gm-Message-State: AOJu0Yyv2dQWPH3ngAJ7yck6WjBc68LbjiskO0HggDAQXLs0ROGKf3pI
 VbiCsotyYwt3UUfIos91sDJCD/UwbskM2WK47AYXrNgX9VQxvGEZ5UzvXUOddt/6lzj5EKbVkRg
 CIWlf2oZTczSROzFx0SmVR0bk63XwGS8e2xr3ICvIJ/0pqkTw
X-Gm-Gg: ASbGncv4Zgz65uIZY1kFUYkuCMxBWQT8e1OLJhwt5acgnyc64w/2TPc36+Rsba9h/5B
 m5l9dRahS0Q60vUvsqvXkhw3idOIxWUGmjpXjWysHnC/8W/nNJW+GOLaiAOfTOHO4D3e5pUCiQ6
 LjGx2VXnFA
X-Google-Smtp-Source: AGHT+IGzSHk9xL20r2oqjhJlFqcdcRRKED1Ek86tuu2y0eGVqnlZ63xn98qSFmeIRfG7c+KvM4X3RFLUo2BwLuvCgW0=
X-Received: by 2002:a05:690c:480a:b0:6ef:820c:a752 with SMTP id
 00721157ae682-6fbcc25ed88mr109705067b3.20.1740408442800; Mon, 24 Feb 2025
 06:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20250213142613.151308-1-peter.maydell@linaro.org>
In-Reply-To: <20250213142613.151308-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2025 14:47:11 +0000
X-Gm-Features: AWEUYZnl__72jn9Ay47kgQZmZBSQHY4Juh_O0iQcTCWpV_uB8NGMHqVhJNCTHhU
Message-ID: <CAFEAcA86t=uc_XZd0s1yOFsop68XN2HK7c5MUJNfn7kcDoMsxQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/i386: Emulate ftz and denormal flag bits
 correctly
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

Ping? Would an i386 maintainer like to pick these up?

thanks
-- PMM

On Thu, 13 Feb 2025 at 14:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This is a set of four patches to target/i386 which use the core
> fpu functionality we just landed for Arm FEAT_AFP to correct
> the emulation of some corner cases of x86 floating point:
>  * when we are flushing denormal outputs to zero, this should
>    be done after rounding, not before
>  * the MXCSR.DE and FPUS.DE bits indicate when a denormal input
>    was not flushed and was used in an fp operation; we previously
>    weren't implementing these semantics
>
> All four patches have been reviewed by RTH. Testing is a bit
> light (make check-tcg and make check-functional), because AFAIK
> there is no freely available comprehensive FP testsuite for x86,
> and risu doesn't support x86 currently so I can't do the same kind
> of random-instruction-testing I could for Arm.
>
> thanks
> -- PMM
>
> Peter Maydell (4):
>   target/i386: Detect flush-to-zero after rounding
>   target/i386: Use correct type for get_float_exception_flags() values
>   target/i386: Wire up MXCSR.DE and FPUS.DE correctly
>   tests/tcg/x86_64/fma: add test for exact-denormal output
>
>  target/i386/ops_sse.h        |  16 +++---
>  target/i386/tcg/fpu_helper.c | 101 +++++++++++++++++------------------
>  tests/tcg/x86_64/fma.c       |  17 ++++--
>  3 files changed, 68 insertions(+), 66 deletions(-)
>
> --
> 2.43.0

