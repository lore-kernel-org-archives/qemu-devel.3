Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84985C282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhgV-0003ic-F1; Thu, 27 Feb 2025 12:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhgS-0003YE-VB
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:28:28 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhgR-0007Yg-8j
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:28:28 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5dc299dee9so1127677276.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740677306; x=1741282106; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gRnxIZxMtrrbRPm4yK9hUiwseHgdagIQ6mDl6/+dzFo=;
 b=q0/AsQTxIVRPLMtIwkmuKe6euv/Lae9HtSGl1ki6yhCAjxgIkRp/rBv+J7k4bG+/Ca
 pCg88o1c3UwKWIX1tUHNLFpeL+TcI2Mpo07d8oQ4goBcSoyJrYWi1bOcDBe3J/w79R55
 SKmG2uA/fRPYohNBqVyIrkI1Fu9nCNdV1/2SilCWFLmQCELf7girhB6ZajNFjltbb4Pt
 5VTl1ZkpEFqUP8cjYRA08tTwcZPAWOJypktJWOsqG2Sp6j6LPTrRtU+zZkl8QwJihZ3l
 wuLrr0cNLMFMnScV+a2MroKnDa6ZLkD2lth4E+aDmfRERmb4nxL94QutnGsW9lL4k1bl
 DcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740677306; x=1741282106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gRnxIZxMtrrbRPm4yK9hUiwseHgdagIQ6mDl6/+dzFo=;
 b=jtKyxfUAdtsTfVE7K4SDPGLHIIe6pptKGusGChRAv78Hyh/ZawyyCO9CEnCWJEKuSg
 qX4Aq0QgdiKF6A+2g90DLhZz7y/QKZNVWOYLZ+A1O9XyUkLAC5w0Bb9OqcoolyWbCRZ6
 rEcf+Qe2viEeB/CRNJWRaP+3jvqRVMvnObdayj9nyw/Hj7Z8vpxfyB9FWP97ksVXshML
 OqLS9Ed7ML06JJViR6aIS91CaZFM03g/r+3lUItwqpQ6S3A4lc1qk304cg1Vr9LYg7Ga
 xSCfH2cZq3VFkFlaq5PFEj8QSOfT1j54LojrVIO65+W9EdHFNrDny8yYxYz5c7UXtg/j
 KDew==
X-Gm-Message-State: AOJu0YxPTay2ZFQNa/XzbBL+8fvL4YWfWa5ZnS+HvrDqnbHqOSLLcWnX
 zkwRf9LUktRw8GhE7gC93qf8gIdId3+8/gAcKRlpz9GP4dFUNrO9K05RLzEhtYISv2AM5pNpaQD
 MmU2fTxtrmkZkB5rVELh4IPh8TY+OWeXnaDeFlw==
X-Gm-Gg: ASbGnct+4HqPtm3NaS1zaSGx+U86g1bdTg4kYO0m+ecZCHTHyOsLE8/iuuJeLp7jbb0
 DsQ27H7z6/Iuu5hssaFpuTYB1N8GTpEuFMMbtflpihE2kdL5np4zRDm4E290IPYTqABtFPTYHMN
 KvZjdXHYdP
X-Google-Smtp-Source: AGHT+IFcKWVFmecCBdeWNOMlxRI3/ZGJkWMLBTh5K9DiQ1qDV0qO5YIAaoN0lcZy4GduZGbLmvBSYT5H+5bVLEkZXLk=
X-Received: by 2002:a05:6902:340c:b0:e60:9d00:ba9d with SMTP id
 3f1490d57ef6-e609d00bb66mr6422668276.25.1740677305854; Thu, 27 Feb 2025
 09:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20250227164538.814576-1-pbonzini@redhat.com>
 <20250227164538.814576-3-pbonzini@redhat.com>
In-Reply-To: <20250227164538.814576-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 17:28:14 +0000
X-Gm-Features: AQ5f1JoRLz6cCGGRc4hHVQJWFYy2jGzkf6KFmLrJsvpHk8prp9P9ZnYGOTcFgn8
Message-ID: <CAFEAcA86CEbeGK6mDju5jyR7JQKB7SfnO4-JoAnyiL2kRNufkg@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: pl011: move register definitions out of lib.rs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 27 Feb 2025 at 16:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs    |   7 +-
>  rust/hw/char/pl011/src/lib.rs       | 509 +---------------------------
>  rust/hw/char/pl011/src/registers.rs | 507 +++++++++++++++++++++++++++
>  3 files changed, 513 insertions(+), 510 deletions(-)
>  create mode 100644 rust/hw/char/pl011/src/registers.rs

Looking at this patch I'm sorely tempted to suggest significantly
trimming down the commentary in these comments: it contains
rather more text cut-n-pasted from the PL011 TRM than I'm
entirely comfortable with, and much of it is detail that
is irrelevant to QEMU. I don't think we should be trying to
make it unnecessary for somebody working on the QEMU device
models to ever look at the hardware reference manuals.

thanks
-- PMM

