Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA338CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRYD-0002Mv-Hm; Tue, 19 May 2026 17:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPRYA-0002Jp-V1
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:00:27 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPRY9-0000l5-9k
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:00:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490229aa522so8333365e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779224422; x=1779829222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h1XCaBoDKeJcEcRyhzaDEIrQxeXjPCQqGsRlSIc7RYo=;
 b=MUzuH5uAVxA3pttQVP7sDWbO9E6JSCa6PcieyXKqwzptJkAEqY+4vFUAb9zd3m6Ty2
 wQUkG/00TOMDK7TDc9HSEbt/4Id1KZQLjDKD070hJ97BzQOspaZ6qZkgN845ZR+zvYsg
 pcYgv0Vmenp+XtQtzvcd1nQA65/J/qu8ADe8LOzTUovvtsMjGEmrePysT4jitW0moiwC
 TN4NurNcEAj2yMmRnuuJTCyxWQQGoi8nK7edLkSTSXAgM39s7d44xf5XjvcFkWe6PGuG
 gzNR938koscABRB+5U19etDoDoB7lUNlMuazVtrklR4XFjTxNAuMG9z8sDILuW6PZbU9
 dv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779224422; x=1779829222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1XCaBoDKeJcEcRyhzaDEIrQxeXjPCQqGsRlSIc7RYo=;
 b=psnk0wi5jxLDQESeFZzRZiOwKbygnh5eXBoiLIJxfGh1+WcEaCLpC2EE/IPV3PSz1h
 3tv8kqlEaCGAgs8UvQoIFft8OnW9u3VzkZdksVWqyg+ZR+UWevgOhhjgXUftZJHP5mcV
 b8Bap+0rCLcr1QUYn1W8XZ8YlxtDg5ncAWkuEwPavTW4lMnJr4YL3H0jAMR/nJXLFQSY
 sywlRl7mdp7ssfsHk2p4Lu/eHfYvsYqCBSbOQUcaOVccQewpvDtzugbMex/txkW5J0SF
 JXoJBQJbjVwEAGxZBf/hHMdMH2A4Ky6DrkiLrgqcLpX/0D8/5LearuBzcw5LRBthPx3t
 YRcw==
X-Gm-Message-State: AOJu0YyPZnma5qRvqysT1zCakj3UEt9TToY8jxc9EDE0YLr3MwCzTzd9
 y7HkOzYp7W34EyjjdfUJ/nZ4C2ucPaPB2e25Y2m07myZfrKxdKwBYksP4ep9DqzhE7vywZdBS7c
 8C6zfaj4=
X-Gm-Gg: Acq92OHvDRNK3kmbykcpy2q7prgqfyTBCx5O8HqJPKOcowXv6x4cpZcgKpd4lexrKqu
 waPn6/RqeiBTyYbvqQnrIm3NQOm8o0AU+ywuex4EJIOevvI9Lr1V6zNMx2VbqzilSEOu8oN/cQU
 U4QIFsOEJYXjA3+zqT+Vuh2Q3KU4PthrTkfThpCdXVI/BXLy7czylOREexBVFyYHMND/XHRR0qv
 HNgkNI5HEAM35M/hC4f1T296Kt1xFzBam9na3W9x9vIKlWqsG6S3z+FKHRccu+lVBv0sDQS2ceI
 ivtGvT+oCBmb5jl88uUoJlD5atkf/wqGTszWpYDozouXpBW2rS1BCzKc1DAeNexa3IeyHEApLj/
 KzQddUJnxxAO8mviKhSwJcf+eN5NvmTtLtNSUboXqFF4ENCpZtIaDJQeYs1ubPJqby9Mn8t4NQl
 gevUpOzTVsVScnEKvKcFeNwPHg/HTb019RnBZ0QTVUoEDkl51FT3QjYqSBQGPSSLNZFwlVTnxJC
 r2O/ae3c2A=
X-Received: by 2002:a05:600c:450e:b0:490:778:4fe3 with SMTP id
 5b1f17b1804b1-49007785042mr187964115e9.32.1779224421711; 
 Tue, 19 May 2026 14:00:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab52a6sm347815195e9.10.2026.05.19.14.00.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 14:00:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] docs/devel/tcg-ops: Fix reStructuredText format
Date: Tue, 19 May 2026 23:00:19 +0200
Message-ID: <20260519210019.11665-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In the standard reStructuredText inline markup, italic
text is surrounded by one asterisk.

Fix incomplete style from commits 5e97a28a8b9 ("tcg: convert
tcg/README to rst") and 76f42780292 ("tcg: Add add/sub with
carry opcodes and infrastructure").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 1ac53a61114..c8239d5c3cf 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -563,9 +563,9 @@ Load/Store
 
        ld16u_i32/i64 *t0*, *t1*, *offset*
 
-       ld32s_i64 t0, *t1*, *offset*
+       ld32s_i64 *t0*, *t1*, *offset*
 
-       ld32u_i64 t0, *t1*, *offset*
+       ld32u_i64 *t0*, *t1*, *offset*
 
      - | *t0* = read(*t1* + *offset*)
        |
@@ -598,19 +598,19 @@ Multiword arithmetic support
      - | Compute *t0* = *t1* + *t2* and in addition output to the
          carry bit provided by the host architecture.
 
-   * - addci *t0, *t1*, *t2*
+   * - addci *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* + *t2* + *C*, where *C* is the
          input carry bit provided by the host architecture.
          The output carry bit need not be computed.
 
-   * - addcio *t0, *t1*, *t2*
+   * - addcio *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* + *t2* + *C*, where *C* is the
          input carry bit provided by the host architecture,
          and also compute the output carry bit.
 
-   * - addc1o *t0, *t1*, *t2*
+   * - addc1o *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* + *t2* + 1, and in addition output to the
          carry bit provided by the host architecture.  This is akin to
@@ -630,19 +630,19 @@ Multiword arithmetic support
          identical to the borrow bit.  Thus the addc\* and subb\*
          opcodes must not be mixed.
 
-   * - subbi *t0, *t1*, *t2*
+   * - subbi *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* - *t2* - *B*, where *B* is the
          input borrow bit provided by the host architecture.
          The output borrow bit need not be computed.
 
-   * - subbio *t0, *t1*, *t2*
+   * - subbio *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* - *t2* - *B*, where *B* is the
          input borrow bit provided by the host architecture,
          and also compute the output borrow bit.
 
-   * - subb1o *t0, *t1*, *t2*
+   * - subb1o *t0*, *t1*, *t2*
 
      - | Compute *t0* = *t1* - *t2* - 1, and in addition output to the
          borrow bit provided by the host architecture.  This is akin to
-- 
2.53.0


