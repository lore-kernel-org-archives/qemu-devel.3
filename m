Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5A1C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HN1-00083q-4x; Tue, 07 May 2024 05:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HMn-0007gm-R0
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:44:10 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HMl-00083o-VK
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:44:09 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59b58fe083so432732166b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715075046; x=1715679846; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rxwyMmfF3KqdghGwiS3fdlhYvlXBRfgLw4N8EEu+e1Y=;
 b=iujU1kHCsc2XzI67AblK2gfqCQbulVevsGpw/jzokx8Q8dn/mAXA2NthcQ/JDkJmSL
 xy19Jk22j5PKnnDZeU1AuoGArb53rl3eAGaZDP6sGoF31bO154QPS11htjyXyzjlOi90
 qzx4LFPu/bPPa0m2vgm7kl0IpjG0HaNo/onUSJU+ZpTqbjy2layaZWfaj/hk01nOj1rh
 Mz9V16x5WGyAIK/IC9YevkLyFUhtJOwy6fPuHzqjc+ZL4/zg1TdvSNTNXo60cTY41sXo
 pB5FyB9AXp77cPMgK+Imiou11777q+3GVesCf8pQ6jOl0NjJgTDBtMwkDUirW/ORKZic
 DjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715075046; x=1715679846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rxwyMmfF3KqdghGwiS3fdlhYvlXBRfgLw4N8EEu+e1Y=;
 b=lRnKolT/7GWGsw2ry4czzU1p/XRXffnpuV4jTHwwIW8MAbl8crlD/okLW8hF6RyZ9e
 ZyJYlcr2m3WbEotUpG8zosc52I/uQTY45B9UavezuIiddbH1Pph2YC+3Hm9JRCyWGxi2
 aOKIZVb48nL15IYJfls/ekkm7fEcMtt9xLWYRF9LP+TOv7xgsMiz5o4FMMStDKf+mAIY
 jbMNfZriEMIbNodE+uUP85UnoTqVG6ffM4siXCUT7V8Mxp+Ai9cpkZc+/iGLvc0YZUI6
 kyku9RHnhMfoztwFqhUYQSaqxAstlmQMPbK923t/bwWi77d4pKDiZoAScqeahWlvvrVQ
 i5Cw==
X-Gm-Message-State: AOJu0YxSWesg8/85cE8JdlDqWpnwSazC5PWCZ7/C+QizxlB6JxwdA9hs
 +H4TW4v4SjeADGaQRMEab3qiOOOaHU6LPKAeJai8LMB7kEUSRImSQ4qFamVZvOId2kFE8R+4d8o
 CYdHTL71G0Ub4ZYE37ozoex97f0EnXtNKZYDto6a8Z7BlyrCZ
X-Google-Smtp-Source: AGHT+IEbDSbeW0gukHdeXT65fucysl1sPG9EwOdpZ+RaKe6c8srHk/RbyDyp9cyBB98ROmErfpj3HxlCk48luzmOvNA=
X-Received: by 2002:a50:ab5c:0:b0:572:6846:b899 with SMTP id
 t28-20020a50ab5c000000b005726846b899mr6898027edc.41.1715075046321; Tue, 07
 May 2024 02:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240504141733.14813-1-dorjoychy111@gmail.com>
In-Reply-To: <20240504141733.14813-1-dorjoychy111@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 10:43:55 +0100
Message-ID: <CAFEAcA9GFu2SvtdrEcH_S2kfc_OCQCyhRbKuRnKgYw9Tw6fvRw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/npcm7xx: remove setting of mp-affinity
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, kfting@nuvoton.com, wuhaotsh@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Sat, 4 May 2024 at 15:17, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
>
> The value of the mp-affinity property being set in npcm7xx_realize is
> always the same as the default value it would have when arm_cpu_realizefn
> is called if the property is not set here. So there is no need to set
> the property value in npcm7xx_realize function.
>
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

