Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4692AC27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrY3-0001d5-5c; Sat, 08 Jun 2024 04:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrY1-0001Os-78
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXz-0000ES-Ea
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPiyqWtkdouPkbBJ15LI8Nw/Quwczy/iCXqPhI1GpG0=;
 b=YmFVQuHOsPjWfslU0dwxAQl9BwygGoukEf7Lcy2n8QsHMvOXLxkLV3PSN0etz7p2bmkLAo
 T2MmugwJs0XjxLje8UBRxC4KHMTPd7n8s5nqN8WSk4W5X4GhHJK7cklupuC2ePy0UwG1U/
 ozSIXXwUFsXwQEbx+0O8vY5X9ddN7so=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-gb8GkYZeMK2a714Y10o2xA-1; Sat, 08 Jun 2024 04:35:33 -0400
X-MC-Unique: gb8GkYZeMK2a714Y10o2xA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a5086b835so810287a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835731; x=1718440531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPiyqWtkdouPkbBJ15LI8Nw/Quwczy/iCXqPhI1GpG0=;
 b=MZVOl41nvoVqSl3NPaKSyhV7Cf7HIhjgkc9BnE2prXNnSPdOgN6yFFvGmSF1p+HeLT
 IrwItV/1qU0EgNfcW/5KvXbynnavAMzsinrsOcrzKw4HhN5MLFwGyN2gJ/N0ew54E934
 S1+86w0o3efzPVaL4VuMts0yWL5jRJmjvX9DKwD3MIuCyNhigz2xhgmYWagRUC9t5dLU
 YQas5jQX3ImcvUkvZM1MlE23wy0sY/McoLcjPEfwIpkkBnFi9q6x0Joz1GNf3R3/3DV4
 XIRL4HA8U9qL5CVZqAhCZ9WphOXg6iE55gODwhM5r1CP5/FOjAHbp5x9UESvIEGUNx3b
 VreQ==
X-Gm-Message-State: AOJu0Yzm1uca9r4eVK0yyiPfRWT1JnVXr31CrlDrSC4D2V9B4RFJaf1N
 GUEM7s+quADub+xFfLdXHOR4Tj3a/YAtP74BsaQP/dXLwPWOTxw2xtwHlZWyHxPNrGU2Z3NmjN6
 LDrGCRC/B05/4RQawPKSa7fyx1LO6fZw4KACdhHkX9N1ifQ0h3jxSQiwoJU55+QiU66lltfFA46
 /d5MoYJbnCWAzqhxztDpNLIgoEG059Glb5C9mq
X-Received: by 2002:a50:871b:0:b0:57a:23d9:9ef6 with SMTP id
 4fb4d7f45d1cf-57c509292c5mr2788352a12.25.1717835731341; 
 Sat, 08 Jun 2024 01:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVJv/kJ1HIL/wVHh9pBOPODsJU+D6eE2rCopr84JxCes8hVGvrNgNXW9xyXMiPD8HXPfpe2Q==
X-Received: by 2002:a50:871b:0:b0:57a:23d9:9ef6 with SMTP id
 4fb4d7f45d1cf-57c509292c5mr2788339a12.25.1717835730919; 
 Sat, 08 Jun 2024 01:35:30 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0ca9besm3943556a12.27.2024.06.08.01.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PULL 28/42] i386/hvf: Fixes dirty memory tracking by page
 granularity RX->RWX change
Date: Sat,  8 Jun 2024 10:34:01 +0200
Message-ID: <20240608083415.2769160-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

When using x86 macOS Hypervisor.framework as accelerator, detection of
dirty memory regions is implemented by marking logged memory region
slots as read-only in the EPT, then setting the dirty flag when a
guest write causes a fault. The area marked dirty should then be marked
writable in order for subsequent writes to succeed without a VM exit.

However, dirty bits are tracked on a per-page basis, whereas the fault
handler was marking the whole logged memory region as writable. This
change fixes the fault handler so only the protection of the single
faulting page is marked as dirty.

(Note: the dirty page tracking appeared to work despite this error
because HVF’s hv_vcpu_run() function generated unnecessary EPT fault
exits, which ended up causing the dirty marking handler to run even
when the memory region had been marked RW. When using
hv_vcpu_run_until(), a change planned for a subsequent commit, these
spurious exits no longer occur, so dirty memory tracking malfunctions.)

Additionally, the dirty page is set to permit code execution, the same
as all other guest memory; changing memory protection from RX to RW not
RWX appears to have been an oversight.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
Message-ID: <20240605112556.43193-5-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index e6e916225bf..268c5734d5c 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -135,9 +135,10 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
 
     if (write && slot) {
         if (slot->flags & HVF_SLOT_LOG) {
+            uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect((hv_gpaddr_t)slot->start, (size_t)slot->size,
-                          HV_MEMORY_READ | HV_MEMORY_WRITE);
+            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
+                          HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
         }
     }
 
-- 
2.45.1


