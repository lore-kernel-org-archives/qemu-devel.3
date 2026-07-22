Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6CBC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVP8-0004Lm-57; Wed, 22 Jul 2026 07:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLNA-0000Aa-GF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:46 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLN8-0002gw-H4
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:44 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so451762466b.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784682218; x=1785287018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ED8ZNuacLaQvPx2m8uKBXJmG6gJ49gu9pZqGBkx0woU=;
 b=GpY8zogXYHnTBvfEOBxBjcEzjINNwZLBKGSNQaW0LhE8R1hFhZJMAazfRBYBBKSCNq
 IO1xuxBRnIX0RMyqevh850uY+Y/79wCE4Cx8UrEch7+PSe93tuuQIn2F9wAx3acTGX4a
 BHUSiwFPR5rNL4GbSINrmgTrT1TeUbXwSGNYy+s7T733683s4NpA/F6TCb7KrTiwLBZK
 l+G7ZHzOR31XMFiA+12nHQvCDKtDZIhG6/aqEdDf/RYC3GCOpcDo5Fx7gyZNA3T5xRNr
 kzdrU2Dc8T0YESVbH9zZxVuC/VqdpwsW+Rpja5RQle8q8g017U/DjRwypqzpq4hHgo+0
 i68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784682218; x=1785287018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ED8ZNuacLaQvPx2m8uKBXJmG6gJ49gu9pZqGBkx0woU=;
 b=nzvcobQ6HI8tqkmDYVFXVAH4ctkIhFbfgEmN75FpcV1WdHpSIZE1pDevh6qhezWqIC
 YkdvzWJNyjKeXLUlFjmvpJkR2bltuAC1EexGI30+r+mWZh50+wuMkoMiqbtnx3Hw2Ya8
 o4MJfIGyN/yaMiSHmitj8K8uJEHPhV0A83dNV9aIbMI15ZLrwVXwgYvyLHQuigrdGlBx
 5z+EXTSe8WKrexigqgpW/BL8gsrS6Bqz8MIbNfpMKFYDUTj1QBq2oMtQ33a7AmVfcREZ
 P5+1f9B3ScDPdMntgZ77YDGi2CP8RvVQJEZkMoOMJgam0h8OpuiU309We/MGkUsg5uEb
 gq8w==
X-Gm-Message-State: AOJu0Yz9WsCcKuoRrvS5eeKj7mNPYPAWtn5mDMf8KFBLCRS8trzkNzn0
 PBCLzVXus4oJhIVWMpfqXA22Zq+LPR7nVYhqdIpn6VHlnPbGvdBuUUVXdfOovks37OM=
X-Gm-Gg: AfdE7clOKQTCFeJUbiKBzQNmvMR2/9sfKbBCpRsUBwftOlWMIeBbuSJvUJD2SgZ+5yx
 Y+tGSjW7aO6WWYAYRMW7TBlz8cmBSvE/lnWxXs6nXpjgvFTbM3Otu2aeyhla6F9awtgG9309r1/
 l7HkmzIf2LkvblilRwcF71WOer1jfItxUHr4/uUTNHglPawRGS49g486Hwkgu1bKxYi8Cp/AWx4
 rMEQnpupV5mDeEZclb/trvu695PtTAV1GQfbxzB2NtnC41FWpUITwog4mW85YH5KDR6kpglWn+g
 7ooq0aFkz83SBJEiFulCsvUERy+e9cIQ7uUawvB+Mwkug1CQwFIjSf0sgdD9So6Sdv5nIbvIKC5
 egLQwjMzuoWvslqioZLx3a5VLkfoQyNXJJHi8kji6aHAhwv615YQPeeEuAO7TmSigLg==
X-Received: by 2002:a17:907:74a:b0:c15:cee4:5244 with SMTP id
 a640c23a62f3a-c16b46f30abmr925111566b.21.1784682218221; 
 Tue, 21 Jul 2026 18:03:38 -0700 (PDT)
Received: from Arc ([109.245.172.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ebac95sm32694066b.47.2026.07.21.18.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:03:37 -0700 (PDT)
From: Konstantin Nigmatullin <rangolit@gmail.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Nigmatullin <rangolit@gmail.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 3/5] iscsi: cancel in-flight iSCSI tasks when the session dies
Date: Wed, 22 Jul 2026 03:02:52 +0200
Message-ID: <20260722010254.424820-4-rangolit@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722010254.424820-1-rangolit@gmail.com>
References: <20260722010254.424820-1-rangolit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=rangolit@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Jul 2026 07:46:12 -0400
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

Coroutines waiting on a dead target never woke, so blk_drain_all could
not finish and QEMU would not exit.

See: https://gitlab.com/qemu-project/qemu/-/work_items/3067
Signed-off-by: Konstantin Nigmatullin <rangolit@gmail.com>
---
 block/iscsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index e7f2d54986..330f17e08b 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -381,6 +381,12 @@ static void iscsi_timed_check_events(void *opaque)
 
         if (iscsilun->request_timed_out) {
             iscsilun->request_timed_out = false;
+            /*
+             * Drop local in-flight tasks so coroutines waiting on a dead
+             * session wake with CANCELLED instead of blocking drain forever
+             * (especially when command timeout is disabled).
+             */
+            iscsi_scsi_cancel_all_tasks(iscsilun->iscsi);
             iscsi_reconnect(iscsilun->iscsi);
         }
 
@@ -1427,6 +1433,7 @@ static void iscsi_nop_timed_event(void *opaque)
         error_report("iSCSI: NOP timeout. Reconnecting...");
         iscsilun->request_timed_out = true;
         iscsilun->nop_failures = 0;
+        iscsi_scsi_cancel_all_tasks(iscsilun->iscsi);
     } else if (iscsi_nop_out_async(iscsilun->iscsi, iscsi_nop_cb, NULL, 0,
                                    iscsilun) != 0) {
         error_report("iSCSI: failed to sent NOP-Out. Disabling NOP messages.");
-- 
2.53.0


