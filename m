Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BD7CD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 18:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqzkZ-0004BG-3d; Sun, 31 Mar 2024 14:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqzkT-0004Ar-Qi
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rqzkS-0004gF-Ab
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711909059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jLpAUqBQzceTRAYU+8U7+iDE5tmAFXUptroQALqFoI0=;
 b=E1Pl9azK3kWPzOfIpeev/WRhFzqnZX6bp/Wm2wiy+x3qZSwK+gdYlBLXgZT7iribkLmtR1
 LtDnls8ayfOL6hZU3g0YV8Nbh/tKta6iJygbxebkN85Rz0spvn///5zPUXAi15ejHgaHCQ
 qm6FWVTxmoXNQQ67NjwC1zwLNqIHjZQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-p1iv4RsWNBaazD2H_E8_bg-1; Sun, 31 Mar 2024 14:17:36 -0400
X-MC-Unique: p1iv4RsWNBaazD2H_E8_bg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a46cc88be5fso257075466b.2
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 11:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711909053; x=1712513853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jLpAUqBQzceTRAYU+8U7+iDE5tmAFXUptroQALqFoI0=;
 b=fqrqc6u8smMwXhfzZopEuOUmXC9MAA5WoxkD82am/Y6eMsG2I9WfM1LEL0h/KK3L9b
 xkQ7ZkfL2VX4xeGmzt3j3DogGt/ySogikTUqSBT18eDbjelPcbmcxyAG4f+nthq6jsSt
 kC9Jv2pc847SCO92roYW6p4Y/qvT9WsJ+WXjFDx+mZKMbrS1yhMcFVFjwMot9T/uWiMz
 IRTtOL/FX5dv56nHN7GfyMbZGl8T8LikA6nspAkS8+CUnil7I+IIObmy/cAFe9wntY0m
 sV/jYX/tYG99coVTn33YvU9VISsr1noeNtIMX3LpUN12ipM5W0lfnuYsmvZBDAqgHyPn
 XXRw==
X-Gm-Message-State: AOJu0YwEOvX4DC/4Xnm7XLRS6tycwzpJ7grXckmSm/aIVWq8M5aCJCp7
 OAH/Zu+dlkYx/4iRNz6OMA2g4RfVw+QY6IK/gk05mnwQpwSnwWGGvjplhfPoH1D3bm2UHD1dSKW
 xVUO9iUJp27IhUmDpsVIEw3fqw5RgqSPMxM+ElxSU8H/KOc3aFjZy949zt6lV7N2jbZLIjd3PnZ
 M/h0mTlEXZjQ5M5u8ixR3qjAOrdj3SMv5tv2Qg
X-Received: by 2002:a17:906:3644:b0:a4e:d5d:8fd6 with SMTP id
 r4-20020a170906364400b00a4e0d5d8fd6mr4472357ejb.60.1711909053454; 
 Sun, 31 Mar 2024 11:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSmdcmNZrnpAjHSPvT2GxerIusqPJdGGfeG6lBC0iONtOIm0wdvICKyfWkWayre/8CtDBMkA==
X-Received: by 2002:a17:906:3644:b0:a4e:d5d:8fd6 with SMTP id
 r4-20020a170906364400b00a4e0d5d8fd6mr4472348ejb.60.1711909053075; 
 Sun, 31 Mar 2024 11:17:33 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 he18-20020a1709073d9200b00a4729f093ecsm4378532ejc.53.2024.03.31.11.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 11:17:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] lsi53c895a: avoid out of bounds access to s->msg[]
Date: Sun, 31 Mar 2024 20:17:29 +0200
Message-ID: <20240331181730.150860-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If no bytes are there to process in the message in phase,
the input data latch (s->sidl) is set to s->msg[-1].  Just
do nothing since no DMA is performed.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 71f759a59dd..eb9828dd5ef 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -927,13 +927,18 @@ static void lsi_do_msgin(LSIState *s)
     assert(len > 0 && len <= LSI_MAX_MSGIN_LEN);
     if (len > s->dbc)
         len = s->dbc;
-    pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
-    /* Linux drivers rely on the last byte being in the SIDL.  */
-    s->sidl = s->msg[len - 1];
-    s->msg_len -= len;
-    if (s->msg_len) {
-        memmove(s->msg, s->msg + len, s->msg_len);
-    } else {
+
+    if (len) {
+        pci_dma_write(PCI_DEVICE(s), s->dnad, s->msg, len);
+        /* Linux drivers rely on the last byte being in the SIDL.  */
+        s->sidl = s->msg[len - 1];
+        s->msg_len -= len;
+        if (s->msg_len) {
+            memmove(s->msg, s->msg + len, s->msg_len);
+        }
+    }
+
+    if (!s->msg_len) {
         /* ??? Check if ATN (not yet implemented) is asserted and maybe
            switch to PHASE_MO.  */
         switch (s->msg_action) {
-- 
2.44.0


