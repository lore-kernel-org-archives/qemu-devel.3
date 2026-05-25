Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99781CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 11:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRTvk-00048o-7K; Mon, 25 May 2026 07:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wRTve-00048Z-UE
 for qemu-devel@nongnu.org; Mon, 25 May 2026 07:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wRTvd-0000oX-1Z
 for qemu-devel@nongnu.org; Mon, 25 May 2026 07:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779710223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nvl62spl8q880wZx2vHq0hZl5SLDVSI4sRYAUMB5wuM=;
 b=MmFJL9ReJMOLkFifqNbVzkkr7K/LlafP8rLtBx3QaEUZB1Lm13ivhmsAktKUACkbhcQX4A
 0VBlBsrhHGfJiaLO/F6I+FCax+StIIhHomFOauVKjvQAwU8W7m2wGFn2CpTPOy+Qpstt0S
 12s4uNun+LoMbxa9UmjUryZMNy5xFkc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-sbGhRy_DMIOj-RlKEJXE-Q-1; Mon, 25 May 2026 07:57:02 -0400
X-MC-Unique: sbGhRy_DMIOj-RlKEJXE-Q-1
X-Mimecast-MFC-AGG-ID: sbGhRy_DMIOj-RlKEJXE-Q_1779710221
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fd3dbd16aso76453285e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 04:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779710221; x=1780315021; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nvl62spl8q880wZx2vHq0hZl5SLDVSI4sRYAUMB5wuM=;
 b=odfXBy67XIatanXrqVEYKjHSNJy+9dHnYFQGq9BoIvZes15oqzCdLFju4bQx3PKYkB
 lMLFXJxGuAcH1PmYf4NNFGR6VMIpDZLrBKK1hJhMbu1pei93EOLwyAx1ZI3s2K+w3jti
 VmgideBGOYlAZ55Qt1OQRxnQOz8ulzwmnAplmQwB9IlR2WmsIjshW5XPs/dl0D99eaSS
 X4iGaDVf9X0abCBMLqID35BkAiZ8QZ6d3XZHv8uzjHrNagFQBaebE1yzSTb5j41TS1DH
 Qhl3WfI7Uj5VCO3E0XfyNDbJud8CgF8jRn9npKOlwBhVIbWz8SeNw5m4tcjFjJgVXxH8
 PfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779710221; x=1780315021;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nvl62spl8q880wZx2vHq0hZl5SLDVSI4sRYAUMB5wuM=;
 b=AZxoeb3APcSe+iULmeSAe/k0WupyDHifbjIuXsTwiBL94uMOOv9wYFctyxxTiTxjld
 imbwWbPETDVivnPmihA8RaHfi5uBRPtPiaxYJbehA3bhvIJXzu9sxR8r3GGeggd2YvUy
 oWDYcNAdw59Cver53iZvnPknFOTNObDofRk6q1ZGxuUQ088yzMVs2ZcHWKgXgOOEpUr3
 E/EchEGJ5PkH8sxTxopxpxdGrodyua392Imp6BS2IzGtfHOjju/j7DjKlalT9W/rkXUS
 Mj/2bi4SutcIE+G0Po4m9a9BtPx8OBut/Ff/lRQY0dv2oYiqlZiiTlhkkw0JkE2GLJWy
 PTLg==
X-Gm-Message-State: AOJu0YzvM/e1+lBJ9OkTT+ED8l0RHLt7g4jRu+3dm5pHsoSVsiZv6P+l
 leNYyWwM96e4d6Z7fBRGKz9bdtqE0o6ZwiUR8fPqdu6blmtb9AuSpHul1vewLy21ST2m4H9GAMs
 kYXNGmrCZfZ+152SN4YVzoyv4PfNAViEAyGtA3pfrHP32pQLB0zFR7xxy
X-Gm-Gg: Acq92OHTK/+qBoFJgR8ICl3Hv5MwrWm6p6bNl4qg7ZbTjlzHBS4Uj1oph29365HzsGh
 xWzlifgsS15w58OjidXgGPln5E4qoYY+sj6aX8ueqj/C2gZRqAtb36tk2zY9zINYaLNxcYwrBxP
 JQ2XVnvfhZRxeRzD7uJhO1CyzGunvKC0I/HTuGXA8dPfD9aml3UiiTYtx2jHwMsZzshkqXqenWd
 egGu8te4g0sNbAfJV0lysne553qH3xElbw7mYbDyC7iHYoZ8dpNQLAeO1yth72jcPEMXtMBx3mC
 vME0H3jVHqHauK4AvLOILDWYMToYQZqxASpVzxsKS1QphhtYc8S2yU5V7UGNypO3qN/V61UPxhd
 EzFzofy8TT3SFjtfVGS8sJAzQHZHYXjygHCGYNaF0ISztnlpC5FSeeuiv2mTJtrsbBchOLBMb1i
 KdsY8H9VJh4tZXDEkC
X-Received: by 2002:a05:600d:640f:10b0:490:3ff5:737f with SMTP id
 5b1f17b1804b1-490426cefe0mr166930765e9.18.1779710220868; 
 Mon, 25 May 2026 04:57:00 -0700 (PDT)
X-Received: by 2002:a05:600d:640f:10b0:490:3ff5:737f with SMTP id
 5b1f17b1804b1-490426cefe0mr166930365e9.18.1779710220448; 
 Mon, 25 May 2026 04:57:00 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49044f2bad3sm262009665e9.0.2026.05.25.04.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:57:00 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 25 May 2026 13:56:57 +0200
Subject: [PATCH] igvm: replace raw uint32_t with igvm library types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-igvm_types-v1-1-df2907c1815a@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNT3cz0stz4ksqC1GJdkyQjkxQjY+NUs6QkJaCGgqLUtMwKsGHRsbW
 1AIkUH41cAAAA
X-Change-ID: 20260525-igvm_types-4b24d233e6bb
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use IgvmVariableHeaderType and IgvmHeaderSection in QIGVMHandler and
qigvm_handler() instead of plain uint32_t, so that each field's purpose
is clear from its type.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index c347d0c17e..8bb5750768 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -102,8 +102,8 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        Error **errp);
 
 struct QIGVMHandler {
-    uint32_t type;
-    uint32_t section;
+    IgvmVariableHeaderType type;
+    IgvmHeaderSection section;
     int (*handler)(QIgvm *ctx, const uint8_t *header_data, Error **errp);
 };
 
@@ -132,7 +132,7 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_madt },
 };
 
-static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
+static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType type, Error **errp)
 {
     size_t handler;
     IgvmHandle header_handle;

---
base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
change-id: 20260525-igvm_types-4b24d233e6bb

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


