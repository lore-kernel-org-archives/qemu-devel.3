Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62964E6BF31
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 17:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlrvC-0000er-86; Fri, 30 Jan 2026 12:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlrvA-0000eV-SF
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 12:04:36 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlrv9-0001hp-EA
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 12:04:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806f3fc50bso24004925e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 09:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769792673; x=1770397473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEgcS586WoXQ1bA7kiDLx0TFML9LLxwYDy+VF81ztcM=;
 b=TfLTpYKNAxkoeXQtzxjwa8XRIWyO6BbTPunhgMq26uBwP8IrQlYz0gMkdTKBPDW9ew
 0rvN5ON4+Ofyv4/CBywjfVV/r6tiF715IKEKDLYh7CONESL0fhgm2qjpu8IrmFPO82Us
 majwxYFJ0PgO0lmXGDIfrPKqQyWdcV0k041PdNn04NqagstxmRTZ5Qft/qvhRgwxJK5U
 M8B1GVYxydFFx4bR3H3uVh4D2PmoJFTAAQLuntKJ7yKxblIDJbnBnd9lgM2ca0/B0wEA
 qMIj85ktw3X4Y0sgipMoD9QVKCP2Bm1qdLm+aPgBWaiDZSA/m4JRL85bq/07cXpg5Cr1
 P3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769792673; x=1770397473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hEgcS586WoXQ1bA7kiDLx0TFML9LLxwYDy+VF81ztcM=;
 b=uKsV3KaFSPeF7V/fllUN2YWE9n2TpgGNK2L+u5b/Fv3lwb8M7hvyBi9HOFYsoCZ5gu
 WSvrt1D7CoB6GGnvCOMrbPUryLQRIo7k8mWSvSXQirw1i5ZQlucsIa36eiqP6SwB5YKA
 +W2K+T7xCjzoVee8dbnBoiYwtVn39/QlbzHVLa4IViuUYV+FrDHErYLhV7wYc6Mu+ntI
 K695U038F4uuhbFmbvTCpHQ3NoPHG92luAiHJSW+L9RdO2rWfcgzbt2jZiLSAOMqAOjS
 AmPW/H8Spx3QS3T8Rpb1kTCrvq/+xqECfkR0Pcaqgikptetw3yxUwt9mNXlGb0xUYe1K
 4hdA==
X-Gm-Message-State: AOJu0Yx0i8FjInUD3QRIr7Lk72ZGskEDPe7aGqnKJuqUlNxsiks+q9mV
 vK8sBtbhdZXG1ZHZpnViSa7fvyGbK/XXPqsDEkdh7hjNBT8vqy54P6L8iYb+luiwa4qhQLuY49J
 COuPYXX0=
X-Gm-Gg: AZuq6aK9/YyzT97lYBhaQe/WyzmVyzRTdaXE72ULt5zd2TlYkUVoaKSg1Kkg66m8uXR
 ZyeEv8MUJlbDyG8TlFDCsa7mVt+/p9HagROJnQO78o3mwOqQWtsan5ZjRFarx2S5lhAZErJOtlX
 hoHKJjxvm2a0rxc4wE8YRLd17TTIV/3ipuasvkO9PInuWWzUWxccMMHyiR0JtmT382sdPtfVWLK
 HZLFoJ42x+PZTjzyJ8q2PVj8dgy7ZWctCxz+lmjSVw8h1pk8j2mPv0U7g50kqTy4SCuB+30gGxm
 IZ7NbmOJ+qpUCyMpKtSg1uY9tKPmT+bjLLwgs47FoBqG8cDeJWvckcX4B4sZNaOFQED8goU3WOw
 dJgVuPcpsoTD484bQs7TZHgtkAI3bp51CHvr/b5eaYSg0wBEW+8gGhkmfXnhpDvBNno06KpgXgD
 I7kfn3MZFLPzy2c+5Pg8opuvrNK1cUhUUEXJNyBUVYcijzDmExmu2zX97Vsv6q
X-Received: by 2002:a05:600c:4e87:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-482db46557cmr41828305e9.12.1769792673568; 
 Fri, 30 Jan 2026 09:04:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bee687sm414400655e9.5.2026.01.30.09.04.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Jan 2026 09:04:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Will Hollins <whollins@google.com>, jpcottin@google.com, jansene@google.com
Subject: [PATCH 2/2] docs/devel: Mention enum typedefs forward-declaration is
 not allowed
Date: Fri, 30 Jan 2026 18:04:17 +0100
Message-ID: <20260130170417.43356-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130170417.43356-1-philmd@linaro.org>
References: <20260130170417.43356-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Do not allow enum typedef forward-declaration to comply with C99
standard chapter §6.7.2.2 point 4:

  Each enumerated type shall be compatible with char, a signed
  integer type, or an unsigned integer type. The choice of type
  is implementation-defined, but shall be capable of representing
  the values of all the members of the enumeration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/style.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 12e509d10de..5ab5c21447d 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -416,6 +416,17 @@ definitions instead of typedefs in headers and function prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
 
+Enumeration (enum) type can not be forward declared as typedef, because
+C compilers should be able to know the size of enums before hand. Simply
+define the typedef along with the enum:
+
+.. code-block:: c
+
+    typedef enum MyEnum {
+        FOO,
+        BAR,
+    } MyEnum;
+
 Bitfields
 ---------
 
-- 
2.52.0


