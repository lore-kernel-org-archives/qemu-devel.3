Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5FCC87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 11:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWWe-0007bl-NS; Sun, 03 Aug 2025 07:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWWb-0007Rh-B3
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:05:09 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWWZ-0000SD-Qk
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:05:09 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71b73225060so20952117b3.3
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 04:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754219106; x=1754823906; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rU+Nutu7V7IDa1XDpB7OzvfVdBw09YZdHxIfKTSeiLY=;
 b=zxHoTw8o2fCCWprEAGxy/xV6z3+McdzlA3rmLUywcGJwE/qo7tysxcrfCoPdppPYjQ
 J7L2Casgg2JwLpjgx1pE/PovubLHoUv6xk3R4ZNH25tH3ceeNE37Xgu5gCIrY9wzkTBx
 4O2XlzeFLr+TafdB3Mgd0cwdjtye/v+/3hdSsX4BgINt66kbMKSRTjQxQlIQdClhn5h3
 AWICAVp0JYKmICRdAM1BlBYHn4vXYR6qRQQa5N5BJdPPOeDljGFg2zEYaAVKGOQBVu/Y
 FnW04sVnZQT+krVWg+5TMWMgqolq2TYXZMpW8n2r+MUJfLD7QGxXYKTd5fON9lDMJyXC
 YR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754219106; x=1754823906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rU+Nutu7V7IDa1XDpB7OzvfVdBw09YZdHxIfKTSeiLY=;
 b=tZ1B1ZwD8a7t3hXlmETYD9+x7snz6R48H01t6w8e8LSrL6n7GKj58ricpZlhSZEHaZ
 v/pIsFwhz80ksE99xsfvZu6Lquwgiyf22GhlTt9Nev0Qj/HvrJE5G4qwxKOrnrQBr5yg
 r7wJSdOciDbF4EyJrMWswV+dTrSMooF+mxdbV1+OM6Fx3nf6QB4uhqQAH0RUSf25LrXw
 WMhJw4RS2ghkloQugDf09KaV9MkHtHGksD09UquqskCUKwSQ3nP0BVgya+MLockAdHMZ
 CAKQXtJ+KMcZSkrk8TJYRo70F3F/cz13h+FzoWGzfzP1w0PvIV/iDQeqgbIK/0bHt7TM
 6nFA==
X-Gm-Message-State: AOJu0YyCk/oigRAumHM2lFQo6zNcZb9zIACeCXAljlkm4+GseGCUsDwX
 J5VLR5eZIUkLZJHsNBlvuWLdgy6iaNj1PYcxuAzGxOLdKvXb5A8liDNVLEOejsyEu4bY0xQsKh1
 OmYRwdyBERC1rgvzwTQRC+0qstFSXajiee/6TH+y9B3MBLMbP3zZm
X-Gm-Gg: ASbGnctolW7EC7UpANv9pZrQeGyQJ0DHVp6lDFDIPOdxClye4DBulUaIDHNJqEfeL7T
 ENwmNoi3MQHI83WA2saOrzwp+onELBCy5Kfp6fScGDVVQdkQw0i6vwKn+/JoRkEdyYYsrk2+rzj
 g0wyyKQPmwmW0qEzypl4G7jaYggvJt/G1x5Oc0tkG/X2n3WONqh3g2cvoNMl2ZKEy26lUX6BGxU
 WOZNT6M
X-Google-Smtp-Source: AGHT+IHA+grUtOOHN72qozI9ytKWovPPYqhf3b+Kua8g+ET369LJIKPq6haN8jKXZrCxT+SVuPSt8E5FxNi9RSreYTM=
X-Received: by 2002:a05:690c:d8c:b0:71a:27d2:2bdd with SMTP id
 00721157ae682-71b7f62d7famr81857497b3.13.1754219106554; Sun, 03 Aug 2025
 04:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-62-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-62-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 12:04:53 +0100
X-Gm-Features: Ac12FXxQRi4iJ8SrjzEkNgF4Ck-n0X3qXcXqDeTAoNpHoMjS43TuZVqcpy3jDRc
Message-ID: <CAFEAcA_GdCju4pXMgUBFqQwXnAfCghKOBD5HcZrqaMt3QbwKYg@mail.gmail.com>
Subject: Re: [PATCH v2 61/95] linux-user: Move elf_core_copy_regs to
 xtensa/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Sun, 3 Aug 2025 at 00:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move ELF_NREG to target_elf.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

