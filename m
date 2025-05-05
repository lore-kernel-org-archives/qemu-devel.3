Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FF7C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl16-0004F8-Qh; Sun, 04 May 2025 21:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0g-0003uc-Uy
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:49 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0X-0002Uo-00
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:46 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b0b2ce7cc81so3533625a12.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409955; x=1747014755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=UePiZeZT5e+XiUGFiF3Q+ILF9kUJWLlPPKoWpBf4tun86enpbq5FWs/6CrXjuPGWPm
 P+9XB9rK8yzLWqdM727P6Dnj5stLIf/f10L5Sgmi3II5pfZeYiBotRfRtGA8UNn2WuW8
 AIaEogVpSTd8PAv3OhMOfiijbQrwDV+5Gw/8IogKIxx0PFnyrtVqijMqvkIFkehIxmzq
 RaMGU3nihNj8tg+Ls4bnyYg0aYsct+AjcgrRIQFVatZ7UTPZh5YarCAM3DZ7Td5bmfvo
 +xBsHsRSUpZyFeoMkwkzIkeNPSOGudR3pQa+w32PnD2o2uwPIQxBsDLhcMDa5cFo83tr
 j3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409955; x=1747014755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gch+3DQ1xFSIgoe8nsFHA95PeotLzKWriKqshNx+4Kc=;
 b=kx+Jc1XhUwVpMMvIVLxrs0XPLSmuoATx8V51VhgtwbZj/SP6SyISmxd0YAQw1uLNTb
 KH63BXJZilpqKDT0wavBgpz13kwacc+nbT9cS8VQnZjSnhxDDFeWtXyiIFBd5Crp6cbi
 BplwXviDgJSBHFswj833FNNFGyaGePYl7WKOr1UbpO8JF9FUx57L69wM3BDjQMIT6Odi
 nF8N5DHWKjSg1R5MtKckL1IpoS3knc8nJ15VreEgn4M9zw/cDnivRBuYRpHCQJjFwlLF
 3NcKwZI3aYExHY3/HH06b03BJf79LduhZGd4ywv5oF4C35gE72fQqHL6us6dZEMbg/9x
 nk+g==
X-Gm-Message-State: AOJu0Ywkar3rPNYn0g6n+xVS35OCFD2PvRDa/mjc/dJttJFdG2S+QP6P
 2CTl5tcjedE8lDG0eKpbdMJJu8EPT+wzLNahLpz9+GgwIA6qYTgzrZfHRBMnaOaggo5XuRYzuTB
 lvYo=
X-Gm-Gg: ASbGncsnfyU71cLKfn1OMOj7KdDmJ83HZnyZcBfIf69oWlKInI90XCrznv83ygG2Auj
 0CShp0SV2CMwp9UkT3F3JjPtatVNOmkxLiprm5iu2pkm83/lXmd8zlVpi+Y62Y82vZNpFQ/B2l6
 Eu/l8t3I05WcWM6M9mi9pa/c29M3b+FBPoa4Wf2F5+lpUd1XrB5rVfAdW9VF9jYfag7Rni8ca85
 o8UHHhn7/MplAimWKOZqhXWRnAE+pSPcM44MSYuuqRxkzk3XV9FmWduAgB/+X56Qrw5Q7ri/Iks
 wTrJS4pj0s26QCqygCFHffq7d5iVDe5QIo71F2r/
X-Google-Smtp-Source: AGHT+IG3mk4YchgUCP/a9nj/YMSOA0RTdRB6Fap1pC1sILKdC2nI/TnxlESmc9cZlPoV9aa77RPxEw==
X-Received: by 2002:a05:6a21:3a4a:b0:1f5:67e2:7790 with SMTP id
 adf61e73a8af0-20e966057a6mr6754727637.17.1746409955584; 
 Sun, 04 May 2025 18:52:35 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 08/48] accel/hvf: add hvf_enabled() for common code
Date: Sun,  4 May 2025 18:51:43 -0700
Message-ID: <20250505015223.3895275-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

Other accelerators define a CONFIG_{accel}_IS_POSSIBLE when
COMPILING_PER_TARGET is not defined, except hvf.

Without this change, target/arm/cpu.c can't find hvf_enabled.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h  | 14 +++++++++-----
 accel/hvf/hvf-stub.c  |  5 +++++
 accel/hvf/meson.build |  1 +
 3 files changed, 15 insertions(+), 5 deletions(-)
 create mode 100644 accel/hvf/hvf-stub.c

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 356fced63e3..1ee2a4177d9 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -19,15 +19,19 @@
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
+# ifdef CONFIG_HVF
+#  define CONFIG_HVF_IS_POSSIBLE
+# endif
+#else
+# define CONFIG_HVF_IS_POSSIBLE
+#endif
 
-#ifdef CONFIG_HVF
+#ifdef CONFIG_HVF_IS_POSSIBLE
 extern bool hvf_allowed;
 #define hvf_enabled() (hvf_allowed)
-#else /* !CONFIG_HVF */
+#else
 #define hvf_enabled() 0
-#endif /* !CONFIG_HVF */
-
-#endif /* COMPILING_PER_TARGET */
+#endif /* CONFIG_HVF_IS_POSSIBLE */
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/accel/hvf/hvf-stub.c b/accel/hvf/hvf-stub.c
new file mode 100644
index 00000000000..7f8eaa59099
--- /dev/null
+++ b/accel/hvf/hvf-stub.c
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+
+bool hvf_allowed;
diff --git a/accel/hvf/meson.build b/accel/hvf/meson.build
index fc52cb78433..7745b94e50f 100644
--- a/accel/hvf/meson.build
+++ b/accel/hvf/meson.build
@@ -5,3 +5,4 @@ hvf_ss.add(files(
 ))
 
 specific_ss.add_all(when: 'CONFIG_HVF', if_true: hvf_ss)
+common_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
-- 
2.47.2


