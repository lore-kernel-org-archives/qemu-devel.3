Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AF5E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJG4y-00051o-5D; Thu, 05 Dec 2024 12:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJG4w-00051O-8L
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:55:54 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJG4u-00041Q-10
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:55:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434aa222d96so14518225e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733421350; x=1734026150; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9oEAsEbXO75Ds842USNMvm28B86C6j12K/EPM9t9A1A=;
 b=sKZ8tVYsQT44c7cGHJuPn2YIt8zjWQgeHnGBg0unfQ5imF0/seU443eo9YWXtTe8ya
 xLra8B81HqvU7iTeM4PiR8O42N7WtriGPzeLck+j+GzqUkDerk7kosi3i0NYERf5eYnz
 CzpyDkW9Xsf4wwVdeKg7gTkVWYqbqvFmprH2vuzDNewHb06YLj6R94fRDYb5NlM7vNc0
 R7A1P39rKA0aNMfyK3GZ4W374iYNL4W4AvZBnhwlLGUlTZFb/LuOoDMM2GYXuIVdKUQ4
 W4iVJVQ1/GDYG+450ql6BawZqNrtbycZojQLzkFOJyU2Amz9WxWQv799xsPYcSRHKEUG
 ChfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421350; x=1734026150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9oEAsEbXO75Ds842USNMvm28B86C6j12K/EPM9t9A1A=;
 b=VCZLFyxz+UAIfmfyH2r3PnkABHWJ2c6AzSR0X2H1LrK+b8R2xM5ndAs1JusX2aFE9M
 yRJxkOOpCnUZRY6mh3PbncATEqUd79u1/SZi4SEWFnDFxE9MgrZPIAXP4AIEcK+vHWR2
 I1vTJ9+Nm9twYdGF0enLrVG7DXeMeYZu13gd64lByCHlF81YIsm//Eu6ELkeCwriY+YZ
 igNtj96BlBpEzKursUcupuHePVNcZi+q2OtOawt/dADxQGcR2CnTkGzvvHeFacaVoGMF
 TLELJLTSyaey5Dv6YulZ697oMNIoIufEL6CDLdA1qk1rBLzA2AzM+9bTUZQ7cfoq+lSj
 YgeA==
X-Gm-Message-State: AOJu0Yxh5rb5RP3HWzg/s0IF/QtDQoEKEkhhJizjLR8WinmUyGfS//u5
 DXfpME64+TfmVxAL6OTKbu8lFJRB8j9tRJzZUH6zOUri2C+ioGGo3Z1Rbd0P7jmo6DQr7giWMQc
 c4hI0UhWD6WSfDEcyfq/Sk6PLndad3KScuoOIKQ==
X-Gm-Gg: ASbGncuoZs0Xf3EXpa/ythD9v5TKHGSlMcg7TNGeCjyg5vpyKVMHlwQz0EiRRczztED
 2GRcGvFKuqOm1Z3sEUbel7zjm9xGFXe3l
X-Google-Smtp-Source: AGHT+IEslY089SVPlsdFW35AZEIFRwu1quMjaMMhHMc5+HcSwfRocM4Rmv+Nfr7xr1sMMd3ZkcGASiG/2/xAGzlUqeI=
X-Received: by 2002:a5d:6d01:0:b0:385:df73:2f42 with SMTP id
 ffacd0b85a97d-3862b37bbb2mr8444f8f.32.1733421350138; Thu, 05 Dec 2024
 09:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-15-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 17:55:39 +0000
Message-ID: <CAFEAcA8LhQ8w61m4qnU=SR+ZfJGeYzVCcp-s-M-+SrN7RSo97g@mail.gmail.com>
Subject: Re: [PATCH 14/67] target/arm: Convert disas_data_proc_3src to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

On Sun, 1 Dec 2024 at 15:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes MADD, MSUB, SMADDL, SMSUBL, UMADDL, UMSUBL, SMULH, UMULH.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

