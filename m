Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0774C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4al-0006pY-B4; Tue, 25 Jun 2024 07:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM4aT-0006hn-4J
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:43:52 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM4aQ-0008R8-AZ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:43:48 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so6213535a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719315825; x=1719920625; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IzPejyNd1pyHPkzFyhh+MwUutBdjG7tTHlq8LFJ5u4U=;
 b=adb1GTo1G5U9rjYWOJx4D6BDIU4zsiz30LTMYfAvQY+4hVTG5Elry5WeOkXLaYpNbR
 OkBvGNmUDt2EokQYNp+/vKjbDBbFOYe4nRQ9ncZlYJjkMcX/ibnlXgIHFzto2U570DI9
 wYGPokT10iTROBxVhg1zuEAsPHZ08N7xq+x8IJ+tc7kk+s+S9RcdkZWqLaFmgzyei08A
 ttnKbhTrMfN3gIAxK01DEcHTJKCZtRX+OflUppyRr4Nm6ggtGg110uzFkNwBW0Q435ll
 WwD96NIIdVdANzXy9DS5viIFLklwogmrrYh2iCwPN33nt2g7eYvZIDf1oHxGFn7sTbIR
 J+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719315825; x=1719920625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzPejyNd1pyHPkzFyhh+MwUutBdjG7tTHlq8LFJ5u4U=;
 b=Xvj3+W+KvoTk0r8Qsm7v5yg1ZJc77vf5I8RKcVcV22BFskR0DiAVdnBLaoutNJe45H
 3VH+Ho3h/wOsQSVvcRW/KEwoN7wdnoWKIS+8q2DmMOk+Ei6LE7FF1rz8O81ZbKE1pacw
 lDtJaAi2Z9RNMHa+G4mtY1JIF0SQy4WizYNQI0m+irZKST/iAqgGy90pP5M8Fg0qottp
 ntbYkpOnPNPCX9qXjmzgz8jFzJxfvAFGXPvPnmR3KkgwxVrtVSZVQROorOK2zGF9IVzw
 oDugNhoCqGtT8QWZPxIwsZWK4i4syHLgvgSHn09Mhbp3l6W8pkm/5ea2gxAvnP1vs3+B
 Ntzg==
X-Gm-Message-State: AOJu0YxvGq+vP8/J936ZFE3NNPQxe/Ui0lCWHfcQAuS07FtVLoJ5OFOV
 oy8l5fkcpMQ4l2HEvvQ81kPv97M2uQVrJO5hDKwLLebt0/cOHxKr1FV/VqLSa7IjvyFgN1qKg0F
 tFGcwWUNzjPPVLBW4EXwhnvSalbIztwjSTYMoNQ==
X-Google-Smtp-Source: AGHT+IHeQGLyONgXoXA67BLpCVccNmMPwaEuM6C89Oxnue3GX53yEhxkR75flmOu989H3YxqC/hKIgOYq7WOhwQ8IzM=
X-Received: by 2002:a50:bb44:0:b0:578:6410:1d50 with SMTP id
 4fb4d7f45d1cf-57d4bdbe9c6mr6866851a12.34.1719315824807; Tue, 25 Jun 2024
 04:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-3-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 12:43:34 +0100
Message-ID: <CAFEAcA-nmCQwkhb+DMfx6MBak7VQXCYAYkdj4T+mFuVH5xoS7Q@mail.gmail.com>
Subject: Re: [PATCH 02/13] target/arm: Fix SQDMULH (by element) with Q=0
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 25 Jun 2024 at 06:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The inner loop, bounded by eltspersegment, must not be
> larger than the outer loop, bounded by elements.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

