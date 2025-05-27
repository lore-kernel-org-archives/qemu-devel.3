Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99C3C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3Tr-0003ID-H6; Tue, 27 May 2025 19:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tq-0003I5-6S
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3To-0001DG-QJ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Y53I0D3GZiFTm9LYMIu17qA08t/JehTcfVK9hw98nA=;
 b=DXCY5xbB+faIQkX/OU25Y9MYSCsq0SHeKEEsAXAfB8ToqjEQTdgAF04OvB2MiSYYPok9Au
 GgVifw1XCZGJXbeYTVjCO65mqZX0SiNf1BPDLywUPiSqIK+k/sGX5NM6ppvTNAInIW/Qv7
 spUxfaCP+ZdNH5ROmlPdGjmhBCyDO+k=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-YwTxTaKFPFGk3_WoukrV7w-1; Tue, 27 May 2025 19:13:07 -0400
X-MC-Unique: YwTxTaKFPFGk3_WoukrV7w-1
X-Mimecast-MFC-AGG-ID: YwTxTaKFPFGk3_WoukrV7w_1748387586
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-400b3a7e434so2888769b6e.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387585; x=1748992385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Y53I0D3GZiFTm9LYMIu17qA08t/JehTcfVK9hw98nA=;
 b=gFnOQHtaeVwt1ZxPm11431tvBIoRAnUD7K/RVDcqnG+CRXiRrfqKI0IDvGHPg+eTZH
 3F3lo5BE9URObwRhkFRjIVgrVbzC42EuQ1jVFnTn28Y3RVt5Qcv70MQGVKD2Byv27o9X
 SBTKRzzbwjJr1X70cuiF7q3qRNnpWhl15IiR7yVd//M6GlzSHLUgGhWQNzpxEuk8n5bo
 Sn2P4Rl19IbUV70+CpUj2FFUARKFCwEgHjNOXcrghMdu05RQal1uDbyjbguPVfQ9bSjR
 3IlDYaW3ZC2fsG7vHISjeHJCZTHPKwBzXzrRP8NEiNIjUmlQbBIGjO4XEsfCTPGyF/FP
 uNnQ==
X-Gm-Message-State: AOJu0YzrwGWieiCnKLgBgvoArXp7qJ+1Ea2Kxl18PeXlW/dGtDGpo9eV
 WPtwzN66fe6tO/wxZ1i58EEKCVUTAM+D0qB5L3gI8hVdDx4CTiEY9A7xwo0pswaMLGaXf9cpBcY
 S9cmUq/KBaQym1wW2z53noaF/bVGNRSECBD/lHd0kin3t66Q1vWr3Hk+UyaYv/0NV17HADT3qRN
 ExCQsMkAXW7oieBZC8YwrPSY3oHjrfo6ijvcm1YA==
X-Gm-Gg: ASbGncu0C7UBQwUrIyV359I04rF1BESayQKnCQdlmoQz1QuAHi1/3CYeZkQ7H9mkr/O
 zhilpdLP0rwhoiS7ClbhUbFvtEz7hU16mJp/Swc043f2y/cZToZEYja1J9ZfvKFnZze3QeiB00m
 NoRLSX+4dcDPey6RmbhBxGXAj/js54yKTeedZHDJCArZEB7aZPfZU6WCIvhTCqJdHZDxJNggPfr
 hY+pyGOiMw47iy+6QF9+WsWXjsqL3pCquiFQDray7tGg77wydOXQb6YC88suW7+Svw+8Y6Flloz
X-Received: by 2002:a05:6808:318f:b0:403:3814:b2b1 with SMTP id
 5614622812f47-4064682751dmr8762698b6e.10.1748387585270; 
 Tue, 27 May 2025 16:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP9asC+b1CGOqCs53Y2ROuUFZ4oTQhVTQ2s7c+MiaL48nwy8im1wz38Im1fnvPR4snHD/OXg==
X-Received: by 2002:a05:622a:4248:b0:490:8fdf:3df with SMTP id
 d75a77b69052e-49f485aa63emr248990761cf.32.1748387574318; 
 Tue, 27 May 2025 16:12:54 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:12:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 01/13] migration: Add option to set postcopy-blocktime
Date: Tue, 27 May 2025 19:12:36 -0400
Message-ID: <20250527231248.1279174-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527231248.1279174-1-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a global property to allow enabling postcopy-blocktime feature.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 162c72cda4..4e923a2e07 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -187,6 +187,8 @@ const Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-postcopy-ram", MIGRATION_CAPABILITY_POSTCOPY_RAM),
     DEFINE_PROP_MIG_CAP("x-postcopy-preempt",
                         MIGRATION_CAPABILITY_POSTCOPY_PREEMPT),
+    DEFINE_PROP_MIG_CAP("postcopy-blocktime",
+                        MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME),
     DEFINE_PROP_MIG_CAP("x-colo", MIGRATION_CAPABILITY_X_COLO),
     DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
-- 
2.49.0


