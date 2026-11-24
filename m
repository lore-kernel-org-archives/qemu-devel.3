Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0E5606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=eS86t5Lt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVu85-0002Ub-PO; Tue, 24 Nov 2026 12:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1xVu84-0002TY-F4
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:16:28 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jorge.merlino@canonical.com>)
 id 1xVu82-0004ts-EJ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 12:16:28 -0500
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1089B3F4CB
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795540584;
 bh=mCNIxrm00BXVM+L8K4SazVkpO6h3z2fCDCv1UEbQD88=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=eS86t5LtTx+uNq2l+okiiEHtCVns8pvxOxEPuZ5aV1zoxb3G4/b044iRAsgd9DcDf
 yT5767eaHeBK6X0yKJfTt6r/Dka/fRwBUpZOGKPxyxwRLpzbrglABKFIc/GbeacXEq
 CLyjtuZAl0tS8+kNXcOymv6dNEjS8DQVRgJQfOaEnJ5+tMHocOV4HnC70efGmlsgCH
 4o4INpzujLwjoOVGOISnlRJobTS2Lpfq8rOW6l4+LXCNTfGceOJAM1zAYa+LG+gh/N
 gdaQVrWIbW8oYGHa0o2hCFMbJGZ+2piziVrnZOSRlaC0aAWfZj92tADJgmYIxZQ7Sk
 apkBxwiMUlQ2nAG8LoUoWA07qMcag+QphLNWLlXBejt4ALeCT22M+idycGqNuUex5j
 JQBSZQy6woRFLOxh+IaIRsbtjzv+GaMME+qFsNVimTV+RqlBKZWcxuXOhrfmhxwvor
 euoU9EpSUbI8eRoWnAneMbe7PN1dhV/UI6dKVborDyMGGZ5LhaVkYHZ1ZV00xszLpD
 FgvMWtcwC8PO45beI+hvUxVm0EPP/dcJ4uBKClBsZbiLwZDLBsjqw8xM/9yOQkkJEH
 FLIAEeW1VPjvdtDkka0N6zykbXSJMh246MbpWedPIdpO7x6o1qu0pOIZRacPak/PeU
 ZBY8VMayXSwNJzmc43e8iSkE=
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98a829c43f3so912282241.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 09:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795540583; x=1796145383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mCNIxrm00BXVM+L8K4SazVkpO6h3z2fCDCv1UEbQD88=;
 b=EiaRqGHHuCdXHWUqsnEMkVanZ9AbUGpmTcHmEWndABW30CP4E2NXoL+AefNWk0Ie9C
 ndNIUhTc05CAIpX3xXAsFtv2L1erYTZQACX0LBcTe3mlrPbAB5dGqWeLgen6XNE1j8l6
 cMdKbT5pK5eeeZKdDOdPUinF01vyby7L3EB419VdHwEhGw5H87gSsij16/YerZdxTwHb
 5OHuzWg13BVTT1rRse/Y8mZzs121II3nuTMNSAorDFJcFk/5r7b3pKTLrgz5/JomZAVt
 4vFeASTM1RwLhQ5sipTHunN3rG1HChlKGXgKg+Ri0+QDkKb9vIyNBR2O/BX5LjRJ7Y7N
 8Kkg==
X-Gm-Message-State: APuU4Z/yMkCYC/DWSGhT0/6Apo+gASo+jIyri2vpOkj1d0TmAFNQ55oN
 //SjJDv2yeA6lhMOVUD9id6kkLKXpn86aJUXT/G97buXDeix9nliQ00C9Mr3dd1yFKvv5Sneoti
 BIahqNliNrI7eXHy/y8Sxx8fixxsoliFDQQEUVc7Dwu5trXNBBdMo9nsFN+bNiPvPaDuz3OaJkU
 hqAPF0r2Y=
X-Gm-Gg: AZFdTZdG4LJQL/QClxrMtgd6L0fhpAAE4zVLPlw34oAiugTtsxRoC/DGRfK/qUDkAM+
 efxDS0FVxj9UBeRishO6sdNXFotbmyTGMMwQ06jEg5IYmcXpV1yUZrwCmyed1X/298GetseDH0w
 qpsqVWgRaKgkqm9hP8sYYlBe4xqvN1JtrYSjc0r79A/VIXkmi1aDvv2JN9iNorWEMlkQq0ac09W
 U495xPA+vq1hIsV/HxwrVBzP0Hsz0upe3uU4BBtSW9P2+SBHltCIz3ZlR1842DWKMMcoecm1011
 sOzG25W85DA+qsifv73GWUDfVveB0XeiINcxAs+zvZUqEH54u54AnQxBt8Oq7Smj/VHehUZ7HAb
 Wrh8giiqjmYh6igymujmTiJ5hrIqflyE+8qy0qexC7c0jSlOJy/cSms/6n1vpWobULhqdGbXg+W
 BdvvbozwaMRS1ZgjJCo3/X5xY9ChPaxYYx0skhhRbbYNoy9spiF6jZYjhznf8=
X-Received: by 2002:a05:6122:208f:b0:5ec:c3ed:7d99 with SMTP id
 71dfb90a1353d-5ee8aea67b8mr7693910e0c.6.1795540582881; 
 Tue, 24 Nov 2026 09:16:22 -0800 (PST)
X-Received: by 2002:a05:6122:208f:b0:5ec:c3ed:7d99 with SMTP id
 71dfb90a1353d-5ee8aea67b8mr7693853e0c.6.1795540582285; 
 Tue, 24 Nov 2026 09:16:22 -0800 (PST)
Received: from canonical-laptop.local.merlino.uy
 (r167-56-144-32.dialup.adsl.anteldata.net.uy. [167.56.144.32])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee8b6641d6sm14707446e0c.17.2026.11.24.09.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 09:16:21 -0800 (PST)
From: Jorge Merlino <jorge.merlino@canonical.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 Jorge Merlino <jorge.merlino@canonical.com>
Subject: [PATCH] Add debug for block operations
Date: Tue, 24 Nov 2026 14:15:37 -0300
Message-ID: <20261124171537.198694-1-jorge.merlino@canonical.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=jorge.merlino@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add debug tracepoint when block operations finish

Signed-off-by: Jorge Merlino <jorge.merlino@canonical.com>
---
 block/block-backend.c | 2 ++
 block/trace-events    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 656c0aed67..97a7e74c09 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1365,6 +1365,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = bdrv_co_preadv_part(blk->root, offset, bytes, qiov, qiov_offset,
                               flags);
+    trace_blk_co_preadv_done(blk, bs, offset, bytes, ret);
     bdrv_dec_in_flight(bs);
     return ret;
 }
@@ -1443,6 +1444,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
 
     ret = bdrv_co_pwritev_part(blk->root, offset, bytes, qiov, qiov_offset,
                                flags);
+    trace_blk_co_pwritev_done(blk, bs, offset, bytes, ret);
     bdrv_dec_in_flight(bs);
     return ret;
 }
diff --git a/block/trace-events b/block/trace-events
index 950c82d4b8..842c3fc809 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -7,6 +7,8 @@ bdrv_lock_medium(void *bs, bool locked) "bs %p locked %d"
 # block-backend.c
 blk_co_preadv(void *blk, void *bs, int64_t offset, int64_t bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " flags 0x%x"
 blk_co_pwritev(void *blk, void *bs, int64_t offset, int64_t bytes, int flags) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " flags 0x%x"
+blk_co_preadv_done(void *blk, void *bs, int64_t offset, int64_t bytes, int ret) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " ret %d"
+blk_co_pwritev_done(void *blk, void *bs, int64_t offset, int64_t bytes, int ret) "blk %p bs %p offset %"PRId64" bytes %" PRId64 " ret %d"
 blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 
-- 
2.43.0


