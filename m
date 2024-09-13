Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1DEFA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80n-0004Ll-GA; Fri, 13 Sep 2024 11:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80A-0002Aq-Ca
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp808-0007o8-Os
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so22129265e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240463; x=1726845263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ZFwfAVKTgNipDHShNCsT5K1gdfzcBV1L7/A4/MYLhs=;
 b=cPzIHRupc9mfN1ExCtvRcXcrpF98fx2VdQ+istq/Ows8KUQE5UOwWfHc3+D3Zh8N8u
 zZ4jpm5Y8sIJSntSQ31kjw9sRFk7/byTZdtEd0tA+FCFwTpAjZUpZQeiusjk4lHCGOXw
 eyquFRdXShMNGUNsAgR+MuOR6zKOVI3cTPryFgFKVqhgnwsF9xQ1Ojhwk3zLReh7ixVg
 grg4OtXcdxCpa9eaYS05uFqXUXdPXXTkC7Mio3mkmLsmvzChODaHtA1PkKTcXy3vbZ2z
 V7AjnaDKFvI//Lt/wUfOW6TXxSaFHJ+1i/sv1kchgY++ZzoRvwBLqkcP3Bkp6TaiMxQ3
 dRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240463; x=1726845263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ZFwfAVKTgNipDHShNCsT5K1gdfzcBV1L7/A4/MYLhs=;
 b=C2TT4Cpaj1Wwjjikseb8qtmdtLAIba1CRFoXPTz/ER6hPb4guD5zlOxAL9cRSHXzfC
 PtfKGmQdc2A+GSccN4VRc97/04P7/csHRjFBz66I91fhFwxJhYkil9qfLHwY0xor0L6+
 OzJPLHqm33o8mkaS112Jxb9ti5u/+KnCRgh4NQY9WobCDPEnzBo1Ty45N5wovMl8p8Lw
 cVIRe1F1k+RGOhcsLrxjJuKgZappB73fjawHyUjROb1Zlryc6jTUmR3zHMVzIM7FnHI4
 P8kQH1sOKZkN6B3vz9U+nvst6GtXiTwUcXqfjtBmcwz2SmMryMLt/F79ltUgE1l7cdu0
 o90A==
X-Gm-Message-State: AOJu0YxmiVkk7foWe5LbwAQETuD486LUqT7A40Wb0ATLFi1hm9L7kAka
 N7ir/Q4wmDjW6VsLe9LrfXfYS5s5Yn1QmLhAj2dBS6WqKSBWyqQzwt3XjaDuk3F0VvQLc2HY3Yj
 e
X-Google-Smtp-Source: AGHT+IFFKCP0NoR03t4tL3/mvEffrOJ2VblDT5XUshbXTUEms8yHxFG0E66PQVwzZ3yoBh1hwJNiBQ==
X-Received: by 2002:a7b:c453:0:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-42cde34376bmr49875985e9.2.1726240463099; 
 Fri, 13 Sep 2024 08:14:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/27] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
Date: Fri, 13 Sep 2024 16:14:02 +0100
Message-Id: <20240913151411.2167922-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Doug Brown <doug@schmorgal.com>

When checking the QEMU_CAN_FRMF_TYPE_FD flag, we need to ignore other
potentially set flags. Before this change, received CAN FD frames from
SocketCAN weren't being recognized as CAN FD.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240827034927.66659-3-doug@schmorgal.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index f89dfc565b5..add1e0fbf17 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1003,7 +1003,7 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
 
         dlc = frame->can_dlc;
 
-        if (frame->flags == QEMU_CAN_FRMF_TYPE_FD) {
+        if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
             is_canfd_frame = true;
 
             /* Store dlc value in Xilinx specific format. */
-- 
2.34.1


