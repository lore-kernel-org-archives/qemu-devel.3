Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C4606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vu7nAhA7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLxC1-0001Jv-Mp; Wed, 28 Oct 2026 02:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLxBv-0001GV-SI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:31:23 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLxBu-0004qa-1A
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 02:31:19 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so905566c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793169067; x=1793773867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SCvaE1xWeWnx7UnU/1gnWw/QKe7acN1+xJB52VmOclA=;
 b=vu7nAhA77F2Mg+olzyJbUH5wOvNCJLdgz9BjEyliaHKbuip4C7XEcFwj9Yrf/8Ja3S
 Pl+rGNi4rCNQ8uWtU0GMhjAvURrNi6r8bMEf98Yci5KtfKBjY6F3fmrCzC2XMX5n0Esn
 d2+Vckt5WOeOYWFTmaygn77KSzI/jOPGXpRoI4VUZHBdEz6tql1tYx1h73cDo/vnX5tZ
 5T8vfDhpImoLIQrVA8Kbfh/yKYtx/XbMlwY+oQ+q4MiFUJ3vzCmX82lqcQRIZtGRl3wc
 NjnV4trdcSGin2EHp39mOGdu4DvmSAN9aQhUEkD30/RXqwDJMBuELp45Dxmj2wNImYg8
 RIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793169067; x=1793773867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SCvaE1xWeWnx7UnU/1gnWw/QKe7acN1+xJB52VmOclA=;
 b=Fn5/vPKGGrNclzOqRdWo0wYdVpQFjQ+dKSuQIOURtt5fuHz0mQkc+c/mCeaLEerBQf
 cCSviqXm+Iv3PtHJTL2UpPDQ9A9swmmDky3u+1Rn+IXC02ceoAiMmhbTbqcRWr0+dylt
 8jf1AnLjebT7oshpbdhwMTjsqD5TpA0KlWGvObioT/rDSlHg8g62pelZD3kaKB4ZbXlL
 /DIRo8n9HkqaFbWQCWdNzdnWv5fL6E/NSMasZbwNM1ba81fBGdrbNQW7rx5fLdElxw5t
 5gFNLOqav3PdlmbanfaPIIuWpRxPkxkxPO38bfiyXlC50t6zfJ295Syhk2NztgzujggQ
 M5tA==
X-Gm-Message-State: AFq9FYIKHrgIWzPnvm/6xQqu0AjmDZ4UbUdiNK/OSwRsMkrLHN2y4SUB
 we3kg/BwEXaX8WPrOdnVsehHnpV7wFbxwxZmgjgWNi8ZlqsewG1rXZZ6UGbesV00
X-Gm-Gg: AYBFou00HYFSy+Om4ACVr1IdxIV+DmTmm0DfXIhzDPal60C3YxvOanDigoNN6KBNSm8
 1ph69jJ68N7hRTPL47zHowCvRnlGP18K6faYHrsYbvjM2TnhINgUxSAMXfWffLMY/1slKtU+ffU
 ALfJQfLtCVmRc4s/7Z08cmyle/y5Yp9godUxwmZHLXadnmmkoSEo4EXpTla8JvPIjrIUPyK4KHH
 0R1raCN2FC45cJ6sHPrF/mi36+U5sh9vXCbholhdY7b7WqYOwZ34CYKuqJ7SiTwGx/ct/qbKrGX
 LiCcaNPvCR/pc6qjlUnokMUApvMGM2Am+0ebJNTmZoCYzCah0PDkRu1p+kH0Kt/8PWMUjqswTPn
 PP26EE+ZyXcrLX4p4y/nrvUKJSrHRgQ+fLIUFEatuJQ+GW4zga0otZbhf42SX9vXoMCw8SOa6jq
 Ve/jRzlA1XWXERclisenB27YnlSzBXu54/LWMW3pE0XOuXsGAbNH9vLDqL+leDkaGUuUCj7TOUv
 0UmnTT40w0OR6stHyXLCDjgNPqpQPOA7QXEbwfje5cYWuZgLCXZLDP4g7nA/9I8Ozo1pampXTko
 WoajMmjbLvjLc/fE/QzHy5SfP3NV7D+wFOH6geueuodsf4tZ
X-Received: by 2002:a05:7022:298:b0:19a:20d3:a3d6 with SMTP id
 a92af1059eb24-1a6c85d1368mr1804797c88.1.1793169066871; 
 Tue, 27 Oct 2026 23:31:06 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1a75e5c6d4fsm4512584c88.14.2026.10.27.23.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 23:31:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Weiwei Li <liwei1518@gmail.com>
Subject: [PATCH v2 2/3] Revert "target/riscv/kvm: restrict kvm-accel-riscv-cpu
 to riscv targets"
Date: Wed, 28 Oct 2026 14:30:47 +0800
Message-ID: <20261028063049.2530-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028063049.2530-1-luoyonggang@gmail.com>
References: <20261028063049.2530-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is redundant now as all accel-$cpu_type parent is already registered.

This reverts commit 2d3e6b4003d5380c245ce8ffac4b8866f6d10a33.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5a82a63b822..c085b22b23e 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -26,7 +26,6 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "qemu/target-info.h"
 #include "qapi/visitor.h"
 #include "system/system.h"
 #include "system/kvm.h"
@@ -2236,7 +2235,6 @@ static const TypeInfo kvm_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = kvm_cpu_accel_class_init,
-    .is_available = target_base_riscv,
     .abstract = true,
 };
 static void kvm_cpu_accel_register_types(void)
-- 
2.55.0.windows.3


