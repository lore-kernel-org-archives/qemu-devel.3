Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BA606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HbhWJ8Ew
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3O-0003Qk-6w; Fri, 23 Oct 2026 10:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3E-0003Hg-7H
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3C-0006ZW-IT
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4956869750eso6217825e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764917; x=1793369717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eT7TDgXjgLoljYrQVDKrZCt0fwTrjLIYNVy0Cb6zcuU=;
 b=HbhWJ8EwAlWfrO51cLuogZ8x7aiNUEguiIX91iwLCnhoPyEheP5m3FB7n/3k8ltBdq
 hr0rTpZx2Wn68qeUs9lMOm5e4vPjy/MJwVYSIyZZLcbZ10RVKmcsD1yORh6wGzG14Lvd
 79jbdUd5YBT4szgI5GfA84nJecEKGyl/VAx5x9cj5cx+XAwKTI8xtTNz4jSmOY34Ewwl
 3GJgrjzFzC8v7C6DgPn1sSNlqfXJhU7SptLBmpRovRDkzCmsxQpq8nPp8j94nDKETl++
 P0DptaUPf7/AphCiuv69l0WPxgc9zPJ6hhRkhK4NSM+5ADH8pCUHNedpnFJvTfaBiemL
 ZaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764917; x=1793369717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eT7TDgXjgLoljYrQVDKrZCt0fwTrjLIYNVy0Cb6zcuU=;
 b=JreNw3QoKIMIxQ71g8Z2YhCqGcjqgZAohdm4QZcHVsGlh1cg86E+6bNFRVUwR9yQrT
 Rtsljb3K8xQTKvIrVlYQTVXzSjIKpcRp4eI1+RZuAjFt05KAg6TT081iSBIXob2tf9y6
 J+opC8TaD9YuplI+loIr536LMroi8ZLN5GSKGCFElJAqjGgr2jperwzhU2enmFO56e5S
 QF7aESpR60f2xH7WpZlzET8Y90MJQbRl8GJwVbJiPVVe13irVzYhCEJBLtMcBNwLlARL
 xDIGWwOIXB06nWylMq5RgQvy9RuIDVYjQEfeZrzJnX2R0WwkTPsMvMYUMv2ID9DPcN9V
 eHQA==
X-Gm-Message-State: AFq9FYLLJsDVEjqAFsQ0tVVLaHg4hw1UHlfMHvT1uLawrGfbSw1sQR7Y
 imr8mEghJZkS48U3xM23gTNUrgf4qYaodQ+zynd4XqOVGG5N1H0PSPCS3Po7f3PbOIl1QQ5Vg5y
 czHD6zts=
X-Gm-Gg: AYBFou3Pp31ZN4mXRH7QWbVo08P/bjbaDo/du8UrrCPTwmtJ8/dO0M4tVAw77Jc4Ta0
 mDgyNzEmY3GEAkzqRuyN++5eSp0DPELwh99YQL8H1NTr9wp40bI57QMZU6zP8jBxOZKnsUpp+I6
 5927VT1/PznRgN/K+zsp8yuL0o0Fk+rOxbj2b2+JjAmCgkiiG/ioYOmE9iWHZOWkXLxBdDvsJ/P
 Ibpkc0V3IB9A9THggQKRRGOIJCVRWMEnkBbHk271kgdyu/hdZIa+PPii5YHywVcQO3X5c/m9vsn
 QVTHjmbt7tWMNEQgK7H+WM5AxLlU3i61TjI9otcxmGmyCItRrsquB7+3MMpWpZlGupT5FZfmGuU
 srnvCWRlcyNsP1D/v7/JBpqpIv7hC1C6nN4BdA+98kEClWwUZElFDBswprzGV1cp3xMVEMMjEyF
 Cp+hf6q1qoN5nDU7dkM5ZDUjjFcbbCGFh5Kj9awr269iP/+PNieQq5GNYA9ZaCNlgN+YpB3rB3o
 TAZvbYRb5no7k3RnAihMtO32PIKfq16+EauG9x1/KoYAjnMfYMP9xD5nSDV8aImNYsK/UwoXIs5
 UuwqCt2cJ5xCbEAMlEXP5Y8uOYMQHbtnfBylDaCOWECw+POWGwNb/krAN9g45xOJPnEQl/9jCf4
 hvrJUWw==
X-Received: by 2002:a05:600c:3111:b0:4a2:1a:a128 with SMTP id
 5b1f17b1804b1-4a211ed7ec2mr40973595e9.19.1792764916570; 
 Fri, 23 Oct 2026 07:15:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] tests/qtest: Add Allwinner GPIO input test
Date: Fri, 23 Oct 2026 15:14:54 +0100
Message-ID: <20261023141503.1397009-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>

Add test that configures pin to input mode and validates that
manipulating input pin changed value in DAT register.
This was previously tested in the interrupt handling tests, but now is
moved into a separate test.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Message-id: 20261017-allwinner-gpio-eint-v2-2-82906f440378@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/allwinner-gpio-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/qtest/allwinner-gpio-test.c b/tests/qtest/allwinner-gpio-test.c
index 7ad89f6e0a3..5c4a148d822 100644
--- a/tests/qtest/allwinner-gpio-test.c
+++ b/tests/qtest/allwinner-gpio-test.c
@@ -238,6 +238,32 @@ static void test_set_input_pins(const void *data)
     qtest_quit(s);
 }
 
+/*
+ * Set pin to input, check that the value is written to DAT register
+ */
+static void test_get_input_pins(const void *data)
+{
+    PortPinTestParam *param = (PortPinTestParam *)data;
+    g_autofree char *in_name = portname_in(param->port);
+
+    QTestState *s = qtest_init("-machine cubieboard");
+
+    /* Configure pin as input */
+    update_cfg_reg(s, param->port, param->pin, AW_GPIO_CFG_IN);
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, param->pin,
+                     AW_GPIO_LEVEL_LOW);
+    assert_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_LOW);
+
+    /* Change input value */
+    qtest_set_irq_in(s,
+                     "/machine/soc/gpio", in_name, param->pin,
+                     AW_GPIO_LEVEL_HIGH);
+    assert_data_reg(s, param->port, param->pin, AW_GPIO_LEVEL_HIGH);
+
+    qtest_quit(s);
+}
+
 /* Test rising edge interrupt */
 static void test_irq_pin_rising(const void *data)
 {
@@ -518,6 +544,7 @@ int main(int argc, char **argv)
         const PortPinTestParam *p = &in_out_test_parameters[i];
         add_test("set_output_pins", p, test_set_output_pins);
         add_test("set_input_pins", p, test_set_input_pins);
+        add_test("get_input_pins", p, test_get_input_pins);
     }
     qtest_add_func("/allwinner-cubieboard/gpio/reset_values",
                         test_reset_values);
-- 
2.43.0


