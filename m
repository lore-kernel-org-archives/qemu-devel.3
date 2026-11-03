Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B229E606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=i61qTnKy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOJ4M-0001Hr-KE; Tue, 03 Nov 2026 13:17:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xOJ4J-0001H3-6R
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 13:17:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xOJ4H-0002Th-Ka
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 13:17:10 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so29845095e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 10:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793729825; x=1794334625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xBOpO8NmUdWTDPFFJJ/0j3H0s+4BUtytcgUlmtLnjHs=;
 b=i61qTnKyEeA9/oNoeTXarxyC63h+cLD2zs5fLqC4oK42OKAzaL8gG3d1hflvjQz4A9
 p7zJoKZI7i+ApDdm2N6QB/iQR/XUU80rbyt0Gt/bWevO/ZCw2foLDfi9T4IXxcah8ben
 8hmszHH3qqGtTfdCtQYSbaUl8oFziWJIJ91TSNFGihfBt5LcOzDOGfN2Mh1fJZH7mDh6
 pSE67FByTdCGA32VJVoFhJLvQ/J4tpclGeSAu/9DiRkF0JL997Z8rAoq8QB+rEdXvQwI
 MSrDVqJGQhjcMuHkucfJ137lvjNaNh1jrW10rOwAHKnmkpj5rTsd4P4hRuiMSDN0fOA3
 qMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793729825; x=1794334625;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xBOpO8NmUdWTDPFFJJ/0j3H0s+4BUtytcgUlmtLnjHs=;
 b=cRvH0CJrDvpRGjAgbz3BtW3ndGhdqFBQk5mtCUf3s5hLBd9ICYjUYfnumhMHj6ngiC
 b52Pk7BbwJvsHC5gjkAXRCu+YWd4GER9tQMYAVxX73xo+916bXDQiqchZTy7PbJP5LUM
 OyvoSKd9CCYrkzcg6OZP4mGPlihUJgOByJwTRMlpjotoGoKTFn00BP3HOUhXAdva8Co1
 pNftL79oG1HE6xlK1wu9Qh2gMtcfCQZCV7iiy+HpHwwAia2/Nng6/DgglEPR0cTmwV04
 5PfZMIoQIv9gDsp7F/S47mqId7JUlqTfObJ9XmfMw7lRUYIT2+zPt8TkaXxpwWu/Vy2u
 HWPg==
X-Gm-Message-State: APuU4Z+/E9ah6kb7nyZDxEt4xJ3kUIVOTZbFkSeBpDj47e6gHCzct6Ax
 lgBDzPV7+osbBUpc/g3uHJ9yUbezms4M2AYLDPyWyNbYTTnfTxcWgHcan1JzpguzCrbK8c6Y/Ro
 D+vow
X-Gm-Gg: AYBFou3npFN/YAJ+6iNbPhotJ41ECvn+1SMVKRFf+4pT9tIWRr41/X+n8TwitbiVnH1
 yyzwvfBI6q7swTnuLAkbVKxjLwpQr0zSUaZ4oSuQXfprKhkexbkhPKPeSmEgkjHhVP4/LsagucC
 yypAVtSS+E7e5+dNM2tczsuKvIdkZJVd/FOw2apxAyyyDMLPTp4PsR5KMJZaLsc27hnY6AZIoBJ
 TDl6//v4HgrycHb+h0YSirBEDjAblabaoqENflCGUvdnYSGvsIxz8PO9uq3jZeQBVGF/6pLo6RB
 gd+2yByoH075wN/w6Ae3RqgYbri+8DfZiYPU2fggiJ99+sWPpyYO2K13WAFU3XpSUdppVSfU5mm
 SEcWnHoSZ7Jo80ItPbGgRVTpt+ZrQSR+wE7K9QgJddX36bqUgaBvJuKT+W0Wtf2vTQch+a80syp
 ZJe6g15BG543yaQgIjTMahX4BmNsp79g4iSGT/sun1TQkHFFB64+SwV2bG+tvkjcw1sIjS+qWaX
 NtgDj1ywQ62Qkmsls6Xvr0Duxv8+WWojOIAOJy34a1dIT86YjcjvXAB1RTwizVbCkux9cAFPFKx
 tx3/buARUBFg9HPYO35DWgByyw==
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id
 5b1f17b1804b1-4ac187a6ffcmr337884315e9.29.1793729825280; 
 Tue, 03 Nov 2026 10:17:05 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c789:8bc5:fa8e:d502])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9fafe08sm120211535e9.3.2026.11.03.10.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:17:04 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-stable@nongnu.org
Subject: [PATCH] target/i386/kvm: fix latched INIT lost in
 kvm_put_vcpu_events()
Date: Tue,  3 Nov 2026 19:17:01 +0100
Message-ID: <20261103181702.832779-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=den@openvz.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

CPU_INTERRUPT_INIT is 0x0400, while kvm_vcpu_events.smi.latched_init
is a __u8. The assignment truncates the masked value to 0, so every
KVM_SET_VCPU_EVENTS tells KVM to clear an INIT it has latched for a
vCPU in SMM. smi.pending survives only because CPU_INTERRUPT_SMI is
0x0040; normalize both with !! like the neighbouring fields.

Fixes: fc12d72e1082 ("target-i386: add support for SMBASE MSR and SMIs")
Cc: qemu-stable@nongnu.org
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 target/i386/kvm/kvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 3cbaee700b..4e435c864a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5512,8 +5512,9 @@ static int kvm_put_vcpu_events(X86CPU *cpu, KvmPutState level)
             /* As soon as these are moved to the kernel, remove them
              * from cs->interrupt_request.
              */
-            events.smi.pending = cs->interrupt_request & CPU_INTERRUPT_SMI;
-            events.smi.latched_init = cs->interrupt_request & CPU_INTERRUPT_INIT;
+            events.smi.pending = !!(cs->interrupt_request & CPU_INTERRUPT_SMI);
+            events.smi.latched_init =
+                !!(cs->interrupt_request & CPU_INTERRUPT_INIT);
             cpu_reset_interrupt(cs, CPU_INTERRUPT_INIT | CPU_INTERRUPT_SMI);
         } else {
             /* Keep these in cs->interrupt_request.  */

base-commit: a3565937b39779d4e3704298095f566e7559ad53
-- 
2.53.0


