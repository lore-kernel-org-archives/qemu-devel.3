Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5FF103E2E6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RRn-0003Qd-BQ; Wed, 11 Mar 2026 17:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w0RRj-0003Pj-3C
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:50:27 -0400
Received: from v54.v54282eed.euw1.send.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1w0RRe-0000ph-1v
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:50:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1773265817; x=1773273017; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=tLxTnFch0+ZJyNAOgL1txoZGyR6iHRLoEY65GqdNH+k=;
 b=iyITh2vlGTRlzg+lSj0IAgIfuON+22smsXw7r1VtgyzXdjWE2MlTMCT4tTlL4BgpGH5IsymzCi1h8yglF/qC4IPonQLCEA1t7+tHh3YDMgjvWZouD5Nd1bAL+Aeig/hx00+h5NGgS1/OfHgDwyaUrpfAhrGCl9MYDNp0YVTEtQph2DiHvLGOienG8kdAs16/jShGwEvhb4Nzk5+a9/upd2yoii5AFPoTyolyVHQpiVDkIBgYQLizZrtE4hZHd4i129kJy54ZiMsWYLEM6wPmwBY06VL3vU8Hoh9bY5o4+IFcIxmOEgT5wyv9qBPe+WuMGBTbxT1EBEK6/ZIIfnOYuA==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub158181109038.dh-hfc.datazug.ch [158.181.109.38]) by
 712eb054bc9015b0ebda65af28a98072b50f328f288845fcd2556865c8031c9b
 with SMTP id 69b1e399ad2ee9373893772f; Wed, 11 Mar 2026 21:50:17 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, pbonzini@redhat.com,
 Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH v2 2/2] hw/qdev: Remove qdev_get_human_name()
Date: Wed, 11 Mar 2026 22:50:03 +0100
Message-ID: <20260311215003.664815-3-alessandro@0x65c.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311215003.664815-1-alessandro@0x65c.net>
References: <20260311215003.664815-1-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=v54.v54282eed.euw1.send.eu.mailgun.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Remove qdev_get_human_name() and switch its two callers in
hw/block/block.c to qdev_get_printable_name().

qdev_get_printable_name() subsumes qdev_get_human_name(): both
return the device ID when set and fall back to the canonical QOM
path, but qdev_get_printable_name() also tries the bus-specific
device path first, providing more informative output.

Narrow the scope of dev_id in blk_check_size_and_read_all() to the
blocks where it is actually used.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/block/block.c       |  5 ++---
 hw/core/qdev.c         |  8 --------
 include/hw/core/qdev.h | 14 --------------
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index f187fa025d..84e5298e2f 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -65,7 +65,6 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
 {
     int64_t blk_len;
     int ret;
-    g_autofree char *dev_id = NULL;
 
     if (cpr_is_incoming()) {
         return true;
@@ -78,7 +77,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
         return false;
     }
     if (blk_len != size) {
-        dev_id = qdev_get_human_name(dev);
+        g_autofree const char *dev_id = qdev_get_printable_name(dev);
         error_setg(errp, "%s device '%s' requires %" HWADDR_PRIu
                    " bytes, %s block backend provides %" PRIu64 " bytes",
                    object_get_typename(OBJECT(dev)), dev_id, size,
@@ -95,7 +94,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
     assert(size <= BDRV_REQUEST_MAX_BYTES);
     ret = blk_pread_nonzeroes(blk, size, buf);
     if (ret < 0) {
-        dev_id = qdev_get_human_name(dev);
+        g_autofree const char *dev_id = qdev_get_printable_name(dev);
         error_setg_errno(errp, -ret, "can't read %s block backend"
                          " for %s device '%s'",
                          blk_name(blk), object_get_typename(OBJECT(dev)),
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f9fb7966dd..f464f63521 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -862,14 +862,6 @@ Object *machine_get_container(const char *name)
     return container;
 }
 
-char *qdev_get_human_name(DeviceState *dev)
-{
-    g_assert(dev != NULL);
-
-    return dev->id ?
-           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
-}
-
 static MachineInitPhase machine_phase;
 
 bool phase_check(MachineInitPhase phase)
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 2da7327144..cc847c20c1 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -1045,20 +1045,6 @@ void qdev_create_fake_machine(void);
  */
 Object *machine_get_container(const char *name);
 
-/**
- * qdev_get_human_name() - Return a human-readable name for a device
- * @dev: The device. Must be a valid and non-NULL pointer.
- *
- * .. note::
- *    This function is intended for user friendly error messages.
- *
- * Returns: A newly allocated string containing the device id if not null,
- * else the object canonical path.
- *
- * Use g_free() to free it.
- */
-char *qdev_get_human_name(DeviceState *dev);
-
 /* FIXME: make this a link<> */
 bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
-- 
2.53.0


