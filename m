Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F407C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWS2-0006G2-K1; Mon, 10 Feb 2025 11:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR9-0004Ki-7k
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:09 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR5-0001Wp-M6
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:06 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so851613566b.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204102; x=1739808902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayP8EMcB4Qo24WwN/jtc5LLSaKf0jilqA/YV1+mpnK0=;
 b=JRQGeReuSpfteDx0HCnwAoKkKJ+kiRQlqx60X8rIXtHcUzEb/0GtDw+9AOCuK77bWO
 +7QsXxyFlBj+sO58mUTArzdOKt7fb6aDX90rsfbyZOf992ogvrKBsw7GIH4RipU7kMZW
 cUBjrALDSOvxuru0GwJDDk2y4YjvP4XxsyPZeGajLafvZUHW4hl4MLqUAeaEW2uyJKev
 AvzeHV3rHFx/5EIzg9FWFzyvAKJ+weQUXFjgzAmE77qzqHzx3yRPcdP1SwbCytUM9cpD
 VqbiZMzNMol7Czu7KUHfufBZgjK3A3pbbIMEuBNCo+OSPQZxzMh4Db7rAOMcBX953owb
 iWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204102; x=1739808902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayP8EMcB4Qo24WwN/jtc5LLSaKf0jilqA/YV1+mpnK0=;
 b=VVppUA4kNCY0D+GtbWKTkGgXj3IyZtxbtAIhhjzfe2mQUBtxCmnhC7Q6sIn9sbIjwB
 6DyW42T7nMWibiwlpsIB+l/fJVOPVW0yjsQGMZ25R7QMB4C+fG8bCWdKeULaQhh/SD9t
 y+Eha0u/gvgFCqVjxOR9z9TDxyvSouO4B+gjg3h9s52BthYERiX6Vit/FbjJusas2wnB
 52qxw5JS7JNXs61f4mZGMw1oZ9M/ZH4pkc1Pkf9hJqfWqT3r+Yc105jM6lxeh5axCCRB
 9ElB/NWD7cGyfNi4sbBQsnAjQERPw9msh5eXKOFaQME1HiIYdn3B7jNP1u2lnUzSckTv
 Yyvg==
X-Gm-Message-State: AOJu0YyaqOa+/DVRJ5EAb9h7oIJz1RvYpD27KdddP/WI0nFt+0SjqPrh
 Q8a1x3IdMbNeSKJSHH2ZrVBPsDyXQZRpeFbevt+YvOFPNlTjXSUL3rCOuoNnbB4=
X-Gm-Gg: ASbGnctMi4gQ9gckWGy9K7ftp7/gMGQ4tCdQiTv6ilLWxqTpAqes4doPEvl8/K5lThh
 e6tC9Sf3X41KH9aeV9ilro+Rru0Bb+WSs4IUDx4gyMfWK/opIP4VS+BbJGIdy18/Zc19IJsYytt
 Nn925SPcTw38vVoywu8Y9FO2xTBocHMeZfmo2mByOww+KKQYMN9gpY+xuJfXMBaQPWXoluxkbxf
 0XEiQwxqRKC2o4mlPlkDN6+hmbSEMna/FIsrfQfDaEZ293/Ye3PZO7uia8SZSxr+0tx5F+2DnOY
 UEdzA1FYZ7ouQXFZwg==
X-Google-Smtp-Source: AGHT+IGnlyu5ebeRHeiaLSsB375w2OCuIlG6sB8aKp3v/B0FTzN5Reo34uQ+XFkLNiFLzM8QQQP3NQ==
X-Received: by 2002:a17:907:1c95:b0:ab7:c94f:af7c with SMTP id
 a640c23a62f3a-ab7c94fb325mr332235466b.14.1739204101880; 
 Mon, 10 Feb 2025 08:15:01 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7d3b9d85asm67650866b.53.2025.02.10.08.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:15:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 14A0260387;
 Mon, 10 Feb 2025 16:14:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/17] osdep: Introduce qemu_kill_thread()
Date: Mon, 10 Feb 2025 16:14:48 +0000
Message-Id: <20250210161451.3273284-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a function for sending signals to individual threads. It does not make
sense on Windows, so do not provide an implementation, so that if someone
uses it by accident, they will get a linker error.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20250117001542.8290-6-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-15-alex.bennee@linaro.org>

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 112ebdff21..4397a90680 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -631,6 +631,15 @@ bool qemu_write_pidfile(const char *pidfile, Error **errp);
 
 int qemu_get_thread_id(void);
 
+/**
+ * qemu_kill_thread:
+ * @tid: thread id.
+ * @sig: host signal.
+ *
+ * Send @sig to one of QEMU's own threads with identifier @tid.
+ */
+int qemu_kill_thread(int tid, int sig);
+
 #ifndef CONFIG_IOVEC
 struct iovec {
     void *iov_base;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 2bb34dade3..a697c602c6 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -111,6 +111,21 @@ int qemu_get_thread_id(void)
 #endif
 }
 
+int qemu_kill_thread(int tid, int sig)
+{
+#if defined(__linux__)
+    return syscall(__NR_tgkill, getpid(), tid, sig);
+#elif defined(__FreeBSD__)
+    return thr_kill2(getpid(), tid, sig);
+#elif defined(__NetBSD__)
+    return _lwp_kill(tid, sig);
+#elif defined(__OpenBSD__)
+    return thrkill(tid, sig, NULL);
+#else
+    return kill(tid, sig);
+#endif
+}
+
 int qemu_daemon(int nochdir, int noclose)
 {
     return daemon(nochdir, noclose);
-- 
2.39.5


