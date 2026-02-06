Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7985EE6B43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQD0-00082Z-1K; Fri, 06 Feb 2026 13:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCt-0007za-5h
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:27 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCr-0001Ry-Fd
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:26 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so2670945a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401124; x=1771005924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSmPsPtEqgdwdOtebkrXfxyaMmCrLsU35/EBxykfB3U=;
 b=nfD2bQSU4nWHxUOj//2PEQX9q2RAK9u2eRvMv77A1h+jCe0YrF757FbJTtD9HcDrzX
 9uCIXEMwmXasma6VkZ/J7d+I/yoFrUyBj4jsXphqTtSH5mZ/ZlRy/7xPoYlcZV8YFpCm
 pySRmh+BblheHUl/rJtdKum3m7PqqguA5ACyDlXJSdxzjVg65cdR5fshkuQEwb0ECiIQ
 dfPyQYm/xRJNF3hm/15u/Ti/T9YAhv0wm/ycfcGW1McREIRKQNJcapqKjX0/Q4IeCAHC
 0L7psZQ0R7gRqO5u/2vD7+6uoQ12chXsjon6fkweUykd3zXdpDiJICTG3gaG4RQfZp60
 OUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401124; x=1771005924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wSmPsPtEqgdwdOtebkrXfxyaMmCrLsU35/EBxykfB3U=;
 b=MTMI/VqXKUYmQtWxzYtCjdXTTFRc0eVHKfY1Cq2GgJtJEqaCduggHAEYmN1D13vZdp
 SQTWWCLpRHwmBEsdAUvRHpG5pkYEUZ7QDgKNLU9RCw1lLEErsOoaX/qTpIeCbO9gJRJP
 UqPump2fE0j3QYz3WYo1R4+RjEaxXUczabd8K4tIowK9uDq/3hhsV3HqRh+DuRrcInF3
 EmWSmUb9rGi3Ye127uMs6zFQ3Ve/u22KU3irGPe3lR5ZTd3Nk3FfNAdUMlhGd/7k7eNB
 F5cWdImrLMd7GLL2rCHcLodGhcJssA2UsBPdYJzDtkH0ZU9dOI8/4nVq5gqgoZD7C/tW
 Yumw==
X-Gm-Message-State: AOJu0YwI3X5TCstWVlEY7amJ6Mo4+WeSJ/9Oldn1c1gWb2KlLpHyT9IV
 cW21uDHLxL9Y8wdJA7qd87J3GKWp36qRmRYMD8gwyDRrfBa4wukq7Hf9FWcQn5TV+eRztfeh7Nd
 zpuG4PMQ=
X-Gm-Gg: AZuq6aJS7s6/pB5AJKUMCbYwgGqhobGgddTXXvIloEsTNu1T3Wp+/pNDHfTfm7wgZ1p
 3CtBSs54/Z0XNj/YOxxSW0xxUx7n0FWZd82tdHfev4XTen7D3mEXGGBRdrNqe+J5Dl8xfvbKgkI
 mHAwd7rB1VbdQ9V7tmwdcF5vmt1gxifXyOdfHDsT12Pjpyc+hk7vQYbba5QlANb9ODNfDdlIYIR
 PF9FZ9Lv1v1yDUThDw5KOoYxbyC+o24xB0kKzupSEhyS7hNxq1iNyL286gwIZGptiYvt76pqXs8
 Z/2RimibIdRfRj/X4JfJJIi6Y3yGBCrWgycZUCLLTqT7NS5sUAm4pGqj/Ucb7clmoF4VhajYsE9
 xkWKp6isZPlFHLdakS545FdtS3eFffnIb2KoEo4aAzZVrd9Rn0ntguLrdSNFGD7nJOnIr5jFYvC
 X3RNi5R9QkoIbVc3zrdkSiuA==
X-Received: by 2002:a17:907:3dac:b0:b8d:bf38:7025 with SMTP id
 a640c23a62f3a-b8edf1a6518mr188090866b.16.1770401124032; 
 Fri, 06 Feb 2026 10:05:24 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8eda7a3004sm101816266b.15.2026.02.06.10.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96908607F0;
 Fri, 06 Feb 2026 18:05:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] include/gdbstub: tweak language
Date: Fri,  6 Feb 2026 18:05:16 +0000
Message-ID: <20260206180517.1335861-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

While "iff" means "if and only if" it might look like a typo to those
not familiar with this mathematical abbreviation. A plain "if" is
clear enough.

Message-ID: <20260203115201.2387721-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index bff3674872e..989a95c33f9 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -50,7 +50,7 @@ typedef union GdbCmdVariant {
  * '.' -> Skip 1 char unless reached "\0"
  * Any other value is treated as the delimiter value itself
  *
- * @allow_stop_reply: True iff the gdbstub can respond to this command with a
+ * @allow_stop_reply: True if the gdbstub can respond to this command with a
  * "stop reply" packet. The list of commands that accept such response is
  * defined at the GDB Remote Serial Protocol documentation. See:
  * https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
-- 
2.47.3


