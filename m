Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF1AC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29j-0001wG-FW; Fri, 02 Aug 2024 19:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29a-0001Tl-LV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:46 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29Z-0004EO-5H
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:46 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8152f0c63c1so310173339f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643063; x=1723247863;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+M2MfyOC3APTOH0qT5489YkK6Lsz6CNB5NL1MMUEoY=;
 b=C/aJSUEOjiak6/wTjfAkly0xjzXO1HfzVJK6xhYJnAXxZtHpRALUAllEUO98BsvjD+
 3x5+1rzPvZgC22dhCxY/jUjr0KQlCCnzDt37ZzDrUkbLJ2+B05UlA7KtsnR3CUtUe0L9
 f1KXrNnTjYKyTbzSd5Nj0ch4fC23ZfmOiP0+tVSo5p6ZpT613MhK5mRgiEbMcbWZvFZl
 rE9k5FtA//xFP+bc9gGvGXzeMysCdy60nuQwsNXL1cAR/BLF+Qg+OR0CT3IZBO9UOe7v
 AD5ArL3thBoQ/GF8iBlascgqNozVKvpxMMlGIiTjVKctkupWolNEMqFGKoVhicGtiZxA
 EVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643063; x=1723247863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+M2MfyOC3APTOH0qT5489YkK6Lsz6CNB5NL1MMUEoY=;
 b=TYdfH7Dep0Kh6DyTlr0TL6yBUWdfkPuPhkuKqcKRFgVK3V0bQIbol1IDH7o+qZhJPL
 OziT6Oy5lUjeNEP2hAwbfHbpgKN7+y2TIvFXd60yncRLCEWoulDFsuP/fXmfUIu1CfwT
 xkzmq4IgCt/zhd6S4bo84rt17OLHVWgMoensbkt+AuKht1xDGacnmLBnG9X0Aj4gzrVp
 D7uX49EAuCR0UTKHvTtKlAuFJ45BOB06iMp1M3qji79PSa0y9thnIMSoGYJXQ0ZT2NJO
 XW3HwF0vsKzxRk4bZTkxGVQz3gglQu04nnRcqB0yB1ebd5Kj42pWUk38yrwu3ApY4s1k
 nxBQ==
X-Gm-Message-State: AOJu0YwcWgZxbXOSSmdqjyj14GfroobUu0y0yWnHKtHG9SpESizca04m
 NWpP3ExdawhXp/F0c9kpdOc6yyyTRzsRHtatRIvQ1bVyFzrYKf8okn4Qs7yW0Ce8sDvCb36pBVu
 EbOo=
X-Google-Smtp-Source: AGHT+IGppSYYqBA7hedKkDI4HBy9gNIJuSyRuommAOrM1q9arH0ioYRQOjbSk/3u+KaDK4EMElyGNQ==
X-Received: by 2002:a05:6602:2cc8:b0:81f:9826:19ff with SMTP id
 ca18e2360f4ac-81fd4374a3dmr708269339f.9.1722643063174; 
 Fri, 02 Aug 2024 16:57:43 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>, Stacey Son <sson@FreeBSD.org>,
 Justin Hibbits <chmeeedalf@gmail.com>
Subject: [PATCH 04/17] bsd-user: Implement cpu_copy()
Date: Fri,  2 Aug 2024 17:56:04 -0600
Message-ID: <20240802235617.7971-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d29;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Catch up with 30ba0ee52d15 and implement cpu_copy(). It's needed for
threading. Stacey's original code, with bug fixes from Jessica, Justin
and myself.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Justin Hibbits <chmeeedalf@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/main.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 1533fd51168..9ad31bd1efe 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -224,6 +224,37 @@ void init_task_state(TaskState *ts)
     };
 }
 
+CPUArchState *cpu_copy(CPUArchState *env)
+{
+    CPUState *cpu = env_cpu(env);
+    CPUState *new_cpu = cpu_create(cpu_type);
+    CPUArchState *new_env = cpu_env(new_cpu);
+    CPUBreakpoint *bp;
+    CPUWatchpoint *wp;
+
+    /* Reset non arch specific state */
+    cpu_reset(new_cpu);
+
+    new_cpu->tcg_cflags = cpu->tcg_cflags;
+    memcpy(new_env, env, sizeof(CPUArchState));
+
+    /*
+     * Clone all break/watchpoints.
+     * Note: Once we support ptrace with hw-debug register access, make sure
+     * BP_CPU break/watchpoints are handled correctly on clone.
+     */
+    QTAILQ_INIT(&cpu->breakpoints);
+    QTAILQ_INIT(&cpu->watchpoints);
+    QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+        cpu_breakpoint_insert(new_cpu, bp->pc, bp->flags, NULL);
+    }
+    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
+        cpu_watchpoint_insert(new_cpu, wp->vaddr, wp->len, wp->flags, NULL);
+    }
+
+    return new_env;
+}
+
 void gemu_log(const char *fmt, ...)
 {
     va_list ap;
-- 
2.45.1


