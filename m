Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ACFCD1297
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 17:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsQrM-0008OF-Ui; Thu, 04 Apr 2024 13:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsQrL-0008Ny-Mg
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 13:26:44 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsQrK-0005Sg-4F
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 13:26:43 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so1375066a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712251599; x=1712856399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A05K/j65InDe65ZKiLrJ37Zq/ILC1jPnX0IufXZJWvA=;
 b=PQfxTllmHMToIx9qWbxgjQgXpUy43FR9+f+NiZ/A0xFiFwU1HzsI2TlpoTmAjfdpvu
 O9NQT5rfyzDu36oLVbbCyqQvLVV+EiEr4AnVG7ttAcJXBJeiaA7K9lnDIWtN/WzE1exn
 8rJRXs/3k//b27G+axft3znh1c9NSZUbfrh0y/LlHJw64FYNttVPiNoorPvpNpEfdtRj
 h8lq4lIweXmki5jqAP1drlFg23S5u+jKW/YMu66qBg1180jX7xdF9C9z4SCYjD6wMPaq
 dfamecSPve8hf5xjcfRJBm6onrn25+grbsdk3OobdE0Wb5QTQwSY28Y4fUjfXRtVJdob
 +oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712251599; x=1712856399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A05K/j65InDe65ZKiLrJ37Zq/ILC1jPnX0IufXZJWvA=;
 b=KTNiIvsjRhPFJepy9nUYWHNvFwEIqa/OvnsLO0ei/3lEVBHFHUcOUB7QJ8vZDPIiKO
 3J6sLZoFS+uPSsdcF1oxbhMUNraLrPFe1wK9rh67ONb4uwxFtGzfAk+4QJTt4/WSTBac
 p9YZ6iDZ52n20kUnA+hkyKNr5aTPGJJyINSUHfcB9iLDoofWmlGawNul7ljXrIwWaJlz
 VwucLmaPCMmxwxOLs83+sORbI++jYj1VOuwlTNVTqLUJE+F0MYOw3mNEBAXvR+7T/pF5
 kUYByQBxvkjoyr4EOfxj8Z5xnA4bOrN+LkcMuujwYkYUJdeRUmw3VMRVAQgYmy6oiQmA
 XVjA==
X-Gm-Message-State: AOJu0YxXOTlVh6LxNZjTnnYgzzWDklIwKxc0jGDX4GLy+hYNXZPT3IGZ
 xiDXF6tuvtozorkU+eetn9ElQfHszPibwzAHWTfMyNUfijRSr2cfAw94t67m3f3UuCII/6nOsxG
 7aeBI+3XEEYUM1aE9+7enlcIfCd6kdS9EKzX6e/wiXjmoLIOZ
X-Google-Smtp-Source: AGHT+IFR+/S09JefqKJcyrJ+BrOB7W5Wf/2kgeQ9j4W4H22/1c6waeDBYriD0igzYcjrBbtgrh30+iPIYAW84/WAdC4=
X-Received: by 2002:a50:9ee3:0:b0:566:2aff:2d38 with SMTP id
 a90-20020a509ee3000000b005662aff2d38mr358631edf.26.1712251599554; Thu, 04 Apr
 2024 10:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 18:26:28 +0100
Message-ID: <CAFEAcA9rScgT1KobUUAb_G9Lq9-9srveubN+uRN44CYHXoYY1w@mail.gmail.com>
Subject: Re: [PULL 00/17] qemu-sparc queue 20240404
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 4 Apr 2024 at 15:25, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit 786fd793b81410fb2a28914315e2f05d2ff6733b:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-03 12:52:03 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-20240404
>
> for you to fetch changes up to d7fe931818d5e9aa70d08056c43b496ce789ba64:
>
>   esp.c: remove explicit setting of DRQ within ESP state machine (2024-04-04 15:17:53 +0100)
>
> ----------------------------------------------------------------
> qemu-sparc queue
> - This contains fixes for the ESP emulation discovered by fuzzing (with thanks to
>   Chuhong Yuan <hslester96@gmail.com>)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

