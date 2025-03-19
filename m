Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF39C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuxoI-0003l3-Dd; Wed, 19 Mar 2025 14:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuxoE-0003j7-FA
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:06:30 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuxoC-0000I9-83
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:06:30 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so6704518276.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742407585; x=1743012385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xmtBwKm4Szm1gHVy8RrQRWt4HCE0PgIASJVO5lH2kdE=;
 b=IeLz/Jcobeh/9KqfC0tYI5hujmWxUXjyb42CTfnff0d2pX7cQfP4Y+loiD9BHbbcvF
 J6xvb9BEF+rJovySwvZmWsBwuyN59w6VN7H24dlgGBkQW1f/TTM/LPgvCa1YN347pSF3
 cOotfs2m7WFrwbVHUdMNRvU/4i7OFm0kdhpL3nmCpfZ9bpNvoWXJUNnUho/vEExgge2e
 DZC8qY2zzeOMji7oMXpJ20OFB/RLyAd3kiqVmgy+lX65xtIEIzOxa88zrmCkezKHAAJY
 LkAbnUd8eI9eWcoyiTLOGqLBZjPjEO/Qio1B/dFwxZXMxT3KzYFDLASNggk2m/DQkBg8
 89hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742407585; x=1743012385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xmtBwKm4Szm1gHVy8RrQRWt4HCE0PgIASJVO5lH2kdE=;
 b=bZ9GXrIDZVj3GkLWvFX6zQvrJYvrI1oOfZADq9mUun8+lD4wwEuFi+CDIaJriXF/uK
 /S4Qv2jylfhzOSINZ5sTaGzrDYICBFIwU0eyHFVIt1Dvlu2+QjDFPQdqdV1co/3pcj5b
 2zru4kcSv6FZxB3BFnwK2irq/WjW0A2wDr6ZMugHnG0ElYvqXUGAipW7rUxsc6nLs0Pc
 +AfAIicsLOsicjfF09t4vHjqCN00drBQiFKq9ElUIJmb0KVFbshtdJx8qidSABrppVjK
 VwLOAY15sHw4R8ZO/7HLHbboH5RS27MsHLWSWMUwV+WabdKmXJhrdOu0Rz3TzIjd5ryf
 UZvw==
X-Gm-Message-State: AOJu0YyKI24gb+kt4Fz3UWRYrPSQlHNiz81ysQPt+vLInvg95bkKmXuT
 /UqgOzJi5iBCZf1tvyV0K2D/YIAGBfgdj9tb8wjIEObtz42QRQpgFoLbFHI9wVeTWLWMMH0yth/
 pfXgVc6VHip15hEqWgT7ndh34xvoa4eqvSjkOsA==
X-Gm-Gg: ASbGncuJmTl1Zwbmg9uyHpzTHIycLPoVBp6T80Qh18RrIaJEVK1x6sPdUaaJfquH4ni
 ADjoCIDnv3OlTUKK8Ma4nzw6m0y7E9wWYUZOub+CjZZ3xCKRjD6A3IyZ1mvbc9XULjL4tCeve4b
 kdieWTXK4x3q787GQRU/TLtxKoy18=
X-Google-Smtp-Source: AGHT+IGz9EYYd9Q1gxOjrncw31sFS9NMRrypQOrcFAMu2LWQMmxOAZ4bva1n7rDdAuSAXu1W9ZSS7hKKxSQkCIsCbto=
X-Received: by 2002:a05:6902:1883:b0:e5d:c7ab:5e0e with SMTP id
 3f1490d57ef6-e667b3aa230mr4672209276.3.1742407585714; Wed, 19 Mar 2025
 11:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250318205709.28862-1-shentey@gmail.com>
 <20250318205709.28862-2-shentey@gmail.com>
In-Reply-To: <20250318205709.28862-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Mar 2025 18:06:14 +0000
X-Gm-Features: AQ5f1Joz43oLlyq-P2oXE_vh0qhjBfYXjZgo-xTddWbBGimZkBXyuwZJYvviD7U
Message-ID: <CAFEAcA8VRjD9bP+GOkCoVkFveTnuVbtfmk25rUHvQSec_ypjjw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/arm/imx8mp-evk: Fix reference count of SoC
 object
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Tue, 18 Mar 2025 at 20:57, Bernhard Beschow <shentey@gmail.com> wrote:
>
> TYPE_FSL_IMX8MP is created using object_new(), so must be realized with
> qdev_realize_and_unref() to keep the reference counting intact.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

