Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66032C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whaZB-0008F3-Bt; Wed, 08 Jul 2026 18:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZA-0008Et-Nn
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:28 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZ9-0004GV-9K
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:28 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-698beff7178so2118882a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783548986; x=1784153786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MazHJbKCHFojNo3ryzg4npnLeCDhiaoceFTMzGltIAA=;
 b=EQ4MvM/flXEZDlXxfktd3YCinolziDUQsx68FhKk0iEONlNy801VEbX6JnIBwQHHtH
 0U6wiF968iKgVshCFzkucQKLfwc26PMYNp6Xcx1J7oFieUR0firLFJ8/I43C9nF1/iqF
 +D/AL7LiqlZ5qtAfEWr65c+J2pecPFfaYRG7YT/yB7/maDx04fmN0nYm7Hkdi/uIGGjq
 0X70cg/gPW2ZkrCGyBYBKPdavVMFSzL4N35KyG0ICAE4sTMSVZPBmOCXIBy3Mx30TQQ1
 2Itdybh6PHERwHV+sMwzGuew2GPFmyEEm7zduj+OLC3Bh9TrgssqGHVei9X5ILQcY+yb
 Pq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783548986; x=1784153786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MazHJbKCHFojNo3ryzg4npnLeCDhiaoceFTMzGltIAA=;
 b=QfCeyzPifQLDML3xDWW6pMVcfk0vCXDMMhrmv6ULTqjrqp1udAxLLHqzUkMvpvqDZM
 1Xbjm6ngsf6Cn/glXAaMp+ZutE/iOptOWfY3fawhlYeh78Yr1wY6rtjLpnIazV2jDIT7
 W8mLjPwx6V7d84LMosTVHGMj0d7aKeRACNIrZWAX0DZZb4MyM9tcB1cO6a98p+HxLQbG
 T5IrgCuvKk+dUbrppXRT/nyBBGhlnQmIh1RCZWP2n72bolz/q7/qdwcL4gQfn5yAbrgQ
 tluS77/DMk3wjNYGfI8pysh/y2z2xchhVHDY82ZjP9b+2SiQ/CTJTR9kZUYPNoic6jNi
 Y2FQ==
X-Gm-Message-State: AOJu0Yya/MfguJtc769C4KfTMqBRaRBaGTnKilbMzQ1okXEW/VJ/Lhdl
 3USj36QyKOY0vGC1a9igVO75sGLDqpJ3nf4z+Zr7UUnyQGmfr3h4SVC6c7IH4m2O2kI=
X-Gm-Gg: AfdE7cmDyeHKTU5gfFnhn7yxyE0wfxqkwiEI6WwAVBoeeXt5qTUz2c888/DP+VWcmjd
 rj2nJE6M4gRRnl8qrRUWx2EkepRTxZS/5og4gDDULtTFUVQleAsgY0LfjRgNcZwysq9u6rYw+Ih
 X9/f8snbUAoxSadQDZU5dwGOQ0VoFF7vQGM8YgevnehLcmxVpoMPxomTFIzxI0P/MYzK0VajI+K
 Vx5g+OQTI3CsLeksOiMATVjIuMylUSe3/ETuAl8QBdz6Y0KpGEPQhgV4ArZOR40NtP+uXTzHnVI
 OTytNlUzeohr7Etkgntv0tjpW0s7qRk35BWDgAyStmmUpXL6YD4SbohND1dKwPclbj/GalM9Uwi
 MS/OhTtjt+lQgGNpqi5Ehm3Ll4brKqV6g4NDjjnvHe0VJVTkm0A2ZzCS2akEPwMKAjWRxz7fYvR
 lXhFvvAC5pj76QP21zInn0vLKJKuJuAfS/Qbc5ptl633Yq5Q==
X-Received: by 2002:a05:6402:4305:b0:698:585c:f07b with SMTP id
 4fb4d7f45d1cf-69ab44634e8mr1960238a12.3.1783548985622; 
 Wed, 08 Jul 2026 15:16:25 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:2200:181c:eef9:4c12])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d786e7sm9059237a12.16.2026.07.08.15.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 15:16:24 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v14 2/6] block: widen BlockLimits.zone_size to uint64_t
Date: Thu,  9 Jul 2026 00:16:11 +0200
Message-ID: <20260708221615.346155-3-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708221615.346155-1-faithilikerun@gmail.com>
References: <20260708221615.346155-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The zone-size field in BlockLimits is currently uint32_t, capping
expressible zone sizes at 4 GiB. Real zoned-device protocols
like NVMe ZNS allow larger zones. Widen BlockLimits.zone_size to
uint64_t to match.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c               | 2 +-
 include/block/block_int-common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3c985da94f..ddb159c58b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3600,7 +3600,7 @@ raw_co_zone_append(BlockDriverState *bs,
 
     if (*offset & zone_size_mask) {
         error_report("sector offset %" PRId64 " is not aligned to zone size "
-                     "%" PRId32 "", *offset / 512, bs->bl.zone_size / 512);
+                     "%" PRId64 "", *offset / 512, bs->bl.zone_size / 512);
         return -EINVAL;
     }
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 147c08155f..7571ed9968 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -901,7 +901,7 @@ typedef struct BlockLimits {
     BlockZoneModel zoned;
 
     /* zone size expressed in bytes */
-    uint32_t zone_size;
+    uint64_t zone_size;
 
     /* total number of zones */
     uint32_t nr_zones;
-- 
2.53.0


