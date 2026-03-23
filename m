Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCEBF4613D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4hio-00021L-Jk; Mon, 23 Mar 2026 12:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ihanzhzh@gmail.com>)
 id 1w4hiO-0001hs-1T
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:01:28 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ihanzhzh@gmail.com>)
 id 1w4hiM-0008NV-3j
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:01:15 -0400
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so297867a91.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774281668; x=1774886468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OqbRfPpNGnOZ4ufg6r9BpKIs1x5fGacz7S8hngqPKc=;
 b=grLa7DvKzm+FqUw7/CFL0/jgdrSJ5lsFb/o58qb6abVyefqRnH4HZ4ZMROYIghL4OT
 N9a9bN/lCkSUrTngHmZtnZuQOYt21LkATevcpprSdt78saoTBqyeul2oiWCkCQCIuR0N
 qstmrFV84da/CUbBTu+/sXg6i0Flq1BXCHky73xu6aMWmfWlm8uYYkqGYykU4iNlb6Ea
 U8niy724xAhnJuMuJcTmqv/R2xc0Cjv+SfN13Yjdtur5BvaVS+PVD6CzxF1lgoe44E0v
 NmIOCRV6f3U/7pxuRN/DcL0AodT/bOrOJDmMZ1RmgtQXpRQrzcZfqRB6bZog9muAsapw
 KJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281668; x=1774886468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0OqbRfPpNGnOZ4ufg6r9BpKIs1x5fGacz7S8hngqPKc=;
 b=T5sEMMqkEIU8CnvEHI5JqQgeFkmNmjPjyfq/PW9lH1d9bxa0Er2yTmKqG3o1pw8aIR
 QmPeZ2ETW3fTFEp4YN/dx0oR4XOiNgjg98HPfPTcAPnrQFFpCUBYPoYxjPWbTY3L4NC9
 uKd07QLyUeTjL5wLGMI5X9KxFx9CFB3ygPzEpod+h7LUkOgxiR1nsHI6C9T+BEoTI+hI
 2ZQCUq/X006Z2f0QnjJ6BTqcsQbpG2bBuyxzFLUbok+4RgKPStR0YCeBLNEgbCxvlQjp
 lr5EIpKPdfAYZAaFXs7DDHWXgHNsqz6P1ppAm4wv7hA2nSuYjdFEVGr7gbmw89cpQZ0S
 0Rsw==
X-Gm-Message-State: AOJu0Yxs2jCOE9akvfTacLCCQQG+g7F4TCtP3ORjFmBYt2qu6TNYFlx9
 6Q89IJMMIwjw9s04rmknotqCSGYpTXaoU6xHTgFgQB3UrWbO0NIqsmhViSoJpHiViLMJ
X-Gm-Gg: ATEYQzxkIYKHxyawRIzgiU+68k9xERXSjBbdbEuCXLb+Ir9XGPUfb771Wqsfjahptlu
 G7PopIiPLLRhXXx2sztj3/BQZZVxA39oIl6gXu2q3Vd1mptjww877pcXYES6K5d5be7NSjtB2i5
 /Zc+b1V5C/8tPVbuGdYtkWC878b7p7h5uN29TibhKtED/N5izOphS5DK3ICQVgCNLurMldM0Pj4
 fJBpAeCcwx8v87uYKGX4NSC4n3JpKO8n4QHlqQ29a10sR3m+WhcqDsIB7awhe9Rk0hkJsVhhpK9
 i95rzrIDeFIRxRGQ+SmQ5u5H0P/2mtNx61yPiS8Jib28avMyACvSs2NUQhYQ5lZaE36a6I1bezR
 Ple9bjIh/uIxDBtAFSpFWgtdXmB/rYMLd+edq2KJSdnxkfYBudXDJPyHLeJDZAMhauOqWGy5EWi
 aBezKR8T1cr96H12MAuOeu05iRDAGU
X-Received: by 2002:a05:6a20:6a0d:b0:398:7ed3:a005 with SMTP id
 adf61e73a8af0-39bcea4f7b3mr10046906637.29.1774281667974; 
 Mon, 23 Mar 2026 09:01:07 -0700 (PDT)
Received: from MINIPC.localdomain ([240c:c603:c:1531:cc6f:66ab:f6f0:ec53])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040da7besm9467763b3a.49.2026.03.23.09.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:01:07 -0700 (PDT)
From: ihanzhzh@gmail.com
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it,
 qemu-block@nongnu.org, Han Zhang <ihanzh@outlook.com>,
 Han Zhang <ihanzhzh@gmail.com>
Subject: [PATCH v2] hw/nvme: keep switch handling in nvme_directive_receive()
Date: Mon, 23 Mar 2026 23:57:37 +0800
Message-Id: <20260323155736.1558483-1-ihanzhzh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317010721.232247-1-ihanzh@outlook.com>
References: <20260317010721.232247-1-ihanzh@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=ihanzhzh@gmail.com; helo=mail-pj1-x1042.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Han Zhang <ihanzh@outlook.com>

Static analysis reported that the default branches in
nvme_directive_receive() were unreachable because dtype and doper were
validated before the switch statements.

Keep the switch statements as explicit documentation of supported
directive type/operation combinations, and remove the redundant early
dtype/doper checks instead.

Also move namespace lookup into the RETURN_PARAMS path so invalid
dtype/doper values are rejected via switch defaults without an
unnecessary nvme_ns() lookup.

Reported-by: Ekaterina Zilotina
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2472
Signed-off-by: Han Zhang <ihanzhzh@gmail.com>
---
 hw/nvme/ctrl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc4593cd42..479a4b8725 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7540,13 +7540,7 @@ static uint16_t nvme_directive_receive(NvmeCtrl *n, NvmeRequest *req)
 
     trans_len = MIN(sizeof(NvmeDirectiveIdentify), numd << 2);
 
-    if (nsid == NVME_NSID_BROADCAST || dtype != NVME_DIRECTIVE_IDENTIFY ||
-        doper != NVME_DIRECTIVE_RETURN_PARAMS) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
-
-    ns = nvme_ns(n, nsid);
-    if (!ns) {
+    if (nsid == NVME_NSID_BROADCAST) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -7554,6 +7548,11 @@ static uint16_t nvme_directive_receive(NvmeCtrl *n, NvmeRequest *req)
     case NVME_DIRECTIVE_IDENTIFY:
         switch (doper) {
         case NVME_DIRECTIVE_RETURN_PARAMS:
+            ns = nvme_ns(n, nsid);
+            if (!ns) {
+                return NVME_INVALID_FIELD | NVME_DNR;
+            }
+
             if (ns->endgrp && ns->endgrp->fdp.enabled) {
                 id.supported |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
                 id.enabled |= 1 << NVME_DIRECTIVE_DATA_PLACEMENT;
@@ -7567,7 +7566,7 @@ static uint16_t nvme_directive_receive(NvmeCtrl *n, NvmeRequest *req)
         }
 
     default:
-        return NVME_INVALID_FIELD;
+        return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
 
-- 
2.34.1


