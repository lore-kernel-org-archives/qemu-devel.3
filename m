Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB573C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGL6-0001FQ-H0; Thu, 03 Jul 2025 05:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGKn-0000se-GY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:34:32 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGKj-0001Of-7m
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:34:25 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70e5e6ab7b8so73129497b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751535259; x=1752140059; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ild05BJyJV7piMfK/sm9VUr1D7Yv5vwaABxOwmxVXk=;
 b=rm4h3pqgLcjT0WsXS7ERdt3d2dh1HwB6HdlEC85OHZZ8v0uw2TExroeGwzQcRSxxYF
 3wOtJ0lyl7GjnxWF9QTK7me9qzImCbyxxVHU8tAjvoA73HcxJ2zSOImTdbo2q7z5tPZV
 rmnPRp24JG8OXHOT/DH30MxpivEOa5DwvK3GwMYuwtTdX3BhOVsAitk+bkLKHjXv3qpC
 rar4gGTLqo8VylHXjdtF4wj9dpQ+rNu5iDthquRAl/ACrp/CfsPHbh2xQcDsD1CVifZh
 AXOeuh03O9IEXIh2Rk+XNQUfTQxW/jCJYAwNXot+OkQG0XrMVsBDbACBktL7pVS7S+3J
 OnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751535259; x=1752140059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ild05BJyJV7piMfK/sm9VUr1D7Yv5vwaABxOwmxVXk=;
 b=MiDAqXeAzMhX7lpvYnADiYTc/RH6err0LNYxQH+ESA94qeyWdJiogk3LuKcs2oQvFw
 A2wQK4JgHJflvbS61EGahRC6k28mhoTfuyGkK4WYgFldAeVLzk2LBT19rd/SbgWuf8/a
 AU2hjPD3NIWCXVETSFILP7IVFjMFIveH/fh1y0Aqk+QZi9DwROi8T5Ha5rWnhq7zpXK/
 EzFlUJmHkxuTud5nchytiU0pyaVmHYkbx2UZ9Dm3NYogrPx21xb74nSG6AMGfsrQcJjB
 hOs2rRtEA/b4kPMzIVG8c3tAAnb4OhREd0oqGnAe5fVqSiNQArDV21do1KZ+KxHSKNkp
 4jVA==
X-Gm-Message-State: AOJu0YwGfjkhoyjA3WV0pU7fdtYxL/tAto6KwBy/JRWleKLubi9fSlBA
 pyeoKsr3DmJ4AY02nvrReVHToOlvnjzF2I71G3JBm4DRus8fjuQywdGcCZUr9bDSvh66280ELVl
 qld/TDCQLj651uoQiIOsMa/WHCBe/zTr8vAJ8FAoWUQ==
X-Gm-Gg: ASbGncuIuI9p7+OoLF0VLER1FrYd1VXNmERJkedJAkpz/7qXmwF8iep6ilkmRp+dMuB
 wIxHz64H7vdpKmBz0C5oshuOcjwJygXliEVAKrJxCB/LiznjLhKqKf6gZToNQKAL3gXSF+ysMs6
 L6jCdMhMBuopWDETnoi5MinN2eL7o3NndYrISLcWxwzjYR3lsSnESFJV4=
X-Google-Smtp-Source: AGHT+IHYdtZr+NHzwNvee9GMlpzNJjBmweByYY5mh/L6wDTALssYfByOD1lqQvxRrU9aFi/Fg6GvWzB5q2DlN38WBfM=
X-Received: by 2002:a05:690c:6601:b0:70e:26ef:95eb with SMTP id
 00721157ae682-7165a320362mr27659007b3.5.1751535259074; Thu, 03 Jul 2025
 02:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-26-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:34:06 +0100
X-Gm-Features: Ac12FXxEF6yunYWp0iXImMNf_PkPNbmQAi7TAdEvbdNTeGy89N2bBMtk5KKZqAs
Message-ID: <CAFEAcA99rix7vxcOyBzW-4W8ETBSF=Sw-b8bHWBKY94VJSxUVw@mail.gmail.com>
Subject: Re: [PATCH v3 25/97] target/arm: Add helper_gvec{_ah}_bfmlsl{_nx}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 2 Jul 2025 at 13:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper.h     |  8 +++++
>  target/arm/tcg/vec_helper.c | 58 ++++++++++++++++++++++++++++---------
>  2 files changed, 53 insertions(+), 13 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

