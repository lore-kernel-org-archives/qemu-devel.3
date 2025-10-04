Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A32CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSn-0003kO-5C; Sat, 04 Oct 2025 03:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSl-0003eK-Fd
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSj-0004wq-JT
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so21275325e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562027; x=1760166827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uJoUfW+AISGMtvpF4V4lmJ+Thr5AfrXlj88IiNVFbPk=;
 b=PIwvY4+rSESoEk8gfqLa7J+qKLpFTJLz2WEe/v3hx8CIg7WS83nmeVXGCQDKQ7dsB8
 Dn+T6tsHvBaqUd8yeo8irkKDl4iKF2jgz30F5G/LR8uAOkYozYwWbAAlpxpiFqtfGD81
 DUGBP9BPoOmhS+kRPiuJg038IlkSHRNrlN4S9CdlrAbEg3Par06INd6bw0L/Ik5NlgDP
 CqWYctOwalf3RC109HE8EuAMGKDBfQGitjCEzjtnUPD6Yu8h28kJseFn6CgOnyxMq+0k
 JNZ3n3girc6ftudZAWRk3Wo1Ljbg1/v/r1cdziLwMxwCyuJYnsk1jYXuP2D2xWLwR46o
 Gf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562027; x=1760166827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJoUfW+AISGMtvpF4V4lmJ+Thr5AfrXlj88IiNVFbPk=;
 b=Ten0YeQxsmfo+0owyvPvLBTUEUOMP5r6T8/Mzn+rY58E4R5nQp/SdR1NUsS8K6Mvq8
 jURDOB9v9XfWGpv2aASsJikr8BGTEPiZSXFqIAIf+yLL0gwMlLThwY1sJIw5kIlHnmQZ
 UMf1SocBFyeLkpBt7Sp9ANrU38puzr+mF6NbFojmYahi28aqe/38TRD6aYMrgDgR2t8S
 C4s72hdsbyTE7NWUUdu2HF0A2huD93xeFrm/pgeszeVDMAGIVPfsrtD6+BYGGgBEgGX1
 zlAwjYq0UL0Pb3Nf+oAM1dwDeImoI4oo6CJi01rYkKL4n6VKa8z3gqi5IkElohc4SS1j
 Zvig==
X-Gm-Message-State: AOJu0YxtTi+2CzuN0MEAFkJGbHqzjEGhSItmoMHAYYP59n5B2k3AWSkx
 l3/g5fs3lnpU+OxD4nQSX/68g/EyRbTrwSLTHiTWUTAz7I+BC8aSZ7MrKrQ5HBOXmPh099qLcOs
 D6vOapv4fdA==
X-Gm-Gg: ASbGncvxz0zFUV3JroGu2z6lGq/iyn+fVsLQC9+lbDOeEwG4P2GaOm7XkWEhIUqogOI
 +fy3M/D8/k1oz9AsnxfaJPDUwnlEPTd9dJkA+Vp1oVbBBeAkN6ycMDUkFjJbutwwekPy1c2ewye
 N6hl1lQZAxXlf5nSIuqR02C1KdogU0aJgFRlCRfq9MN6hUbEXG0LjmgAdMx5wcoXpx2Ke2GIelX
 31F61tVtFXeTkf0EBYseUGzJOyT5ZhceMpvI8Q5IG+e8Tin2WyxKsytBQqrHn7WMnhjAerYe+Np
 pYfP+2qA5GHZ8yudG3JJB1IZfpv3+VVpHZ6i9bYssBVdcwXYTloxk0K0iAYKAcRjoQnBFjGfe0N
 v+edPqrSXgZB+NktVb3azU6Av9jjJxsloDrcsOqc9MVER+PhwOQMFMuHxftiU9AzhlXZbtd5T0b
 v7mH3n6l8DBBTgGjVVbfoQLBPd+6MgO6vw7I5w09lR04N7wg==
X-Google-Smtp-Source: AGHT+IE1lNrW5WbOu1ARGc1UeLEaXA/WcJQB5xhoVmnR226MA35wVm0FG0M1jLWOAI+KbxRfMwOy6Q==
X-Received: by 2002:a05:600c:408a:b0:46d:38c4:1ac9 with SMTP id
 5b1f17b1804b1-46e68ba134bmr48503805e9.2.1759562027327; 
 Sat, 04 Oct 2025 00:13:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723432c9sm61062925e9.1.2025.10.04.00.13.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/41] system/memory: Factor address_space_is_io() out
Date: Sat,  4 Oct 2025 09:12:34 +0200
Message-ID: <20251004071307.37521-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Factor address_space_is_io() out of cpu_physical_memory_is_io().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-3-philmd@linaro.org>
---
 include/system/memory.h |  9 +++++++++
 system/physmem.c        | 21 ++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index aa85fc27a10..1b2b0e5ce1e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -3029,6 +3029,15 @@ static inline MemoryRegion *address_space_translate(AddressSpace *as,
 bool address_space_access_valid(AddressSpace *as, hwaddr addr, hwaddr len,
                                 bool is_write, MemTxAttrs attrs);
 
+/**
+ * address_space_is_io: check whether an guest physical addresses
+ *                      whithin an address space is I/O memory.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ */
+bool address_space_is_io(AddressSpace *as, hwaddr addr);
+
 /* address_space_map: map a physical memory region into a host virtual address
  *
  * May map a subset of the requested range, given by and returned in @plen.
diff --git a/system/physmem.c b/system/physmem.c
index 225ab817883..c2829ab407a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3358,6 +3358,17 @@ bool address_space_access_valid(AddressSpace *as, hwaddr addr,
     return flatview_access_valid(fv, addr, len, is_write, attrs);
 }
 
+bool address_space_is_io(AddressSpace *as, hwaddr addr)
+{
+    MemoryRegion *mr;
+
+    RCU_READ_LOCK_GUARD();
+    mr = address_space_translate(as, addr, &addr, NULL, false,
+                                 MEMTXATTRS_UNSPECIFIED);
+
+    return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
+}
+
 static hwaddr
 flatview_extend_translation(FlatView *fv, hwaddr addr,
                             hwaddr target_len,
@@ -3754,15 +3765,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
 
 bool cpu_physical_memory_is_io(hwaddr phys_addr)
 {
-    MemoryRegion*mr;
-    hwaddr l = 1;
-
-    RCU_READ_LOCK_GUARD();
-    mr = address_space_translate(&address_space_memory,
-                                 phys_addr, &phys_addr, &l, false,
-                                 MEMTXATTRS_UNSPECIFIED);
-
-    return !(memory_region_is_ram(mr) || memory_region_is_romd(mr));
+    return address_space_is_io(&address_space_memory, phys_addr);
 }
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
-- 
2.51.0


