Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2827DE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBNn-0008WM-BF; Fri, 13 Dec 2024 14:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBNF-0006t3-Te
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:54 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBNE-0004I2-Bz
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:53 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30037784fceso19590961fa.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734118249; x=1734723049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5t5Kfg88Idn9A8sdeK/3C+aA4Q4/f69T01+9FYpo+k=;
 b=pulcQxxvmsaMNFbCgeKdO0MxoTeoxjO4cqGY2XeFUAZAjlUHZsfNI9pm0NxmAVhDea
 RZA7GqlGA7r2bZJkKlxA0d9NImYjSVwqsoIwvvltH/BvKNWsdYKRNKnYDHbj/KoyI5Bh
 wcuam9pOertvrPjh/wUZtWab1QkrDkFVXGdw4PBcbTZGfvVUxUZVbIp0aWj21slCLz+a
 O1sdxMuJ1p3aXbhwrUOZzOUe9H9fZnTv4s0uJaE2/IpiwPeRG41Wn3m4G6AHgIkAse/5
 p21Acwz0Nj9rvmVBawuEb56Y/E5wkYErUPBKwracWfkPLd6FR9otClfbljWnTcRSgEeS
 kwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118249; x=1734723049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5t5Kfg88Idn9A8sdeK/3C+aA4Q4/f69T01+9FYpo+k=;
 b=pfs+MrRSXsZbfC1tlOXsIaansDdKUBfsoW9va02S1x5a8fXrQc/oIKbZKX6dFfyg9S
 o0+uAAkaAbEL0zbFoCPhJ6ujJJskTcP2g/gCPBboYMycR+adK4rvTBpJ1oO1IKUjydIA
 FXmq1xhygPBIYqs69Adr+GCVRQao4g0t0SHhUzVwckZ+l5LEyifMTtzwt5r2c62nLPof
 r251amQ1PJ1qD3RsXgch2nfjXq8jf5ZYgnsc9LyIA2OEwuGxjC8bN5x5gVVScWmj+EVJ
 vumvP/dt34Asjm9AW6qrD5TvWlz5hfCqXsvrLSeW8bJsPtmO1VozMH1te4hCDaufgpZG
 eiyg==
X-Gm-Message-State: AOJu0YxzDd5UiXQVMLi5NBfDuOo4Xs7pTXatXdpvuxg0HJTdDxvm6amf
 D0PXyHdJh0gbubsl6SoQ2nWYzUu3wOy20jemRabuzpI/WTlYNXvVPxNt6OiVj/FOeY/XcxgPIEX
 hb8o6cCcI
X-Gm-Gg: ASbGnct4nI9qCsCzUZqXOuGmPy7t0QvR9EqEGN1tQTFMr+/v41zJHggTtEiBtfYDIvT
 sl3fFH+dSHeFdzoOACLcKVpjQWs+LEmTpDBgOBhe4cBvHiTx/y6IKD8tVtDZcXb8vG4VbkOpK3z
 b19HWs81px/KQm9WdkNYO89V6qDFkRBVBuOoxXh5SNX6PEmySRGihNZHv5nxzM9JBkUc4/FI3Jd
 PbfHgsoUfKpfqIc5b2fzok0/2t4HpLCz8a3BNpCjOpaLzkRBPSBlX9z1quEig==
X-Google-Smtp-Source: AGHT+IEVWn8s5zP1MGFumvUQTEQ3ffwofWS3mvrYSU47wD3xL4Ll8IZLZ5/xOoizBV+DtpEb6Tf3yA==
X-Received: by 2002:a05:6512:104d:b0:540:206b:c358 with SMTP id
 2adb3069b0e04-5409055826bmr965522e87.20.1734118248733; 
 Fri, 13 Dec 2024 11:30:48 -0800 (PST)
Received: from stoup.. ([91.209.212.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c01051sm6972e87.156.2024.12.13.11.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:30:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH 69/71] hw/xen: Use DEFINE_PROP_END_OF_LIST in
 xen_sysdev_properties
Date: Fri, 13 Dec 2024 13:30:03 -0600
Message-ID: <20241213193004.2515684-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213193004.2515684-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193004.2515684-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/xen/xen-legacy-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index b15393e934..f6ad58fe13 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -675,7 +675,7 @@ static const TypeInfo xensysbus_info = {
 };
 
 static const Property xen_sysdev_properties[] = {
-    {/* end of property list */},
+    DEFINE_PROP_END_OF_LIST(),
 };
 
 static void xen_sysdev_class_init(ObjectClass *klass, void *data)
-- 
2.43.0


