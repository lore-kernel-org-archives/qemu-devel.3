Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48635C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDOv-0002dz-VZ; Sun, 11 May 2025 16:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOt-0002Sa-RN
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:55 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOr-0006KW-R2
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:55 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso1129143b3a.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995752; x=1747600552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Acco64j8AohVk0U3GZiX+hk+MPR+Ymqfvr9WRzFbhZc=;
 b=G+aF8OGZaloef7l2mDxAJlCH8WfJAETEhF5x/W8e44ygT40pbF+vQ9EkZLfXYbVh90
 FmkhaztEB7UG9B3kBTkGNiMYEKS/7dDwibRT0ry94j5hg30WaZDTmKV/KCH1RsUDz6ND
 IwJpbfAR7n7T7JzrtIeBN/O5qU7fsYV4Zy2USCV31xXJlMv/34gbfKFWGrUwQ8SSTpOU
 seyBLtZG5GchdheEjuStiwB9aU1a/zSZEJTWtaDkaVmA7lsm1Lp+NaJ9dCiir3OlhzfP
 kTrD+dX8j0BoNjXo7mxfDFTXNxJLVXekt3nvfIAynGWMxy5akLIpZayjKValUB8u6+Lk
 YCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995752; x=1747600552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Acco64j8AohVk0U3GZiX+hk+MPR+Ymqfvr9WRzFbhZc=;
 b=MdamLGTqLO0KOFvfE8hh4qmP5SIoS/UyCdpeduHScf7OKu7Wxd79z83rhynEZtI7k/
 h/iGjTQd8F3fz5+1r8l2jnxeXNggYBprXhpYGDz7C5RnNb4740hpdHxQE/5vxQwTnao1
 saZQYNNLJ7yi4icx4itnOwnRkk1H6gNV9vKTDm+Q98e33YhEaW5YIeOgSgAYYXizv9bz
 urAZ51c0ud9shHdflPiKuuEoUHpO51xctL4LRIiNu6sY3Db8CtElGwr05/+b1b7VlnTa
 3URMgHuMEBjaeSDtfsL7YPrl+z1tysEn15p7uJrEdTL+SF0qSFtqhR6xXhlhj+kZE+3M
 7CMw==
X-Gm-Message-State: AOJu0Yzv/6r/CSsun5KehyHCASzi7xVoAS9vOsCeBRh82O8lsVxl2a3K
 srLGf0bbMiogPjL8bGkt3hjhySX0jT/w2xog0ADiamgA/Vx0ELD0Xebfq+mlgx1HMeCN9owfXXw
 7
X-Gm-Gg: ASbGncvxSBz0XZW+sZbt+mTKEb93+KoHHYpBGkLuTqcRQAqBHn67SFT3hW2ihsd6ZYB
 QWdRrWardPm3IhpkYuBo+Ui4hOPkfhfivIJ6E/tE/Vh9loDObm7TZ5vOaLTpaKoYZ9dK3/lMReV
 eRbDT/lOIPxt5FW+2MRpTJpmwpUvFyhKO1ixn7IwCzd62l+1MKWrLjX+o7Jbtq5lh6qhCwxJoyo
 Nkf1WFTIXNaqYVcWijr6k3qMF4Z1NoafVyhJFeXXrCI39xdOV5nzQNbddsGn3hy9PFfS3Ol8X6c
 mNqr6nUx0BfnfosSWR4pi9n6iDyIpjjrlmSVw5xglThduL4fsVK727H9n1IR7RvT/1J2XRu7295
 aexewMkUzWA==
X-Google-Smtp-Source: AGHT+IH5Cr/8BEwRFX4OuAvvqGkgPr9LFKqoqtfdZPhomNeHVKxzzRUBx/XW0OZLXefHhrFG7Ss5bw==
X-Received: by 2002:a17:902:fc8d:b0:226:30f6:1639 with SMTP id
 d9443c01a7336-22fc91c9f97mr146853915ad.51.1746995752417; 
 Sun, 11 May 2025 13:35:52 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 06/24] target/m68k: Introduce
 M68K_FEATURE_FPU_PACKED_DECIMAL
Date: Sun, 11 May 2025 13:35:28 -0700
Message-ID: <20250511203546.139788-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Set for 68020 and 68030, but does nothing so far.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.h | 2 ++
 target/m68k/cpu.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 0630eb26c2..8adb1c6515 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -574,6 +574,8 @@ enum m68k_features {
     M68K_FEATURE_MOVEFROMSR_PRIV,
     /* Exception frame with format+vector (from 68010) */
     M68K_FEATURE_EXCEPTION_FORMAT_VEC,
+    /* FPU supports packed decimal real format */
+    M68K_FEATURE_FPU_PACKED_DECIMAL,
 };
 
 static inline bool m68k_feature(CPUM68KState *env, int feature)
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index e898156403..866d32fc9f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -260,6 +260,7 @@ static void m68020_cpu_initfn(Object *obj)
     m68k_set_feature(env, M68K_FEATURE_MSP);
     m68k_set_feature(env, M68K_FEATURE_UNALIGNED_DATA);
     m68k_set_feature(env, M68K_FEATURE_TRAPCC);
+    m68k_set_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
 }
 
 /*
@@ -302,6 +303,7 @@ static void m68040_cpu_initfn(Object *obj)
 
     m68030_cpu_initfn(obj);
     m68k_unset_feature(env, M68K_FEATURE_M68030);
+    m68k_unset_feature(env, M68K_FEATURE_FPU_PACKED_DECIMAL);
     m68k_set_feature(env, M68K_FEATURE_M68040);
 }
 
-- 
2.43.0


