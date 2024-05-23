Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24727C27C42
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA92D-0007lw-6V; Thu, 23 May 2024 10:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA91w-0007is-2U
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:02:53 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA91u-0001TW-7T
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:02:51 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e6affdd21so4192392a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716472968; x=1717077768; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BPt+nb7hywVmTI8U6ts2p8IFjc0iayqwxsudITFwFFk=;
 b=R1Vt5c1t3SD/0GfHvau2Qq/GpYQ6XsfV5jysartTUPCXpFRK6oRvBiAJkxTBSvFk6R
 VsBUpqHcuEFvARJY7hDyGirLcojh4ohaOhs44/g3fS5ZPf1yZVUlLPmlhNA/t8S9nW6b
 g1PIEWELEthbm/DDjlLdk1dO9x+/AiaFWM/yFUU9cGxuAFe1Ic2V/VBYRh93ciNm4GU7
 cesSczic875keo2ujZNgjhjCRueaG90V+V8JobG1XuyuyNPQ06MkEfc48vb4Zg7Q/a3k
 ccp8sBp97wA9UJCgY51KZ/oUha5MIyS6FPr4H3CJV639CpNkBcxVFmZwV7HAlSns3Snp
 Q1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716472968; x=1717077768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BPt+nb7hywVmTI8U6ts2p8IFjc0iayqwxsudITFwFFk=;
 b=ovKQdqrGOdcPUQ/t+EFLxtyl+DR/0pslmMgbV2+uM9DIX4c6u21R8X+9Itc9kWc6sK
 Q/C3KRqx6JPqEwQSrBsnhh6B8tNWVHPnubFy7IMNQqhdo7RkxD7qGYJ3Nngg/LiQrC4n
 9Uvfc4UM7zt/ffVDm9s4anzx0sadRmGtD5NEMOFOHWn7pxlnQW0IevarNRQbpJSbs7Lo
 +eZ53s0kioQ7ZP4Op78M4Dr1eSAJ8ywO7QojuX1dXXlKq1S0deBYnHwlDNbvpKIHKi5K
 r9pZjhrI5AagrvGFHTlYozB3V/baYofNYM2LTZLfDP9RzLNmxDXRFEKm5OJ9M6yqRD8h
 /D5A==
X-Gm-Message-State: AOJu0YxjVmwgh1VWyaA1XOuWduqIWA3XO5HfLtXE3g4rn3dREvEv2hD2
 1s/C6+GgV1r3rWmQUn23UfZAKDIuHMivlwFc7RKlPv4+o7WWsWDLR0kZtDZ/XlQc2dIWQV10nbZ
 2omzmyGxPVScXwdxlvoOFAvB2XXAfqHTV5MOKCg==
X-Google-Smtp-Source: AGHT+IHKMZ1NjpaVmUF70w2rrHpCIEDEn18F9g2HkHyXz0gRiKjyY0bC0mQD0s7++p3cfG2uFOw+ZNNZr0vm0JWfWx0=
X-Received: by 2002:a50:aa9c:0:b0:578:4ad4:7645 with SMTP id
 4fb4d7f45d1cf-5784ad4788bmr1099417a12.36.1716472968098; Thu, 23 May 2024
 07:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-27-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 15:02:37 +0100
Message-ID: <CAFEAcA9hbxVwFZAJH8hHjLRb-zPvsgn4E1M5Jb1fqOtECa2EOg@mail.gmail.com>
Subject: Re: [PATCH 26/57] target/arm: Convert SMAXP, SMINP, UMAXP,
 UMINP to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 6 May 2024 at 02:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are the last instructions within handle_simd_3same_pair
> so remove it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

