Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80374E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK34-0001iW-Lq; Fri, 10 Jan 2025 13:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2U-0000J0-Bu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2Q-0001At-HC
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QD2muu0CYvy6M9Q4xI+b2Xo6yFDVXnxkK2RJi0em5XA=;
 b=X3UDPmhGh1dYNEYrmXHXzDPtSOgby5zDpS7GHxnj3vDOFbfEPMlCSc89FlcIparJqYe+TJ
 Pq7t6MVgBKy2Ig68D0WQcsgrf4/HwKVF4jKI2qSIpt17cdiGWqhufOQpsXBbGPL43KqmCs
 fiwQaKbFDlKSdP19p2wZ0Mu9RUFUoS4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-YJhGpRBzPji6QeAJMCrghA-1; Fri, 10 Jan 2025 13:47:16 -0500
X-MC-Unique: YJhGpRBzPji6QeAJMCrghA-1
X-Mimecast-MFC-AGG-ID: YJhGpRBzPji6QeAJMCrghA
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d821f9730aso3652981a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534835; x=1737139635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QD2muu0CYvy6M9Q4xI+b2Xo6yFDVXnxkK2RJi0em5XA=;
 b=hcvqZbytOSZEkll/wFIRgON0w/A6zfOBllz828ArhT6aOURvZI28AQNEeiszYrYI8z
 6kldKRjsILL8JK9Xl9wXF3Yj4ea7y5MmNIrDSPws4H1mchqDhGAXmOpD3E/Chq34Rhrj
 3jnGPQKAeGLM01q2/k53AOJUnX9ZTcfVD9NYLMezZaQ0CYAxCCTCopPU3JXoFxj8h5JX
 T3QlmHm4HHdCXC3uCl4iEqy01yyWufJuxm+xpswAGIQm9FNR0bgo2bkK5wRbQYA3bFT9
 UqXDQ6WpjHxlodQb6MIdFm7N7z95ure/ycZKGGLG6hZNFZCYLGSJi/lC5hID3DLtTSQ/
 7DhQ==
X-Gm-Message-State: AOJu0YwsTLP+63PqjLd2TP6OqsahRLr4jPD+50Ie9w0yWf8+QeE5ZMQ0
 GYUIZcnBIIJzoSyipC957fkXAl0jPmS79DN27lx7lgfHM1M81zJ9aW1l9mlaoF4dvL/ByYlQRGF
 F8oBfsBcG7lHOe5kc0ZzgZxl/JA3apcVSnKt/MZoxivLCvKwnUaF85zkD7cb6jICnVPIT9jx/OO
 krw6fwvzvwix8DJkIrey0+pOldQAFLg3QzRM0qnEM=
X-Gm-Gg: ASbGncuBoJUi9u9RhZNOYZf8xP6wEpka/Upd3HumNpefnxd7v6BTItIRtme6JMLC5ii
 IfuNV7sYrhYkHLf+b/bnF6ECOD2Atubo3+VzL2xEBGHvdLDNa4bT1eRAT29dqYaJFGPRN1XFY7x
 YGpN58nF03cwVBdzDhOkJL4iQ5XuabXRMjKs50SW6P3J2t+YKUN+0TZo1Bpr/5hzh0kmB4/3N4i
 a1h1jLIsJF47XTJv98G20SjzRwtdm8fUQ4+d8dMLRNyxCRuwade/bqgGpI=
X-Received: by 2002:a17:906:f5aa:b0:aa6:945c:4531 with SMTP id
 a640c23a62f3a-ab2c3c5c93dmr817943066b.7.1736534834990; 
 Fri, 10 Jan 2025 10:47:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmKMjJLhbC5/lwN6KWSHDST+TBBjTHyDflWfxYUSVdAcjcV+3OqTbB/O/vPD6ZZlIfK5OTEw==
X-Received: by 2002:a17:906:f5aa:b0:aa6:945c:4531 with SMTP id
 a640c23a62f3a-ab2c3c5c93dmr817941066b.7.1736534834566; 
 Fri, 10 Jan 2025 10:47:14 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905e283sm192956366b.31.2025.01.10.10.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PULL 23/38] target/i386/kvm: Drop workaround for
 KVM_X86_DISABLE_EXITS_HTL typo
Date: Fri, 10 Jan 2025 19:46:04 +0100
Message-ID: <20250110184620.408302-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

The KVM_X86_DISABLE_EXITS_HTL typo has been fixed in commit
77d361b13c19 ("linux-headers: Update to kernel mainline commit
b357bf602").

Drop the related workaround.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-7-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7536a3c9fd0..17f23607ed0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3100,10 +3100,7 @@ static int kvm_vm_set_tss_addr(KVMState *s, uint64_t tss_base)
 static int kvm_vm_enable_disable_exits(KVMState *s)
 {
     int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
-/* Work around for kernel header with a typo. TODO: fix header and drop. */
-#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
-#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
-#endif
+
     if (disable_exits) {
         disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
                           KVM_X86_DISABLE_EXITS_HLT |
-- 
2.47.1


