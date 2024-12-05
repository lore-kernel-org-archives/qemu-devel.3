Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D86E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFoK-00070f-AN; Thu, 05 Dec 2024 12:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFoJ-00070K-7x
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:38:43 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFoH-0004Q2-OJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:38:42 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso954575f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733420320; x=1734025120; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UgBO6gIx37t5U4S0qID2wzdu9LiHMxmtrvX8Yn3pXRU=;
 b=v+inU2KhoPU1bFV+CV+JO/i8LObsFuHZ63XgRzk6UaM+Vgcnal1+EZGf6cDMY+KOD+
 soGnprv+jsS8FdMyGGNqsE18jlMNblu0e/p3usfCKy1a2/BR4cDkq24wtHwzZa/clGqw
 dd03Slo3dLn76lADqRgIXDR0uM5kYmcj/VbSAEbnjCjk4DMpAzr0ROLTodA0Adrxhe9b
 JfBia6K+PEtTPx8jBsCjk4nNBqdHhWlD8TdyPTs2TaD/kCulVIT89RvIXVtFGk8Bcj0Y
 ETLalMMJAR/f/NvMwjQbl+AxbeEXmMBmDerIeYXMirVu6+dr9LJ94GLQppPqoXmKGFoY
 bCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733420320; x=1734025120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UgBO6gIx37t5U4S0qID2wzdu9LiHMxmtrvX8Yn3pXRU=;
 b=CCMgxk1FlrQK8B4ITTGQy9IsrRYVhcVgQ3YUKIyALxNKMP0KNkGqvy9c3MajWYasBO
 NXHMVueVrdN7ri7SbDE/5mE5AKJiWJxCAaTFgQqjKeS4Bk5DgLMtMmvCJ4FK0UrNOdTw
 qbjqGdD5gZDwhw0q7Sv2EXHYN3HJNdk5ds+KJCn+W27tYQo+VZHvf+dWJT5hZ/mdBzwI
 kmACbQrPAZgs6roQ+nfruMQILblVABKnm3lV0FXuWDtns6ZuF5w3v1YhTQ61KphdKMNe
 5g3Q+WvMzohmE2V9evGF9oJcE6nw4BiE0ok189djdZ/JZBwOHgNSYJswa4REYpCrQvkp
 fiVQ==
X-Gm-Message-State: AOJu0Yzoc3dMteqECB0msPphUKTFOySy8QTzpbt9C413mH1odiN6z0lX
 m1tJqmaciqDFUfaBPTIoMaB9y9mTTLVuryTVnxnRAsMRnnDV2wNtbqJRafDh0vCHHuVH1vMRWTy
 3KqTx1SFyG0E9GFRyL82OcDjbDhY2rvbka6TdRSo6697haPmo
X-Gm-Gg: ASbGncvvPcVA7nXb7ITAyBnvOAiJIePGejufhojulV42Yzg3+0WYEnV/8LiGzE2NE7A
 5sUMrX51JagfREejqfXTIRo/AQl+JPO9z
X-Google-Smtp-Source: AGHT+IGPmrdvlqtRYDSezmV6il0kX3iNWrtIpCXYBI+LjlaCMmdWe3g8cmsjGN/xgmmbZhixjPB9lBgL+OfHtS0QALU=
X-Received: by 2002:a05:6000:2809:b0:385:f07b:93d6 with SMTP id
 ffacd0b85a97d-385fd423ac5mr6461433f8f.45.1733420320136; Thu, 05 Dec 2024
 09:38:40 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-12-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 17:38:28 +0000
Message-ID: <CAFEAcA9ukDtrBsiKaDqMfEv7RVSYAYVf=GqU6sML-J6k6W0npQ@mail.gmail.com>
Subject: Re: [PATCH 11/67] target/arm: Convert disas_logic_reg to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

On Sun, 1 Dec 2024 at 15:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes AND, BIC, ORR, ORN, EOR, EON, ANDS, BICS (shifted reg).
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

