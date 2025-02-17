Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCCBC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk1BD-0004P1-IV; Mon, 17 Feb 2025 08:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1BB-0004Oh-74
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:28:57 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk1B9-0000Dy-9y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:28:56 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e587cca1e47so3879420276.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739798934; x=1740403734; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yryzwN+0NclVxJ3n1GoDSP0hqF7jJNbPE6p7nvejvqI=;
 b=y1QIf5F1IcW05g+Lhoc3GecySBNvWYhMxlcbrcm/bEeRH24hlqO/Uyq8ipgeUrHY+0
 I7XGAdYpEqLsxgcHVOAY1K9U+vomxtVi29d1FRAuQ4eF22Wje8d5balTp4+4rXD0JeLk
 aG98+9UG2bKrk8E4ZBkbPdAAziwk8TvMvdkRbHYLHUAFF3JWw6djyC/BHrN+3YHg8Ssm
 4ROm7l028B8BJ2/N1c0UyCQHZH/x6bJyRwQBL9W8zNeKrc2oUDqBfmcKrjGZ6GnNxDYD
 kRdB/N45I0rSaldsBTz4TqMRHQkX6tfxisuTw6Wan/ngXAwzm89S2fVyKJ03bCYRgnBc
 kB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798934; x=1740403734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yryzwN+0NclVxJ3n1GoDSP0hqF7jJNbPE6p7nvejvqI=;
 b=celjEoY1uLvopJdIh9mqqDkX59MeCIjwwPhwHZSIL6X7jU4lZQ7hjBchVNr22phOku
 GjDNEYWzAxrXy4XSnid6CIf8/zZN+hKH/n19vBLUjMy2zxjpaRQ11ixj5VqtvdNHbVlH
 YR97gwmjWy6P527gDSjv5NPaJZ/f0qnTbxHdfMVcy698wte1tZkpjTCNJt9zGYxdS9dP
 pE27maRVvbyNPpVGz/5UlmvJZ9nXSdlygL812Jga0PvgQSPz3Vr4EEbhTa2InET3ApR0
 pU5hWuPrggb+T1DEdYBSWu6ny6oncSYhU0DUTU9evRfyYPHuQDnEUwiF1sgiwHSvnSFr
 HdNQ==
X-Gm-Message-State: AOJu0YxRYrXnos09Z0SGh9BUheuLvjdsmfS7cJkQBoiGbOKKoV1sp9XQ
 7SQ1XHsmCzJpdxY4p14o+fEYhDZOzFSZjQGCFO8nZnE6PHu/xTwkOmEyR3eu8ccg7Jn5++WWZyW
 0evircxTC3Lp6MPYXq8CvGcLYkC87aaf+hDyNYA==
X-Gm-Gg: ASbGncvxHllg0+If5TzJUqo3vdmp2oKgVMDIn28xwIU10nhDupgVuEXeFROn7py2mjM
 qwIRHA87Xaf55P7v0h3CNuE69+YE8kNmDvAfiuzyLk4XENOqSjo0kEf92dPxI7ILEAP0a8U3ToA
 ==
X-Google-Smtp-Source: AGHT+IGtfT+euHGH//RpcNhv6aydXvIJG30dtk3HLM/A5NM1+wYZ9Veq12JhD6pNlf6Ba77p70uhZy4M1QVfrjx4mM8=
X-Received: by 2002:a05:6902:1027:b0:e5d:ae04:1e42 with SMTP id
 3f1490d57ef6-e5dc906b6a3mr5551988276.22.1739798933789; Mon, 17 Feb 2025
 05:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-17-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-17-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 13:28:42 +0000
X-Gm-Features: AWEUYZkbk0rPIphVtCUbMA3GIJdZVqihIG-mSdTsPhuwvYfgptdU6T-3_Lv1fc4
Message-ID: <CAFEAcA_Kasz0jMTQO1F32bMwSh6tRoDTaS2DE0sSruLENdcu8g@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] hw/arm/fsl-imx8mp: Add boot ROM
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> On a real device, the boot ROM contains the very first instructions the CPU
> executes. Also, U-Boot calls into the ROM to determine the boot device. While
> we're not actually implementing this here, let's create the infrastructure and
> add a dummy ROM with all zeros. This allows for implementing a ROM later without
> touching the source code and even allows for users to provide their own ROMs.
>
> The imx8mp-boot.rom was created with
> `dd if=/dev/zero of=imx8mp-boot.rom bs=1 count=258048`.

If it's all zeroes, we don't need to commit it to git as a binary,
we can generate it at build time. (We should avoid having
binaries in git as much as we can manage.)

thanks
-- PMM

