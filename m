Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69F1FCB611
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWf0-0004R9-SS; Fri, 06 Mar 2026 10:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWey-0004Kh-BX
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:12 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWew-0002j1-LZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:11 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439c5b40f60so2779163f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809209; x=1773414009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g66N5rRkLXpQRozpgeaSX2aSBSYfnGWNWHDlSt3lUl0=;
 b=bIZvt+IiyAbVjACWV3MimKfd5UhFGfvmTq7FS1EvPUy6FpLADqcL4fq8oabM6xHoqO
 0bqyfcqSHrs+yL+aDq2elXj4jgtl5XFCCt17+pRjZKX0vxW86RQL/1hKfrAzmUlcqhYa
 O6cNuk46PoXzv+H1gNg2XdHzq7pmepLShzRuQtX2nbZnDiy/d+R6J8CyEWhsCAllumL6
 GkDyjkc5UsxJair6U7WZ9EloAAtjudpZOuZsjpjkSYbbtOmXxZFvel6Ph8lV42W45BCi
 AoRGYiYWYpBQSrleR7ylSehrZlS5UV5biYTTU1VphmIxf7Ko8ErAIaFXSUdNMYeofYFs
 vnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809209; x=1773414009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g66N5rRkLXpQRozpgeaSX2aSBSYfnGWNWHDlSt3lUl0=;
 b=B4EU0/8ZWqlYY4vTBtnqt1huup2TuHVbkx0qa4nEv76zGgmFVx6h6d7W/15/gLusk2
 w+11ZwGA22DYkiVMaK1WQdHj+ESzZh85AiKOCCeH/6apehfqhfG9PT14I/Wor9Bm1Z+V
 vz8rpTTViRn9irBBrlQB8OprLaNE4UJ9WudKLG3fNz33IK8iyal4JEfbehBv/Fc7SAAj
 Z6lKae+63jRdDxu+kjx+8qK/Akf1XL+3ywVo2go7iF68JlpLI6twWWfvzNqTFEJ1QEU/
 wF14NX0IM+S0tyg/Qpj0eTlJxPkyqtSZQv87EgJGWi2mNpBepwBZ3JMXHzwCHLciRl9/
 tgTg==
X-Gm-Message-State: AOJu0YyX48bMXLa40XW7UDvK8NCi4dPOS26wwkRBZFlcdN6k3cqURr4j
 3vpzBU4xDOQr+eQhp0tLtiskF/i3WZ1jk/t8iriT8zgqPmM3RUSBe2yDI39WHMDKvyQ6vaQfwJN
 F3dDs
X-Gm-Gg: ATEYQzxd/BLy6vthyrvVNwreRW7q/QtnhcdpmrfPiYtrToF1ysuALPFtZORTmKNvu2t
 Le4DdFeg17m+GdFEUb7r0IFKg/6s98BR/hwPa3YZ9QyPCrT7frL8+uMNmXCa0yjzfK3E6cMoKsX
 qStfxd8kORuRzLsDqWsklef4EsOPam+9m0zpbLkPWfclPUhuYmotLt+szCccJV7m4+HX+8p/HBd
 U9NGE8R/uOnhdKQBk9CtkO5XfsznoCVpgS5bCLFmP4lZc4NQzR4yymIq7oVtL7NxmQ50SR7EZBN
 FhFPSPMN0IZkqiBES61AU6565VabnKdRrplL9tTxqvAC/Uam/+MkpRGyZ7sXzNGlM6IrirqvZNK
 KSpuJ1xnzuedvUr3V0gr/Bt11CTgrU2b40lVxhSFfBacIWPx3my1sxvaMbTfr7Uzj5547d8C702
 G8bHBcb3CAlaDhJWjV2H6gejlb3SJo8JXLJV91JdZPqshgB2tnuWPksoQKdp7t1vujK8tpPUfYi
 HoRdBsVrn0amiOo2dbwE8+1WUhi+O8=
X-Received: by 2002:a05:600c:a12:b0:483:badb:618f with SMTP id
 5b1f17b1804b1-48526966b07mr37639405e9.25.1772809208984; 
 Fri, 06 Mar 2026 07:00:08 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/49] tests/qtest/test-x86-cpuid-compat: Free allocated memory
Date: Fri,  6 Mar 2026 14:59:18 +0000
Message-ID: <20260306145939.2162189-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Fabiano Rosas <farosas@suse.de>

Free the test arguments after test execution.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260302092225.4088227-9-peter.maydell@linaro.org
---
 tests/qtest/test-x86-cpuid-compat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index c534e764f8..be67631a85 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -65,6 +65,8 @@ static void test_cpuid_prop(const void *data)
 
     qobject_unref(value);
     g_free(path);
+    g_free((void *)args->cmdline);
+    g_free((void *)data);
 }
 
 static void add_cpuid_test(const char *name, const char *cpu,
@@ -161,6 +163,8 @@ static void test_feature_flag(const void *data)
     qobject_unref(present);
     qobject_unref(filtered);
     g_free(path);
+    g_free((void *)args->cmdline);
+    g_free((void *)data);
 }
 
 /*
-- 
2.43.0


