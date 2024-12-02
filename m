Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B1FD7831C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAfb-0004Ci-QV; Mon, 02 Dec 2024 12:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIAfO-00046i-1T
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:57:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIAfM-0000GM-Cm
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:57:01 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e2c52c21so1484063f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733162219; x=1733767019; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DVH9/euVNcJBggiE5fEz1CQkvnAZ9KZBv3Vk0CueCrI=;
 b=fPgxRiDeUiZ2NFeqAChE79gVaPCOzWodCot07/PJFh4BNNAvhRhQSN5x4NI9ALgN3e
 fHWQORmyg9nQZa8kiuEDkMeWOdiK1yPAijFIM58q0p7r+fUSuUHEpMh+yTIWsyb+IzqS
 dwwQSnAvxX+M1i3Yh8F4cMt51SPAvLC7sclZSM9wOo2WFwyDr/fWUvCN/aYGRQHOfI/d
 b9h28cM9Zx37O9iZfTVm2mCw2ifzwYH2G1HIJJrjfLw9BlWogOTf3MOaw5lS+yKnKB32
 FDTSRP1mzJq5C3qkeIPqJZ0nQPokZOZgMXhVYUTczH/uyGGOSkk6z5lLYDwtPRmQk1pV
 o65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733162219; x=1733767019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DVH9/euVNcJBggiE5fEz1CQkvnAZ9KZBv3Vk0CueCrI=;
 b=Nn60jgMjOZovqO/EWV+E6o3QE3QaHatvlooiGtxIWWLrekDlQd8dOLjs0GoZCQNECB
 qrbjKwRWMR6+D5ya2zfgxldOms9G1r0/gVACFyA58iky6qOimkGsxNCYs9IhJdggqB7s
 hbsC+GZfWYTyKvUaiLr/okxiF4CPy16D0NS/y3uzW+5eT1YXGDbzoP2bVi/1MEB2N6ys
 z964pNUxsaw4GhAoAbuwVI/WiSEjDDVhjT/MxC8yZp9nMWhdiwcnofFy+c72xZldLjwL
 pjpy5HCPqfuUNJKETd9cs51e+fdEO4oHA5zHlMveZB3Y4XP/57SkQCKn+zbW1q+p+xa9
 vaOA==
X-Gm-Message-State: AOJu0YynXQLw4NRAJsL1vqpKfWxkaid8G0cAwR6TLEJtV6fAWpRBktyB
 P6cJNs18U4xKIMkW7XV7/wH9ivwXrEBT+A7t8Xi1EYxVLqPXbjS7UrCCTPYTfgYrG7nwm9ZZfzn
 ZJORYr4Kima8VJcfr//BguQXn5i+hRLxzVjtUd4e4e5HhKQYy
X-Gm-Gg: ASbGncuSoDcRvFJa/54wpKcxqL89m123jAoi5WjVmRPi/6FL+eppnCRMiClCqOuAf1Q
 lVMZ84U+FwWqJkB2TLoWtyWFhoekgFZHc
X-Google-Smtp-Source: AGHT+IE4Gh4NY6FQwU1uI7fkxjOpUNPYczdl9oCj//TK9C+/NtWW/tTol4GPP+nzQ0qke+dmnh/tadN/FnEILBDr8qY=
X-Received: by 2002:a5d:584d:0:b0:385:f349:ffdf with SMTP id
 ffacd0b85a97d-385f34a0393mr3375548f8f.45.1733162217437; Mon, 02 Dec 2024
 09:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20241202135640.80528-1-thuth@redhat.com>
In-Reply-To: <20241202135640.80528-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 17:56:46 +0000
Message-ID: <CAFEAcA9j-iB2Cr2bkLpwoR-Av9XkagO7jqqdN_LSNORDBF=S3A@mail.gmail.com>
Subject: Re: [PULL 0/3] Functional test fixes for v9.2.0-rc3
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

On Mon, 2 Dec 2024 at 13:56, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 72b88908d12ee9347d13539c7dd9a252625158d1:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-11-29 10:09:05 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-12-02
>
> for you to fetch changes up to 92ee59bf56ba42954166e56ab112afe10f3c7556:
>
>   tests/functional: increase timeouts for arm sx1 test (2024-12-02 14:53:40 +0100)
>
> ----------------------------------------------------------------
> * Fix timeouts in arm-sx1 test
> * Check for the "pc" machine in the virtio_version and acpi-bits tests
>
> ----------------------------------------------------------------

Applied to target-arm.next, thanks.

PS: armbian.com is returning 418 again -- maybe we should
skip that test for now?
https://gitlab.com/qemu-project/qemu/-/jobs/8522343823

thanks
-- PMM

