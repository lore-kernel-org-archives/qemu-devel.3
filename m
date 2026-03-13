Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA683106FD89
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vuy-0004Ox-1X; Fri, 13 Mar 2026 02:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuu-0004Ft-AN
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:37 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vus-00072Q-PP
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:35 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439af7d77f0so1460734f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382953; x=1773987753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gp7D7IXxOtA8JIzMvgi3moGsqkl9D+pf6XknAI6wFi0=;
 b=QOkAXhExyEyHd+jfO/IdHn6tgXfYaOr8bkRi7YfMe5U9KvFOaalRxiBm/m5C86BrQ2
 xkQRJNxe0ReCDLWR3/ntCDNLLooDCWLtlZTphR7eIp3BTv+gYTCewm0+/HIbsF5UIKbc
 /I+wZAofAkKfExkoOxlAQ8mRpc0nwhO4ZyyGntadacjs8Oyq9IekvzwIpRj1VRqSlnpm
 Y/rzvyctcuRNFfYolR+vKyzxGaW3LIFhsqJNQaobgmi870Aq0W0LgVbOsznfXcTOETg7
 Zf7SB0kmoBmYCfvb75bBGYfRlkBokCas2oiipFN11cPwA4VNQAGXVWD3P2gsbrLhNhmD
 0nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382953; x=1773987753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gp7D7IXxOtA8JIzMvgi3moGsqkl9D+pf6XknAI6wFi0=;
 b=ako6MtntaeECh9t9FBwauRh1Gy4p3bclFcEIBFOuSl3Bp5+3la+DfKWQWNkW2CEE2m
 XhzevFCnKf/NtEXUE8kaJ/XgFQx96gjAyN/WJuGzLtD9+O0ojZjdobYL5gpHREqT6pzA
 a4xeN4uTgsHeX++9T0ONkeWY/s+FGe/OTzWGohuzHXaefNB2sP16IcutUOHHVg5/J+h0
 JhZdxV17+UEH6PQuN3+g/yzizspXd4t10awhtzrL85GtTAZ2A6r3gcuhp9SY2zX6C0ET
 S5UsaVlHsAebVvEMscbhflNihNNt+nET70oTHbslf6HClFoa1GMdYUOH/dCLvnypVFir
 mlyA==
X-Gm-Message-State: AOJu0Yyc+Y2upHeYoQbhKL80hpX+dWXI6ulG8YbBPSU+FTB2Cfj22e5i
 skKeyegk2VrD2p8LYwRHnJM+ukTrfxoQBU/UtwXFpXwY6OZjLoink+4vN9OVWmNwa0DE4BCScDr
 5tNTXDms=
X-Gm-Gg: ATEYQzwIopqJG7OkGbO+Gs95WDGyAUj7Rk95X8T/cKte7R9IkmuoC+qym993FDj7dqJ
 Hmx2vOWULiJZFRXTTuCqru+hiol0mfdatnVe7bYEJHs5RHyDcgX7xPICmG16llc/zCs7OtTNG0I
 KgpSkt1w4GqqwVAGVtVvPjdps3cM05xP6eCjshq0OugFtP+VTkN32zkDPicm0ZUPvgZZjt8gexB
 rKIhksvu0hJhHLlKjiX0Q3xTCd+2zup42DLbLgEKhsyn0Khj+Yt7nv50Q/0HzTT1l5XjvaZ29BQ
 JxqtXI6+E+eB/nVvQtXTs96qYImoEFDQfN7eVWRmKx/bo7+MuChuly7EscOQN3QeDEyY2Yc5ghV
 +xZgSI2A7Zslhe1aZPkqU87XRWCAcRDSoZqEx8ItHBVwFRTddrZbfBTtwZe7S+mJ/duLN5bJO6d
 2gkXfN81nXYEZnNh6ZnEFhDecjOjz36ZnAVTzFeVKgtS5qJlb9qEJxxeZUIybvpOGwZftkRtstp
 MUcfQ==
X-Received: by 2002:a05:600c:4f54:b0:485:353f:c651 with SMTP id
 5b1f17b1804b1-48556702b4dmr28363495e9.22.1773382953095; 
 Thu, 12 Mar 2026 23:22:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fe27sm191652155e9.9.2026.03.12.23.22.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:22:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 14/38] target/sparc: Include missing 'exec/target_long.h'
 header
Date: Fri, 13 Mar 2026 07:20:30 +0100
Message-ID: <20260313062055.2188-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

  ../target/sparc/cpu.h:615:1: error: unknown type name 'target_ulong'
    615 | target_ulong cpu_get_fsr(CPUSPARCState *);
        | ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 0139732e4cc..155aa8ec637 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -5,6 +5,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_long.h"
 #include "qemu/cpu-float.h"
 
 #if !defined(TARGET_SPARC64)
-- 
2.53.0


