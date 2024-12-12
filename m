Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F3AE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGo-0004FU-Qr; Thu, 12 Dec 2024 04:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGm-0004EM-Eb
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:04 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGk-00006j-KE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:14:03 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21145812538so3715315ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994841; x=1734599641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=md9GySIJ3TCHpzC0bgJMV4Q1M309e6Yb0FYtaFc/bk4=;
 b=TgqO2/fxEyqhmeEONUEchntgH78wA4jutKZyyZQI17GEOP79vLgRI1YFmuenygqSo5
 ACVBxkeryyfpj2btMZdXGaMfEMovHoLt9NEwaf2l2pSamhwXWFcsyrb7Q/2+BHGLn+GV
 V/NiniaSy/bMwG/Ty5nVT4W/op853zgsR0xxu2Yy+u4z/BKoYPEDs+hgVekOWwCm+vU0
 cwcB7rLQnqpenn3B1NxbZuz/9ht9M66Y1t/CY4QgGpnxi24F6rGOIWvCM3LmerQmMJI1
 c7GLzAUjojgsOlqW1BQ/IGEz9RFOIJ6cyJhdnm+EqzCHo6LKRsXZYGiMP7SCvlJ9F5Su
 xECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994841; x=1734599641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=md9GySIJ3TCHpzC0bgJMV4Q1M309e6Yb0FYtaFc/bk4=;
 b=lrf5kD4mTqZ3Cg4SbFqbevjk6WrkKFgX0KsJRLplkyrKtpKhEr9PfUw7097xpwDcYb
 TWOkf/9GVIK8E7aaoIM0Pgn2Y2PeiqwkeGLuCyNJOlLoitn0IDxKigyLapenpLzqoERr
 +Ez2KMATDjCyfaju07m/ALcx5RbrXvemAZT/L0mS2W3iusl6SIaYSOPQ3vxwdvXXtTX4
 Wd1n68E7x5FdhHLaKipuXv1nV2Ulo3m9/ZI2EFT+7uSmyizMs04ZbHFimQBvvWb6cH6G
 T5+RSA0nvXsoBvrBisPGVUrAYbqEZrgKBpNPaqpdxSUDPzpW7M7yONxb/zsLf93/B93I
 x6BQ==
X-Gm-Message-State: AOJu0YyODfzY610wffTTau2pWeDAso1Bz1lJFrypAq2Xn4gaVPocrxfV
 0mp/iFqIL1Yx38YgHm+j/5yu+0G0HJBli0KThLww00ytuCcN1E61P5L+NQ==
X-Gm-Gg: ASbGncs3V1bKfHyZUSWIZzmej95mu2WfPmN2AFOH0UR0BdzCTt7eLl8xG4sMSeFdxfj
 6vcdmoAaiaiNWq4Lv+pQJCO5iJi874AjFwtMuRz3y2zcyFGmBRG6UpkvB9pwwtcKSUzJYD5YMeU
 oyvRyEdWB909gxYpMds5IrV1W2zQeARMUtnyGzEcGUSN02u0E2QXWJ/gNBDzFoJsTAg004lcPOU
 VfTnGmGKS0qbI36Cx3pIDFXkxN+1VKk97Z2LFYW4QKjewqUKumUjPu9LTY=
X-Google-Smtp-Source: AGHT+IF+Oro7OkMLzh8csvIDMa/cw+yX5StFgD3DXFfEqsD7ncFzNCvbPmAT4HatWKaB3OO32nXjsw==
X-Received: by 2002:a17:90b:1b0f:b0:2ee:d433:7c54 with SMTP id
 98e67ed59e1d1-2f1392b94e8mr4675722a91.19.1733994840654; 
 Thu, 12 Dec 2024 01:14:00 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:14:00 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 08/11] usb/msd: Add some additional assertions
Date: Thu, 12 Dec 2024 19:13:19 +1000
Message-ID: <20241212091323.1442995-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

Add more assertions to help verify internal logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 4e23537cd75..c04cee0041b 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -264,13 +264,24 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
     USBPacket *p = s->data_packet;
 
-    if ((s->mode == USB_MSDM_DATAOUT) != (req->cmd.mode == SCSI_XFER_TO_DEV)) {
-        usb_msd_fatal_error(s);
-        return;
+    if (s->mode == USB_MSDM_DATAIN) {
+        if (req->cmd.mode == SCSI_XFER_TO_DEV) {
+            usb_msd_fatal_error(s);
+            return;
+        }
+    } else if (s->mode == USB_MSDM_DATAOUT) {
+        if (req->cmd.mode != SCSI_XFER_TO_DEV) {
+            usb_msd_fatal_error(s);
+            return;
+        }
+    } else {
+        g_assert_not_reached();
     }
 
+    assert(s->scsi_len == 0);
     s->scsi_len = len;
     s->scsi_off = 0;
+
     if (p) {
         usb_msd_copy_data(s, p);
         p = s->data_packet;
@@ -288,6 +299,10 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
 
     trace_usb_msd_cmd_complete(req->status, req->tag);
 
+    g_assert(s->req);
+    /* The CBW is what starts the SCSI request */
+    g_assert(s->mode != USB_MSDM_CBW);
+
     s->csw.sig = cpu_to_le32(0x53425355);
     s->csw.tag = cpu_to_le32(req->tag);
     s->csw.residue = cpu_to_le32(s->data_len);
@@ -486,7 +501,7 @@ static void usb_msd_handle_data_out(USBDevice *dev, USBPacket *p)
         trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
                                  cbw.cmd_len, s->data_len);
         assert(le32_to_cpu(s->csw.residue) == 0);
-        s->scsi_len = 0;
+        assert(s->scsi_len == 0);
         s->req = scsi_req_new(scsi_dev, tag, cbw.lun,
                               cbw.cmd, cbw.cmd_len, NULL);
         if (s->commandlog) {
-- 
2.45.2


