Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99034C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq1M-00021o-QF; Tue, 14 Jan 2025 18:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq1B-000206-Cy
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq18-0004Aa-Nv
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/OGYzU0DY1992OqiRiyqmD3H3jqkTaE03aIsLwBHxW8=;
 b=E9qpH9kiHA5RJTxu/+/5qEbQGGIELEmY7S+bwJyDMPMdf1gSgQ272VWVSLPs2d5FXgU72d
 66ScOP8VMoM1Wif8GHxA+11HMEoyUk5GQmqyN/oCwNvT2L2mM4+kcvTkn6XjLSbD5doVHO
 ngSuhyM1WJ0vFhEfC/fEk6fRLK13y8g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-3Dr6LF8_OLyNe-QJUVvOIQ-1; Tue, 14 Jan 2025 18:08:12 -0500
X-MC-Unique: 3Dr6LF8_OLyNe-QJUVvOIQ-1
X-Mimecast-MFC-AGG-ID: 3Dr6LF8_OLyNe-QJUVvOIQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6f943f59dso1044006885a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896092; x=1737500892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/OGYzU0DY1992OqiRiyqmD3H3jqkTaE03aIsLwBHxW8=;
 b=AkioRxH7J/hMTFbOdB2r7vrcIOe1IHysWHLME/xMu6QZI7qHTh9cwDNpaMGVrmJegb
 eNvPujSJQyYkkAQ17ZtgMkmYS9RzvexGfy/1pWGtUkxvxSRUnayAhDvRotmavZwWiDpE
 5T6AQkzpr+k7jsjxIh7Z2VSG/2y1OU0PZnlxn3rezF/6LJOERu+HZtdw8X9VD5IP2vvN
 AAyOO/wHGUnh4+sJpa6eEyhJzv/KpsG7PEUhPmExtkJd8ZS930HrHH8FoxfZv8wtZ4mm
 s+TS1TocSX9M55mpBc+cFadtrgj9PfbYvyIuTUFdrVcykadvpnTZVLciz3Chjjyl7jtX
 8sSQ==
X-Gm-Message-State: AOJu0YzIPQ1qGLQvu632fiduZU1HlhH4RgQBAm3ZShvCGHZ9liGOxOC2
 uDIlHwdPp/zwvUjU/Sh+DA3w3fKkbumGSUW3/u6i4fMc9sBxI0cM36VE45qSSjDnMNuKex3j08X
 uhSkonv+dTJqroNU7uGaAJlZogN+3vTS7NsaPqVh2lAVdXV+BqhBzhYLcvldLrq3z+tJYvubiI+
 Gg+MZ1Jr0AwpgYrgD1+1SYoxsddWmgyV2P9w==
X-Gm-Gg: ASbGnctLUkIfGXvekiAWbYrhHHWnkfP0eFJF8SesOVDTb2QGukUAugbx6otyTflbyqP
 iroEacTWeg5tOBZkv9COav+1GIYh7XhIVpqi++Wq+lkz8ViMF1JEDiLBGsicnHv2akq6Q+faIEl
 kwdCYmoalJJHia/yZD+NHFSpnMaF8dzATILduj6VlnBXqtbUZ2cqsX0R3AoFvspNMPO8WdAHCjU
 qbmgNY3Z+/mfK+xWWHsfSlx84wSNJuqt28u4cw42dcVyHiB6fz7vkPbQdxRXb+ZVSXlf2xQQsjX
 rClcc2gXJ9E328MF3y5qPkNy0pa6cx7M
X-Received: by 2002:a05:620a:469f:b0:7b6:d4b9:b5a7 with SMTP id
 af79cd13be357-7bcd9727ab1mr4589246985a.6.1736896092032; 
 Tue, 14 Jan 2025 15:08:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf9rehkQlWr1MW0F7Utef7epLonee4nDlLVc6KVH/qCGmygEVHKZotruvA8u/MYsWftYuXIw==
X-Received: by 2002:a05:620a:469f:b0:7b6:d4b9:b5a7 with SMTP id
 af79cd13be357-7bcd9727ab1mr4589242585a.6.1736896091585; 
 Tue, 14 Jan 2025 15:08:11 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:10 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 13/16] migration: Cleanup qemu_savevm_state_complete_precopy()
Date: Tue, 14 Jan 2025 18:07:43 -0500
Message-ID: <20250114230746.3268797-14-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now qemu_savevm_state_complete_precopy() is never used in postcopy, clean
it up as in_postcopy==false now unconditionally.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 0ddc4c8eb5..bc375db282 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1577,25 +1577,19 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
 {
     int ret;
-    bool in_postcopy = migration_in_postcopy();
 
-    if (!in_postcopy || iterable_only) {
-        ret = qemu_savevm_state_complete_precopy_iterable(f, in_postcopy);
+    ret = qemu_savevm_state_complete_precopy_iterable(f, false);
+    if (ret) {
+        return ret;
+    }
+
+    if (!iterable_only) {
+        ret = qemu_savevm_state_complete_precopy_non_iterable(f, false);
         if (ret) {
             return ret;
         }
     }
 
-    if (iterable_only) {
-        goto flush;
-    }
-
-    ret = qemu_savevm_state_complete_precopy_non_iterable(f, in_postcopy);
-    if (ret) {
-        return ret;
-    }
-
-flush:
     return qemu_fflush(f);
 }
 
-- 
2.47.0


