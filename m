Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D84CA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 19:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEtq6-0000up-N9; Thu, 08 Oct 2026 15:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xEtq2-0000ua-RR
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 15:31:35 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xEtq0-0000vU-7u
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 15:31:34 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ac4806e210so33716627b3.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791487889; x=1792092689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qH0/yqeoo6bE7Rw0T+CPyNXBe4Y/+9cE3alp/xzuuIo=;
 b=QmphCRl+YGb3hkZ5F9nA2+12cRXMh11u+qDxX5903+m3Q696eEDOFC8wHegCgUbMIM
 Tn4LFqGEKWeCbDWNuXQH8knMniFRxM1DU6L5BAagQgzWB21iDhyfbxbFyxmkLYnOnk90
 /xJZSWAt/whiVOpa8uhppWOHAOEEVCqnBHQacghOS7H2eXFDwL99LjLg+nlBQsvhbYDX
 R+UbKRA8InQsMqikMx1bOtOjGj64LbzlLUVQLmejP4+NZ5QdlloESG5XJ9vAJoS5Q4L3
 UUGUbEZMn4G8+Ti786d5PhuTNSIOMQEVO8BrmNd5Ixd9+8cVkdn6f/BY6YeGEdYzhYps
 qcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791487889; x=1792092689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qH0/yqeoo6bE7Rw0T+CPyNXBe4Y/+9cE3alp/xzuuIo=;
 b=T6VMlMmtBTUgyrk1xfGw75YHnXoth4CE9fwaldJSAcD1WBcdqqX5IUj4VwwwiYQDBY
 LKSzbgSa6XVROhdUzf45/VFv9vVxppU4VmMBOpw46bjxi3VOERQ494Li9GkvuZKbgnhW
 ExfJ9uiq24RO6r6aZUqvSrFbyYsK9KNkAGwqJgQDXjVoQlPyDaUPEwWYb9sm6/g/yU8D
 i1ahD9r2FkuW8By6A1A2pX5CfUh/5HxBpiSCTlEi0V6YhPRdm83vVYxxyiG13Ry3Hd+3
 1KTtDasonmum51k0ahDfIdiVgbkutvrcEUGAXK3kskVaK8bGT72EHLbsLmcNBv0PlQnf
 vgqw==
X-Gm-Message-State: AFq9FYL6A0s+6UNxvdTQXCy4KS78k4419DCg7JPaAKiIuQUEtkM2FToQ
 APBOkLpq+LGuD7e4zbcHPGoo2bZnFKaKE7Y0LfjKV4y+XCG/lV/jHaXVA176IQ==
X-Gm-Gg: AYBFou0I/Xd1RHzkk6iy2B1FpBzGufJUdauGpnxs091gPmXxBJsaZo24TZavD+0Pppt
 bFoJrdR+AtP1P8CRTIsoDcmAwxukCj6GB1FrNwD90LWBR2ydxAMu2k+FHBXhNNdODiHIt0zd/tx
 GHs0rMoSRQ8tNO3j1Mv1kL63XarsfTrVZlE73ymMuDU4Ji+faS7qFRG+R0I9ALAI7fnDdDamCNM
 2zXY432VqIYI+OCx+0OdRtAPTECbAcrImJOd+7+MfwHBYgd2M0ZdO4FNbcGTvbnZRtyemNBVD+3
 vXsCXmtm27nggpSMlOwilphfkAASNbCkoYG9AcI4wb52uI9nhhuXDkUsPH1KHxzDM5272wrP8GZ
 3J1Czhpg7E79HQYUvGUT6nGkJLPQirv9wRPq/m+2gzaNSXpFopj73T8XD2uTgO5xV9jT9P/qgKO
 vn3Le2P+Cy8bgw09ArkFOFMITnxbS1Bl3JbmYmCIe4CPPkncgm7ZI0Az9LEOEXd6d04bp6QLeN
X-Received: by 2002:a05:690c:e203:10b0:873:5c0f:293 with SMTP id
 00721157ae682-8b05b11de21mr27772117b3.61.1791487889158; 
 Thu, 08 Oct 2026 12:31:29 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b07d5c097fsm522777b3.19.2026.10.08.12.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 12:31:28 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>
Subject: [PATCH] target/alpha: honor the page table entry granularity hint
Date: Thu,  8 Oct 2026 15:31:19 -0400
Message-ID: <20261008193119.1246259-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PTE<6:5> is the granularity hint. A hint of N says the entry is one of a
block of 8^N pages (64KB, 512KB or 4MB) that are contiguous and naturally
aligned in both address spaces, so that one translation buffer entry may
map the whole block. Such an entry takes the frame number bits above the
block size from the PTE and everything below from the virtual address.

Do the same: mask the frame number down to the block base and take the
offset within the block from the address. A well-formed block translates
exactly as before. A block whose frames are not contiguous or not aligned
now gets a wrong translation, as it can on hardware, instead of working
by accident.

The size passed to tlb_set_page() stays TARGET_PAGE_SIZE. A translation
buffer is free to ignore the hint, so a guest already has to invalidate
every page of a block, and one entry per page is all that is needed.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 target/alpha/cpu.h    | 1 +
 target/alpha/helper.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git ./target/alpha/cpu.h ./target/alpha/cpu.h
index 378bd96d94..93b8795257 100644
--- ./target/alpha/cpu.h
+++ ./target/alpha/cpu.h
@@ -321,6 +321,7 @@ enum {
     PTE_FOW   = 0x0004,  /* used for page protection (fault on write) */
     PTE_FOE   = 0x0008,  /* used for page protection (fault on exec) */
     PTE_ASM   = 0x0010,
+    PTE_GH    = 0x0060,  /* granularity hint */
     PTE_KRE   = 0x0100,
     PTE_URE   = 0x0200,
     PTE_KWE   = 0x1000,
diff --git ./target/alpha/helper.c ./target/alpha/helper.c
index c3614ecafd..bedc0df483 100644
--- ./target/alpha/helper.c
+++ ./target/alpha/helper.c
@@ -267,6 +267,13 @@ static int get_physical_address(CPUAlphaState *env, vaddr addr,
         goto exit;
     }
 
+    /* A granularity hint of N maps a block of 8^N pages with one entry. */
+    if (L3pte & PTE_GH) {
+        hwaddr mask = (TARGET_PAGE_SIZE << (3 * ((L3pte & PTE_GH) >> 5))) - 1;
+
+        phys = (phys & ~mask) | (addr & mask & TARGET_PAGE_MASK);
+    }
+
 #if PAGE_READ != 1 || PAGE_WRITE != 2 || PAGE_EXEC != 4
 # error page bits out of date
 #endif
-- 
2.55.0


