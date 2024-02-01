Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DF4C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXd4-0000TF-BK; Thu, 01 Feb 2024 09:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXch-0000Pk-Bf
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:01:06 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXce-0005Ix-Cj
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:00:59 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55eed368b0bso1724438a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 06:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706796052; x=1707400852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySb0fSZNi62tgNa9LuMn6W2UNfmcsml8mDxQriq7QUU=;
 b=wO2eZ2tvVfooE6m+zXoTNDy831yg/7+VeKpfwKJtPUirKsbhLHtWwsZtTT+faoSJ4G
 /HRnTq+GyvaVahZPQpQeJy73BKj+vTp9gqHLw+URG+FI1nY/LnAg4qvU8mXKBXQxbRC7
 1R+B8Rtko4hTDqibRK95EduVpJJVkfMoN5YgWiZW4wbPnt69ufdJpHBsX20uhGd2SCxq
 cMoqk13bVjONOeC5TMMpco8a2tfCP35HAY6+gWsg9LZ7Inie8uP4N9Z9xZy4G1YLc1lQ
 o8XSAiD6UZiyGKvxfAH2wlzfk+uvZ5hNOIWcssFbcewUkcoNFNxgaTM4pdJnqE/k3S7h
 OWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706796052; x=1707400852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySb0fSZNi62tgNa9LuMn6W2UNfmcsml8mDxQriq7QUU=;
 b=OiLzizUhE3pFu/QS3DSnBMk5LzNYHRLhgmos50yVoqPFIqc0Dl46NNEz4UEhnYwh61
 RUM3BEOMZB+HeLqwfKtehVZFiNvyHBEOWI/WMKivhptZEorg2N3n5SvrZITlvJRZnEzS
 518ry1IbYfuErtDeKzBSnthFquYuLENYdNpX9L/u80NTkX1dx32fisHa2sQhO/4cwEEJ
 H7xh8cmDuB8LFvm535G4etOVx0l0qpZEnV/nQKAJEBYc7Lz4Q/tKCqewX+YHf9k2qA33
 tQeLB8amLKdhFI7InxMErVWCoRL0wJYy3+7nE0M+07M+RLbK9NTnaBc1ET4SQoGdbVXU
 7S5A==
X-Gm-Message-State: AOJu0Yz3Bxv6T3viLD8CdxadYG9o0L3hTwohYOH9zjLx3EPqcgOHvENL
 c5UFWtB4EhTP63sWRpLjjbCew+lubOIgjkKkr84THuL6t4xthRzQbpRbMFN2U8p59XbXmk6OfHl
 ZDtMobbIJBW7aAWJYouURqJjkVUO6tY2mz2sv8g==
X-Google-Smtp-Source: AGHT+IGI1B4hox40E+Y+PcFjxa3JUaAtgQqdxQfVhocJlsP5stcFq+Yl9gnMyx0w7e3h9UdK19qbNf2OJ06KFpf3N3k=
X-Received: by 2002:aa7:df8a:0:b0:55f:cacd:d0ca with SMTP id
 b10-20020aa7df8a000000b0055fcacdd0camr891886edy.1.1706796051709; Thu, 01 Feb
 2024 06:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20240129151828.59544-1-philmd@linaro.org>
In-Reply-To: <20240129151828.59544-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 14:00:41 +0000
Message-ID: <CAFEAcA8rx+kgSX9ofkB19zsSe-dfp=QNA-BirQ81PsrVkzmOVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] hw/arm: Check for CPU types in
 machine_run_board_init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 Hao Wu <wuhaotsh@google.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 29 Jan 2024 at 15:18, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Series fully reviewed.
>
> Since v2:
> - Rebased
> - Remove default_cpu_type (Richard)
> - Added R-b tags
>
> Since v1:
> - Add missing QOM parent for CPU cores
> - Dropped Aspeed changes (C=C3=A9dric)
>
> Following Gavin recent CPU type enforcement cleanups,
> restrict more single-CPU ARM machines.
>
> Supersedes: <20240123222508.13826-1-philmd@linaro.org>
>



Applied to target-arm.next, thanks.

-- PMM

