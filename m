Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2B1106FD85
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vtv-0000uq-1T; Fri, 13 Mar 2026 02:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vto-0000oG-2g
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vtm-0006ta-I1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:21:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so20199505e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382885; x=1773987685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/R6d1uBZPwjzpP/2K0o6+0+0LivzvR0k5Sb2Q2xFMc=;
 b=B3xs2LDABo+bzbMqstntzrOAk+q05GQ1oonig5xR3XuOnauc43cwc/y4/un2zKr/bM
 BDk/oXBS+ubS779NJj8ZjklkHd/FKKu5pnMi0+10id9rg1w7us4bWldzjT/AFOwvyZvS
 +VRR/jEai4On87NZ0pfBz7vxorALU0Ko3HzgekrlSwVPwFNndcXlkRa5Mz9Y5dP706J5
 JIs8GkwTIUjLsxdPnr0feVlide7yD7H2tPOGkhLV6Ylji3rxNf9ewUXkTNld+pWoJNKa
 /XEV+8px1YT0qov5b+NnQ4+PANLW0SZJ8jX6OpvUnqccUg4BCGXRIrEPB1oKBBvEDFfa
 2hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382885; x=1773987685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P/R6d1uBZPwjzpP/2K0o6+0+0LivzvR0k5Sb2Q2xFMc=;
 b=b0Yd3NHTpruPbudZlyyg+FPULjVfkaFfmQi7kd5mgGnAxppMtewsXm6f0cjlDNUPh/
 Q/lhy3ivrz5UtDDPkCqtLJ8/ogjHH8eP/5/cDKn6VV95rpLOYRXqeU+ySxIW24esF0C4
 pdqn8UdY84BKTtkgEZHjOhh8lNm75YWO8joh1Vsu0zVdY2PA4kvuQSDkZOzbLUH4f0mj
 F6ZcXzY40vwXTWSgCQ+5ZqCj2NUBbs0AyQUrbViCfKLdqG0xM9zXDDBLGXZ/nDQf9RS7
 bEzbeqVXX/733JtZI9oqUSSD3YFP78n4mnKWErdb1UW2cp4NUeM0GQu6ZaKlS46Ya+RB
 jT5g==
X-Gm-Message-State: AOJu0Yw4tJMiCSpUAjjtVYweG52OGIVGdco2NSYw1VkZolXVvnXYG9x+
 p9OLBUp7xOarPjGuTSHwqeFQirZRAx8BxyzEdJlsrC5hucACG9ZD0LfIcEgwoIbCcwiatEjNEn2
 pOaGX2tY=
X-Gm-Gg: ATEYQzwHWBwk8D8yogB9x3g3Yp+JFVEutaYCe8Q7hXkUMG37Devluxr0lkFLncd01X+
 Ra7qDOwHVlhxoeaTntiBLS9LLFi9uujIn0YeF1HfztPLUcG70WcDIHp/egsmcDx6PhIJ5ualRho
 COiakKLO3zBjDcMLFY0SH6FHKNFoyZMMoLaDtUh6MPsFyWCndGdwydWSWhfKnsOT0SxebhIHYI4
 CpsEOW46uN+zwJNgxS/R+0uRViDO7vIXZqoNe3VK3RUtPY9qb1mY4RQ0cPKokQ88InTLsakBTmh
 bNMwA/0zfnpZLZC66JW6pSphpoQ4Z7HtBHhJMGJKwnem3uPYp/pImO4o1QTJ0i2ok0ZKQ8ygc+8
 5ql+o1XKPqFfJiEPaKaH35dWI4fbezGblgnFN1XFYanCJsDUBu+pUcqGGpifgg4m2yCeeMQq81H
 D2Iw84U1HhXUqzJ2QGDHSL1b9PF6d3XsodilarT/MesCqYNUkptZths28EZzQIBEfzaaFvPPGF3
 AaK6A==
X-Received: by 2002:a05:600c:3106:b0:485:3ae3:b394 with SMTP id
 5b1f17b1804b1-48556711ec9mr35994205e9.31.1773382884690; 
 Thu, 12 Mar 2026 23:21:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f255sm290560615e9.12.2026.03.12.23.21.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:21:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 04/38] monitor/hmp: : Include missing 'exec/target_long.h'
 header
Date: Fri, 13 Mar 2026 07:20:20 +0100
Message-ID: <20260313062055.2188-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
via "cpu.h" -> "exec/cpu-defs.h". Include it explicitly otherwise
we'd get when removing the latter:

  monitor/hmp-target.h:35:5: error: type name requires a specifier or qualifier
     35 |     target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 5167d17d41d..898473b3ed0 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -28,7 +28,7 @@
 typedef struct MonitorDef MonitorDef;
 
 #ifdef COMPILING_PER_TARGET
-#include "cpu.h"
+#include "exec/target_long.h"
 struct MonitorDef {
     const char *name;
     int offset;
-- 
2.53.0


