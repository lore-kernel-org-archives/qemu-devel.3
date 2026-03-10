Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A49FD88CE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06P6-0002nW-7y; Tue, 10 Mar 2026 19:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06P1-0002cU-Q1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06P0-0000G4-4m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:22:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so113202315e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184932; x=1773789732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1rfBVikTwv8UKl9/GEItZIIiz4modSUfC3Li8tbgj8=;
 b=uZ+Zq/LgdfFl8NvQEJGfhvcf5wOBZN0+SoAXweeM90JVqt1esysdzJkxF646W3t/c+
 lDbNmEPQwUNPpfarmiOny7EbKYYu/c5T+03TKiNf9KO2MMuQinhAlbzqHX3KT8lJqFmG
 901/y2qAerUf7z3/6tDx8BgJCp/Ljf84Tv04G+A28LPX8Q7dayFTJx7P7H76dPYnwP0O
 d7EcZO8Ce0TriNxcmSka6z/0WJQbkkSPHppOUSpHI9v4DzQhx7jgcVu1sQiKLil30A4s
 z9klSMTlTSphnRSJcMWyivqIHCKUWlUd+GvrNHR3s63c0+pmynw6w4k5BOEhMSRDVPU9
 74Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184932; x=1773789732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y1rfBVikTwv8UKl9/GEItZIIiz4modSUfC3Li8tbgj8=;
 b=W9L/kqPBAN9bG3bWScaPIcBSyzfupMmiiHJrH5XW1HX8pEQYhjIqKmNjuW6hbQoLGp
 DSuuQDH2gu/4i2YtZkAB0Yda5MQdrXesxvO59rUM/Wsf/X4M+MyqQoYyrJki2ByIFOe0
 GJ+fVffJY40/PAcTazyCnPqgA+mrHP9TUtq/GYLmtBN//sKi5MUrn74NSykSQAH3RWDQ
 qNuXP8kOo6BQAhZ8ev9wyOUax4VOey6zUr11wF9a1bUaSiu41GoZvcppGZ+HXLyeAeBy
 8D9kr2scvyFnEDEEN9PARKH/f+fAnkZpG6Rfn35wdZyMkfF2ZIWUTj23RhCGAslDMqSi
 5RPg==
X-Gm-Message-State: AOJu0YwxsvX3+/fDih3rrDzmGzhHblawrrdTQ8vBRW8YzNfCZBpFuRBX
 4wRuEKhCw5SZcFNGgwQ3hMO17LaPNXN9ePuhRplWj6nwD5R++vAH+zCXVBJiks3JCtNb1vbBH6T
 1QdYYuzI=
X-Gm-Gg: ATEYQzyFVVeivbEoXVBObfzsmDKd5t6J7lxRvNZo9cmdLRDFjEvCxY/dyDm7KkuYflc
 okbS/Ngm4cmv3xFB0o6chVqUvD0NEWA9Bjthc4y3WIk4KX2maQb/5IXniF28xFiiMDk0i0mI/Rh
 A98BwyTt3VMvoyM/OXWktTmh3YxJdTTqHyN6S40j+j/QtSRy1J8sokep7trWIrNGYHSCOyRyihz
 XSwrOxKuPgKxTwNtwEBq4mKJQ73Clz5ePGr4sZjcYoiA/mzCwJ4lesAN3H2koOrQc4FgLkDUiU/
 Pu+UXrJNjBWcihpjceqyETzRwYT/AldZC+m+ePBQ4dMjCe+xht6pcWLPWUgPnS7+Py2R9KObYaH
 YFBkDab0iDwb9zja8hvweVzG9chRkdjf2iLM4AkYgnyh7x6ifqhvPI4J/4dz/HV7G8jXZforxcA
 xSZTKvvnNPYT6cRPqXwDEwM0kem2QT/FG5wpvJwmvdJ7orydNBJhzAs/BUhxeKtux5sEsoEsAQc
 m4Mvc7h8RE=
X-Received: by 2002:a05:600c:3b02:b0:485:3c41:360b with SMTP id
 5b1f17b1804b1-4854b14f5aamr7759315e9.35.1773184932231; 
 Tue, 10 Mar 2026 16:22:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6c24sm7302335e9.5.2026.03.10.16.22.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:22:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 12/16] gdbstub: Consider GDBFeature::base_reg in
 gdb_register_coprocessor()
Date: Wed, 11 Mar 2026 00:20:40 +0100
Message-ID: <20260310232045.58440-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
2.53.0


