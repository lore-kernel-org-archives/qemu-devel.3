Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53319C52CDA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8It-0006Mw-2M; Thu, 25 Jul 2024 19:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Iq-00064I-JD; Thu, 25 Jul 2024 19:55:20 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Io-0000p3-Q2; Thu, 25 Jul 2024 19:55:20 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7a2123e9ad5so238221a12.1; 
 Thu, 25 Jul 2024 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951716; x=1722556516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xijc/4hj1e9Cv15QuxISSCdUEPCfH65xyo31i+c5EP8=;
 b=XGXn6QWdCzoko5f4yEdM0bP/SXQFgWQur3COVcszgcN7RJt6uYxDu+XQ6KTUjCq+tk
 8B9/MKDGQRMi0K0Pqa2UcRO3kcFC/zqXpEDsUvC4z7VS1/5qQb3Zb2GXeRaV4bGRxAYp
 kzikluConS5RSXeGD1fwjXG69Pc2uEwDIQUCM/s9G/cjmEErvHlQzQiLaHTsHEewrFRY
 pXEZ2u1McFMqcHexqtYuGq5OXWSpQxwS/7qWEDoZ35CwT2iXflKE0DOchsI/AthNaX0l
 0eZ3s8jFKheg7mcn503+d52MuMrCbEDaDLW8UJaOhIZBmm+OwIGh5HJehJz0k+n9RXzF
 OkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951716; x=1722556516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xijc/4hj1e9Cv15QuxISSCdUEPCfH65xyo31i+c5EP8=;
 b=Tc9inltUuRTZrSRDuEQA0RDKgkz9fkGOvcqQkdJW5Rt2bTC1NXXEbwbYoX6ZoyWy+j
 4z9DZ/KFGY8Is5yFhkkgmpftjQfkj8mTTP9VYlfcsg+YK4iwVwDUfznpotyFKwflIVwl
 gXlV3EN6yZLaEi5BukGM6F415yBzoGwgSuyY3ck8jomvjYJ+BiX8tkM/qyA3Mdeu0Ihr
 8Ugz3bFixxtuXxLrDcpBsOqvtDpmEhFkdRVv69q0mIrkF9E4ozMlZ7H41Lg9BXbMF9It
 7p6E8hc8Bz6KcXIxs9IBti2wxI85oPrxRoGwiVZCJjs8OIklQZiLYL9yEpFwWFLhCXKZ
 e4Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE3gcTZ71kwilLqUOSI6x/wyxzwWGN5KhejWCT7/iLL3uqBIjIZ/Ppt1jv3UdpJ/I/4XUzE5Te834noXCMmSwn7wIB
X-Gm-Message-State: AOJu0YyX3Li6rNB5kIdj6ZBipOMPQXprcdNPlrmHBRyLcFP/aw8UjXW/
 5vcOR/MTjDx28qOD9Hrve0ZHAypHnJXS00QvFNn0/gnz8vHz63XUvohxMQ==
X-Google-Smtp-Source: AGHT+IEDDzA9AoAEhEezcu7/biaGMQV1jV7odWvx5Q/IUkKdHl8Jo3NKgTDaqSrMWfsbGpAylwjcJA==
X-Received: by 2002:a17:90b:384b:b0:2c9:a831:3b7d with SMTP id
 98e67ed59e1d1-2cdb9442d61mr10948294a91.18.1721951716413; 
 Thu, 25 Jul 2024 16:55:16 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/96] ppc/pnv: Update Power10's cfam id to use Power10 DD2
Date: Fri, 26 Jul 2024 09:52:46 +1000
Message-ID: <20240725235410.451624-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Aditya Gupta <adityag@linux.ibm.com>

Power10 DD1.0 was dropped in:

    commit 8f054d9ee825 ("ppc: Drop support for POWER9 and POWER10 DD1 chips")

Use the newer Power10 DD2 chips cfam id.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c            | 2 +-
 tests/qtest/pnv-xscom.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6b41d1d2dd..13cebd6ab9 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2087,7 +2087,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
     static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
 
-    k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
+    k->chip_cfam_id = 0x220da04980000000ull; /* P10 DD2.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
     k->chip_pir = pnv_chip_pir_p10;
     k->intc_create = pnv_chip_power10_intc_create;
diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
index 6f62941744..5aa1701ea7 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -56,7 +56,7 @@ static const PnvChip pnv_chips[] = {
         .chip_type  = PNV_CHIP_POWER10,
         .cpu_model  = "POWER10",
         .xscom_base = 0x000603fc00000000ull,
-        .cfam_id    = 0x120da04900008000ull,
+        .cfam_id    = 0x220da04980000000ull,
         .first_core = 0x0,
         .num_i2c    = 4,
     },
-- 
2.45.2


