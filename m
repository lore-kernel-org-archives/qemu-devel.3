Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401C5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlSt-00077b-Q6; Tue, 16 Jul 2024 12:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTlSn-0006gF-TP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTlSk-0003xj-Oz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721148936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=svFAtYQ+zKfL/CIKeUJ22r7UpuvyFL8U+O+z4f5HkMk=;
 b=OzZpP19QxpstYSArJOylK+BcibqYxVuYfiy/f0WV4RCKhHdzGfpUsr2FOxYuNTWkGj4xk/
 ec+SKvc1qdKQKnCrxmRR1pMnXJfUBuh7sdCjUFTsr9C3ypen4/5dRsNXajb/QF2KIS/pKT
 wLc35Carl8m2BGryG+rtr4nR0YBgOpE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-xNuoqEJ5OreiIhfaZIWbgw-1; Tue, 16 Jul 2024 12:55:35 -0400
X-MC-Unique: xNuoqEJ5OreiIhfaZIWbgw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42667cc80e8so40900435e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721148933; x=1721753733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svFAtYQ+zKfL/CIKeUJ22r7UpuvyFL8U+O+z4f5HkMk=;
 b=hxqAT/c+cS4JoZ+8xFSOK+R40HaKUG7kNUbfRwPPNsHAJk6nv4X/p38ME74cHV+wN6
 hvWenRCvj0wRep6tJ919fPaoVxvC33LxSn6fvsqFx5scfkP4Kblu/PNNw2l4alBnA2+h
 uuS5TbEVsggaPfywYXcU5jD3kmgXeiQN8l5cVi2OSF/vbLrtBHBQ6f/dblIqsZ/oMvZk
 I0LxZMizml2Mn/loE368mzQPKwF/L0eI9qg8upvP+9EvQ7NGuKhzrGcl6PA9oxScp51b
 YGrGJ5QVcAsoD+vJOcRCy9wp9kEkXhfAZHNGAulPWJ5YvebwCNK7RFSmQj2fawb9onxN
 XOTg==
X-Gm-Message-State: AOJu0YzRYQicVQGb1fTB9n0Y72FXOMoFujNAEZeF/uyU7BUqM2YSCSjC
 RnPbwogpd3G3l/qQ3kzzs9Dc9yE04Rm6Rs8+DxUwn1M0i7vfs5fqnnT7+wLbsVLJjMAf9V9mpP0
 whLAaDawIMt7eg+3dpHIsoaqzwon0QvJoN95C2q93DKyJS4tzDWYv0XXmtATy5clyTB7sTwacdc
 mwCorMB+LrIzWtKeo92IebKjPAhTd5a+ELaOCK
X-Received: by 2002:adf:f48c:0:b0:368:75:2702 with SMTP id
 ffacd0b85a97d-36825f65994mr1614291f8f.13.1721148933101; 
 Tue, 16 Jul 2024 09:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYVU7FdIPaU9gqLHQc+M2guqD0CZawvWlg4AoMTRLqpMylajr9TA7VHXv0HLFTgPzXRcbdQ==
X-Received: by 2002:adf:f48c:0:b0:368:75:2702 with SMTP id
 ffacd0b85a97d-36825f65994mr1614273f8f.13.1721148932634; 
 Tue, 16 Jul 2024 09:55:32 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc32esm171365895e9.35.2024.07.16.09.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:55:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/i386: do not crash if microvm guest uses SGX CPUID
 leaves
Date: Tue, 16 Jul 2024 18:55:30 +0200
Message-ID: <20240716165530.288096-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

sgx_epc_get_section assumes a PC platform is in use:

bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
{
    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());

However, sgx_epc_get_section is called by CPUID regardless of whether
SGX state has been initialized or which platform is in use.  Check
whether the machine has the right QOM class and if not behave as if
there are no EPC sections.

Fixes: 1dec2e1f19f ("i386: Update SGX CPUID info according to hardware/KVM/user input", 2021-09-30)
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2142
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/sgx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index de76397bcfb..25b2055d653 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -266,10 +266,12 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
 
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
-    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
+    PCMachineState *pcms =
+        (PCMachineState *)object_dynamic_cast(qdev_get_machine(),
+                                              TYPE_PC_MACHINE);
     SGXEPCDevice *epc;
 
-    if (pcms->sgx_epc.size == 0 || pcms->sgx_epc.nr_sections <= section_nr) {
+    if (!pcms || pcms->sgx_epc.size == 0 || pcms->sgx_epc.nr_sections <= section_nr) {
         return true;
     }
 
-- 
2.45.2


