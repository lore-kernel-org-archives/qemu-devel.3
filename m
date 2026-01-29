Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D387DD61018
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSAA-0001oL-1s; Thu, 29 Jan 2026 08:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS9R-0000Se-0s
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:45 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS9O-0002iW-I0
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:36 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so841758f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769693612; x=1770298412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohAv9/55/NIDQzfGujars5nrP2pYPm1zRQkvZvftI7s=;
 b=AkkDOs2GHVJRWonutUHCF5G3xK8Nz4EFmAgwARQaFkssXxp/JnAg5V5sVLf9xBgYNB
 K1Z+8HrUnrLfvwRV0ixeqtjtDPibhKCuk+7a2LMsBnstLTQhrowuIO/xK/k3WzWEwC+x
 d6pcig5AHNnJjU1x0Sm//MGBVGFPqidDjTQqhhKeIMnQnnMsvVuCXpy91liOJJi1bQFS
 S7k8SbAJLbdbUXs2i+ujI4VRMpcMUF9W0dWcZbZRPWualKqpg4WAtAbzurUBqlaZHogG
 +REfvLXDQKewnmkGhmWVrTF+rSL4l4sFM3TMP5DuY96HXCkwY44IBrD+yrVNu8TkCUEF
 drrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769693612; x=1770298412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohAv9/55/NIDQzfGujars5nrP2pYPm1zRQkvZvftI7s=;
 b=pw5wewhC2+OK0pFkVrrkwjJOFTuNQJRqJYrDFGfOjwm60uyMZdf2GLkBGnCnPEEUQL
 wBBSubWnMagDacFPOVsbZBlJVQ5dIdZ9tr9H0MwgRcgIkeK3fpJnSamEMvd9ca6WjwRk
 cpIPzi34UWiMjJJQOlLPki+v/sJTw/Ne5zuX66c8ar/RB8mduSO6DE0Cs1TqydkiqzOD
 zvWgI3G4H25syul6VCwMsXWiOcvxFXMuKGdYQkvqwYr0wg0QtiR98/fdcH025GAr3+Hk
 P+tfUcDPwyS2bX0iitMEfaNEcKdr29c31XwFgnDOVg6A9Dsjxorx1n55q/an5w6r8f2z
 rtRQ==
X-Gm-Message-State: AOJu0YxrfDNPT9ZCRPNoXaSju4SlyweAVwKPHbXvqgyv2cdF/pD1lWq5
 Fxs/12rsyzGt0dePmyliRCFd29IAJRmy3BM+Tl/VeTF7VIj/TLNFZqiO5b0gBYvo8eXUv4YKWPk
 9r+nmQiQ=
X-Gm-Gg: AZuq6aI3tEtr4N0Lm8JJ3dMkLWmYsBLklWN5s5Nt9sZSL9yWe5tMpXIO9VAuQD4uwcU
 i83uelMMkzKYG52mALT3BA9cxALyH+GiKQK1G0mNwZ1ECODX5gfd5dqBhT5z82jKDZKL0fP/Kw1
 Lt/Gp/dUDRCEr09lOqelYBXSKGF5e179I7Q3HFAP8HFlraUkabk1YEjl7QD04WRw5y8jGD3J6Hi
 nzogvAITVDYzb868zPnj7z60HGdf4cDQH5RWZU/ejSUW2cRdTNtBdOPl6gXH2MoCU75lwdcaTPO
 YE4pPuntRqN1khcZxuKG/qLqog3mGZ3JOb2xGMYfb3KsyqhGrc8lqTd3mAth+3VcsY8p2RdykaA
 LMYcNJU+9P1ogAZKZ1utnek8dkiY7iM5j52jhR875Z3Eya/WjZxWO8vXJijH/Vm6Q9yJ4DTg33s
 mX9SGByVVTh23TRl/Hzu8vv2YIElfaOiQ6BHj78fMlhVrjOpczkdVcxQKqw/+kKUwJ4DDbO5k=
X-Received: by 2002:a05:6000:40cb:b0:432:dc23:368 with SMTP id
 ffacd0b85a97d-435dd1cded6mr12591202f8f.49.1769693612079; 
 Thu, 29 Jan 2026 05:33:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4757sm15066367f8f.5.2026.01.29.05.33.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 05:33:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v4 7/9] monitor: Truncate target register using ldn_he_p() API
Date: Thu, 29 Jan 2026 14:32:39 +0100
Message-ID: <20260129133241.35990-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129133241.35990-1-philmd@linaro.org>
References: <20260129133241.35990-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rather than truncating with a target_long cast, use the
unaligned load/store API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h | 3 ---
 monitor/hmp-target.c         | 8 +++++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 6d6653aee6e..788bc9e330a 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -27,15 +27,12 @@
 
 typedef struct MonitorDef MonitorDef;
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu.h"
 struct MonitorDef {
     const char *name;
     int offset;
     uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
     int type;
 };
-#endif
 
 #define MD_TULONG 0
 #define MD_U32    1
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 5738b47bb03..257605a1c96 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -65,6 +66,7 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
  */
 int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
 {
+    const unsigned length = target_long_bits() / 8;
     const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
     uint64_t tmp = 0;
@@ -83,11 +85,11 @@ int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
                 void *ptr = (uint8_t *)env + md->offset;
 
                 switch(md->type) {
-                case MD_U32:
+                case MD_I32:
                     *pval = *(uint32_t *)ptr;
                     break;
                 case MD_TULONG:
-                    *pval = *(target_ulong *)ptr;
+                    *pval = ldn_he_p(ptr, length);
                     break;
                 default:
                     *pval = 0;
@@ -100,7 +102,7 @@ int get_monitor_def(Monitor *mon, uint64_t *pval, const char *name)
 
     ret = target_get_monitor_def(cs, name, &tmp);
     if (!ret) {
-        *pval = (target_ulong)tmp;
+        *pval = ldn_he_p(&tmp, length);
     }
 
     return ret;
-- 
2.52.0


