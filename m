Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E23E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 13:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVA5m-00061X-Nc; Tue, 07 Jan 2025 08:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVA5e-00060I-AQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:57:51 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVA5c-0007NT-Lq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 08:57:50 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso11822575f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736258266; x=1736863066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYtSO87TvztjAyXEjizFAAxhiS+XoOlqzVv7TToVVGc=;
 b=VeyDfdE0sX+Zmi83bP75LGhPM/wgKSG6BR9Qm5XOmoafQjUDdOiOsNQG62GYmKTcsG
 75eIm/jr4qMVa58kc+9/6VtCzKDwKGvjBKEHlFwuuzwESe/FQbi6STedbxOq7iUfgHDB
 jMgJj71g5PVrNc+ltRC+kG+KZ5aK4zoKznGutjsGgAfTJ/oGYqZq9hVGm6q84hFmh1EL
 nc4pYmE7FgT+vEvVDdWN1SzpFq5oB8AeGAR/WBmRtiZ6SSLemoOz5ai6HAP/D+Td+6fJ
 UV3pQwlxIa7foYDEA5WmbGdSXxc+ALXfqgamRRDQ/DMmt3LVJUX04xc9JB7CwuVmvxu5
 h48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736258266; x=1736863066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYtSO87TvztjAyXEjizFAAxhiS+XoOlqzVv7TToVVGc=;
 b=YGm5Nj9O8PjBjqtk4GhPK+itLDpPrmgsepG3MEjkuzZIYkLp6RFVBVIaWH6xJtbasl
 gkxkiXSG7wrcxQK8jrW9BQs8v8Dvr2Ntg0qGL2Z8S62z0UCX7s5G39RT0DT65xSDegAX
 CKrEGHPcBZzrsdQMlAc1WEpJeU9gDITXfoTzN/yj7vaL2UHTJpycr7Spt0o8PjKavvkW
 FbRFgvhUo4Lmh/BDLPLY7Sv9GrPtg9BbiEAiMg6KqxkdPeXIqrJy1hl/cGrUfTAPuFC2
 6Xc4d829seX/HyANflg9oCeO4bl7glxhuFqWHBHkn6MwUHhHgtRpMBazDVB/i16fGJ5P
 uzkA==
X-Gm-Message-State: AOJu0YyGxh81E6vxuJB87G3RzsGEq24Oil/QLPqzTVq9tamplLXElZ3M
 ZXX5+wSZ4UiqPRqxpGpHGM1ujKUY92G/5TIu2XGZpy9/DWFbfJHMb2LImFYtNQdxOPGzO/btYUL
 dznE=
X-Gm-Gg: ASbGncswzkKET0yY2qgmRd8OzIwCWhPMDuPltIt6Ry/MYXRjwBA8lm671JuNO/shyug
 Jqb03rBd3IOpiB3LjIsya/PY3DA1c0Dbl18LqPK7YNvImTNDGVbw0+WcOeqG/N5qfPo+12eXsTD
 SE83Arra3NgiNdK7ia2T8MWZLxp4MOMrt9ZJf3hPTNoa4z3s7xzec/Ub5Jg21M1/5gnKatl2BK/
 JhcOovk5jumcAb5boUu9cE/GzBLdLNGcXq7ydarQs6mePlldLoP9hxAQ08gXkxFUEc8VCAS8OzJ
 1Ujdadgt2GRNzhIeQoc3yAG4XyGFmdI=
X-Google-Smtp-Source: AGHT+IHr4b4bj8eykuMdHCUSvezDyJONP7UEGesPRDM8pt0sieMgv7l9ZnflmeEMlzjNUZBJeC7wQg==
X-Received: by 2002:a5d:5f54:0:b0:385:fc00:f5e1 with SMTP id
 ffacd0b85a97d-38a221e2448mr54763938f8f.9.1736258266671; 
 Tue, 07 Jan 2025 05:57:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8289a0sm51878061f8f.7.2025.01.07.05.57.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jan 2025 05:57:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/2] cpus: Introduce cpu_is_of_type() helper
Date: Tue,  7 Jan 2025 14:57:38 +0100
Message-ID: <20250107135739.48324-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107135739.48324-1-philmd@linaro.org>
References: <20250107135739.48324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Introduce a helper to check whether a vCPU instance is from
a certain QOM parent type.
We don't need to use the type-safe QOM cast macros and can
directly access the cached CPUClass (see commit 6fbdff87062
"cpu: cache CPUClass in CPUState for hot code paths").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 9 +++++++++
 cpu-common.c          | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c3ca0babcb3..d55d4802ceb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -795,6 +795,15 @@ ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
  */
 char *cpu_model_from_type(const char *typename);
 
+/**
+ * cpu_is_of_type: Check if a CPU instance implement a QOM type
+ * @cpu: The CPU to be added to the list of CPUs.
+ * @typename: The CPU type.
+ *
+ * Returns: %true if @cpu is a QOM child of type @typename.
+ */
+bool cpu_is_of_type(CPUState *cpu, const char *typename);
+
 /**
  * cpu_create:
  * @typename: The CPU type.
diff --git a/cpu-common.c b/cpu-common.c
index 4248b2d727e..2541a81ef87 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -455,3 +455,8 @@ void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
         }
     }
 }
+
+bool cpu_is_of_type(CPUState *cpu, const char *typename)
+{
+    return !!object_class_dynamic_cast((ObjectClass *)cpu->cc, typename);
+}
-- 
2.47.1


