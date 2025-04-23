Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5A9C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wbu-0004hZ-DZ; Wed, 23 Apr 2025 05:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbW-00047X-5W
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WbU-0008Jk-0w
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KUXfxem6hXz9wBC7InW3PIEnFU5WiG11keAeu8ffU8=;
 b=LHdP/QV4Kox138XdeQj0W0qabYHvchaJPduGv/quuxJCm2zkky9+rlhNUMdD++3dtq1Dxn
 PIM2D6kDicNPmqFyMhh6fYckrzW7QngFe6CJ0Sz31GaMn9+g/Fz5Jk7QhCkW2S5gWSsSB2
 pusE/HemXlvFjoV0uOUcSFR6eoQrgjI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-UDXO1TD4MvaumuJX3GH_aQ-1; Wed, 23 Apr 2025 05:41:12 -0400
X-MC-Unique: UDXO1TD4MvaumuJX3GH_aQ-1
X-Mimecast-MFC-AGG-ID: UDXO1TD4MvaumuJX3GH_aQ_1745401271
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5f4d2b91f1eso6279118a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401271; x=1746006071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KUXfxem6hXz9wBC7InW3PIEnFU5WiG11keAeu8ffU8=;
 b=bEdUS4Ta4fdikvKBtkRIwuM2McMxWWZRBVwhFOqHLnt0IMbL6KEyElFFZVJuh/0MTV
 8z9mnObvkV7SN0OKAWo7cNIvwJp+mEl6PikmEU0VT6qdJQt7LAtcnKXngZTWVmuHllyE
 vCufs+oyl8yRCTXnAXqnHCunz+e4uBQbZvpBKNy23GVb3ogISIo/xO6b0u9SNrroUmcd
 59p9kTmrFhXKCTa5mpuwIP38mnU+X4zp7BXAhz8x/6Cs44M+MxNxtwvxM/wwa9vPwYyU
 dPy1I6xZoyMC1trhbrII44YIXi9qAZFgi+IcE+7bPNriGW95PdO2jtZpu2DYK3o6zfs2
 LWhA==
X-Gm-Message-State: AOJu0YwH0B/Bo+CEnqxWrn2an0wnFNKDyPxWti1VeFCmSvueSL4qZm87
 vE+pctZFKhY5/Gaw8gVtC7dU4QNS+EidGktV73D17hajotHC401ltufnyYM9/FAPFG8j1oyFF8k
 0iQnYw7JaIh71eHcLEsBaFrC7uH5K2A8doJLNczcGdEwgbY2Eq/NMfj9APeIoB5XRgdA3w/i8oo
 HYoTy9qu7Dxgn2Ztipkr0DS62iWDyeXtMNrzwC
X-Gm-Gg: ASbGncuAY1SfAr0iEdAJDgZoSs4moyyV0BWZSh02FN2vvEJvmaC7dDsnW3bE/Vl0C96
 kjEGS20XmVI4pQBDZ1O6L5ogQDIJwJpTV9B/n1PkefRhZnMiwjxDx2M69ooZorACf3Fo1ZvY1XM
 icybqHKbzCP5MYiNyA6620fCjpr/v7ef/OJGWZFHjls+FgvzIgYcfjjdGfxnJdcT+HvYmQlqSgC
 9YjsMNYkGgmKX1KW37RkmQT5A9GqwmrStJ4N3fPdCFIrMKUfl2o6lk7pz2z7wkmXl28u8KpcaTV
 S3rN+tVFjE3aq1no
X-Received: by 2002:a05:6402:524b:b0:5e6:13bf:2c7c with SMTP id
 4fb4d7f45d1cf-5f628524b53mr14875905a12.9.1745401270974; 
 Wed, 23 Apr 2025 02:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnWnqWjKL4pAElTiX2uf0opZRUGtI5NNPTXCb9cECCgpeug3R5Js7gSjj5R2rgiXVO7JEXmg==
X-Received: by 2002:a05:6402:524b:b0:5e6:13bf:2c7c with SMTP id
 4fb4d7f45d1cf-5f628524b53mr14875888a12.9.1745401270559; 
 Wed, 23 Apr 2025 02:41:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62557a151sm7223601a12.32.2025.04.23.02.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: [PULL 02/34] target/i386: Fix model number of Zhaoxin YongFeng vCPU
 template
Date: Wed, 23 Apr 2025 11:40:32 +0200
Message-ID: <20250423094105.40692-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Ewan Hai <ewanhai-oc@zhaoxin.com>

The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
The correct value is 0x5b. This mistake occurred because the extended
model bits in cpuid[eax=0x1].eax were overlooked, and only the base
model was used.

Using the wrong model number can affect guest behavior. One known issue
is that vPMU (which relies on the model number) may fail to operate
correctly.

This patch corrects the model field by introducing a new vCPU version.

Fixes: ff04bc1ac4 ("target/i386: Introduce Zhaoxin Yongfeng CPU model")
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
Link: https://lore.kernel.org/r/20250414075342.411626-1-ewanhai-oc@zhaoxin.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba4..3fb1ec62da1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5621,6 +5621,18 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Zhaoxin YongFeng Processor",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .note = "with the correct model number",
+                .props = (PropValue[]) {
+                    { "model", "0x5b" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
 };
 
-- 
2.49.0


