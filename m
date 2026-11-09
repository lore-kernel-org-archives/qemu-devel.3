Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F55606D802
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PfwwcFOo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQ0P-0007Ky-QX; Mon, 09 Nov 2026 09:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ0H-0007FF-II
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:47 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQQ0B-0008BK-LD
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:05:45 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so9743495e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794233136; x=1794837936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eLMzCKJK010QwiI+TdClrcXBscIJkeSZJom2hWupRi4=;
 b=PfwwcFOo/KT6yJOwKzfg3fHNhyHpdiDevwfl3mzPmjevqQgQs8YJNa0WJklXwjOvXq
 pNHdwu52aG6wzrKFjIl46jFZH/3KY35xa29tRdv5ZZCIeX013F5rwf3h0XpUh3Mp1r4i
 5GY1smQI22UfOqQlQBKJyYmlZyKZNOBetmxJ8LTGaX0xAg+3rBPdRqUTS54KxRz7l9ic
 H2pMjq8YYDiyo1ar5+hKKC1PmDXfDYIM3J0CKfr8wo3lpmFe+wWKdGSIN2XG2uKWAoYr
 qZ23iQ+oBd2SH/dcSLELh1L9UXEyDjZLaVDvREwG+ernLFGc/jmB7YTvMpicKimNXWUX
 1X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233136; x=1794837936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eLMzCKJK010QwiI+TdClrcXBscIJkeSZJom2hWupRi4=;
 b=xmxrEj6VWF0UXHRw6VYFaAdplcoSjDrA7O41B6gTOKbfQfOgTfEI+QEBflO69ZLWbF
 fa8F0jKkCd3QbQM2C8bgbcfOrgk0IgxlxmKQmgiDZfVAce3tJ8VWFmrZ72ff0gtCBjb2
 CuaPo+XV8pMyJAkauICvfR6KZCnnY79IMC71rCYAH9E3o8nKUPc+jkHObaXdwuflCAtX
 HvRZvUzGEXNEuhn4JDq3w2Y7skJympBrlkh7PfHzjZ4ZihML3cAHClSwcEv4FjbO6obA
 rVJ5NJpOhBgaihEWdtueXNAHIj+7L+FXrGOdeFjrqgWSVjvOGajRuZWZYRRsmS9aQSs8
 Wp/A==
X-Gm-Message-State: APuU4Z9NBRdjabhYLB3wlSw7Thew5tD9JljhhwEWFi/wtiOoCrkOP9+s
 EgO2bKNbciIqOUospoPGnJ6LoAOVskM4arMRDV9CmMV/qDMfu8TZGW+CtuDg+rooYaM8WChqNOJ
 kQF0cqGk=
X-Gm-Gg: AYBFou3eVW1r3fN+fRYXYGgb0Vuq/SgZk9sYCJyBoOw0hdok/yg2zcbqcjpo4QBBcIE
 rbTCFRnxjmtbH3Dt5K9ZSKsI3s/IYS9ySSUSdurCQZnqkLOWOA6Aj4fybMzGIEyhhuBtKFcN5As
 TR6g3s+kTnPZPtYNyCoFsteHGZth5aUDjubIddJSM30sTqX0rE/k/ykXP9FJ1r8RYMHDfV2kqL5
 3B9F45eJFzON1l7vTnNAtRzlGZkCIB9LoEU6kbyYPCx1oQrSf8JQ5334K5udjHWXEx/agxUwNvO
 yTHhnS3wnLCT0TxiXIzjG+mFjtS3sFfBGV4el89ayA5ie2VING2j40nPGSJgBw+WCm3jRB5utnL
 O0msa08PFzM28NVLJ2eVEmELgZC/sh2WzMjiowHgKX/v2QglfQmMvwwemte96UwXxvCqdGq4dCS
 GYO7Txq1b4FCEb79tqe5ABzcEifXJin0pvOXgHS6MfLeBHj1q8Bhnk/Q39SQUdHhsERE4cNn9TJ
 TnaCw2AO7ZyvhQmh1SqRu1L3QYGoAyIlm8B8N3ljgO5+9NewYR+TvSdig5VZxfwh7rtGuWQK/Nb
 h+pOcaBlXCNXo/f1eiBwILrtKad/RZ7bIMiXyGSOWzm2Gyr1TErsHUQ8qOeoa4/g6eFAD+0MMgk
 XpvCiCrpXT2mkALLllsHhY0mcP71bz/uSAw==
X-Received: by 2002:a05:600c:4eca:b0:4a2:5267:3cd4 with SMTP id
 5b1f17b1804b1-4b94d762f4dmr73297255e9.3.1794233136032; 
 Mon, 09 Nov 2026 06:05:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea51cbsm11184750f8f.27.2026.11.09.06.05.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:05:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] hw/intc/hex-l2vic: avoid shift into sign bit
Date: Mon,  9 Nov 2026 14:05:23 +0000
Message-ID: <20261109140523.240161-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109140523.240161-1-peter.maydell@linaro.org>
References: <20261109140523.240161-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

In fastl2vic_write() we do:
   val = 1 << (irq % 32);

Because '1' is a signed integer, this can shift into the sign bit of
'int'; the cast to uint64_t to assign to 'val' then results in all
the high bits being set.  This happens to cause no visible problems
because l2vic_write never looks at those bits, but it's obviously not
intended.  Use 1ULL so that we do the shift as 64 bits unsigned.

Resolves: Coverity CID 1685261
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-id: 20261023084624.1063258-1-peter.maydell@linaro.org
---
 hw/intc/hex-l2vic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
index 2335236f837..93fbb7449e8 100644
--- a/hw/intc/hex-l2vic.c
+++ b/hw/intc/hex-l2vic.c
@@ -392,7 +392,7 @@ static void fastl2vic_write(void *opaque, hwaddr offset, uint64_t val,
         uint32_t cmd = (val >> 16) & 0x3;
         uint32_t irq = val & 0x3ff;
         uint32_t slice = (irq / 32) * 4;
-        val = 1 << (irq % 32);
+        val = 1ULL << (irq % 32);
 
         if (cmd == FASTL2VIC_ENABLE) {
             l2vic_write(opaque, L2VIC_INT_ENABLE_SETn + slice, val, size);
-- 
2.43.0


