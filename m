Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93CCCEDD8F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1m-0004iv-Kg; Wed, 09 Oct 2024 08:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1k-0004iV-6A
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1i-0005Rc-Lf
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSrTZ5PyIp+y/7h2oJbsCMlzTXaX6rgV2rodQaLvIWo=;
 b=LfP0FNGKwqIdzeu09z2AS4p0ZoYtJOQ3hC6n3RZmtr9loCO6FnuDOayRD2x68ha5d17331
 7nhq/rkBRH0Prf9OQLexAWTq8LrQAxUlg+qdjI545/pFbh2JRRuefcRlDFIe4SLYfxe87g
 piFFC76Z3fyK4Ct7ExIYYC7tzvdfHjc=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-woXH5DhPOkK0YNbAKJSl_Q-1; Wed, 09 Oct 2024 08:42:48 -0400
X-MC-Unique: woXH5DhPOkK0YNbAKJSl_Q-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-8353d85fc5bso90994139f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477767; x=1729082567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSrTZ5PyIp+y/7h2oJbsCMlzTXaX6rgV2rodQaLvIWo=;
 b=Km4IrLx5Znxp7FwYH+g6934TujLYmcQ5e8J/LhZg7HeHGhixdfRb65Wbc0ZnMOt5kX
 5WbJT3XHQvGdFU7Dp2mNqG1HBfAXpgQnLmUxiPr1+dtG2wntrDFsldhqD6TL2mO2cHLZ
 yhO60O9O1XhiFpOHafNIIBODvSirdFNeJGxD9MTLnKIpEJRDMP/33j8OnumIRsHmrJRu
 SRHeEEc6MX2ChAFYeA2QL/L6G9xHnPV0M0X7+Fv7XWpr3bYSvD2m8nU9sAfDCW/Sj3UK
 YjY40NWDd3gME5nm/X7Avk69M/CQaDTkvxilLdZtj0qOlWXDRA9meGVdrvmDMMp33IC1
 Z+aw==
X-Gm-Message-State: AOJu0Yzgf0uSFJ5YxqRLOgNyPdteCdxu5eDgB7ftHHoRBO7wt4TrEPqH
 l4IQkVwP0O4DZgOe78nb6ri61EyJaVfrVoRGCw+9WzxR9YAngWB5/2Z5P1BXOBYanVGapPhhA51
 MjRlZm+s5601uDZ3L8Q9v0UNFHynZeYNgnfySKiwQclWb4cnvVDpkMIWsUzN6L9uGWHZnRYyl5a
 y6+AAruL3GaIxXtOPTA/c+BXxQEcOthsyKtA==
X-Received: by 2002:a05:6602:1595:b0:82c:bdec:1c0e with SMTP id
 ca18e2360f4ac-8353d378d0cmr246749739f.2.1728477766793; 
 Wed, 09 Oct 2024 05:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpypbmveO/15wJzQiiV5f8btY+IXUL1ItykcAGCz313DXu/lwvl5Vl1GBnfVOI9x47LbpLaQ==
X-Received: by 2002:a05:6602:1595:b0:82c:bdec:1c0e with SMTP id
 ca18e2360f4ac-8353d378d0cmr246747039f.2.1728477766274; 
 Wed, 09 Oct 2024 05:42:46 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 03/12] migration: Remove migrate_cap_set
Date: Wed,  9 Oct 2024 08:42:29 -0400
Message-ID: <20241009124238.371084-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

migrate_cap_set has been unused since
  18d154f575 ("migration: Remove 'blk/-b' option from migrate commands")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240919134626.166183-2-dave@treblig.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.h |  1 -
 migration/options.c | 20 --------------------
 2 files changed, 21 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index a0bd6edc06..36e7b3723f 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -58,7 +58,6 @@ bool migrate_tls(void);
 /* capabilities helpers */
 
 bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp);
-bool migrate_cap_set(int cap, bool value, Error **errp);
 
 /* parameters */
 
diff --git a/migration/options.c b/migration/options.c
index 147cd2b8fd..9460c5dee9 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -605,26 +605,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     return true;
 }
 
-bool migrate_cap_set(int cap, bool value, Error **errp)
-{
-    MigrationState *s = migrate_get_current();
-    bool new_caps[MIGRATION_CAPABILITY__MAX];
-
-    if (migration_is_running()) {
-        error_setg(errp, "There's a migration process in progress");
-        return false;
-    }
-
-    memcpy(new_caps, s->capabilities, sizeof(new_caps));
-    new_caps[cap] = value;
-
-    if (!migrate_caps_check(s->capabilities, new_caps, errp)) {
-        return false;
-    }
-    s->capabilities[cap] = value;
-    return true;
-}
-
 MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
 {
     MigrationCapabilityStatusList *head = NULL, **tail = &head;
-- 
2.45.0


