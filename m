Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD83C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0Ga-0003AV-P6; Tue, 12 Mar 2024 07:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GS-0002vn-24
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GL-0000l1-8k
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-413318a3a29so5636875e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710242738; x=1710847538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLoGh9BJ5sW1PuxoNirl7iXBfbZ2yLuS6AwQQm/Ji9Q=;
 b=Q5QWEBp35t/QYKpigLPo6ygSM3kELfkJOerON98VNMp2JpTbYy97ahaHbLu7QQcOTG
 tMNHnbtcvuoqD+bKf3++T7cG1ClHwFUoemCXLvomayCmJg2nvRS/rUV7hqV9huJk9WCJ
 aJ+IVX5arGtn+4b3NaT66GxxAniHVYlxWT6SY8QByjERVVpc0QPu4t7VSB4rW5+P4Zn/
 2XiZRmDIy8HOOQSPjnn5lV17tIL7ppDUyD2a9pChP9VUtsQdlKYqe6pHhllK3t3OIMNa
 4uWBhNVuTi24sUr/dj24GHjR6CCwkvFfhrNbUr+WXUQboumCSMAEtRQEccmD+XqhGXOD
 sgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242738; x=1710847538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLoGh9BJ5sW1PuxoNirl7iXBfbZ2yLuS6AwQQm/Ji9Q=;
 b=QbZMN1ug1hkG8roqh4AeYGwkHWhjLsGnDqh/QHb0YbDeDnXaegHVOg6U0m6TfY4kng
 khsNM9wwmeOppbfd/LEOW9RvhTSKx6Mg3KrJ1L9ydWc5Zn9+gu/s08eUsnKUQ2YyO8xU
 1kyZ4sQ/uNVrXoGynjEGfKeM40NjZBF0pi9H7Mssl3XgYx/Qb79eQHhcRYom0zyjeSxU
 vFDQZJ7bJ4QGUlnkFJ+CjBWhUX7tBqVNwsUzQ7x5g9EgIrY4PhEq+k1zMkis5Et2NsTZ
 I2GtA5xLzc4DBfmmQIwhceBIKkv5eEevG4cXLWGrOqwL0VwCEnZyvMkodKCo20r4kzvj
 SpjQ==
X-Gm-Message-State: AOJu0YyaDd9Hy6+4MXEBVuZ9PUAm1Xu6Zfh9GpPDKO4A1qTvGfR+EnZ7
 xtRNkE6rqtnfnIVHCb7p4WSBRuqWEsyKDX09bI7v1qkmmc3zErFwGu5VwoFs0zeSfFmIniDcAnd
 N
X-Google-Smtp-Source: AGHT+IHY0HV1ZsSPQmEV5JTOfE++edIy9sOGWE6d7NP6Hg9qXQa5yy9OAp9VqjH4Uq41xfZvLlN+4A==
X-Received: by 2002:a5d:6611:0:b0:33d:679d:a033 with SMTP id
 n17-20020a5d6611000000b0033d679da033mr6132756wru.36.1710242738088; 
 Tue, 12 Mar 2024 04:25:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h14-20020a056000000e00b0033e7603987dsm8839153wrx.12.2024.03.12.04.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:25:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 69D6E5F8E5;
 Tue, 12 Mar 2024 11:25:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/8] gdbstub: Fix double close() of the follow-fork-mode socket
Date: Tue, 12 Mar 2024 11:25:32 +0000
Message-Id: <20240312112532.1558319-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312112532.1558319-1-alex.bennee@linaro.org>
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

When the terminal GDB_FORK_ENABLED state is reached, the coordination
socket is not needed anymore and is therefore closed. However, if there
is a communication error between QEMU gdbstub and GDB, the generic
error handling code attempts to close it again.

Fix by closing it later - before returning - instead.

Fixes: Coverity CID 1539966
Fixes: d547e711a8a5 ("gdbstub: Implement follow-fork-mode child")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240312001813.13720-1-iii@linux.ibm.com>

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 2005f3312b..edeb72efeb 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -517,6 +517,7 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
         switch (gdbserver_user_state.fork_state) {
         case GDB_FORK_ENABLED:
             if (gdbserver_user_state.running_state) {
+                close(fd);
                 return;
             }
             QEMU_FALLTHROUGH;
@@ -542,7 +543,6 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
                 gdbserver_user_state.fork_state = GDB_FORK_ACTIVE;
                 break;
             case GDB_FORK_ENABLE:
-                close(fd);
                 gdbserver_user_state.fork_state = GDB_FORK_ENABLED;
                 break;
             case GDB_FORK_DISABLE:
@@ -557,7 +557,6 @@ void gdbserver_fork_end(CPUState *cpu, pid_t pid)
             if (write(fd, &b, 1) != 1) {
                 goto fail;
             }
-            close(fd);
             gdbserver_user_state.fork_state = GDB_FORK_ENABLED;
             break;
         case GDB_FORK_DISABLING:
-- 
2.39.2


