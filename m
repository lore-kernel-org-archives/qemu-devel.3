Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EE6FD88D4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XN-0003z5-Fi; Tue, 10 Mar 2026 21:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XJ-0003xQ-Vi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XI-0004px-0j
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a9296b3926so105010025ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193135; x=1773797935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9RKY3p04ElO43Xisole6IhcJMxmCAuLsbn7nLP326k=;
 b=ROgTSMw+isDwAJy5Sdgmm/zBUhjqDJtJxkfPXzt7zDW4Vr7321UBHRixsVx7rDYT5H
 mdU06D2S/JB8NlyqenYXcxuFDJ7LCkT6zqGQAP5c7tqdbgeAMbQmwwjvlhRGDmdUiwrw
 HpK9cNht8puWRAKRPquFsGSC8CdhPx1FehuWmVn/JyWVFlBvzlIkhKMjrTzz+BCa0DeK
 Z4f87XmjCSotAQ8mMNBXT3rrVrXdMyqbi6mkLnbk3gBEAq7PMy7MJYRuNZ54w2PgEyki
 uM9wAEzThW415IUjtQ2Oq4914z8wwPci6TOkUn5CEjBFGD3O92a02wh31pRXO7VOfMdG
 GRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193135; x=1773797935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i9RKY3p04ElO43Xisole6IhcJMxmCAuLsbn7nLP326k=;
 b=KbX/PmDTyfs2XP12PJxfVVvSPRe3aPoMjZPLb3PNS79gU0XBR/WOtwB1vFBNpw3pqf
 DXc9OZtK7dUPJEz3E705pcX5mkb0oSUAG7smm3rUrD3sUz/kP0+lzCVVXLNC6u9RGG0O
 hn/8zrP+1yYcOELs2mzR9tAJ516Qej05VGS9BRMIISXqC9bcCfSCfSZ6pNU7ew82LMHC
 H0gKfZuXXh46RjgFEdGwfCYwR21ej7jQvfJXYfbbzNybMd7s/+k7Sy2/mfS0Xk12umps
 KZMciK9RbN1QL+3lgXMWADrtudOop0j5qJf/KuUfiO6HfXqfvaO5H04vEZwKlZp4kWVV
 I+Rw==
X-Gm-Message-State: AOJu0YzdKv6crtOVb+/WdlLg8w+rVriiAwQctVdKR+2s6sbtvirPDx22
 cgPCQTAihPNJj06uaoxYE1u8b/oXGY1FYB9wTau7+YTH5xsI/TNgNc9TedfGLXD8yVxXVpfnA+V
 q9YYH
X-Gm-Gg: ATEYQzwxR8hGTcUxijI2kAC7Y6hK9NF4LuacCehX//4J3veyvgu4UmisnvIijI1KHi7
 +iKSPk2gZm2Ya3v4UIQFEfUX89QNeaRiw3+iUFZ5Gpp1RajUefRLMs4gYw7Cdr/2jog1Df57MwM
 jYD0rWtKTlH9YcQJFCMmvslaD2n8i1RcKgTdzwJ7UqR0Gag1iz6tz1fhGeNhIQC978NlVLE1AQ2
 NmTI2+9/D0MJRH2P1Cxb15gborNaWbPglchT26lhZrmaSXJfoEHCf+emkdfXS2hNqFnRX0xzOi7
 9LUr8VaL0aFcHIkBWHggmgHI826DMUhBke27vLqwu77/y3sU8+pwB16+8wUJMK3hmptT5x/dNSG
 PkBgb0kECtEGYdz6nnokcqsLXl6vYLwHzUr04+NYVzdqqgcwKl/GxzIaZhSwu6UV+g5J7H73hs6
 qjQN35Vz3e+sG7sAfxWwA+u1NS4rAj2AuS4PpOak8yotSiApafwOPykL28mux+h6mf1bITvx45H
 mNA
X-Received: by 2002:a17:903:2412:b0:2a9:622e:fd3e with SMTP id
 d9443c01a7336-2aeae762901mr7459795ad.4.1773193134598; 
 Tue, 10 Mar 2026 18:38:54 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 07/16] gdbstub: Add trace events for around XML parsing /
 generation
Date: Tue, 10 Mar 2026 18:38:28 -0700
Message-ID: <20260311013837.69945-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Add trace events to help follow how the various files in
gdb-xml/ are parsed or generated at runtime.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-8-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 gdbstub/gdbstub.c    | 14 ++++++++++++++
 gdbstub/trace-events |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 221951c22b0..5c1a18e055c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -478,6 +478,10 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder)
 
     builder->feature->num_regs = builder->regs->len;
     builder->feature->regs = (void *)g_ptr_array_free(builder->regs, FALSE);
+    trace_gdbxml_feature_builder_header(builder->feature->name,
+                                        builder->feature->xmlname,
+                                        builder->feature->num_regs);
+    trace_gdbxml_feature_builder_content(builder->feature->xml);
 }
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname)
@@ -511,6 +515,10 @@ GArray *gdb_get_register_list(CPUState *cpu)
                 name,
                 r->feature->name
             };
+            trace_gdbxml_get_register_list(r->feature->name,
+                                           r->feature->xmlname,
+                                           r->feature->base_reg,
+                                           r->base_reg + i, name);
             g_array_append_val(results, desc);
         }
     }
@@ -563,6 +571,8 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
         .feature = feature
     };
 
+    trace_gdbxml_register_feature(feature->name, feature->xmlname,
+                                  base_reg, feature->num_regs);
     g_array_append_val(cpu->gdb_regs, s);
 }
 
@@ -598,6 +608,10 @@ void gdb_init_cpu(CPUState *cpu)
     } else {
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
     }
+
+    trace_gdbxml_init_cpu(object_get_typename(OBJECT(cpu)), cpu->cpu_index,
+                          cpu->gdb_num_regs, cpu->gdb_num_g_regs,
+                          cc->gdb_num_core_regs);
 }
 
 void gdb_register_coprocessor(CPUState *cpu,
diff --git a/gdbstub/trace-events b/gdbstub/trace-events
index 4fd126a38c1..8caee36c242 100644
--- a/gdbstub/trace-events
+++ b/gdbstub/trace-events
@@ -28,5 +28,11 @@ gdbstub_err_checksum_invalid(uint8_t ch) "got invalid command checksum digit: 0x
 gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packet with incorrect checksum, expected=0x%02x, received=0x%02x"
 gdbstub_err_unexpected_runpkt(uint8_t ch) "unexpected packet (0x%02x) while target running"
 
+gdbxml_init_cpu(const char *typename, unsigned id, unsigned gdb_num_regs, unsigned gdb_num_g_regs, unsigned gdb_num_core_regs) "%s:%d regs:%u g_regs:%u core_regs:%u"
+gdbxml_register_feature(const char *featname, const char *xmlname, unsigned base_reg, unsigned num_regs) "%s (%s) @%u +%u"
+gdbxml_feature_builder_header(const char *name, const char *xmlname, int num_regs) "%s (%s) regs:%d"
+gdbxml_feature_builder_content(const char *xml) "%s"
+gdbxml_get_register_list(const char *featname, const char *xmlname, unsigned feat_base_reg, unsigned base_reg, const char *regname) "%s (%s) [%u,%u]:%s"
+
 # system.c
 gdbstub_hit_watchpoint(const char *type, int cpu_gdb_index, uint64_t vaddr) "Watchpoint hit, type=\"%s\" cpu=%d, vaddr=0x%" PRIx64 ""
-- 
2.47.3


