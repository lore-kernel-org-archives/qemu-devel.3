Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513D3C3601A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWif-0001HN-OY; Tue, 01 Apr 2025 04:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWid-00014c-0g
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWib-00062f-67
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so41348875e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495091; x=1744099891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFyvhroy74MCVS8YFBdiJPFNhSZTwEwf1bl1oXT/Waw=;
 b=gke2AiFX9+hH5TCCXKXBjoA6zhPwIyoS+pbovde/7544pgzbBjQUmc+SEvYJR/sLVo
 fQmuD5B3UyPeEjMCAFWBQ0TpHCMcD7khAGJY98/UplRodU6yQkVi1L8nBGGhw+2CaK51
 13/7+abi19nufvjKCHU6G5Y6oeN5PHOmLbVIaCVEcYzxzussea9xuU0RTcg3yOiKgk11
 EpLM6gI7DPT5c9lLECh4kvw8c5PgrYiJA1VuHFGShMCxhcx+oxe5ffhji7Xe3ubSgCFD
 xmYgQK0agl/B9ME3+Bf17fKQWvC6XOMG36H2Lxbvb/VPNEc+YJwDP28I+gbABD42xqGq
 9z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495091; x=1744099891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFyvhroy74MCVS8YFBdiJPFNhSZTwEwf1bl1oXT/Waw=;
 b=anR3Bg0UXCZ3htrxcJO0uQOCPprx+nyyUByWVsEAnAoeR7HcCS5hgUF3U00nNR0EAC
 SLmK2wskWAeqHqJQLk9CuYEEyIgldhmPoFyP0/OQuKk17c5JrMf2ZP6hCaI12Goy/o61
 c+W4QgiCpauIsmTcv4aCAXG3KKHOMqP9TQ5LYF0LvyBl1KxYp4HtY6ZNWdYjyHoM680D
 eWFjdKFFKQZ1cBu00isL+xO6swwzJsfo3uLxCgA/IdePpcuiEbeeVopfxRDS8XHBfds9
 rByZHpccPf3r3Z6qbOdimViLRjKjmU2of0Je6oKbW5w/2Eg+TnbO7AuSRHmOAM7VtNZT
 m/kQ==
X-Gm-Message-State: AOJu0Ywk6xkSFvLd0vEHUdq28xZokPKzwhGPk6WkU1amM5CtWCt3Oj5u
 6t3wdvglK5BZCjrcaHl1PQBe/Tf7XsIGl+mg/MrYq7U/k4gHHeBuO510tNpdzdNobl92DWCaCIW
 3
X-Gm-Gg: ASbGncsjZ4daIqc6dVGZdn+GdMCldMFkIzThGi97tSxp+O+jiG+sF5mx8WEiQjhnR4U
 zyIB+YlfxGyDHEjVSjYAIsdjpye+bdkuOB2SFB6es36vvTM7J6Kf9KTaQCCc8E2oPbNpE8RxUR6
 t7rJHcfBbIukblBDtmqrMCjdTDi8LfcHiGilfn6yzxQdRT3B9zSId9bDHaiB5ElGMMPIZ4Ti294
 dGYzCWWvIo3SQWnzc0sD8D8CLNGSBKCT+Dkfl0N3hS510Kb17AL+cEOGQhZVTrupWGJGZAXnNbX
 nITjE0gZt1BuwJlLaBHcIng6g/mWKR14PyhtweMwk7jIRrDpyPjr0tAQ2GZbPu5gRRezsDKqcN7
 SSowdQlxi7kInZnUAVEM=
X-Google-Smtp-Source: AGHT+IGWG/ySR+IDeXKSm3ywBl7EjLuzdF/EHQbPnuqChjsYtIrgVy8BFtofLgsoRvnMujNCXuVDkg==
X-Received: by 2002:a05:600c:45c8:b0:43c:f513:9585 with SMTP id
 5b1f17b1804b1-43db6247b2cmr102595575e9.13.1743495091257; 
 Tue, 01 Apr 2025 01:11:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a8e0asm13315116f8f.101.2025.04.01.01.11.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:11:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 23/24] hw/core/cpu: Remove CPUClass::mmu_index()
Date: Tue,  1 Apr 2025 10:09:36 +0200
Message-ID: <20250401080938.32278-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

All targets have been converted to TCGCPUOps::mmu_index(),
remove the now unused CPUClass::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-mmu-index.h | 4 +---
 include/hw/core/cpu.h        | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
index 651526e9f97..a87b6f7c4b7 100644
--- a/include/exec/cpu-mmu-index.h
+++ b/include/exec/cpu-mmu-index.h
@@ -32,9 +32,7 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
 # endif
 #endif
 
-    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
-    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
-                                 : cs->cc->mmu_index(cs, ifetch);
+    int ret = cs->cc->tcg_ops->mmu_index(cs, ifetch);
     tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
     return ret;
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 60b7abaf49b..10b6b25b344 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,7 +104,6 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @mmu_index: Callback for choosing softmmu mmu index.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
@@ -151,7 +150,6 @@ struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
-    int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, size_t len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
-- 
2.47.1


