Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1EEE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZuf-0003v3-AB; Fri, 06 Dec 2024 10:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZub-0003um-PY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:06:33 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZuZ-0002LB-5U
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:06:33 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3003943288bso5535161fa.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733497589; x=1734102389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dgFFuH70gyq/lM9gnWJfwiCv3S27xgQExu2iFijFMpU=;
 b=j5z7rd0l7GyGk54ikkVIP0YJdF1yAekS8EUk7swYH7Dr0AGmxX2BbUoFsrvSdbtgEm
 tbtkfO1x+74vZhKXPn7eXJKtqS8zkyiDTDAWjvqPy7cWzG+UT4Qv/K+/KYhfhZFdgSUF
 axT+0yKUJxeldF8mvE1tdC7QU/tHGLUwdMZQdNGDCWseR+cZzp+zkANNFmb9KkKTCvYt
 rhwnbvpUPEWfmTV6wZa0/i+yLTd1J+HRb3mOKmJhErqiJCB/t/I6Dr04bWtLGHeA+tVo
 /2DBOAX26rQKNBytSx7U7KmArknwsAf1IbieOgmqIx9016MAv4lS/42oM0po17bspog1
 3tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497589; x=1734102389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dgFFuH70gyq/lM9gnWJfwiCv3S27xgQExu2iFijFMpU=;
 b=DlpQAS35+cxPItdBIObnvvwXZw2Y5fIriWd/3wcQGxCNG7uQ5uyWsVs5nAPl9GtBtC
 OkKollsL2TV9uQU0pEMrwur6YmY4hWbHRWdrXL9jWxoyiOe3pctk9Z2aX1zPKRttAJyJ
 z3RvPORCHFVstvSu1uilDL/CEI5wXZfp4xFzD7rSuz/Tf3lbt8mwPQiV82Ixc5N8kZRq
 +3Mhc6ItSi+7iBsgbvyHrjEuK1/vkyedb0eYP7smOzeQp2LViMwfwoQV6Fa3QulK6xDf
 6NGkib1rkMutoYqksknuQliMmsB/+J/YBYAP/GjxU3p5Gi8qyh+YxbDYLF3HOk32wUw9
 ZIIw==
X-Gm-Message-State: AOJu0YwoRu/nrdAsWnyDoByfxvPxoXU/HBPk9UUakjLsvbfQCDQOwhaR
 HRDY6LO7kaBbzmeqyqAoe1bU9Hx7fTlWmRgicaV8yr9sdyzFyFmRrPrS1gbg3r6HvHU0dZAxi1Y
 ScR8v+5mEnL5LHCt9kjXfZzkwUFvMdesiPnyLhA==
X-Gm-Gg: ASbGncvC0Da4JfMeQ5iH7jgz2nroWWr+BQaO+et7dbKLTBnzZMLHBJKYm0vO4IXSLLM
 Z3cbfy33sYGVWWkhIO8i7HofGib42FPEK
X-Google-Smtp-Source: AGHT+IH04ekmU7NBrKSBVkv8c5pVSBHucApK0gp/FTYQVR66K6Wrdxx69MAWrp8Z2G011LMuhP1/Pl2KbSq2xIcATps=
X-Received: by 2002:a2e:a587:0:b0:2fb:4603:da13 with SMTP id
 38308e7fff4ca-3002fd99ad5mr19445901fa.39.1733497589133; Fri, 06 Dec 2024
 07:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-41-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:06:18 +0000
Message-ID: <CAFEAcA8Ljk7JAAfkSgAk+JC2jnvKK6Ejr1bs2jun8H8O=C2xwg@mail.gmail.com>
Subject: Re: [PATCH 40/67] target/arm: Convert CMGT, CMGE, GMLT, GMLE, CMEQ
 (zero) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Sun, 1 Dec 2024 at 15:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 94 +++++++++++-----------------------
>  target/arm/tcg/a64.decode      | 10 ++++

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

