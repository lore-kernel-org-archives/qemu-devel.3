Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AC4C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0PP-0004N4-03; Fri, 31 May 2024 07:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0PN-0004LK-69
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD0PJ-0004b9-QQ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717154807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MELx3a4wImL1JG8cbryKCbUuCn7aSkqRfzZzglKDbxQ=;
 b=V2vgd8UsbtZnjs9xmLIojM3xyYCdnSjUDuYjjcsWFeyRIrqOa7LtS9cRLts/r74FUtDRYT
 Rx0wCdJI5rEFwIk7z/cOaHBopU8olpE9jJJITve9pnWhMvIIVuAXTM2RR5Q7vMEDhLDicd
 KGmmcsosCvhQY1btxJDI3C/OAhhhSs4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-tehcn1X2N0ihpyqGpTbybQ-1; Fri, 31 May 2024 07:26:42 -0400
X-MC-Unique: tehcn1X2N0ihpyqGpTbybQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6266ffd419so74627366b.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717154799; x=1717759599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MELx3a4wImL1JG8cbryKCbUuCn7aSkqRfzZzglKDbxQ=;
 b=nw+VVAX1syLK0NbWk7+ACKl3nNk4kCDaKSL7Y7TLUjHjy4TnYrZwv1i+RkGZ3/fgqD
 lfoYzL22+SDD6WLq+EnW++S1CwRHDhv6wNlzC3JXegYRiVzWzgYV6Ejgk0b0k5as1yOk
 iB9wss5tFIHCdzhUOK57yevvzPaFdUdq6tzxdJyOyk5uHII/4PFtP8yt3JJCtaP3rptX
 I+SikfxS2Kz/7EevBBgBYq0XXAm4+5Ypp1GOreXdA9lQ58XIgUi8S+hlZ88K2e2CbVvh
 pSRdVtd/HO3O1+YLk21DQAYPnPXQue0zzXPFsmTcnOiq5JeffmNg/MjYnnOee1rIjb1W
 LyYg==
X-Gm-Message-State: AOJu0YySmHDCEzqJuUoBV1w31uxUTNY7oGtyPdwjgPVuaiUDgDt5FrXK
 Tu/XrTZCYqaMM6noTLMmaaegZ1+ettTI4AFo1qvMpm7y/RWvx5E4PEjzaFx2xkw2xnQK0hVV+bO
 kNRov9Nn51mznAZx5+yhGNe9zhQGfYz16ilyJ4AxWi8bjk5iCvnnJjHOd5JbT2biD35sBnQMtc8
 pBPAGC4zdS4whsOur46jsGZLnm9tPT+vtEI7gY
X-Received: by 2002:a17:906:f34f:b0:a66:b9a8:74ad with SMTP id
 a640c23a62f3a-a681f87f3admr103487466b.10.1717154799230; 
 Fri, 31 May 2024 04:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCh5Uy2AXxNug9v1pZP52CRkqNoAPpnvoJDdxcM68OfJ4zOjo0gxsMftOL/2oXcQ24N0VejA==
X-Received: by 2002:a17:906:f34f:b0:a66:b9a8:74ad with SMTP id
 a640c23a62f3a-a681f87f3admr103485966b.10.1717154798634; 
 Fri, 31 May 2024 04:26:38 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eb344431sm76261266b.195.2024.05.31.04.26.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 04:26:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] machine: allow early use of machine_require_guest_memfd
Date: Fri, 31 May 2024 13:26:36 +0200
Message-ID: <20240531112636.80097-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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


