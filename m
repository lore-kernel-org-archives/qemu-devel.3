Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D5ACCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68m5-000650-5H; Tue, 07 Oct 2025 10:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68lu-0005vQ-M7
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:34:34 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68ll-0005c3-Ip
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:34:34 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6354af028c6so6305379d50.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759847660; x=1760452460; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=up2pd2h+xw1eC4BsvbiSd4cik8lt2ycq2b2BMwznzo8=;
 b=V6q86VLqkzoicYiF4+KNAR44n1pG3xgZUszAtS2nDBIURyn/SJnjSgUAdNI5zCwwWY
 naMEhpOg1W+Fgp1Z2sEkunjggKdGZ5nQpcHzoylQKv8SNzK4RIG3bPTMCIg+iCvuI36D
 w6o8reBRvCgr1UJ5ptm8P7EvCzZ8p1n8mVxs0/xkBo8r8gblPbdM40VnQJaSUbj23+QJ
 RQO+IXCD3gwMnNJ3x3v2c3VKnPH+sgCRbJiwb5g1GW63o2H42LZYtJLtxDS1TC2FE4EI
 0Tw1bR/p4x75xdkAmkz5om+DRNbu1h/Ecj4vFF1zpupS20WqCAhokij/K3NYXSAukVP6
 GCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759847660; x=1760452460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=up2pd2h+xw1eC4BsvbiSd4cik8lt2ycq2b2BMwznzo8=;
 b=IBApcn/R5aQWBUvxq55y7qt+3Yq0COQcUvhbyTMMQPssbbbCmmgZm4A/uu6PmNPGha
 Th6vaNtJlGGIrP123AxlI6PKz7KSGKEroSSz6LF0wX8smirLwg+jIoCns95VlXV1TsrV
 h9y3wdQ1WmZrRJl9/SANb/GXoEGN6wwXHNAdLLfcYPfuTryC7QC2WVNC6MvEjAkv3jBp
 1WXXmmAr7T/U63BhoO8mUzfQ06uIQ8sO/Ed48AfgAWinfi94KIKi7vDEJ2vczERc+sjZ
 qiDlnADLDXErVvBQDj8fSYsWi+c5eM1NBQx8uSE6zqfxs5B3F15w+uFhYv8T4iccv7uy
 72Yw==
X-Gm-Message-State: AOJu0Ywp530pAwthlRv/iNuOcdZiLj2GSC/TS16TWLlGqdeJ0+L3uifu
 mnsu7b5CbME6GNR00BzHN6TU0fHdBG1+qqfSsZm3V20KKEkCysLqaVwd7GWOCRxsIV9Hb7PUQZ8
 OD3d2epwI7rakMD8BSbYUuRGz3450CXUhBQ9+9qY4Nw==
X-Gm-Gg: ASbGncstSFCsOOjufmLuxdgIMj71LMRWI20J7bXK4NVMxBHO+gkCBJd5MLE7U+AROr5
 U9rCoR+2boOn6GZg1f438CXFIJmysk1T7+c5RTAuQ5IyUwu/fCRbY5NeplR47FkuDXN49+oepqc
 B3By93udmTJDKRFA7moGhyyclug/sasRyNjeswSowa4tf1zCn0KyFpxLPcRqB+3KJByfiM8bPUD
 n40+0OvIrHQSiIuDPENkFCf5z1SVKfGvKisDZgawxT4aYc=
X-Google-Smtp-Source: AGHT+IEus3RbHlNqq6rk6mGzCzdln51dHABWNqkN5+MtEJEwGR+B/kB8Tjg8+RnCAOA9eXK6t87ikfky0AND5yK7XOQ=
X-Received: by 2002:a05:690e:1552:10b0:636:1fd9:d64c with SMTP id
 956f58d0204a3-63b9a071c12mr12573769d50.8.1759847660445; Tue, 07 Oct 2025
 07:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251006001018.219756-1-gustavo.romero@linaro.org>
 <20251006001018.219756-4-gustavo.romero@linaro.org>
In-Reply-To: <20251006001018.219756-4-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 15:34:09 +0100
X-Gm-Features: AS18NWAblrMYWXxraQ7E94kBiphBp35BbAPRRhJJqYPBDjUQzkQQfH-4mzlT6rI
Message-ID: <CAFEAcA_p-zJVmEGujPamQgecuoPENKG9ubi_0xAc42UCsMkYpA@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] target/arm: Enable FEAT_MEC in -cpu max
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 6 Oct 2025 at 01:10, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
> first step to fully support FEAT_MEC.
>
> The FEAT_MEC is an extension to FEAT_RME that implements multiple
> Memory Encryption Contexts (MEC) so the memory in a realm can be
> encrypted and accessing it from the wrong encryption context is not
> possible. An encryption context allow the selection of a memory
> encryption engine.
>
> At this point, no real memory encryption is supported, but software
> stacks that rely on FEAT_MEC should work properly.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250711140828.1714666-7-gustavo.romero@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

