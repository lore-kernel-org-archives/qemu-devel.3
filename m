Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B2EC3DA44
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 19:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQXIf-0000nk-Om; Sun, 07 Jul 2024 15:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIe-0000n2-LE
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:52 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXId-00059m-6Y
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:52 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d932f991f6so44207b6e.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720379510; x=1720984310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzZW7S7trkqr70JQTEMEt+xFl2Pbm9pRqeFrftAZXeU=;
 b=LMCjp1HnhgWul6k32vvD0eC6njqViOJK8A6opiyq+SuzoBaZbVeLmNPAUjxcER3vIV
 LMnGhUA7fxl3YJNRutewf9PUPTFq4jG/lCODGbJnVl/QzkqEKuS0J1J1rfl7Bxdd1TEr
 QS+8UVHxS8eqqaWivLB8QN/a7U66GLnCDmT5YcrA65E0KTJaHFwpMICjs3JBU/MrZFLb
 jfMf3LSpwcT0BYcIZWhxSgc5Hp3gg2sWy3G9/9yWcVZkBrYIz0nhP29J/6FSncVE9diZ
 QhK2j2NfbdxMf1Eqv9kxmu6rD0o1xj5koF64rqzBEQWE+zvH+ySNG/nLYDfATz0Fwssx
 TjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720379510; x=1720984310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzZW7S7trkqr70JQTEMEt+xFl2Pbm9pRqeFrftAZXeU=;
 b=U3JONzRTaUVhfNuJz76jdjAK6/un/WnBQZMPh6GO9S/ijH8glglz9/0PN4APulNNyT
 lfPPFq5sRAXkp/leNf5nqaBqq44xDwBt6Xszygh148eYgsGWvDDTBAT3Grvw9vaLlBWd
 loQbndQH6qbP2B9KElbTymdLRoXWJHaaozGeZ+jr6ZoQWl/6xjba7Kq0MvexNCc/KIbe
 pdHBf4dT1TSOFwcaw1fCqJrTX5xPCI3BJycgXkhMCwOgo/lSymIHvs/lLP0PLn3vK2Gx
 6RNc/DN5f79udrTRDv5UsE1MrWo9JugSviBcZyzATOhP8yFVrIp2PLSSCgqgqXTKphEY
 Z5SQ==
X-Gm-Message-State: AOJu0YzDRoXiQcVWqcv+zpvN5IXP+rRcfO2gynWc4kX6qf86NBy23I3r
 GysnPcICnAJORZyszIgpg+RtLvMQt8AOOowr7Oj+CVRjuKTky9LK97VG8LOx
X-Google-Smtp-Source: AGHT+IGIM+wISClL3BYSAWW5tNb+206wRD4X5lJpkhYL7VdQzuueswRjaLFFiTHwc5lFCYj+nCC7Yw==
X-Received: by 2002:a05:6808:210e:b0:3d5:6504:6713 with SMTP id
 5614622812f47-3d914e9df47mr13520889b6e.43.1720379509847; 
 Sun, 07 Jul 2024 12:11:49 -0700 (PDT)
Received: from localhost.localdomain ([106.222.220.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d8a70sm172156725ad.118.2024.07.07.12.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 12:11:49 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 6/8] bsd-user:Add setup_sigframe_arch function for ARM
 AArch64
Date: Mon,  8 Jul 2024 00:41:26 +0530
Message-Id: <20240707191128.10509-7-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240707191128.10509-1-itachis@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=itachis6234@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Warner Losh <imp@bsdimp.com>

The function utilizes the `get_mcontext` function to retrieve the machine
context for the current CPUARMState

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/signal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index ab3bf8558a..43c886e603 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -81,3 +81,17 @@ abi_long get_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int flags)
 
     return err;
 }
+
+/*
+ * Compare to arm64/arm64/exec_machdep.c sendsig()
+ * Assumes that the memory is locked if frame points to user memory.
+ */
+abi_long setup_sigframe_arch(CPUARMState *env, abi_ulong frame_addr,
+                             struct target_sigframe *frame, int flags)
+{
+    target_mcontext_t *mcp = &frame->sf_uc.uc_mcontext;
+
+    get_mcontext(env, mcp, flags);
+    return 0;
+}
+
-- 
2.34.1


