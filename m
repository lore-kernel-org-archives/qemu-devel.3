Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13F1C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0qT-0006cx-G6; Mon, 22 Jul 2024 17:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0q5-0005Lx-Vf
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:45:02 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0q3-0004Mr-TR
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:45:01 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-397580fa3bcso10961375ab.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721684698; x=1722289498;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9VX1qTliZmCA4rGJoDFFHTihIbFxaJR/Jp9RTUGPRo=;
 b=cB9WxR23KMftJMKH8norVcvqRLOZjji8duMPUZ6WZGrVYA9/7UN70qs9h9W84V1pTD
 wAy3UbdzaSgwyX/vq3XPIN85yXB4lMMBFdS/0tlwhBOcmj6PAhEBAamCiLNuPeBmfxEd
 /7luOY7cLFpLAuEXHYSd5PuMP8w2AVc7PTKdGZiBpLdM1nDg80qzDIfnES9bclRmH1X8
 baPnPZR6s9DhZLeVPMG4T5IyGib5Rk9t92Yrug2XN5sJEjRTQpoesCJFskwiDs5dpwzp
 z/w2Yhftt5UWG5iOQTdDvXgQiepuVjY4aB1QJLhSuvoCaccaF9pOPeqYjeIzQGl1SJGa
 9zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721684698; x=1722289498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t9VX1qTliZmCA4rGJoDFFHTihIbFxaJR/Jp9RTUGPRo=;
 b=tjWUZr6IIukagucFme1dnD1gdWosFNz7bMxOfAJihmK49Eali78NTQT4RjNkO8QrEl
 xZ1ikvFh18ECQiuK9R9zhSnJrGG4uYfR1ir3FSxIt+lS68NopwAHgaMFBr6NKyy/3jY7
 6CyM9AnjVZNZvk+OET5nnCSd0l1t4ycV0QJntGtBhdJbHW49QIwNlr21Z27AI1KIye4y
 biNXdqIW+v3TfKGY64O8dAeOjSwtR7tokJKhYqIJl/lCIZsxb/T3PKewHjOSDlVqvLTH
 Q7YavwPKdWSShBhg505zJya7pO5IUdYrKjyOS7ii8XTaSqf3rSBev8mG/UUf5ODMSNJO
 oMKg==
X-Gm-Message-State: AOJu0YwydiRfulYdDumQt4WiheC4IiB9FPPGesh8rH2V3a2ohPBSuqV0
 9ACgloJ4y/wl+EAJw78HfT+i0auZ0YYGNf4GIoyLAHDyZn5eAn+j1MZwvEZNk6p/VtVloMz44tR
 /Bv4=
X-Google-Smtp-Source: AGHT+IF+cSzMZVgs3oOl9JYy6lFyV7l46bbgP9Ut4Pb6hKdSMG8AqtiBBNDWjQFJxPZXLXxk+hjChw==
X-Received: by 2002:a05:6e02:1a43:b0:375:a37c:14b6 with SMTP id
 e9e14a558f8ab-3993ffd5902mr114438415ab.23.1721684698096; 
 Mon, 22 Jul 2024 14:44:58 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c2343d2ff3sm1816830173.128.2024.07.22.14.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:44:57 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 13/14] bsd-user: Make compile for non-linux user-mode stuff
Date: Mon, 22 Jul 2024 15:43:12 -0600
Message-ID: <20240722214313.89503-14-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240722214313.89503-1-imp@bsdimp.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::132;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

We include the files that define PR_MTE_TCF_SHIFT only on Linux, but use
them unconditionally. Restrict its use to Linux-only.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 target/arm/gdbstub64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 2e2bc2700b8..6dc81aecb2a 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -404,6 +404,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
 
 int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
 {
+#if defined(CONFIG_LINUX)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
@@ -425,6 +426,9 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
     arm_set_mte_tcf0(env, tcf);
 
     return 1;
+#else
+    return 0;
+#endif
 }
 
 static void handle_q_memtag(GArray *params, void *user_ctx)
-- 
2.45.1


