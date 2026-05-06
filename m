Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EABFCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKckT-0002xc-Jo; Wed, 06 May 2026 09:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckQ-0002Vc-0H
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckN-00085v-Ik
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:09 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so32440225e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075825; x=1778680625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jn1u55xWzu0MsyEl19yV2ip/+YjodbZU5/4gzMB8MyU=;
 b=KBUQi6odZypBO/JhPrFMPzgHjJdHKrEiPTL1J8QepVHKWnQgxCLUYPAkQY+sWSLwLz
 RkJAphSNIbBH8IMDrYJiFhDCIplMX5goKHGOe4kNly8KxiZ/ain+9YtFBEoTSK8nWz8t
 j8LMldJUJvOhhu2a34vmmr5aNN+4pn6eKZGrm7NfTeGm8O/zFFUTYyRzgma8N3jnlbcJ
 rZLZnzEAk5+Cr8Es/isV7Pcsaoi+F/pUf4vxl17Tn6wZt1FRn5x03Mc1derxe71rQyJ/
 HC5wvTmn0y/JgdstxjayVhUr/YAivo7xeWJIOfd8LAx0rm6jvEoqetN6XIkHzPTynG84
 pwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075825; x=1778680625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jn1u55xWzu0MsyEl19yV2ip/+YjodbZU5/4gzMB8MyU=;
 b=ctZ1tGhJZieDNWqft0aydPryx7cvSIW1tdnj+jdcZe2gr/DxDu1L7iwHELi8cbKE1h
 3TcUDOzPZ57FkIZ4XHlVEPj6eBgts+/2cH7aAUXN+wcrukXJ118BBrSodoxWzWOW7hBt
 AIUKul6o4zr3rckk99wSgp0Oz0JaO1LQuCtPWas+fcJ+AQ8Xp4u/cuI67ocJjhKZwfN6
 DYddt9RBqOEzXWCqiQyitGZhr28P2RuK0RxmmbvAU+ieR/HCQAXVGGe36Vf+Ah4Eh26U
 om6D9mpjqNYAKxSN3GssIMCvsZgygO8pr7SPbN7fSFsD4cmshO4O7Ng6Rcw0fAu8kHR9
 1mkQ==
X-Gm-Message-State: AOJu0Yw9hHn7tHHlu0QsGTYkt+rKtHVxL/2fdWwBxm3kwdgZcYrM1ApR
 apWDH3ZOX1CQg9lDlbi/36oW8LpoWRe1Axsps2y/swkiFEgFVArbrk91qVQZUWwSgDiIjYH7c4K
 f4RFn1e0=
X-Gm-Gg: AeBDieus2nMjdqSnVVBjFYugXSSasKVAyqjNe1XwBCmGffyyn0PvnLuf0Vtq14sY0DQ
 n6HZHFAU0GJP764+tbJVzrDfJsjYdb3fDuUZCdOWPG0LWAqmxmKBgOzMVpHFaCLPmaRBPErBHK7
 r+5Esflkx6PAmSIvZSeHJaE7v2r9GaPJWEU7Yexw6nSfaxSIr42LCzgRnFUlUccmf4N4I6teWTP
 RdwPlT9tjSYdogLQGIHicYWv4hhgLxy2hBcjTyjMg9vdqBrgQKyFc8XRiAJGE623fbrLcx32t1f
 19kiIMhkYWEPYKXJnZfj/5uoQ/sd/geXiwavfql413PV83Ow3rJL+DyKxidupkUFw6xvc5//NfL
 W8Ph/87i4DfczuIAbIvPdY99bE674L5Czyei1AfQ0egdr6rt1XSSF2ikkTNcJLXZ3eNSoeM7was
 +RvAiZtj1K67K/ZqOUzG83aWuKT7VqZPKtJ0y/PjITWbT+Fk6iE/eZeARm0dsxfqs+Uwx8UpRK8
 HveC9xjzxE=
X-Received: by 2002:a05:600c:8908:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-48e51f24340mr42275375e9.8.1778075824679; 
 Wed, 06 May 2026 06:57:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538aca14sm46296545e9.7.2026.05.06.06.57.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:57:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 013/110] target/s390x/tcg: Include missing '*cpu.h' headers
Date: Wed,  6 May 2026 15:53:45 +0200
Message-ID: <20260506135524.20617-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

The "hw/core/cpu.h" header (declaring run_on_cpu_data) and
"target/s390x/cpu.h" are indirectly included. Include them
explicitly otherwise we get when refactoring unrelated headers:

  ../target/s390x/tcg/tcg_s390x.h:17:44: error: unknown type name 'CPUS390XState'; did you mean 'CPUSH4State'?
     17 | G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
        |                                            ^~~~~~~~~~~~~
        |                                            CPUSH4State

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-18-philmd@linaro.org>
---
 target/s390x/tcg/tcg_s390x.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/s390x/tcg/tcg_s390x.h b/target/s390x/tcg/tcg_s390x.h
index 7c8aede80d2..975f60085ac 100644
--- a/target/s390x/tcg/tcg_s390x.h
+++ b/target/s390x/tcg/tcg_s390x.h
@@ -13,6 +13,9 @@
 #ifndef TCG_S390X_H
 #define TCG_S390X_H
 
+#include "target/s390x/cpu.h"
+#include "hw/core/cpu.h"
+
 void tcg_s390_tod_updated(CPUState *cs, run_on_cpu_data opaque);
 G_NORETURN void tcg_s390_program_interrupt(CPUS390XState *env,
                                            uint32_t code, uintptr_t ra);
-- 
2.53.0


