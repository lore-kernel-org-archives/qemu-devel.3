Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7FDE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 17:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQ66-0005YJ-Hu; Wed, 11 Dec 2024 12:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLQ5O-0005MQ-SW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:01:22 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLQ5N-0006im-8K
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 12:01:18 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6ef7640e484so81611027b3.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733936476; x=1734541276; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uUa4Q3n2z6EKzMTLHCiTTArjkvUBuMkHdOT7pp3q7do=;
 b=KIZ+dm4kKfkOp060AtLeTMXRR8uJpPLieikltoh2x/GV4CNcJc7wQEF6GMo/84pbqe
 QQzPZt22VegrdDNmMlBoYRlJYdfApULiFjZIW/0N9vbJyvPtZEW7t/9ieJzqZbhIcjfU
 mhRNDCIbMkISpqQ1bHOOCv2KwhJlG3oZrEKav53ntsE/8o+z/tKJv3Ew+OccNgZkVjIR
 zSp5pG3XBd5E6Xcjw7pY5tLFSevdKuwviz3A5Fn15l+jWW3S/IZRuO3ckkKqBDo/B6zK
 lkA9V0FyxBeqLK4Q4z85IJhiwf9n/ZhluALHUrzQ31uwiS9QQzcuuYY3RuHhSZkDddaJ
 b+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733936476; x=1734541276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uUa4Q3n2z6EKzMTLHCiTTArjkvUBuMkHdOT7pp3q7do=;
 b=D8NTCPlD0QK+dSeX6rcRiMYlxqZx0sUni5BxUMp7TNOorbMLVMKAa00674rdtisBcj
 CiKhDyxe9vXTVX6FRzXrBORw14seZv3fA2sFLuc1Hd+AK2EKMZwoXyPfBAZDdeBpNAb8
 dTOQXDdvPWgCBxbv4P3A266F4wh9NPxocgYUvn4e481yX/3HlJzvvLI2z5q7nlC+ZVAF
 rkiOzfu4UVtbNE2YozZ/AIz+SnTkwYuvemETeR9RmQrrfy+QOX3ZHmgGwbL7eTy+5s4L
 vlLjtXNtyCvgEwzeiu3mB4t9kmzyJdkYPJRzzhvces2D/MDdHdrRv0N5dHrDG5ArwU6m
 J1Aw==
X-Gm-Message-State: AOJu0YxO9Qw7LEXjPLasSWi+E5BUzQ6nnRC4FwhdATSry0B/ciQCavz6
 KzP/FAQMh0x2yC1y7HDFNApDECC/S7X0CVoVFrXtWt82FvIe1c4Zp8iJTYqg9lzLL+b4eQZ8CIN
 5Oj+aI46Pwz5ioGfyxGkexLHmVourJ7qvXDONelfZqoB+HaTB
X-Gm-Gg: ASbGnct/q0yUQKyJeWQ6ZSMGuINBbMI7lEhCYOqnyAKDBqgcXjhrsGAXYR3ruT8ssPc
 AxHd/UC7juuKqyYYG9u0X9g8aV6jrprAGQlJR
X-Google-Smtp-Source: AGHT+IFrUbAvWUOB25pSNhCwiPtERYaPzi3QOJHXi/cx9PzcsWaPagMumMpr9LIP9J0zjgqNmRIRNDrDSJcoaEDlokg=
X-Received: by 2002:a05:690c:6f10:b0:6ef:910d:7846 with SMTP id
 00721157ae682-6f198a3af41mr3156767b3.1.1733936475841; Wed, 11 Dec 2024
 09:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
 <20241211163036.2297116-24-richard.henderson@linaro.org>
In-Reply-To: <20241211163036.2297116-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 17:01:04 +0000
Message-ID: <CAFEAcA-s0W_1syz9UO-8-tQX-5C2sEa8H0wMyAUSMQNY1pRj7w@mail.gmail.com>
Subject: Re: [PATCH v3 23/69] target/arm: Fix decode of fp16 vector fabs,
 fneg, fsqrt
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 11 Dec 2024 at 16:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These opcodes are only supported as vector operations,
> not as advsimd scalar.  Set only_in_vector, and remove
> the unreachable implementation of scalar fneg.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

