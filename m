Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862D9CAC585
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 15:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqZgx-0000GT-Fd; Tue, 17 Sep 2024 11:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZgt-0000Fc-GM
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:00:31 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZgr-0004wZ-RF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:00:31 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so60479291fa.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726585227; x=1727190027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6zS8b93UQ+iuiMa7ETZmG3L60NdNrKAnrCCJDAQW1bg=;
 b=uCkm2N8j1kXxdzFnim6YysKgZdinUkUiq+OpBP93uPSTv/V3CNGtY6pg8mU3/havIg
 Yg6kIjNWegInC8UrnmTL0JRefC65oHntAIMDdPlO/ON6BTVpOx+WO/qYkmzVa+JEI35D
 Py4zVHJMZbo+yEe2zFn+37kY7oBZXwOFCnYuc5jWbU7DFedksJwUIDxH5XmTa8XZbNxd
 w5/vNh3+neScnhzW4v3DXbo5iNUkxQrfSpW3+E7NG5myqirnynUPG5jbzkWKeIMnFTB6
 7+31ZuthO3qtKcYWEwLJ9nqu9Z7o88uXQGpEgy7zH9TOxqMM9ORYSyDeOLRmERHkMiTs
 8iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726585227; x=1727190027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6zS8b93UQ+iuiMa7ETZmG3L60NdNrKAnrCCJDAQW1bg=;
 b=o0d0mbKDvXQw5A6+JQlqFFhagL/nV3L8qYtrde/fxHgMRLA380+5Gb8TQGXhOOjIU0
 KDEYhOGwW5q3u8EW+VJZ2AGcd1fif9zJX69LbMNLG9p6gwQwqkoWU6BC82xpq1OR3cw6
 SjcTP206/SwME34BcGY3seT376Q2kILkUY0kgwDIuqFdiN1rz85wS0RR4kINiSz1g+PS
 1Qrivd4C6QWpqKqkX9UmVavB0cDVrTJ93xHbQMFvDNqVP38GL+kDLq24CTIa3r9c8JwX
 3c4OgwdBjfmeXHLEEwuKJm3jytv9+b/ehi5YlugrZwUbS0X3yNUn/0xrSjxDRSSeNWAp
 ZjjA==
X-Gm-Message-State: AOJu0YyeH9cQ8A4zP2lUi6v2BLodvzXWlb34APdG3lo9OuZiSI3AWanX
 KTSRa1TM03Jr2ifHJ06iCe/iDOOVSsR0DN3Ud6iQtbMdJxonU7Fn2FOqyJ6hSMdcENEVtX71MbK
 2s3xhr+v3xJO4v9sluo90G3wFt7xRGk9yCZve/g==
X-Google-Smtp-Source: AGHT+IEv+COOt3BB2I81am+UR7BXVFr+LM9MV/KpSjEyqTkRd1H8ImuulzzTN6Zb2268CFlKkoeeBseWTRPEModXJBA=
X-Received: by 2002:a2e:4e01:0:b0:2f7:6869:3b55 with SMTP id
 38308e7fff4ca-2f791a02d1dmr71411291fa.21.1726585226441; Tue, 17 Sep 2024
 08:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240911043255.51966-1-satur9nine@gmail.com>
In-Reply-To: <20240911043255.51966-1-satur9nine@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 16:00:15 +0100
Message-ID: <CAFEAcA_q4A2XCHXo7-HUYJr_zSeaLXbtUg83pZ50f8t6hLPYMQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/stm32l4x5_usart.c: Enable USART ACK bit response
To: Jacob Abrams <satur9nine@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Wed, 11 Sept 2024 at 05:33, Jacob Abrams <satur9nine@gmail.com> wrote:
>
> SW modifying USART_CR1 TE bit should cuase HW to respond by altering
> USART_ISR TEACK bit, and likewise for RE and REACK bit.
>
> This resolves some but not all issues necessary for the official STM USART
> HAL driver to function as is.
>
> Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
> Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
> ---

Applied to target-arm.next, thanks.

-- PMM

