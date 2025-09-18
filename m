Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C158ACAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLQ3-00066V-T6; Thu, 18 Sep 2025 16:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzLPw-00065J-3w
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzLPu-0005qA-E6
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 16:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758227985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DHtSrXZcVQINioTONBn/GrEMHeTFb5InPbuhxx5EyD0=;
 b=A/V3C9VjsFHc0lfYZT0yIuXD/u8XZhr+8sEZNE7dswPLvpzmpOoILw4terD3ityUe9NESV
 zJIAIqmAOM2IEeiqJEZOp0moQPWCDcGn9c4foagX1jv4iUIkO24LyYzysjzcve0Leloliq
 SpbYbxL3v8g3KPA/TPuBqEAkiyvQTGI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ZBMYZw4WOVyUI_hWyN_DyQ-1; Thu, 18 Sep 2025 16:39:43 -0400
X-MC-Unique: ZBMYZw4WOVyUI_hWyN_DyQ-1
X-Mimecast-MFC-AGG-ID: ZBMYZw4WOVyUI_hWyN_DyQ_1758227983
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-81678866c0cso244489785a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 13:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758227983; x=1758832783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DHtSrXZcVQINioTONBn/GrEMHeTFb5InPbuhxx5EyD0=;
 b=mk3EYHFScSq5WUkXDJ8goSrH9oUkkLBtFAySgiRuhjY35Cgu4O3/Q1H9cBq5ICf3Mh
 m46kfHPpLr8MC043CrTnysDhdJQGC7SHpCnUv0xwtF/A2H0rg2OOlTIcXHY5pvjeyj/W
 iNP8GbQtbHcdjbWFB4+frdbn37V09eHL2IFqpR/2FLWzXk1bx9aWW/HKOBZs5gUryIX7
 Iui1nCTyxkKEJ8zstjcwi2UOoZ7qghFSNPKZbh3VVAN7z9/QGaDG03Psrii5l+5MKcgI
 VswXWpFhABFLn6yFdzKI9DT81T6zK6/skCpzP5gXzG2jLTOoXLSz9EUwDQhw5XFar1Is
 r/OQ==
X-Gm-Message-State: AOJu0YwPZFkTZQVnTNXGxkL+aMNUS7vl8Z/uhtxlqgSt5Ah1+FAN6VEf
 gxiZFzLY2c5qmiXBu5s5NFaiY7ANMAabZIzYPDUk1iRKXoDCxePRHq6zwx+vkxzOWLzW/rOep5g
 kNoNG6PT7E9FxSq5WTRnmkYfDraZVXItiMDZ5HajYzeL23dDyV3FTu7itkYemDVb440dxcs+TUs
 uDhrqChNHBGJbfY+qFb7ECrJhY2kVEhVqoM1vpQQ==
X-Gm-Gg: ASbGnctVkAktRFp+z71hx79FXY4RoaxYPQHgl95GXXOrGkyXjfMOKRA9KK95lpMuTR2
 z7PHHpX+eyW3ucNyn8OXvSOeR57mSIlm0EzVVDJ7Mf0JM8rCKqyE/+PVC1tEwF0dEpLep5JdVp2
 7biIL3tkDbZ+Lh4k0N5GhSYESWxg7aPFFeN8OpCQV2i/oU+gitnRg3yh7iWtf1eagw5J8xZxZsK
 H97VWwLsF3uJkkFPRlN2ZT7KRvAivika0yEcfBxWeqtFCmO2WCow8kCFIoJgWaIXGHNvSm2DX2z
 0v+rznrTtUTrayoX1+r3bZzOpBl/lqZOi0ZDz7VdrCdAYwe/4NGAdsVQV/IBrDL4ikKadwrMdby
 4d3alqmhDBVo00dh3jKw=
X-Received: by 2002:a05:620a:390b:b0:82a:4593:3089 with SMTP id
 af79cd13be357-83ba53d2b4dmr133611685a.33.1758227982733; 
 Thu, 18 Sep 2025 13:39:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZkY33+47Pfwtb3zRly3iWPKq3iMa99MxmzW49cnwXPNuVGSlbzITLPZbEfWjZMbGURXA8Zg==
X-Received: by 2002:a05:620a:390b:b0:82a:4593:3089 with SMTP id
 af79cd13be357-83ba53d2b4dmr133607485a.33.1758227982027; 
 Thu, 18 Sep 2025 13:39:42 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-836278b8082sm226276285a.22.2025.09.18.13.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 13:39:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v3 2/2] migration: Make migration_has_failed() work even for
 CANCELLING
Date: Thu, 18 Sep 2025 16:39:37 -0400
Message-ID: <20250918203937.200833-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250918203937.200833-1-peterx@redhat.com>
References: <20250918203937.200833-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

No issue I hit, the change is only from code observation when I am looking
at a TLS premature termination issue.

We set CANCELLED very late, it means migration_has_failed() may not work
correctly if it's invoked before updating CANCELLING to CANCELLED.

Allow that state will make migration_has_failed() working as expected even
if it's invoked slightly earlier.

One current user is the multifd code for the TLS graceful termination,
where it's before updating to CANCELLED.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..f6f6a6e202 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1702,7 +1702,8 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
 
 bool migration_has_failed(MigrationState *s)
 {
-    return (s->state == MIGRATION_STATUS_CANCELLED ||
+    return (s->state == MIGRATION_STATUS_CANCELLING ||
+            s->state == MIGRATION_STATUS_CANCELLED ||
             s->state == MIGRATION_STATUS_FAILED);
 }
 
-- 
2.50.1


