Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D8CCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 22:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vExvX-00032Q-QY; Fri, 31 Oct 2025 18:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vExvV-00031Q-3M
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 18:48:57 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vExvM-000882-1L
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 18:48:56 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so34545865ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761950925; x=1762555725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O88KYOjUwqb1BPlw/7cvHlppXwsxo2scBXj/TdGXXgk=;
 b=hWtuHC1GjS45KEXQLDsdRo0ZebQQ+hLA0dqawEpwat5XkKDM8FmBazrR6bWE19ld5b
 gmFHRBpKNb8oTFd/bHWQkT+SEevuT5rEMQYy7TAK4FqWr6ZUBVPD16vB5y6IBb5R0JsT
 nLZSvdiWq36p9RaanRuQuMbTFZDHNLCiAVJixR5ngpduq4sm1RSrBHodcTydIUOnzXew
 ojTE69KRZa0icQPl4EQwoH4SuWf9X98UnCMvdb9OHgEQ248cdTMlzPrr1Akw/u2dL1k7
 cK7wtGIHYBw2u7CmerdlII7RBHviAM5jSqhXtmurfEBO3HnakStfV8iF2Y9dh+U2FDbW
 fJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761950925; x=1762555725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O88KYOjUwqb1BPlw/7cvHlppXwsxo2scBXj/TdGXXgk=;
 b=MieXU3n9KFPR5wLdLjbGv1pCP5dtXekWHWT3U8+xtNJUZA70f4yWo7HrxoYheYPyGh
 A3Hi3HfZH4CaDK96JkjlNsw4G7pqtbb4mQeYHg29CjKHcE0PmJViOVaIiESQDTSXBiU2
 m4o9wKrRadFRjk+2kmGXdQpDprGyq6AYFDpVnT8TdKx1ahtRlxPxIGhpliK1gj9PSUiR
 N6U1phZwPkI+C68S9XvNApFRYCgv4/sEneIS8Hvxnt/ZHp1BBP3odLNnDDr13FFiiT4e
 SWS9z0w/pZs2GOMjqybEF3o8qA6uB8o18wjngZg64G9jFnCfBaT9g7f1IObEo95fYYrG
 AKYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9ji3A/0wsjVxr3T6CTUNvW8cOo1N0lAmdpzeKBg1A7AljxNJFVzhYO3haORL/wNR4uz1IYV7pujkO@nongnu.org
X-Gm-Message-State: AOJu0Yzh6YEIiDjtFlpziIfrSogB1207bi74eqo2NrwzzBKNnHDnDlOh
 hkKl1hGA0OVwMLScuvYtT5u2vgivUMPsucOFV5XgfgsgVCzoqa91lMXV
X-Gm-Gg: ASbGnctucUBOFIgTXsnkyLjnrddQtLYHMVDtwt+7mYwabjMK1mUyjg0Tn7G/wpA8YnW
 lOpGEte9XHVx0GsdCyevMOfAMRQhRO8CnNj4IIE+7eQkDToZzxCOoh82Y2d2TtBispK1jxn+srn
 NABmoo0WF5DA+bZefb5x0Q//5ek9/kcTko4efif7pxi0XBOES7xeIwyJi6nYRhxISQqqrHHfWSq
 Q0aiLqUD/FvkBDNl6YpTuG05VCzlsZQeteEYCCDVQ7GZn7geEZAVciB4klZTRaxMOZAGMMMKUXH
 DPaYDKX5QQvDDU/6JxyT1s8tFW/g/o69BpN1zU3Dxgd3y3mtjgz6XKNbkyhPsdXQ35wqRKqcFqL
 Q6+W141z0vKpIwHPF2clO+mmOHItLnx9Q4Jmc+bK8IXTXrJ75j7HCWnk0u2hMFDAgXfzUZEVNMp
 U5N5MdnEI1geZOQSBUkzwMQsklEBneh4IPSUdpABg=
X-Google-Smtp-Source: AGHT+IEoefgVJTA/rHvfo9nnY6eibwlSBgP1I1bgkzLc5H4SP28QHGZsOSJbvUZO5ApHpPUSezu47g==
X-Received: by 2002:a17:902:f542:b0:295:4d62:61a9 with SMTP id
 d9443c01a7336-2954d62663cmr17508755ad.38.1761950924850; 
 Fri, 31 Oct 2025 15:48:44 -0700 (PDT)
Received: from fedora.. ([103.2.232.250]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-340a079b9e2sm920786a91.10.2025.10.31.15.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 15:48:44 -0700 (PDT)
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
To: sarkarsoumyajyoti23@gmail.com,
	qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 RemZapCypher <soumyajyotisarkar23@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Subject: [PATCH] hw/scsi/ncr53c710: Fixing defects reported by Coverity Scan
 for QEMU
Date: Sat,  1 Nov 2025 04:18:38 +0530
Message-ID: <20251031224838.229154-1-soumyajyotisarkar23@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-pl1-x644.google.com
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

From: RemZapCypher <soumyajyotisarkar23@gmail.com>

Fixed Null pointer dereference & Async/Sync IDENTICAL_BRANCHES defects
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


