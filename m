Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07A7D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbX-0004cz-3s; Tue, 05 Nov 2024 06:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbS-0004aN-TF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbH-00078A-NJ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:06 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so47101845e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805592; x=1731410392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Pvdl2amKi4XsrvVH6yACE3VgtWiyqVuGZb0GDfDjII=;
 b=C96jLdK7ftOa9Wf7c8DBQOYFuIvOmOcUxq3AQmXYtzETrJErI0VPm5bCzYQwirVala
 uWmdJDCq+YVREQ9OLQ2BG5+FabVhNiGzQ+jkEFlXsX3K1e57K8Z48kRkWf92QKLV3lqg
 cAF1QKPHkTbaDtxYsg47dSDX6lENMCRVDZP9c0LUSjeHAbOPz0k+Wqn2vHqCWYvefu+s
 zyrnM2LVOXoeCdx1o7fzqrkPbQ3DMArMgwaNN8q42OP/RCUbf8dBoPS5RsTuGpIujQUB
 tiW9Ag4zN7djw1MqI7nbzyDosGrOzFkVUCV98jnZgXqsMkAXYz3gtzKA0x/TxJAHy0F9
 DRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805592; x=1731410392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Pvdl2amKi4XsrvVH6yACE3VgtWiyqVuGZb0GDfDjII=;
 b=rNEAPigebajnaEfs7SdpzglLzoGa78OkLI/1ZuFUvNO94JGx1AL9CVzd8TpBsSD6sT
 98vRX/L7a9K8RkIKHP+X+xgUMobc4rbjIjACFcthN2hv+pyKKb9n3yxzbTaWFTXNb+Pv
 3PYr10fuXzq2xzR7VT/+OiLjN17AUDWj87wJzcQiPfdZmgCfwW7xtL6RpCze4808xKd5
 g1HhpA62oZS9z8u4yAC5YsIFr06ZG4F+ly2Yad4k3iOxnHtUT17DbsfJXUwBeSsMuzYt
 q5liWwqB51Ch6OcAKeUnVnJByh/UvCpF9raB62Z5QBWAOJ1JvWtzk7tVX3o91ZFG9n6A
 dOYQ==
X-Gm-Message-State: AOJu0YwY5UAya/BpVzRKRn8b2cJ1TAJQ9sw6QfeiIF8ciFDgpas3Gx1j
 SGJiWIll+5cKWeCmheBT3Fv3tEoDzbm5Zq1oKQ0zLuQws17GYcEKOLZGr4piMEjJlOF5w1Ricy3
 u
X-Google-Smtp-Source: AGHT+IGx8/44cCsS7nXTqNeszL0aS25wSSf9Jf7HWgM72z44UFTnSs6JMrftu28uVyj4nvrfllvbcA==
X-Received: by 2002:a05:600c:a41:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-432832562aemr122556715e9.21.1730805591998; 
 Tue, 05 Nov 2024 03:19:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/31] disas: Fix build against Capstone v6 (again)
Date: Tue,  5 Nov 2024 11:19:29 +0000
Message-Id: <20241105111935.2747034-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Like 9971cbac2f3, which set CAPSTONE_AARCH64_COMPAT_HEADER,
also set CAPSTONE_SYSTEMZ_COMPAT_HEADER.  Fixes the build
against capstone v6-alpha.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20241022013047.830273-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/disas/capstone.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index a11985151d3..c43033f7f60 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_CAPSTONE
 
 #define CAPSTONE_AARCH64_COMPAT_HEADER
+#define CAPSTONE_SYSTEMZ_COMPAT_HEADER
 #include <capstone.h>
 
 #else
-- 
2.34.1


