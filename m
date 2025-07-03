Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDE3C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXIyM-0005dD-JT; Thu, 03 Jul 2025 08:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIyJ-0005Yf-4w
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:23:23 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIyF-00046G-FX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:23:21 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7086dcab64bso52159397b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545396; x=1752150196; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBgsgIeawqL0c81jNvHXOOlPF0rya4pW0p9Ob7Foz/o=;
 b=MnuRV25NObniWLgy7IQwJpWQ7p2q1Zk0qDC03ePStEh58whm49c8y+YAyiflHH7EMr
 InNQI5g1TDQgPNLEja0oOLWoKbqpCk3KBXlIE5cj6rD4c0vBb9H3cjE95g1eVsaUMznD
 jqLBsXLqZAF4H1WPdi+1R9QtsZjgOnRCe1HbCU/T3BoeGmFAdZP67hQndTjE5kIqrbKM
 hBX50SkX2jEhWGZayc7dqCwOMUWHEdNm6e4YZ5gEtGl3Pbm53+Z7S+W8l9BCIxlMUXUV
 lnCD+vb9I4lxL4xpgT2ZL/LIf90bPR28RY75OPePFg3qKoRGTB1AJMHIKhMwrEJVO7V9
 wfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545396; x=1752150196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBgsgIeawqL0c81jNvHXOOlPF0rya4pW0p9Ob7Foz/o=;
 b=JDW3l/ZN89xL6aJ7QKy8okeuxBQI/47Ayt1xWeDNFhyXSPS4oUGvMzLwti4OmMVQqz
 l2/8FWHGCMi+RlX2yECtaN7mGX60t/QsVjm+2FE0juqDK5eZDsT5mxiNFogTE8LUv8fK
 ZQpPf28of4haAFdsS5d8WwC7veWHcOaB591lGIhfhG2GqqUV9grBUnloyeWtIZxSnI5e
 JSKgCGB88mui/Q2ExDXh5QnUdrqGr1CM67Eby6YewWJZkDH/oeRlFaJWNzzirgURI0rB
 4rPxASKBmaGzeZ6fiqYFn72UrvTJKIgLlo4Bz4e3l1qQccoFam7Do2kDTVqEt4nDQGmH
 HTCA==
X-Gm-Message-State: AOJu0Yzybti06Z1ZrWgLuZCtEAlN3DQVUOxu5xAt9quuStvAw6lnpiED
 JOCtK9Yb4CYB7z7IfdOfitpsvu1DShTUYt/lIY61o1qLKTKpX+x6Y/bgashMkelA+u1N79d6i5q
 iluzaUNasvgSuEtDi1nXzW7pXPTVZC4b0GAhYFQTcyQ==
X-Gm-Gg: ASbGncvo//mG38JYI99YQSkLv1C/V8DhYujY+mcfwvv0bv3WhzFxeMHXkF+duQ8Na4Y
 M5Yu19pEEn5gXxaRW2S5fyG14Ewrmp0c4rw5DBz+P4AboJeeqWqZtglGCNiuvGjDy8eGGtdSoFy
 ztFI9rRuVQ9j8sXiCt5d81DRj2047hHW8A8BzIKBy+TDCe
X-Google-Smtp-Source: AGHT+IEwjThRluHP9Lpu1DVNnkNT1QEM0ksuEwpYZ1FGyYpGdvFSooWabduFxn/xSqzmpmqTa9E0lj4DjexAbq8c5Ug=
X-Received: by 2002:a05:690c:3386:b0:710:e6b0:1688 with SMTP id
 00721157ae682-7164d2c773dmr92527667b3.14.1751545395915; Thu, 03 Jul 2025
 05:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-74-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-74-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:23:04 +0100
X-Gm-Features: Ac12FXzv6GIncvGRC8JU7oNCkG8Xfi8bhT9yeJqWpl3dIFaITH28rkiKow-bP8g
Message-ID: <CAFEAcA_9V6csuaiaxxsyWK2GEX1=u03Nx-75h6Ko-Z8mqDirHQ@mail.gmail.com>
Subject: Re: [PATCH v3 73/97] target/arm: Implement ANDQV, ORQV,
 EORQV for SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

