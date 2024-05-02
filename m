Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390F9C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YlL-0001Gk-IN; Thu, 02 May 2024 11:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl3-0000wI-SA
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Yl2-0002OK-8D
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fT1y4KqRaxFcPgY6/amvw3l0h4xpM4rtBuLLxm77NYA=;
 b=P+7Tmp+uKoL7oYSfpBXDfav+QAERhcFdqUHMqbSy0wRK/kXHqzqRLCJ+SV5JjlzPrN9oa/
 iSAU82Dwr+BAvYbjQHYNSfkbCjA2Wi/kYkJK3oCbCmGbv867qRaw1Vln+nkaAUIiTMbs3t
 fRUWc1yD07QeZeEWuv5uo9dVH+oW5xE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-WXuQ5JOWN-GdqXLwqtev_g-1; Thu, 02 May 2024 11:54:02 -0400
X-MC-Unique: WXuQ5JOWN-GdqXLwqtev_g-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-572a0c5ece9so963916a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665241; x=1715270041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fT1y4KqRaxFcPgY6/amvw3l0h4xpM4rtBuLLxm77NYA=;
 b=nSPHu0q0dYllxCtsEJYMKr2PBdK7U4FDevpwxQEtzqgX1E5PyqGC3Y8KZViJMVChJ7
 blgGwE/ePDS0Ca8B3uw3Vj7/4YtHX9l3JoSPTbejvuE0lttikrPO4ApfsE2XbUSBhyAg
 OIwudeDPJJr9S1wG+iqpomcUlFO8S5lhAbVbUGOV+gbraeZb/RAbpZRAfSIPFMwSlfh5
 smoEMzxXnTkb3VoF2B6lv6ITxgVDGaUy2yXlbqG5HIvYL+fSyBYXA+62LxVeB4qbptPt
 lMHdrqytGs7NP8G2HJj1ehBGRSMTHLi16hDyCjp3OoMtszNfSvAiUTbpXr3WJL3JfKQa
 FYPw==
X-Gm-Message-State: AOJu0YycQybQumkofvIC0jtwYH2ZMsD49YDSvsOV19sRv0pKKi+raPWp
 blQGvSwDCVed69tGx86+CdWjtmVKIK2U7tZZAWwmYdGt4/SQlOXT0uYxLYoGvxcK9YYR6Rrehkc
 ZD2cIA1IE/u9e9JyKXb7RcqKQumyCbWiVZOadQ28RMHxVrgO/xAvW7R2uA8/fxGixga2S6y5Z79
 4DHKKRWOXf3ia3UaQPd6oVP6iGQQ+aUAlFWqPF
X-Received: by 2002:a50:bac4:0:b0:56d:faa2:789b with SMTP id
 x62-20020a50bac4000000b0056dfaa2789bmr3721518ede.40.1714665240879; 
 Thu, 02 May 2024 08:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFILstlQFGwN9u18nirD0qKSFlxWgCAkqc5qb3IYQ/XTi4JigOGYJEGMsYWZWlqMcJx+HAB6w==
X-Received: by 2002:a50:bac4:0:b0:56d:faa2:789b with SMTP id
 x62-20020a50bac4000000b0056dfaa2789bmr3721503ede.40.1714665240509; 
 Thu, 02 May 2024 08:54:00 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 12-20020a0564021f4c00b00572707cfa09sm656409edz.9.2024.05.02.08.53.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:54:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/13] qapi/machine: remove types from typedefs.h
Date: Thu,  2 May 2024 17:53:28 +0200
Message-ID: <20240502155331.109297-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502155331.109297-1-pbonzini@redhat.com>
References: <20240502155331.109297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

They are needed in very few places, which already depends on other generated QAPI
files.  The benefit of having these types in typedefs.h is small.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h   | 1 +
 include/qemu/typedefs.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 46b99a7ea55..a23d39f6a0c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -28,6 +28,7 @@
 #include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
+#include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qemu/bitmap.h"
 #include "qemu/rcu_queue.h"
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index b71a36d02b2..78598f27f32 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -37,12 +37,10 @@ typedef struct BusClass BusClass;
 typedef struct BusState BusState;
 typedef struct Chardev Chardev;
 typedef struct Clock Clock;
-typedef struct CompatProperty CompatProperty;
 typedef struct ConfidentialGuestSupport ConfidentialGuestSupport;
 typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUArchState CPUArchState;
 typedef struct CPUPluginState CPUPluginState;
-typedef struct CpuInfoFast CpuInfoFast;
 typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
-- 
2.44.0


