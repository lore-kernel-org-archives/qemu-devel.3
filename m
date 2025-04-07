Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6E2C36018
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 18:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1qyp-0001Jz-UC; Mon, 07 Apr 2025 14:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u1qyj-0001JA-Ba
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 14:13:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1u1qyh-0000xa-Qd
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 14:13:49 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so4479320b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 11:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744049626; x=1744654426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahFIFL8hXxK8cpnUP9ZgFBNSrNH2qOG6aOuDMuEfh4A=;
 b=dkkGKLGLdgVFrKcIPE0tp65/n3X+olFwRYa516cXur8VGo+/XLrBmngUAWR56be8J8
 r29pj+5OdHN+bZECK1Xyov63s0Qe/99uSwcGInUzT4G8ukSrGRilT8VdvQ+rc9n9ugDZ
 Tv7CZEaVfg9pVDoaeWYcXp/safWCamIPn16ecksDXnp98PVfHILFeok8UH6eHZNH63JP
 CcOCUPKX6jN8vKBuznbRmPylloBGTcDPI8va0zeIdSGdsUtD7K8mXj2Fkq4h7mnfg6B/
 c5Nm6rhDL618ngyWLETQnO0BRsB4mekWl4+dW9A4b2NGDD6swbN5xiGR4K8XZt59t+hY
 uXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049626; x=1744654426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahFIFL8hXxK8cpnUP9ZgFBNSrNH2qOG6aOuDMuEfh4A=;
 b=pVfLwG6XdK7Nlh0veNcYFhxFRX4XeZHarh+EYgbPf70+iQ9yUSLKOLBUqYbnexnxBN
 2QEPPT6bXjqq7z8oc3M5iqQiOHvziU2Yor0Gs+E2+gyGmzfQwZBNCxbpF833M+MmDfw4
 jdJNJ3EaP76JMVcvQjILU3GSuCRoDoJiSoHfn+JfW+40ZNJtdBFGmhSLvQMLogIAEkdk
 YJ/PuU+dMEu1S6lBvWI6Xs3FPCuISjtGjx2M4HdBglFJ56t8prEPq9mG2Gp2WIugomJi
 h2jF9OlirpGMLQxp9rOlwJRW7VQg/sDq1kPk/QTv/dHjFsTHEl6yQbDO222RrBE2z6Wg
 3qMg==
X-Gm-Message-State: AOJu0Yw2wV07wis7SJipJ3qL2NyzGqppD5a8D4NoAjhzb3pLZCH5M3uI
 dH60jB7DVqG8K8WIqz2g8pZ7dF0b4z/HpjzOgv716iX7asyx+tdwoeJjcGUV
X-Gm-Gg: ASbGncsOX6acXgZb2r9E8aOnbebf0bF0aVaBB+rcPuCUm+mj1qWrbr1Io7JHzOlXnuO
 1eh5zv6VoFiMIgdl4ton+03h9wybArSHzh41qrdvUOkRa/cJ34EozDjzrD1xtxAPkIfXCWWQkvT
 aps0WGp+Onpdd94OQGQMwpcwIcAqq2RYJGKcAcOyOfGklrtrZsh8FHdL8sEWpIlRpabXEppPCmG
 g1cH7GqenaAlgzgh4RfBVm5gkTZCCQ3dti4skqV8TQawWI2S8XzYjRlSxkEfWP3eIgHTs9dCOPZ
 cQa/pjS63Xa2XzKL4r4wt34hjF61/YZE2OItiIisynnzQup1zvin
X-Google-Smtp-Source: AGHT+IEAyP/OTfis0itzYIDvOipDopidZQsqfBgGFx0CzWgR/KdH5a5BTqRKCWLisAW74/rMufE/xw==
X-Received: by 2002:a05:6a00:928a:b0:736:ab1d:7ed5 with SMTP id
 d2e1a72fcca58-739e46ba7c8mr14678013b3a.0.1744049625751; 
 Mon, 07 Apr 2025 11:13:45 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2018:65c1:1184:2614:d863:8ed2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ee7absm9084572b3a.58.2025.04.07.11.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 11:13:45 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	rakeshjb010@gmail.com
Subject: [PATCH 1/2] rust/hw/char/pl011: Extract extract DR read logic into
 separate function
Date: Mon,  7 Apr 2025 23:43:26 +0530
Message-ID: <20250407181327.171563-2-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407181327.171563-1-rakeshjb010@gmail.com>
References: <20250407181327.171563-1-rakeshjb010@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pf1-x42d.google.com
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

- Split `read()` DR case into `read_data_register()`

Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
---
 rust/hw/char/pl011/src/device.rs | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bf88e0b00a..87153cdae1 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -190,25 +190,7 @@ pub(self) fn read(&mut self, offset: RegisterOffset) -> (bool, u32) {
 
         let mut update = false;
         let result = match offset {
-            DR => {
-                self.flags.set_receive_fifo_full(false);
-                let c = self.read_fifo[self.read_pos];
-                if self.read_count > 0 {
-                    self.read_count -= 1;
-                    self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
-                }
-                if self.read_count == 0 {
-                    self.flags.set_receive_fifo_empty(true);
-                }
-                if self.read_count + 1 == self.read_trigger {
-                    self.int_level &= !Interrupt::RX.0;
-                }
-                // Update error bits.
-                self.receive_status_error_clear.set_from_data(c);
-                // Must call qemu_chr_fe_accept_input
-                update = true;
-                u32::from(c)
-            }
+            DR => self.read_data_register(&mut update),
             RSR => u32::from(self.receive_status_error_clear),
             FR => u32::from(self.flags),
             FBRD => self.fbrd,
@@ -306,6 +288,25 @@ pub(self) fn write(
         false
     }
 
+    fn read_data_register(&mut self, update: &mut bool) -> u32 {
+        self.flags.set_receive_fifo_full(false);
+        let c = self.read_fifo[self.read_pos];
+
+        if self.read_count > 0 {
+            self.read_count -= 1;
+            self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
+        }
+        if self.read_count == 0 {
+            self.flags.set_receive_fifo_empty(true);
+        }
+        if self.read_count + 1 == self.read_trigger {
+            self.int_level &= !Interrupt::RX.0;
+        }
+        self.receive_status_error_clear.set_from_data(c);
+        *update = true;
+        u32::from(c)
+    }
+
     #[inline]
     #[must_use]
     fn loopback_tx(&mut self, value: registers::Data) -> bool {
-- 
2.43.0


