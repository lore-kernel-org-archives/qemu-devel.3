Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F7BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzHr-0006HB-5z; Tue, 28 May 2024 12:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzHp-0006GK-Q9
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:02:53 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzHo-0007oP-7b
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:02:53 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-529b79609cbso1748344e87.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912170; x=1717516970; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pHpodULsqsdzeSAudm3146gsyzitGajONPimXbKis+M=;
 b=D0p1GbuLeilXU1k0sXMWzb0/lWMXlhV2uX6n2R55Az/UquZvXvI5VoXl0zE6xfcKi+
 As13fGf6+cCGzGAlThxgRFK/LU+P0tmxkepiMijjvJ30U5ap09PPxxy1EN0RkXIlaimu
 z0Ed7ZkRxUKvevMtwbFWA059JzJ5AIMUJRZ4KugDn0zC/cSMUszuKWBNsXpRzMVVB57M
 spsAOTKSXL3t+yL1SjQqi4zcNK5Rh3xlOpZBPNP2n8KhqJj7lzCw2JOpVmDuYiigqpeO
 qOmKY3BR/fMot7VyX/pVFqt0WMiYo1nfvGb/FaMUt3oZEuKvlix3rynGGRiBEygc1GGD
 066A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912170; x=1717516970;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pHpodULsqsdzeSAudm3146gsyzitGajONPimXbKis+M=;
 b=tkZGHv4GGKn/fZ+NwhW9yb1l0MB9+SR7DHr7gGxXRa19+Cg2Icykoz1nriJR2tXFzW
 /6XQ3L8NRWtCHNk1O/dUwhhcIvNC3gAeIU/0xpy/J3YFR0oDD6zb/otgLwj9DMHetonO
 fsBwvqVvXHYXOZsfJULuRTD8eJUXBkGlkiwtKbDwhVimlsFfs7jSE0qGtnvMJLGn/YpF
 tPmsnr+B/jnvmenhb+PCwMwEdzuAy1U9hb51vtclx90BukQ3zA9sH53wuknLn7GIlYMH
 RHWEWIJJb7MMpoQq2UlXss5VF3M4F8XM1+RBOB03s0FkeOM3A7qT15gvM2txXODEZTUt
 KbnA==
X-Gm-Message-State: AOJu0YyKtnmfZAkgRLelOQ5vZVrFSBFZQNAbtfXf3WnbbZs+rpKi04zn
 N4JcYKosw4jdUrgDSb2iV/mNYv9pbWscIejZ3dcPscVUrXfFF6kgOFPuhAbb+vYouFnLgWFDEKN
 Xl9o9qMhIJiOa9XVSoiTI5WBQLlTqiYAv9SrtRA==
X-Google-Smtp-Source: AGHT+IE0KCIKVLm/pM8s9L2sIrWjW754InkYcgcFxpVSjevDtA5u81Rlaw1W3t+PI2DAenMwmqY8hMWVnSKVSKzwPJE=
X-Received: by 2002:a19:914d:0:b0:518:dfed:f021 with SMTP id
 2adb3069b0e04-529645e2b3dmr8113469e87.24.1716912170320; Tue, 28 May 2024
 09:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-58-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-58-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:02:39 +0100
Message-ID: <CAFEAcA8j1CV-C7dpD9GQzHFZ4iCCvfzN3UoWTcWg4xkd+E0BRQ@mail.gmail.com>
Subject: Re: [PATCH v2 57/67] target/arm: Convert SHSUB, UHSUB to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  2 ++
>  target/arm/tcg/translate-a64.c | 11 +++--------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

