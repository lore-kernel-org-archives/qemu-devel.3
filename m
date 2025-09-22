Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C69DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0li5-0000UJ-ER; Mon, 22 Sep 2025 14:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lgG-0005s8-DL
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:32 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfS-00051u-Ow
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:54:31 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-77f41086c11so1133376b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567218; x=1759172018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrRDTwGDphkvvBtsV/mK2pHDoMT9L4tWZDtSjWVgm+E=;
 b=XpJq/XlcOgE2kphS8aDIpU+93+7l/UgcWT+DLjjePqxPn/0XQ+kMGHbOBjRPRgMx5Y
 TD5ZeYhQpFt39grIxnJsERfQB/QCQ6P1XnlVSM6B57sunnYQ+tbeD/i5Z2xZzCmszsni
 7eTwMN881oFBqll9jI0ZdSr650/9eMNDfB/FlAu5dlyrdxr4dZPeUSYzu/0hrM4rj3WG
 YjKRsJUIGSbANyOm6wxibTN4E4AOfueMJ6k5GiloLo8GgvvcjJt8h9YVf5D6xtqbmAyB
 OuYgFEK0x/mgzHGrav4xxN4J+o49AVBsqdfi4c9zVDfBMfAmRQD6qgO2c51Hoy2GExla
 HKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567218; x=1759172018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrRDTwGDphkvvBtsV/mK2pHDoMT9L4tWZDtSjWVgm+E=;
 b=I6qb833+VF7AwkpFYqYSb9SG5U6xNf4e25AyogS7gVUfQ+KoYl1B+sjXCSiWUwg30z
 MlZHLC8K57OAED6XmOJjc2UZVQi1fk4PfCZLW7WTJLbwhvmwBdZZo3kwz/aHEUwq/dcT
 MTNRa8us247Qb259g+JLwyRxkGQMTucvFNzF6+2tvHEVsMpQCSqzDlFgEXlHmquieAME
 m0UGJPAaa0E2MJJAl66Iu6NSQqj+WWT/WvEFjcIlS1qeNN/RDnSLPBirMjWONmc2YxNd
 zUkh+C4DxoILgWURJsvfdf62sqF/FKZ7eOkHLen+wU7IwjdgZrgfvkX3gZ0T0w3QhYRE
 BwpQ==
X-Gm-Message-State: AOJu0YzcqTMvtD5F4bj2hUJgeU7rIEMAPMC5Z7Yl0Wrx4kek9nyG5er6
 RRJu10ARjr9+5G8k08Tswce2hNNLZaaU9WqCRAe4Lw6FpGadoTtCk5nfUAIyoLDV23i7Ra/oWPw
 GEJXl
X-Gm-Gg: ASbGncvluzxo/G52TINmGsmkG0ef1h1lym5f3JSiOv1js6DhzpRj4SuBRUCD9wkSgFm
 5HtQFyhBh924hOJMIsn5I6nxMAPkk5BAOKp5C3CzR46WjiIf7zYDahqN3dkMooXFMHbnpZWYyVM
 5B4urrzUOoVARYIbSy7t4UC7OkpDLXxWs6mB9qWYs3S2qZcUXzvIPR7CrYgHawBu+bDQcUd/X34
 bBvQrUhpqIx5ZNpFxMUZLwRyv3iLbeVwfhkzEswd36c9150EB8wAfHn6E0s0E/vXYQn5o7GYJqm
 U/ddbjGSR6k0N3M7RbB4pkzNJpegiWVne2S4hQg0qCOei6ybD/KPDwWkPqYKjpyPF1FTbJbBave
 YCA5v80vWzn1x7DOuD2xwzT0aE+XV
X-Google-Smtp-Source: AGHT+IEWdpBQlC7u4fveMVXWQYys15rxESqEZr8pCzmlkj/1EM7M+uGcMto0CqhU/9Kyez+ui64jDw==
X-Received: by 2002:a17:902:da8f:b0:250:1c22:e78 with SMTP id
 d9443c01a7336-269ba402db2mr214039945ad.1.1758567218370; 
 Mon, 22 Sep 2025 11:53:38 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 67/76] linux-user/aarch64: Allocate new gcs stack on clone
Date: Mon, 22 Sep 2025 11:49:15 -0700
Message-ID: <20250922184924.2754205-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Allocate the new stack early, so that error reporting need
not clean up other objects.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2f1e881046..91210775ed 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6652,6 +6652,21 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ts = g_new0(TaskState, 1);
         init_task_state(ts);
 
+#ifdef TARGET_AARCH64
+        /*
+         * If GCS is enabled in the parent thread, it is also enabled
+         * in the child thread, but with a newly allocated stack.
+         */
+        abi_long new_gcspr = 0;
+        if (env->cp15.gcscr_el[0] & GCSCR_PCRSEL) {
+            new_gcspr = gcs_new_stack(ts);
+            if (new_gcspr == -1) {
+                g_free(ts);
+                return -TARGET_ENOMEM;
+            }
+        }
+#endif
+
         /* Grab a mutex so that thread setup appears atomic.  */
         pthread_mutex_lock(&clone_lock);
 
@@ -6676,6 +6691,11 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ts->info = parent_ts->info;
         ts->signal_mask = parent_ts->signal_mask;
 
+#ifdef TARGET_AARCH64
+        ts->gcs_el0_locked = parent_ts->gcs_el0_locked;
+        new_env->cp15.gcspr_el[0] = new_gcspr;
+#endif
+
         if (flags & CLONE_CHILD_CLEARTID) {
             ts->child_tidptr = child_tidptr;
         }
-- 
2.43.0


