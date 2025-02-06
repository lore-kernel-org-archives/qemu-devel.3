Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8BAC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5fN-0006LR-En; Thu, 06 Feb 2025 12:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5fB-0006Cq-Td
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:27:42 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5f5-0000aj-PL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:27:38 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so952712276.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738862854; x=1739467654; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CyQULLYznuLYXJGLbQtL8i1PZLOV/oZUVaw+gyu3l/E=;
 b=fl7hPkmpVOrtDgidHF3XXahQo0fPVOLbhMKGAdpG1cMlPm9raG6dqqk6iQoi9SqZjK
 N0sUWw0z0rz1eJ4U5E/tHaKPa+AMjK7M4iBEP5AvAEpJ33KcCfNZJydMo6ip3xDSRrbQ
 XcDDLisETkdySd6zLth9UzT69QtUMc6R5LqqQeOM2vy6CQi1ZFne7C5PyIaW2T7gRu6H
 1CjT5a79QU/ImpLYm0pAf9ftEkzHCAs/bXJaXMYwe4yRlxIBBlsCiCttx3Q5KxQg7cxV
 h6/W3PqZzI3fBEKgWEpAoMiCtuMk/8yqee63nKjTItifliPVC7sQp8fbKSkd1X9876/c
 mYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738862854; x=1739467654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CyQULLYznuLYXJGLbQtL8i1PZLOV/oZUVaw+gyu3l/E=;
 b=RE8cfSAxV+wRZguaiZpZja9xSgtXGclKTPCgmFTcOxRqfdzTRjW/aUvbIA8J20qnAG
 0ZehNII0EqDZlD/Adk3zmYFVxvfjBPiktD4kNt4Ne8MKvMO0h2h0ZBBvAGmhe0RvaG1D
 2IanuCywsrEgYtm/65KVtdnxwy4yyePbU6647ILsu5esCtW8YIhKHHSaH675aWGCeP6k
 XMRVNZrHgfeBTx4Pl1yWLhKL7ORezUzF+qJRGKTLSWZ5gYgZlN9tEjKVFMiIWLO2FPg/
 OtxwGF6emsgco5i0Tpn2Oorx2cGlr+oAeck8wDEppBLpwu5dqnkAa/aRj7sTCOjM1A/4
 itrw==
X-Gm-Message-State: AOJu0Yw4XhYJx7+tLC0dNRZtmg2ERcLXW5wdoJI7fLZA9J7fKwUJ6142
 HpJ0lzJ1wgP1LK1a69GBDneVbbVpqo3ZLC9NRTtc/sEN8mZ/C883TQo4rXVwmEvVPs+qIpps2P8
 GN4auLHzf7cuzMFIK0Ch/8VicynkIgrv3qPPWOQ==
X-Gm-Gg: ASbGnctb6Sxr5fQGhSa7lz4pIwnXZ6Gp23K9SEQxwFDMFniWGkTPytVVtV4bhA+Phv5
 gvzx2QhYcxLHUM4+LbjssoyWSay8oxTh/sKgYERZCmPfQB8BiwYV+COEt0r94BFAFTP6Uwl4Yug
 ==
X-Google-Smtp-Source: AGHT+IESl17O7Q7f+yyVuO6DPML39yTlN2tka0X/OSUlbjTBsoM0W8Fj1Lpv2qVG1TX+0iLwXbXm3mh0tknqqbH6osM=
X-Received: by 2002:a05:6902:2101:b0:e58:305f:440b with SMTP id
 3f1490d57ef6-e5b259cd35cmr6411795276.7.1738862854726; Thu, 06 Feb 2025
 09:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-13-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-13-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 17:27:22 +0000
X-Gm-Features: AWEUYZla8P_cTkbjhXRISSnfDMkCTPmEu0VY8Kw5kObJowltWU38TbjyRqiyUXE
Message-ID: <CAFEAcA8J=mxeKzA98gYeOXrh-=aFXUHxaf=uXXCWznsTSa6BsQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] hw/arm/fsl-imx8mp: Add watchdog support
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8mp-evk.rst |  1 +
>  include/hw/arm/fsl-imx8mp.h    |  7 +++++++
>  hw/arm/fsl-imx8mp.c            | 28 ++++++++++++++++++++++++++++
>  hw/arm/Kconfig                 |  1 +
>  4 files changed, 37 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

