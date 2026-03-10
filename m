Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EECFD88C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05AB-0000im-Ie; Tue, 10 Mar 2026 18:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05AA-0000ia-Jt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:02:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05A9-0005AC-3H
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:02:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so28768315e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773180167; x=1773784967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIpIWa58YkeuMC/dlDkFzMSQak6otlzxcm060/sRvzE=;
 b=FXHQHHgGlN6FsoilzZLLqCf08j/K555CBcewFv5guQMSk+JeT/BmoXudJ6PPCdAajS
 bSsxI8K02M9ufSxhOs8ydDJ5i6+d6dhMj3xAmdPeIoVqbBKclC0wr6i8gm3w7Qmk/3cE
 tCbXkLn03lvUkS3yo630t4ytBWEVesxMl1SVm+9LZrtSNVXDwVTsRWgoHINz/tGogQ3y
 uVe/cVkrRQOPQ+U6OcoL0Sw+V6L6hjUyBZJYPJX2vW2+tGLfD91K+HbVFYdPcGohH8li
 KS2o7J6WZup6zc4C7MH9LjQ7OjI9wVhioo0UaiZqhBFZHAmi4NwpAx6ag6ccL4PC8xZx
 MeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180167; x=1773784967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uIpIWa58YkeuMC/dlDkFzMSQak6otlzxcm060/sRvzE=;
 b=wOYzUBxTAwFV5o03db7v0oZN6yFW8YSP+twAsVfx5fMG20uNNKjKWQQV+S0Tm28Gfh
 NchkxHWQqYX6y5PtIZOQGi9DP/qTQIrkpA8NaEyPrFaDUe/yWkJuZvYPgqJT1uUq1Q47
 XkqQU985mUHOE4zQrFywlMIM083cjRLQ185Htm8+nEqoJFW39BvUnE8suvZLGhVrOrL/
 7dqMqhpyTy9nEDJqYTetBciB7WcM9p9ykq8IlmDlsV74OgIJORRMf0vdet7FAQrVCvuO
 OfBkRiR8uLzy1FxwNWLYlWL/UYpTIyY0Uh07FPhlmEaQvuDofOPJubF0p2dr78ww1xXT
 OrMA==
X-Gm-Message-State: AOJu0Yy879zfBPtOxIGzlTDsgwU/iru6iGpY7LdgxNQmNryMjkedgoyG
 uVxU0+P5++oxJKbDtGlN3+troGvHMFYSiUrLJnIUf1/kbDKuvU+Cp0rtMeJP1QTL/bqk7vh2SXs
 +y3TltZ4=
X-Gm-Gg: ATEYQzwOLxbwlR10HBv3EX95SKC7qPnskQZvRzT9IO+JdcJmOF0UKkpvjQpmow5RNgj
 HSBqWIg2QKzVpTA6PCEd1kcxZ4Z/4tDbi2qYXXSx3ymvsQZDXhzHZ/Nvk/ifnkMsn0Fa+Jyp5sr
 RxpiDxzUqzS7lzFT6ten0M4viD8Iz+EkXhsHCGXcaKzR07/5eB5nd23qRD6vbXZ4L8C/lhTXJ3k
 +PtmiCF4SQxuw3vUW3QMB9arUWdyrekwwWWXYus9CPyyhHtbF49Je93kkD0ZBIMvO7N4go4Ayx5
 EA02937M3kqSPqJnBJJEpGZjXZ62voHjgONjO1YHlNOBXQDJaFO+Vvh7s1hYWRz9bzAq87oQWH6
 89NX+hSsBah4hXuosBjVvaXhjJRjYEt9/IUGoNLtBjGgHf11L8O5xDNghR28qiPqir8ZnRjSwNm
 m/ZqXRT2MEPm8QPc2wXEAKDGcpemGC2KHpNzxZ0DCVpJgRaUaylmwrHUM3XoCXQQs6ba5JCeuf
X-Received: by 2002:a05:600c:4710:b0:485:34b3:8587 with SMTP id
 5b1f17b1804b1-4854b0bb77dmr6345645e9.10.1773180167147; 
 Tue, 10 Mar 2026 15:02:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541ad1e4esm108553795e9.8.2026.03.10.15.02.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 15:02:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 03/12] gdbstub: Simplify gdb_init_cpu() logic
Date: Tue, 10 Mar 2026 22:59:06 +0100
Message-ID: <20260310215916.55815-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Ensure we either set gdb_num_core_regs or have a XML file.
We shouldn't modify CPUClass content, so mark it const.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 90f4b95135b..221951c22b0 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -582,22 +582,20 @@ static const char *gdb_get_core_xml_file(CPUState *cpu)
 
 void gdb_init_cpu(CPUState *cpu)
 {
-    CPUClass *cc = cpu->cc;
+    const CPUClass *cc = cpu->cc;
     const GDBFeature *feature;
     const char *xmlfile = gdb_get_core_xml_file(cpu);
 
     cpu->gdb_regs = g_array_new(false, false, sizeof(GDBRegisterState));
 
     if (xmlfile) {
+        assert(!cc->gdb_num_core_regs);
         feature = gdb_find_static_feature(xmlfile);
         gdb_register_feature(cpu, 0,
                              cc->gdb_read_register, cc->gdb_write_register,
                              feature);
-        assert(!cc->gdb_num_core_regs);
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = feature->num_regs;
-    }
-
-    if (cc->gdb_num_core_regs) {
+    } else {
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
     }
 }
-- 
2.53.0


