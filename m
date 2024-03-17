Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC8BC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 19:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlw1p-00058w-AZ; Sun, 17 Mar 2024 15:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1rlu8z-0002Co-DZ
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 13:17:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1rlu8x-0002TG-9z
 for qemu-devel@nongnu.org; Sun, 17 Mar 2024 13:17:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dddb160a37so26256805ad.2
 for <qemu-devel@nongnu.org>; Sun, 17 Mar 2024 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710695872; x=1711300672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rPGxsZXrkk+jF7t3i2054TO5zMp+QhBf6N673HPNJBI=;
 b=R//bch3xh+OTQ/Vs2jsJ41tUVbZG+3308sodMCDMhrzmVK0WUjeFaTs6Bu0gUJpW4C
 MkM2kHCuLr8wueXCoEsZUzXdB/YfBpCwAE+l0631W+9MpFTE6lBSdtQkedrZJS9zh5m2
 INtZ+ubms7dQUJPAmprUzvmvgt4Jr5EtiaMQSoR47+5wgu3wfKyiT/E7xNEoEkhVfAp1
 nSqUZ0dgCClzREC6x73WzpPququYkPy2Ql/xPL0KqdWBcmcykCIXFdu1QKC1CWvwLFu5
 6wr9pWP5p7goUgoykvzSzbbCuDcI875qi8lacGilguD36wtY1ihyuj/A1lcxc2RUPADU
 bkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710695872; x=1711300672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rPGxsZXrkk+jF7t3i2054TO5zMp+QhBf6N673HPNJBI=;
 b=PNw58B3SQi9ItvJuqcHVTKjeVBSmnyNyPDb1+D0aWyPeCekhv7EfUYF2s3t/P1NvYe
 N9ofHPEbkczahow7ufSmgOy2+hdhdg2vS0NErH3YIS9GnmjxxWgNyUwubKdcLBoR2EBJ
 6qnLRUBPc0axkNgY/tQ8vIfquPtW5jC1N2nouUAgHXtLAyzCs7aZEGf03ecRd8pFdApb
 KvB0SP62lFMeWO6ICv6QM74ydfFhdNth+8tDcOoN+WVuxLNOxaSr+IYByfmfgod7V2ry
 lYHDPl7c/y0RqDBCELWt1+5gBnKdP+ktXiz7uXrhWMieeiqan4mi0X+jv9ZYlvB70F1Q
 3arQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeLWWNQsuUSNtw6gf0JptWI099AEGfVOPB/n1ZSXPcPF/SR6jqV3JEy+pQhy7mz74KrQpCfR+yJ5C7wZrXwc2688vBKN8=
X-Gm-Message-State: AOJu0YxrYXBVmujVb2XxFJzH7tgSRktzIBhb84eSkqm53o8CgH3S/w9n
 m1OMTalikmY+ySOGUK/jeU72Po4RbCtK+CFFLLXRvusm+kDrz4Vds5sv+cjk
X-Google-Smtp-Source: AGHT+IEy6vVp9eDN0rER0ssv2oHErgbZK4aH/HeItbOrcyrwuK9yF3VUUFjb5N/gMUX4phdyB+vgeQ==
X-Received: by 2002:a17:903:2342:b0:1db:35b5:7e37 with SMTP id
 c2-20020a170903234200b001db35b57e37mr13506595plh.50.1710695872575; 
 Sun, 17 Mar 2024 10:17:52 -0700 (PDT)
Received: from phi.. ([116.86.31.222]) by smtp.gmail.com with ESMTPSA id
 n18-20020a170902d2d200b001dee0e175c1sm6775416plc.118.2024.03.17.10.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 10:17:52 -0700 (PDT)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] linux-user: replace calloc() with g_new0()
Date: Mon, 18 Mar 2024 01:17:47 +0800
Message-Id: <20240317171747.1642207-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=phind.uet@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 17 Mar 2024 15:18:40 -0400
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

Use glib allocation as recommended by the coding convention

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 linux-user/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 9277df2e9d..149e35432e 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -928,11 +928,7 @@ int main(int argc, char **argv, char **envp)
      * Prepare copy of argv vector for target.
      */
     target_argc = argc - optind;
-    target_argv = calloc(target_argc + 1, sizeof (char *));
-    if (target_argv == NULL) {
-        (void) fprintf(stderr, "Unable to allocate memory for target_argv\n");
-        exit(EXIT_FAILURE);
-    }
+    target_argv = g_new0(char *, target_argc + 1);
 
     /*
      * If argv0 is specified (using '-0' switch) we replace
-- 
2.34.1


