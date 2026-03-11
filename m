Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B863EFD88D4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XV-00041q-01; Tue, 10 Mar 2026 21:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XJ-0003xP-Eb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XG-0004pe-V6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so3757545ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193133; x=1773797933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuUmG/L72zbLMqBvR9KryjJnE/4gSsMz3FQcKZdw7Yw=;
 b=lphMVynCE2ah9By4zgRVf9cXtdDixrkQUFzO87UjXD5QJ8D0v77cKh5XX3ev6oiYcI
 KBOAtq6DDQ0/hyjfTylYZCl8QMcLcuNOgCUhyoW6LGhfmgcLUjytxBivBLh3xmI4molv
 5qjl8d8iCn/gN8EQnAQjdtkz/5uw5iHzK2+YxPPMFpDcHzhBMe+c+UNR+luY7v8xIHTD
 15CWcUjTupJpsVaLxVTUhzuz4sQZjKAJzvpWT8Hb1P3OF7SVcazZwR6h3YXtmd2l7Jn7
 89+YyEclYqEA6dlytLc5QoOPOr9wJ7YU0Zx23KP6owxIXuGYcs4IzUIVQMq+BSdVf06u
 T32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193134; x=1773797934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WuUmG/L72zbLMqBvR9KryjJnE/4gSsMz3FQcKZdw7Yw=;
 b=oAO1O4+qgtKFFqcrUnKJXyeMjIcMaC8xCO5LR27BWp3Mx4oES9LDXc9Dwnd2Ns/Lk7
 +Kk0/uyWlqHqW+ZUcU5cvfRgu7BFDi9yCicqrH6hr/PohycARBafDiIn9RFBhcyejnDJ
 LMeiZaze0jdwQwXpC4M5DGZPNXud/QSEK38jnJPL5fkcX/Mao0lkGp0aDxKsYCl6JwAJ
 LTgpaJr9mbRBnkb32wqhuFmUShvYkCfmqNU5p0kdDpTaOtWdyEzHY3XcFS/zbPUG5zQj
 weeI6vszVZBH0JZkElcFqFB7xbdDtwYA9dgk69FSE+4PgTV7rEpZtLeuGSuHDfv24Bf0
 MaCw==
X-Gm-Message-State: AOJu0YymADcRSaZjJ9buIySuN1TMI56m2BoYIL1ZLxu1+CS+mXYC/Xib
 Qui6JZa5bbiIL+6GfS2huIGQ5vd/KLhJvbTwLIHtzKoDDGIj+WuT6YNfNXYVCCmtYyxoQXnPBeT
 9Vfyi
X-Gm-Gg: ATEYQzwh+IUypFtWnSJxmqMu8e1IKn31kDrpdrkXJE1UI/oIs8eVQDNaXU9oKtheC00
 QRLL6OmlKYg+Q28EUyhuckkNqL+BCUxLU2pScCuIPJ5g5pwn/cvA4oo7R7m4CxiLoL5lSDqEfe+
 +N8Ji7P8jmsiNTAjLg4m6ingiaYGLry7KXr6dk7MJL+YPbsP5oQ/v2Hnf5oMl+Zj+L+hPMmXCEq
 0z5KhVjIOsJz+oW9Nhs3ZuHzNijR5qabz+PREHN4MjRGOUt/4eY0Ewtid4Uq/abYU6PKA+Fn9RS
 +oySKzliiqdGB7y8D7LzNYod1rg0LCG9aFxDShdC3uBL+nGf/hn+lfI7h/5fb3+iEuxEtJ1vOKY
 jbAyjDUacOPnU72kigueW1zU4MNYHwhVxoYsinSqBhu7aVXr6joHvmyN1iAwuww7lPHISv+q/wT
 rakozCotZ4FEZ8+2zjUBhuovCUr8hH/+c9d6GXvNG30cDtSTM6DgptXdtuGdUW90Wj89mXreeKw
 +Em
X-Received: by 2002:a17:902:f601:b0:2ae:4ad5:b76c with SMTP id
 d9443c01a7336-2aeaeb95924mr7329915ad.10.1773193133549; 
 Tue, 10 Mar 2026 18:38:53 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 06/16] gdbstub: Simplify gdb_init_cpu() logic
Date: Tue, 10 Mar 2026 18:38:27 -0700
Message-ID: <20260311013837.69945-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Ensure we either set gdb_num_core_regs or have a XML file.
We shouldn't modify CPUClass content, so mark it const.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-7-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.3


