Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7DBFA1FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkz-0001jt-DW; Wed, 22 Apr 2026 16:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkv-0001MO-Bo
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdks-00029e-FZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so41841735e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888060; x=1777492860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oIITiL8QOdJdZl114SSAVmYjhy61R96Y1Hwwr6ats1o=;
 b=oWc5Vwoh+nxpB2kyIrPFe1Vnq7R93EGufua3Mku7p21JpIFRkmKjWuPcBg5GIPPEpF
 o1o5lvHv3c87ll4UfmYxoDjEdAlpSmDnkt7FbTivjqa9A9A3x9lEfw7MijzXx+7ixc/l
 95Hen6UJBoGwvQumehcFdYbzP+Kwo5leqAV7J0F7qGn6v52SMwngA9zxVct+NbbvrTd3
 EvoQR+6rSyqAxYGGAHLcj174OeSs2YW0b9Gs9qcE85ZREtB1df+DKh/FkK+Ckr1OqNcT
 EnQCJbHXRLxJPRMDAyKvhwIhbEpW56vgX2sA9blVHNJFPp/+QzZuBgp4J4KbJAeOed6f
 ufFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888060; x=1777492860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oIITiL8QOdJdZl114SSAVmYjhy61R96Y1Hwwr6ats1o=;
 b=TtQth1r/EWkmMVW/mIoaErl5iDdtW6Ow7PBM1tXZcKX3OJOQEYMyhjiXgkVZ1JULVf
 Fc7HrAivleeT8O3rTYmaa4sMw9cHXKW7rirdrFlifHexSCnfsCB0fL9AGcjOAiauRFUT
 6wjEHn/z76ShZXb6xo/t49+BHpLt6rpP98vxweOO0jr6pPgh9nCXefoCJBG6nLfzbEG2
 mwxfHxjoVP180JI5+6WB/Qo0Tu/2GpVY17s+e9ZJy/o4pYNeMRD0O7B+6NMmWaKsHBhJ
 iUsHYhLgNlSiCIBgzFccRltWYTSMjVfgwe64ApU6aTgWk6z1Ht/Cia75jTQMngS3uZch
 WOjg==
X-Gm-Message-State: AOJu0YzD3L80wq9zFgpdwRpmvQYXtcnHjYBmc0iYnnASkgvw6emctXyR
 wtWWNWK2nwaAfTqcLxd9fbMOw0RNTwI6XENOVWnmidBOwqd0J5OqmtOUxi4vDlkfJkcKaLraLLz
 HN8D6C24=
X-Gm-Gg: AeBDieuonxSWh/UL/bhv922DpkEuTAAD4vN/h10NYNdy8ONbpnWxr0rW2MruiG5pvyu
 i1R0O6Khb0lJjyZqWbsXyXFoBohviuXBqW1Ek51+OFEdAAKs1TdJJgYnnmijYuV1RXPvBgsOJTw
 NyR4sAAb8i8v7UhhuJMBLn+Y/3Scn4d+sjmz7oRkHJMd0XL7OdqoKhj6sYiNWwIv6HpBFLI1ETd
 VAXQODjDkOYfQQ0SQ/xmn07gplnL3seK4JtgqgEpQpA9VPgnacItESSTgn2/bbYnxEHjhfBumpm
 SSk7b0SdnTPTHTnaMK8v/U3F6x5HHSFzPLNDQk8kcm/Q/hmoC4auxWvZAVMy5ypPF7xTIHAqT1i
 RHbE62ZaQ0xp4uZy2VdgpH/Q8XNe4c0X5FeTxy1oHlPAzqvrC7Nplv57OwypjPHTg1yYvoL/X+i
 hCBV7rzhzPfzc/sA+uF8RXIahPdldk6tfW6eP9LCA5Lifj8xa6hM4jHd/Squr8U5a8hXx6Y7YGM
 a1w81Z2gS0=
X-Received: by 2002:a05:600c:3546:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-48a554663d4mr131850755e9.15.1776888060185; 
 Wed, 22 Apr 2026 13:01:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm157019155e9.14.2026.04.22.13.00.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:00:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/48] hw/core: Move compat_props_add() to 'hw/core/boards.h'
Date: Wed, 22 Apr 2026 21:57:25 +0200
Message-ID: <20260422195746.88865-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
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

compat_props_add() is only used by board models, no need
to expose it to any device model. Restrict by defining it
only in "hw/core/boards.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20260325151728.45378-3-philmd@linaro.org>
---
 include/hw/core/boards.h | 10 ++++++++++
 include/hw/core/qdev.h   | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index b8dad0a1074..0ac7e17ef7a 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -798,6 +798,16 @@ struct MachineState {
         } \
     } while (0)
 
+static inline void
+compat_props_add(GPtrArray *arr,
+                 GlobalProperty props[], size_t nelem)
+{
+    int i;
+    for (i = 0; i < nelem; i++) {
+        g_ptr_array_add(arr, (void *)&props[i]);
+    }
+}
+
 extern GlobalProperty hw_compat_10_2[];
 extern const size_t hw_compat_10_2_len;
 
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index f99a8979ccb..778617787c7 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -421,16 +421,6 @@ typedef struct GlobalProperty {
     bool optional;
 } GlobalProperty;
 
-static inline void
-compat_props_add(GPtrArray *arr,
-                 GlobalProperty props[], size_t nelem)
-{
-    int i;
-    for (i = 0; i < nelem; i++) {
-        g_ptr_array_add(arr, (void *)&props[i]);
-    }
-}
-
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
-- 
2.53.0


