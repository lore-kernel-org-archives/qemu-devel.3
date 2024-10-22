Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E16D1CDA1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t37w2-00023U-FP; Tue, 22 Oct 2024 02:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t37vu-000236-9h
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t37vs-000880-Sl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 01:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729576791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ytyP0necWqgtONoGnKITq/CJeMl78GQb/p1J2l+52P4=;
 b=HZb+tDWD0LKbBAtnfxUQx+swok9Rg0Kqx9/qLtLuujsm/r2G4WuMBJ2GBATWMRDvTlaRCW
 pgZMOAOWTMt5R0WyYNI9JumWtK1kYzZlQm79O7hqCQSz2f+P+Qhre+ObgbzJ59lgqRsJVh
 34Pe1tWRojdClNBM6jd6LXoGQo40FvI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-3w1sWbe4PseLMEbLMplhzA-1; Tue, 22 Oct 2024 01:59:49 -0400
X-MC-Unique: 3w1sWbe4PseLMEbLMplhzA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4314a22ed8bso38762185e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 22:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729576787; x=1730181587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ytyP0necWqgtONoGnKITq/CJeMl78GQb/p1J2l+52P4=;
 b=bJugUQhZkbWaE7mz1DXV1i5tuf6WEPFGF/iXUFN9gi/SKiFlAG1D/EJp4FXJHoWEXx
 68qlbXlx6KtnLD6sDNGV84BxODK4n7UQdI9Aa8tS71GZTednPvBq8BjEKkQvjoRd97JV
 RAL+7RY9psdnI679WJAhpwkMYJEbkALEs1tiKY7x4nz7DbiSACSug1hYBwRo7907ytvw
 bNBIGM0zFfBug4cUlt8Vmzgr8T4DV2s+dkIwcESixW7lityXiI6Z7IkqItD0XBDBI0w+
 SGfBIq0kwPPMRGr7x6AJ0f+5h8pJuGsQHWZv1oWogzD+FQ6k4MwRmC+anLtpLXISUyP3
 6Csg==
X-Gm-Message-State: AOJu0YxE768Qgx4xxoDsD4+lTZ4WKzJzQ4oaRDw0rN5gUJbb1jkI8KL1
 0bJ0lcuYWbHYxFMmCQdtmu4C7uayAWp9Zpm3xnJeU1jQZZSw8R573cBAv4kidx1J0RqUWtKOUzF
 2yd0EzL9weOzd2Fv/Mb+n0S8wiPX9Lt+z5oWszWfyEoO7vlMklw1NKykdAk3mom4HzZPdBeMpIc
 CX/och450Nn+OCjedy6Hu8Z7e90dW6kzsyboCNERM=
X-Received: by 2002:a05:600c:1c9f:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-4317ca9a8e0mr10762235e9.8.1729576787198; 
 Mon, 21 Oct 2024 22:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk5EveH8dmZqkm9rjSCKaKepXc/PVTNZMICYggtN/5f/Zh0BPeKFx5UjXdMLagWVsXePj9Ew==
X-Received: by 2002:a05:600c:1c9f:b0:42c:bd4d:e8ba with SMTP id
 5b1f17b1804b1-4317ca9a8e0mr10762035e9.8.1729576786778; 
 Mon, 21 Oct 2024 22:59:46 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57fc77sm78162235e9.17.2024.10.21.22.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 22:59:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	qemu-stable@nongnu.org
Subject: [PATCH] target/i386: fix CPUID check for LFENCE and SFENCE
Date: Tue, 22 Oct 2024 07:59:44 +0200
Message-ID: <20241022055944.148030-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

LFENCE and SFENCE were introduced with the original SSE instruction set;
marking them incorrectly as cpuid(SSE2) causes failures for CPU models
that lack SSE2, for example pentium3.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1f193716468..48bf730cd3e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -345,9 +345,9 @@ static void decode_group15(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         [1] = X86_OP_ENTRYw(RDxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3),
         [2] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
         [3] = X86_OP_ENTRYr(WRxxBASE,   R,y, cpuid(FSGSBASE) chk(o64) p_f3 zextT0),
-        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE2) p_00),
+        [5] = X86_OP_ENTRY0(LFENCE,          cpuid(SSE) p_00),
         [6] = X86_OP_ENTRY0(MFENCE,          cpuid(SSE2) p_00),
-        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE2) p_00),
+        [7] = X86_OP_ENTRY0(SFENCE,          cpuid(SSE) p_00),
     };
 
     static const X86OpEntry group15_mem[8] = {
-- 
2.46.2


