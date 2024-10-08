Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C3CCEF17A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAxQ-0006aj-Eb; Tue, 08 Oct 2024 10:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAxN-0006aF-UJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:12:57 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAxK-00076i-MS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:12:57 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c918c067a1so281778a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728396773; x=1729001573; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1lXif4RUJBAa4Us8GfRhA66sgDxsm7TrrGS+Pr6tRns=;
 b=tvrC5KfvqHxxv4Is1WA1vR/jtwYRuCaeYh6zB/t49jCIOvPmTmJcnhiJI1zzLwpbB6
 MHak6dIw7FfKlwAeI77ieDM0aCyvZ8HgXUZYoNHm6rdzCrEIyIShPa8ja8wFVxxPPkrW
 q1pzaGDE/rDGixVSHr/v83HOjKZD682YzPiuJ4q5Wq54ARNqSUt3JiR+SE3q4NxKtSH2
 AybHFIpG5HNN1QE9iJn5rRHw9DD48Px5bYSjOb91/PZ1HdKfe1yG5vZbbV65+EEjOmaI
 akLs9NeK8fexf1wCtRFzmTqV7WraWfywZSC1KA5xbKEc4fu7AW+qGV1Q1a23evQa+7nc
 /+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396773; x=1729001573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1lXif4RUJBAa4Us8GfRhA66sgDxsm7TrrGS+Pr6tRns=;
 b=cz7TK6ntivdtaZqHSe8cLwwvw3NYHMaA9iBALYZFRJGMbkGOwGwXFDuD8QKNUFwR9t
 ECUjULIeh23+SanUNsWaaH+hagk9r9h7klGPz3Q8l299qbGV6pVFU/t9+uAjYH/7He8i
 tx9EutrIw+Szll4FdhSpvycHSRAKr1JvDYdGtTO97GaSGOeylIAci69gUsYlkZ+lcLM5
 h37GAucv0WNJsIO9FnnRYTFPAhSDllUCMZ+n1nnMzhj6W/wyiZQNPtf85UbXVyoVKuS7
 4qriq6Zp6juMYm+6062YlhDKFUWqlHxjk+oOcvVasGVv/FXS1Flc0Yipbajy7f7L5sQR
 xazw==
X-Gm-Message-State: AOJu0YzmQUK+iYgYPmzWL4q4gFZVPh1RkBGIok3+UcuM9pxpvKcHzTRD
 g3ngbtj3vb8NMsmyHcZTHOO54F8yDygKWtH82ZrpU2FYO9/VBIJu61JQGpddRok7DY1tvwvZ4fR
 Z0YWou4y1d36TxvfOF65xkkJsITHWs7ModkgQEw==
X-Google-Smtp-Source: AGHT+IEcDc2sIhY+0z9mugT3adwi3ou7mwIvwU3589KDMI2IU3RWaTS2embnO91yYcHNIouo0MisPyWHIBEyQYrQlQs=
X-Received: by 2002:a05:6402:4028:b0:5c2:6343:8ddf with SMTP id
 4fb4d7f45d1cf-5c8d2ea0879mr11698041a12.33.1728396772504; Tue, 08 Oct 2024
 07:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-7-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:12:41 +0100
Message-ID: <CAFEAcA944zo89gOGhn8Axdi4P+vWqATo7qGGEEMDcwPyAD==7A@mail.gmail.com>
Subject: Re: [PATCH v2 06/21] hw/core/tcg-cpu-ops: Introduce tlb_fill_align
 hook
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add the hook to struct TCGCPUOps.  Add a default implementation
> that recognizes alignment faults before page faults.  Populate
> all TCGCPUOps structures with the default implementation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

