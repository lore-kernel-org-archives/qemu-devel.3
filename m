Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51017C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFh-0001ia-32; Thu, 28 Aug 2025 13:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdeM-0005Jo-BE
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:31:06 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdeK-0007pC-B4
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:30:50 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d603f13abso9435797b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391445; x=1756996245; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=V1YTDrZEQMXm+NBmgI15fMVUC3vZqHG3Rku6Wx78+B4+2f41RnWcaM0BsaSZHDR7Fr
 7Zn/3/ARlsaVAS1TcUCiwAziIr+bf/dQy0eRTipGy2jiBbKwFyNvgw3d5s6z5m3T5Evg
 dgbBv+8C1xtDgcTZ2P9WCzojyTOjru1l/XwxF3xVHdNzdrDqprPzdE1XFO4e5NrS/HXD
 f7HTIVeubHca3PuXn8uZ3k29IIStDFukTwsBoRMj1DMAL0AKwRjJF5iwdiSnb82yySn2
 ii0mh5Md5h9HWgabvt5CKKWaNOgYXOhAYgXMEnpoO+sqZJkALP7l4wmJGe6D0aPh3brA
 NnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391445; x=1756996245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=IGlz7r84RLFpbGximPvRjonSyDmnYLx9SLminu933Uf48C4bPTYR4JIa4uzzRYxIVk
 qUYN7MyNkAvNsyV1bWPaDwBBoQn8euPYQ92lRsXc7AiCMbgcOpvWoFQuRnPneL773WXn
 y3q1OlF6/XxaR0UH/rv9yoFIGMPs8yC2QcgbaeDn0NDEqJe07oP9f2GMewprnuvCsQMh
 Et/uK5x1mO66RZmBUz0ukNnJDJbM2g6FvcdmA3QLt5Cz5WfqMNjmczZQBappMswcnYHA
 Ga21k+08qyzEXXFnJFlpxmrweA6k9RT5PI9nsV+9iQodKVIzVir5KMFKzLgIHqGH+8XB
 sUDw==
X-Gm-Message-State: AOJu0Yx7pBpQ2yRYbApqveVqCfm04Cehnkj+DO1C47rQNpBa7bhoQ31s
 flPMEsNNHY8xAJXX8wpgq9tvj8u9d/fYUnbQ3ZmJbfaIRhNhHZ7BBUceMg6cdftilyMasSuyIZ2
 7KQkV7UrkF28vRB3IIUs1reWh7e3jRRXCcHYiTYdSxA==
X-Gm-Gg: ASbGncvXjdCpMWFifG2tUDzqeL98TUXXT2anUVpNO9i+pSoFweDlvm0Rkq/zYbhdcgD
 TXxC98ftEVN0v4b4NWe2wHyL2YUSSLJkBO8okenkBtrgEWJTlsWDacGNCBg3J1s+hJwMmS5lnKY
 7KCKpmKZugbJ5gph0jI71moGw6eEvHw3YVlbTtnrgNx4xECL/NoGcvqs1rS0i+jBhAiXJ37jAFK
 VQUjAt8
X-Google-Smtp-Source: AGHT+IHi67psymPhxSiZJc7r8821pKLVmha/e5qEta33T4BySSZsUWFu1OjScOvVofEBIkznSBnYihCuWiV8W38tOCg=
X-Received: by 2002:a05:690c:6b0e:b0:71c:bf3:afc1 with SMTP id
 00721157ae682-71fdc2ee8e9mr266417807b3.17.1756391444310; Thu, 28 Aug 2025
 07:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-20-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:30:32 +0100
X-Gm-Features: Ac12FXzy3tYnDVekpI-Amwl4FlJhoj2gz0pZ-MIQid47xylCkECgyE1PUgLycT8
Message-ID: <CAFEAcA9ucyNfXSn8yE4DN69U1bxaUUQvk=NhktBJ0hCcT-p11w@mail.gmail.com>
Subject: Re: [PATCH v3 19/87] linux-user: Move elf_core_copy_regs to
 aarch64/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

