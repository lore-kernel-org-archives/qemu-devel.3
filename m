Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6093EC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zN-0000bs-Vd; Thu, 20 Aug 2026 10:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zH-0000ZQ-Pv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:23 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zG-0005BG-0T
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-499b57cf2f3so3247305e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787237000; x=1787841800; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZaviRMEZTGypIQA7N5P6+n+kL0KfH+GkmP5oLcPBN3A=;
 b=pBniTOKdE440QtkyGmvUSJB0TXQ2VgifwWyv8h4LcrcRppwUtDrBaXXWvSk1rlF6is
 KEI6EqDzZ0woPMK1aY/XD/Gk9JULssWPHu5SGl+5ugq5TgFXuPKwAvMa7tj0QVYbC62a
 yN2pzAdQVG2uQA8SuwcsoF9/AyaemDsSii3ucD6LIbEQgUAcVLSXGwpJwVt0JyM0fL/t
 YzdNZ/BHbxNoz+nX+d9pL/vftI7coCSmdckk9gKopd2YE7sHmPghWh7mmixEXJiUWGRK
 wqvbnAPMJ2g+sYXRm+LUV5g5wT3xfHVNgE+M6rtbPyjFEoecy11FKV78pE7g11HfUVdS
 F7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787237000; x=1787841800;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZaviRMEZTGypIQA7N5P6+n+kL0KfH+GkmP5oLcPBN3A=;
 b=j5kl0p+SNH3MzRrmr54F51H/VTPezz1fySL+guZBplUEgaxBv+SoHL2rqgT0Ca47RD
 PyrLjewdK0KEiZ4zFKL9ugq3xu9e6lFys4etAaHQr4tJsa7fbI219U8n0YSOuGbkeifA
 pi6XvpTX9CZYjXKiyHRSZkm4KqRa5kcK1oO7+9Siv2FUoaRAEf5JPDR8VwOUIRCBvnqy
 dH8P8qhLHLhU2CKqEh5iubQurQneeXZAsqkbyG7vxyH0qimU0zX7ai0Q0etTroWEEgNW
 JiUdZEMw3CCMmeGqdvis3w619w5qSPhXYOqf/OBQzat694xDITnfnUxYk8luQr1fC31O
 MpPA==
X-Gm-Message-State: AOJu0YwVDHDLARmqud9Td8eENkj0MeEGAKE33Q40eJDLfXbprDUb61T6
 e90OXjtJgnZHa35k5vEWhNpcGuapEr50jwlXk2toeGj8Qgn3Q1eSwAtsqOozDnRpNPkSyTJtKEL
 8z32b
X-Gm-Gg: AR+sD13N8KqsHPh/KoBXiEkP187KkoDxa/s33GbTeCJVx/VpjhXZTe+aaKR/pYnmgcA
 WXpwA+Own8ovNFpqUZTTZ0LnsvRSoBILovIyYiQYtn1G4BYGATerPr7G1pc/DnkqaMnhjiMLOpi
 cFOsdWuej/yCgAhqD6U8h996Jqh95xjp+ITeOw7YvSoX8aC0eCDuSQuaIy5pIhUtVKkI4S2fa8q
 WL3/LR/Hrwq0YaJoYNWz2w68RJzPRe/r+fO5zxyfuaAuBnoxQ+aEKg+ZMmlHPhoMpvIT/VD9cep
 Nkl2WjlCoPSu4OfGeLxQcl8lYyTp9mU0vjL61K13MWO9zscjNDh9s7xcCwQfV+E/6u9JaYoAt+w
 8kUv+kiiB/hLwWBu8x662Lr59OzJOetTbVcrBBf+rVOhXQtILxZzXhtBGPJhxj+tFW/RBP7LHR2
 37ynnXtG3mBiPLtTSbxG2wSwRy0qOanZl7Z39NSxa+4G190EPwFqpJKtYu+w==
X-Received: by 2002:a05:600c:674a:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b06cbaf2mr111834105e9.7.1787237000489; 
 Thu, 20 Aug 2026 07:43:20 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:19 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 06/11] hw/ide/ahci: treat a failed PRDT walk as a PIO transfer
 failure
Date: Thu, 20 Aug 2026 16:43:04 +0200
Message-ID: <20260820144309.835173-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=den@openvz.org; helo=mail-wm1-x32a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

ahci_dma_prepare_buf() returns -1 when it cannot build a scatter-gather
list, the PRDTL of zero case among them. ahci_pio_transfer() tests the
result for truth, so a failure sets has_sglist and the transfer goes
ahead against whatever s->sg holds. AHCI 1.3.1 is explicit about the
zero case: "If this field is '0', then no data transfer shall occur
with the command."

Test for a positive byte count instead. A successful walk that yields
nothing to transfer is already handled by the size check below.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4043
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 4c138b0c51..436a0eaab6 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1428,7 +1428,7 @@ static bool ahci_pio_transfer(const IDEDMA *dma)
         goto out;
     }
 
-    if (ahci_dma_prepare_buf(dma, size)) {
+    if (ahci_dma_prepare_buf(dma, size) > 0) {
         has_sglist = 1;
     }
 
-- 
2.53.0


