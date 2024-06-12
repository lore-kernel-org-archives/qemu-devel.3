Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D02DC27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHU0v-0001V2-NU; Wed, 12 Jun 2024 15:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU0q-0001UT-Ob
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:52:06 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHU0o-0001hh-Kt
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:52:04 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70109d34a16so201704b3a.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718221920; x=1718826720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCFt+tldr1rW+0NreK8qY40FuQCSjQhtCWx/uKeVdGY=;
 b=J7tZ6yME1FKeDUN2jg23lgI16Gjbij4Yf9byHcurW1D6gABwZ7oN3wHXBVT69BsSQt
 YER9gCqNZ64kFl9/kkFmSfIEmS/R5HS6/+4Uw51GDkP1wiFrYjVx1WkFLfqn4zRnxW52
 xKFSEcJYO+8y1yjlt+IUWz3zTKBLQsZXcuTyBiq53o3h5FEhSSksHklXsMftG2EM3MV5
 f/B0CNl4J7nrm9zzM+vHa1i+ZxnxinsBL34jFK8UOaDOQeG27Ra9RrlVyswsGQp4Pyc4
 xC8PPuiuCKKEtrrOI8HkzsxvF1UFe6JZ902t6frlRZwnRHxqx9OS59QOlVdljQhiaojv
 3rRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718221920; x=1718826720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZCFt+tldr1rW+0NreK8qY40FuQCSjQhtCWx/uKeVdGY=;
 b=Pya6NvWE8gE8CnEYB59lq56Xc6OVee4K3/yUoTw3j2J8GffPsBEfxQc7rscDXwmAl5
 qTckJOL+4ExPTD4NLe4dZZ3KhcAyji6iFrPKobm5g2FscRMRFRwBPlyvS1q9ppMDn32d
 NzAZCsOQPpulL6akw9UQ1gUOGUvc5xDH1yVBIC1D6RymtOQYDUFrWezqOcWpP/MEP4Kb
 cR1wqNpZW5iZyXsZ6CLnDNyO8eK6wbInnKiiOBPe5euHFfBSzEjso6CwPDUoUtUAlrRs
 udYWKOKjLeOl8WC5N0RweOZOzNO/Gt34Pb8EUl2JhPps52E+brRCi/L2j/GF7mleRbxx
 Ulbw==
X-Gm-Message-State: AOJu0YwNIhTE2Au+aiRrIrKW4YsDA7wgWUS+ojJvbsuMH25IhJIJPxY1
 FkOxhbYXTeWufPKjm8GWX6beR6bRKAtWIt+ajODFLlRwcvWyjm66WkwHEkOs7qFtRkzuY5N3ZWs
 g
X-Google-Smtp-Source: AGHT+IHEjpoqzT1K53MYa00GcBzaGroJRiJFyPEvwwiRaxrbdAWO8qnl5hsoT2BEsTb9DYeCSf4rBw==
X-Received: by 2002:a05:6a20:3d8a:b0:1b8:54f8:3856 with SMTP id
 adf61e73a8af0-1b8a9b3514amr3611704637.5.1718221920425; 
 Wed, 12 Jun 2024 12:52:00 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70424c7fc99sm8009927b3a.157.2024.06.12.12.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 12:52:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 0/2] Bug fixes for plugins
Date: Wed, 12 Jun 2024 12:51:45 -0700
Message-Id: <20240612195147.93121-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

Those two commits are meant to be applied on top of current series
<20240612153508.1532940-1-alex.bennee@linaro.org>

The first fixes issue with windows plugins, while the second is a bug that
concerns memory callbacks, and due to a previous refactoring.

Pierrick Bouvier (2):
  plugins: missing QEMU_PLUGIN_API for time control
  plugins: fix inject_mem_cb rw masking

 include/qemu/qemu-plugin.h | 2 ++
 accel/tcg/plugin-gen.c     | 4 ++--
 plugins/core.c             | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.39.2


