Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEB2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjni4-0002Ok-UB; Mon, 11 Mar 2024 18:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngp-0000nU-PC
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngn-0004HG-UH
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 18:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OZEcnrxRNvKPm1DvrVRTFALc0OvjfuvU5sOoiUMpdc=;
 b=Kc3y99XE4uIInoZHuR7ptK2Fr0r/PR/nYJZoqzgPGjgzgYk2yvM6kV96YDiGJwNT2jX7Je
 okFqe1GreptC4dP8ekd8Dh39jwUe5Lg4EXxXfi0noBLJ/kyx+dbD3yZyXKd++AU5C2Zxz/
 +MvKN7xEVzoTEn4vFxRkWomZ/TojxH0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-X6GrvQ-UMuieD-WPYlLCCg-1; Mon, 11 Mar 2024 18:00:06 -0400
X-MC-Unique: X6GrvQ-UMuieD-WPYlLCCg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-690becce69eso10938186d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 15:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194406; x=1710799206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OZEcnrxRNvKPm1DvrVRTFALc0OvjfuvU5sOoiUMpdc=;
 b=BLKK3bTXwjXpL+OE5Q9n+lmitiwmUAqs7kh1X5slOoEr4Tq44BQJcWfsWzOZIviP5N
 StE6/nTqF2xcIZAPO0fBXFIjcym9AgywbdVeDRxXT/eUG4I77jA29o6YyDDL7EmtcM+l
 +E2DWBuogxiDeqDjxBd8ltZlQrJhV85AlEL3to6fmKhtgRd/J8M/SsqYDvXThb6nv3XR
 OxXfp+IBlyWL4S0kIW+0GBqb2RRvfM+2xqFpL9QT2JYTJRvpftHXhPyjZghX9rCvlica
 BcHeIlquHuiV8jT0Ivu6/T6BoBEgEkC0HHpqnnPl+rw5CDBE/E9Q1gBtBBRJvJKEu/Z3
 ePFw==
X-Gm-Message-State: AOJu0YwC8HWq1CepB3dTu3R2zAT8QgtEuEBXyhFquN/nPpzkjLNya4MM
 MaIThSzT9PjRiyuKT4CzoqJt30fKzoausllYCycfyuubKcCQwM2iDijsox6SlA94amk1UXnnfy9
 XwmRtN3CmB4ECTweY/PTLIJ8CLfayvBST+mgH3s0qk6V9R/w+oxmBWu53iU/Dl/rQnH35yZl3Fd
 dwqkb4iRBNHj9nL6omNQIPz6c7A77HxfA/BA==
X-Received: by 2002:ad4:58c5:0:b0:690:a974:5b79 with SMTP id
 dh5-20020ad458c5000000b00690a9745b79mr7754134qvb.0.1710194405997; 
 Mon, 11 Mar 2024 15:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDcHw0Svf4tCIp0dAh9DyX/XvaH3ed8lUOCGSOkQbv5VkrBrNhaVdH72AsUUIxHRVOKlOPOw==
X-Received: by 2002:ad4:58c5:0:b0:690:a974:5b79 with SMTP id
 dh5-20020ad458c5000000b00690a9745b79mr7754102qvb.0.1710194405510; 
 Mon, 11 Mar 2024 15:00:05 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.15.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 15:00:04 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 26/34] migration: delete unused accessors
Date: Mon, 11 Mar 2024 17:59:17 -0400
Message-ID: <20240311215925.40618-27-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/r/1710179338-294359-11-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  3 ---
 migration/migration.c    | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e521cd5229..d563d2c801 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -105,13 +105,10 @@ void migration_add_notifier_mode(NotifierWithReturn *notify,
 void migration_remove_notifier(NotifierWithReturn *notify);
 int migration_call_notifiers(MigrationState *s, MigrationEventType type,
                              Error **errp);
-bool migration_in_setup(MigrationState *);
-bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 bool migration_is_running(void);
 void migration_file_set_error(int err);
 
-/* ...and after the device transmission */
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
diff --git a/migration/migration.c b/migration/migration.c
index 216f63d62b..644e073b7d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1548,16 +1548,6 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
     return ret;
 }
 
-bool migration_in_setup(MigrationState *s)
-{
-    return s->state == MIGRATION_STATUS_SETUP;
-}
-
-bool migration_has_finished(MigrationState *s)
-{
-    return s->state == MIGRATION_STATUS_COMPLETED;
-}
-
 bool migration_has_failed(MigrationState *s)
 {
     return (s->state == MIGRATION_STATUS_CANCELLED ||
-- 
2.44.0


