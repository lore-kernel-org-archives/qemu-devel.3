Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E52C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHh1-0000mN-Iz; Thu, 03 Jul 2025 07:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdZ-000572-Iw
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdY-0002Et-3F
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:57:53 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso6148705e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540270; x=1752145070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpujPKNmLzr2YCI+n9fjeIzsX6AjXIBIk5d4rtXU8jY=;
 b=ZpT5MMaklG0ev4xWhwjfo0PjmibbcWIszvHHVtwiODkX+eYB7OGGtiI+/UG5PDZL5z
 bb5jkKNYnyFUpwzphLjME1I8V6Z862zG5U26Byk1wqOz2xIcixwieAEF65XOeHO/AVdG
 IcZHKPoexmltfBmGbDaLBhxFNEwVxNC3WuB8NSRW7W+8weCSpujP5g5auRCKXXe3+cvm
 sY1lpYtDtWzYO43RDx9Ql5jjnRlMNIxXntXLAQhG3Awq2XzIfUiEcek+hLokd7Z7xtTl
 X9roM9O6+9sSZf37M3A2VK/zEPe1uYkVOYyrnG4BEcoGtRdUGKHID6RTQN7+3QqE7w8r
 J4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540270; x=1752145070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpujPKNmLzr2YCI+n9fjeIzsX6AjXIBIk5d4rtXU8jY=;
 b=uDowDBXN9tgdjcRJfZoxUPevsHJV/xYBiSpov8O5aDczlJLbpTLLvlbYBoQ5znHnUp
 seQWrmIccBcxwGmDtk3wpHYSjMrz8sTtpnvt9NZI9r/1enWxC34fF3WgBW65zlo6v/Hv
 KLEP85g7RGzWjuNivQFQeGFlk6+hCLNMfa5hWzgPb978YMT+l9VsCmAV5yiJ0orWu54G
 V+FGmyjpG91FnnwfVha8EngpMRKYwwTq8w1LKmgsP5qMVrMCW4DUYU47aYUnryOKH3Ar
 X7VORw5zI4eRQgiLZPKiKWCjglvBr3C6XNeqHFoF+fqkShXF4uIFaB1RUuqKZ/AZDPTd
 BUqQ==
X-Gm-Message-State: AOJu0Ywb0WPDxqCChqyKymY7FrBmOuK88yzR/sP+ZP3ZWmKKrwkXAX3w
 qvfZqm0hUXB6b7bQLLFUKvh6zTwAtiq1auLww7xc/p1hCW+5ZVchw807Vg8xxd0IzZx9rn/pb3/
 IKlFZ2Ds=
X-Gm-Gg: ASbGncstXomxkOhEpKoQiGZp3mtHkSNyRrzvNYULUQqtpVJMTcGP/Dmp0GMaH4UqwCY
 GHvIY9NKlD9eRtC1Q1SvGS+E+IIfAq+yj4EeUxzuGpcCG11mpwBs/670u1CECERUOZgQypKUp7k
 q5Loksf8AhjNvbAVK3sJL9uSd5WvCZqEMdeDHE/g9PdT7WJBpbnIsUJKdhwSoFvQiiHpSwfAIik
 xz43MKdwFSNFatqaGyAbHLLsm5xHNqKuhQqdEl7mafJIDC03nm7QnRjvX8vUWf+y3HFrzYMoeTs
 uIiGa/SXb+RjjrGQI/aqKUxGpOg/QmK/G55hXooHGnURubOKfSYYCsVb395lHObqT8dZ4fdMdmS
 zi44dkYJpbKTpmEmFIt/g1g==
X-Google-Smtp-Source: AGHT+IF9IKQZECBZi/S5op3MGZrBBvJrgZce9jUGHoXUct1Tc3R7UnwtXNQQsSeG2xM+tHMugsII/A==
X-Received: by 2002:a05:600c:3b89:b0:453:84a:e8d6 with SMTP id
 5b1f17b1804b1-454ab2ecdafmr23671555e9.1.1751540270071; 
 Thu, 03 Jul 2025 03:57:50 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a999c8cdsm23658325e9.24.2025.07.03.03.57.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:57:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 24/69] accel/tcg: Remove profiler leftover
Date: Thu,  3 Jul 2025 12:54:50 +0200
Message-ID: <20250703105540.67664-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

TCG profiler was removed in commit 1b65b4f54c7.

Fixes: 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/monitor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 7c686226b21..344ec500473 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -141,11 +141,6 @@ static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     *pelide = elide;
 }
 
-static void tcg_dump_info(GString *buf)
-{
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
-}
-
 static void dump_exec_info(GString *buf)
 {
     struct tb_tree_stats tst = {};
@@ -196,7 +191,6 @@ static void dump_exec_info(GString *buf)
     g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
     g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
     g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
-    tcg_dump_info(buf);
 }
 
 HumanReadableText *qmp_x_query_jit(Error **errp)
-- 
2.49.0


