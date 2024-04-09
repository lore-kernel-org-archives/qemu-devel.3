Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092E8CD129A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGQ-0000Xt-Rs; Tue, 09 Apr 2024 15:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGO-0000XQ-Vu
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGN-0004d3-DJ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso44162825ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691370; x=1713296170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lw/beNU1QugcC97gSnNNo3jFHiOgyIQNiC5qPkBLROQ=;
 b=EvzIyHcgo7LtCmPPB/9RcOJZmakueXCqPF0UgeUDSE9EO+f0Tvf+bfOQH/weCHHtH5
 SrifWB/GVrkCUFKIQL/Sb88YZxK07KqaajafMqV7ERPM48oXOow8I9+oCZrZI/i3Z6wM
 wWWw4AEl/80pRXlO8n+EHd4bOcWuU7/JnFhvhGvRjuynY+TTSiZq/CACp7apljeNpoC9
 KoVYUVkL0Ft8HFa4m3R4sMFYBGzjNBjFqFlq0CJFW222BGI+ETL+NrPmUaiOSLf+4K8j
 5EflQ6BiwkdssOlxZJHALfW0rwN4KbKed4TuggWBziQveAk77uVb9vSylXwXE9/9pRNU
 /ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691370; x=1713296170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lw/beNU1QugcC97gSnNNo3jFHiOgyIQNiC5qPkBLROQ=;
 b=lNMqsrIV5WSBzrMRTGZBbQDF5Q7+uWl7azySwtUt+TTEIY1FOugd1nPeOE0BPQYPkJ
 3jknxj5PASd5uVn5MwM2pu43baGjcpzZwHTABtH0OFWWbuG9AYYpjlHcp4QjQs1QsVo4
 KKCbqn2s34gIZdsa+cX225u6SmWNBPN7Rocez2s57lRi8DmElRo/clw3kQKnMAtwqXT3
 zKOK+RDwIGtdFF8m8jCNfA2H2Gukz3Z2YNCcIm3S7Pm/M59VImTlW6ed2lHtFuHOZl+Z
 93GdUiyPLa+bxa16XiifMiPQpgcfA2SkwARal0HPeFUEGW2I5MOVTrZNg6SQw2++Qu5i
 776w==
X-Gm-Message-State: AOJu0YxiHTJ5hTn71tg7ToyzDPxhFWIbjWLr5lPUfX1Zdh3W6I2kk7k/
 c0xvFRNmk+XJjIQap8ahJZmBYFYMn4fFGT5D+3tmkz/FoWzlIkCVp5cMNRUeSa1q/voygWjI4eH
 3
X-Google-Smtp-Source: AGHT+IFRAQpvzM/HZ/79BVPPqMJ2fSbXNy+tSCJRmL4k2GnYSv78raKJUd8Z9VBWR9n2222k0W6pQw==
X-Received: by 2002:a17:902:eb8b:b0:1e0:afbb:7a89 with SMTP id
 q11-20020a170902eb8b00b001e0afbb7a89mr906459plg.22.1712691370019; 
 Tue, 09 Apr 2024 12:36:10 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 03/20] linux-user: replace calloc() with g_new0()
Date: Tue,  9 Apr 2024 09:35:46 -1000
Message-Id: <20240409193603.1703216-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

Use glib allocation as recommended by the coding convention

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
Message-Id: <20240317171747.1642207-1-phind.uet@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


