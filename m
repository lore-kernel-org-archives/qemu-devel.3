Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0B4C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURG9-000362-UB; Thu, 18 Jul 2024 09:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURG7-0002yO-RE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:23 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURG6-0008QT-9q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso2683525e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309601; x=1721914401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mso2QJcRmduCVnkl/10ds9MgeFytW7Y36v0Ku50nZ0=;
 b=PaPA1wkTj0d5sDOJdfOnFgctZJ+Tb4hhxsioSSaYCXX5zsTnH/9CNk8JbRzBw8WFMy
 N98rQjCg+an5rKAvyNb10jQuViZkpQJ9tTMyluKsxd4b3MQoWmEa+6X/NUDOtAu59tPg
 dvqwMwUl1PbZ6y52BDB6b6E7rfkKoDejyvfnPawltuKQ82CyXEcFYrPwXhQtkzb1wvZh
 8o5l8vyGxxmWRAYDVwUYKbF/opQV8PtQHjQONhV5uCRS9jKmabeaS3fkW5P217uorvN1
 hjoyz7IMKstV4sCqnC1K4mfOpQbhZVpe7y08DVzEF3RwiyyNsCpsYX3Cw8EU/JqSEdy8
 Y6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309601; x=1721914401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mso2QJcRmduCVnkl/10ds9MgeFytW7Y36v0Ku50nZ0=;
 b=rgneGXkQditl5sfBHiSA5U37ShHkkv3SldazjN8QkeS+X0mAN//o48fM4NfqcN2nyo
 MA4Bct+3b5vvgEavacxZLCpmwqyFWC79aB6CmjUac9CkxXrVktQvroj1uZhHHNsaOkJA
 60YUHsr/d532JdrFpo5GCtQ1b9YwmB+fKuMnmYEzMfFyt9lhsGo1pUtC9VfIHZNk6hvb
 ybwQD55qOkxBd343VxkuAHtr/m7L/RrLAxjUmSH3oeHbw4kPWsUrwSxLUW/+DO4+t9O6
 Lu4pUOPExtkM8qSaR3Bg5OpOh1Y783NAe1fgtZmDfip33eHyE1hYgc4RmkKS/M2UiGDR
 FC5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG1v2BpOncexuC/0JK3pOkc99xZABVo15fQ5nhWBX0pAaPq2S0c34m1nCTNaCXU26GcbeD6DBu8nDDENq94MKah4havGY=
X-Gm-Message-State: AOJu0Yyg7ikIMAGb9DaHtb6pJwQAl77Wr/kttJnMAHc4eVkO5nVtWVUi
 AwT4XTu27k0CR67QGvr8f0z78ShZ6JSppkKe5WBHjEnL71+tM/WMy09JqQgy6m8=
X-Google-Smtp-Source: AGHT+IEm0lSwfzGmu+2MmttxmLndXLMoIqw0QB43jj3pdhTS/7SukzApPLrmw/no2x4YlVjc2RjdiQ==
X-Received: by 2002:a05:600c:314d:b0:426:616e:db8d with SMTP id
 5b1f17b1804b1-427c2ca9b13mr31097455e9.15.1721309600733; 
 Thu, 18 Jul 2024 06:33:20 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b1815esm13685285e9.13.2024.07.18.06.33.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:33:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 01/19] hw/intc/loongson_ipi: Declare QOM types using
 DEFINE_TYPES() macro
Date: Thu, 18 Jul 2024 15:32:53 +0200
Message-ID: <20240718133312.10324-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. Replace
the type_init() / type_register_static() combination.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongson_ipi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index e6a7142480..dc82caea0d 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -363,17 +363,14 @@ static void loongson_ipi_finalize(Object *obj)
     g_free(s->cpu);
 }
 
-static const TypeInfo loongson_ipi_info = {
-    .name          = TYPE_LOONGSON_IPI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongsonIPI),
-    .class_init    = loongson_ipi_class_init,
-    .instance_finalize = loongson_ipi_finalize,
+static const TypeInfo loongson_ipi_types[] = {
+    {
+        .name               = TYPE_LOONGSON_IPI,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(LoongsonIPI),
+        .class_init         = loongson_ipi_class_init,
+        .instance_finalize  = loongson_ipi_finalize,
+    }
 };
 
-static void loongson_ipi_register_types(void)
-{
-    type_register_static(&loongson_ipi_info);
-}
-
-type_init(loongson_ipi_register_types)
+DEFINE_TYPES(loongson_ipi_types)
-- 
2.41.0


