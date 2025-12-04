Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09DAD216A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 15:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRBfX-00069Z-Ec; Thu, 04 Dec 2025 10:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRBfM-00065A-JR
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:54:49 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRBfE-0001wl-EU
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 10:54:43 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so7220495e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 07:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764863675; x=1765468475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cJP/5foxyTYgjxPkj3TGmAIyUfsDbEhAMuw2VksSets=;
 b=YnFwUe19RmbqFVtt0xiMj6E8Bhk8cAtO7nIQEHa1TY8ESC8utBFA0SAMVCqcxFieXL
 2qq7gtrdi+PGkJtBFOwOn3uk5bj3loI4B5tOW5B+luZdCGS1RNubTvKgXnNTcCypV6bX
 5iHkZC60mnm6cnqnOCdj4QY7ihXn8qmuFj1Pgg/9z1oeajn2pIt53fJd7C0JxLw6zTMz
 Aa1ZAHV/Z9ZXMdZsQM5rkHiBeGPerHhzCmVFQq77/yo/Sr2CO8E5vhcZWY1IFdyhKvDH
 i/5o6iSMPpgwvQLjI1SEXArM/SnUcBHmc0zV70yjlIwAApXmtbDdiw+J5ZOIx4bkB8bv
 W15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764863675; x=1765468475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJP/5foxyTYgjxPkj3TGmAIyUfsDbEhAMuw2VksSets=;
 b=pNpGxOtb+FAyxd6H5I8ixVzBfImItMUXZ5G5084U8Z0jNQc92j0fTyH7JtPm6qkd1r
 R7JohkehsAziHlL+lI7FTZlP1wjH9jAlIU4t6l8TYtOvpKhUPhdVD0hVWCqy5ViOvm0q
 HZDYhvvqxWWnNRxfCgQ84vCUOLd1wGL0ng1B4M1h0TYcxas65ANS7TpNyn6CKYvKp+4u
 dqCMHUHJK5Z7flQrA8aKJI+nKPszCMETZpo3V4xLhgTU5c7fHLqoc0hdrhjj+g4dvWhJ
 j1KT43NcOY2r6kdPoSWlQQAQCgy7vjNFmo83O7cCTTUlPZ2nC/+edhZIWKiY1ZVbN/ks
 yelA==
X-Gm-Message-State: AOJu0YxnpGdyBx9tfm1GH6PbHk5P+FdJ4gKnel96adYHBs7mt0Sozb9L
 oaDxq8Rjiq0dF8PO6kx1Dod9t2nKhBV3DibdMz9lrKGzzmX1bOHBLh44aR6iLmpvvdNlNpxo9Tx
 nreZW
X-Gm-Gg: ASbGncux76hvkhpcIIaHnHjAQIzpcmc63EH4ZfZDMEru1VEPA3mdmlmDXiB9tYMqB9F
 zGTieatWBPpIDLQAcHmReJzEFfVxHdWdEyN3DtKC++jvD+ocuygpwTx5eq9T8LTi+xp8GHnbGuP
 3FTcqLY1Wl/+THV7dRgcJcHm5ENQUMG/v6yJ2NMIW2QflMD+ushHmwXe0wtHMAQTDQhPQ6S/09Z
 IdaR9ctD2p6Pn0grIisJxcTTFV+swk3TohyCJSUpO2FJDOBNSuD+4IvzvyD8ziFFOLG5eXSxZEu
 xUHXQ5K9onuPyyrfoOF+zSAAeO0LWNLAmmfMIFc4SHYXLnLnwWQPK6H3wova2VQAXXv9IM6/JlN
 P/pEogjEJXm45ZesBCMWIt4WKh+Dtew7npmcqBE3yJMfZjCRppmJhefvbiSkXJCDqRFv/JqBMAU
 XU7ZCivsDbBV8=
X-Google-Smtp-Source: AGHT+IEg6u/Qmj4XtQjlnRCGGufSD+oUPi/n0z1Jg2BDqsLy+JZseyRwE8Af1X06k5Yz0E8oulg3pg==
X-Received: by 2002:a05:6000:1845:b0:42b:3455:e490 with SMTP id
 ffacd0b85a97d-42f73178df8mr6857740f8f.14.1764863674645; 
 Thu, 04 Dec 2025 07:54:34 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm3687286f8f.3.2025.12.04.07.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 07:54:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 22AE75F811;
 Thu, 04 Dec 2025 15:54:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] target/arm: handle unaligned PC during tlb probe
Date: Thu,  4 Dec 2025 15:54:27 +0000
Message-ID: <20251204155427.801085-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

PC alignment faults have priority over instruction aborts and we have
code to deal with this in the translation front-ends. However during
tb_lookup we can see a potentially faulting probe which doesn't get a
MemOp set. If the page isn't available this results in
EC_INSNABORT (0x20) instead of EC_PCALIGNMENT (0x22).

As there is no easy way to set the appropriate MemOp in the
instruction fetch probe path lets just detect it in
arm_cpu_tlb_fill_align() and set memop appropriately.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3233
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index f1983a5732e..78c85cb3306 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -345,6 +345,17 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
         fi = memset(&local_fi, 0, sizeof(local_fi));
     }
 
+    /*
+     * PC alignment faults should be dealt with at translation time
+     * but we also need to make sure other faults don't preempt them
+     * while being probed.
+     */
+    if (access_type == MMU_INST_FETCH && !cpu->env.thumb) {
+        /* probe sets memop to 0 */
+        g_assert(!memop);
+        memop |= MO_ALIGN_4;
+    }
+
     /*
      * Per R_XCHFJ, alignment fault not due to memory type has
      * highest precedence.  Otherwise, walk the page table and
-- 
2.47.3


