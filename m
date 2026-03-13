Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03FF106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vuI-0002EU-EG; Fri, 13 Mar 2026 02:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuG-000262-1v
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuE-0006yX-IR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso15126305e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382912; x=1773987712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bxVDDXu/eQkvYvur3z9ZbH8fD224/ZN/Wmu1so0dKE=;
 b=EX1K1+4omUvb/ZcRSI+fx4wdZyIpea+Oty0v41iFi9/iMct5hikTd6LCS952bmXERd
 nbHoPfR3Wqc2oTImPZBywc5sQxEC/v6n4uV7Zs9/ZZ34/mtYt+TEccSBmNhvmCP1Jb5n
 w8KZI5ZL6LN49jAplOPfaOZdbguYMyXEfK80Ci8FMogOJ8D+iF7EDJPbo+49+Oef4LsM
 SlhHvm2lXKO2ebz1acxLpdkr8X9EfdsWWKIme/jSCdbkDK2gIM6/2ia3nhHu/a6tYT2K
 NOINYhNdAOlF0bUhjFNI4aWCRUCt408pYfaSyzoNhaAnEZ4WbpuikSdKmmeRkiT2OvDy
 TH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382912; x=1773987712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+bxVDDXu/eQkvYvur3z9ZbH8fD224/ZN/Wmu1so0dKE=;
 b=RwrvY3K3LySE/uUcntaslpSVF7BD0JSkTEgORiGaQZCewuMsTsMr2jquvMiGYh6w53
 PT6MRju6DsCyMzbNZ9gBXBY8lWKN9L3fL+kmsPkSuXlFKZ/fHYInETs+YAWs8tugJEYw
 c0jUjUzR8wIkpTgRKo921l119DX46ucn/X6lExvkjcsQwvPq1zT21BaNO23Fwkae4mpI
 qgw1xCTBnwO5LJ8kd30Cv6Cv4yhq9GpYlvS6HRQb8L3/qa+37QYpTH5Q5NG2d2PlK2xu
 dl/ZLXzQDNJPi5+SHpHEk3PTpXQIcVGukZouainCf+X+S8y/EeuEQyJzae9y5lxEfTpI
 tK2g==
X-Gm-Message-State: AOJu0YxEDOZbFCJyJ91vAjwIFfc/F26OMYRK/ovE1bpg+WbeoMS1ccfm
 dgzlY3dZ/8tM9FU+JaJOjIi1e6PZRQYhrN4IiVyggbAu+8PEtoAKqoSUXXtvLdf8KOyYaP5H36w
 5GMUfRRg=
X-Gm-Gg: ATEYQzwOAmTVGIOmHr+NjfiIHiGcv2q+8dIyi/wPbJ647TvEFaKg/TcUEbN3tierTjI
 cJTzeuXFw2oH3P2VF1lMJfYXWutjZd0s/5hiEPDu+K3nielhSBWwu1RRuEUXRw/PvbAP4CZSptM
 eefTQ+HIOOOSENSh90pwXPYmZBWxJ+du/zbu8Ncq4BYmTXKomgP24b8p7j5c8fyaY5lUHiU8Xlm
 ZLcRbTgXJcSRkt5oxLMZdWs8NEszX0ScZ+Fvh7wDnT6PJdUtYF67A0zjOsbe+E9Pba/FU4WsKXc
 TIfylg0U535QIyZ8I7gktDGarxB4JJ5i2XZAVZPwbti11dZOzLjPN3ktOKab2RttIHwvv3I1DHw
 an2jt9OHzzzNHzfkfbe2r/2hvMAUbMaI0PPs+aW6lOx+WIsnDGiQBgiB/CITahRSbR5fzI/uwI0
 bvdlZDURhXhDdjOuSA+pj5pX+rUMC6YcL5SvA9QHI+DPYnsVKkc7goUYTo/+3VidepB/aX/7T1s
 kW0QiPjnXoRHS9h
X-Received: by 2002:a05:600c:3552:b0:485:4438:6ef6 with SMTP id
 5b1f17b1804b1-485566f79bcmr29149315e9.18.1773382912450; 
 Thu, 12 Mar 2026 23:21:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fe27sm191617675e9.9.2026.03.12.23.21.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:21:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 08/38] target/hppa: Include missing 'exec/target_long.h'
 header
Date: Fri, 13 Mar 2026 07:20:24 +0100
Message-ID: <20260313062055.2188-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
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


