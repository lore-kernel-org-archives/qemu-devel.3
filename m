Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13CEC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgTI-0003j5-Ro; Tue, 16 Jul 2024 07:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTgTI-0003fs-1L
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:35:52 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sTgTG-0005M2-8O
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:35:51 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-58b447c5112so523231a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721129748; x=1721734548; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b8mtSeHdgs7/KzJ6E6HcTqjOuu9I5+g5tFY5GMOz27Q=;
 b=x2I6XejazEM25OBayzfCZMoiBSGEqVRrt1LNpHuCr/p0dlXBQYp7UeC/tqAmn1Kued
 2lHet/mdQgb48P32G5A961P757lhd8jm7anrq5QMClm8oE0CpppPoaGsknenxkezhTyg
 CGLLHUHCs7kmL9iMSRSKhxOx1PCtHAY7jnmYhpqlZdR6OtejsDkSpELy5RNrwEyVdl/O
 tvkVChOmKqdnFCM+fGYajOmZGdgY1XiyFWnREYMX5Pjdi/64+4yefxWGD6WxzaUej2U9
 wxe6rtpoyO8OL0/YTOzrqYmxaM+bOmz965sypizPitinGL4Vo66G2sxdFBKY9fui42HQ
 awGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721129748; x=1721734548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b8mtSeHdgs7/KzJ6E6HcTqjOuu9I5+g5tFY5GMOz27Q=;
 b=rupobq8sk3ucEja6VIEAK09yTuzuQ+mmQ4K42KDdUdKYsiPZ5JrxSN+WXR4Wv2gYdW
 7BlGaRNSSac577tERAE1gQRptnOPc0PMtd33DYDQlqSMSgfnZwX4roDrmBxxPlZXINXT
 4FqQ1fYdGh52VXDrsBNUiBY4MG8bE5QacbFmnfcIdS+Bi3Bv19QrnmOsrf1+XRKyOk/0
 ZjKfudGzA7zH+jhTE2YEz7qJ7ok/A8yOxvZyan5zN/GMDAmDqTBObgWThpQlg813ikRC
 4qvjfb1KJc7jPSOSqE7EyM1JLBL+pjKbO+aLud3d490ry/inp0wrVC7L56WiyQ6RelO9
 c5Ng==
X-Gm-Message-State: AOJu0YwlpYsVgIjSaT4UCqy56B+xtxIizHRQfVjktX5wQWhwW/r6jOn8
 qSGPoSfzWaGNX/dXT1KMLD5zk7IoROf0lV5tCMxQMGZuDcb1RzFqffvV8vc+aPlnl0w/zRN6Jif
 KxddoONYAh7EyPIEl25WfOCr3URV0pqqOsJFW5w==
X-Google-Smtp-Source: AGHT+IGHwCHFI6ggmfZmb3IgedbXCEg/J6ydNGfG2gidnl+SwyCRov3cb2Zrz6bk1NnY4ZE/6CduzMDu0lgfndqeuHM=
X-Received: by 2002:a50:99dd:0:b0:57c:947c:52f6 with SMTP id
 4fb4d7f45d1cf-59ef00b5524mr1215922a12.26.1721129747896; Tue, 16 Jul 2024
 04:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240715055820.319035-1-richard.henderson@linaro.org>
 <20240715055820.319035-4-richard.henderson@linaro.org>
In-Reply-To: <20240715055820.319035-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2024 12:35:37 +0100
Message-ID: <CAFEAcA9FnBV+9MtvHf1YkaNxjKJjaX8iYV6gAnH+pUYYaGfunA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/tcg/aarch64: Add test cases for SME FMOPA
 (widening)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, danikhan632@git.sr.ht, qemu-arm@nongnu.org, 
 Daniyal Khan <danikhan632@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 15 Jul 2024 at 06:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Daniyal Khan <danikhan632@gmail.com>
>
> Signed-off-by: Daniyal Khan <danikhan632@gmail.com>
> Message-Id: 172090222034.13953.16888708708822922098-1@git.sr.ht
> [rth: Split test cases to separate patch, tidy assembly.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> --- /dev/null
> +++ b/tests/tcg/aarch64/sme-fmopa-2.c
> @@ -0,0 +1,51 @@
> +#include <stdint.h>
> +#include <stdio.h>

Can we have copyright-and-license header comments on all
new files, please?

thanks
-- PMM

