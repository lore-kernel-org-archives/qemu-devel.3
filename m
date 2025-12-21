Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EB4E66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKMB-00024V-Sj; Sun, 21 Dec 2025 09:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLk-0001Lb-SD
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:59 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vXKLi-0001Q9-Tq
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:23:56 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-7e1651ae0d5so2475560b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 Dec 2025 06:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766327033; x=1766931833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwo1mKiMyT/GajHYoh8G0G2szHYZLyV9nC1hl1YqUaw=;
 b=PM/5GLtR6KotrkG4T2Vv6XRsChCJbpB2eEYCqJuKQc7HM5zVUQ+f3VrSlZvNPmljEn
 GfNJdVdj05b8huTo09efwGv9pg+1XBxqlKR8EAqEGB9dYgTbBYwJV4ZInSXUvh9dw+xA
 MroY+EvtE0mGLVun21TDnL46kf7UQCeLpJ6I8WmW8hNNgW9t5JGe8p9zrRa7OXYiDCnk
 GoVT+5ocNc4f9a6881HTRmBF4oSIxJvIh6xKKt4BMgWHpYCXr79JzaTHjOA55mcx1enp
 LAgoTSbx2v8CrE/1PwK9igKHr5wquUaKqgx7GmQL+LZMJKZgnG7N4N/7pKSp10XGiHxe
 Rqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766327033; x=1766931833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rwo1mKiMyT/GajHYoh8G0G2szHYZLyV9nC1hl1YqUaw=;
 b=CPaxUOmkgpLMEBoioNMdyeW+FSjYgD9/z2ukAKWGzNdj3eWzN0arhAKfSwdrP05eGM
 Mta4tLSRKMXd3VAzOrnHe97NLf8yA6dNiiCz5T3I2xydG31sGhNdQ/B9Zk0YC5yhdvRV
 j/mbV1Ap5/9goO0TidYnZeBhmEh+HAJPCP0xeNcqm5ey2PoDDnWfveQJ8xRI+zmoT22n
 kdCjZj+sgFABmbUuDxCXFGF5bFxHmNOBZIqPrpGMKEFNrH02KyIvI7COtcvwFSq6A3pW
 wF6rc45DaeWEvcTxwlH92cz4KZ8n/8ufuHlSZyeQGUV9wHinoFG7yJTrK2pCazR8EFnl
 3LQA==
X-Gm-Message-State: AOJu0YwPNo5ouBKnvN7FAjyTJ0kJgDy8d+wAPK8HD+URDUA3wpO47cRS
 dbn/JNPQOATHEZZ3YyvFmXFZj5uKwdQIOpkVp+KmcrhPt8ZV17Xl5k7GwAvNhh1w01o=
X-Gm-Gg: AY/fxX5Fb/KAN2lPJJjVThwqTAxvCrofhm+/LnaY4s5CCwgmoULzpSOntyiCFOSDIyr
 78UF/BLIO7BEk+AdHKAnCCtdoY5xG0a0CA0kLLx9j3LjyW114TupyIph/UQjj8YVCSjQACxC7HA
 mB4wX8uFsjDQLTInEa1rZhlwXBIpngpU7tSZJqh4qUjqbUQmCIgIcMjFXzlL/Y8jxdTQh2eWq7m
 7effpUu/79k0Z4Cg3oam/MOofOo18gbAq7wQPi694M14/60vTa0OSdArL7zNs/+yq/Yfzpix5vS
 Mpnfpu95OphUKKcyFBIfv5Sq+RPTamH/70U9qEN5nX1ke6ED8EsR1kGFQ6MB+CoCOTSsQORzJoZ
 J7Car7EdzSYcDXhfiT4oV6qQlL7+/djqUR3CzsKO9ZDszUo78zadbTdZC5vUK6okOGQJAxrBGrV
 ohHm6PFl7hlmAKR/xZ+7k=
X-Google-Smtp-Source: AGHT+IFv6dh3tArYH7aFS/i++7JDH2y/UAX/tNgQgqrvomDz5RTgLpU2OTYZQzXVEFJLu9g9AZi6+A==
X-Received: by 2002:a05:6a00:1d23:b0:7e8:4587:e8b9 with SMTP id
 d2e1a72fcca58-7ff65f7907cmr7696060b3a.44.1766327033330; 
 Sun, 21 Dec 2025 06:23:53 -0800 (PST)
Received: from fedora.. ([118.151.210.82]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f258sm7590449b3a.47.2025.12.21.06.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 06:23:52 -0800 (PST)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: qemu-devel@nongnu.org, deller@gmx.de, sarkarsoumyajyoti23@gmail.com,
 mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 10/10] scsi:ncr710: Fix CTEST FIFO status
Date: Sun, 21 Dec 2025 19:53:17 +0530
Message-ID: <20251221142317.266293-11-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
References: <20251221142317.266293-1-soumyajyotisarkar23@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pf1-x441.google.com
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

Update CTEST1 FIFO status when CTEST8 is written, setting to 0xFF when
FIFO is flushed, otherwise clear to 0x00

Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
---
 hw/scsi/ncr53c710.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 0ea1fc43a3..cdc365478c 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2161,7 +2161,11 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         if (val & 0x04) {
             ncr710_scsi_fifo_init(&s->scsi_fifo);
             s->dstat |= NCR710_DSTAT_DFE;
+            s->ctest1 = 0xFF;
+        } else if (s->ctest8 & 0x04) {
+            s->ctest1 = 0x00;
         }
+        s->ctest8 = val;
         break;
     case NCR710_LCRC_REG: /* LCRC */
         s->lcrc = val;
-- 
2.49.0


