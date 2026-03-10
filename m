Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0212AFD88C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05I4-0004BZ-5z; Tue, 10 Mar 2026 18:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05Hv-00047M-1s
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:10:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05Ht-0002Oz-AN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:10:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4853f2826f7so24813745e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773180647; x=1773785447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+taZkY3dMwbzz+K23pIIxQ5+P3Tgxt3EnFelTHI+VHA=;
 b=XCcPI8MQPtVwgMrvcFa7zupQGXqnUKNlv8uFoYXwOYg86fCd+VcLeAudJzfWm5FkNF
 aBwnfbydw/J5QGfw9Apjnfev+JvpSmbHC9AmIZ4DC4maIv13VT1q8G7mcelWHAmkXUFR
 f1sjHTUJO9tXsLBJI2BdZ9oeaoh7VK0Py3fJ6Avmfaa5kFNuwsojKPaqKoenLxP3qWi6
 CWyS/6spEXC1B/kmDSV9eQer8xKIDns0N2wpKLHIb/2D255ubVR9KEnWuQWg3ozP3L8W
 2mx70Ci7+KSUeCjynOOCQOtGguLsxJphKa4bRrzZN14M/VFwS3TTH5NZFauymYUyoJ3a
 fhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180647; x=1773785447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+taZkY3dMwbzz+K23pIIxQ5+P3Tgxt3EnFelTHI+VHA=;
 b=D1XXfsPo/Nn4Yr03iuh4nCS17R4UgIGPrIAspWMjsF4/6fToaOJpw6o6hLdnqk9bWS
 gW4x+wXD3T3TrpC4r2LvIXCoR5vzZQco8hRNDcfkjWowIIy2HwUU33xLv/ecrc4PRfvr
 BQQ9cRz+mUq4oL6WZMUkFBa1Ncue99zfDF0i/og05QCQH8s6o36Z5oN2zFf30sVXn9NL
 OLHICWzaEhbvlgagIEBv+qoiYrGvpCDwKRWZy+oaejSaF5fSsX45smMtk0sbuloCUuxV
 atA/Frs97VMeLwx6juaxGD+a+9l0pduvwSi5n3vSz01Pwmdw7v7p2j7P263QWza2Cytr
 Mo9Q==
X-Gm-Message-State: AOJu0Ywvd4U+fU9vj5FZEfBAH27zDU8dVHgwwS5WYw3V5o7zUKj+G2DI
 k0rhHs2owwXqqjQH0hqgMo41BSSm1K69vCS6Yq8pEDPku1bnbjs1+DcE8sUG4W7ZglSGUyvMcuA
 eWyrtM+U=
X-Gm-Gg: ATEYQzwBbSu/LFbZZD5PuOS3oxk6GBmCWV/fpRZ3UchKC+ozc96Isi+DZGhGLXcD6GC
 NsAiIJ26zzTgRRoM8Z3pbQ8GfVOsdXLXwLsDK+9eZb07xxjwkg170EKWQtNXRUTsQ+lwQVmmSFI
 Gr9JbCFCKr++WTn+xTU22td1z1cnPs+KrGjPM3tCYiX/IiEj1cRFUzjDFE//mFe7Yk2LRHMK05D
 /SL2zDrYm3HqX4GNQ54WUDKEDfM9wjj/6AIxaQPkSuiCfruz/0BaCcKClU4RTFT298E2zxuvCaI
 xE0gbzlbsAODTt5kjSNplf79X/xjReM/z3LBrYEyHrMc1YyzP67KVdsqyM6bXHIgSeVQMH846tj
 M5NR9vGOK5kuiAwG9wYL983n0+u+s5fqWnhaWmJAmN6ASVWiqvulgzXoQtDCfzxfOSu9qdV4/VV
 Sg2JNsr2SSihQPpeRZsfWTOjqXajGL7wm4fj9wBSiY2fzX0eTv3ihki400IOfaZH1Smz5RPPPB
X-Received: by 2002:a05:600d:6444:10b0:485:3423:727d with SMTP id
 5b1f17b1804b1-4854b1b1918mr4068865e9.26.1773180647465; 
 Tue, 10 Mar 2026 15:10:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aba60esm108944135e9.5.2026.03.10.15.10.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 15:10:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 09/12] gdbstub: Consider GDBFeature::base_reg in
 gdb_register_coprocessor()
Date: Tue, 10 Mar 2026 22:59:12 +0100
Message-ID: <20260310215916.55815-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


