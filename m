Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EAFD5B86D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B4y-0003Xk-A6; Wed, 30 Oct 2024 11:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4w-0003XL-Si
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4v-0007lx-CK
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LPVTPWOgvdRxt04d1ASLhb7X2V2plDFvoFd5bfX+Z30=;
 b=O/JT2bM97RQHgvm1la8F2gOteDQ0eGCqAm6gFKc0keXLvUJY0ZvzQEVKzVGqLnqMuW4217
 bNC3QHSR/wPaBKjx5ETRn4dYp5ozFhJDDdiRSpJxVvJTqB3+8SHE0E78fP/sK45f/fZc4d
 9bWM+rDaahs/8YIWMKtkBZEqhcnLwD4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-vRu3npNEMiygzj8w3sbVcg-1; Wed, 30 Oct 2024 11:57:46 -0400
X-MC-Unique: vRu3npNEMiygzj8w3sbVcg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d35062e1fcso59336d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303866; x=1730908666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPVTPWOgvdRxt04d1ASLhb7X2V2plDFvoFd5bfX+Z30=;
 b=PGvmSkb+L/hqdFd88kxeH3c+HQnqRaT6PAzp2kOm7oRQwlu6cbQxE++Ph39NasgjF3
 zY20NJoNKrQCm+eSKJu2wPb+yjYoKPdVpJ6Lrr9QzMJFJiSokA6NphFZfiUzbz2oebbU
 DVgJG1hh1b3XBS3mDWGCoEwK5tySwMgGI2pCTITyKNcfghQ723MoZHTvt1Hf7gZRcbVD
 Jbki48e7tvdpZP/LVFkgcyqitMxH6dGTHCJQH/ZhgchVpXzQ/Xgd8EwFsfWagTQNimou
 H5UPX3RyyAmG/ByyUNj5w98l75sjtmElHTQ3YqjI4VQ7Jd5q741Jf/5oPfEJxsLO2YFO
 qiwA==
X-Gm-Message-State: AOJu0YyK2/wj0u++WunCu9P8NxoBeD0ukyM41gwgzd92CK2nB7tTNMce
 ZCCSQkO25icRjvH9yp/xEEge4NJNCJn8zpbxQX4EkysP0ipDPG5QS+zCy8NtwncoUIZ/7LsLLZx
 Gzs6vvs0W82ukb8YI4JQYIaljJ8r7LTi19/HGBKLGQZHZwCGK97HNo39T5elkbKio0tV9Iqy+8Z
 BMoAtKGaeyesHcPhdjgwWudrvwwlwJV9bVVQ==
X-Received: by 2002:a05:6214:5a0b:b0:6cc:2d3c:6472 with SMTP id
 6a1803df08f44-6d1856b4898mr207007696d6.14.1730303865797; 
 Wed, 30 Oct 2024 08:57:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIszSgVBjS+zerSZyizB+9+ynJ/mMCVgJPmtbKtXxBQCXLHsgEuEo4q3PtErowkRb+Df7Ezw==
X-Received: by 2002:a05:6214:5a0b:b0:6cc:2d3c:6472 with SMTP id
 6a1803df08f44-6d1856b4898mr207007416d6.14.1730303865389; 
 Wed, 30 Oct 2024 08:57:45 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 05/18] migration: Stop CPU throttling conditionally
Date: Wed, 30 Oct 2024 11:57:21 -0400
Message-ID: <20241030155734.2141398-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Since CPU throttling only occurs when auto-converge
is on, stop it conditionally.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/f0c787080bb9ab0c37952f0ca5bfaa525d5ddd14.1729146786.git.yong.huang@smartx.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7609e0feed..e81c70b9d2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3295,7 +3295,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 static void migration_iteration_finish(MigrationState *s)
 {
     /* If we enabled cpu throttling for auto-converge, turn it off. */
-    cpu_throttle_stop();
+    if (migrate_auto_converge()) {
+        cpu_throttle_stop();
+    }
 
     bql_lock();
     switch (s->state) {
-- 
2.45.0


