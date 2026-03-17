Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C19FF6E7C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 21:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2bXr-0004Nj-7h; Tue, 17 Mar 2026 17:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1w2bXg-0004M2-Fs
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 17:01:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1w2bXe-0000Qo-OZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 17:01:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48540355459so59754725e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773781288; x=1774386088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VMvzzOtTIFMkmpUCSSaxMUUuqn1TV0hVfuhTrNVtLbc=;
 b=OjBLQDucWcueT+xFJliupbRfo9iob3+xGb17VNHNzGVdcm0iNfFwb6Dn9F/uX+cIrT
 E6VZ5soQYb+bQcylwPziNQXPknGo28gQJ6u/s0fI+P/YB+Ly3RqicuRul3IKiz3OYSC7
 ntDumHkay5Enj0GnZM7pTYSCoZ7U/X9GdfBVO/WbB8NjKdufonl+C6DBu36kEbKXHpW+
 BIx2bra47aFM1hMmBqkfgZ3oLahEw543BwtZcrkjiiq+h4CEm6kcLcuYvtqRfo6/K8AE
 HKaxKKtM5yrhWIVAZ417bvj8FiRJqXOUOUKdEvk/obf+CBRBLqZQd35l3zOkjF2DhUQj
 omgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773781288; x=1774386088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMvzzOtTIFMkmpUCSSaxMUUuqn1TV0hVfuhTrNVtLbc=;
 b=IwSaMcmKfjCp+NMkw5hORUoXMIws1JWwjIF/LeFxRqyd8KibbiSTNI8VGJrpDzzItV
 OF1FPfxczhoxdF2RCQYhN8dQhbiq+YkU2TBjh04rF/oh9OXp186YtnnpXtYx4ouziCA8
 FN70ddmcUzIlbwYz/9Y1sxkKWLNIOo7011aoehtpzp9858MCRuk1E31Y0VGnSyo41/0I
 Db7HSbthJpLw1ZuPEVG/n9EzfDnXvCYB7W6aRY/chsVgPYMPwLVFpMUNQ3GMEwu+JCx+
 xNifTxn5BDYcwP8ix+KBZ3HUnhFU8JBxqkhk5aPc/1GXyPohSwqLuMLtHNy3bek3Hbxa
 h0xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0gGA/JQ4+569ZSut2fFnEPg+ZuW6UGclyX44XhBPM22+5k8/+g7ZHe1b50oRTELRtCRYK51px/yxp@nongnu.org
X-Gm-Message-State: AOJu0Yy6Asw3q9UBS92LB93DxIWtu4P1hTCP9zmJAQsx0JDsYMxgOtzH
 Br9n4gwChxavVBjLiPfLO1IFOoVJGkPfpqYK3Z3xTyffGDHx7MVt9FEX
X-Gm-Gg: ATEYQzxPx7vS8V9OWnGvMVjz4O5KoGEvzrcHHzo4Re/RrkUFJthjNMTEItJooaWcOJ7
 yH0gFFFKdvu8JCz0WKT29p5Xtf3ZfafSVQWlBAdjOMStxtNd6mU8uGiaT6McPFZ5Hvqs2lSAnD2
 skFtBZpUO4PyNvt3g8hrZTnZdibsatYdHriPkB9ZXJtSSNMMxtHu4mlP+wuUfXOhT9NSA8DSIGc
 wKde9XeRckbn8hDujTHJgvOWN1FRf6Oovo0YPcGdAE5X6qvUHkGOm24IklS6Ht9bL/jSjD+ajs9
 vNtLznF8JzYEe3UpkBYrUBoQzp9XJOxqJ57lfP9vE1WAs4H4ZbvGY759WMeHo5gDYsHnPH+awcf
 4JLnNQnw1V0dsb/d/4uhNaZiLodCUP4mZZTUYfRjVz9RxIseWu9hmDibZRdRKmiuj92inkRHvUw
 LMoJM+4cUFnUPc4SQcmxe8A3MQXXZZLwK5++kmGC1G
X-Received: by 2002:a05:600c:358e:b0:485:40a6:442e with SMTP id
 5b1f17b1804b1-486f41ff20dmr20867355e9.0.1773781288175; 
 Tue, 17 Mar 2026 14:01:28 -0700 (PDT)
Received: from localhost.localdomain ([92.180.8.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eae3322sm76955865e9.10.2026.03.17.14.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 14:01:27 -0700 (PDT)
From: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
To: mst@redhat.com
Cc: sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org, Razvan Ghiorghe <razvanghiorghe16@gmail.com>
Subject: [PATCH] vhost-scsi: use virtio_error instead of exit for sense/CDB
 write
Date: Tue, 17 Mar 2026 23:00:06 +0200
Message-ID: <20260317210006.187234-1-razvanghiorghe16@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Until now, writing to the SENSE or CDB size register would terminate the QEMU process,
but a guest should never be able to crash the host process. This patch replaces that
behavior with virtio_error() and marks the device as in error, allowing QEMU to continue running.This follows the same pattern as other vhost devices.

Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
---
 hw/scsi/vhost-scsi-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 0bb4305de6..938e9d9965 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -140,9 +140,9 @@ void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t *config)
 
     if ((uint32_t)virtio_ldl_p(vdev, &scsiconf->sense_size) != vs->sense_size ||
         (uint32_t)virtio_ldl_p(vdev, &scsiconf->cdb_size) != vs->cdb_size) {
-        error_report("vhost-scsi does not support changing the sense data and "
-                     "CDB sizes");
-        exit(1);
+        virtio_error(vdev, "vhost-scsi does not support changing the sense "
+                     "data and CDB sizes");
+        return;
     }
 }
 
-- 
2.43.0


