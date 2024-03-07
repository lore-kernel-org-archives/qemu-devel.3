Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527B3C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 03:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri4M5-0001Rl-As; Wed, 06 Mar 2024 22:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M3-0001R1-Ck
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:35 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ri4M1-0005fP-I9
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 22:23:35 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-365aff1fa8dso895825ab.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 19:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709781811; x=1710386611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3teDd8HDxktJH46jy4fSC2tTIGKstCq77/p/rg3zPo=;
 b=UE9/Be2Cw0BGRFW4Eozngb/VeaFDGKiOjoT4Tgw4vMx+QDGESHgLS1rVL8xbdR5BQ3
 wLRnW3d8lYh2IG75h6Z+lvjOHAvEzETXesd8ngSHReIUz4C7B/KQrIYkTlKwcZi5BlQd
 iKHisCHnae1B96f5mZ/lJuQD7QgXMECPcVILsCsEYPx9oVkjsM96g+QlA/yiYg0S8djb
 rQhjYek5cjrKTNCBPmmTnIjNsXKcKc9THLxmfrgxXhm0rW0qhVYiSmNaysKd3Ze/+Q6x
 WkS3cFxHv8BxiMpZpE6XoZjyf907r899HAkZGtrHZ1eQ5niike4WgjwOIm+THWotUx84
 J/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709781811; x=1710386611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3teDd8HDxktJH46jy4fSC2tTIGKstCq77/p/rg3zPo=;
 b=wkquRnr8g0TcQnwa1YJVEPN75FGUlcZ2pG6NpP2sHMC/txA+yYuvIv4bD9SNcsyQKi
 nJgVnqZdmnrwC7GCuZyG0OmWhMFBfzPTzcq5M2QqmdwvXXPXDRr+VATLSErMSW52WBQE
 CmThvkcDw+uYlE1VI5CwQmpwNtsQ0gJsq5/qMgNyIS4suFrlR2g3kDavRv1t+s12a/ji
 G/HMe55E3HtvgO3CHvvRABqITbE/cbE7w2QCkPyETcGjJAL9HKbH6ed88GA9Bn+VGSNh
 JQ2Zxj5+YmDO3AHczpvoqQOKA3l6fGJp9hZT0D6LgnhBfVO1e/ZdBO+G7mpOjThGpCBH
 FtZg==
X-Gm-Message-State: AOJu0YzTU+gzI+ogbokEGJMxWQqJgmuWxpJXW5w/x0l74yu2RcRbb+fF
 JNANGKFBUokT177hVSQNpC3DeOnSjABhqCYIfomaosnSZVd4naSquZXk6J+SVYc=
X-Google-Smtp-Source: AGHT+IHoEbcP+7wbWfLsHOZrllvtBPoQOAcEdIyYiIoOuuSu+B6VuzYN51GfKWoC4ASfv8HWnSAvaA==
X-Received: by 2002:a05:6e02:148d:b0:365:1dd9:ee6b with SMTP id
 n13-20020a056e02148d00b003651dd9ee6bmr25409244ilk.25.1709781811024; 
 Wed, 06 Mar 2024 19:23:31 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a02c734000000b00474e9a77424sm2233990jao.147.2024.03.06.19.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 19:23:30 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 1/9] Hexagon (target/hexagon) Add is_old/is_new to Register
 class
Date: Wed,  6 Mar 2024 20:23:19 -0700
Message-Id: <20240307032327.4799-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
References: <20240307032327.4799-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12b.google.com
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/hex_common.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 195620c7ec..4bacef223f 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 
 ##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 ##
 ##  This program is free software; you can redistribute it and/or modify
 ##  it under the terms of the GNU General Public License as published by
@@ -397,10 +397,18 @@ def is_readwrite(self):
 class OldSource(Source):
     def reg_tcg(self):
         return f"{self.regtype}{self.regid}V"
+    def is_old(self):
+        return True
+    def is_new(self):
+        return False
 
 class NewSource(Source):
     def reg_tcg(self):
         return f"{self.regtype}{self.regid}N"
+    def is_old(self):
+        return False
+    def is_new(self):
+        return True
 
 class ReadWrite:
     def reg_tcg(self):
@@ -413,6 +421,10 @@ def is_read(self):
         return True
     def is_readwrite(self):
         return True
+    def is_old(self):
+        return True
+    def is_new(self):
+        return False
 
 class GprDest(Register, Single, Dest):
     def decl_tcg(self, f, tag, regno):
-- 
2.34.1


