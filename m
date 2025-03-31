Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F01C36010
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 23:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzOmV-0005Nj-H0; Mon, 31 Mar 2025 19:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzOmM-0005Jx-Jv
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:42:55 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzOmL-0002Re-18
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:42:54 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-477282401b3so51089941cf.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743464571; x=1744069371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ycjb5tKcxx1UBX71eHJG+ME4QQCfYzSOhX6L084YcME=;
 b=d87tC7B04osQuHhQuMId+F4kQ16Wr/3TKKkEOGkPPr2KG+QIwqxE5v1y+3RWTB/R+3
 sCssbqn1FBBVsCN/EdMlww9fotXVHyR93vVUwTQwUy3Qwpt3/lWGNNaoITrXdGltg6Rt
 7qnFTv8Tr1fMHOtRQ5fGIXTWXIJxtbYomhdudeRyGhJNciBYE35N+b7VyPucWCidM82O
 z6j9hyloC9ytv68F/UFgWdkuzYll39Rey6xF4p0gKJeQtxjUqTaBKGJdplVAdFynoq4z
 yLZFvcmQP4Gq/26dwXBFGFle91CYyhxfomxc/gbVGh0O5iTL/gYMpsxHdwpgxvNDzU7g
 y/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743464571; x=1744069371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ycjb5tKcxx1UBX71eHJG+ME4QQCfYzSOhX6L084YcME=;
 b=saJkOeLK5ZNyREnKlnlJaPr/tMUrAZgy9v19KSKe3KHKx1r7ohorIVuhaoGSxg1sHb
 Wlqqba7Zs3WuZXXf0m7UvUHnlNnyxjg1hg/7LBmCgsvSsJd4j6QUT5mI2FquXvHQoS5L
 gUACKg8C0zGbQJzYT6cZ7RyXpjYJXXN4ucNQu/SNPzAZw41mwtsCQ+UrWct1P7SBaQ0I
 yKl2ICziAmPnUw8XofUVNGb9aLZLD7ho3I13Ua6YGKWQpBSmOnLjei5aN0VUnCHWWFpa
 NkDRQd3a6//atmDsi49zzSjuIygQUy5PWwk+V31YOQVBwldml1/D3qi0uyNCRIT2ytDq
 bgEw==
X-Gm-Message-State: AOJu0YxbebYLmTbe9MMpM4l5O8S+piS0JHLx1mhG+C9dyf38HlDOIfTh
 gnRdsOb3lPmZYk55b85q2TeRStp3at0bJ3LotY+b1QPjdpua/1xLKAEm9yY7MGIbyVaJTi0oq9S
 1
X-Gm-Gg: ASbGncso/xQSVOAGT/9AlIBgmrNiUreY4Hez+wU7j3DKbd+J28sYOdQTqchpNhOt4JI
 0ayOr2Y8HtRciQH9nrhc+n8fYJshhPL+BOfiU9PErCj8MMnze9VvBXin/+aFA7nCsC51Owf3mrz
 qVhHfanPvhLw94Y2b5BFDKQxRGobNf05nvBb/qoGdNx4M+dV15rBiX8y8YIoNdbzKcxh+2hPGbw
 hzeC11ztzOFf9Hh7Q5FicggN8+OFSx0+vNWirYUkaT59D85M9l/7tCl5jBJ5PcMOH299tLzUWvS
 TJ1CvGXAIuiYGjAq8G5H0iSRnV+fHDwUcQsx+DCz/y/9EkpDfp3hmyE=
X-Google-Smtp-Source: AGHT+IGPUzlsRmg5J8JDEqTVEm9qSXq6zQXBzEKh+f9m/ugUjJAjPXl4gg72IOlROaUho7A5AY1thw==
X-Received: by 2002:a17:903:1106:b0:224:b60:3ce0 with SMTP id
 d9443c01a7336-2292f942a24mr185759065ad.5.1743464560808; 
 Mon, 31 Mar 2025 16:42:40 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f5835sm74883675ad.220.2025.03.31.16.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 16:42:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] bsd-user: add option to enable plugins
Date: Mon, 31 Mar 2025 16:42:28 -0700
Message-Id: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x82c.google.com
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

Nothing prevent plugins to be enabled on this platform for user
binaries, only the option in the driver is missing.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 bsd-user/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index fdb160bed0f..329bd1acc02 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -175,6 +175,9 @@ static void usage(void)
            "-strace           log system calls\n"
            "-trace            [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
            "                  specify tracing options\n"
+#ifdef CONFIG_PLUGIN
+           "-plugin           [file=]<file>[,<argname>=<argvalue>]\n"
+#endif
            "\n"
            "Environment variables:\n"
            "QEMU_STRACE       Print system calls and arguments similar to the\n"
@@ -225,6 +228,8 @@ static void init_task_state(TaskState *ts)
     };
 }
 
+static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
+
 void gemu_log(const char *fmt, ...)
 {
     va_list ap;
@@ -307,6 +312,7 @@ int main(int argc, char **argv)
     cpu_model = NULL;
 
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
 
     optind = 1;
     for (;;) {
@@ -399,6 +405,11 @@ int main(int argc, char **argv)
             do_strace = 1;
         } else if (!strcmp(r, "trace")) {
             trace_opt_parse(optarg);
+#ifdef CONFIG_PLUGIN
+        } else if (!strcmp(r, "plugin")) {
+            r = argv[optind++];
+            qemu_plugin_opt_parse(r, &plugins);
+#endif
         } else if (!strcmp(r, "0")) {
             argv0 = argv[optind++];
         } else {
@@ -433,6 +444,7 @@ int main(int argc, char **argv)
         exit(1);
     }
     trace_init_file();
+    qemu_plugin_load_list(&plugins, &error_fatal);
 
     /* Zero out regs */
     memset(regs, 0, sizeof(struct target_pt_regs));
-- 
2.39.5


