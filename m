Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6FDC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWrQ-0006Tn-I7; Fri, 09 Feb 2024 14:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqh-0005Xl-7O
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:47 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqf-0005Cd-Jv
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41059577f26so12395245e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508063; x=1708112863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHFkIMQcrdC3j/6Cul4tcisSWhVhPHeZYHnbMVO8ZNY=;
 b=cUVwwaub8GiE4NXsW9p3yQjyk1JCjovwMigNno3XgInnr3/dPwF1x+z25qn/7Wh7El
 8w1HtwM5ONoCqn8ZREsWrLwUxyOlhzfAjJW0CSELMd6zpJX/NhtHMcfvXgPHQJBk7D2B
 A0HYgHOmvmXZu/h7jbEve9/+7CtZVQxLOxdNSK/yy8PppUPdFvRvTqHPXEiySB/ofZyG
 7DmW/od93+6XU5FSmfQnCaS+XWyB7P7VlkQ5mSDBEw0oBdH+SydwLam4R9q/jVIYDB9E
 ttmxl9xZ44zooUJd8UL19HpQdUzqpHH288QyUVenyLlEImKjGKxpHOcmg4iPWqCXi7iB
 zmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508063; x=1708112863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHFkIMQcrdC3j/6Cul4tcisSWhVhPHeZYHnbMVO8ZNY=;
 b=Nv8/aX3y+x2fxmdsNIWLhJxyvMs3SoHiSJ+4GgEQVMSMNtWaldHfimFz1QgLJ8vIZw
 c+qUuaL2m3y5blvd0KR2C6TjNKCg56wO4DDL00AUS2+d6Qh1YhccDh6ViaUDzxklstqw
 YW8aBK/TyhqcPjd4auDjWPwaInJaFVcaQYQk6Qh0S0gKXHJHReKTnMlEkjruy//+oluq
 IrO2vA+X+9w35qQwze8F7rJCrvxq/UCGs1WIQFPCBOSRu/+YLVTYDhaP+Q5cA/qQXy7+
 JgeAqZutql+JuSW65+x4KlvVBSMNvUCIJZum1oaUxtbj+hkoHZHo7J0/gA4+Xfzue/fg
 8zTw==
X-Gm-Message-State: AOJu0Yw5TPcVoa+vkWgpHqf7ecG7f6kpgE9HgBHwxdSKE5Muzxni3R/q
 APJoITCtD/LyfrevJ3ICTT914DkNuxYgw7HQtUZVW+5qooGAkQLzRwovNgPceh0=
X-Google-Smtp-Source: AGHT+IF7fuoHeo8iEzWltYKkw/B245gXhnjZ6H1jq2tX18hgR6xpmhzFBfMRYduthA4O8jX1bx/MHA==
X-Received: by 2002:adf:b312:0:b0:33b:3774:ed0 with SMTP id
 j18-20020adfb312000000b0033b37740ed0mr28497wrd.2.1707508063437; 
 Fri, 09 Feb 2024 11:47:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWC9N5Xl7IyApzeVR1Vlw3DDoCdLGELSz0IClmS1s/+8UulNKKFg6dstER+/cONtfC7vCyVkn7KT5EWuIu9mKY6R8HmAhkVKoc7Ye7yTRjsKtb1bBunF2kREw==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y18-20020a1c4b12000000b00410723b14e4sm1468068wma.19.2024.02.09.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E6495F8AD;
 Fri,  9 Feb 2024 19:47:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/10] gdbstub: Allow specifying a reason in stop packets
Date: Fri,  9 Feb 2024 19:47:31 +0000
Message-Id: <20240209194734.3424785-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
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

The upcoming syscall catchpoint support needs to send stop packets with
an associated reason to GDB. Add an extra parameter to gdb_handlesig()
for that, and rename it to gdb_handlesig_reason(). Provide a
compatibility wrapper with an old name.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240202152506.279476-3-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-12-alex.bennee@linaro.org>

diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index d392e510c59..1fc43e04af5 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -10,9 +10,10 @@
 #define GDBSTUB_USER_H
 
 /**
- * gdb_handlesig() - yield control to gdb
+ * gdb_handlesig_reason() - yield control to gdb
  * @cpu: CPU
  * @sig: if non-zero, the signal number which caused us to stop
+ * @reason: stop reason for stop reply packet or NULL
  *
  * This function yields control to gdb, when a user-mode-only target
  * needs to stop execution. If @sig is non-zero, then we will send a
@@ -24,7 +25,18 @@
  * or 0 if no signal should be delivered, ie the signal that caused
  * us to stop should be ignored.
  */
-int gdb_handlesig(CPUState *, int);
+int gdb_handlesig_reason(CPUState *, int, const char *);
+
+/**
+ * gdb_handlesig() - yield control to gdb
+ * @cpu CPU
+ * @sig: if non-zero, the signal number which caused us to stop
+ * @see gdb_handlesig_reason()
+ */
+static inline int gdb_handlesig(CPUState *cpu, int sig)
+{
+    return gdb_handlesig_reason(cpu, sig, NULL);
+}
 
 /**
  * gdb_signalled() - inform remote gdb of sig exit
diff --git a/gdbstub/user.c b/gdbstub/user.c
index dbe1d9b8875..63edca131ab 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -121,7 +121,7 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig(CPUState *cpu, int sig)
+int gdb_handlesig_reason(CPUState *cpu, int sig, const char *reason)
 {
     char buf[256];
     int n;
@@ -141,6 +141,9 @@ int gdb_handlesig(CPUState *cpu, int sig)
                             "T%02xthread:", gdb_target_signal_to_gdb(sig));
             gdb_append_thread_id(cpu, gdbserver_state.str_buf);
             g_string_append_c(gdbserver_state.str_buf, ';');
+            if (reason) {
+                g_string_append(gdbserver_state.str_buf, reason);
+            }
             gdb_put_strbuf();
             gdbserver_state.allow_stop_reply = false;
         }
-- 
2.39.2


