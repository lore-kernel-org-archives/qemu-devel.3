Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DF6FD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XW-00043N-8g; Tue, 10 Mar 2026 21:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XO-0003ze-IO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:02 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XM-0004rY-NC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso59295645ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193139; x=1773797939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8a1x0CIz1Dz3JdywSYiJEs59NB9UmqDZiiGwWJXBpo=;
 b=qDk8uQRfGusbAO2cTDYcAHh8g+AenHNY58fsyizS30z9v5Qkk62NFwlCJ+nEy98M/T
 DvG+5zMvZk+T7NQkA4B46gmCfM7y0VOREVIs3uAc1ApXdY+34U9exkq9ZFnT6cbLA3T5
 8KissKxx4qWAw/dxkuZxzjkEpWqFv9ssbiXez9grvIx5oczex0tggCmVcrKIgodbxV+W
 Qd+mM6OYuKkoevILTDI3KkADKEfIdCOCDO4jfbLQIAgM6u1dZyKbqA8vCguDJBm+bjWS
 XSuXBKtHAU7fbrI5488SOJsNux2//fafRF41872jBaaplJhiyF201S/z0S4ZSgA9qMrz
 HlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193139; x=1773797939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f8a1x0CIz1Dz3JdywSYiJEs59NB9UmqDZiiGwWJXBpo=;
 b=McYoljFDRKMGMqB/YID0XOQEasZ7SDsyELytVOa7C9eHP1wwWFkECFIcf/dvvzowcC
 00dw+xPiLwfi2loI/0yOB2U+ifgEDDx7uMaZc76pVYr+AUnj4Fnn6VOBOvf9Ku0+qGVm
 Q0qYp/ow+HWTjZjvJmhGTceIAWwV45FNbf9NcNwcQ7f8RsMUgRqe72wHLNeeC1QSlfE7
 5IA5++Uf1gp5zeibV/0sZzu1VxwH+ow1wUq5PllpkywToZ4x2wx5XQrAnlFH8QQuf3sR
 kgZ2cWToI1EIzDYlF1Si5CPVwfoqIZT8ew9tK+HnJspq0i3QLbuGQNo/MxKbV6nyliZt
 UlHA==
X-Gm-Message-State: AOJu0YwGt8cKIaQmhbyyEiBGQT2ZID8ExNJfArR20LbdE38sW6IAgX6e
 2CwyhjPHlTEHAZTaHloplmAcm9PNM3mPoWQNVZcxqrquikYbsWXiQE3YVay1eEKW2+dHatDGK1L
 73TfK
X-Gm-Gg: ATEYQzxJIoe/3FwhrAwkQ1ZkkG6fve5ZM0kTmIiBTPKuUvROn0/VsRABbuJaaOHHcxH
 Bl/sf6YCHD2HWdxxeoV8yQz4dn7YBQi3g6g3yO/99er+rFL5b3Qpt4qTcMjClRsRfOElD/o//9F
 yXjYD7kfui29PnGoxBE5xhR9HQ5C/7Cf67dd4N/naGUhGExWw1h2M5hrW6+vTiUt/4tXL2sBfUr
 A6YLbYdQwaZNEiZ/jAGww8M9gW81izZrswwYfb+2BJp1UiyOO0a4jWveKb7vmvJoMcrSlmjwhfS
 umDW0JEuhUonwa7FVBF6TfRTnHT1WIHGYDfgjKrRZfzb9AHbqwAW7zBEk/J5oIP2yDfhZXOGeoT
 p7YQaW8OeNdonM85ZL+Xw6raB2E/Xk1YOqAA7JxtKpDJ2gyTybAOKtHpgAWFlZO5DjvP3xGFQJG
 52Sdwr6ZSGTcCmFZtgHM9YEkDiUv1X1q2eE9JoNNmnytngL/jEI8uz0yS6Z9DwmSifL72ke5AXo
 6s+
X-Received: by 2002:a17:903:1b4c:b0:2ad:e975:4735 with SMTP id
 d9443c01a7336-2aeae7f4b9amr8124765ad.20.1773193139179; 
 Tue, 10 Mar 2026 18:38:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 12/16] gdbstub: Consider GDBFeature::base_reg in
 gdb_register_coprocessor()
Date: Tue, 10 Mar 2026 18:38:33 -0700
Message-ID: <20260311013837.69945-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When a feature XML file provides a "regnum=" tag to indicate
the registers base index, respect it, as it might not be the
same as our current number of registered entries, in particular
when there are gaps.

This fixes a bug with the "power-fpu.xml" file [*] which was
loaded at index 70 while the base register is 71. This latent
bug was exposed by commit 1ec0fbe2dda ("target/ppc: Fix
CPUClass::gdb_num_core_regs value").

[*] https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/

Reported-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-13-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 gdbstub/gdbstub.c    | 6 ++++++
 gdbstub/trace-events | 1 +
 2 files changed, 7 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 69038c66f2b..c3c944e965b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -601,6 +601,7 @@ void gdb_init_cpu(CPUState *cpu)
     if (xmlfile) {
         assert(!cc->gdb_num_core_regs);
         feature = gdb_find_static_feature(xmlfile);
+        assert(feature->base_reg == 0);
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
@@ -630,6 +631,11 @@ void gdb_register_coprocessor(CPUState *cpu,
         }
     }
 
+    if (base_reg < feature->base_reg) {
+        trace_gdbxml_register_coprocessor_gap(base_reg,
+                                              feature->base_reg);
+        base_reg = feature->base_reg;
+    }
     gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature);
 
     /* Add to end of list.  */
diff --git a/gdbstub/trace-events b/gdbstub/trace-events
index 8caee36c242..5bc83946743 100644
--- a/gdbstub/trace-events
+++ b/gdbstub/trace-events
@@ -29,6 +29,7 @@ gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packe
 gdbstub_err_unexpected_runpkt(uint8_t ch) "unexpected packet (0x%02x) while target running"
 
 gdbxml_init_cpu(const char *typename, unsigned id, unsigned gdb_num_regs, unsigned gdb_num_g_regs, unsigned gdb_num_core_regs) "%s:%d regs:%u g_regs:%u core_regs:%u"
+gdbxml_register_coprocessor_gap(unsigned gdb_num_regs, unsigned base_reg) "regs %u -> %u"
 gdbxml_register_feature(const char *featname, const char *xmlname, unsigned base_reg, unsigned num_regs) "%s (%s) @%u +%u"
 gdbxml_feature_builder_header(const char *name, const char *xmlname, int num_regs) "%s (%s) regs:%d"
 gdbxml_feature_builder_content(const char *xml) "%s"
-- 
2.47.3


