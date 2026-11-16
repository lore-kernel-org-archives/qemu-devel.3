Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A7606C113
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t/bDt15F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSufs-0004x5-7v; Mon, 16 Nov 2026 06:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueG-0003pb-2Z
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:20 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueB-000284-LO
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa87so1692833f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827592; x=1795432392; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pjw8iuDZkRxk9QIN6UyEUQIMdDyB9ab6e2fltNT38po=;
 b=t/bDt15FD3a6+7aOtj71DjOO/omUggUOg95rivDrF2Nw34Pr34F6OwL4v/QJesZero
 H9M22Or+L5Pwk6+qTKOUWkWqNfrULgCsUOGbfexym2NTRV3gkkl6vK6LUjh5r0coa+E+
 56pE/IT5hQjGdf0xPvc7H1bbRmrpFqDLBQYWqVz6BlasnaaEeTUo6QCL/1zNTmLIYzNr
 OmxM/17hG+pXZDu9BrRenpawIc6wchV4s4HCavY4FGyyDOe8Ka5Ll26af5epRxplE7mh
 UV/a+doDgg5ROyXo1xRMVLgtDnKDF76J0DIgOzTj7C8BimrPL3czZTp/6ELkmv0LuPgd
 +c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827592; x=1795432392;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pjw8iuDZkRxk9QIN6UyEUQIMdDyB9ab6e2fltNT38po=;
 b=pQAHrMGwD0F/3g3S8UydzxaaPpgJbwOrx8ZuSdHVGyYD4ogd6Nejh2m385NN5QlrKR
 umXyAQrru52P34qd4LbFJpR6RxzbyGulE1oCNM6TpERvxUIxU/v8eYWEEwftyoZdYSnF
 7iEjKQ4Z8Lzl33JOJqg35C/yPa//vODSGbjbgVQ5UgQbX3gYW7/YtVndFds12/lKoCvA
 bdvGI/vXcrDWtmAR6KfmA02xDu3WSabrrOi03wmPS83eOLlU8Wl/wfD3EM8c4HyNKkAQ
 7ZiaGmSHEZ1By21L3tdGpmb5hMPL5mUmQ/Yl+kOp8nMuPz8scn2iRpeDTmhndlyhs+fW
 Qh3Q==
X-Gm-Message-State: APuU4Z+esuXxfbA89Ox5phy6LI3/GklOEki2Oab+i6jnHyLm9dwegSj6
 xFDrrxbD5V7JYn+z3RqQbwGgZKrBUmZBsiuusPhUWrYQL5LHLfGw0AtO7FU4gEtOQd94MTlIGjc
 dAX5u4+c=
X-Gm-Gg: AZFdTZe/ORQu86YLfRiEpfgvlviTls88LYnAAy7nisHd2bF49gp0Q2oLT/pn4e+dV7k
 C4BJm7Hu5Q755u8JSkIr4qr/h5965TF0TZHySnLtVqIfKh1vGY9pL3NFXjydNVxUwZzyvxDmyVd
 Xu2LWhCnN4TjveO+kScaBjM0EeO0L4HIOPxtSTbXEwU2KYBp+09jVp0IpgXgWi5JyTrLlZBd+E5
 vUfKE6vA25059yban0anflBcnPydT7aJUqo/CvZLFcD60+xqU+ymreBWNsBZ4jMfPlMyTsL0TD1
 xiWOdfiTqPQKQm7A4KtfTFdTi2Pd2kkFI7c1if3OyTkHa8enkNPSqNavMn+MhRFAsHDxxsBU3yB
 1gq6LRVqCMZwZpYReRBFY1TrKJOzLRGTeAIc4W7uggWUX3nsjxsqXLB3/cEw607wcs+GOlkwDCI
 5U5FfVAD+Fqd/uCq659Nw71BeS1oqmgQNciAnMYpso5vfY215mmWVE8VctSR1YL26kqPxf/V2QX
 ttsZVLWMtn5ogHLylwwfuBt8ZBz9lZeX3ZXcsZecJc/aiJzckWKoKsKq/MYZcCurL5581Xs1ypn
 vB098rewQ0nIgpMNxzm76hgy/p6iJhu/2tC3vbfqQUkspNOOyESNOxHtjPdfA1O5jhwcAXdaY/a
 KJK40fb2tj8HUYMw8HJQWJk0WZRgWLVcRDA==
X-Received: by 2002:a05:6000:2613:b0:48e:3085:7cf0 with SMTP id
 ffacd0b85a97d-49c7467b551mr18246962f8f.51.1794827591579; 
 Mon, 16 Nov 2026 03:13:11 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/33] hw/intc/arm_gicv5: Use correct type for value in
 lpi_cache_get_hppi()
Date: Mon, 16 Nov 2026 11:12:36 +0000
Message-ID: <20261116111303.1692832-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

lpi_cache_get_hppi() is a function we pass to g_hash_table_foreach()
to iterate over the LPI cache hashtable.  This hash table has keys
which are GINT_TO_POINTER(intid) and values which hold the L2 ISTE
value, allocated as "hashvalue = g_new(uint32_t, 1)".

The function is passed the key and value as type 'gpointer' and has
to cast them to the real types itself, but it incorrectly casts the
value pointer to a uint64_t*.  This works on little-endian hosts
(since we only read specific fields of the L2 ISTE using bitmasking),
but won't work on big-endian, and trips the clang sanitizer.

Fix the pointer type; for consistency we fix also the type of the
local variable, though that was not producing any incorrect
behaviour.

Cc: qemu-stable@nongnu.org
Fixes: a0562ada75e ("hw/intc/arm_gicv5: Calculate HPPI in the IRS")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20261103172616.2400758-5-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index fd6456cd8aa..26dcbc82ed4 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -390,7 +390,7 @@ typedef struct GetHPPIUserData {
 static void lpi_cache_get_hppi(gpointer key, gpointer value, gpointer user_data)
 {
     uint64_t id = GPOINTER_TO_INT(key);
-    uint64_t l2_iste = *(uint64_t *)value;
+    uint32_t l2_iste = *(uint32_t *)value;
     uint32_t prio, iaffid;
     GetHPPIUserData *ud = user_data;
 
-- 
2.43.0


