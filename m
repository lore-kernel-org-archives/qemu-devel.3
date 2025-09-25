Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CA3CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 02:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1c8x-0001wQ-Lo; Wed, 24 Sep 2025 22:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c8v-0001uO-QW
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c8q-0002Tb-F6
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so313336f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 19:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758768922; x=1759373722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1YxsdJ/dwXQf54qmhwO23pjL//EyDJ2Jun+bGdlFb3w=;
 b=Z8NXHxq7Qncp1UhQiOPQCDH3p9bc7lq1+VdsE2YNWHmuqzDCXp8kYZQm8IU8RDfyTb
 Dxeqi3mWrLnWVZANYEnTg/Jpu3t0Tb8PiG0ES3zsyz6ZOpLATxOAMviaTFnz/bh4FUAP
 ncPu8BCES5i5QPSImoqqHnIzfTslZkv6j5iZuZyCVqgGGXLCea63WvjII9aYQzP1veWY
 jqjEwy8aTZQ6asf48zxO4OyPJjpuUAo8kBPQUjg4iEuDT9YWSLU+ceOs5hsfD09SdLn4
 4MZtOQ1zayqDK77dLnFeeHNS2ITkCw3hHbnPIqTcdMhezJuAMJOfcRJBk+8QqFNhYaYr
 4uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758768922; x=1759373722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YxsdJ/dwXQf54qmhwO23pjL//EyDJ2Jun+bGdlFb3w=;
 b=T/CAVlTTURX/YCfrIE5Q4FBohnpg8c24m41WCAb95T3+EHE4JRaHnb15GfMnoKshAC
 RrO3IeigRriGaB5niCnjI0msZCrAJpPZIPLyC8o9md/RcXkvYgU1biYQECo5I1QVfDLZ
 iY81QvcKy2fOUhHgYvvkDJ07L1enLOnWJI7S7GcmMvSuZQZHC81X9r+IVYnYua7h8bqm
 8TM2hOuleXfrmAPzpcPUUFa1WVFzD9y4Pxi5nzQm5Qojo54FgrF5uoCtF/kp2bSE49a9
 SMC/+5WsYGL4x5nb9OJ/4XT9dMHxdAmJR0ws4zTrUzDzf8EWNwStdurUaOQ5JJutz/xM
 +cMQ==
X-Gm-Message-State: AOJu0YzqM/HErEYne3HiP1RqjbEkhS5fLBReEObkHG2yoyUdgzjr9KhL
 o/PfZ8h2M58S/SF/Decf4j9ZbGzpoUzL2Cw46ZLDgObeEXgTHRms8KFdQ5CPDHdJk0pOv0hMwGr
 X+Pj1zJ1+JQ==
X-Gm-Gg: ASbGncvTs86uM9vqxnKzSemqPqEIDku6ZqDrpDZ4vQigwjFWZ0ycWmI+YAPEqFXIH2U
 b2j7/f04qyG/ieesXoOK4XZje49V8c19OfrVixFaZbp8rh/orgQVAqvUUeZDYqoN6flSaBPBBiu
 9p0ZUOHDVZZlhIaYlzfu7Zyfu2cGfdSGTX76sbqxCan68W5hZXyte63+PgOMTuQjy4PRrIZ7yxx
 ySg8jc4G9sWFmr0Du5nur91mVvhVCe9fUIivW2BAMrfjJXntWbDzcQcMgR9N9xpA1g+hH5TAjP4
 Qz9G9vMq/b+viHmtWIfuPKwEx7k7cAQI20R4t+tSGCq2aBM9ugb8GoG7WpVKuOnOIO/cmSHBEpM
 yKfN5EVDY4cCN3IwflczToSxo8oxUcLGwE77npKAIOmNmEf5kt9ruKOqFfJmP9wb438hGPZol
X-Google-Smtp-Source: AGHT+IHi9KmpGUp4F9i+ushm8citrvWXcxaj1RbbwdJ9nVk9DfBxJDnMe1IcKO0bY0LOVzs9xhmbfg==
X-Received: by 2002:a05:6000:2304:b0:3e3:e7a0:1fee with SMTP id
 ffacd0b85a97d-40e46514dfdmr1666905f8f.5.1758768922292; 
 Wed, 24 Sep 2025 19:55:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e330dcb82sm7784185e9.4.2025.09.24.19.55.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 19:55:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/4] cpus: Cleanups around cpu running state changes
Date: Thu, 25 Sep 2025 04:55:15 +0200
Message-ID: <20250925025520.71805-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Few cleanups following Paolo's recent "accel, cpus: clean up
cpu->exit_request" work (now merged), extracted from my
"split-accel" work.

Philippe Mathieu-Daudé (4):
  cpus: Only resume halted CPUs
  cpus: Access CPUState::thread_kicked atomically
  accel/hvf: Make async_safe_run_on_cpu() safe
  accel/tcg: Use cpu_is_stopped() helper to access CPUState::stopped

 accel/tcg/tcg-accel-ops-rr.c | 2 +-
 system/cpus.c                | 8 +++++---
 target/arm/hvf/hvf.c         | 2 ++
 target/i386/hvf/hvf.c        | 2 ++
 4 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.51.0


