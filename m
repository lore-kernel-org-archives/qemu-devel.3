Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D144DC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 13:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3wH-00016V-Fs; Tue, 25 Mar 2025 09:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vL-0000oi-Gu
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vI-00081d-Vx
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so53538615e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907745; x=1743512545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FI28d3al9G1K9slKxPKNzbPGTJUh0uXNQ2pfMhuk3Rw=;
 b=FeW2qV7LahFFUJceDlnvQIkk48El1/PNaYGvxXpsFOOP8oSM0hF5ItuIoUVsSMgmN6
 PrIs3RRrVf0TUgRjjLy5O5wTaM1LXMspUXwerZDANvIRFs4hBRrKqDGIrgcZ71/9paD3
 aTl8g1eIvgY2k6SwEvSKaC8PjzXwM6GtP3nDo9IqXTvs3LW0klNopkPeEF3kybqYXtYx
 DwKnU6ecBVtrJI9LgoqOIzSQrusc3+8ZsLT3HspKRJdnOe3YIoHqRTVPIaQ/GpOdwO6j
 EZr62mig429AHcPj4FFa90bhpXVikv4/jD7jExGi0Rf8Y+JyKXimyGRQGwW8rmg38Y3f
 +i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907745; x=1743512545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FI28d3al9G1K9slKxPKNzbPGTJUh0uXNQ2pfMhuk3Rw=;
 b=WsK0UblBaaNix4GWOw5YUaq8zFi3cIP5sTZhTr66NVffhtD7g9eaQwl7mKkbJx6D4h
 ut0ddph4DC1LFG34oACGg+mRHRwfY2PJ829i0c0UzzynijX5sjBEz4K6sYD1nhIvljhr
 l/56jyUvdAf+6em88AJYqWWSAdpkTweSTntqPTdfxsCJPy2ffX3iO7NbXsjb/zPEoUE7
 /gUo1XweMZdlbWhjinMvZOcN2fXqGNyMhgZx3T7L2QhsKc7jb9R/PjA8pJRnWWw7rHB1
 du1zTE7fMx4ZLxIDOObf0j3kiUbbec5Db3BDZTNe4X/tEdsUlTZFOqpkRmNmF7tOh8d6
 /LWA==
X-Gm-Message-State: AOJu0YzkKULPr/0j152gKbXaNVtG6Lg0zXtSGOPL70Dc8z5FmSzovPJa
 QXVuZz+Scj1/1/LFW+swhzIEeKAv3f2dYvtz2EFgfkF0t3EouiUQqc92epKpFGP6X27wJ+0qOnC
 h
X-Gm-Gg: ASbGncs0gb/02fQAjTf12Gf4SXHSmwQ46D348a447+w+CwVyL+HT9Ga2s7V3uX4RMUC
 2Ia8BOdexCvNuG6DpuA3U2K6dWnA93mKQ98tNUrmM13lJdzk87ZRdE1Za85zaBOE0IY2BLsvxWf
 TSI8df8FqhLExzOq8awlxTFQc4efPUPDdCdQZsMCHyp2tPcJ1LaXgkcIAoB2tNnDLH5/PS2T/tE
 y7k5eKnz8balAvDRRjDxJn1BdRidjsLQ6rxObPxPZ859ysbo73aAvgKpwPL3qq9k7LYMpbZbmdc
 zvNF9Q8pC6kq0OJ/dg89v1+c2ecwB/WQl/wcbQB0icBGq2Ll9KQMbdL/j2wT+bwHaIoHt3pMvTc
 vzR6qk/WjbcD9EiVfNMQ=
X-Google-Smtp-Source: AGHT+IEzeqCbUfPLvuwdx1q8hey8oeembA/H8J9h2Tg4riiFXtjL4FzH9420ZZEBN/fG/lGE/StzTQ==
X-Received: by 2002:a05:600c:c0c:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-43d50a35aaemr171833115e9.29.1742907743199; 
 Tue, 25 Mar 2025 06:02:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd18580sm148311815e9.16.2025.03.25.06.02.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 06:02:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.1 0/5] exec: Remove TARGET_LONG_SIZE definition
Date: Tue, 25 Mar 2025 14:02:15 +0100
Message-ID: <20250325130221.76116-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

TARGET_LONG_SIZE is only used in 1 source file
and 1 header. Remove it to be able to focus on
making TARGET_LONG_BITS target agnostic.

Philippe Mathieu-Daudé (5):
  target/i386: Use explicit little-endian LD/ST API
  gdbstub: Remove ldtul_be_p() and ldtul_le_p() macros
  target/ppc/gdbstub: Replace TARGET_LONG_SIZE -> sizeof(target_ulong)
  user/tswap: Replace TARGET_LONG_SIZE -> TARGET_LONG_BITS
  exec/target_long: Remove TARGET_LONG_SIZE definition

 include/exec/target_long.h           |  8 +++----
 include/gdbstub/helpers.h            |  4 ----
 include/user/tswap-target.h          |  2 +-
 target/i386/gdbstub.c                | 24 ++++++++++-----------
 target/i386/tcg/system/excp_helper.c |  4 ++--
 target/i386/xsave_helper.c           | 32 ++++++++++++++--------------
 target/ppc/gdbstub.c                 | 10 ++++-----
 7 files changed, 39 insertions(+), 45 deletions(-)

-- 
2.47.1


