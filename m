Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD68CEE34D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQxB-0008IN-8W; Tue, 18 Nov 2025 14:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQx9-0008F4-IE
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:23 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQx8-00060n-2w
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so40001565e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492480; x=1764097280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DvqP0yYSnga49L7kwxAU3PVeYVK1Qd/VcAbwUPzRRds=;
 b=OLDcwJ9CFR4GQ0pBpE69GHeByVL5nTrrVtOXcYS+myoYRAyb2PNRTWEkfkH2Tzb67h
 TQbnonAN1fjGOmDQ4dOsokftMmeVbPJgvAs5bFb9Z56/S/mBhFWcKP74M7bPFP1kXJc0
 r9lep29Qf4zhI/ERJj2YFDt0m8QTbRJB/rZ5uOmsg5U0TcuklsFKVqKW9xf4zotDMDw+
 Xqy05R6T63yz5vSCvVg168hhW56Of2xDdDMzvMNNVXDN8MstasdzV2lKhcgfeO3VqIN6
 Vp8CHqPzUlaM47rjbOxQch8+/gx2C9EaMJjjpnrP4JobtZnjvIH8wsNAI5CZVHrU0iRy
 buDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492480; x=1764097280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DvqP0yYSnga49L7kwxAU3PVeYVK1Qd/VcAbwUPzRRds=;
 b=VCCyZpX6WrwVI5V1s1wyo8d9RT1XxzIi5JUtbQLRPJ6O9dUycnWyfQtfaQQtlc6d5V
 HJF34nTUZbFmHPSLunP0XUItQqGssZviW1sdyNB2sB67isPFxtUtgUwE8ynCi5/c0Fbd
 zghT6JprjGQF/6/HvgHHTFGJOVAWcbVqTjvjTdgb1r4EYaaLvhiSZeFY9Mg0LQcKPmut
 o/f9n/ILbHIqvdEgC4DLbAU9EX1XPiBoPG3LjlZF4HzPCQFAzYsfjIZQEbxNSA8aDXGa
 1EfwQ3GtJGAlWxYWJ4Wd6tUoqhGqSC1UKip8yG2gqy4WZOGeIxntV2rXSFMIrn6rQYUa
 oY8Q==
X-Gm-Message-State: AOJu0YwuKWv6/+6sptw1WkMXpjqjEtwYh8m5SuUjwgiQez6xMJ1Zu2Fe
 hueekjBmFE5wdmN0kRQXVcVxwCa/TWqCFJEX2g0XijTdGfrLBZkwgasEe5MACaM5IS3T+wgeIIl
 1ZioSpLYTIQ==
X-Gm-Gg: ASbGncvTKzAKGxCzthIMSWELXAhxO5hTJLo+30HEt77QF3kSjtl3Kyw0Z1qXCmgSOkh
 Pu8slU7fUy5TdH2bkSHLaWfvyuPkdEkpefgf07ge/RvUwRjqAhl75XncaInsFU/lo0HwLPJx3gi
 pZyD6+oTwGPLYLZWHzAlfbkjrQNfbR5xC8RDe/TuWB8zUTSQhFYQ0Qzw0Y3KIUNJpllyZIHRf2O
 sUowT/hp7s51vWSsfCSINP+DAPOfsKHhp6SmhhfHxQw2dXMniSpWyTHGyLLJr7wMFZz1d0/nTBx
 1Qlh2oEn5UK1j+26HIaf2lCdCd42EviwSPZCo+YiqQ7+Ijl33p5+7bsg1Vxoin4qhuvoVJvLs0K
 ijd18lpMCRYgxmEmpE25jWJ0jTJa7zNKv2VKpL3xqRzo/yzRvUwmbEX+vVWzs5coth5PWCBiA5g
 2S1+HhKh4AJO3PNyxi5oILnVeMoq3FmRjHzWMM9GK6kNC/ES3RLcyul/XCRy1BAoZM4KKIA4Y=
X-Google-Smtp-Source: AGHT+IFwf4FrvFejTsS/5cKXe7xHqIlpmVM2ovW+om+PstlGID1pH/dC+rvOw6kZZW9cb24b81WuFQ==
X-Received: by 2002:a05:600c:4744:b0:46e:48fd:a1a9 with SMTP id
 5b1f17b1804b1-4778fea8ab2mr178062855e9.33.1763492480099; 
 Tue, 18 Nov 2025 11:01:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a972141bsm24016645e9.2.2025.11.18.11.01.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:01:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] system/qtest.c: Allow for multiple CHR_EVENT_CLOSED
 events
Date: Tue, 18 Nov 2025 20:00:38 +0100
Message-ID: <20251118190053.39015-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In the qtest_event() QEMUChrEvent handler, we create a timer
and log OPENED on CHR_EVENT_OPENED, and we destroy the timer and
log CLOSED on CHR_EVENT_CLOSED. However, the chardev subsystem
can send us more than one CHR_EVENT_CLOSED if we're reading from
a file chardev:
 * the first one happens when we read the last data from the file
 * the second one happens when the user hits ^C to exit QEMU
   and the chardev is finalized: char_fd_finalize()

This causes us to call g_timer_elapsed() with a NULL timer
(which glib complains about) and print an extra CLOSED log line
with a zero timestamp:

[I +0.063829] CLOSED
qemu-system-aarch64: GLib: g_timer_elapsed: assertion 'timer != NULL' failed
[I +0.000000] CLOSED

Avoid this by ignoring a CHR_EVENT_CLOSED if we have already
processed one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20251107174306.1408139-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qtest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/system/qtest.c b/system/qtest.c
index e4d1cd75daa..cbeb7f37728 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -808,6 +808,10 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
         }
         break;
     case CHR_EVENT_CLOSED:
+        if (!qtest_opened) {
+            /* Ignore CLOSED events if we have already closed the log */
+            break;
+        }
         qtest_opened = false;
         if (qtest_log_fp) {
             fprintf(qtest_log_fp, "[I +" FMT_timeval "] CLOSED\n", g_timer_elapsed(timer, NULL));
-- 
2.51.0


