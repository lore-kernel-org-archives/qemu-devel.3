Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2101C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tAT-0000dd-6T; Mon, 06 May 2024 03:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9s-00088m-2T
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9q-0001nR-Dy
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fT1y4KqRaxFcPgY6/amvw3l0h4xpM4rtBuLLxm77NYA=;
 b=gLbRnRoebOZoSJLeep9iF+2WoQ+u5wWRJwldHvNxLjSAPON/ybVWUnmd3p04pSYCgAovnJ
 05nZxmKVTapIlg/XA2919vLkT5Rub59ZliiiMubVk5L/SU6p9MRptkXy0UHhA5GF9bC5Sh
 JZG/L1ZuYVcNXW8bKUPoSYMrrPzlB1o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-h7n7uO4XM-W4UXOFHTYIhA-1; Mon, 06 May 2024 03:53:08 -0400
X-MC-Unique: h7n7uO4XM-W4UXOFHTYIhA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59c0ecd59cso81001766b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981987; x=1715586787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fT1y4KqRaxFcPgY6/amvw3l0h4xpM4rtBuLLxm77NYA=;
 b=NDBRaICSXp3b4b9SCQ1yt3ivIlhbkEBa9lw3YJk3El3ua+ckhwja9jy3Itr4IjCI6G
 uNlDaSm6gvH3hUm8p7x9jkszWV20XpuDJ0ARL3+ruT1W3mosBE6j3etPRaVtfKiofP60
 bchN8ieer9OTk+S1OE2AfaEBUE/NaA4KaQL+0n7/Ida+zFPF8GtM5e1AwyT+bGKdUoc4
 xpfeQnj0CKXAxbBuFTzgCVqsITiblJQQf0ybchZK6l6Xj12Gx8jmM3/zyrD6vEA+zTLc
 /l4fU8zYuKpl/WsThG5U7aCgVbEfaN9LXeCwfBL7BHD33D71/D4ePyLOiDPqtSDi4fBG
 L/IQ==
X-Gm-Message-State: AOJu0YyBKJ9R4DXlJ166YRdWAGkQ0Ve/7J3Ct5XYAjM7VC+EabSC/X90
 TFhnbK/o+wQi/lEG1ijyRrP3rgynoPLbS+wRlS4ecU1JO577uNPu/RVH7T7hAwYIVuhuCepliwr
 KI39HC+OfSlFE7YlxuDWJENhvuXxcZNB370e20YmTG8paeaACIVoaKvriQV1tSXMak8otv+a8pr
 mzI6VPrZ3oX2ym8uOpxHoNET/Dl6ng07BsDJGn
X-Received: by 2002:a17:906:aad7:b0:a59:a8a4:a5aa with SMTP id
 kt23-20020a170906aad700b00a59a8a4a5aamr5203490ejb.44.1714981986863; 
 Mon, 06 May 2024 00:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL8j0yafyXmQL6Vowj+aq3whBUCYhkWpYqxgexTkC0flFxyuwGNgO4Xcn0Kf73jdpEoZFSog==
X-Received: by 2002:a17:906:aad7:b0:a59:a8a4:a5aa with SMTP id
 kt23-20020a170906aad700b00a59a8a4a5aamr5203476ejb.44.1714981986481; 
 Mon, 06 May 2024 00:53:06 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 jl24-20020a17090775d800b00a599acaff03sm3624761ejc.19.2024.05.06.00.53.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:53:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/46] qapi/machine: remove types from typedefs.h
Date: Mon,  6 May 2024 09:51:19 +0200
Message-ID: <20240506075125.8238-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


