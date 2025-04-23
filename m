Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD55C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wd5-0008ID-KK; Wed, 23 Apr 2025 05:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcD-0005Rv-Hl
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcB-0008Or-Q9
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wirrYJL3x9+/MjPnDW8rrScEQsyGxGC8l7QgjarGMjU=;
 b=AQmA9dR22FCEY08oA2J8rqjvKs8JGA8VSdDyzbrMcoqHHwJP4mC7SV8QwQ8zoSM0tQ2Qqi
 Mq+eDFBAstX8ZR7at67H8JHdcx47h6dXkSDA7UPE9PAFDSaK6KUFfw0P0iQ+/po1LLfxEq
 exVR83Y5b2kQ07YOY6/zHoHN8AZBD64=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-pjCXwFlXNNufnkPiMlNqBg-1; Wed, 23 Apr 2025 05:41:54 -0400
X-MC-Unique: pjCXwFlXNNufnkPiMlNqBg-1
X-Mimecast-MFC-AGG-ID: pjCXwFlXNNufnkPiMlNqBg_1745401313
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acb5a03afdcso450299066b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401313; x=1746006113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wirrYJL3x9+/MjPnDW8rrScEQsyGxGC8l7QgjarGMjU=;
 b=QBczanpbCzqsMzlhusSQnCBObOwbhKeI2PcpOClM53auvoI+IxUDwa1wG+y6fGc7oW
 3HT9d14Pomb1NRi9vNXxZh0qWCMMQfEuSoIm22ziVFMXMtPvldW9cxvPH+jsxtQOWdZS
 VhRZypBeNULxHexsYzBmc5d23Xj7Gi2/3rb9ayWUa3DMA4UfRerbqLdeDQM3Z1jpBY6T
 C/wBn0HsSyxZmh8pWh2TeBmXchko4R9X6UF/5D8pPZ5OTJQMoOhUw3zpHgDp+XT7badR
 h922xY8o4Hkq6YbSuZznuisTm0O8W3Y/ltLjB7InjwSRl9VSVqcji+XQKk3fpD25t2AM
 K55w==
X-Gm-Message-State: AOJu0YzR0DMVuGNmblRhovMEP00P64ua3slDpiew79di1zyGU4wE64XS
 GlknO8D5Sep+5maM2z1SiTxOxkXFwazy+QW31sGPX7wmdF+Sz0L68nhQow8yj9ygqMsvLJ1DeAn
 le+XqbDZ/yabnFbGV/qBa0xpMoT7PmoyKudw/lTnooQQ8KCBTLfs7zVFdwAywehQwifTxZDhvge
 m1+apA0TjFVFuVITBfDmHKMGx32Ij7y9Y1iHim
X-Gm-Gg: ASbGnctpvM7RYxwTr9wZ8teGReAdjRH5L55EwecCyI4Xe47vqJglkK7Uj5mHv2i9npk
 fCBphPLSDiWXN9ptHoGARzd1GH814lUdjS/sz+1l2SsBeumyO3ogQrpEBTDCO+gS3f/QfLMxhbY
 HXHpkMvD9a//1NOIDpRNhA4Q1dE8XI73bY+Pm2yE+EsFm/ISSfazwRj+Wb3YMvH/1jTQitSqLzV
 ngGEk/K0tFGlCESweCdfaz3WOL9o8Eb5tZP9eUo1G7R/k3ih4xVI7pSz60+p3QksaTAA95xPYhX
 bJprmLkEQA14wcWT
X-Received: by 2002:a17:906:f5a5:b0:acb:6ec0:12ec with SMTP id
 a640c23a62f3a-acb74b87d49mr1654854066b.35.1745401312719; 
 Wed, 23 Apr 2025 02:41:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHtw6tTVH9IS1i+TrmL0IdfATgu+SyrW444/3SCX9aJrIrzuuhmMg0dxkeUyjJL3EnerQEwQ==
X-Received: by 2002:a17:906:f5a5:b0:acb:6ec0:12ec with SMTP id
 a640c23a62f3a-acb74b87d49mr1654852466b.35.1745401312289; 
 Wed, 23 Apr 2025 02:41:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ef47089sm775233166b.130.2025.04.23.02.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 21/34] target/i386/hvf: drop unused headers
Date: Wed, 23 Apr 2025 11:40:51 +0200
Message-ID: <20250423094105.40692-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

From: Wei Liu <liuwe@linux.microsoft.com>

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-10-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_decode.c | 3 ---
 target/i386/hvf/x86_emu.c    | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 728e1596381..ddd7b60bcfe 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -20,10 +20,7 @@
 
 #include "panic.h"
 #include "x86_decode.h"
-#include "vmx.h"
 #include "x86_emu.h"
-#include "x86_mmu.h"
-#include "x86_descr.h"
 
 #define OPCODE_ESCAPE   0xf
 
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index aec7a8a3fa8..26a4876aac0 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -40,11 +40,7 @@
 #include "x86_decode.h"
 #include "x86.h"
 #include "x86_emu.h"
-#include "x86_mmu.h"
 #include "x86_flags.h"
-#include "vmcs.h"
-#include "vmx.h"
-#include "hvf-i386.h"
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
-- 
2.49.0


