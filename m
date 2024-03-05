Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6940CC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhRML-0004Sb-Go; Tue, 05 Mar 2024 04:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhRLl-0004Ka-7F
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:44:47 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhRLj-0003Xf-94
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:44:40 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-563d32ee33aso6537298a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 01:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709631877; x=1710236677; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JeZCWv7cmtNskpcCCtjczX0TjupB0fz4ZZyNX+ULMfk=;
 b=D3/S8WBj7GZtKC9em9k0vBtQm0VuiUoZ54GeEuioLHnLQCZcRg+uYnw4Ij1pDdEfNr
 QsXhoA9Bi8NQfrI9WqGcfld4oZ3mrzNaOfFhL9w/su2raLlFaOaUlRs+5lZgLqxrOZ4n
 aLdQa0OoDlyMmIheo/mkK5sxyjcAps7EhNMNC1c/UvYHhjehKjs7ewg43bGpvE0DHBY8
 tBX+LurjdcPdLN4oxzxRiMDT0jxr7opxdutuBETWbYWHz+jS37bWAgUI4/Cd1dfJYwVa
 8FddhgfpQiMISsVE/HjcUc92yhOfMrMR4IrNyCyqwYy3DayNU2jWIG2R64xOdR8eY+Vx
 lUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709631877; x=1710236677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JeZCWv7cmtNskpcCCtjczX0TjupB0fz4ZZyNX+ULMfk=;
 b=pKgoasBNntOJl+Djwk9OjiLNRrJlqU+ELMA//VSLRVfHoNbVheR+ot3+ap66w1gspZ
 QehdSSWya4bfj4L3OdeyPJvNY1l5pp0IyP6/XrBbDt5vju7K5BwbYk8j7daK0Qtrdtsv
 bnFFBo0qFopWUjmfqNE56/yUbuf5PLXVe7TJ2bHvTCfAun5jL9JcwX+GKFQ36GYmfxb5
 UUBtsSVvhgGBgkmMWmNYhhXrFZFfbvJgHGs0JFP261XRDND0evXWnAUS9bc8QdivSG+k
 LRexTBnc8BnzZKQU7OKBb7GaHmhfzduvhtoVEaJJu2dzMzyKY70lsjYyRxCbUl3+f3pY
 A8wg==
X-Gm-Message-State: AOJu0YxaFBEHsZh544LMDdwwM73i/oHeeP1YEMnZruFPo7vb1eLL03WH
 L/+VU/OO2d98etKugPEx0QeYsK0yHODa0O0ZM5Ik2Lr35xugY0nCDEaKFSEgydQL2VDMbN69HFU
 0D24Bd5ThW0PBed3+dtpIlmcoYGIpeQN3oWfxEw==
X-Google-Smtp-Source: AGHT+IEzAsFW13XbjLQ0aevpIO3MOSu0QR9Jaiszj6/S+bpC7xB/uOXg0SG9/uufutb3gmXxmXRwNih6UJu7dIzHH1Y=
X-Received: by 2002:a05:6402:2151:b0:565:f9c1:d925 with SMTP id
 bq17-20020a056402215100b00565f9c1d925mr8136052edb.0.1709631877065; Tue, 05
 Mar 2024 01:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20240303054645.3004-1-deller@kernel.org>
In-Reply-To: <20240303054645.3004-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 09:44:26 +0000
Message-ID: <CAFEAcA-TD2Auf4duTP=Debpkn4T27xVD3oHR1qDhqsvRsxu9yA@mail.gmail.com>
Subject: Re: [PULL 0/5] Hppa latest patches
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sun, 3 Mar 2024 at 05:47, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:
>
>   Merge tag 'pull-request-2024-03-01' of https://gitlab.com/thuth/qemu into staging (2024-03-01 10:14:32 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/hppa-latest-pull-request
>
> for you to fetch changes up to 839a88e8bd1a1efe05844c39a59985482894f4de:
>
>   roms/hppa: Add build rules for hppa-firmware (2024-03-03 06:41:19 +0100)
>
> ----------------------------------------------------------------
> HPPA64 updates
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

