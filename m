Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A826FD88CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06OV-0000w9-9w; Tue, 10 Mar 2026 19:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06OT-0000tl-B9
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:41 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06OR-0008JF-QB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439b790af67so327517f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184896; x=1773789696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNTAcnUVZLFT1caohWc1RYKZIcF7oFrm+9IM93yP2WI=;
 b=oCw4nOCkk/p9trQme6GDQa1e2sKDzeA7j9kN6poxhW8k/7MVSDwRTWBWlscKNGqt98
 mXjjdRr/btkGAk8C2Qe7v4JXIOsBk35whKaGuscpuhdyMwg0QsZmbqs1wJ6lYgzd94pf
 wl1qlisGcuxasdMnY3CRRBm371D33f/qOj70L5pRcFQfYZmLRwjuz3O0tTOeCRlHuGlx
 LuEb/88wdZcMSUsFNEC5Q47feGiHRDz506A7YiBM7uLVarah4aV/w7h5M0z6gVVC3DaP
 qwnbpeMZW/uCj9K8guWm5oYiKbasb0LLl2xXduy4TKUHBDFwXQkRG0NDoSYaFPObkNNq
 BFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184896; x=1773789696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wNTAcnUVZLFT1caohWc1RYKZIcF7oFrm+9IM93yP2WI=;
 b=RK8Xa2xQaG4u2Ze48lYgxBXNRJWABe9OVUXis0ojje9SI9lI7fdX8hxwYBRqHNy203
 H463lmvpNqaMcMvUSoZ7Rp5Rm1q95axqRokb0haT4F93eUYPUK54N9hZ4o7VXVdFQDsI
 bOkdvTPKEnAm1aGW8vJyll+HGngxADgDtz6QVvxW6yN4rsBpnpbX0yncVEptPD2we5g8
 fu0+7xh1cIA5j2+VUu4xcszvcYnEQsYmI2MjVYWg8aySKziJtKKZ3GMOEsOCbY3wQxbR
 QngqN9KJQ0oXiwqGPOgrGXjed9MKcAgz8G5jl8UPZ+J7RpQqkb9X2q+aZoPiHysvSRl+
 0Gtw==
X-Gm-Message-State: AOJu0Yz9iLY/APSTrqQGqA3irGrFiIe6g95ZknniEWZkWU8EArBayjxP
 b49zBpWOHendF23T8KZ4Xao8coZu3FgyXXwijjEaQYBUkMEywDv2FWoGxOUhw+GEDh5/1Bmg7xU
 T2ZFzL8k=
X-Gm-Gg: ATEYQzzJ8xzD+BjlEvZ1VSDfnYHvDSKLsUwwaIEyvNhgeS/oG8h0irMaw587f+RST9x
 9LHe4GulOeXJK0vV/ZKwdZZsLjf9X98jaL09CGVOc0RMKpC8Aas5/AohBiAjqiIVoHG0dk+N6PN
 gT58CDcYfcSto9AbJWELLAuv6ZpEdBneyNFYhTX1llX+OrWiHRNGE2Ea01a8esnSEm97470V9J3
 gKnnpKTusbyYPPmikim2MKh9aNJWmw/ZkDWoN90gt3EIN2sGV8c660ehmXooUZjtarIZXBq6I/6
 dBV3Y4b/+8Cj0DD6G7dL4o8yjZ5PsZrBlGJm+7w2AgvdV2KN0EOqydFtOrLHLq6MZ6v/M8EGM/Q
 fmso7MKD49JKrD/m7yxaf3sJoigS+l906QfUZlSzsE/BteOA4/n/7pbk5yWIJGNuKA3QSmxQyP2
 7CaBvr98f76/DyHePq8f3TRD+BhEjuedeJDLhgQsdoGh3CkVLzsost0A74krY/XJVcBzlXJi04I
 kraWAF8HOQ=
X-Received: by 2002:a05:6000:18a6:b0:439:9812:35ea with SMTP id
 ffacd0b85a97d-439eff12c90mr10624969f8f.3.1773184896269; 
 Tue, 10 Mar 2026 16:21:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a5143sm1798082f8f.14.2026.03.10.16.21.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:21:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 07/16] gdbstub: Add trace events for around XML parsing /
 generation
Date: Wed, 11 Mar 2026 00:20:35 +0100
Message-ID: <20260310232045.58440-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Add trace events to help follow how the various files in
gdb-xml/ are parsed or generated at runtime.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.53.0


