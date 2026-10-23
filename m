Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62420606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IRl5rlwG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3S-0003WP-7N; Fri, 23 Oct 2026 10:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3P-0003SY-DH
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3N-0006lo-Ie
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so5627515e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764928; x=1793369728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Cb10u2JOaNw7G+QXdySRhYmW9Zq6GXGNxz+7xwTMOhg=;
 b=IRl5rlwGB6g5JDGwAT/RJ/iIXMB17yQsP4+XtCq/2uySSo+v32AGmkcfZFMBN8Frlo
 IPRegbMzivnzpBR/5bZA8WjRmNoc9GCTrFjy5bBNKBg0kECave81RL8+l2nsT0ao1qH2
 DzDH+QN89eif/VC8p+xXW2Jpe79uxjLrTlfxWtt2RY4r+9j+8OQaxfq+xN2daEHYUh2P
 bzw4GcnBeX97cjRvYjoCuKKvKerNNvVDo6EOolY06tP18RZGPSTTac5O+LYIccixWksx
 8pKrMyg+NGPieqAkkVj/Nr9Vuh52c4bBVkuqxYhgnh2iOX8QFlYbse7divI9sLYg61bL
 //lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764928; x=1793369728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Cb10u2JOaNw7G+QXdySRhYmW9Zq6GXGNxz+7xwTMOhg=;
 b=HdKUExxF7NFYpilJNR7LTTeQWisa86sWlhHk+ZcJS2WaujpI1WoT9gBNrO+bIJ3zVG
 OC1QxsYbPNs33u6rDvVDlnT4c2+tdb178woFDwT4OePtaj2r+LZoVPZ0lUNl/+Fd8k+4
 15IfLssvwnErnBVMrktZ0NflKy0kESYngHseaRlji4IszEIjB8byJDsYHG3WyluTJGZz
 MlZ3Nw03FBzAu4krAYjepycv5ZxEFGrjjlmtShfxfo1XP+d68aUsaFN0bmn9tuWnSwCn
 DpB376qgrHT05Qvxs1C8nzzK0X6uQznS3I/dvF5qqQcXwRs8TOs4RwKPxNBM1WVvVnT4
 U0PQ==
X-Gm-Message-State: AFq9FYLRgtMFNCtjORSr/prA3KvLpOOSA0D3NNfuabAJ/Nag3lGG3c07
 yosVSTGub9CS0evwvS7ZolUPdg/ebXKk16U44zN1nK5qgS+xbTQLoKHwj/QaEAbJn11mhdL+ll2
 /l+/dkXM=
X-Gm-Gg: AYBFou2mIP6TFeKRG3oYALllme/1IG1djOSfc3JwbLQaSK7kOzldkWN6UBKiMtRK6nm
 Ha0ydFfcx45YbOm4FzDNb6h54nqLIsa3nAT1kplPatlipNSC7pXRcXtNpnBURNC2ec2C13AU2bx
 UQMEbpTYsj0AhALLFLHVim/0ltfIj1cvqXSb7PUOd/ZtwJBOXfg/6NMpF2phrVXQpdxitRJrShC
 SxQUhKgYt1DCNQRCm76ka7ZrO3f8pBWYXkWLhygvMXDwxUxI7CrRRkGQFTxaoMjmOPCexhyaHPD
 dmCCTX2i62aeBR6RHtMNgHmMA0ipXBT8bvXar0GBRWd92rZxBdRAdq+287WxELOaO6Y6FgMvHNA
 3wARhq9+J50JV6D/m39lYLTH5xQacGtUt6ohD8krKGIyTB9NeAoDwXbr4mW4ONn+eaJTDM9Qtfh
 PHkjctGK8/kRAkd66AWYnljdtbqwzsggfvXtkfIsq2Sgy7Dd/jxc7clOa+LzTzR64bSuo884wEa
 iguYEp8lnN9aI/TikpZykVsTNEE51vrJLpczhjV2r51ueJhN4W6RO1kWqlp/71e/x35wQNFSo5Q
 J7Vpp7t1EmK5Q9NCvrnGb+7P2J3xZ+YiE2U5eRKzeuz18Lu7LFLkAK13998P
X-Received: by 2002:a05:600c:4f56:b0:4a2:729:f7ce with SMTP id
 5b1f17b1804b1-4a211caf297mr53245395e9.8.1792764927852; 
 Fri, 23 Oct 2026 07:15:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] hw/intc/exynos4210_combiner: Make reg_set[] only as
 large as it needs to be
Date: Fri, 23 Oct 2026 15:15:01 +0100
Message-ID: <20261023141503.1397009-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
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

The reg_set[] array holds the register values for registers in the
"sets of 4 registers IIESRn, IIECRn, IISTRn, IIMSRn" part of this
device, not the extra non-grouped ICIPSRn registers at the end.  It
therefore needs at most 0x40 entries (for registers at offset 0x0 up
to offset 0xFC), but we oversized it at 0x41.

Reduce the size to what it ought to be. This is a migration break,
but we don't care for the exynos boards.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261019162217.3272337-4-peter.maydell@linaro.org
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


