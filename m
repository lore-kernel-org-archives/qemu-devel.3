Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE85C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 18:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riehm-00079z-0P; Fri, 08 Mar 2024 13:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehj-000780-UL
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1riehh-0005o0-G8
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 13:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709921539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ff3Hzr/qQnFeHJ3R0iUom7wtGXBzK9NGYQzCU5YsyUA=;
 b=IuqpmqQhWftqmnZDu6ftGxdifvL87JTbFywVOaSolwdbpJxSeEimQnSJwp/OyuefJAgg9z
 aNTgrnSXigSJ3xaB9BnasDdndFi5hupmtRW19/wHg6FNGH/1tESUvz2DBMPs8q/M3IT9h3
 L6kAThQbz2xXbFgKTtGvm7zhBgQxqeo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-JNZ7ypJBPZK1txaij32Wug-1; Fri, 08 Mar 2024 13:12:18 -0500
X-MC-Unique: JNZ7ypJBPZK1txaij32Wug-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5670ee87ca4so1108720a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 10:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709921535; x=1710526335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ff3Hzr/qQnFeHJ3R0iUom7wtGXBzK9NGYQzCU5YsyUA=;
 b=Bsb6T45IuTxHpNI0cFivXsjCG6ZlVuCwfOyLKToxNHMSpJhA9HGGbd+qz/JkccQCMt
 JXzWFsHwcgWFY9r44x9I6eQJB8nxcfhWOJLJnvVhzqCVwUd2z8TmckKWTwpSTE7p5z7R
 ZyCvXc8raw9aUUmcNxxXXc0AACIVLWk6DG6TWgIxjtMrZefStZ+VE7u6jNeVcJbEWFGb
 EHKbPUcHz59mcE/3Tvr9tmlYeEPXXn3x0U3G4TNLs8Lm8tcMYVWrcJOSOqeoU16iN+T6
 Dqihv8qv/+3kkzdHTE+mIi15hQYfKc5hFvhPJMHoI7Myl7wPJJAAWGCKaFxhs2MIaqS/
 fIgA==
X-Gm-Message-State: AOJu0Yy3D4mXKn+h6dpY8hfc5ghgof+SECWFZL+qjRR5WGOHsURIqFbC
 ZCo074NBTy7lMFgePJAeqhZ7UUPnTtVISpBYPpfKm+Tf7Aez+aR98H5ckft7QbgvgppNictTTey
 r7sHQRrl3B0gYdER7IDghiNMWFiFF9ePHC3fqGqjSqKdxIAFUMYStH5RLlkx35JG6ED+E1dNH1o
 BLSpIPkDWRGuboNSUxwFEIWDCXaZutiWaX9rC3
X-Received: by 2002:a50:9faa:0:b0:565:59a:a103 with SMTP id
 c39-20020a509faa000000b00565059aa103mr29893edf.33.1709921535244; 
 Fri, 08 Mar 2024 10:12:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPnsqjXmf/kRkEMik4h43dtMchE9C+ZRTsPbTw4NMAyyI5/k3Ji+e91QH6IqGuhsqS1o5hsw==
X-Received: by 2002:a50:9faa:0:b0:565:59a:a103 with SMTP id
 c39-20020a509faa000000b00565059aa103mr29876edf.33.1709921534821; 
 Fri, 08 Mar 2024 10:12:14 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 x14-20020aa7dace000000b005671100145dsm22397eds.55.2024.03.08.10.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 10:12:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 4/9] hw/scsi/lsi53c895a: stop script on phase mismatch
Date: Fri,  8 Mar 2024 19:11:56 +0100
Message-ID: <20240308181202.617329-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308181202.617329-1-pbonzini@redhat.com>
References: <20240308181202.617329-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sven Schnelle <svens@stackframe.org>

Netbsd isn't happy with qemu lsi53c895a emulation:

cd0(esiop0:0:2:0): command with tag id 0 reset
esiop0: autoconfiguration error: phase mismatch without command
esiop0: autoconfiguration error: unhandled scsi interrupt, sist=0x80 sstat1=0x0 DSA=0x23a64b1 DSP=0x50

This is because lsi_bad_phase() triggers a phase mismatch, which
stops SCRIPT processing. However, after returning to
lsi_command_complete(), SCRIPT is restarted with lsi_resume_script().
Fix this by adding a return value to lsi_bad_phase(), and only resume
script processing when lsi_bad_phase() didn't trigger a host interrupt.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Tested-by: Helge Deller <deller@gmx.de>
Message-ID: <20240302214453.2071388-1-svens@stackframe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 4ff94703816..59b88aff3fb 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -573,8 +573,9 @@ static inline void lsi_set_phase(LSIState *s, int phase)
     s->sstat1 = (s->sstat1 & ~PHASE_MASK) | phase;
 }
 
-static void lsi_bad_phase(LSIState *s, int out, int new_phase)
+static int lsi_bad_phase(LSIState *s, int out, int new_phase)
 {
+    int ret = 0;
     /* Trigger a phase mismatch.  */
     if (s->ccntl0 & LSI_CCNTL0_ENPMJ) {
         if ((s->ccntl0 & LSI_CCNTL0_PMJCTL)) {
@@ -587,8 +588,10 @@ static void lsi_bad_phase(LSIState *s, int out, int new_phase)
         trace_lsi_bad_phase_interrupt();
         lsi_script_scsi_interrupt(s, LSI_SIST0_MA, 0);
         lsi_stop_script(s);
+        ret = 1;
     }
     lsi_set_phase(s, new_phase);
+    return ret;
 }
 
 
@@ -792,7 +795,7 @@ static int lsi_queue_req(LSIState *s, SCSIRequest *req, uint32_t len)
 static void lsi_command_complete(SCSIRequest *req, size_t resid)
 {
     LSIState *s = LSI53C895A(req->bus->qbus.parent);
-    int out;
+    int out, stop = 0;
 
     out = (s->sstat1 & PHASE_MASK) == PHASE_DO;
     trace_lsi_command_complete(req->status);
@@ -800,7 +803,10 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
     s->command_complete = 2;
     if (s->waiting && s->dbc != 0) {
         /* Raise phase mismatch for short transfers.  */
-        lsi_bad_phase(s, out, PHASE_ST);
+        stop = lsi_bad_phase(s, out, PHASE_ST);
+        if (stop) {
+            s->waiting = 0;
+        }
     } else {
         lsi_set_phase(s, PHASE_ST);
     }
@@ -810,7 +816,9 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
         lsi_request_free(s, s->current);
         scsi_req_unref(req);
     }
-    lsi_resume_script(s);
+    if (!stop) {
+        lsi_resume_script(s);
+    }
 }
 
  /* Callback to indicate that the SCSI layer has completed a transfer.  */
-- 
2.43.2


