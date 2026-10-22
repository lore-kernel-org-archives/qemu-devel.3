Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D7606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jzPc5EPe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJywq-0001OV-5J; Thu, 22 Oct 2026 15:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJywk-0001O0-Ot
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:59:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJywi-0004fN-NY
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 15:59:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so2084985e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792699166; x=1793303966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uwt/aBfIVnj6q/gSUcPnJ2a8PJs4AKOazHIuE9S2L/g=;
 b=jzPc5EPeJkUBg4PLuhtWCDZ8C6vSp1dBAZxo1Mijgz7BUfNX2nUH6rGYORII/jky7t
 vtsE0HeNhdr1WrjsCVRvq3nzJFLHsmeMRx6EJ7iSgpYqwFc9d1MOgP2LAMlEhAZWLfK7
 qWxvI0dmO93h8wpE15oivxw9xCuR89OhQ3FcUSjmniYqv72fbbEcSfhI3IIIEliD0mo/
 Tm1/M1krp8MgYg4H1rfvKPzVx6FixEBDpPNdj3l1XqA2Oa+oJ1k4aq+zMVPI4txjSn9x
 8YA/m3N1syRBwL18LnxEZa3pWEJ0+Oy+IB/uX9gBygM0WPsX8dcdO0Bq6izQ3zUr2MYo
 BwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792699166; x=1793303966;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uwt/aBfIVnj6q/gSUcPnJ2a8PJs4AKOazHIuE9S2L/g=;
 b=yyEF535QMMmuZn/QuYoaHsc1IiSrLqG7Rh5oNQeKHnISjtupNUZsVmEAqHgEu/+1ZZ
 bRjgv1vujOzHEorL6qjK5O5Ynb7sUyoAkUPocmg+RBd8Cj1VWc+UXv5t+c7t+DYjlTAz
 TEpqV0rX0aLy6kpnLzpBruIDCWkwMNrhHRAYtarsyLaZ6YXmTCYxL9aKPswxTQqTF73f
 zbyhm/XXdWJeAwk8c6xYrwS1J8E/KvznfX669ruQbzWGgbcQvqsMjCiKTLg53ujxlsj9
 lbGgHo3/FL40Ja+71JppC5Wj6F85VghGvPVpqy3ExALcib+LlGJPeHaVqUf1ar+z1W6I
 pmKw==
X-Gm-Message-State: AFq9FYKbAF6lEajnwPgBH8UsqIA20KT7ovUiVJoO/1PauN+lZIvZgi8q
 XvCeMadQ4k8kfqLwYF7QlhEUc7YFVi3g9wvAdCUNNjAzda4k6Xz29Jz/dw+0KvMseA0EPXzNm/P
 oKGJPQ7k=
X-Gm-Gg: AYBFou36EARFQ9ycrRsz0v7PD+3PO+ZGvp9k2KMIV3XeR9mylwLLUfTtW923IJxfanX
 ZjbpeA+p7H9PhCPFh5DILzV0CV55fuAjjBJntYBE7TlhTX614LKMmxgY4YnKL5FSoHFNBHSeUWL
 UarvMI3IdaQ2d/zaDQIEUC9dFKTMEEKWy6RbtXPihuADkkPhZCTm7VR4KX2O54sDbewh5qi42wG
 Zd1JpvM25+0lMNJupN51HCS6PN6guEngZWd7DTe4mIeUF28ctXuyeXGqPIcyYz2m0ZvvWWkkElr
 dUq+sn5kwhiaKt1xpdK2ghfWnhP7gvBD1evXIq8WuZUjebALtANp/OUWm7vKyLPZPS2/xRtzADM
 DncclAV3KxRRU/V9mQDBLgp0DVGAnT2K+v3vkFQSMtsAj9e2+cbNQCHrzvHEcZUiJZ6CFSOjbDn
 jG+nawM7dDNqI6JrfaIXh1rpnWjkqRY31ibPumcc4taTzCNONFXxQCtbYH6uLhtnP7loeBrnWcc
 CGDo7uYjxBgx9HXDu6L1sWGBXVwrcX2j+fRktT6AnsbtXFXwGPpVEO3hCDhG0+ZQtRqr9mjI7dB
 sgMVCeehIdieyb8fOTLKIA3Qz1wZFqPZTsmypBAFNO3umaMChw0KY4V+GkQh
X-Received: by 2002:a05:600c:4e8a:b0:4a1:d675:b031 with SMTP id
 5b1f17b1804b1-4a211eeea21mr1820405e9.6.1792699166496; 
 Thu, 22 Oct 2026 12:59:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21235a61esm159185e9.2.2026.10.22.12.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:59:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matyas Bobek <matyas.bobek@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH] hw/net/can/flexcan: Fix FLEXCAN_CRCR_MBCRC definition
Date: Thu, 22 Oct 2026 20:59:24 +0100
Message-ID: <20261022195924.672606-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

FLEXCAN_CRC_MBCRC is defined as
  (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16)
but FLEXCAN_CRCRC_MBCRC_MASK is (like the other _MASK values
in this header) defined to be an in-place mask
 FLEXCAN_GENMASK(22, 16)
(a value with bits set from 16 to 22).  The mask and shift operations
are done in the wrong order, and so the result of the macro can only
ever be zero.

Fix the macro to shift first and mask second.

Cc: qemu-stable@nongnu.org
Fixes: 3c4e23cbb597 ("hw/net/can/flexcan: NXP FlexCAN core emulation")
Resolves: Coverity CID 1662973
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/flexcan_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/flexcan_regs.h b/hw/net/can/flexcan_regs.h
index c18bc4736e5..7923bf836ff 100644
--- a/hw/net/can/flexcan_regs.h
+++ b/hw/net/can/flexcan_regs.h
@@ -150,7 +150,7 @@
 
 /* FLEXCAN CRC Register (CRCR) bits */
 #define FLEXCAN_CRCR_MBCRC_MASK         FLEXCAN_GENMASK(22, 16)
-#define FLEXCAN_CRCR_MBCRC(x)           (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16)
+#define FLEXCAN_CRCR_MBCRC(x)           (((x) << 16) & FLEXCAN_CRCR_MBCRC_MASK)
 #define FLEXCAN_CRCR_TXCRC_MASK         FLEXCAN_GENMASK(14, 0)
 #define FLEXCAN_CRCR_TXCRC(x)           ((x) & FLEXCAN_CRCR_TXCRC_MASK)
 
-- 
2.43.0


