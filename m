Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F366E77179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFsj-0000F1-Gp; Thu, 05 Dec 2024 12:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFsd-0000EN-7D
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:43:11 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFsX-0008BT-Uq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:43:08 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so1450489f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733420584; x=1734025384; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SM2jvQ7Mm0KjM20jPndgEZJvk8M+uJsuwsmSk1Rx4c8=;
 b=S91JOnr8+pRP/G289vqiLhScBf4gsTfmNWCrR7AMkKbcjUqWRCj5ZHdZ9+0f/5ZNNa
 JF6wPfH5cpjLE2GyGLXGCE8z0q0HyNFbUcNgoUbj/oxuoCFr9fbyGgfoy/j2LrqldpwI
 zjzqTojeyTmIsLDxr5w1sHqCOVXDzkxO6sWeFHQYAUNUTdRfKXlh5nGmxYhGJwePhXDK
 ueehVtxSAjmJzMzeHXBF190TuUqjTn2ZBYwWXZgG2pjBd0RMoDglYbfoFyVTW+C38/99
 b9NFpoxt0Igg0lIFme0Vis2BS3U1GZ7w1HGkXshTa/KMIieYnaRZGk4m77qsqf4XuRr5
 7v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733420584; x=1734025384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SM2jvQ7Mm0KjM20jPndgEZJvk8M+uJsuwsmSk1Rx4c8=;
 b=AR62VCpHGgF1HB21dS1yIdYZKkCNM62rSUlmKgxfnHLbCvpJ49yF6hzCAHuD6PHZng
 FSy4yUXn2NzOcB5xo4mpg1cicH5POqccjFq6ZdWnEV45HKfGn1SdQJjCGgejXwnvSBZd
 fMbOA5V9h5fgea6n5xLhugMVa9tzm6r2MWPsMM0oZK39/twBZCsN4SceVVMCU2U/BEDp
 ahtX2zP2/U869USNhMiwipt7gBimPHB4NJYoo68i5ekzSHpOAUiggznST9zMzB/r/LEY
 IgJCrl1uEPPfmzmMuJn549BaJ7/fGIAaY4QCWjKPEJuJ5824eq+KnmoLyvVu8QjxzkCD
 +umA==
X-Gm-Message-State: AOJu0YypF7JBPZYfGiBsZ/Z+4msXeKEm0BjsSzdaHQh6uDLqnJEMXv2N
 w96x2h8sp20tdWzeIq6ekbO/aq3BnDVXGyNbgOwZsAEFkznjEAIqLRxQcOQIn5KbcjgDxIai/a6
 HVE218k8UdcD5yqyHETla+kEu6NSFG7W/h5m1sQ==
X-Gm-Gg: ASbGnctMMxk3H2TgWLlsoPSDd0pRJzRLy8u8oDzCFavoVaAuANPvaHAXktw/+Wvn39X
 XP8f8t1XJSdZpkan0T1s3fz1flBPpU7Z0
X-Google-Smtp-Source: AGHT+IH9DpQM9fXkLhlGj+SchyKMx4H0eowRlKk+hS/g7ggN3065ofAQsRYu4yOXItj96M2KeMqXyEq41uaZTsJ7T7o=
X-Received: by 2002:a5d:5f46:0:b0:385:f07a:f4cb with SMTP id
 ffacd0b85a97d-3862a893f98mr138266f8f.8.1733420584035; Thu, 05 Dec 2024
 09:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-13-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 17:42:53 +0000
Message-ID: <CAFEAcA9cmbYjwLG26C7Z-GVOQ-jAoy3eHMP7Z-d5H2D97BPXEw@mail.gmail.com>
Subject: Re: [PATCH 12/67] target/arm: Convert disas_add_sub_ext_reg to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

On Sun, 1 Dec 2024 at 15:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes ADD, SUB, ADDS, SUBS (extended register).
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

