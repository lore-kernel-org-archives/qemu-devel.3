Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A32C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfn9-0004AB-Cn; Thu, 30 May 2024 09:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfn7-00046t-4t
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:26:01 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfn2-0000ql-80
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:26:00 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f45cso892930a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075555; x=1717680355; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rleXSPuja6127256vP5VjxEvlE3lS9iylunzhrGdEnA=;
 b=dZ11ceDayEpC0+UDR3pmb+v85TA68ZSehgS28zAWLyVWpr0/ePoOL9j7wUXsHcsvVa
 sNSQXsWQD1GPamZ/2kYIgIMqL8+3pJsMUB8VBLHpoyb38ZCgDEl8t5oO7DRQQPiXO2GF
 +2ujS5SDk4b88PFqRocDhPkEG7zPTszBUZezqkyKvM/y/Git+7wRRVhEweKN8cEb2Qyo
 LwX9Ta3Ifzi/ukRpkYzCUS8PVAEbWqwK30x1Jwr1HMhZ0utlDP8Jg5h0Hf4Bey6k7AGY
 8upoOHaBFdw4/LM8tzQEmedytEkvOL1v4cq2yy6fXEwP6EXzz6TML+TDpumf3Ns6xacs
 7/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075555; x=1717680355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rleXSPuja6127256vP5VjxEvlE3lS9iylunzhrGdEnA=;
 b=Mf4a5Eqp0/2AuUTmJYxTI+Ft1EYoFs2MEHdHpAofcRDLiWpVgxJPQzbTj4+iMcfEEb
 6PNVgJquXoRULOFoZN3mlxZ+EipGIFTAtbT3p5v6dmotUfkkXMUX+exqLjjLSx76v9G1
 DjC4+kA7G2mB1lbc0FDPg2UVyPvP6xx2JuKDj8CLhoA86uktlwWL6nQ/EAq7NNbP8XwN
 zmKaBMnelbi/Y5Vao+4wu4dcpNWjKevVbTa7x0GlIe8fxyN3EOeUlalU+H3yOt5jMgF6
 U8wOv8EEHcrpaorFOPfSH33MZXLeGWunngJcubSGsxF0VqdT3sJV59lbl0/x7Tn/kZm5
 ZzsA==
X-Gm-Message-State: AOJu0YzC+Uke1hm+4AY+pQESdZ+mukklHEsqEAFQfeWI4ubXblU3vVD3
 NFW5yP5lXayOl2ddIWDTa7A0WWkhTOAwRHDRboM8vuPUTBpbFgD4Sspn0t6mMQMWoao3jE2tTBu
 8HOzNqqLZU1WvYIphh5wLo0psiZvW9BN48ipJwA==
X-Google-Smtp-Source: AGHT+IGBz+clmRQApkVMgVVh9wUzexDeWDoMAW+C2E53RlgNNDqWwUM5jitWM2AG5iJfB5pCtHpFXmXr+C2iptj+cVA=
X-Received: by 2002:a50:cbc7:0:b0:572:1589:eb98 with SMTP id
 4fb4d7f45d1cf-57a177f7eefmr1257517a12.12.1717075554694; Thu, 30 May 2024
 06:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-11-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:25:43 +0100
Message-ID: <CAFEAcA_MPdoayJ8VBtp9xf+yLwsqWfHL3wi108hgPwrYNvP6Fg@mail.gmail.com>
Subject: Re: [PATCH RISU v2 10/13] sparc64: Add VIS2 and FMAF insns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 26 May 2024 at 20:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  sparc64.risu | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

