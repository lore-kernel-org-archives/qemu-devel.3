Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5F3FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcjT-0000t7-Bl; Wed, 06 May 2026 09:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjQ-0000qo-8Z
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcjO-0007pm-Nr
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso57750955e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075764; x=1778680564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PUOV72osLEXpR0dcwtXn5HQdjKKmmU7aY7ana5NjptE=;
 b=p8lwXJXwo6H2oIyiLdU1Decap/NNWZz2ttc4uuggZRK6Kc3f6aUPMBKKFabF0gJlt4
 Sn7nW442d6APXJkIu8oif/2+bTI8GYwEBG5H5BoQYYM0e29rYSvhq2Vg9XZU9loSkH4A
 inQfiEHnt/uGea4h+EDM78Ag7rYgr3niDkvUhW0jeiyObpQxW99So1OXCXElDGV0u8yk
 Q3PnA7U1rDwt/3JOileMRs1gCsR2VlZnBpPK+6qFIqDipGXXQVZa7DoI2nT/KHCraW9G
 ky69OsOZp6/tTBCOcchinrrTRK6yCf7T5XEF7LCvnKZ6vQOBEvO4S0aftW06REI/iyCy
 6miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075764; x=1778680564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PUOV72osLEXpR0dcwtXn5HQdjKKmmU7aY7ana5NjptE=;
 b=q1piYafTa/YsyPhgh+FIKp/FoAeJfPfzMoVv3NnNgAzj4s8ecY2dgV/xY93WuB4jGP
 p6MXM3m3iblm/Yr5CyMOYH6epH+OBdr1B1HZPqXo480+uF/GArtXaParCQaY3Ykkk3X8
 w0fr6zo+a0cFbijbMkYvFAcW6RzHI+/ZS3b+6HNw9/3q7e7uhQQtxE6T155IRFhQcTQZ
 upSb1svD5XOIeg9qOxfNnhxAAi8jUPLjP+KXAT+iCbP8YINF8CXuFkTsT1KvOk1DTHOW
 qGjnQy1MsD8uR+AQnT3I4QmcKH7N+HCflx1VzaqHjb0hRBspZLLprzqhHY0hotxuc4nA
 Vpag==
X-Gm-Message-State: AOJu0Ywk7p17V7icZyB2IxaZeptC/UImS1to/TKPyC642heC63Y3YCbu
 iT5MWVVN0Fj2jLIIGUvz7sJxnApqlVrw8kGkNTrrSSgm+wMD2kG9UwJXOLu9ObCtT4BjQJYdjfZ
 IpwQvtBk=
X-Gm-Gg: AeBDietu4hXnt4iRCByMvoghZ/ZtapxCtiwKaAxU2j763OXVnHKdD8XyxgTGSjqRass
 NoBKiqdctiaH/0YvtgKaXRhS8AtP/Z08UGk98h6mYuWkTO9UDgjXjSQGlBEfZ2dGkCx+VfzpCtY
 qFhdY1ZV7Hz2T+dXNTO0IdMhsyAKou+YDmAlXg8EQLbWFo/V3fWMDn0IdSNjDTO4z+No2t2Xhdn
 sw+rIY157iDU8Bi5PmiCCiHuCZUzdoEh7zcpA5oJsvMP2ZjzUMLeiUm+FvHXAnijByW20S4/flU
 fjM/03DQpwWDbg0+oqMQrFmcg8uDxKplmfqwPnpn3LCAhwIQPcw9pYrI+VYnMyE8zlozC7Mh7j6
 it3BaXYftzdCgPXOrt623GPFRd8rZGUn7ReVUdw1M0qjToK+9PLm63k+tEOwBe2zYzoSJMrpvW/
 dBWfmjNw/ZO0qiyoOIMLbrqE/GJvtwK9mbRwuGND/dcD3UH41TOtOCAcmu7fC2d8InkQEKyRdGz
 kSgzHvERgo++lIZN90pDQ==
X-Received: by 2002:a05:600c:4512:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-48e51f539b0mr59282895e9.7.1778075764124; 
 Wed, 06 May 2026 06:56:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960022sm12783848f8f.26.2026.05.06.06.56.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:56:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 005/110] target/hppa: Include missing 'exec/target_long.h'
 header
Date: Wed,  6 May 2026 15:53:37 +0200
Message-ID: <20260506135524.20617-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  target/hppa/cpu.h:375:1: error: unknown type name 'target_ulong'
    375 | target_ulong cpu_hppa_get_psw(CPUHPPAState *env);
        | ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-9-philmd@linaro.org>
---
 target/hppa/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7d47afe8efa..6ea4c9b6826 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -24,6 +24,7 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_long.h"
 #include "system/memory.h"
 #include "qemu/cpu-float.h"
 #include "qemu/interval-tree.h"
-- 
2.53.0


