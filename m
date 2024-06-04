Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DECC27C55
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENut-0003Do-Qc; Tue, 04 Jun 2024 02:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENus-00038p-2m
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuq-0007Tx-AX
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MELx3a4wImL1JG8cbryKCbUuCn7aSkqRfzZzglKDbxQ=;
 b=EsHyXdk+H12fwf7gGkAbpwjMJd++uj1zzw4+ivLXBIW9imEmhccr3rXRPnpM80hqHf7ooo
 LLkn3jpHyrckBxi7Js4kBGxQqkthk2JidQt7UcWm1ggh2pc7mRzL4vU8ZiS/Y6IKm9ufRF
 7zufxnTS5dOI69ESVv2KYiPXDP4pKlY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-iSGYBXzwPqu0TDbJh4gRwQ-1; Tue, 04 Jun 2024 02:45:02 -0400
X-MC-Unique: iSGYBXzwPqu0TDbJh4gRwQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6840dde124so353556566b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483500; x=1718088300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MELx3a4wImL1JG8cbryKCbUuCn7aSkqRfzZzglKDbxQ=;
 b=OJ01sZ186cZGH0x4QkGR2iA8pN2azLGvygWUcnFLkrl7RcWwKDfrgCk7CoW4K0OBRn
 Q0M7jKDyijFuubSFtwDOdy2jZ20LQqDRc7J70YKpAzDOAwbwi13iOSgPq4wDbqat10+L
 jgaBWgMIETlK2XxORXc6ejDk7CCeYv/dBnpnGWs/R5WUPXuufgEjox2NW98ObOtC99A/
 ZgT+wSsby3LPr7grIW1rXZYCWmaZzkEtGqqS5OVWRnk8DRpEgTSphwSfNktfSMrihsv/
 pvDuL2MWVhVdj0dG+NcKaZ6WX33NlNPzhmXA+MOuLLpfDcrDZtQjrRH8tJlHiVPW+alN
 BQ4w==
X-Gm-Message-State: AOJu0YyriQYHe9are9sj/7ZQZ3TbrjOhPieAIrVhR+L0d8GZYBqTAYfw
 8S40uHkdoF7kKdGnaGv0i6efyqiROqYGeBkKhlc0OVa/r29KuBj9PHYSTdDYyQWsXbDFUn/FBVe
 Q/OFYIPZNACTiKushqf3E9PK5MF+IJ3BXUJNDVMxtc+EPIBjNYeFhJnQbqpOwSlet/pglMFTk4d
 ajaHtTVW8pocHkta3xK8+eoXtpL6brvAKUnWSx
X-Received: by 2002:a17:906:f299:b0:a59:c698:41ae with SMTP id
 a640c23a62f3a-a69545681d7mr130022966b.34.1717483500463; 
 Mon, 03 Jun 2024 23:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6Q+VT4oWH8leYvid1PjpB2EftMUvVziXppNecf89ZrhGIrNCKkOarmxQO4X8p/UNG0frFsQ==
X-Received: by 2002:a17:906:f299:b0:a59:c698:41ae with SMTP id
 a640c23a62f3a-a69545681d7mr130021266b.34.1717483499960; 
 Mon, 03 Jun 2024 23:44:59 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691364322csm228016966b.109.2024.06.03.23.44.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:44:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/45] machine: allow early use of machine_require_guest_memfd
Date: Tue,  4 Jun 2024 08:43:40 +0200
Message-ID: <20240604064409.957105-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
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

Ask the ConfidentialGuestSupport object whether to use guest_memfd
for KVM-backend private memory.  This bool can be set in instance_init
(or user_complete) so that it is available when the machine is created.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/confidential-guest-support.h | 5 +++++
 include/hw/boards.h                       | 1 -
 hw/core/machine.c                         | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/confidential-guest-support.h b/include/exec/confidential-guest-support.h
index e5b188cffbf..02dc4e518f0 100644
--- a/include/exec/confidential-guest-support.h
+++ b/include/exec/confidential-guest-support.h
@@ -31,6 +31,11 @@ OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
 struct ConfidentialGuestSupport {
     Object parent;
 
+    /*
+     * True if the machine should use guest_memfd for RAM.
+     */
+    bool require_guest_memfd;
+
     /*
      * ready: flag set by CGS initialization code once it's ready to
      *        start executing instructions in a potentially-secure
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2fa800f11ae..73ad319d7da 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -375,7 +375,6 @@ struct MachineState {
     char *dt_compatible;
     bool dump_guest_core;
     bool mem_merge;
-    bool require_guest_memfd;
     bool usb;
     bool usb_disabled;
     char *firmware;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 17292b13e62..77a356f232f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1216,7 +1216,7 @@ bool machine_mem_merge(MachineState *machine)
 
 bool machine_require_guest_memfd(MachineState *machine)
 {
-    return machine->require_guest_memfd;
+    return machine->cgs && machine->cgs->require_guest_memfd;
 }
 
 static char *cpu_slot_to_string(const CPUArchId *cpu)
-- 
2.45.1


