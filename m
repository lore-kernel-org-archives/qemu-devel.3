Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AC3C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 17:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSKMr-0000aD-Ux; Tue, 23 Jan 2024 12:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSKMf-0000Sw-Oo
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:15:13 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSKMd-000290-M8
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 12:15:08 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cddb0ee311so48672741fa.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 09:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706030106; x=1706634906; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4hMQyMp3ILXvrFqdf3ItYHAh35OMpS3XW5mXnp9AQ38=;
 b=z4KpTiBYzKu6xLYfuPAUJPbBbdtkUrRVGdDejl3z6mUG6wZ5FUnQzSd2Ifg3Tm6E0A
 nEnzjVRfT21zzFjsNBnv5zg2q1ohPH+0RAwjJBIyKEYuYDNnZT4la4gyGhj+4xpuiBdI
 9R/z3znQJjjmgiD+b+SwPi1hPpuPZYe/8qe5dPyEe/oo0uWigDS9pmn1MQohv2M6WTL9
 4lVUiR01aA5ILL3bvV8Bf7+78Y7SBAG32yBzP1wr5qa80JhJww3cknffD+inxLnZwXmC
 0G/j0Fr44mzllJ2PPNMzvrV8d3MEyu0cftCriLYKv2xIagTBUAUkdgAGKG1x1ViKC7A5
 5zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030106; x=1706634906;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4hMQyMp3ILXvrFqdf3ItYHAh35OMpS3XW5mXnp9AQ38=;
 b=K2x+9u9B/vx7YC731iOUgkri71Ftchn+L2obJfTjsk4x9w2GNLTQzVZDQ2I1pJXQ5J
 LZFLwQln0Z1Q0g8ssG7jEGolWO1tU1wfws8LbkiE/26RyRFztTkk7XNZdRGHY77GEdnd
 QOi4mbwZCSN8+CLr90D2ihh/6FRKMB1VMLPmV1Fvi76a6vHQZ/nClHtV2SzX9xfHihE1
 jQEMat/FdrDwiMK0Mv2jb4Mg/i59Q/YCvjFWY3++aZhQahqTelZ+ubelHNDy9GHiHwWB
 Z4ouhFuiukdzNIv9rcJEvhmGX8EQGJLm0jqBZAntWav7oW7JEnVcTNLmlxGnrBV76Gjv
 +e8g==
X-Gm-Message-State: AOJu0Ywf8IuxNfgoWPm2kYihXBLch6OzwMZCItGHF03CdgXwTs9eaR1P
 +8eYNw7YJyUY5C/IO2v9+7YSueqb0ndbFygJ6PHw727p7IBD2+RGl58KBAxzCv8G75nXqEEUiem
 LciLfAn/x+pIs2DhJoQM7BZTkrtNp98ka9w1D2GV+JyOcZNB1
X-Google-Smtp-Source: AGHT+IGS8f6+e0xcTk8JegcqGixvikp6d3wIptbNFT0Q0HBgu+2l+RcCzvCpZGAKgFxCQCamuAgN1NV4vRIz0MwtQM8=
X-Received: by 2002:a2e:9612:0:b0:2cd:1b40:5725 with SMTP id
 v18-20020a2e9612000000b002cd1b405725mr35774ljh.212.1706030105786; Tue, 23 Jan
 2024 09:15:05 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2024 17:14:54 +0000
Message-ID: <CAFEAcA_ncrw8nsD50Ov=Fse=gYFw3CabpURWM9yK3yWmL5CTQw@mail.gmail.com>
Subject: proposed schedule for 9.0 release
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

Here's my proposal for the freeze dates for 9.0:

2024-03-12 Soft feature freeze (all feature changes must be in
           a pullreq on list by this date)
2024-03-19 Hard feature freeze. Tag rc0
2024-03-26 Tag rc1
2024-04-02 Tag rc2
2024-04-09 Tag rc3
2024-04-16 Release; or tag rc4 if needed
2024-04-23 Release if we needed an rc4

(Easter is 29Mar-1Apr this year, but we can hardly avoid
that entirely.)

Any objections/suggested tweaks?

thanks
-- PMM

