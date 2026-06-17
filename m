Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB83CCD98E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 05:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZj1Z-0007Kx-OD; Wed, 17 Jun 2026 01:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZj1X-0007K6-E4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wZj1V-0003vd-U5
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 01:41:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c6c57c5bcfso737275ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 22:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781674872; x=1782279672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8kDKuGdmXQ0qjXWUf1LvEVQeOU9K5mmWBPHFWVh0nY=;
 b=PjKyMDWCtbCr2jWTsqsiWXhF20Xhzgmh1o5GXyik5cfI+A9V0uMSHD1Tcel437Qsb/
 uVzthz1fzHRyX40uL7fFhqlMqX3QndX/K4jsXAqT4XBk7IIVR9PP1k45ihx3CzH2C1dr
 TOCT1El9vXlmTljJXzLH+OdBqqDtiGwy01AeQY/0vpBnk+j0xnNj3+ldnT0v7eNk3DP5
 0TuEmDVzkUKzUk4tfNbyg30qWAG0PQyHBAU0tN6YWw+mrg4zKcVJEkjVLHKwv8vkGHuR
 3iDfChnOme/t74XQ0WoeIU2UZ3lkQH6M2y5uQnOY2oTS4NphVVdVhxLHyWFfRBGi+Eai
 oe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781674872; x=1782279672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c8kDKuGdmXQ0qjXWUf1LvEVQeOU9K5mmWBPHFWVh0nY=;
 b=Cf5qG53gc+6Pl6cmJtX/iCRLTuzylcJakRNGbKzeVJiqY4zWn10pnZhAumQqAIz+1e
 xQdxvf7e4ZnBN1628q4n4VrLf0yGdDf/JQMF1LiV+U2dCuZjdfnu0EqzHxD3SEtlxf58
 HEx7lFjpDhgXyOJqsXsgP2oAQPiRUkHvLPEOl5TpPkvs3pyg77z15lKSeOYXsjkPKRmg
 M/UhpzGmxWSJh6MR35Q2N0TZcJHqcIwcrhMVnroJchVh/TbhALPdLvp1Nu1rR2+WUVE3
 YzRbDEf5BjUhOc5KI8tBy4YCwKIB+GVwJ+E+hBtJgDaO8TTU3wSxqk+Bjp6gP/KAlxIA
 7KzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O+GLRiSobIHunQCK7jouxUv1IQudZnxiqjkLQim7vqlPfPC/peDF2cXtfipfAMzrnbRMQofuKWKEk@nongnu.org
X-Gm-Message-State: AOJu0YwFsUlkMMcgt3qNvPb2bF7eilZs+dwulIuBp9v1ixL4cHC4tM6t
 2ei01bsie3l4ICZH6scdUKNgbNwG7uR0VjeFWNOPjfaM0/Uy+JnCk+nx
X-Gm-Gg: AfdE7cmzlmf6frAomkMU3LffNrixNubwSsPJgSktWODSUm30JCDWClsQfrx5qQT0xL8
 mPtv10c5wMtMBYqJGADOy9A0DmfwOYJ3vjWsR2Gl/J9vsOFyu97z8wGXhGZxx753XeEcLz7i2tV
 z9Ev0IhwDlyKPt+9vvztKrA2Out4EW+7ANzcdm6HfWqFyO7O6MFkjdnDM32i8qH1nyi8Hf7wwkC
 o8SKU0pqzwrybPnIQb1wrnBVGHSXZG+E6p3jHsvC+Us8mlV5OAAWldbMxyD020op1sj6/SMaTyI
 ptFeq5+MD9S1J+Ms96jbCp4xX5c/iErYNKBrufE2to658KCtkLaMhPkEotxtZ9tj0bAGUl9yqht
 eaccOEgm2vHLFh3eLU0vCyKZroUS1r7KaQ8BUd6VgfvuovV7PIlzPx1zura91vhe/x+vqK6L7HK
 JFaCBmSp0ZbLvwlmO3XQR1eQI23rJXrpcsP1LZvWTINZY1Q9hKIBSbzQO/Xc6uEUka6wTRQRyiI
 mLgOJCTrpzgWS2k5jaWtReGaKkD/OC0RFTmLafdReY=
X-Received: by 2002:a17:903:46c6:b0:2c0:fa4e:91f6 with SMTP id
 d9443c01a7336-2c6bc0bdcbdmr23719745ad.13.1781674872510; 
 Tue, 16 Jun 2026 22:41:12 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433078264sm149294725ad.65.2026.06.16.22.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 22:41:12 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: alistair.francis@wdc.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] tests/functional/riscv64: Use newer kernel for tuxrun boot
Date: Wed, 17 Jun 2026 15:09:27 +0930
Message-ID: <20260617054034.1020724-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617054034.1020724-1-joel@jms.id.au>
References: <20260617054034.1020724-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The published tuxrun kernel is 6.4 which predates the introduction of
AIA support in Linux. Update it to a 6.11 kernel, the newest build
on the tuxrun site.

Boot times on a laptop are slightly longer but still reasonable:

                       | v6.4.16 | v6.11.9
  ---------------------|---------|--------
   test_riscv64        | 4.82s   | 5.56s
  ---------------------|---------|--------
   test_riscv64_maxcpu | 4.94s   | 5.30s

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/functional/riscv64/test_tuxrun.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
index 0d8de36204a3..43d1242be52b 100755
--- a/tests/functional/riscv64/test_tuxrun.py
+++ b/tests/functional/riscv64/test_tuxrun.py
@@ -17,8 +17,8 @@
 class TuxRunRiscV64Test(TuxRunBaselineTest):
 
     ASSET_RISCV64_KERNEL = Asset(
-        'https://storage.tuxboot.com/buildroot/20241119/riscv64/Image',
-        '2bd8132a3bf21570290042324fff48c987f42f2a00c08de979f43f0662ebadba')
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
     ASSET_RISCV64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
         'aa4736a9872651dfc0d95e709465eedf1134fd19d42b8cb305bfd776f9801004')
-- 
2.47.3


