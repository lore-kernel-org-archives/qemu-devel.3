Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908EBC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5ep-0005aG-0J; Thu, 06 Feb 2025 12:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5eh-0005VI-Nd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:27:13 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5ef-0000VR-SU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:27:11 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e46c6547266so923535276.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738862829; x=1739467629; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nN3uKjuk7wRCSeRPs0qfUzFgMBCSrlGatMDIvQVB0ZY=;
 b=mj3a1+O1EHr6cbfY/FnsjhcJYfNHW0NuHcVJcJtjZww7kknKnaX4xRvGztP+k6IoRm
 7oh5juXlmwv8UgGluJgc82rx9EGruVXCdZWgVW4rURGLyiYxylznZyO8URQN2hGIEk0o
 clSRC29rRJyaesTVO0XhbhmWhuqTBZXZ2jJHwcT+b7dLJcmjC+K4wGRPXFDHRpqf6Y5L
 +FFUttGtESO1ctO1Eprl5z/0vptnwN3xtDA6D3OHz2Qvh0uYaGqlqn3gbx/EYL8dUolA
 gyV0F8pBpDzQNZvMO6WyBZVQUg4hS/1iuvMLm2esw6q4oL5f/9ZsWrxCZ+BeeMpFj9V3
 ULtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738862829; x=1739467629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nN3uKjuk7wRCSeRPs0qfUzFgMBCSrlGatMDIvQVB0ZY=;
 b=sG+LxXrGf3FtFrqFnKGFA8EA311pvTMAcUI2EkU8GY20oOeKlRLBq9wm294MC+59Xd
 j0ed3ECrpJe/4mpeCRGfjsjW8KYGH56wjzWtoifE1Dyb0UaE63ZbW9Jl4jzfL/dxdC1P
 Xz/6gZwr6efl9+2Z7B8ixsmZtLbVlA9l7Av8hFQ1sB9lA2jpzvOSmmuUnua/cFLumKR3
 ksqS+2hUsHNMtnBOBRFYjgWKwR9FyU3tfaZ66qnuugZE34KFDnSGeENcvWptaHWcPGJB
 4V61/7mPLiWgwHzhrA9UMhxl9HaHIYMNhRrjqp4SzwN3XfDbR2oGy/08VdnOnHiZdb8t
 4Thg==
X-Gm-Message-State: AOJu0YwI+cQMPNCF3FQnAKLDwXOjZaeUNof18N5n2a4rXMnl+lRT9gED
 avu0yecQpBZHRiwOUJAfVJR5cy8emFS943rGC53symX9jZNaSi1M9NA8TQyfu+EHMr1WxCRwhJ8
 WJAboOSUfdqmjcc9lmFQryS9mlyXHGadWAuSd6g==
X-Gm-Gg: ASbGncs+ySd0Y1Gr4Lnr16JUpKLioOkSaO1+B+ufwBO8J+LFsmfJIqcEc/v6QCfOjtw
 ePIehPXVmvLklhvnf11ewzSNxHk+6Cmdat8IYdwP7nyNKVzzYsOuOXk2roBAPKSpJSG3+TltKqA
 ==
X-Google-Smtp-Source: AGHT+IFOj7uY0J0G+1mTzW0RwGdKrB3SyG1ftJbgwPsFhFvIHrrAvRNj9/2WzlIoQMGLlXSFx4LDv2A0nB2zPYZJNcQ=
X-Received: by 2002:a05:6902:200f:b0:e58:cbe:75a1 with SMTP id
 3f1490d57ef6-e5b259cd10fmr5826990276.4.1738862828957; Thu, 06 Feb 2025
 09:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-12-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-12-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 17:26:57 +0000
X-Gm-Features: AWEUYZlxa3bGt4PBflBb8F-HJgPJyDP_JBdmLnoKNsAr4i6ml65r4opWsCIEa70
Message-ID: <CAFEAcA8+VpG0vmqiVsbeGN1h_12wXW5eOSx2B0i-BbkPtaYcmw@mail.gmail.com>
Subject: Re: [PATCH v2 11/18] hw/arm/fsl-imx8mp: Add SPI controllers
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8mp-evk.rst |  1 +
>  include/hw/arm/fsl-imx8mp.h    |  8 ++++++++
>  hw/arm/fsl-imx8mp.c            | 26 ++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

