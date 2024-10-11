Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D45CFD2E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 08:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szBMR-0005Hz-VO; Fri, 11 Oct 2024 04:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBMR-0005Ho-2C
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szBMP-0007Vq-72
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 04:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728636655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OgoG8JgwXVz3g5onUJt7t2xCU8/TZqbsVMYU5eI+0xg=;
 b=St3/cJc6Oeuet2VfyZYn2WtXPusNmTzN7u8EbXOajotMYQ+SMtAK9KWvJjZTpRRfKu+WfP
 CSMgWTQrsdenvR9RWBVfalewToxy22vWq/nfBqRtwdHHTE9Z0cPSaMg7LPwTIswssmULGL
 rxDPhMqTPyCEg5K1uNMzD72mW3X/igE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-WraLTEzSPi2r8HX8yB2eRA-1; Fri, 11 Oct 2024 04:50:52 -0400
X-MC-Unique: WraLTEzSPi2r8HX8yB2eRA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a995c3a984dso143433266b.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 01:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728636650; x=1729241450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OgoG8JgwXVz3g5onUJt7t2xCU8/TZqbsVMYU5eI+0xg=;
 b=h/uN02jXvBr645mVSgLr0NiEvv7e3DIFCKaCNRZZuUgVn8kl9bVRVc9yQjqMeJrvK9
 FLMjg/6dOdyBrD808fqGk2wmwPNw3R9JygFjU0PZddWkXiQRvZ+mUy7wbQYIBmloF0DX
 0y/31wvVVy+A7xfAEcEMfn2IK8ogDyz5yv4vLACo4VxEI5ArLxY6pFZuqGHZaIMdyTl+
 tAmkYJkjL7Cekr2J3A5T2nm1dtl82Ycj+hkv3YIv2oLsrYmpX+xgBQB9jAXynF6VzStt
 XiQVt+DzIfq3YnJeDy9fu+p4tPgeYAbYNS4vmF82zECPhfB2QyVxE3PifG0V95ARNTlR
 iAjQ==
X-Gm-Message-State: AOJu0Yz8bFn2V5mJUkvUsytE+KRyE2S+E0Vp+cURHOr+DPxY8w5JVB7j
 z37//KYj6vaR8mAtS080Vf9SUb+wToAwqvtDefp7gFb95WgdvmNQ8PkXIWz/fKxy31UIrbH57Z1
 1mpZ68nRjcOC6AKzTJkawezdHab2ZskQ8oIlxQptoOSvUkONFRWC8GwpMxT6yr0T6pSuOT5kCEO
 jwxlli/oWaRHbzWzSpxXpMF2eDyenG/dnSFzRT2OM=
X-Received: by 2002:a17:907:7206:b0:a99:541d:8c0f with SMTP id
 a640c23a62f3a-a99b95a75bfmr178047666b.40.1728636650130; 
 Fri, 11 Oct 2024 01:50:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7ZFks3chAlBPSldxIxbug+c1ERI2T4l0tpED7r7o3PFXe6muTfPGe3lqHeIg0cHnnOfAJgg==
X-Received: by 2002:a17:907:7206:b0:a99:541d:8c0f with SMTP id
 a640c23a62f3a-a99b95a75bfmr178028566b.40.1728636645600; 
 Fri, 11 Oct 2024 01:50:45 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80dcd03sm190412966b.174.2024.10.11.01.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 01:50:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tom Dohrmann <erbse.13@gmx.de>
Subject: [PATCH] accel/kvm: check for KVM_CAP_READONLY_MEM on VM
Date: Fri, 11 Oct 2024 10:50:44 +0200
Message-ID: <20241011085044.19004-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Tom Dohrmann <erbse.13@gmx.de>

KVM_CAP_READONLY_MEM used to be a global capability, but with the
introduction of AMD SEV-SNP confidential VMs, this extension is not
always available on all VM types [1,2].

Query the extension on the VM level instead of on the KVM level.

[1] https://patchwork.kernel.org/project/kvm/patch/20240809190319.1710470-2-seanjc@google.com/
[2] https://patchwork.kernel.org/project/kvm/patch/20240902144219.3716974-1-erbse.13@gmx.de/

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Tom Dohrmann <erbse.13@gmx.de>
Link: https://lore.kernel.org/r/20240903062953.3926498-1-erbse.13@gmx.de
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 482c5b24cf6..801cff16a5a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2683,7 +2683,7 @@ static int kvm_init(MachineState *ms)
     }
 
     kvm_readonly_mem_allowed =
-        (kvm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
+        (kvm_vm_check_extension(s, KVM_CAP_READONLY_MEM) > 0);
 
     kvm_resamplefds_allowed =
         (kvm_check_extension(s, KVM_CAP_IRQFD_RESAMPLE) > 0);
-- 
2.46.2


