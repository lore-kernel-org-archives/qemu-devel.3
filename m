Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA4AC4829D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 06:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYKZs-0005tp-K0; Fri, 09 Feb 2024 01:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rYKZo-0005mq-PA
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:41:34 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rYKZm-0002Oc-Nf
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:41:32 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a3916c1f9b0so73545566b.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 22:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1707460889; x=1708065689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytTPrgvmcSAVYKXxwo9D3fPgoAujr29L9BQ2PXjBjJU=;
 b=GUwlIrfMJLi+m0QhrP+rDM9csRnx8WhKzdvziezTCKCl4/Hyzfg0oJHXxvsLPa6UkC
 vw+2g7YcD9C9XE2W5RliUMejAb5qA4cabirr2q1i87/P9t0VCiFdo2YMcWHUGpBe4/oD
 4WbQFiUKMqjI6Urq6VaTBQ/mn7QXz178lismOKkYi9l8/1c51AHOdzC5z16sW+VR1eF+
 gbxMtxadjIGI5BI1Kt03UFRQKJbNcN6cDeCNyeJ3vQ0aKSfW9Iatyp97h5N/PBR8DIM0
 r3A7Ie+83zib4EhQk0CwDkxyVEOrm0n5HIr0u15Cmr64mJ9rw4EvffXAe5+wCTwfM3+1
 MKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707460889; x=1708065689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytTPrgvmcSAVYKXxwo9D3fPgoAujr29L9BQ2PXjBjJU=;
 b=bvdAQ96STLoZ6JYCyW3n34KQFX1I8vORF0FASpqM4uBRyIQeEeZaF6+zWbDqsZoScD
 wtjQtxJv1iWBygACXf9FYuv+ZehLujxR3EMwOhXyTDJpWCGlNFISDTI+8fq/D1vG7gm8
 J2LtrW0OG2p2etvTGyVSQLI/WAqnwb+M2bCBMSK4OgRSyPM5xf15AYucrnScJG8ZCaOc
 iRkIMfsBUhvtM3dkk4LWodY6qSIOVrC3PbAi5JT8Rrl7Cu2FvFEBI3fTg/enuODpVpBU
 i/r00c3GBI2g7ibpREr76R7z8yl5Hl23lJZcEl1oybc98NSdWsv2X+YFmAhVT+hermNg
 dAWg==
X-Gm-Message-State: AOJu0Yzj295KE9T4WOjccZcG6k3GiyxAmWtmSLOm18QY8hb3RkLup0ec
 3ZYL6aMlFp62A74Y7B3knPmuOjJg5sHJhEExJKXm+/U9n5NMrncdiCOKK3HOMIM=
X-Google-Smtp-Source: AGHT+IFVg4lO8zkHhRZCGeDc2MDr2YQcPD8It/U0CsIDnPbxPJxfIBzw6pOBCu/rKHCc+ukuID9cwQ==
X-Received: by 2002:a17:906:3b5a:b0:a3b:721a:9162 with SMTP id
 h26-20020a1709063b5a00b00a3b721a9162mr409548ejf.66.1707460889359; 
 Thu, 08 Feb 2024 22:41:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWR+BGDglxI4JrKwy7PM9PtB7wk/zlH9clO2KU+SaMEc5HYGP6818LRYYzni3w9RdJNoXM91X8rVEr5nFYgjOIIoZB0f99OlA4LQ3LGVCpO6eqW7bv9lj+ElVSDNGrEE1uJcq9QvOJhO2C43pMYwn7oP3VU/SCF0Gs45ZvTINicfDhEItIi1K6p7xy0HLGlWL/JsInD6RN5f17TlbR2Oom/RpL1VjEQRnwWD1gr5KxC14yPlp+TYobLea7Lz4QsCNP2Alo0GyMQgr6g8qhycZvbs7o4AxOUBVem2ahTmphQf7Y6VI/0kK4lIo/2R2ytHRhv3iz9bpVHsWxJLi2CoA8jgZxakVm4JK1KHg==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 vk9-20020a170907cbc900b00a36c499c935sm450575ejc.43.2024.02.08.22.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 22:41:28 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [RFC PATCH v2 3/4] linux-user/prctl: Add dynamic memory consistency
 model prctl API
Date: Fri,  9 Feb 2024 07:41:16 +0100
Message-ID: <20240209064117.2746701-4-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209064117.2746701-1-christoph.muellner@vrull.eu>
References: <20240209064117.2746701-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch implements the prctl calls to set and get the current memory
consistency model. This patch does not implement any real functionality
but just defines the relevant hooks, where target code take over.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 linux-user/syscall.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bf0d66b8a8..cf0845a074 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6309,6 +6309,12 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 # define PR_SME_VL_LEN_MASK  0xffff
 # define PR_SME_VL_INHERIT   (1 << 17)
 #endif
+#ifndef PR_SET_MEMORY_CONSISTENCY_MODEL
+# define PR_SET_MEMORY_CONSISTENCY_MODEL        71
+# define PR_GET_MEMORY_CONSISTENCY_MODEL        72
+# define PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO  1
+# define PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO  2
+#endif
 
 #include "target_prctl.h"
 
@@ -6355,6 +6361,12 @@ static abi_long do_prctl_inval1(CPUArchState *env, abi_long arg2)
 #ifndef do_prctl_sme_set_vl
 #define do_prctl_sme_set_vl do_prctl_inval1
 #endif
+#ifndef do_prctl_set_memory_consistency_model
+#define do_prctl_set_memory_consistency_model do_prctl_inval1
+#endif
+#ifndef do_prctl_get_memory_consistency_model
+#define do_prctl_get_memory_consistency_model do_prctl_inval0
+#endif
 
 static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
                          abi_long arg3, abi_long arg4, abi_long arg5)
@@ -6481,6 +6493,11 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
         /* Disable to prevent the target disabling stuff we need. */
         return -TARGET_EINVAL;
 
+    case PR_SET_MEMORY_CONSISTENCY_MODEL:
+        return do_prctl_set_memory_consistency_model(env, arg2);
+    case PR_GET_MEMORY_CONSISTENCY_MODEL:
+	return do_prctl_get_memory_consistency_model(env);
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported prctl: " TARGET_ABI_FMT_ld "\n",
                       option);
-- 
2.43.0


