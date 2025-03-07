Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABBCC28B25
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIY-00013q-Sp; Fri, 07 Mar 2025 10:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIV-00012p-UP
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIT-0008Ls-Vg
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so16707565e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360052; x=1741964852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nTp52Om52JlzEKvgvtGomRWuf+tAauGk1Wv9ixJOvzU=;
 b=Gwd/K5B4h/uoL1wjPK+JjtznqQyT29B/AsAPzhvccF3SRA/WIjZgizPhLwC5xg4ZoM
 b3YUtd9JNmYTkdcGdmgFqfDUXl1N8ZdftqybW1sSrovLQbKbsFg1eM7e0QMWvl2Pztix
 CtrrPtHYV7QCNreRZmpMs+fSeb+U+OId4nux2x0UTKASWL1dae92TkLnz96H9THSdKh4
 Vo8GjEe9l0UYduAo57bv91yZ5Hg0uZXF7A8nHFRuIP/04pktdPmZNv0auHoRxs7EGfo1
 sFXfJzIfUXES8kGlAnQjGlHluXiuspsh5FaNl+PvDjHjq1CBWvE2pW2AE+UcwlXc4PBD
 sIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360052; x=1741964852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTp52Om52JlzEKvgvtGomRWuf+tAauGk1Wv9ixJOvzU=;
 b=dKetYvnSouK6SNjfjg7232R+zXxvr6iFqFrnjTLBce2h/6bkCijQ18Jx+jrlaVf0I3
 PyvSzKGwT2rx/DmESHfx9jOWoOcNHvUu4uAApzL/uNhG1tuuTvyxHn7wTauB6K4ku8W9
 BClP2H3uC4GBonDLv0oN+P8+Kc+ChinE1HyEUEzcaqP1MfgbeKCPZomOIR+JutCq/oSW
 oPp0gJqWGl089Ab96OhfAEZfKt0PrXOGkg0k4LaJ04qR+HhqQHnXAIinkgAHiaWx8dJb
 Kp4If1RPOBIlX1zz96JyAVMbM0J2DWlr8qZqxX/SFgOTgqwB8eS+Jo+O4JWkZad43E0s
 eoHQ==
X-Gm-Message-State: AOJu0YynY0OQJEig1+2M+7uLZp++it9t/b7zgygzpqxLGTrR3IMHlkun
 uUEOy5hdg1f3TYj0jU+EI4DqweNfbkn30vhEJSYp4lEbSObzYcYhrbrSCXn0vH05Rlsis1GRaaG
 Z
X-Gm-Gg: ASbGncuiEG53uGGUsqF8cI8z1C/DjGaao4OkbZzVKMNBWxafXK3LtjcwexgbpbyqMkj
 HwdiWh3V2S1SB/Kmz7Off/Bs7lo2kzQkNdcpCY8E18TsYdUNHUJ2sX6V9TvWB/aLEogqWauOR2b
 mZGO0aqgVLTsAeZgHNLEN9QVnIOFnrA8sU0L8AuZxRjM2+ABc9rtiRcazR6UvNtojU+Fx7PwVk8
 DGLA9wCkg6SVZHKw2uOJZHaKdGiVOtl/hTFLI7KhuCmhCysssm1cH7V52YJ/9af1TS0AV0mG+Ag
 SrXnhUj4asloVEvmZPFLWGdfbUvM3vxXv2aceIooIeLeoLRQy2k=
X-Google-Smtp-Source: AGHT+IGdXHBWUY3FKzuin5VLAPYnMeHsue2y3O+JDf7/2IQHeOahlw0xvCJrLdbQU4fkwlB0rpNFUw==
X-Received: by 2002:a05:6000:1a86:b0:38f:2a32:abbb with SMTP id
 ffacd0b85a97d-39132d325c1mr1979372f8f.4.1741360052355; 
 Fri, 07 Mar 2025 07:07:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/21] include/exec/memop.h: Expand comment for MO_ATOM_SUBALIGN
Date: Fri,  7 Mar 2025 15:07:05 +0000
Message-ID: <20250307150708.3222813-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Expand the example in the comment documenting MO_ATOM_SUBALIGN,
to be clearer about the atomicity guarantees it represents.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250228103222.1838913-1-peter.maydell@linaro.org
---
 include/exec/memop.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index acdb40a9b3b..407a47d82c7 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -91,8 +91,12 @@ typedef enum MemOp {
      *    Depending on alignment, one or both will be single-copy atomic.
      *    This is the atomicity e.g. of Arm FEAT_LSE2 LDP.
      * MO_ATOM_SUBALIGN: the operation is single-copy atomic by parts
-     *    by the alignment.  E.g. if the address is 0 mod 4, then each
-     *    4-byte subobject is single-copy atomic.
+     *    by the alignment.  E.g. if an 8-byte value is accessed at an
+     *    address which is 0 mod 8, then the whole 8-byte access is
+     *    single-copy atomic; otherwise, if it is accessed at 0 mod 4
+     *    then each 4-byte subobject is single-copy atomic; otherwise
+     *    if it is accessed at 0 mod 2 then the four 2-byte subobjects
+     *    are single-copy atomic.
      *    This is the atomicity e.g. of IBM Power.
      * MO_ATOM_NONE: the operation has no atomicity requirements.
      *
-- 
2.43.0


