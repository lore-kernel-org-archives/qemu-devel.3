Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EF1CF45D8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQmW-0004Rm-S8; Mon, 12 Jan 2026 17:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmI-00040s-49
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmG-0003Pr-Gi
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so39930935e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258367; x=1768863167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nJJAGz/yRL6TpHQsdBJlz6vXjupAFSq6Gnhdr8Lxbtg=;
 b=Am4+dEE0Xa+0FdpcJWuFBTLvcfT9WuVZcuQ7Uy6X3jrChFsE+ikjbHfL1/tPbMQ3k8
 88I7xzAMc9h3D2p3PI1gBJYYPSPejmf+vkT2nVj2lHusPRcFVrcgyV5zNhpzSKI0QlAu
 lQOjrNz5BDI9yRNQUo4/kzCJulMOSlWnVAQzWj79VwPFtXDgl6fhKuGsZK5f4Mmswxgb
 STz+tMnWBBMBKDLq2x21bGsrwC22k4kxIjStwxvQUxQSheQdGKXuVlaoXpviAoNbRgMU
 vYbZ2Z+Atsu/Oa1mAJ1G813JNYln6+hqWNTiGttHdembGnOwXEYU5mKytkhB2JJV3vFH
 oucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258367; x=1768863167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nJJAGz/yRL6TpHQsdBJlz6vXjupAFSq6Gnhdr8Lxbtg=;
 b=aR9ZKLFBCh1rwlMZOuEoaGwqoWzYGLLu57Guftgz958zzkVWgInbXg60wum4AkHqGV
 iW/j4A7GptoqHpMXcXCAcfP+mbY595VTxSuSarHdU28zgQbChjCDdfR+iOy9LZkE2jdP
 51wkMyRw/YN3PgbriDrnANyz771Gb667BbJGE5u0tyc6zPzj0O9ZSJTJmuQHXp8sHUCd
 ma7dWAsJRdBC2alT0wpva+mfidD727NAAv3ekL6CSXB2D5XpEzy7YcNQ2bh/e/O6TYaz
 4YAq+/aWZt0Jj4Q5vru4hvQsUke5Veb5XxvGTe0aOMLJbrxX11uXWRlk/RKNC+E6usrS
 L8HA==
X-Gm-Message-State: AOJu0YxT8tXZATGrbvsbuuGhFRH1k9nSswU1wnDSeSTzXLiH4kyNeBsA
 E3L2T8Sja3CxEOLhbjoiifFZo7v2V1Ud+5JfiEsyZXYFP/DoHZmJZquczMPXwUnocrb9ck2995/
 PjtbUbkM=
X-Gm-Gg: AY/fxX6GAb9Ovc9gWOf61rmbsUx4l0GDkgwZ0KXsKyundHXt87Sj4aQy/ZdYMCHc7LM
 7KZrRX4DQ7FibX7HclYlwplFnkSzQ2L7vYII1E1YWy9C1fhWOAvC9rUqyHEKDPTh6Ty5wZ+pYTT
 U6UyJzxKALAVakI2yUHgMsgLrml+gFkEuW0LklvfwkhjZHBRRDasYTDK+ydJj4lWFS29BXV7qRT
 0otnC7BiBcysDhRgA7LDxXIr0HuikF4oUYLEfG6VcBdEtxlZTt+x+RQzIgS7F11pfQC25I023dw
 oBMinO9TEoGqOSGJ361/Di0ko0y/lmWunOkNVTgnBgcT7ffcl4JMWY9icTrR656DIkvFWYAGl8B
 icIjC9DleKuR0FYnRXWDjWjlUfxqzq6ojTV2LAes3NO3t3d8lX3q/cl5h9efwI6p71kDPOL+vhU
 uvaE+hOSGccjnXQN1dJdSQxELkyFEQDkpUtP7GXC34U0kK/4nEKbb5nQO3DHiKHiwhdIUIviY=
X-Google-Smtp-Source: AGHT+IHxFtLzqLO1GX5Az2Kxzxzu7CirVZbXVWGqTadHjJ2gnqaJH4IHqcAN8tlJqUACbhSuLtWw0g==
X-Received: by 2002:a05:600c:a08:b0:477:b0b8:4dd0 with SMTP id
 5b1f17b1804b1-47d84b36b7emr250782665e9.17.1768258366621; 
 Mon, 12 Jan 2026 14:52:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm388151345e9.1.2026.01.12.14.52.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:52:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/61] target/microblaze: Directly check endianness via
 CPUConfig::endi flag
Date: Mon, 12 Jan 2026 23:48:28 +0100
Message-ID: <20260112224857.42068-34-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The MicroBlazeCPUConfig::endi flag reports whether the CPU is
configure in little endianness. Directly use this knowledge
instead of evaluating MemOp from mo_endian().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260106235333.22752-3-philmd@linaro.org>
---
 target/microblaze/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index fefe5cb552a..0be3c98dc17 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -794,7 +794,7 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 #else
     TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, false);
-    (mo_endian(dc) == MO_BE ? gen_helper_lhuea_be : gen_helper_lhuea_le)
+    (dc->cfg->endi ? gen_helper_lhuea_le : gen_helper_lhuea_be)
         (reg_for_write(dc, arg->rd), tcg_env, addr);
     return true;
 #endif
@@ -828,7 +828,7 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 #else
     TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, false);
-    (mo_endian(dc) == MO_BE ? gen_helper_lwea_be : gen_helper_lwea_le)
+    (dc->cfg->endi ? gen_helper_lwea_le : gen_helper_lwea_be)
         (reg_for_write(dc, arg->rd), tcg_env, addr);
     return true;
 #endif
@@ -954,7 +954,7 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 #else
     TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_16, true);
-    (mo_endian(dc) == MO_BE ? gen_helper_shea_be : gen_helper_shea_le)
+    (dc->cfg->endi ? gen_helper_shea_le : gen_helper_shea_be)
         (tcg_env, reg_for_read(dc, arg->rd), addr);
     return true;
 #endif
@@ -988,7 +988,7 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 #else
     TCGv_i64 addr = compute_ldst_addr_ea(dc, arg->ra, arg->rb);
     gen_alignment_check_ea(dc, addr, arg->rb, arg->rd, MO_32, true);
-    (mo_endian(dc) == MO_BE ? gen_helper_swea_be : gen_helper_swea_le)
+    (dc->cfg->endi ? gen_helper_swea_le : gen_helper_swea_be)
         (tcg_env, reg_for_read(dc, arg->rd), addr);
     return true;
 #endif
-- 
2.52.0


