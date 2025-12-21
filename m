Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15276E66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKMA-0001wu-Tl; Sun, 21 Dec 2025 09:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLe-0001JG-BJ
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:54 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLc-0001Js-UB
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:50 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7f651586be1so1489200b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327027; x=1766931827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XD/BsROiENdr8y/iTNL+8rSfBE9xfwKYoALONG2xb4=;
 b=OLsiUa4xy7Bxwoy2cD6UXQPE6JEcCVnzHLLowUKS+pvGhMsrv/+AJlTA2Pkqymc0Nr
 ZOfHBIjWr4GoCPZS5ho7oRGwxscmPRhKeOkHAcnl3QDVlvUufxAxZzoeY9+gBAkcQeqd
 gxW3BIz8RFywSI4gUzs2kLucezSEiA13VPRg05QZZvG9CPIR6DvCtHk+0ZNKuYY8pj6Q
 bx7113zZkskWi/QrXIwWhkyKXkqaHnWrnhybP72GT8WErURYHoNNupldryrXJSVG/PZz
 aYklIxoioxpVjI/0V/RAi2pFDRKvJ3UQbhQdUoKHt3b6iiPVRP9ug3Ah1Lv1uwh3k1k8
 InUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327027; x=1766931827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+XD/BsROiENdr8y/iTNL+8rSfBE9xfwKYoALONG2xb4=;
 b=TKstD8YQLCPziXV/c0xXzrWmk6O+Bhqoy8Ib9mLsPaUjyD3LexlwiilNFr72Qd+zeq
 SudxmUWaJJF5Vj1YazzB3bnxqhMzPRKOTKSbpCbzEvg7QB/tPfgiOIL8wJo+zxZRBRay
 TeGoatSP83ReA+SP9ahRFHBQxxqBjHlOMKwz0E9Tx/DvHg6utb1cIsJGNROEF5CL+6Qb
 CCsLRhCtwv5wie30s5H5auuxDm8jeiNUirJcWXBSo2A+/wFyWw9ICUOQUTlmg0HCRl3w
 9JYnS5b1p3/qCi5TVZ2BXJnJ8W9g7bQNrkU3RuGUGUg7ei0AwTpaSZWA6I458xREStO0
 R1fw==
X-Gm-Message-State: AOJu0YyhR7p6JZUdhE/+AtjqWajrYTIXjQRk/ELPRS4DX3o1dA2J/nlI
 k/suZHg1yIPJMwo4UsVYg+wZqim5v4X9gSCoIF2757xSz2H7iVzBd87bAXrpjdxFRC0=
X-Gm-Gg: AY/fxX7uf2Xtri83AYRpSJ5bEd12WmM4PXY5015t8WIAqG2NpP72XN+AW75X37KONoP
 JuL5LiGn/n4N6amONGRJpY48giHJGkqfNky6EP5J6si0cpoBdwjnK3u6IHw/3IIVuC/Ga5fez8L
 E/V7U0wDsA2+3QgA60H+GPzSq3O+pI3JbI4xQ/QSGrrqgH0gaW+yaZrCkXGWHpDHGEl8+ueocp+
 0HU+eZT8CEbxXH9R4y7FqhkJCS/PJVOBMV2v/ItHMQAxFZ1b8srYPgZ/0XxJRxvpvY4MFvrCseS
 oA9H8xRR38Nw0BSfe/9LexbdurRJSaorWiT0UVMdKByYwehVbr1OQAL4gqjEZyiN0IacFuXjRiI
 ik+9A7iN5BZ6slXGn6I+aFIcdVQyjaw5QC1Vp1uCD319QY59c/AiW2/Ski9WwtYvemY2KoGeOuQ
 z6VVCmPr5GW8nU1mrZWeg=
X-Google-Smtp-Source: AGHT+IEQlWnTY8GRCL0pTDpnbTWuCxP2kE8I43+GuNrZBQ+0tDnZ3FTmWlgUB2sssrF0ItHkUNpoSw==
X-Received: by 2002:aa7:9903:0:b0:7e8:3fcb:9b0b with SMTP id
 d2e1a72fcca58-7fe0e8319bfmr8133826b3a.33.1766327027336; 
 Sun, 21 Dec 2025 06:23:47 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:46 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 08/10] scsi:ncr710: Simplify disconnect handling
Date: Sun, 21 Dec 2025 19:53:15 +0530
Message-ID: <20251221142317.266293-9-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Simplify disconnect instruction by unconditionally clearing waiting
statements when command completes

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 277aa2c3d3..dd453991e0 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1469,9 +1469,7 @@ again:
                 if (s->command_complete != NCR710_CMD_PENDING) {
                     s->scntl1 &= ~NCR710_SCNTL1_CON;
                     s->istat &= ~NCR710_ISTAT_CON;
-                    if (s->waiting == NCR710_WAIT_RESELECT) {
-                        s->waiting = NCR710_WAIT_NONE;
-                    }
+                    s->waiting = NCR710_WAIT_NONE;
                 } else {
                     if (s->current) {
                         s->current->resume_offset = s->dsp;
-- 
2.49.0


