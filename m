Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2880C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvu-0000Ux-Kl; Fri, 30 May 2025 03:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvr-0000MW-Ny
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvq-0006qr-0R
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJgOcvBZbflxB21XmiBn8XHOi1hzQEyAQ+9+77NfZME=;
 b=hR1Vrv21Nk0BdpLJFXgnhTTTxod3PK6/h6b25aRMEW4TA9kyic64cU2AubNEcd0ZpUyHIr
 hoFfUWGshZaqOalRPYbM1HQiaD6EqpXqh1iVGqZreoA5AeYb3MJAzj4pCk7joHwkW4iqRi
 bW2Nsa5wCnnVh4qztPXy6yMSivSOe5c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-srs_wjpmOGegpKk8Nqyk9g-1; Fri, 30 May 2025 03:13:29 -0400
X-MC-Unique: srs_wjpmOGegpKk8Nqyk9g-1
X-Mimecast-MFC-AGG-ID: srs_wjpmOGegpKk8Nqyk9g_1748589209
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acb8f9f58ebso125228266b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589208; x=1749194008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJgOcvBZbflxB21XmiBn8XHOi1hzQEyAQ+9+77NfZME=;
 b=Yl1Z7x0qr1DEkmeJFtvd/Iwdn7q/WOz4qyJO1HUx7jPvt9WnS9brkrEmICagEmprIO
 R6XqbJyh3HKglKEBi8xWIOnNkpCdrl7mKFPQNsqK9thH0Zt2onZP0ZRC+M7s30REmEur
 zoCsNgNzmsABumFsmRxRHXQ/GsxZ9qlzKwnegcHZkp6qE0UboIdCZ56pOPDQwIDcfsnO
 aUb9NWBmUlhyZwptqfcC2ymVdLQrKPZR7tc6E9afg4dfPhSyjdNaaafH0qEdBT5NhWoG
 gVBXsGUEnBhWihkOZnIj/d0WHvEShviPIBUWAeR4iI3Mbty5Kyks8E4d2i+Vt+kAOxW9
 QZxQ==
X-Gm-Message-State: AOJu0YzUHxOZN6ski99RAAMaHilXSsBdgxwS72VdrNqSMYf36zYWPZX2
 NgTpw2t8l2p/iV+F3aBQbHVNt7+8yYu3791RY3ZDkYHbZLDOGYjAjvpTss/yCCfLw9fkb2/R+Nc
 5WK3g63/muBWiEJGmnVl50vroxFN5Fizjd0lJLMLwYcXK8AV7hgUau129UEm3sDyqB78lxg5gDm
 OWeE8GQrsN7Td91ZLnCAbeE9Z8FK0H6Mx74VJkdvVp
X-Gm-Gg: ASbGncsHnkXdlWGV19Mtxf/wr4aM/rnEMkS0qr/loV9xS5hkC6Ew8ml+toUDjdYjwxm
 EOcSzL8aiV/jye4q7NVM6EiMlKhO8hnmbOTw9ial/BLwtqI67Hq8tnC7nzyzcSFNFJxBGCLXfB6
 ltkMZ9DENwwvzFTp87hIapUC04u35R/dL52ZaNgugsMnafH4jawXIQEItAbGIGEQ7Cg8PP8xCk7
 g6RtsQWsEqCkUBjEjX0nxdHIjlMWSAz94VJ08H4vz8L0SPMO0JIlc53jTQ5U5XrboSDawSE0ibG
 hrVWKPUaQkQ69g==
X-Received: by 2002:a17:907:972a:b0:ad2:5499:7599 with SMTP id
 a640c23a62f3a-adb3228d6cdmr207785566b.18.1748589208167; 
 Fri, 30 May 2025 00:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9adLU/2XUzKnBkf3WHWb0nDyMPeyzUDtm5vGEpBhJBYQXQc4xZMQWS4pWAzM0V5luv9AT4g==
X-Received: by 2002:a17:907:972a:b0:ad2:5499:7599 with SMTP id
 a640c23a62f3a-adb3228d6cdmr207783066b.18.1748589207706; 
 Fri, 30 May 2025 00:13:27 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad3952esm275308466b.126.2025.05.30.00.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 15/77] i386/tdx: Implement tdx_kvm_type() for TDX
Date: Fri, 30 May 2025 09:11:45 +0200
Message-ID: <20250530071250.2050910-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

TDX VM requires VM type to be KVM_X86_TDX_VM. Implement tdx_kvm_type()
as X86ConfidentialGuestClass->kvm_type.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-4-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c |  1 +
 target/i386/kvm/tdx.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index c9a3c02e3e3..653a8f46c2f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -192,6 +192,7 @@ static const char *vm_type_name[] = {
     [KVM_X86_SEV_VM] = "SEV",
     [KVM_X86_SEV_ES_VM] = "SEV-ES",
     [KVM_X86_SNP_VM] = "SEV-SNP",
+    [KVM_X86_TDX_VM] = "TDX",
 };
 
 bool kvm_is_vm_type_supported(int type)
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index ab70566c7df..21a4f877565 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -12,8 +12,17 @@
 #include "qemu/osdep.h"
 #include "qom/object_interfaces.h"
 
+#include "kvm_i386.h"
 #include "tdx.h"
 
+static int tdx_kvm_type(X86ConfidentialGuest *cg)
+{
+    /* Do the object check */
+    TDX_GUEST(cg);
+
+    return KVM_X86_TDX_VM;
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -40,4 +49,7 @@ static void tdx_guest_finalize(Object *obj)
 
 static void tdx_guest_class_init(ObjectClass *oc, const void *data)
 {
+    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
+
+    x86_klass->kvm_type = tdx_kvm_type;
 }
-- 
2.49.0


