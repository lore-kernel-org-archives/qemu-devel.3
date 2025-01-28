Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DB6C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmcm-0000XV-CT; Tue, 28 Jan 2025 09:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmck-0000WC-73
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:31:30 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcmci-0003se-N8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:31:29 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e53aa843a24so9436298276.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074687; x=1738679487; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cRuJ7Dv8TtJ9AX33y0YkKmUuezADSdj3p2lizyzZgzY=;
 b=cuKqebyKXS14ZJofiKJIwRAcaG5f+0tOlkR5OD5ZeBco8v3sInDGipbTR4v5uikUWC
 eo2aODFwzsxFDYr5Qf6urh5p8cl+yzwGrn1LesZeSnrcFenqHx9UeCgsjwZh+XTPOjVJ
 a90iMi4dNDzzipiSCAY+ox9zCsWO1EstZwDV5xl9kPRFnAbeVPOqbzgXupU5+ZL0oQBl
 ZXopeRjwcM/C0/szYJFDZO7uftldxrURue4JyKTd0JVqXB1gpKIPXLer9mCWYgS+7g1G
 ej/1BCZ54o8zGcBSt55AygMXdxx3CNAA57BJm+VHvGGar3n7cYS85YGbuf9wAsPimnhq
 7TWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074687; x=1738679487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRuJ7Dv8TtJ9AX33y0YkKmUuezADSdj3p2lizyzZgzY=;
 b=FY0eiNainEnYppedgwEO4funu01EkqzFK5Dpau+gl4oUOVGgOoic3wuDRMcd3K6itE
 vG0RsZSPvjSbm0rU332iFEwTmBHBjK2mspxtuMO3vtB4rg8B+OOoroc3JfKNvMvnjQiA
 /V2ts5BAgvIsBC1nHmx028aYHoHwW8nN+yp5x78Y6QybGjwoyUauEKCVPWOzyaAnebnM
 A1SLEC+EVy102GaRnQvsx/mlonQQkaqZBxY1reOjpQvN/TO7WXPMz3bQxyt6JStd8wgg
 KJaWgDkKgkXEiOS0MdU243weH2gR7gZmOvXVXLQBh61qiDB+hb8sDA9Zqfjnnk/8zAKW
 etlA==
X-Gm-Message-State: AOJu0YyKKw82HgU4rZSpPaMcJo5mBH6oXmTxkmaeFzEdRCEMNZ0HaXDT
 vIuX1ZkgeGlrJXVFpBrz/eDpEmxnqkOZzW93v9I3GV6tpryfKwAPcR7L5QEfkfRnx0+wFFLqwwZ
 6NGjZWMNCN2Y5NlDdGMBbb1S3HjFhHfKPuAs8Ew==
X-Gm-Gg: ASbGncsfj0KeooKXfOFT7yZ1/+9zHz2NbVx7dl2/XGuHhDxXh/xNF5IMFtsu+Y/VOWk
 O0Yw65kVjIGpOZnzIAhobtl9HreKiN/gep7HoBpLJhvocrvHQ0cuGIESUVMahw7iTczQtXLSulA
 ==
X-Google-Smtp-Source: AGHT+IFm6gJRPQHtr1kgLPwARCo0K66/Yy+RSmHahmdIuUynP8v6IA2RAmBky0fIn+Bx54I1ABBeff/GRdMxZSYMMsw=
X-Received: by 2002:a05:6902:168b:b0:e46:9e9e:a214 with SMTP id
 3f1490d57ef6-e588f1f1283mr2736207276.21.1738074687317; Tue, 28 Jan 2025
 06:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-8-shentey@gmail.com>
In-Reply-To: <20250120203748.4687-8-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 14:31:15 +0000
X-Gm-Features: AWEUYZmC3W68f__q3wzwa_oeAQvP1uNior8oze8XZxtenHcnt_sCayEePDCOOxE
Message-ID: <CAFEAcA_4pzw90iyv0Qr_4A_HOmK0gQ5jQhK2YHXFq+v2NxZxVw@mail.gmail.com>
Subject: Re: [PATCH 07/21] hw/arm/fsl-imx8mp: Add SNVS
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Mon, 20 Jan 2025 at 20:38, Bernhard Beschow <shentey@gmail.com> wrote:
>
> SNVS contains an RTC which allows Linux to deal correctly with time. This is
> particularly useful when handling persistent storage which will be done in the
> next patch.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8mp-evk.rst |  1 +
>  include/hw/arm/fsl-imx8mp.h    |  2 ++
>  hw/arm/fsl-imx8mp.c            | 10 ++++++++++
>  3 files changed, 13 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

