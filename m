Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2461AC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVOx-0004F3-6H; Wed, 22 Jul 2026 07:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLN9-0000AR-3s
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:44 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLN3-0002gj-3m
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:42 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69e8ea2783aso5412719a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 18:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784682216; x=1785287016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zdT93fDs6UB1uSpu3Au/OcyMYvv7vHTYp3jSGdCEpFU=;
 b=IFPH2cHdodoLTJSG2GP4eNzlAbO2PV54bX1GhQ85KzIQmGBqGprd1x1GPZz1vFA2VX
 XE3jh6sfg5phRkJVrrO7JmJGinjBOuOI/lpw7shiGptM6fs/wEe8lTZHp+lGHTee6Bxy
 8bsT+HsTk+x9idBZvMYm66RBg4iP6lHMBUPMjlpxRuWeG8enM+ef7ak21tkvjIdM3fL+
 vah0D0ZMwTDclJJLTK193rk2BmuF30oMs7FTVetf+Mc8GMv9KHxePzJGIGgvtU/7okMt
 LbJYhLcoaPX8By57fbyfx9Kj3wwYnCuTJXGMA5Yji3JM0JvjMQSljJwGZwllwawm6joX
 hpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784682216; x=1785287016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zdT93fDs6UB1uSpu3Au/OcyMYvv7vHTYp3jSGdCEpFU=;
 b=cjE8OhtapjZhYkSEds84IkqNN0kkMbGwazAb77L/AzdPPCUQkfJf2lN/2pXuyHhlDX
 8mCxYJin0/5pKK6Q990UaGCOtyGr+X92V7ASgdgotYJK5IOhuri8dY47GspO2c+Iu3kq
 KdWmFYL1DF0SXdxwOL7O+/J0LH6YIQlpSKFZoRSpYeVBrTdYHBfgMqQ2jDaKLKW+rjR3
 2o16RP6O9sVysvqixWX+c7SLTkg4cZBi4+g/fcEuQI9pytc19IJmVEKaEMQXhtSR98OM
 FaleJDJbf/aQaRqMg8NKaExky/e0Sq/k08EZN2bGCpUaQhhJviZVByinBWt7b0xAAPNa
 o+qQ==
X-Gm-Message-State: AOJu0YzCpOah3rmfWdRPXJ/KOjK+Z5HkaHzfa9D1nvPlhzwpkuW7f98S
 fPyyldCqNKXaj0I4VM4RhDl4hBYljauyKdmDDXKRLTFy3LAQW/GXc2qzhnB2jjCZ1zs=
X-Gm-Gg: AR+sD100b8aFIBikhbMgJG6wPls+3BN9rCw5mhY5RVPmlgAQrLaBq87xBpe23/eCjZX
 tLVyomkGTRDng8E7DEgy119jTAKA2dnNFY+ECP6xmEBgvUk1XFvRCw1EvLMJCiZ/KBhaLzxTj10
 8kUZFcKu3KrYa2Gg4srhhZcx5t7Q8Fo5cSAo+21Fs+lGJZ5m9hACirW9DjcXvoGJStzw4UOCk1s
 lYSID/B/QXgu7sZYQWgg9lYWdEDTTsXnTldLde+VF5Qv4iFc22ibFqzuIHb16bDiidYJ6gL30TJ
 0AYc4mSmcemfmsRlgBhhjJOOpaRQnmE8U7XueIVbKSOOQ/pxhCetr6Im5jyz9i8FaCp6N0Gx5RO
 c5MPhQViZA5F/N4MVXgO8Ibt5yuwLQ0g8fAnXQP8gjPUgtEOKC8GLdG9iABpfYk+a7jQqkIyTNf
 x4
X-Received: by 2002:a17:907:d22:b0:c1c:254c:16c1 with SMTP id
 a640c23a62f3a-c1c254c27bcmr158104566b.0.1784682215539; 
 Tue, 21 Jul 2026 18:03:35 -0700 (PDT)
Received: from Arc ([109.245.172.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ebac95sm32694066b.47.2026.07.21.18.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:03:35 -0700 (PDT)
From: Konstantin Nigmatullin <rangolit@gmail.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Nigmatullin <rangolit@gmail.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 2/5] iscsi: stop retrying timed-out iSCSI commands
Date: Wed, 22 Jul 2026 03:02:51 +0200
Message-ID: <20260722010254.424820-3-rangolit@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722010254.424820-1-rangolit@gmail.com>
References: <20260722010254.424820-1-rangolit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=rangolit@gmail.com; helo=mail-ed1-x536.google.com
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

Retrying SCSI_STATUS_TIMEOUT up to seven times kept drain and shutdown
blocked for minutes after the target was already gone.

See: https://gitlab.com/qemu-project/qemu/-/work_items/3067
Signed-off-by: Konstantin Nigmatullin <rangolit@gmail.com>
---
 block/iscsi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index bf74b4cb65..e7f2d54986 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -240,19 +240,21 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
 
     if (status != SCSI_STATUS_GOOD) {
         iTask->err_code = -EIO;
-        if (iTask->retries++ < ISCSI_CMD_RETRIES) {
+        if (status == SCSI_STATUS_TIMEOUT) {
+            /*
+             * Do not retry timed-out commands. Retries keep in-flight I/O
+             * alive across a dead session and can block blk_drain_all()
+             * (and thus QEMU exit) for minutes or indefinitely. Kick
+             * reconnect and fail this request.
+             */
+            error_report("iSCSI timed out: %s", iscsi_get_error(iscsi));
+            iscsilun->request_timed_out = true;
+        } else if (iTask->retries++ < ISCSI_CMD_RETRIES) {
             if (status == SCSI_STATUS_BUSY ||
-                status == SCSI_STATUS_TIMEOUT ||
                 status == SCSI_STATUS_TASK_SET_FULL) {
                 unsigned retry_time =
                     exp_random(iscsi_retry_times[iTask->retries - 1]);
-                if (status == SCSI_STATUS_TIMEOUT) {
-                    /* make sure the request is rescheduled AFTER the
-                     * reconnect is initiated */
-                    retry_time = EVENT_INTERVAL * 2;
-                    iTask->iscsilun->request_timed_out = true;
-                }
-                error_report("iSCSI Busy/TaskSetFull/TimeOut"
+                error_report("iSCSI Busy/TaskSetFull"
                              " (retry #%u in %u ms): %s",
                              iTask->retries, retry_time,
                              iscsi_get_error(iscsi));
-- 
2.53.0


