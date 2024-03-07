Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87767C54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4M9-0001TI-22; Wed, 06 Mar 2024 22:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M7-0001Sg-IE
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:39 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M6-0005hm-0H
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:39 -0500
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7c854657e13so14091839f.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709781816; x=1710386616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8J7F2iE5kae+EJMR1Fj9GxIukzXTHmw7zGOIwbFMQA=;
 b=EcW9R5QXgou9pHN1RapdTvVvwCe4gJVkTz1/bSArUzXD7n0zvlTea9RQw27L1ecCK7
 PjKt4Vt8W7+XIAfBpzCX6ICi6jPr4hxqwIgClwE23FEvhPDZhHahBXiPZVK7QetwWUVT
 UqFZ3JBh8wdiP3n+XC30KhkBsBR5xo9qcqo7sVg+t3VVIRkXJ1X+niSEPea+SE9dfOzk
 mfw/QX6GHzTXiuhGgUrGe9SS6p/idQmdqo/4xIUZpBX+re6OMWzB4+TV7X1lj1U7GETC
 uMj0dVOF83duHzh+faAbxP8RzBnRz/Ug1qfSq85/3gmQYml+KTx/SPAl2XkchzBD6QGm
 nBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709781816; x=1710386616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8J7F2iE5kae+EJMR1Fj9GxIukzXTHmw7zGOIwbFMQA=;
 b=TGNLVo9ZQc+xdpYCwoAcjsCJEG0wO5ZZ2XQsbtSru9HbWU8VdwR8SkKK8rGyD2eDcj
 SsLSTa3mPnIjbD8kuoPOXgwTbjbPW/GWrG10LKbKLTiScDeL0AsbJfbevW5wIZDFeLl5
 lml2b4V1f87GcYOheJ3RI4s2rsFcnThaTOr/guwOLQpzimBI/0wUJQqT3T5+Ikcxr+FJ
 Vbo6+8yo9GLWWmzd15rMEbSbVE3YZK17emHDVm9KNcCutgGXzOcpx0Mn6syfmOtYi6EC
 TdGqhlUmTzlC4tyGOyXifwErE+cnWcQ8qPaMWSXfpA9bg/0rn48MSsP7/zLN5wI3TPD+
 qxdQ==
X-Gm-Message-State: AOJu0YySwt9gE96VlPw+BDeLQflMymPls2miYR/laJkLyS7Kyu08bPNU
 02of91dgyhARjFf40Hjmj8zHPBgFyPUyFcV/EQhrDUxb5pSCbJwF7qf7K9+vGTU=
X-Google-Smtp-Source: AGHT+IFVLFsJc1YIjFalWPIg9rQtwl05NIVY2omMQMLo1ujfua9AlRO2S66kn9N5ZKMIJ5zspooy6A==
X-Received: by 2002:a05:6602:1604:b0:7c8:65af:20ce with SMTP id
 x4-20020a056602160400b007c865af20cemr10157674iow.15.1709781816211; 
 Wed, 06 Mar 2024 19:23:36 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a02c734000000b00474e9a77424sm2233990jao.147.2024.03.06.19.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:23:35 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 5/9] Hexagon (tests/tcg/hexagon) Test HVX .new read from
 high half of pair
Date: Wed,  6 Mar 2024 20:23:23 -0700
Message-Id: <20240307032327.4799-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Make sure the decoding of HVX .new is correctly handling this case

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 tests/tcg/hexagon/hvx_misc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/hexagon/hvx_misc.c b/tests/tcg/hexagon/hvx_misc.c
index b45170acd1..1fe14b5158 100644
--- a/tests/tcg/hexagon/hvx_misc.c
+++ b/tests/tcg/hexagon/hvx_misc.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2021-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2021-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -231,6 +231,7 @@ static void test_masked_store(bool invert)
 static void test_new_value_store(void)
 {
     void *p0 = buffer0;
+    void *p1 = buffer1;
     void *pout = output;
 
     asm("{\n\t"
@@ -242,6 +243,19 @@ static void test_new_value_store(void)
     expect[0] = buffer0[0];
 
     check_output_w(__LINE__, 1);
+
+    /* Test the .new read from the high half of a pair */
+    asm("v7 = vmem(%0 + #0)\n\t"
+        "v12 = vmem(%1 + #0)\n\t"
+        "{\n\t"
+        "    v5:4 = vcombine(v12, v7)\n\t"
+        "    vmem(%2 + #0) = v5.new\n\t"
+        "}\n\t"
+        : : "r"(p0), "r"(p1), "r"(pout) : "v4", "v5", "v7", "v12", "memory");
+
+    expect[0] = buffer1[0];
+
+    check_output_w(__LINE__, 1);
 }
 
 static void test_max_temps()
-- 
2.34.1


