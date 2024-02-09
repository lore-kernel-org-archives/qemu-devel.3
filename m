Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A385C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWqh-0005WS-Rt; Fri, 09 Feb 2024 14:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqc-0005Um-7e
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:42 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqa-0005BA-Ho
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:41 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33b6847df67so312477f8f.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508059; x=1708112859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LL5Dv7JkupzeOyiQ5GcSbTiVFGuPgwqizfiHIcw9nM=;
 b=FTnPI0QcXFKV28UZit3ZqGXqOt7tENnFzzeb/ROMzVJKqhbsW5d3e1Lqdx82aMuTzA
 sdR9+Mai/FRpO9dEl8PBLsR31yqJB1atP0iYr6EdVPsj950bxKKzo2v421Cr3zBMN4bo
 g0C1l4ZSvWgTecX7tYYT1A02vZIfAnn5EsRb4ix6Z0NuQ325i+AeDtco1yXn7TIxvoWA
 JXVJgw+iRAF1qotYc73D/y6oq6f4lpjmX8eoftdh5mLNNWJtwfRFzzWglkPpuo8dDYx6
 VbFG84lvgDzcBauHzszt6tPejVcAlY+x2sZwLF58oWFtSLuPTcD4MbWbvMJKuv/WmpKH
 t94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508059; x=1708112859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LL5Dv7JkupzeOyiQ5GcSbTiVFGuPgwqizfiHIcw9nM=;
 b=UAfoOjjC5Qsz/MfAOEq03+nNjj3NfvFJlLj8O2gsne9H2PChrET5elFS6PsiKSf3BB
 MA+YCirISWxinV2lGxdspylc7o6RAgAdTw/7fOlZBQve56oAtOJ7gIoiNzQw62IHHPRf
 5I6roHktmyYRvmr/2a7Dh97rVw/skCSWTk/SrPRdIh96YR3OqnkeG0zqSVWQoGDqmS2G
 K87qCQzmH0ZeMFkOZVxbVjxFGajPsji+vKVbeOrpl1zIjG2iXm1nVrf+tGUoYZNQCw2w
 ND0kQcks45SZG3eCJr7xXAVv+05uyBIdglqQNVaBeGam41Ty4sl4/OTkEPTVJzdTQB/c
 wGwg==
X-Gm-Message-State: AOJu0Yybv3VgP4wiCEsYcRbmlVrgnT2Ib6hmBjuGCWhNIY1ejwv4H+zE
 XjtOSN4Pg8powKSeaDhI6npf00VlqHpHntfhMrwb0f5ahiCM69DPBEVUwHOZv04=
X-Google-Smtp-Source: AGHT+IHhUr7jlZSyd8MxDc8iM71Wp8qP7pk5LeVG5rPXId8WvYLxbmfOV0hDpIp5RieM3tK04ma/xQ==
X-Received: by 2002:a5d:55d0:0:b0:33b:4020:8710 with SMTP id
 i16-20020a5d55d0000000b0033b40208710mr3336wrw.61.1707508059066; 
 Fri, 09 Feb 2024 11:47:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW4E5RUiUi04GFWYcpsLZbwepDjXv1N7PkVQBPlXi/KPMY6ok8yIAr/7rjgPzlcK1fSBe/MuQGW5zvCGhGMjM6RWwnLUXuWPOophNCfD74vPuO22H2wC2NIKw==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y12-20020a056000108c00b0033b40a3f92asm56264wrw.25.2024.02.09.11.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 45A9C5F8AB;
 Fri,  9 Feb 2024 19:47:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/10] gdbstub: Expose TARGET_SIGTRAP in a target-agnostic way
Date: Fri,  9 Feb 2024 19:47:30 +0000
Message-Id: <20240209194734.3424785-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

The upcoming syscall catchpoint support needs to send SIGTRAP stop
packets to GDB. Being able to compile this support only once for all
targets is a good thing, and it requires hiding TARGET_SIGTRAP behind
a function call.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240202152506.279476-2-iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-11-alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 5c0c725e54c..aeb0d9b5377 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -136,6 +136,7 @@ void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
 bool gdb_can_reverse(void); /* softmmu, stub for user */
+int gdb_target_sigtrap(void); /* user */
 
 void gdb_create_default_process(GDBState *s);
 
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index c4bba4c72c7..b7d4c37cd81 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -418,3 +418,8 @@ void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
                     ts->bprm->filename + offset);
     gdb_put_strbuf();
 }
+
+int gdb_target_sigtrap(void)
+{
+    return TARGET_SIGTRAP;
+}
-- 
2.39.2


