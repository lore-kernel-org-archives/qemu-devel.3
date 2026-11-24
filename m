Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3E606A332
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vJjSuJ/f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqaI-0005AX-Hk; Tue, 24 Nov 2026 08:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaE-00057w-Vv
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:20 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaD-0007Ou-DR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4b52fcb410dso1020672f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526956; x=1796131756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EVaEY/nHBlKHPLaKeJoE+iwmwVYXCHmgjMUD0AmkgIk=;
 b=vJjSuJ/fNoqK1zTj8iDbTuB69gemTAXlqmZd0MXpavzKVS6Tdp6tUmHj9547GbvjA8
 sTFZPoM2XkNPXCUD9lHYNWrpE1ZMLsyIgg3tcX1ZxY0+2I3QWtdNgem1C5Blv5QbUCQA
 tOX/fC56Qz9oHYIM0WzNqaFWiVoIIp/FuYRXU85gDpiXkuH57xhPaA4n5ehxkuJowauj
 UFbzoMpQzfJiCt5JDToxTJyc4v30pAWJ1b3jz+S0tDOHNykWXT7DssqnavJJLVxPYfY0
 e2JMJ2EdgE3axlICYuxQAB8g7VtkdfaZt45JefCnDK2aSBsuwCH75a/+G6blwPSVUQsP
 IBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526956; x=1796131756;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EVaEY/nHBlKHPLaKeJoE+iwmwVYXCHmgjMUD0AmkgIk=;
 b=YQqFtgbDR48g09JZYPTlMzQKCTw4c9tYHtKLjIWJsjpqiMvNmQyWs5jN/982xZQX7P
 E60ye2Q6fwk7XAWPtSq4ZOApiZsQDKMDAJ434Yh8w8f3D9ZROARmkiYSvPXYU+2QtBpz
 KExWEWFdweCk+mJSO/tcGwE8z+rZQa+QqgR3k9poxfg61EBRDNsJhJWjD4TrqyEiHfWy
 EFMkI4smcaxhcb+WPXAE1XirONxuIPKBNNvEylhjVdzx4LyZa3bOJnN6omPn3bRk3nfN
 EHtfOjV5NaA3PFTG6goWlS1zpVKJCCzNDkRCN/O0n9OXHpm4c2GYvUzpVNaBncJRq7kD
 33AA==
X-Gm-Message-State: APuU4Z+oEQv8mvQycVp7IjgJKQmEbeoUrIsHWrIu6KZH1ykq635LrOB2
 qJ792zVWCdnhWojMmoMKbzExHIosFHz8ckv9DDKfGxriK5MKHeJ9NE5rLkLRy1DT7tnvNm9CNZu
 1rbDb
X-Gm-Gg: AZFdTZcBdQ2+6xlfXMENOHGetz25XsI/PB9yJVWY3zDIE6U/lcVUUX74iJLGmYgVj+n
 d2fvKeOPnj+poxDOncvUXE8im+Dc/TxUwxlhJhH7r+CvJFQIAYRiSzHjr86DjtYpmMg5uvbS38f
 Fp+MRvkl1mdzTKQRYJYxb2i6sHxSV5JCwkICxIXA6tJVxOxRyvPVyUBVGiSIQhDM8Sy7kXTTTxE
 Y8fRXqFadrFZze36ME4jldbC/Sc3ENFtKH0iViLgFZwhfucNn2BStgEQ9eUoLDeOGbIueIm8P4t
 8qmBax0f62MWBxoxoBAHj1z5DiooKVd0x4B3H7n4CITNL0M0OGdleB3nPIv8NDbC2dNfypGEGuL
 AUv7nC0zg86/ePllhbU3htbAh/NN7H/XToV8sAU6II0oLVIB8CatgzFHBvEDZs4xtqZnnBXq5z1
 uTzu620sBmYkwS3R1K1E8gh9XfZw5vwgz7DEUtAjo1IFh3XngLAkKN0ANh++8QFqFw6N6xKnSlF
 PZhg1cj3kKmuf3IgUKwgdA5KklzXQEZM9vta1s7zNOa+a4tGn36iVaTjhO79q8q9v4HWv1x4sO3
 8/wVxZxPQptWjOrmTaAEVD8iMSwO0dsIfMVk7VeJI9DAlynZ1UmPuVayCLAMoYonnH+zBpsZ/Ao
 3Q6NODzRhISQOsA4ZsLnfg7Ci5WzReZoVw88yV963LOihKQRHVzCB9I0=
X-Received: by 2002:a05:6000:2085:b0:49b:f7e8:6f3d with SMTP id
 ffacd0b85a97d-4aa579a93b8mr34174240f8f.18.1795526955715; 
 Tue, 24 Nov 2026 05:29:15 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] hw/intc/arm_gicv5: Fix value of the IRS_DEVARCH register
Date: Tue, 24 Nov 2026 13:29:04 +0000
Message-ID: <20261124132904.138731-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
References: <20261124132904.138731-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zenghui Yu <zenghui.yu@linux.dev>

The GICv5 spec says bits [31:21] of IRS_DEVARCH are 0x23b. We wrongly
shifted it by 31 instead of 21, so guests read 0x80105a19 rather than
0x47705a19.

Cc: qemu-stable@nongnu.org
Fixes: 22232793ecb8 ("hw/intc/arm_gicv5: Implement CoreSight ID registers")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20261124120509.19746-1-zenghui.yu@linux.dev
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 26dcbc82ed4..59b8596bf0c 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -318,7 +318,7 @@ FIELD(ICSR, HM, 5, 1)
 FIELD(ICSR, PRIORITY, 11, 5)
 FIELD(ICSR, IAFFID, 32, 16)
 
-#define IRS_DEVARCH_VALUE ((0x23b << 31) | (0x1 << 20) | 0x5a19)
+#define IRS_DEVARCH_VALUE ((0x23b << 21) | (0x1 << 20) | 0x5a19)
 
 static uint32_t gicv5_idreg(int regoffset)
 {
-- 
2.43.0


