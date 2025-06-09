Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D89C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDM-0008Tj-8j; Mon, 09 Jun 2025 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDJ-0008ON-1X
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDH-0004U0-FN
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDCSHE7UZto1NWz1vjWrhDSXJj9UdV9w/vzQlY4ASS0=;
 b=O7gG/M5p4zxPECmBo5fgLZd/SLfpi7Q+OV0CANhfwvhsqNcETbDbBqXCGxaYBtLtTgG3oX
 FR8jNvZZiXVeCDKqcuOdYhPYtooI3BqNZE5mQfzFQdAMrLpsJvvyQ/Aa1j6bUsW9WTcw2h
 VwMqR98YhcpJp6n3NmKdosavRqpwhiA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-dgjchpKsPcqjUIDnAUdmvQ-1; Mon, 09 Jun 2025 12:19:05 -0400
X-MC-Unique: dgjchpKsPcqjUIDnAUdmvQ-1
X-Mimecast-MFC-AGG-ID: dgjchpKsPcqjUIDnAUdmvQ_1749485945
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6fb1f84a448so7772496d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485945; x=1750090745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDCSHE7UZto1NWz1vjWrhDSXJj9UdV9w/vzQlY4ASS0=;
 b=T3NY7Y0p/Y3Fkk4FOenPSmb8rg3n9Zp7mH60EZjOaGp023/b/+uat6jC/RpkL5A9JG
 ovLxxT16pXs8gZRB4pr/kXGe4M56FaDfWzSi2Kgoq6LQFZsVgjDMws45w5kGwwp2KZh6
 uGjsxDbzKqZsiKiOv4Ir24tybGtYGcycMZuf/RULcbaHu69YGHQX00/tBLjeMVFkSnLD
 NvzlXvVxUVUi+9fmpsB9RUw52Z464lty4gZc/GnryiukBBAPKMOI0+F+xGOMS5F/aFTv
 TxEHrJtxY6UIig/7JOpWKXC0DNdZIH5hqiKVVd0BECmPjDi/cVtPjafpr/R1UslXoMo2
 94eg==
X-Gm-Message-State: AOJu0YzCdmalBMmLIdTU72Rmrzf/tgSPfSiNyGSma0X9L38zv/cFPykN
 BB46Dwh6HjaqniwJ0JKZDUgXAEAemZUS1qL31XumkCbI66amzufwB4HnncC7Q+hrSzlDDL6GMHv
 9DLKXNK7mFv06Ot/hvc1tcoMlO8hQleQHo4o1udv2PA9lToYqxudKdlrYwwV3VjG1d/kcy7uCof
 ZepZBrKqN1a+t9aG1RNRyIUojow1QecMXpcwl2Lg==
X-Gm-Gg: ASbGnctaNL0uNwnSpyTLPJ8h2am52TvWpN9v8bQKARGDkGq9OZPHYG3fnZgdzjSP2+P
 YDeb0ZsjkpQnggwoH+TMzXLvECpHLwxxvtcR1qlPgqEdrrnHLx2KuUlh7fu0ca+aE/Cn2vK62ry
 RFApv/0rUja1YZ/nfbjveaT0Y9VrPpMjTimvpMBAuIrdye8xACvEsxzD/+MFR4qKxsACrWNOMlA
 HSxLqJ+fwwW0D3U+KWfhEqJSbZWHdwY0vl1owYBAk/vo05WUSwcn9ZnfjOrLKcGvKAbzF802XUv
 FjxwTA1GaRMo6w==
X-Received: by 2002:a05:6214:d68:b0:6fa:ccb6:6036 with SMTP id
 6a1803df08f44-6fb08f8d31fmr217734006d6.35.1749485944641; 
 Mon, 09 Jun 2025 09:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErobSbYOP8oWeS9RDsAXGUPZIAOJdLibvL5y6Ss1B80VuId+QxeBBsQPHt/ImkJHS9JaYocg==
X-Received: by 2002:a05:6214:d68:b0:6fa:ccb6:6036 with SMTP id
 6a1803df08f44-6fb08f8d31fmr217733226d6.35.1749485943949; 
 Mon, 09 Jun 2025 09:19:03 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 04/11] migration/bg-snapshot: Do not check for SKIP in
 iterator
Date: Mon,  9 Jun 2025 12:18:48 -0400
Message-ID: <20250609161855.6603-5-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It's not possible to happen in bg-snapshot case.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4098870bce..e33e39ac74 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3887,9 +3887,8 @@ static void *bg_migration_thread(void *opaque)
 
     while (migration_is_active()) {
         MigIterateState iter_state = bg_migration_iteration_run(s);
-        if (iter_state == MIG_ITERATE_SKIP) {
-            continue;
-        } else if (iter_state == MIG_ITERATE_BREAK) {
+
+        if (iter_state == MIG_ITERATE_BREAK) {
             break;
         }
 
-- 
2.49.0


