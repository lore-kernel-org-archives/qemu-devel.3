Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B1CC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqrY-0000gV-By; Wed, 05 Mar 2025 10:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrP-0000SH-8p
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:39 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrN-0002bB-4A
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:38 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bcf9612f4so12976585e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189234; x=1741794034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OC+PlyCRZLGzf6tvLjkEgzmve3rRTU2dVEb5T9eDDQ=;
 b=b/YeO2v7VHhjdEkd4WJk0LoDvREN1xyR+DpQO+RT1HZLHfnEOT6vf0wXhIFBBqd9yp
 NjPymYt7vqzMdKB0D4UoDrxTW5xhbeEWiU79vfByrJs5v35NXo2wAHdO1K+UPfcD5nMM
 zfj9YAIbH6142/BLTFkFSxWBkw57OiVSJQNpl6X59XnwDOAfVJw0vauPiB4vHBGqaIhe
 o9Pgy2BL+WsEuUzFAmaa7MEWExnBnch+kWMUhaYcRh02ksyFex6N/lrmwJpO144qNoHE
 4l0bNkFirOughwVxp/SOpmqYI03UmVuCmJ/IucEJkP7X1C9WkFpz3cb0zsMntkT33GD+
 XQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189234; x=1741794034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OC+PlyCRZLGzf6tvLjkEgzmve3rRTU2dVEb5T9eDDQ=;
 b=QTkCUrW23UOF7qITgCkClLf7HNNinY5b6dFwkLCUzTUffZKn5/PJ/2kqxZQTwbOnRs
 xpoDCwI9ac657AJvCNqubXixe8nBRZ/Zo+rh7JGR7sLigLEwacct3s7wjx67QdYStQMe
 D8hSI3uwfH0/DsaHBq334IDn8J6GWI6UJJ7j4xSs7HuoS3seO6LCqfE/hQSdYPClQCcp
 wIS/B8S1CyueSPcLRHx/lEEGwhLq3rgN9Ofs/2QU4QV80FUCczSFf8ufIzMfREcKoXFu
 uzEcjwLEkJEcHDRhIpgtJSeVHw5n5kAGqqy/UMNCRdkX0YS9eDcF87SlXi1t/u7lIZTn
 S7gA==
X-Gm-Message-State: AOJu0YyMq04fB1/QezhWLw6HJ7ZxkfbPBYuOIlShRzJ5Cv4FMCekeAPX
 RQcElSFJgWjIuHZgaFa+2DQA5v4sz4MnFnzFOUAxgTgdnclZsBLb90y1Wvmtk5xz6zRnEcHAu8l
 ZMxE=
X-Gm-Gg: ASbGncsUnvXVPtJnXUkvmxWhousUnWEvUpk7hWhDxggysb8F164S4uKZPjrsRtdh2Wp
 tLsGt/iam6Tl6C7In/7HMW2b9qkLk6SOCK+jPyGioq+3Tk52loenaFglWOIE70M24gzWJ0v5Atl
 xGMh2mq1PMSyvPqD8r/+k2XhQrSDkiJG5DW9RZtbAwAxHbTxPHRVEp02gUNYHb+O/MxIKpeZldj
 n2fSZUqQmY0Rd61ym97urP0pJT2kLvnuZ7H/36f6ZdM40SEJrGzAvxM/0fSadzh0Kxn+MUi0BUf
 5b2mJ1/bwRK0dcaCo1ll962OIQoeO+mb57DCZkJh3WszSQqY3kdxKQNs0jdgOlUwDuXOjbB+1SJ
 dQNRs7V6Qp6k0/tz9l/A=
X-Google-Smtp-Source: AGHT+IEjJWIf/DBd+lPpvtVxhda1cp+bcr6SSnME4rm00JkqbKVNHrfkpUTqfwQf+rmX6xbgEsfjGQ==
X-Received: by 2002:a05:600c:4f51:b0:439:92ca:f01b with SMTP id
 5b1f17b1804b1-43bd29bb5f2mr24975095e9.13.1741189234128; 
 Wed, 05 Mar 2025 07:40:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a72d5sm21730622f8f.31.2025.03.05.07.40.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 13/18] hw/xtensa/sim: Replace TARGET_BIG_ENDIAN by
 legacy_binary_is_big_endian
Date: Wed,  5 Mar 2025 16:39:23 +0100
Message-ID: <20250305153929.43687-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

For legacy binaries, legacy_binary_is_big_endian() is
equivalent of the compile time TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/sim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 1cea29c66d4..cd7c6014c3b 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/legacy_binary_info.h"
 #include "qapi/error.h"
 #include "system/reset.h"
 #include "system/system.h"
@@ -101,7 +102,8 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu, MachineState *machine)
         uint64_t elf_entry;
         int success = load_elf(kernel_filename, NULL, translate_phys_addr, cpu,
                                &elf_entry, NULL, NULL, NULL,
-                               TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB,
+                               legacy_binary_is_big_endian() ? ELFDATA2MSB
+                                                             : ELFDATA2LSB,
                                EM_XTENSA, 0, 0);
 
         if (success > 0) {
-- 
2.47.1


