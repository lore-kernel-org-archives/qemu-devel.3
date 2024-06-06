Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE95BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8AU-0006SS-Jp; Thu, 06 Jun 2024 04:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sF8AT-0006S5-HF
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:08:17 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sF8AR-00072K-TN
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:08:17 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5295eb47b48so815989e87.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717661294; x=1718266094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=d5uRBSa+SRmh8ubH07EsWpj3//vi7QJqTyze2CQpcms=;
 b=iRWgb5ZHYfsC0Ja7A8bt2KiNvOM54jNRMRrSoIcwZLcf5GXwEHq2aXEvw/4f8KuQSo
 QQNSoN3etmjOrgNulFllHgs0ULHft4dOoiV7C/Xl8APnK5X52jXauiR+UK0GT6iuYuGn
 TTUYS930nvQ9cOiidgrF103ecBfuGpy9+SFp8QgjcSG//7K2ytdrXiTn7JERvoxEmoUW
 JI3BUJAhgvlj2cDBbfpqpoe+esFcxVT5eYfbmuQm9rHCzTeHbv3Ki1Pwbg/iWCA5eywT
 1woRZQf4uK7C7DOyd8nIUqln9qFxgyISGg5K2soyCn863Li8i2nHWNb7AiiAORnRjK9o
 Qh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717661294; x=1718266094;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d5uRBSa+SRmh8ubH07EsWpj3//vi7QJqTyze2CQpcms=;
 b=TY9oQKKr9oGciyAAfVAPQr6FB3LCRr1Px0vKtLd4ddQL4q0UfjsRPo5MjqnjoU7LmG
 3vFN8igGWgPTvTX9dFnQ5Pg5CZoovi9lO0aoYvjrNzO43g3HvtIsBygfAQfyZ1wsHNfp
 kFl2w8FAaZnwTjzg1/m4khoYoGFuFafEVBa53iiYjYN50MntWhLjqeGzGu7PcMrlFa+Y
 93nO8YEnT7Tvru/0ixJFxSXxGdtyu/WbwdYlQ8gGqhHW0HchtKH+0SoeCoatLXEdZGdt
 83pga9Ya6lEQeBdLoJqaz62rK14CANthgpM6oVgux2QCe4+O8tGe0xxeR3+aFVXBNCiL
 FPmQ==
X-Gm-Message-State: AOJu0YwB3TiDPS3P9523Iy7z6WgXGS3LULjFEOuOBsGP3tHeFuUyB5FC
 hozcx6ANBCoykg4kd87rGZaEBJn/C9TGlH5gFv1pQmv4TjT39gYNzQdBvm5y7bsb35KrjJL2W4D
 YvoI=
X-Google-Smtp-Source: AGHT+IE/k/BW+mQ0XG0wmB3l4s4QvSC/h7sKJeOK6MKhkiA7d4dZMFY+nk2Z0MFnwon6lOvZq3SfgA==
X-Received: by 2002:a05:6512:696:b0:52b:8255:71cf with SMTP id
 2adb3069b0e04-52bab4fb4d6mr3556916e87.47.1717661293545; 
 Thu, 06 Jun 2024 01:08:13 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2c738bsm12693605e9.32.2024.06.06.01.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 01:08:13 -0700 (PDT)
Date: Thu, 06 Jun 2024 11:05:28 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 01/20] qga: drop blocking of guest-get-memory-block-size
 command
User-Agent: meli 0.8.5
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-2-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-2-berrange@redhat.com>
Message-ID: <enfxn.f5a9r77dfi9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x131.google.com
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

On Tue, 04 Jun 2024 16:49, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>This command has never existed in tree, since it was renamed to
>guest-get-memory-block-info before being merged.
>
>Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> qga/commands-posix.c | 2 +-
> qga/commands-win32.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>index 7f05996495..76af98ba32 100644
>--- a/qga/commands-posix.c
>+++ b/qga/commands-posix.c
>@@ -3099,7 +3099,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>             "guest-suspend-disk", "guest-suspend-ram",
>             "guest-suspend-hybrid", "guest-get-vcpus", "guest-set-vcpus",
>             "guest-get-memory-blocks", "guest-set-memory-blocks",
>-            "guest-get-memory-block-size", "guest-get-memory-block-info",
>+            "guest-get-memory-block-info",
>             NULL};
>         char **p = (char **)list;
> 
>diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>index 0d1b836e87..9fe670d5b4 100644
>--- a/qga/commands-win32.c
>+++ b/qga/commands-win32.c
>@@ -1995,7 +1995,7 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
>         "guest-suspend-hybrid",
>         "guest-set-vcpus",
>         "guest-get-memory-blocks", "guest-set-memory-blocks",
>-        "guest-get-memory-block-size", "guest-get-memory-block-info",
>+        "guest-get-memory-block-info",
>         NULL};
>     char **p = (char **)list_unsupported;
> 
>-- 
>2.45.1
>
>

