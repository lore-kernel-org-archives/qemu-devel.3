Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E053C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ50o-0002YS-AY; Wed, 31 Jul 2024 04:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50m-0002Pq-8O
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:44 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50k-0004cF-Kh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42111cf2706so5061475e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722415721; x=1723020521;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxTT+tyZr9At4fgl+GpnY8w1n+uFaZlL69cg05NKgv4=;
 b=v2MtBze/VlpYSPY5h02ftnn/PEkANQ1MHdFLCOIQ212j9bporkKZXuLM+XhJqAC8+a
 /zakYxWE8bZo8YK83mLii374p1/rkElui3IPeRTpAWeTDWrb4XlgF6/8xj2m8fSq2dbj
 3dt0r6bu4TbpUvfIcMxsWaJl5WsEwl0e1TN5sWJBD9OPp/r+9TOr6/+DLrY04v966udN
 a+z1QRDKZ5C+7G8rssUUYgxz7U9nEnptcn/2gBxuBdaSEENF0Cucu0XKZZziJYNtCtAE
 Qk0/qyy6LjXAKDB54BP8hIry7iU6DVZ6xVLvCZyNGyUx9jVJJl8Z10V6hEeG/JumTcgU
 snRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415721; x=1723020521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxTT+tyZr9At4fgl+GpnY8w1n+uFaZlL69cg05NKgv4=;
 b=c3pVwoZalZkdPouZZ2PrMz0l/F/zh5iNUdv0zPg/+cRW06cIsAorrp0guFbBe+7+5q
 BDWCm+XOuo8xJhP5JkfUUtyKCj+SQjCCIauZl0jNtJeBBA+OhqVSlQ9Lok3PZ3cbqnKL
 nnDoqk4nODHQD8rHoxG89k2uhFQGEj/FcF1NWtnTrTMGa2DoM1EHJcZ/5fBhJEOsvH0y
 GvaEukBq4rSHh0bphyfnUAkkytVrJJyUo+dWLxAMTMdvrdmQBPqp5FF3HrMwWToVJxsZ
 omaeyi1FCk9NVj592IYcwqxs/fBuXaL9FYZgJngXjDlFH3HMsZddo4OU9Jykp36h9fJo
 SA3A==
X-Gm-Message-State: AOJu0YyIPx+MW0bA6sXu1jE4mp+dD8pCtDX6oazZNo1u/gC5KpxkEyoj
 PbBiynx3Kx0hbGGHo2XiCbJK/dRoEuHJU+SZiHxrNSHgYPs3mQ9M94hR2ZLAII7OKB442e8upwY
 FhRg=
X-Google-Smtp-Source: AGHT+IHMNgq4HoQ6IJGLsznC23wWCYpClU66IAnUMh9rfl8p0vwZEJfRwvN6n98Xnl+wRjSQO8Kjng==
X-Received: by 2002:a05:6000:18ab:b0:367:90a8:4d3b with SMTP id
 ffacd0b85a97d-36b34bf2d44mr8401583f8f.3.1722415720939; 
 Wed, 31 Jul 2024 01:48:40 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0344sm16576425f8f.2.2024.07.31.01.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 01:48:40 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 5/5] net/tap: Use qemu_close_all_open_fd()
Date: Wed, 31 Jul 2024 10:48:29 +0200
Message-ID: <20240731084832.1829291-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731084832.1829291-1-cleger@rivosinc.com>
References: <20240731084832.1829291-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Instead of using a slow implementation to close all open fd after
forking, use qemu_close_all_open_fd().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 net/tap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 7b2d5d5703..3f90022c0b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -387,13 +387,20 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
 
 static void close_all_fds_after_fork(int excluded_fd)
 {
-    int open_max = sysconf(_SC_OPEN_MAX), i;
+    const int skip_fd[] = {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
+                           excluded_fd};
+    unsigned int nskip = ARRAY_SIZE(skip_fd);
 
-    for (i = 3; i < open_max; i++) {
-        if (i != excluded_fd) {
-            close(i);
-        }
+    /*
+     * skip_fd must be an ordered array of distinct fds, exclude
+     * excluded_fd if already included in the [STDIN_FILENO - STDERR_FILENO]
+     * range
+     */
+    if (excluded_fd <= STDERR_FILENO) {
+        nskip--;
     }
+
+    qemu_close_all_open_fd(skip_fd, nskip);
 }
 
 static void launch_script(const char *setup_script, const char *ifname,
-- 
2.45.2


