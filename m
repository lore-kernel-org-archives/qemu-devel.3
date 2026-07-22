Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE014C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVPA-0004VM-6C; Wed, 22 Jul 2026 07:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLN0-00009C-NZ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:34 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLMy-0002gA-96
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:34 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so434154166b.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 18:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784682211; x=1785287011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k4yK7lDliBq/8FU36kdREjJRsf5raunpvsSFKyNur14=;
 b=Yr66Nc4+wi4NDDYmkdcgn559/eD92A8LiDfx4fuBU31QzbyJDoLAaQnXPzMH4uTcz5
 xZsXyRigAvTWaxEc3ru6mHcUo+aVwTAFTc252sMwrwKky0lc/nLPdNoux7RaPIZmv5Tn
 lDkZVEOpazUFF4A6S4POKJcxHCP0V4f34ukWsqzYfYyK0MksNcdq04YJamdN9s42AfDC
 XXfnkbHzxUMMo21uLJdBljHzzTlFK2IWK1O2N1kWyouck8dfK3N5az/kZD2GxjI2JtML
 UhY/GuRw2WwGpP4TibQfeVfPI+QmaV/IjGYaVSQO0d2ERt0o5rczog/VQ7VgRFSz8QWo
 /HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784682211; x=1785287011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k4yK7lDliBq/8FU36kdREjJRsf5raunpvsSFKyNur14=;
 b=KXnushHE0x5Dks0Gf+WLaCfhTFQvQ9uZ4GSGzTWs7fj55wPL9g4HHJStRMONMGnW1K
 v5rEWFW8QIlEk9soP9LtUQGX14lz0+LebIm7c0L8hWhw+mZKeLZ82NxsT6big7ALRaVS
 y7DfF5JITO6XfAgG6kZFVx/MrLg9vQVj/pDWaeQEA0LUdtmpyPCvJ5Nky3KEx8ZxtQvC
 2LmNl+LNVY6DsQ0ad1/jG9h/CcINnZV9dlmKSFxXFcBD8LHLjkNld/D6y2+NOrDc3HrL
 RgxZBXa4DuFfGU9DeuRX7SLSv3HqUGjx3mb3wvzbqKF5GsicwCpHmQXQuoZ7IRGzSURr
 +wkA==
X-Gm-Message-State: AOJu0YxPyYFZQCzuVJHeIhAlTtiNO1XbuJ1sCQqx/tW1SvEPRd4FXPUJ
 8XuVlhJkmROVV2jcmk8dzk4NGGpWJAjUh6I6zQEaq0SyMiOFLQDju1s7jnfWv+yoZdc=
X-Gm-Gg: AR+sD13R3Yzd3Te/XJqXy09ae4Kcz4sRmdYvoLpe+p3KUeAKn+TcaUi/JS8yoEM6jMm
 YQ+2mnI8+MBRK0gJVrIHCxkh5eOTinHjupT7KHPc+/pY8T3kFe58RfDqq4ICzlfR+toCn89iWD+
 lzHkT+CPXStUvamfjXWU50RbRGNq03Sk4fVf6nMTDy+gOjK62DiEeA06wNvNfoxsTVP1VhYeoco
 hcE3NrAIxh4C98DKOHy2o2Q0hqoPwUsXZymhUNcBegn4gxDsiMHEpD23fJ4fhIR+53HX1NSrUyW
 o0AE253BI/W3WOxv8jWPga9oUhdrCO8G+4R5+1pB7/waljBbQs/XjupAiJx34P5LZBtzATZgjxY
 S5hCe+ufgo7p5rJCOGgmeQypEztxiUSyDoE9ARS7+NCBb/W0WcxBTywPfW+TRjbwfaA==
X-Received: by 2002:a17:907:1ca4:b0:c16:19fc:9976 with SMTP id
 a640c23a62f3a-c16b48ed368mr834040966b.53.1784682210508; 
 Tue, 21 Jul 2026 18:03:30 -0700 (PDT)
Received: from Arc ([109.245.172.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ebac95sm32694066b.47.2026.07.21.18.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:03:30 -0700 (PDT)
From: Konstantin Nigmatullin <rangolit@gmail.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Nigmatullin <rangolit@gmail.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/5] iscsi: detect dead iSCSI sessions via local NOP failure
 counting
Date: Wed, 22 Jul 2026 03:02:50 +0200
Message-ID: <20260722010254.424820-2-rangolit@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722010254.424820-1-rangolit@gmail.com>
References: <20260722010254.424820-1-rangolit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=rangolit@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Jul 2026 07:46:12 -0400
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

libiscsi nops_in_flight stayed at 0 on a dead TCP session, so QEMU never
noticed the target had vanished when command timeout was disabled.

See: https://gitlab.com/qemu-project/qemu/-/work_items/3067
Signed-off-by: Konstantin Nigmatullin <rangolit@gmail.com>
---
 block/iscsi.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 7d6bf185ea..bf74b4cb65 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -103,6 +103,8 @@ typedef struct IscsiLun {
     bool dpofua;
     bool has_write_same;
     bool request_timed_out;
+    /* Consecutive NOP-Outs without a successful NOP-In reply. */
+    int nop_failures;
 } IscsiLun;
 
 typedef struct IscsiTask {
@@ -1398,17 +1400,37 @@ static char *get_initiator_name(QemuOpts *opts)
     return iscsi_name;
 }
 
+static void iscsi_nop_cb(struct iscsi_context *iscsi, int status,
+                         void *command_data, void *opaque)
+{
+    IscsiLun *iscsilun = opaque;
+
+    if (status == SCSI_STATUS_GOOD) {
+        iscsilun->nop_failures = 0;
+    }
+}
+
 static void iscsi_nop_timed_event(void *opaque)
 {
     IscsiLun *iscsilun = opaque;
 
     QEMU_LOCK_GUARD(&iscsilun->mutex);
-    if (iscsi_get_nops_in_flight(iscsilun->iscsi) >= MAX_NOP_FAILURES) {
+    /*
+     * Prefer libiscsi's counter when it works; also track locally because
+     * some libiscsi builds leave nops_in_flight at 0 across a dead TCP
+     * session, which disabled disconnect detection entirely.
+     */
+    if (iscsilun->nop_failures >= MAX_NOP_FAILURES ||
+        iscsi_get_nops_in_flight(iscsilun->iscsi) >= MAX_NOP_FAILURES) {
         error_report("iSCSI: NOP timeout. Reconnecting...");
         iscsilun->request_timed_out = true;
-    } else if (iscsi_nop_out_async(iscsilun->iscsi, NULL, NULL, 0, NULL) != 0) {
+        iscsilun->nop_failures = 0;
+    } else if (iscsi_nop_out_async(iscsilun->iscsi, iscsi_nop_cb, NULL, 0,
+                                   iscsilun) != 0) {
         error_report("iSCSI: failed to sent NOP-Out. Disabling NOP messages.");
         return;
+    } else {
+        iscsilun->nop_failures++;
     }
 
     timer_mod(iscsilun->nop_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + NOP_INTERVAL);
-- 
2.53.0


