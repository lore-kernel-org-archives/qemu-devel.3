Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C61ECCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 09:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI0Wb-0004Or-8f; Sat, 17 Oct 2026 05:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1xI0WM-0004Mc-LZ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 05:16:09 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinja.p.jankovic@gmail.com>)
 id 1xI0WJ-0001fq-OJ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 05:16:06 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3ab27b4924aso3863841fa.2
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 02:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792228561; x=1792833361; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2PJr6/o4UWvxEIOosKJE71cINqojrzw0er7aFPFz+ZE=;
 b=R+0vRTObgwaS1PJb5sH683arsqGXBY3iLxgYrjjL+99wRmfwvqUcp1b8DIICfcBBI3
 SijWw/Kba33QhcYxg4UIVx96xInh2UilX6gMImQftrxJCDG1d0TITThcv8YJ0G0GojJc
 n/6+54OVoPIbBCi/peZGtWv5iKiF1CJ8iGxcHPt8275k+vO3at3iiYqc8zexPbmTDS+g
 MNTOe0sk2FdTuNveMrCEFG3tGO7mnrzzIQtS7wqZwTgc5Y+tMjwPE1mAikkNhECiQeGN
 rXwLX7lJ7zFMmKN12n3ntU1y4ceXfU5G8aVPEydm/BpZ38pZEaD8cjq4F5Kx3QI49Rg7
 pmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792228561; x=1792833361;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2PJr6/o4UWvxEIOosKJE71cINqojrzw0er7aFPFz+ZE=;
 b=pdmixKj61AdLHbYQodyX7xOdDcNt4SqwIT1Wp22QBPHclhcQn2CR3hXBqdM0pC3Nk/
 3EiZZxkIcVYU4OZ6pRPSYeGa5IF93cbX3yPNmrOF6v+Fzcn7vHhxnsagXQxunHZf6duu
 qGIUwWL6aYQrUkF1f4IybW2qpoLjgBQrnCaMOco673E/2mWvMymsU2QGu9hEfX+BRZ9L
 cc1lcUM0+tdbSGuDuaGRTlIG5VTKlZU+Bfdp52HInb54wwqchj18hXaNWYhQioDD0Xa/
 dJ9DRmQQu1EKnWdfzREO/Lxc354/vATXq2SXnwEaz1cTIs2Ysl9A1kgjtW9KTs//JhgB
 AYWw==
X-Gm-Message-State: AFq9FYIkN0A/RXHgHpienKSRh3yxcv5yJVL1MjklO8yCXqPocfOH2QxN
 Bpg5jgfMF3IfoBtjPydlNqjJNcArsqH0QaAyppSDxSnNWnZfnKnobRLJ
X-Gm-Gg: AYBFou3qDpm2+GpPF6xI7QcmBy6Jdgt4elFVDiEOO5nILARHClP4aBQ/+S3Pn0kqHbS
 WmoRZKWWZj83+IUey38/S47tfEtj1EOVJ++1subdzi8TAYlWFkGPFSdS87lJXxzD6g23BBqbLsN
 9g0dLaUffOSTMsBoREuf11rjc9gGKQkt67o/INnrs9sj1xCDy46anBqOO8jirlUkGnQVa2R4OPZ
 bWRlIj8sTpdxgX6NuJfDEvO1v5LyCrGWmnxuinzwq89zLg+6V0UvtffvLszrlOqiXRuKmdXvx68
 eNG6JgOCsa+mUr3K5BV1b94cnjlhhtIM5t10NG//mgsNqaLpjb4+JouYKC71d+x+tvCBw5pS5Ub
 mWFc+/DWMvXO/6OhSoqsgqRtCxhowQHmzOfwnGzyk2vnBRcf0TCATfu9ofzl/r5K5Gb34XP4pj0
 rSqqifQlxfmx6ocpe54hiP4GA/8IxW9wRJoJdDYaBxVcY8xdMXIKMq7tCbPo2Ekvzu/de+hel7q
 dhTzYodxFu34v98DgrSSpItvnXsC4ElKVItuZ5UgkCF/AeRbR0BFy2FylD0CF82HriVOA==
X-Received: by 2002:a05:651c:1986:b0:39c:7d57:a3ae with SMTP id
 38308e7fff4ca-3ab28e5b213mr5423131fa.0.1792228561305; 
 Sat, 17 Oct 2026 02:16:01 -0700 (PDT)
Received: from [192.168.31.141] (213-65-111-204-no600.tbcn.telia.com.
 [213.65.111.204]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be4a633f54sm853132e87.60.2026.10.17.02.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 02:16:00 -0700 (PDT)
From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Date: Sat, 17 Oct 2026 11:15:33 +0200
Subject: [PATCH v2 2/2] tests/qtest: Add Allwinner GPIO input test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-allwinner-gpio-eint-v2-2-82906f440378@gmail.com>
References: <20261017-allwinner-gpio-eint-v2-0-82906f440378@gmail.com>
In-Reply-To: <20261017-allwinner-gpio-eint-v2-0-82906f440378@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=strahinja.p.jankovic@gmail.com; helo=mail-lj1-x22a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add test that configures pin to input mode and validates that
manipulating input pin changed value in DAT register.
This was previously tested in the interrupt handling tests, but now is
moved into a separate test.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 tests/qtest/allwinner-gpio-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/qtest/allwinner-gpio-test.c b/tests/qtest/allwinner-gpio-test.c
index 7ad89f6e0a..5c4a148d82 100644
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
2.56.0


