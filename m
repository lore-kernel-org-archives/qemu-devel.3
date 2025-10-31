Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A35CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 22:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vExxR-0003XN-RC; Fri, 31 Oct 2025 18:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vExxP-0003Ww-Q3
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 18:50:55 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vExxG-0008Nv-2I
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 18:50:55 -0400
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-b5a631b9c82so1805673a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 15:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761951041; x=1762555841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NmkZm9kpgt+I+e7k33D/Bb/9YNltO23PIaBpp8hbaG4=;
 b=Rs3WGi5yiPPSq+buoN230EwigPkGnbBR/7gK/xPGhjW0fmJfGuEKCN7WUlj1uKpR63
 oQ8wBKsp/LMc3/eyc8em/TGMgLTuO7/e2nO7SM0D+7jGeU3t9iP74vhO37orfb2Lppf6
 u0FlGYWO5x/fcF+mhRmddVQ8OJt39hbc8U8XelBSbuMh+jw1v90dM11rAeZJkjwnAuGY
 TGCUrK/6EYWF8FrreGA8qK71ArFDJUGlwDXIOBKPRhI1ZiTZwVPXr7Ss66HjW4zZoVtD
 fIOAhWQTV25Na1BNOoNFgRNnSxMGj8tJHn3B37ri1W8HVnl83J9/3/ieSduobETH4nUT
 IPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761951041; x=1762555841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmkZm9kpgt+I+e7k33D/Bb/9YNltO23PIaBpp8hbaG4=;
 b=h0iZ++aV9gieA3lqbsFnIJNnbsA4FyQUiAcXZITsDotvtSW100AGy1rXwf3hmS7kyc
 YFyNqijLsbkX6d9elut0+UcrgMPBkloeC9gbUx/bvLp+SoU1eOA4Mu1Mm03jAXZtUYjV
 Nd5xiE9teP54YiM1uK4E5U1/5nHhy3zZgffAsuL/N7qSBcQk4ZzonoYrV2vt60zXvEBO
 yVCtHjUdIfUc/FWusLToEd9m/FvcXt4ZDefDuGcbEVQA3pdxqv7pTCFMWAzXBadYdzIb
 al9t/KqwXK3V8iIIkk3wjvwlybFQ10qad69Lx789EkxDPtYbCEzva/4jMJpVEsRIJAco
 iPRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYnRiW6/wxIw/+gBKJDM8fXiDXkOM3Qs+q+obDXjyiJ5/gvi7GuHdHm+Hy2GfwNjHMuyzgwZTyB2OX@nongnu.org
X-Gm-Message-State: AOJu0YzPbicIfZjAApCTaeATL+nR7PmLUVL4St6zWOW2ZMPIRRxVOLdt
 rvDM1fLWvlEN7sEXWv94wjcYBh3/Qjhw9sIArexwTCMCbR2UdAKMxL7Y
X-Gm-Gg: ASbGncvC9b53uAXp3wa7S5I1mBC69h4MePKEwjAumYgkWF8YssmffhN4IMXr247SNxW
 yqKJzyMTsaRyKwZVyfNj2lafVYF0AXIzcfx/4N/mY7v7OXp0jmNY7yHbDGFoSaeuWCbh34051AM
 RkTPlaJxauSTqotSBge1+6oMH9YDhp+bIpm2iwK795GV6QqpMslPuWEmlF6Zbbc/6AaL60XI8qm
 WDrbcRFGDl6Lgrebpd95aUogPnI2q8HAh7bYDlamoRr31hqAuRm9dkRKBqt3PAvRbILAPkDrcQM
 WYH+1OqWSdLjTNY+p0TQUTy+jxQamt7qbm9PmpSIUTdtsuA7EsKpHEs4HqxY5tA/hsdcDu7J+vC
 cVRn4JRapZHQC+bCdqBTNbnXjHaIy42yRGWD9alWWOF/rVKhFtovFG6vt+Mqh6kMy/i24xm7Mo0
 B8sn8sBnR4XyMrmZUKmMLDolP920lytXnylsUz9XE=
X-Google-Smtp-Source: AGHT+IFkE/Wy5pSHPg6yTWg0Vpr7sUweZZlKW8kujlK0LXzIF9O5T/mbO/JhjRv+DMNe1nJTJV4LxQ==
X-Received: by 2002:a17:902:ea0a:b0:294:fba1:94b0 with SMTP id
 d9443c01a7336-2951997e53emr67886055ad.0.1761951041350; 
 Fri, 31 Oct 2025 15:50:41 -0700 (PDT)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2952699c482sm35599365ad.80.2025.10.31.15.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 15:50:40 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: deller@gmx.de,
	sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 RemZapCypher <soumyajyotisarkar23@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Subject: [PATCH v2] hw/scsi/ncr53c710: Fixing defects reported by Coverity
 Scan for QEMU
Date: Sat,  1 Nov 2025 04:20:35 +0530
Message-ID: <20251031225035.229422-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pg1-x543.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: RemZapCypher <soumyajyotisarkar23@gmail.com>

Fixed Null pointer dereference & Async/Sync IDENTICAL_BRANCHES issue
reported by Coverity Scan.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
---
 hw/scsi/ncr53c710.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index b3d4593b72..dd9884c8bf 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -834,13 +834,11 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
         }
     }
 
-    /* Host adapter (re)connected */
-    s->current->dma_len = len;
     s->command_complete = NCR710_CMD_DATA_READY;
-
     if (!s->current) {
-        return;
+        s->current = (NCR710Request *)req->hba_private;
     }
+    s->current->dma_len = len;
 
     if (s->waiting) {
         s->scntl1 |= NCR710_SCNTL1_CON;
@@ -1367,11 +1365,6 @@ again:
         case PHASE_DI:
             s->waiting = NCR710_WAIT_DMA;
             ncr710_do_dma(s, 0);
-            if (s->waiting != NCR710_WAIT_NONE) {
-                /* Async - stop and wait */
-                break;
-            }
-            /* Sync - continue execution */
             break;
         case PHASE_CO:
             ncr710_do_command(s);
-- 
2.49.0


