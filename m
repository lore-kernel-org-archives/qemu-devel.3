Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6F8FD88C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05Ho-0003vQ-TO; Tue, 10 Mar 2026 18:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05Ho-0003tT-0h
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:10:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05Hm-0002OP-CQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:10:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso22677525e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773180640; x=1773785440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BJTest1a3cNWKq4Nrr1+dAp93rwCNK3uFyM4eX7U/M=;
 b=spx0Y0s5IrRaAR+SdTE264i6RE2gjHXYVulBFbK0Otg4tgYZC2bjxTqMDJerlXFXre
 h3GsfwQoVggOeT9m6ANZNhteFr91speG6oZoadIwyPUNOUtanhS7XmJnqtIQQtq0lm+q
 6CwLeaLoLSkI98vAUhn63R55xqNYNbw9xblC/T5LDZ0avyzxq1lTQpNyvcD3vcyWIKaD
 jxF2QWAqmd/bUTd20/ZLxIvAhGOz4oqzdAcEd1rPkiPh5PXVpIgBGSSVhgDXasuxgLKD
 zP1ZylxCefY4Devh8ijlNCaqJ1fj+pqjubnIBHLGSpcM8CK42bQw+MdNm6ywTAwtUzQB
 qUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180640; x=1773785440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2BJTest1a3cNWKq4Nrr1+dAp93rwCNK3uFyM4eX7U/M=;
 b=XvL6pZMtajBo6UooTIlB9eWDRrk6L+Ga4lQzZvfcioDvsCROtnhE9RpVnJtDmnTiZZ
 Wjy2sl2fvqfF10XhPIj2ojor3hW3DKpS4AZuoS8tHPsnXvkik9Mbp77IKa3CNYDgrnKY
 h6xz98YpUKmKOxF5Y+FQ2hafkIhBU4NXbRKITdCI8LSioPQ3iw3JyMP9eaT+Nm+bVPa3
 wxARagud+V9sLaUGpppglkqoL+YTL/pM5cK1sUOHD6JsZF+XznSNia1ZOnIYVQr0Jnoe
 nB6MgCs0GeOqMT67D5mMZIGV10MSViDB4Unz8b7uK6YdK+Zemu7Zmlem+GU+icSMazMV
 zUYg==
X-Gm-Message-State: AOJu0YwEnUq+C/LN1YjdJOzGHkGRL2SqjEOd2WwjK3zHYIYI9OT/m0iK
 fJCjy6m6iGf8F6mFXGuDKlDp5FMhTIuaC0Ro6HO0LRyl/2WeRe/XcBRuZDDmexWTxxGecrBAyfh
 rn0ssqX8=
X-Gm-Gg: ATEYQzwiRlQJpSokoXOMsc+AFgRt2pje2nG3mqyjrrmj2DYxPEw47Ns1yGYwCC3vcaJ
 DZFNxT7ffOrt6Lw6ZrBtGQfxexq1mF4xJ1BHwH+40Pc9x4QJIGIvUfzPxM9LpBxNSPjRWf55BDa
 soAqpjupRwSoUsgrqu01PHvdTOVXsMl0JgZYlZkCDDUpqHg25OoNstBxT4CT9JvrK/wb4KH7ShN
 Z7C/JgHTKl6ASMvTLkycvJWwdbd3fmh+ioxA868uvt8bJh7Ohga2SsefvTtqEL8UrOFFAT3DJ2J
 qni4+m8gz6rPcbkg6Dcyn8JafGFbJA4uY8P5VdAtVBH3tRRDfhicZGi4olFiJJsUq/fHPJbQXMp
 Yhy2+8nqzsagIognrNfLyvIXYWUJjMADu83fFgUmaFf1mYFhmaYrmtUQYcwQwEF7hIrq6TBdFOb
 6FTkbntjw3Tjb5IgP2NX+XAFqD4rEojkT/jIqAy94771BpS1ZMDvz4zvJ4gQyT0WNzr5RwT8WWV
 q2yd+4FaTE=
X-Received: by 2002:a05:600c:35c2:b0:485:3f58:da1 with SMTP id
 5b1f17b1804b1-4854b0bb3famr7103655e9.9.1773180640491; 
 Tue, 10 Mar 2026 15:10:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fe27sm3520665e9.9.2026.03.10.15.10.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 15:10:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 08/12] gdbstub: Emit base_register index in GDBFeature
 entries
Date: Tue, 10 Mar 2026 22:59:11 +0100
Message-ID: <20260310215916.55815-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Record the base register index in the generated C file.

Check at runtime that either @g_pos argument of
gdb_register_coprocessor() is zero, or it the base register
index.

This change pass 'make check-tcg' test suite, which runs the
tests/tcg/multiarch/gdbstub/registers.py test, itself calling
gdb_register_coprocessor() for each target tested.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/gdbstub.h  | 1 +
 scripts/feature_to_c.py | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 79e47a024ec..75eb4d9c365 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -6,6 +6,7 @@ typedef struct GDBFeature {
     const char *xml;
     const char *name;
     const char * const *regs;
+    int base_reg;
     int num_regs;
 } GDBFeature;
 
diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index 1329695ad04..a52cd2e9ec6 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -102,6 +102,7 @@ def writeliteral(indent, bytes):
         sys.stdout.write(',\n')
 
     sys.stdout.write( '        },\n')
+    sys.stdout.write(f'        .base_reg = {base_reg},\n')
     sys.stdout.write(f'        .num_regs = {num_regs},\n')
     sys.stdout.write( '    },\n')
 
-- 
2.53.0


