Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A662C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEcR-0003YN-1p; Mon, 17 Jun 2024 11:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sJEcO-0003XV-E4
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:50:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sJEcM-0002xt-CK
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:50:04 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70423e8e6c9so3930166b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1718639401; x=1719244201;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nz0BTkYy8+cNUSoTKA9mAzm5fhe13UqTIL2SbM27/78=;
 b=1eVEg6S1GMjqWkkoFeJxKVJbI0eU501eaHhyaNbJVxNsR5rxnxKRUp8VSXSA8sENVd
 D/REZRyjr4P3hFekxJUDuDdNdyCuHZKZCJaJpHNMHvSs1dYsEPlEbWtxax8QrJL/G+dl
 yPxiX/Gr8XWChptFUDHGOj1x3K2DBTdLUhBKrAXi6IScDUwHaBulFAYE+eEyPE0BSq2z
 EGiPxDO65wCivruPiE4AJemQDMxSL58xbk6eXuQVb2YqblMTnYZqt5dzlXL8dm6S/JEv
 PhuhvHlmTARr2s7oVNbyN+pIjhgnVXEuACHZMNWVnp4jR50Jy0xnDKDjg/SNVCF+KmiH
 7zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718639401; x=1719244201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nz0BTkYy8+cNUSoTKA9mAzm5fhe13UqTIL2SbM27/78=;
 b=mqrXp2tbneK3tcpJphNpA6xE1SbWAlNPRSVDWwKlN2lAtxMq7/VsXyXa8bbXyzXZYv
 tXSpb7MD8h9JDqKA6WP7i9Ch0gWxKZkxuhsoi2Ni6Zf/NX1tg4ftgVnpzhe3RTfUB/hS
 Sj6gfomqpyzgLjmaVq3Np4wpkt2aMAZ0sAccGR11Fojjn7GhUKeFsE8Vu7ZR8D+x8SKU
 EAuGoZxVt9eEY1L7eJH0hViHI2TbrQhZ/hMSrbTEMyylE29VvmZY9Q3T8Ap+1ATfAeYP
 fWisrSNtjbh7ywysE8BAyPkXSK1oHGdtZFkHZ89wP3NnDmgqN7EIUncaYtZEKo6JwY3L
 XmbA==
X-Gm-Message-State: AOJu0Yz90ORDJwSdLyY+E1I+KSHdZfAxGP7O1u2wUbQ1+P9cVR+ZnK5s
 /AjD75G5y3xdoF+WObo1m3BKgyvaUYSHh7yR0qCGAmKMvATsYASH4GrnPzAKhLMMp0v9FpoctPQ
 KQBhDLg==
X-Google-Smtp-Source: AGHT+IEiTcv5mU30QLoUGjEbM2J0dKOWTsvwgEfvm3gRTGyT52vfAPrZdomYtQTf9OeFw8ndECf1KA==
X-Received: by 2002:a05:6a00:1748:b0:705:ab2b:2fe with SMTP id
 d2e1a72fcca58-705d71e3634mr13288997b3a.33.1718639400259; 
 Mon, 17 Jun 2024 08:50:00 -0700 (PDT)
Received: from localhost.localdomain ([125.71.94.151])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc924ed0sm7511138b3a.4.2024.06.17.08.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:49:59 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Masato Imai <mii@sfc.wide.ad.jp>,
	Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 1/1] migration/dirtyrate: Fix segmentation fault
Date: Mon, 17 Jun 2024 23:49:51 +0800
Message-Id: <e65152d5483b2c847ec7a947ed52650152cfdcc0.1718638495.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1718638495.git.yong.huang@smartx.com>
References: <cover.1718638495.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Masato Imai <mii@sfc.wide.ad.jp>

Since the kvm_dirty_ring_enabled function accesses a null kvm_state
pointer when the KVM acceleration parameter is not specified, running
calc_dirty_rate with the -r or -b option causes a segmentation fault.

Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
Message-ID: <20240507025010.1968881-1-mii@sfc.wide.ad.jp>
[Assert kvm_state when kvm_dirty_ring_enabled was called to fix it. - Hyman]
Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 009b49de44..854cb86b22 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2329,7 +2329,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id)
 
 bool kvm_dirty_ring_enabled(void)
 {
-    return kvm_state->kvm_dirty_ring_size ? true : false;
+    return kvm_state && kvm_state->kvm_dirty_ring_size;
 }
 
 static void query_stats_cb(StatsResultList **result, StatsTarget target,
-- 
2.39.1


