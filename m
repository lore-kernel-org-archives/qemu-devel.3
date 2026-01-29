Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5323ED73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyS-0004qP-U7; Thu, 29 Jan 2026 12:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyR-0004kT-0Q
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:31 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyP-0000fb-8G
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:30 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-c61343f82d7so499689a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708308; x=1770313108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrhEcNLkm/NjrIYqaUvna4D6+e//Z9G8gExH7fNJCJE=;
 b=c/+tiuK0VqIw7TGpQ//RL9r9YMfZmfMpmWcpr5XH3idOvPVp4UgEu57+7+6xp1EF3u
 iiOojbhHHQZVZ0cVSDcFMHvjA9Nibo8ImcMtPuwpcQ5giBYNQvMyP+DU0/+MaaEeuQT3
 8HCUXTkelJqk8LemPPxC1l8YXEoRjSApWv8dYwWAZGrLJbx+ZCY68K5D6W63pvI5hPrr
 v8dGzZVGXUxgpiRqRhbzDUcgP5S5QszTkOD60ovbjPh/I1dG/STJRN9zEAGbEhKaeSdV
 iKxIvF/utmaufjUvvbfhlyiA/LWN+8eGqpDKpwJHiH2QT13SJj3hg+25Hp0gS4AzVzLi
 WaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708308; x=1770313108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FrhEcNLkm/NjrIYqaUvna4D6+e//Z9G8gExH7fNJCJE=;
 b=tIa0ot64ObGHkkm6ir+/u12W1rsz7K3kZWYFYUId+H7XaKZncYzHcyB1njRyAYpWu2
 3AbPoBU/1qoSi8mGplXh3C7NJdSw6NEvFxjtRVa1oOAHwszNw6Q+3m9wLbr0wOIlpc3k
 JRwEIriuxvdFr6nCpMxxsZmebF62OhHE424kRLDuZovZD9OwdFJKZniFZVb4n5xIFkKK
 CNwDEXqJVEXsiI8zOx0oza2QRGLGOkxXUzjoIT1ZSM61Pda0IfoPNbudtVbfn2jpB55y
 i1+nPWCGW+6F2lasX9ll3DQn6xd63aHx6b1VDyFj+FHbgK7IYhvH/AlBqYzHzjFJh3D2
 xZaw==
X-Gm-Message-State: AOJu0YzBeJLS7+ECX5m3pILC7Db2fZVrM6cN9s4R65DkjHe4JDEuSTwz
 wnx2fy7p8GJovbQBL6JwX5kHTErPZB7H5rYJKoe/Oaju/gCypJSx0YrVsmpz4QuB4LXS2tb+Rt7
 gSAMTlEo=
X-Gm-Gg: AZuq6aJMR9+ND37g4pdKhhHal0kxpBZw7TGTuA7YuNyCPmH+FMOdMvjXtnb62UHItrz
 fnjtObK7pL6w0QrfU8U86hZQCBGUmMQckfAdNjE0PX1y5y3FTMVgAFqwDytmlEde4z/cJtEZc3X
 2LA4ZLdKZ5TMbChgKO3szninCiJpphegT1cVapWMBL713SJM+lWOhM9qTMkbTwA6/CkWfzRkrRy
 r6ge97Fg+UqChmZfcWzaNhwqN/aMR7yFTOJGSDvxdQBjksnsK3vI+HLQP5bI2JMcpM0yHDj64RK
 U5qsz8UxmRAej6g9LGWrUlerTRcKDqPscgN3WhYVeN0Ix9of4jMEytG+DZnqaTwybtrmeCyPQ0t
 4r8yPoEYXIuuterZTI3EN2rEnUFLVb8AZqx/klOJhbrziLw7klyitawMZnFKiIv5PqTxszwxPIz
 LgDlBlFQ+fpHaR/tHcxGb2uf/1DAtETx5tcscigMLYjVqU0djqyzUuiwiDPzkbNqYF
X-Received: by 2002:a17:90b:4cc5:b0:341:88ba:bdd9 with SMTP id
 98e67ed59e1d1-3543b3ac871mr198856a91.25.1769708307670; 
 Thu, 29 Jan 2026 09:38:27 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:27 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/21] plugins: define plugin API symbols as extern "C" when
 compiling in C++
Date: Thu, 29 Jan 2026 09:37:59 -0800
Message-ID: <20260129173811.138036-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x543.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-5-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index eb6179ab1ab..7f449d1b50a 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,10 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -1245,4 +1249,8 @@ void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
 
+#ifdef __cplusplus
+} /* extern "C" */
+#endif
+
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.47.3


