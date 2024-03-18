Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1C4C54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDA-0003VV-SK; Mon, 18 Mar 2024 11:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCx-0003KR-IW
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:28 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCq-0007tp-3s
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:27 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6e68c1574e3so733781a34.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776838; x=1711381638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cpDZh15JK6klT5wZKrbBKlp9qR3QFwaO657r9oH5kc8=;
 b=brlvid480Cbx4QALjWFb7QI/IlxGKaE0O0xBBiD58NjxLQKXsoZcwrVUAJIjcnDWQ1
 0isJDtEiLIsPvCXEWiAVY0hKfO1RsOeRiRG+w8uNYcUaogvhGFHC2T+YpTyNzQy3s86s
 0wmiM/Y+FaJG6OSRJAB07jHFvch49vLJG7Lcsaql5fb93eCX4yFIEH+YtFw87hu75Yhh
 tFKOx0v9/NqMVK1aV2Ge7dTqYSRoUEVozxbNclVNAO72ynwRArNq8mv5vIfuJXLriIL4
 VoBWa+iM7pxsIwCHAnyLirDTsT41pDhnDsXfJ1trZ26DYbiPPfa/wzZlWYKzHRLkLPPb
 X6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776838; x=1711381638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpDZh15JK6klT5wZKrbBKlp9qR3QFwaO657r9oH5kc8=;
 b=j99QgR+mJ0uxYa5Kq5UuDjUPFB1iGQE8osNhUxTcP3qqJDbilZXGY+K2VeGY9yHt+m
 OcXZxZnGzQRDA22rVw6zeMBwonNxb/S5t84pAf7Bw1H6bIM5Csrg20sybj+8x+uqUFpa
 jzI1zquo1dhEX09mFFU6n++wB/LQpFahdgdFEZlFMTrHph0K+Tsp7DwCoiGbByB0i+Yy
 vrqYijxIr1YDPjn67WAw1YXUoxNVo5AZ0yROBymrHcyAFb0K4yW9gDXVxHMvEJ1LR/Xe
 Vb7U4RWNTuXOODkvbxMOgnand49oyQ4v+wrfmDDI6Hnnl69AIeiZsFV5QdKaDjahtcMo
 SDrA==
X-Gm-Message-State: AOJu0Yx4aS5Ds1q7KzlMC3ybPwiGkpd6mYkXaq9C59OfHWMmtNAMwSGm
 XJHBTGyBaNb6EkDjiW5ni314ZeMLPUR7fLi7b0p1OkErrQxNL3jRsepzeF2Iguo=
X-Google-Smtp-Source: AGHT+IH1A/xxW46MQmQwbwjWOk3clylkGJpJnpvswp6ujXv431Z057qUO6Jc352IfolwYi3qOZsb5A==
X-Received: by 2002:a05:6871:b14:b0:221:cb1b:c572 with SMTP id
 fq20-20020a0568710b1400b00221cb1bc572mr13897924oab.25.1710776838517; 
 Mon, 18 Mar 2024 08:47:18 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 08/24] replay: Fix migration use of clock
Date: Tue, 19 Mar 2024 01:46:05 +1000
Message-ID: <20240318154621.2361161-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Migration reads host clocks when not holding the replay_mutex, which
asserts when recording a trace. It seems that these migration times
should be host times like other statistics in MigrationState. These
do not require the replay_mutex.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 migration/migration.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 644e073b7d..2c286ccf63 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3424,7 +3424,7 @@ static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
     MigrationThread *thread = NULL;
-    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     MigThrError thr_error;
     bool urgent = false;
 
@@ -3476,7 +3476,7 @@ static void *migration_thread(void *opaque)
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
-    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
+    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
 
     trace_migration_thread_setup_complete();
 
@@ -3555,7 +3555,7 @@ static void *bg_migration_thread(void *opaque)
 
     migration_rate_set(RATE_LIMIT_DISABLED);
 
-    setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     /*
      * We want to save vmstate for the moment when migration has been
      * initiated but also we want to save RAM content while VM is running.
@@ -3588,7 +3588,7 @@ static void *bg_migration_thread(void *opaque)
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
-    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
+    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
 
     trace_migration_thread_setup_complete();
 
-- 
2.42.0


