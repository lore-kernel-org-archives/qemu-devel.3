Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E00C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2XZ-0000fU-QU; Mon, 17 Feb 2025 09:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk2XX-0000ez-I2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:56:07 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk2XU-0006Hf-B1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:56:06 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e589c258663so4776114276.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739804163; x=1740408963; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBLALD+Vb9oUFnI6jxhdOaCAb498OH9AuKZBWSRaGLI=;
 b=Tj0sj1RZLJ5ymccUUw2+sCBlUaw5hBQXfkGbzyCindMl9He28gFreq4++j/A2Ro9VS
 8Y7o+LeO2YQA5rGjJqn2U0ItjfTYncQlWMVifZduVYGsX0aPzliv1QDoLis6HngbOQ/y
 H4yGjClzUQ01pc5ZGLwSt+e2RR3WPh/WC7rVQPgDRpA/oM6Qdi8oM47U/ecGTOolRe33
 mIU4W1P5krkW/1MCP+PviAkWH8+bNniZgBbIM4+A7VWU+AVRbp0MbdVm/F1hfPMfPBhm
 s1R2E6qqSyjMduBPjMcuO2R3c7DtkRVXc1ZkT3YHTSGKg/NjsysRVvmAh551oiqj+kMu
 f+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739804163; x=1740408963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBLALD+Vb9oUFnI6jxhdOaCAb498OH9AuKZBWSRaGLI=;
 b=r4W6LsFJECipno+H0XRpo0QiN5aRDkPIZXCGYGiS3CiPZF+tdguqOVj5o4UioM7x1p
 vcTb97XocBx9dKbVLv1SNB6Q+6YrxdxPTLCNR2wZJTcQSBS9NI0w09t3T8Ly1m1THKHl
 8Dg7LTfIYisBbbL5LYS/lLswifAJS/y/E/9j35TqJZAw9IdWnl90CGEhQcsvrkLNQPVo
 l9gtNrursyVvIbYhXrtgAPVcfPF5pZIcoBlfQQHjK+494aDFW7Ny75Jr91JjO5lFatkt
 9FJ/C3AzbHQTywa+msVkcdKXwbQSAqQFnZVsDRW3VYcethiSbWufV63JL7kE3tAkgX9J
 aWNQ==
X-Gm-Message-State: AOJu0Yy/bqX6Vcfkus470ufLWgpBPUeOTQ38xNYSncv19hQ8hqpA/AEA
 gcMLCOuXXbG5+z6AiU0jWWm1toIsMlrOoKiVO/qsKhx05nJbom1lu3XiKCXOrGhIY9JSSfrBDP3
 s2X5gtFtWDV5kwyPMSXGpofB8PEzX2Hqo/KEPsQ==
X-Gm-Gg: ASbGncvhjvp0JUmknuVU/+GgcCtqo6BNN6KtiVK0aUOcrgNItxfZWFRdSNDMFyZliNL
 cBY+QD3BeCXlgnGY5o3klJxDDpXUn/J/iKXRszWC6HuXojf7lN1bY/Z2y9yj59aoo78PUUtj/Mg
 ==
X-Google-Smtp-Source: AGHT+IHAlkWzeNzuLUhA1y7FYrX6rGdyfcIx/ns8YODDckg2FymVQA+cZAhoW8UjG4wNJGxOxcJ6QDegiUJOsUyILD0=
X-Received: by 2002:a05:6902:108e:b0:e5a:c5d6:3948 with SMTP id
 3f1490d57ef6-e5dc8f4bbfcmr7511987276.0.1739804163015; Mon, 17 Feb 2025
 06:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
In-Reply-To: <20250208163911.54522-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 14:55:51 +0000
X-Gm-Features: AWEUYZmE9Bg7EEVe-jdyUElUT8HIfLpU1M_vFyLsUVBaz9WtLZSLFg5UREGxAeY
Message-ID: <CAFEAcA8PYv3-JX66THwj-mDM0es6V5gVVWJsHTqkd9wTEVor4A@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi,
>
> This series add support for (async) FIFO on the transmit path
> of the PL011 UART.
>

Applied to target-arm.next, thanks (with a couple of minor
tweaks to two of the patches).

-- PMM

