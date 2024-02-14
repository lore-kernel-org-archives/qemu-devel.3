Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3141BC4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra6rv-0007mq-2Z; Tue, 13 Feb 2024 23:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ra6rt-0007mF-FS
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:27:33 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ra6rr-0004PC-VF
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:27:33 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-363c2edac5aso18176235ab.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707884850; x=1708489650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYU53kj6Z9SDsJEykjfEK2SUz1aqv0gAFOVHSmMyOb4=;
 b=Dir7074Fyrzmb02Qx/6iGtNjaLrcfpcy5+xKkayYAWR1Y2Ss6O0xhyK4sLC9a1hedx
 Sx88+Qf4xig1M25f4LJykqfXykFvyteNZR/+y0LMfBzXTeqespNUWyxnnOFUJKOvHkuL
 dxrzj95ovrDhG7oY62TDfO6mrNlSLHLTLIcJtZ0rxDbnRrxAb1VFfUxuSRjO/y9sRoU0
 LorMcklBaJGCdyNIw7zpg1qthotS36R2pLv0CP0pRUWsHhxHVcXqBR25vFD0zSnOQcdG
 swdxBOYmqDhdhxW4oIETAIvS/YRBpFN4smeLxQi3gDeB/TDrmbvlcdWlnxQquKP8cOoQ
 vxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707884850; x=1708489650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYU53kj6Z9SDsJEykjfEK2SUz1aqv0gAFOVHSmMyOb4=;
 b=lYfK15KmG9xKy3p/rl8KXCZdokLQ9GlM85/8LXQjLsO3PEGXRtxjpcdwAX3mQS9rY7
 6iyR6MqWNPXSSh0PIPhXQw6Ob2foU4lflziAY3nn9gtb6W1OcsnCRH6zGu4LH+h13GXQ
 di4VS6LXofCmjhon9qzfZFOhNmSeEr2ekCti8r5H07QJgn/zQPkY9roQocKrv4glWXI6
 nOnhvyTzeRijGn1+RUaHhyxJyJoeLg5Qx+GfKNYHyOUndthovHJRFmrAL2diHXACYvds
 qdRPODWm7aUnaGNWB4bofhr8wr9/BVwxmZl9k11YO+4/lP0mRwDROVqoqNSz6FnX3daO
 MBlA==
X-Gm-Message-State: AOJu0YxaYItmxLXhILjSJLwE4Mqhr/GCZI3gwL6Bn6OJTjfCq3aJibu7
 7MjWoUCjoLyZb8If+lRjSNjuhZgxkJZXUclnvHSuRQfYYQ7Gb23jE5P5r2Istu8=
X-Google-Smtp-Source: AGHT+IE6LxDbW2Peq5MGk7c2T77uFIg+giRgNt7VqVbvr/35TXMRXvlfD8Wiyo86/ppTZ146ioZC2Q==
X-Received: by 2002:a92:d20b:0:b0:363:d953:a129 with SMTP id
 y11-20020a92d20b000000b00363d953a129mr1990690ily.25.1707884849979; 
 Tue, 13 Feb 2024 20:27:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUokmLNy6+nOMMwX5OBxfY5T6Su0Xi8QdmgcY8t86MGTNtbTt/hZAOYZKiBqFqWdDldjFRXQFjJiiNm2vePA+RR9zzGNX0RRZrvNs/lvsZTKV9XOlhrxKZBOMiajdNS4gXCYDHw6dwB+QIaEIGAgGm26Go2B0oY2jP3RxJjAXj8CUEOaNC/yV8KUNlBDACqmnN0+AYGdatTbs4tO1hYLLuaIswaqPtksYBR0zCfmmvh7/o+xHdlASpfqi9hVEEaA9UWuCyMPQVfTkUxT92cvBcizRuK3nYSKjjNiKl+
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a02c9c2000000b004713170def2sm2312305jap.93.2024.02.13.20.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 20:27:29 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 1/3] Hexagon (target/hexagon) Pass P0 explicitly to helpers
 that need it
Date: Tue, 13 Feb 2024 21:27:24 -0700
Message-Id: <20240214042726.19290-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
References: <20240214042726.19290-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x132.google.com
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

Rather than reading P0 from the env, pass it explicitly

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Tested-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/macros.h      |  4 ++--
 target/hexagon/hex_common.py | 12 +++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 1376d6ccc1..aedc863fab 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -358,7 +358,7 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val, int shift)
 #endif
 #define fREAD_PC() (PC)
 
-#define fREAD_P0() (env->pred[0])
+#define fREAD_P0() (P0)
 
 #define fCHECK_PCALIGN(A)
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 195620c7ec..14dcf261b4 100755
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
@@ -197,6 +197,10 @@ def get_tagimms():
     return dict(zip(tags, list(map(compute_tag_immediates, tags))))
 
 
+def need_p0(tag):
+    return "A_IMPLICIT_READS_P0" in attribdict[tag]
+
+
 def need_slot(tag):
     if (
         "A_CVI_SCATTER" not in attribdict[tag]
@@ -1118,6 +1122,12 @@ def helper_args(tag, regs, imms):
             "tcg_constant_tl(ctx->next_PC)",
             "target_ulong next_PC"
         ))
+    if need_p0(tag):
+        args.append(HelperArg(
+            "i32",
+            "hex_pred[0]",
+            "uint32_t P0"
+        ))
     if need_slot(tag):
         args.append(HelperArg(
             "i32",
-- 
2.34.1


