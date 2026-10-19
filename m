Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45402606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xP7BEx8s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIq8G-0007dk-2Z; Mon, 19 Oct 2026 12:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq8C-0007c2-Jm
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:36 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq8A-00010i-Js
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so10176965e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792426953; x=1793031753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rb/hV+kc2y+cyLc/E9FJoAdgtXpSI/AdRDMtqVqJdQo=;
 b=xP7BEx8sbtRQxwMnmkiaeR51cBUgHel9slKrK+UnZ99WMFSE2gxxY0s8XV+VTwFWLt
 LRNUVKXzlQX/9KqMFgmFUKevpgFcYMQGBr9l2RwM/W60u6DFbHOP6bUAmQsfb8FAxamT
 FubrzBIPra6qxDKckfj/ZYa7g3Kiczf+U3VxEldUOqOfMsEfcH96xO9126g7t6LyGIAh
 wxj4D/PNqzDpl8/xWhROnLnfl4heIRM3atbH5v+ar2/PdSLwcMFz4/yQCRYRuINnUs+J
 33CJWBsGHrMgVf0miHE+yPzFllsnsAzTSOqAoocOfliDldxfR+2HS6lNqOOGJpaf4kgN
 Tl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426953; x=1793031753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rb/hV+kc2y+cyLc/E9FJoAdgtXpSI/AdRDMtqVqJdQo=;
 b=1J4AotBvdLelALakK9/ElLc4agMQP1LnpqDOeKaV0N/nyf0rGwdf9W5L4vptwP7Xnp
 m/5kqmBqD91EVpJfB5+JewgKRkp+gf98SrrEzmnIRJ+jG3slEQt11+DIGja8J5NV9eXH
 dNspIL7DoK4j223oEPDLUw86niVnK9BUYnS4eEfD92uB6AFQQfR4sdTHliCAe9l4AHGc
 BAgNiefZMsU61AlKK6P88vwwjKyDeTICbHSm9JGBwUu3NE7E4PJWzL5SUqhTm+WK4ifG
 5aw1mB9/hjmIeMzckXrCjETS/46InZg+h7AgvV8wbZ5TCD61o3sZlLCbmjK1IyvgIQvq
 FKBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhk2LN130LSZp2HKAL2KW7S2AU8pZXQ435cxcwfZhk6tVRYy5hGtwFPP2iUf46Jopq4oPfGwxGpXuv@nongnu.org
X-Gm-Message-State: AFq9FYIlQNVy3RcIRtBd68+QZd1xlKlgapkznLnt/I018wjNGufI5Mkw
 O7Tn4oPW6JlzP/r6ewORwb1+lATs+kkQzJ46R0D/ktYxCD455is2GnRgCpE3WkjZfw1gHtSUlaS
 d0A8xE7I=
X-Gm-Gg: AYBFou0rEgoZ8pum+4tZ3L2+Vg7YkT7AHPCwM0lfZmc4dRlq3VSkifZHemipCXg1qtF
 dJp0/Xyp1tTlyl+arIHgQgj4bK7MRszMQGmPz3hGJAJf+o1euy2BNCVkpdMMKu70PfTev6/jKCG
 BRgNoe7e/3dnkS6vRwNN4bTDjcYQs+CLq3CJdeurBu+WfYtIsKDciKE8zLurQQnIRceQup8fswR
 aMRBaTD3eqiWWdBObAGXVRnIFLPmuvu2WEWlVxBeL9um1p7OwAPC9cTPo4CKQopDV1uU/iKU6Ed
 VV/csWYd+7C9TnFRGYg4zcWbHDLysyOcskkBXef6tAWiUOb8EzPb7XeX7Vr+iVkPFDZ+lvcc48D
 exUwU437I4VsjwgjVb8Db7ElIXh4wa3yGbiTZsThW2Xzbxs6IywFNd6mk/fFLEB4sa2wkMIAPRx
 UuYP2rONgNP3gug6t1+2mSW24bCltRC9BaL7Yoo2l7z29es4OgWH1aeQepJYlODe1dJyrIwyyX8
 V1+0mkIgQPeVymZt+B5jxoJUMYPOUb0CQf1FG+FD/n+eT1M3/yKl/NBj4BpjA4RqFW9blEkmuT7
 YyA=
X-Received: by 2002:a05:600c:4f88:b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4a1d75fe190mr168114545e9.9.1792426953065; 
 Mon, 19 Oct 2026 09:22:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm3100095e9.13.2026.10.19.09.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:22:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/intc/exynos4210_combiner: Make reg_set[] only as large
 as it needs to be
Date: Mon, 19 Oct 2026 17:22:16 +0100
Message-ID: <20261019162217.3272337-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019162217.3272337-1-peter.maydell@linaro.org>
References: <20261019162217.3272337-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The reg_set[] array holds the register values for registers in the
"sets of 4 registers IIESRn, IIECRn, IISTRn, IIMSRn" part of this
device, not the extra non-grouped ICIPSRn registers at the end.  It
therefore needs at most 0x40 entries (for registers at offset 0x0 up
to offset 0xFC), but we oversized it at 0x41.

Reduce the size to what it ought to be. This is a migration break,
but we don't care for the exynos boards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/exynos4210_combiner.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/exynos4210_combiner.h b/include/hw/intc/exynos4210_combiner.h
index b1db48cb880..94177827196 100644
--- a/include/hw/intc/exynos4210_combiner.h
+++ b/include/hw/intc/exynos4210_combiner.h
@@ -39,7 +39,11 @@ OBJECT_DECLARE_SIMPLE_TYPE(Exynos4210CombinerState, EXYNOS4210_COMBINER)
 /* Number of groups and total number of interrupts for the internal combiner */
 #define IIC_NGRP 64
 #define IIC_NIRQ (IIC_NGRP * 8)
-#define IIC_REGSET_SIZE 0x41
+/*
+ * Number of registers in the IIESRn, IIECRn, IISTRn, IIMSRn part
+ * of the register map.
+ */
+#define IIC_REGSET_SIZE 0x40
 
 struct Exynos4210CombinerState {
     SysBusDevice parent_obj;
-- 
2.43.0


