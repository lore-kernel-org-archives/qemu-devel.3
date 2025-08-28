Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54125C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIN-00071y-Fm; Thu, 28 Aug 2025 13:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urde9-0005Dy-Ph
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:30:37 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urde2-0007o4-Pz
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:30:37 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71fd1f94ad9so9135057b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391428; x=1756996228; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=uB34fD/YRXEwpi4HCFJ1YdJey/sEgetzyyUp/FoDRZkbs+tKfRmmgLgo3wkv5E2hEK
 opWj9t8r3X5lhlzB3q4sTUuH+ubOKBCd9Uxoxk9iZi8kyNZASzUHbU415FrEY3W21oqu
 Vrmw2qV5a5pdmmCoCnCwFs/FKa0QybP9w0fNng/lC8HZNBqiVp7t1naLsNkOlmyJMlxv
 8FZh3qzZT3VoYhTUs0+sw++o55s+lJ79+zwt7zRq/to33+LILkzWPb3DsTdN+mqLy2XV
 lDma+K3oSgRjBdK9JJqFVJlPtmX0FwzmkRJ2KFg65d5kSUp6E7Pk3le2XmV0z4xIqdzT
 OZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391428; x=1756996228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=Nm3P9tCXQyBsgLPHNfHdFK3mKPbjBbPeMkD6QPHSrVfiRE/U4Jku6X36GhoGzNIIU+
 4Dqra5bLqb8kIm9AJP3QjjfwSbUv8NkFR0fvrUFAPk/j79qop2kWeKQrgXvdkyJRBO6s
 vmrKLumDPFzeUScxkxhEhmcBYl+UU8HkF5UY/aOa56Ij8FvFpBKttpN0Lw5AfkVDH9J0
 SRcW9vtItzjy+mQ6jnzu4DNJ2DG3VPxzR6Q/79pP2a6s8FnB5xv1EHONNkQM3WDeuOD+
 7e/5nLAeuhXVmlan4jUFqxVzxC94qgrvhDxChkq0SAiHhhBNf6R0yz4rDG0cCISHQt0t
 93dQ==
X-Gm-Message-State: AOJu0YyH3rQsanb+QJKVktQkt3R4qL24BoVOhgcGLZ9GDOeiX3CeKgwA
 GpiemMRuAPbgyeIRCZISYM6cE9Ge+2x09ZVyrSkKokmEM/Ep10XZL6489u79U5Gds8q4t2nIR1d
 oU7HUu8atSr37L3qZJSpoA67wqRXQNmp409PJqvovcvTG7llbB+V8
X-Gm-Gg: ASbGncvpyNJ0gIVsZfbYKBErhFL0MwA4jghaY1HbHd+o6gGHI0BbdxnsVAm010lH5Rf
 Pw1hMxWUv0YpUnBBFhPoxmIhANxpNiVfVvYtCZF5ybBbTeBw3yiaC3QncfNQ/L0iyD3HPTMnynT
 KPZg2slXln27jlpO4xlXwjmNz2mxvt7GfRX0MIG5LgidUQZWe4wOoMpWv+JZlNutLmPkypHwmr9
 sF7Upc/
X-Google-Smtp-Source: AGHT+IGgXU5OTod7Xv83zPY8kU4fDlqrVSoh+LX7FZAsNGoISyaSurP1PHOabpgyXmmpTsSZaaEB4xHAPynW+S7TiPQ=
X-Received: by 2002:a05:690c:60c5:b0:71a:183e:bfc0 with SMTP id
 00721157ae682-71fdc2b8218mr258805907b3.9.1756391427704; Thu, 28 Aug 2025
 07:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-19-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:30:16 +0100
X-Gm-Features: Ac12FXx8fA3-4gt-cKL7WOtUu5inwvn81Rxmn36QrBjsOq6WX0dOgrcSAa2V1j8
Message-ID: <CAFEAcA9_hUHrGHgixbJzBwc_0gefkLiNk9gjsE-4QoqJx2Ankw@mail.gmail.com>
Subject: Re: [PATCH v3 18/87] linux-user: Move elf_core_copy_regs to
 arm/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

