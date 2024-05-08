Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2820BC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4h5s-0005DY-5i; Wed, 08 May 2024 09:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dks-0007c2-GN
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:30 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s4dkq-0000ZR-D0
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:38:30 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so3653242a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715161107; x=1715765907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbH5d8nS0+8RiFpo1WcBikzFAHCe+8opa1Qcgy0NVCI=;
 b=Dj+5MBffk+eSkQj5nbGEx7LxHYR+EVwpzilYKWxxE+zHJcMF8GYJ78rDxNnufoIxkF
 CSALNhGSj3GXWKRu77XKnot3JvC2yakp5EbJxpuTZFTX0wdPAbmA0EBv+SCLd2d2PjFZ
 Sg+/7xQDCRoZUA3iIomltIiN+Zs6kcwXM1SIgkkx2PBRnhvPBaW2gBczm00FDWAcVG2H
 hN2gpO9dCT6EBcCKWgkjhjdxJFBwPCG3AA6HyG5ur5Bk8pshFoHjdMFn79Nr98pEN4Nl
 5KUf6gMyS3H4sMDegWWpoaSl6qc4pirVwqz2laFtALLV/Fj+uRy0opOCJ5ofjKw8Zx8H
 jQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715161107; x=1715765907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbH5d8nS0+8RiFpo1WcBikzFAHCe+8opa1Qcgy0NVCI=;
 b=nZ10IqqPgWYSeKiUsggQ5sgGepWa7qUdJ8PuNJiOyvHynCnIbS0vACIkV4VfPEOHuU
 x8/S8eX42ms9qlmQdI68zgF40krbqecDrKCFAxA1NiQfUcm6kYsVw4aC1mv+ni79mETe
 IfdBsEhXAnVsm8JTQ9T6yzp1w/8aYF3jC7+szvAYvvzoe8LkGx6Cbkc6Vydxfg5Q0FWl
 k6nthVIXUmJ9dmYxgjNtkVnA11hucqkbjfBIi+v0+cSJZuladxnkNTNxteCRqZsXj0uW
 LjhPW9PlvMSoF9Nif3EL47Lgh6MtTQaF2CuXz0vNXSp2GJ6VekmK+hCPTi2Q+/SXmFLC
 LxSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX11fygj/sMCcIOo/dpweWMdKt1zYEOW6+xhCraw7IXUdrrNbWb4VAfJSX9gRy9O/cqSCWWl5eCp+QCRNWRE9nr2ZFL3hU=
X-Gm-Message-State: AOJu0YzN14vcfMLHzo4aMVAz9IuduOAjKEO8O3i2PSt1KeN87Xj/BlfK
 LXjHJAjYi17NAoF53g8dlYn2mRuNcLXysGkrOwgTYlNkKnF01PGvvMC8bo1FI4s=
X-Google-Smtp-Source: AGHT+IE8JgTSnzTmrzUAD6JKxEV2KtwCPZ1Xb9QEBHEYQNVRf1bSp7v2AEzEqnBBIcDe0+aheZhNOQ==
X-Received: by 2002:a05:6a20:3d8d:b0:1a7:5780:1f4b with SMTP id
 adf61e73a8af0-1afc8d3a125mr2776356637.24.1715161106828; 
 Wed, 08 May 2024 02:38:26 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.134])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a1709027ed000b001ee13eb2bedsm4992178plb.98.2024.05.08.02.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 02:38:26 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 Changqi Lu <luchangqi.123@bytedance.com>,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 5/9] hw/scsi: add persistent reservation in/out api for scsi
 device
Date: Wed,  8 May 2024 17:36:25 +0800
Message-Id: <20240508093629.441057-6-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240508093629.441057-1-luchangqi.123@bytedance.com>
References: <20240508093629.441057-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 May 2024 09:12:22 -0400
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

Add persistent reservation in/out operations in the
SCSI device layer. By introducing the persistent
reservation in/out api, this enables the SCSI device
to perform reservation-related tasks, including querying
keys, querying reservation status, registering reservation
keys, initiating and releasing reservations, as well as
clearing and preempting reservations held by other keys.

These operations are crucial for management and control of
shared storage resources in a persistent manner.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/scsi/scsi-disk.c | 302 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c..bdd66c4026 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -32,6 +32,7 @@
 #include "migration/vmstate.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
+#include "scsi/utils.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
@@ -1474,6 +1475,296 @@ static void scsi_disk_emulate_read_data(SCSIRequest *req)
     scsi_req_complete(&r->req, GOOD);
 }
 
+typedef struct SCSIPrReadKeys {
+    uint32_t generation;
+    uint32_t num_keys;
+    uint64_t *keys;
+    void     *req;
+} SCSIPrReadKeys;
+
+typedef struct SCSIPrReadReservation {
+    uint32_t generation;
+    uint64_t key;
+    BlockPrType type;
+    void *req;
+} SCSIPrReadReservation;
+
+static void scsi_pr_read_keys_complete(void *opaque, int ret)
+{
+    int num_keys;
+    uint8_t *buf;
+    SCSIPrReadKeys *blk_keys = (SCSIPrReadKeys *)opaque;
+    SCSIDiskReq *r = (SCSIDiskReq *)blk_keys->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(blk_get_aio_context(s->qdev.conf.blk) ==
+            qemu_get_current_aio_context());
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    if (scsi_disk_req_check_error(r, ret, true)) {
+        goto done;
+    }
+
+    buf = scsi_req_get_buf(&r->req);
+    num_keys = MIN(blk_keys->num_keys, ret);
+    blk_keys->generation = cpu_to_be32(blk_keys->generation);
+    memcpy(&buf[0], &blk_keys->generation, 4);
+    for (int i = 0; i < num_keys; i++) {
+        blk_keys->keys[i] = cpu_to_be64(blk_keys->keys[i]);
+        memcpy(&buf[8 + i * 8], &blk_keys->keys[i], 8);
+    }
+    num_keys = cpu_to_be32(num_keys * 8);
+    memcpy(&buf[4], &num_keys, 4);
+
+    scsi_req_data(&r->req, r->buflen);
+done:
+    scsi_req_unref(&r->req);
+    g_free(blk_keys->keys);
+    g_free(blk_keys);
+}
+
+static int scsi_disk_emulate_pr_read_keys(SCSIRequest *req)
+{
+    SCSIPrReadKeys *blk_keys;
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+    int buflen = MIN(r->req.cmd.xfer, r->buflen);
+    int num_keys = (buflen - sizeof(uint32_t) * 2) / sizeof(uint64_t);
+
+    blk_keys = g_new0(SCSIPrReadKeys, 1);
+    blk_keys->generation = 0;
+    /* num_keys is the maximum number of keys that can be transmitted */
+    blk_keys->num_keys = num_keys;
+    blk_keys->keys = g_malloc(sizeof(uint64_t) * num_keys);
+    blk_keys->req = r;
+
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_read_keys(s->qdev.conf.blk, &blk_keys->generation,
+                                        blk_keys->num_keys, blk_keys->keys,
+                                        scsi_pr_read_keys_complete, blk_keys);
+    return 0;
+}
+
+static void scsi_pr_read_reservation_complete(void *opaque, int ret)
+{
+    uint8_t *buf;
+    uint32_t num_keys = 0;
+    SCSIPrReadReservation *blk_rsv = (SCSIPrReadReservation *)opaque;
+    SCSIDiskReq *r = (SCSIDiskReq *)blk_rsv->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(blk_get_aio_context(s->qdev.conf.blk) ==
+            qemu_get_current_aio_context());
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    if (scsi_disk_req_check_error(r, ret, true)) {
+        goto done;
+    }
+
+    buf = scsi_req_get_buf(&r->req);
+    blk_rsv->generation = cpu_to_be32(blk_rsv->generation);
+    memcpy(&buf[0], &blk_rsv->generation, 4);
+    if (ret) {
+        num_keys = cpu_to_be32(16);
+        blk_rsv->key = cpu_to_be64(blk_rsv->key);
+        memcpy(&buf[8], &blk_rsv->key, 8);
+        buf[21] = block_pr_type_to_scsi(blk_rsv->type) & 0xf;
+    } else {
+        num_keys = cpu_to_be32(0);
+    }
+
+    memcpy(&buf[4], &num_keys, 4);
+    scsi_req_data(&r->req, r->buflen);
+
+done:
+    scsi_req_unref(&r->req);
+    g_free(blk_rsv);
+}
+
+static int scsi_disk_emulate_pr_read_reservation(SCSIRequest *req)
+{
+    SCSIPrReadReservation *blk_rsv;
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    blk_rsv = g_malloc(sizeof(*blk_rsv));
+    blk_rsv->generation = 0;
+    blk_rsv->key = 0;
+    blk_rsv->type = 0;
+    blk_rsv->req = r;
+
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_read_reservation(s->qdev.conf.blk,
+                   &blk_rsv->generation, &blk_rsv->key, &blk_rsv->type,
+                   scsi_pr_read_reservation_complete, blk_rsv);
+    return 0;
+}
+
+static void scsi_aio_pr_complete(void *opaque, int ret)
+{
+    SCSIDiskReq *r = (SCSIDiskReq *)opaque;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    /* The request must only run in the BlockBackend's AioContext */
+    assert(blk_get_aio_context(s->qdev.conf.blk) ==
+           qemu_get_current_aio_context());
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    if (scsi_disk_req_check_error(r, ret, true)) {
+        goto done;
+    }
+
+    scsi_req_complete(&r->req, GOOD);
+
+done:
+    scsi_req_unref(&r->req);
+}
+
+static int scsi_disk_emulate_pr_register(SCSIDiskReq *r, uint64_t old_key,
+                                         uint64_t new_key, SCSIPrType type,
+                                         bool ignore_key)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_register(s->qdev.conf.blk, old_key, new_key,
+                                       scsi_pr_type_to_block(type),
+                                       ignore_key, scsi_aio_pr_complete, r);
+
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_reserve(SCSIDiskReq *r, uint64_t key,
+                                        SCSIPrType type)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_reserve(s->qdev.conf.blk, key,
+                                      scsi_pr_type_to_block(type),
+                                      scsi_aio_pr_complete, r);
+
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_release(SCSIDiskReq *r, uint64_t key,
+                                        SCSIPrType type)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_release(s->qdev.conf.blk, key,
+                                      scsi_pr_type_to_block(type),
+                                      scsi_aio_pr_complete, r);
+
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_clear(SCSIDiskReq *r, uint64_t key)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_clear(s->qdev.conf.blk, key,
+                                    scsi_aio_pr_complete, r);
+
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_preempt(SCSIDiskReq *r, uint64_t new_key,
+                                        uint64_t old_key, SCSIPrType type,
+                                        bool abort)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_preempt(s->qdev.conf.blk, new_key, old_key,
+                                      scsi_pr_type_to_block(type), abort,
+                                      scsi_aio_pr_complete, r);
+
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_in(SCSIRequest *req)
+{
+    int rc;
+    SCSIPrInAction action = req->cmd.buf[1] & 0x1f;
+
+    switch (action) {
+    case SCSI_PR_IN_READ_KEYS:
+        rc = scsi_disk_emulate_pr_read_keys(req);
+        break;
+    case SCSI_PR_IN_READ_RESERVATION:
+        rc = scsi_disk_emulate_pr_read_reservation(req);
+        break;
+    default:
+        return -ENOTSUP;
+    }
+
+    return rc;
+}
+
+static int scsi_disk_emulate_pr_out(SCSIDiskReq *r, uint8_t *inbuf)
+{
+    int rc;
+    uint64_t old_key, new_key;
+    SCSIPrOutAction action;
+    SCSIPrScope scope;
+    SCSIPrType type;
+    SCSIRequest *req = &r->req;
+
+    memcpy(&old_key, &inbuf[0], 8);
+    old_key = be64_to_cpu(old_key);
+    memcpy(&new_key, &inbuf[8], 8);
+    new_key = be64_to_cpu(new_key);
+    action = req->cmd.buf[1] & 0x1f;
+    scope = (req->cmd.buf[2] >> 4) & 0x0f;
+    type = req->cmd.buf[2] & 0x0f;
+
+    if (scope != SCSI_PR_LU_SCOPE) {
+        return -ENOTSUP;
+    }
+
+    switch (action) {
+    case SCSI_PR_OUT_REGISTER:
+        rc = scsi_disk_emulate_pr_register(r, old_key, new_key, type, false);
+        break;
+    case SCSI_PR_OUT_REG_AND_IGNORE_KEY:
+        rc = scsi_disk_emulate_pr_register(r, old_key, new_key, type, true);
+        break;
+    case SCSI_PR_OUT_RESERVE:
+        rc = scsi_disk_emulate_pr_reserve(r, old_key, type);
+        break;
+    case SCSI_PR_OUT_RELEASE:
+        rc = scsi_disk_emulate_pr_release(r, old_key, type);
+        break;
+    case SCSI_PR_OUT_CLEAR:
+        rc = scsi_disk_emulate_pr_clear(r, old_key);
+        break;
+    case SCSI_PR_OUT_PREEMPT:
+        rc = scsi_disk_emulate_pr_preempt(r, old_key, new_key, type, false);
+        break;
+    case SCSI_PR_OUT_PREEMPT_AND_ABORT:
+        rc = scsi_disk_emulate_pr_preempt(r, old_key, new_key, type, true);
+        break;
+    default:
+        return -ENOTSUP;
+    }
+
+    return rc;
+}
+
 static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
                                        uint8_t *inbuf, int inlen)
 {
@@ -1957,6 +2248,9 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
         scsi_req_complete(&r->req, GOOD);
         break;
 
+    case PERSISTENT_RESERVE_OUT:
+        scsi_disk_emulate_pr_out(r, r->iov.iov_base);
+        break;
     default:
         abort();
     }
@@ -2213,6 +2507,12 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
     case FORMAT_UNIT:
         trace_scsi_disk_emulate_command_FORMAT_UNIT(r->req.cmd.xfer);
         break;
+    case PERSISTENT_RESERVE_OUT:
+        break;
+    case PERSISTENT_RESERVE_IN:
+        scsi_req_ref(&r->req);
+        scsi_disk_emulate_pr_in(req);
+        return 0;
     default:
         trace_scsi_disk_emulate_command_UNKNOWN(buf[0],
                                                 scsi_command_name(buf[0]));
@@ -2632,6 +2932,8 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
     [VERIFY_12]                       = &scsi_disk_emulate_reqops,
     [VERIFY_16]                       = &scsi_disk_emulate_reqops,
     [FORMAT_UNIT]                     = &scsi_disk_emulate_reqops,
+    [PERSISTENT_RESERVE_IN]           = &scsi_disk_emulate_reqops,
+    [PERSISTENT_RESERVE_OUT]          = &scsi_disk_emulate_reqops,
 
     [READ_6]                          = &scsi_disk_dma_reqops,
     [READ_10]                         = &scsi_disk_dma_reqops,
-- 
2.20.1


