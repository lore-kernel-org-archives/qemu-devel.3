Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49A9C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribe5-0003KR-Sr; Fri, 08 Mar 2024 09:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdy-0003CB-2Q
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ribdt-0005Qr-SH
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709909769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ff3Hzr/qQnFeHJ3R0iUom7wtGXBzK9NGYQzCU5YsyUA=;
 b=Vx1l8At7Bnm/pUtd9GEmfAWqNwrqkImn8PIYsda9xBzHkSNb/wbedkoGb4HyZ8M19rWm6W
 27/QmenWyY3Ff5NTVWhiMjJFmUGXBrVb0W3wauwj458vuCgVRQ2oyxfLpIdfpFRNXCJrpd
 cegg7ihNcFdQNIcoC/PVpEZPVAyJP6w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-rmIytNJJPfSZzVxjL9hpVA-1; Fri, 08 Mar 2024 09:56:07 -0500
X-MC-Unique: rmIytNJJPfSZzVxjL9hpVA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-55d71ec6ef3so1769475a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909764; x=1710514564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ff3Hzr/qQnFeHJ3R0iUom7wtGXBzK9NGYQzCU5YsyUA=;
 b=gIgMDirZMILcXwgOIILn98FBBpkqj9r474Cxl4WuHaB1e7QVrq4v5WLXZFC5jSiVnA
 h6m1VHPdNs8LtdNFCwsYXjg4bRx1W2m0Ui2DX3uBlAOkI/KE7lZLCG2nnlCb+4yGLVmK
 xANieietacXpVXD9XyXXWenhE/rdDm4Qs20TZPIqDRqnbazN+sYV83IHQi4Xo6OGMmhs
 4yF3kdhbcBgBipE/thdOPBP/NGhG3/PAZX/VU7+AjVRxBQ0u7vlXj+/w1f94yJ8W4zYL
 k/B1MOBUJSgdM4GbEBz4Z2KvIVLGrv6k2Eoy27zFxMVPoxr6HF6Wxvtunku7R+E9wWOD
 r2nA==
X-Gm-Message-State: AOJu0YyNz61dj2USkI6pKDr8fFNjRr/AlsbIJ6iDU2pMq7W8LnovTQ67
 pCLG8I3/qkBzhS0ZWkuuOSIIsyFJl8MoXI9X4ApjEQRaDHWCzyJUWv2Ux8qj27q/VmVxQvT6BOf
 gSjt8llClQFWhOzFf1tQxnBhzskfKoL/ut4O16WkZjPdqW/muWEKP/9vW2HCFY49NjG2AIGZ3JZ
 tjSTJXgm4xIP3le4vX9n2igMFrKrwo8+WjVzTn
X-Received: by 2002:a50:d742:0:b0:565:7116:11d with SMTP id
 i2-20020a50d742000000b005657116011dmr2073979edj.27.1709909764568; 
 Fri, 08 Mar 2024 06:56:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAVEyWkNZrfv1hjc4G/FEDROC7KHvXhyltvhRthoGrmcKvSAbCFBiav/Un9dP/psSFQWc2EQ==
X-Received: by 2002:a50:d742:0:b0:565:7116:11d with SMTP id
 i2-20020a50d742000000b005657116011dmr2073971edj.27.1709909764279; 
 Fri, 08 Mar 2024 06:56:04 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a05640214c400b005660742bf6bsm9221092edx.52.2024.03.08.06.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:56:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 04/12] hw/scsi/lsi53c895a: stop script on phase mismatch
Date: Fri,  8 Mar 2024 15:55:46 +0100
Message-ID: <20240308145554.599614-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308145554.599614-1-pbonzini@redhat.com>
References: <20240308145554.599614-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


