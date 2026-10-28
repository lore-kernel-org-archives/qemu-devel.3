Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9DF606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CYD+XOeW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=l5Vk/kdZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7F4-0005rD-8F; Wed, 28 Oct 2026 13:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EQ-0004wh-KU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EO-0003Tb-Cq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ee1m00EDlWr0jEW8segC8pNIiaqTy3X6Sj5HozOvh4k=;
 b=CYD+XOeWT8VMw0cZTKW+aImKB0R20NImmQu38B13rzbQ2Bznuw5nxRKG2mZq94JTuW2C1+
 fIvSca+pbs/p1HPk92aNtyzRbBOsHqP3WgCcDt6ULXE/8PuF2YYyZ+qvxsr/VpsQJPC02i
 CPvZP7XnmqcbEekjJCEPuFFw2SWvKjU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-dGiiNs-pMPGt6RJ9uAPmpA-1; Wed, 28 Oct 2026 13:14:29 -0400
X-MC-Unique: dGiiNs-pMPGt6RJ9uAPmpA-1
X-Mimecast-MFC-AGG-ID: dGiiNs-pMPGt6RJ9uAPmpA_1793207669
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1fdde384cso8403715e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207668; x=1793812468; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ee1m00EDlWr0jEW8segC8pNIiaqTy3X6Sj5HozOvh4k=;
 b=l5Vk/kdZKDuQsfcb24JzR1HJZyTQ5Wvntj/f6161hniG2I718JP33D5clc/tyq5l1A
 r2PQD8UgUnooLPs2iC7SQ8AD3nq1loXOM2zk3V9hErtYQSb0ZMveB6sCWEA3nbmR+yQh
 T/Nf9y2wUjpP344ifdd+kM5oZVafEQe67iJjNsvk8KCjmv5ZemCB3YOo4HHUAdadjCTt
 kp8iNRDfHFGuUO/OxNtVZ+UL4nSKX/ToiiOVJ+FEbBWIHlZ4WP2+1v3f9B0ERrcF7XSf
 Riy9kXLnfa5ULR0q/SiPceITcjchgaLuzOfB3fDYyi/sA6wexIH4kVqafI5mDT8VozaJ
 emOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207668; x=1793812468;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ee1m00EDlWr0jEW8segC8pNIiaqTy3X6Sj5HozOvh4k=;
 b=y/pTDcGbvE5BOMJrbHeiirpHXJbRRJrSVinAnMvc1izC3MK5Hna4PAStKYdg4vcc33
 hwtr/VuVrdXF8tfcyLSQ0G/o08NfPtlO/0wWGQUgxucOpLHyd8+2E/HTScrttDf9U46j
 CM4TY8D1OnjWRF5FYbh1R1Ze7SdxSo4+7QXPDVk57xCTZpI+Jp1wnptgHXSeHwT8m5TR
 VKnkOatDifu3R3rjv5NZINg5jXSgX6uRsoPyOGYkTHeKPmHUAno0RICs/BY/sFBZXzT5
 69rTvq+SS/na1WW1V9IEXQY4TkpBbF4MMF+rWjFT8bk6T3xp4UN9NlliMjECXhvXu1Ud
 XT4w==
X-Gm-Message-State: AFq9FYJG6VpIOF+3dRU3kF57yqcAuxt7Uuoy/HZMO67i3qsspvPEc8eX
 TNmZUZOdNKp/JAXLGsO3CDU0wQAfJcgmXoFOTIVCPsXuT9XMbxXRxr1LwXs1enmEmQHoUcxCSt6
 exXFWMLPBi/xSN5unvcrSsgmoTYHiOwbXD8XbXxyNiuzSw6/NOyzt8mZvxzthHU9wbdltGTPfXH
 j6m04qBqIwiOnHTPLv8UYjDQPEBH9nz59f0A==
X-Gm-Gg: AYBFou36TAkmPJPZUjyFuFekkYBzGEnP7jdGRwWfVcjTNoYn00/WeyCGBLmMa+Htcgr
 UDBuDHPK3QvxDRHndA2kbf2D0e2VtKW30xjk4qoOkhutchyUjfjWD5v7Xar/I9kdqoilMJED12R
 NKn4vLHLwoZZo7x6rrg5XhftT5CJTZAnNUQNnjPyunXFqIOSD9yuwn4kDMvUC27o2RFvyvh6kZi
 5eJ26ry0KFoSK3UBzXUFa5kjpbuksBV8gcoJZ2QTqXVLynxN+wHltFJ6CH/sHlTAvJv3AZEYIRy
 YPdSv5jHjdIkwUmDlAvDI439BjE9LZSG6KMRFRSk3fy+QECBG8r4RprB4CRgu35Tn1cVhE0XUzO
 m/WgBGm5P+evrW1XhCHVtbeL6Pugs9DB4s7LDVqdN
X-Received: by 2002:a05:600c:154a:b0:4a0:1efa:c74a with SMTP id
 5b1f17b1804b1-4a9678c26dfmr64048435e9.20.1793207668461; 
 Wed, 28 Oct 2026 10:14:28 -0700 (PDT)
X-Received: by 2002:a05:600c:154a:b0:4a0:1efa:c74a with SMTP id
 5b1f17b1804b1-4a9678c26dfmr64047335e9.20.1793207667775; 
 Wed, 28 Oct 2026 10:14:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80285b88sm6378075e9.14.2026.10.28.10.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:27 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 12/78] migration: forbid snapshots in CPR migration modes
Message-ID: <7d806e21fb37cb5c573e62218b9238391a78807d.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

The savevm/loadvm operation doesn't make any sense in any of the CPR
modes.  Saving VM state implies saving its RAM entirely, while the whole
point of CPR is avoiding that: in cpr-transfer and cpr-exec modes RAM is
preserved in place and never put into the migration stream (see
migrate_ram_is_ignored() in migration/ram.c).  As a result, a snapshot
taken with such a mode set has no RAM in it, and loading a snapshot with
such a mode set fails in the RAM loader.

Currently nothing stops these operations from firing with a CPR mode
still set, e.g. after an earlier CPR attempt.  Reject them early in
migrate_can_snapshot(), which guards 'savevm'/'loadvm' HMP commands as
well as 'snapshot-save'/'snapshot-load' QMP commands.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-3-36c38bd15ffc@virtuozzo.com>
---
 migration/options.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 46d040fc3f..92eda90114 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -560,8 +560,15 @@ static bool migrate_incoming_started(void)
 bool migrate_can_snapshot(Error **errp)
 {
     MigrationState *s = migrate_get_current();
+    MigMode mode = migrate_mode();
     int i;
 
+    if (mode != MIG_MODE_NORMAL) {
+        error_setg(errp, "Snapshots are not compatible with migration mode %s",
+                   MigMode_str(mode));
+        return false;
+    }
+
     for (i = 0; i < check_caps_savevm.size; i++) {
         int incomp_cap = check_caps_savevm.caps[i];
 
-- 
MST


