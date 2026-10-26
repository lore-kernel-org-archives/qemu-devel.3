Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D3606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=gMp8R6T1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOiY-0004lb-LE; Mon, 26 Oct 2026 13:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiO-0004fC-8I
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:33 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiJ-0001Xs-Vz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso3374400f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793036545; x=1793641345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iZ64/4UZ5WTW1uc5/rq6b03krqWbjLS2gvBHMW/9La0=;
 b=gMp8R6T1P34j2y6+d6bMCzZdcohbhMtn5ttUY3iBzzkacQse2MC7a0COJVGDZi4tli
 FYS2HS+AvTTc/2DPUOdRQdCyB/GYGN+b9XeSOBHpyRCAHeqmaMPQ1qYIQpX3zmkO4zrc
 iUN8WztycQuPsaFChl9VHRdZbOPQccsb5ddwn1vfWRwXUZsTMud6/8kx3fWnYFAC3H9/
 hS3BfNKkOLztYQcsWMMKgT47m3Y+DfjCo255JrspK0XB2Umme89rrdAgvcoATacQeQ+c
 7NaWGsaTtVbkODbhS0Yc1qoZ8JQcuKyLdkVmr40RQPUcvBYIVUcgLRx6DRD1ja+nqlsp
 OjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793036545; x=1793641345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iZ64/4UZ5WTW1uc5/rq6b03krqWbjLS2gvBHMW/9La0=;
 b=uZOjVD/JSO+iRKt13ksMm/F/FEnofd+rqqTBBpH6iJAArYNJVkRmW3ygoZgNGFQv6u
 5NEfhcCbq0m39Hwy14IzeoHuHd+rf4MQz26UZLAcGql9ISzgugP/+PLra2zxyyjmtZbl
 L+8LWgsFs+1rG3NiMdMdrj34DMxi6RMcNOlx6NqdiL6Os1WD63RvoN5rBAQfD8qHZQFl
 8aJkTfuQ9udembJa8MsTEzLTAbd18F9tCmELACyQZIbnpyoLRGf1k/TQpdTEuTOvC2u6
 cGG3x68sTEpNgJPOArdn+QtA2Ow/I6n1ylIdhzW2MrHjLNHqRsNcsXRaz+FIb23ycuFi
 IAKA==
X-Gm-Message-State: AFq9FYLNHsfF/FSZXizRYK0tj5KA9o9BfJAjuLETHv5zNETk/9vX3/0k
 uwZOj71AYTq/BzL5eZiot8ABGffoe9ptQSsPVTTSIgGy89jhtsGuA4iD6a+2cdz90k/HnyQa2ho
 JDQLB
X-Gm-Gg: AYBFou1HjB2FCj7BUkwpqRbP0HwpTurvdufKvJ3x87ztVOgb2PfQmbplyezP1J9V5hX
 7OTh20FiGVBNA/8D+32uRXTCwrpAjOTe4pHoEsuG2GEDid7BIaGtfAWSiTdx8i0+m8GlYpSE2Az
 VD0HR40cHgmSVAIndmtArNR5M3LkQewaR0qFthFhc0oasqgIvnO0k9fiRo2/UD2RcljWrgrbNaU
 2lUq9Fxggl8eQE68Jd2pZ96T2nqkDa4BJ2uDE5gYL3HVuajH95rQhW6t26tl+FY5yibUzEsLNkh
 ibcLPaFg94bYyEu7m4H0htftlrJdxCUtnHUO871TDvAUlBXpar794a3VdTVTABQQkscJT2ha/EK
 ggLZhx8oTVC3nsujONJ8qUjfoPnt0dwDH1jmPXrNQ8oasRi3BEy224lFQ3j5+KgQEmfoPk5PtxI
 npxhSrUd9M3mQe90Gw4fe4LNGXLgRknFcxYMh7f4U7YNwqoTGhOZrjjaG9oq4EFIBwkRgomFxNr
 V7KNu9q60k9/T/TcRY4dDmREpiELjLK5nAx8jzf9YNfv9SQAl0=
X-Received: by 2002:a5d:650c:0:b0:48d:dfff:fe6b with SMTP id
 ffacd0b85a97d-48e3eb7b517mr11294318f8f.34.1793036544843; 
 Mon, 26 Oct 2026 10:42:24 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1a6:7f7f:f573:ba9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm16169111f8f.22.2026.10.26.10.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:42:24 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/5] scsi-disk: check all UNMAP descriptors before discarding
 any
Date: Mon, 26 Oct 2026 18:42:15 +0100
Message-ID: <20261026174220.674460-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026174220.674460-1-den@openvz.org>
References: <20261026174220.674460-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=den@openvz.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

UNMAP checks each descriptor against the capacity only when its turn
comes, so a parameter list with an out-of-range descriptor in the
middle discards everything before it and then fails with LOGICAL BLOCK
ADDRESS OUT OF RANGE. Validate the whole list before the first discard,
so the command either fails without touching the medium or runs to the
end.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: qemu-stable@nongnu.org
---
 hw/scsi/scsi-disk.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6341089ddf..73c1ecba0b 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1773,13 +1773,6 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
         r->sector = sector_num * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         r->sector_count = nb_sectors * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
 
-        if (!check_lba_range(s, sector_num, nb_sectors)) {
-            block_acct_invalid(blk_get_stats(s->qdev.conf.blk),
-                               BLOCK_ACCT_UNMAP);
-            scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
-            goto done;
-        }
-
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
                          r->sector_count * BDRV_SECTOR_SIZE,
                          BLOCK_ACCT_UNMAP);
@@ -1794,8 +1787,6 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
     }
 
     scsi_req_complete(&r->req, GOOD);
-
-done:
     scsi_req_unref(&r->req);
     g_free(data);
 }
@@ -1824,6 +1815,8 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
     uint8_t *p = inbuf;
     int len = r->req.cmd.xfer;
     UnmapCBData *data;
+    int count;
+    int i;
 
     /* Reject ANCHOR=1.  */
     if (r->req.cmd.buf[1] & 0x1) {
@@ -1849,10 +1842,21 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
         return;
     }
 
+    count = lduw_be_p(&p[2]) >> 4;
+    for (i = 0; i < count; i++) {
+        if (!check_lba_range(s, ldq_be_p(&p[8 + i * 16]),
+                             ldl_be_p(&p[8 + i * 16 + 8]))) {
+            block_acct_invalid(blk_get_stats(s->qdev.conf.blk),
+                               BLOCK_ACCT_UNMAP);
+            scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
+            return;
+        }
+    }
+
     data = g_new0(UnmapCBData, 1);
     data->r = r;
     data->inbuf = &p[8];
-    data->count = lduw_be_p(&p[2]) >> 4;
+    data->count = count;
 
     /* The matching unref is in scsi_unmap_complete, before data is freed.  */
     scsi_req_ref(&r->req);
-- 
2.53.0


