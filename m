Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B639EB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzPp-0003nb-5V; Tue, 10 Mar 2026 11:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPj-0003CF-O6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPh-0006cv-GY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48535a0ef86so22863715e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158067; x=1773762867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BJTest1a3cNWKq4Nrr1+dAp93rwCNK3uFyM4eX7U/M=;
 b=xQS1gKVHvJpx70k4XZHmbqfyCC6oYZ3gA1WN8tPkxO6/ZRt9tKIxmP9FwdRzy8daJ3
 fpzEuaalV9RyUmznnRERFquHHWXh59JN7nGnK45QHTZxMiT0gNAizQI92hLrzW1UZmWU
 N2JvjiYBg5zBIeXU8PBoz4ClFhbAeeHzaVLw4+DTSJe1fqjOixrFSOnrBr1DEv4jEexf
 H0GZhsYgwuH4pfnypoWnfVswUjnjqfyrSsmaSPCIn7XyaCfU3llneujFNgkfWmW1pDW0
 Og5lzkI7hE4423gfrLD+Ja3ppDS8IxqRkuiRWlljemTL/a80CVAJkMQHZ1VN85A5xCnT
 JYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158067; x=1773762867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2BJTest1a3cNWKq4Nrr1+dAp93rwCNK3uFyM4eX7U/M=;
 b=cDiFcQxBf5jouQpvTIiJ2/3RyN+oEJepGYBasBZj+Ajdl82lqRvFJ4FmLHzOWSH7ni
 33OSLUGDDI94FDgkqcIh7QkxmglnbIpfolj7CHWAguEjftdV1YVj/e5HmrmLUZtnFXR0
 uV/CwEvlFF4Wr7IilBjcAS+RNFptryyYajIk782Ls2DoOoAhzzP0vzJ7o18zDepQLnDp
 Kp1OdKfUvRc3U1vNofUGYMG+CpWH9OwKFEo2hQdqiBHW34pP04ZKR/tawzavw1dKkfjC
 Jk4mldMQiG69lQVC2+WKg9jtfRvLfe1D37Z22O72nJxSYeJ8EHei6ZeL0ZWjCck6v9jT
 nOoA==
X-Gm-Message-State: AOJu0Yx0hsIyRe8hHj2XF55eFcQ8A9zTT/S2iBUKK6StofkodK09cZnU
 K3K8F7JYuri5H9GchWhmgZOSdmjirQSBBxY/4ZhMOSQZAhFqQvObDqUJPWPBgyFUkc/e7A3ehIm
 GxUM/HZA=
X-Gm-Gg: ATEYQzxnSSIwIN7JkIGM/NAmQgxp4zrny+4XXCvWHbCbCKP5OGGJz9UeyFiS89YN+Ri
 OBIoZyoSHjwjLV38qaJcwnr8IjDhFhy6G513xs1EZtgJlqIDfxsUJ3GbceZyqXt3Yh204vpNj7P
 OnUuz61yMg04nDgnreqoJIDuOTr6756519OTK9IkQUBq0wqBVnXSdpyy+sJpi5aDftrrZZEP5Wn
 tSXq5A4DlA2UQiPTu3LKD195fHM+7uwPEoBR8C8n6bOKPEnNKx26Pnr0/8DSQZ/4CGGyaNC/78y
 THL5m/AQXiaL+Vgc8ZQgUqJ+N5oQQfi9rRGhb4qSwpkNCe/xV+jLe7GxJx7UZ/Kk4LSCvhYZ/ij
 ri9R0sCwh3L2ymlIlpfzG9T1jMCwudmmyYGAIHm9QNnLD7lJc5lkLZBpfiFz6JeR7IALU8nuyxS
 k/TjCy9eCTo5cpTgmE75v6hpuk8FjV46IEMQDV1NwngQYZ196WotcPrbiVs7i7UZSIk+a4zoG1b
 T3MEz2qh4k=
X-Received: by 2002:a05:600c:1e88:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-48526916beamr283774855e9.7.1773158067340; 
 Tue, 10 Mar 2026 08:54:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853149caffsm104944765e9.1.2026.03.10.08.54.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:54:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 08/13] gdbstub: Emit base_register index in GDBFeature
 entries
Date: Tue, 10 Mar 2026 16:53:24 +0100
Message-ID: <20260310155329.48772-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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


