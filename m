Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49222D3B9A4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 15:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxli-0003A0-PR; Tue, 26 Nov 2024 10:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFxlg-00039V-MI
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:46:24 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFxle-0003EK-Qb
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:46:24 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cfd2978f95so7788345a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732635981; x=1733240781; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E7tw824mWO6uL9TDtFfa2x9dPrRH2osnMZtW5VtAK+k=;
 b=GQmeSeBlv60kh6EYueIfEI8ZlaXO6owaBSFdbzWWRda1U4FfMY9WL94447SzSrO8Pd
 7vloxXLSaZMJ1JGxzW2lXz662mUco2FrbHJCg+nP3lY2Wjn3k64Wk4aHtqE37jm7103B
 /oxE0xRrD4eRJdH7y84bmVQ5Lsoc++gDoyoB7p68Ujm6iVTb9Cr9nz0m/CYJCV5FPWvO
 3MizpEXt5jWLeH2FOE96NNvVlxR08mx8am4usvOKXaHczvukMGrRdh8nee0pg+O1sIrG
 CAYZbtJuazQF8/HQX9dCOqlKi6mE1jmhYUBIXAfamaaBFsgHNpHKSOBaOBwRIhvr0YXy
 YErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635981; x=1733240781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7tw824mWO6uL9TDtFfa2x9dPrRH2osnMZtW5VtAK+k=;
 b=PpDznNqD1aWh4iiK97H//QJGeOMF6D6DyX4wdBYkO6YxJHTBEsK2o9I/ql56vQMdjK
 ncJNQnhWneqqsSnCT88wsQdtuALq4QAYZbRslcLboR9/+0Ws6pGNt+QebAiZB77WzWXK
 0GZvsAzKB9hsbiTtch71gEwHUa+NX7tOhbexdfPUbzv3gdCQrdF8e0GKaPMM27rMbumP
 lRu/Picn8UuSNl9ESGFqCM6SeDrz9Zg9aDP+tYlRwSZben299HS8ogQT8d8onCgN+X3V
 ISD+/bV1O5M6sMMZ6JewpqU1jZOcqGlxSom8j6tr/jmn/uNilbj3uEQ9Ym/A0X5hbKZY
 7Pwg==
X-Gm-Message-State: AOJu0YwyCP57n7ejlRMPQPOziabv4HUVmNyJ6Uyn7DFsfv0SpqTmzCB9
 w+f5D+vbeMQmgjzbcSgNS+H9VSxNEimE14AuhrtIG0hNjElI4o3Zih0t3CMkOK3WoAhy15geISg
 E/M8D6XyrIreEYu773Id8zMpsW5u2WAXdKtNO/Q==
X-Gm-Gg: ASbGnctG7D/mg/g8obRMfkSLlvchseQ//MXEvsoQ7hOoqT8/ajvaWu7fplWOATfxCmz
 CeAGiki2JLJbDBVowd3//JSlepBpDfUOR
X-Google-Smtp-Source: AGHT+IG68K9g743X1RrftrJLAhfRyNUEP1alOyY0HidaBIcUgtkYzKi72V1ESnUY2myvPod4UHLqPagMf+tP2u26n3E=
X-Received: by 2002:a05:6402:2348:b0:5cf:cf81:c389 with SMTP id
 4fb4d7f45d1cf-5d0205fb16fmr13423922a12.8.1732635980892; Tue, 26 Nov 2024
 07:46:20 -0800 (PST)
MIME-Version: 1.0
References: <20241125212256.62608-1-peterx@redhat.com>
In-Reply-To: <20241125212256.62608-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 15:46:10 +0000
Message-ID: <CAFEAcA8VtDZ1+P-KXpREtNqv4Za2=hOeq-XkowJ0Yi7F8f_qjA@mail.gmail.com>
Subject: Re: [PULL 0/2] Migration 20241125 patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 25 Nov 2024 at 21:23, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit 791e3837c1105aec4e328674aad32e34056957e2:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-11-25 10:44:11 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20241125-pull-request
>
> for you to fetch changes up to 59c390d95b4984c87db0deda2b8dad0c9595156e:
>
>   migration: Fix extra cleanup at postcopy listen (2024-11-25 16:21:55 -0500)
>
> ----------------------------------------------------------------
> Migration pull for 9.2-rc2
>
> - Fabiano's patch to remove double vmstate cleanup in postcopy
> - Peter's patch to whitelist pipes in fd migration URIs
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

