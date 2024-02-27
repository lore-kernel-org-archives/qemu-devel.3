Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7568DC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaz-00015y-Nn; Tue, 27 Feb 2024 08:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexab-0000pj-F1
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:47 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaT-0002vE-HV
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:43 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d23a22233fso43646371fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040814; x=1709645614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SKp/LXSTlCcUFFla4fnBLkH5V/PUv+zdz1N55mPonwQ=;
 b=wqlLyFiW33rsU4Wr+ERhwP67WlCsqMzpIcF3jGYh7uB2MU0OXgXBUwYqMbUUHgdmZi
 JyebwHcmYYUAMVOFg6W4ubL+GOVQazYuaBXwJ5hPYtOtcvp5E48EKnAnz+NXAeOJFa8y
 x5uyg4DClgWquHAg4Digpus3XlshEp5OA7s2dYNb0bvfJ+h6hgVRBZAz9u91YBSpkHQk
 Tgxr5iAMqow4p7IMim4YlYsEqsDfdsl+Y4X1/cJ1B9X77hmrLV1ZZntj2oWY0ZzEQ3mR
 upJldmuiKV9NLqD2S4KcHGiW4EIW3/UT49xkHTQySLnYkrBQHv1wZUt6uF48jv9HquQS
 2X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040814; x=1709645614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKp/LXSTlCcUFFla4fnBLkH5V/PUv+zdz1N55mPonwQ=;
 b=mrqCq+XU6Ph/MctaKubBZJNLATZ+9e4AoLbD94xoy6J/gVoASBz7QfoII3Pyenw8Vd
 lJjku6ByGJFK6d6fD8Vv/JPCIbalJ3v7tfRCwgnzExMN/uhLvGnTIzt5vXNeBhyKZvrg
 ErLroOuvya6QA5/4CR68G7H7HOXBIF+49UbZpf9Cf3nUEffYkZs5HsVdbYuWa4rcgxfl
 K09dam0COSG8BvxReFeiRLWrQevGxnx+X1Ojw0JRyVbJjjx/UGtBv9HhTL/S7hcfg+Mo
 8fwyDx6QoEM0Nx9LRolgrRB3ne0IY5XJiUgT5Lagn+xoTxoefiEXx+LMHxyw8emOnUyn
 8Hvw==
X-Gm-Message-State: AOJu0YyhJci1Ome7LAaPSNw0MMzuOl9DblJbkTzugn1A2uJBNZ/mIOuF
 Tt9P9sGp4DwCbzMqoTvLlQTRo9J9K/1ezt0p45scgQHY44TzRq4bVS+ce5HiusELJy50tB78nWy
 6
X-Google-Smtp-Source: AGHT+IFS0FaZz74IrGghf9OXDs+mog/IGeBpIeb4WESp9TdcosBxsrRPPmWaD3DZXHkAxewjClB/fQ==
X-Received: by 2002:a05:651c:508:b0:2d2:45e0:f154 with SMTP id
 o8-20020a05651c050800b002d245e0f154mr7130141ljp.26.1709040814450; 
 Tue, 27 Feb 2024 05:33:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/45] tests/qtest/bcm2828-mailbox: Add mailbox tests tags.
 Part 1
Date: Tue, 27 Feb 2024 13:33:06 +0000
Message-Id: <20240227133314.1721857-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Message-id: 20240226000259.2752893-34-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bcm2838-mailbox.h | 177 ++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index 9222b38bad7..1360fbb8cf4 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -116,6 +116,183 @@ typedef struct {                                                        \
     };                                                                  \
 } TypeName
 
+DECLARE_TAG_TYPE(TAG_GET_FIRMWARE_REVISION_t,
+    struct {},
+    struct {
+        uint32_t revision;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_FIRMWARE_VARIANT_t,
+    struct {},
+    struct {
+        uint32_t variant;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_BOARD_REVISION_t,
+    struct {},
+    struct {
+        uint32_t revision;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_ARM_MEMORY_t,
+    struct {},
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_VC_MEMORY_t,
+    struct {},
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_POWER_STATE_t,
+    struct {
+        uint32_t device_id;
+        uint32_t cmd;
+    },
+    struct {
+        uint32_t device_id;
+        uint32_t cmd;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCK_STATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t cmd;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MAX_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MIN_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCKS_t,
+    struct {},
+    struct {
+        uint32_t root_clock;
+        uint32_t arm_clock;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_TEMPERATURE_t,
+    struct {
+        uint32_t temperature_id;
+    },
+    struct {
+        uint32_t temperature_id;
+        uint32_t temperature;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MAX_TEMPERATURE_t,
+    struct {
+        uint32_t temperature_id;
+    },
+    struct {
+        uint32_t temperature_id;
+        uint32_t temperature;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_ALLOCATE_t,
+    struct {
+        uint32_t alignment;
+    },
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_RELEASE_t,
+    struct {},
+    struct {});
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_BLANK_t,
+    struct {
+        uint32_t on;
+    },
+    struct {
+        uint32_t on;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_PHYSICAL_WIDTH_HEIGHT_t,
+    struct {},
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_TEST_PHYSICAL_WIDTH_HEIGHT_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_PHYSICAL_WIDTH_HEIGHT_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_GET_VIRTUAL_WIDTH_HEIGHT_t,
+    struct {},
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_TEST_VIRTUAL_WIDTH_HEIGHT_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
 
 int mbox0_has_data(void);
 void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
-- 
2.34.1


