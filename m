Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B608C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u363P-0004gY-AS; Fri, 11 Apr 2025 00:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363N-0004c8-Se
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363M-0007Vb-5a
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227a8cdd241so18848085ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 21:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744345903; x=1744950703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRZOC2tSqmQDMujWz+eg0jjAA3OFDUOED5xf58eJ/zc=;
 b=ia5Rn2c4MWihENVRl0Bc2Jh1EbjF2m737Z8/8IasW9lJ8xGsdHQLTiX17L7xJH+ri3
 0/PdSe7E4hwMqXMvhRXwQcgpO2tHQreq2GHw5KlA3UIBSIys/MKPvWKSComjufHy/6lR
 Keff+OHew+V/WN5jKyHLg4Z16Fut1cIaEZbGiAnv5JimvwbkgYSG1YTQRemgWCAMsOUZ
 NcVRPiwv1TIHUGHxu9/gYizsbavt2BEqDcvkXH9jqiXRip5v9M6WlVIhNqJNcza0qpjM
 ZDsr1OLAicwMheFVMW3ageaW/DeRrI091PiuUgnX3GHorq+AF4ZppOat3uncIkCeTRXo
 KB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744345903; x=1744950703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRZOC2tSqmQDMujWz+eg0jjAA3OFDUOED5xf58eJ/zc=;
 b=wlq3yJKzDfvqoz7/6T9K0gUsk3rxwleDVA8G1jzw6mocNsfP/59iO2l/VhNfZXDNIV
 1Trqk5mnjfJaDvTBxJWKmrBr+CQVoKwCr20YAIifsd8sJu6jV1jph7yw5xEMrOAagUJE
 Fo2tpMN4gKmDX4ArLTwO46ricfzC3PEpvSBAphWyEPsn+b43yJMGmiDdHFel3J8GA02O
 uPs0cxSRcgApL0LP1aRtTSdrK7wgWeXQIWkynX/NripVMdw96f1Mn/d5v+qwR7HyiUKB
 9rHDrwwQ5YFW7jDZj0eU6ETQNQeVA+8SpzN3odaqhtTS7XZsCRdxrG5i2+PUU5NrMIT3
 DeVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoFTvoixQsnQQiEb01t1rd1oxMfptmrRhCUyIhTvH9VgT4wbod749HBQM3BjuvqdWcYH6d0cxnomcC@nongnu.org
X-Gm-Message-State: AOJu0YwouMHMOVbL/fVdkyBt1EWwX4lE32sKhXKvr6kv8vPzlsLcGYSi
 n8zTHji2hYqZkd9G0uErPBibdWigrQdu2vESDncjibF8CJRpOD1w
X-Gm-Gg: ASbGncsxd05K5nh6coGIHn5ki1CaoxzQfluiuFrFOo1IEkqylMgrt5De7RS1ADRgOk2
 EkzUH40r5Fq5dUXN+A98QT6z1wmIY+0DxvpyyFew2v2CHCMPlHdk71HKhTvnytEchRstQ4ZUYK+
 cLwQfl0dTwRomG2AL6ktbi0Zpm5AF4LHOU3xTHf4mHWXhARamyUYvN4xJ9YCvMSIx55eX+Ijq4e
 ow/W/tn3pzAaBeCMh/L4iJEepxXnGppVLDb9qeP0rLLSonuH8vlW12znWRXltdraLyG72TYH32/
 +VisVsuL0OmRJWG0r/WxDmKQ3yL85EQnSk64CF9UvpM1
X-Google-Smtp-Source: AGHT+IGW1SClwUYPaaFK53VuXDMjMaIHkjVB5P0LSj7LWWBcyTDTv1JPd0EizIhD1djdZ2Cfjrp+/w==
X-Received: by 2002:a17:902:f710:b0:224:1935:d9a3 with SMTP id
 d9443c01a7336-22bea4aba6amr18988835ad.21.1744345902590; 
 Thu, 10 Apr 2025 21:31:42 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b64906sm39361625ad.48.2025.04.10.21.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:31:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 1/8] qtest/e1000e|igb: Clear interrupt-cause and msix
 pending bits after irq
Date: Fri, 11 Apr 2025 14:31:21 +1000
Message-ID: <20250411043128.201289-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411043128.201289-1-npiggin@gmail.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

The e1000e and igb tests do not clear the ICR/EICR cause bits (or
set auto-clear) on seeing queue interrupts, which inhibits the
triggering of a new interrupt. The msix pending bit which is used
to test for the interrupt is also not cleared (the vector is masked).

Fix this by clearing the ICR/EICR cause bits, and the msix pending
bit using the PBACLR device register.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/e1000e-test.c | 9 ++++++++-
 tests/qtest/igb-test.c    | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index de9738fdb74..746d26cfb67 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -66,6 +66,10 @@ static void e1000e_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
+    /* Read ICR to make it ready for next interrupt, assert TXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_TXQ0);
+    /* Write PBACLR to clear the MSIX pending bit */
+    e1000e_macreg_write(d, E1000_PBACLR, (1 << E1000E_TX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.upper.data) & E1000_TXD_STAT_DD, ==,
@@ -117,7 +121,10 @@ static void e1000e_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
-
+    /* Read ICR to make it ready for next interrupt, assert RXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_ICR) & E1000_ICR_RXQ0);
+    /* Write PBACLR to clear the MSIX pending bit */
+    e1000e_macreg_write(d, E1000_PBACLR, (1 << E1000E_RX0_MSG_ID));
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &
         E1000_RXD_STAT_DD, ==, E1000_RXD_STAT_DD);
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 3d397ea6973..cf8b4131cf2 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -69,6 +69,10 @@ static void igb_send_verify(QE1000E *d, int *test_sockets, QGuestAllocator *allo
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_TX0_MSG_ID);
+    /* Read EICR which clears it ready for next interrupt, assert TXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_TX0_MSG_ID));
+    /* Write PBACLR to clear the MSIX pending bit */
+    e1000e_macreg_write(d, E1000_PBACLR, (1 << E1000E_TX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.status) & E1000_TXD_STAT_DD, ==,
@@ -120,6 +124,10 @@ static void igb_receive_verify(QE1000E *d, int *test_sockets, QGuestAllocator *a
 
     /* Wait for TX WB interrupt */
     e1000e_wait_isr(d, E1000E_RX0_MSG_ID);
+    /* Read EICR which clears it ready for next interrupt, assert RXQ0 cause */
+    g_assert(e1000e_macreg_read(d, E1000_EICR) & (1 << E1000E_RX0_MSG_ID));
+    /* Write PBACLR to clear the MSIX pending bit */
+    e1000e_macreg_write(d, E1000_PBACLR, (1 << E1000E_RX0_MSG_ID));
 
     /* Check DD bit */
     g_assert_cmphex(le32_to_cpu(descr.wb.upper.status_error) &
-- 
2.47.1


