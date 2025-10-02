Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F27BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Euq-0007UG-Qa; Thu, 02 Oct 2025 04:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Euk-0007JY-NT
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EuR-0000zY-0Z
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:49 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so468544f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394597; x=1759999397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAgjr5yIgrIO789GqXuRF0t/EGl13bmDgqvJGL/31ds=;
 b=HN2tLbEdulBpFqpiNuxM6l3HWpI22DgC7izyWYytd57g0F5HGOFEz78u1qHk/QXaz9
 5vx2Li9tlMgu+chKWjOMHYLGAZnB46GIcwAh4/k1Hfaj2kmtarxQNJCVt8Pq9/Uui9Ke
 JLYoBperSMO4DjJSazmfq9PSwCO/W0n+U9dbTZkLGpiVShOXrJmU2owUzHPdCD2kSzEa
 NkMVOA2QuKPIUWGkAAqTyXCCIE/9dOkSe7QOJZQM9AezgRU9lw3Zu/Y9QKU4ra1HsRrW
 QytIeAEfu/5XhhmFyN7x24ZZEJvL0IvBMSxTKOjktVWZ4cWvHWOaigwtqq04Zrcz1SQ8
 SXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394597; x=1759999397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QAgjr5yIgrIO789GqXuRF0t/EGl13bmDgqvJGL/31ds=;
 b=czGdBoqD9Z/fj9juUPNuM7a1eCsOAbJT9RWc4egyW9yyn91U5YLHupbB7R7V+Prpjd
 6OmlLnFqOgFwRe5zfrhqI2rkwZ2PbhcuAyZVuEd2LHnjlYuu+mMRiDfnXWsQfMoZ62Lb
 V7vFTQV/P+to+NKUOlhovjk21rVi+dwDJ7eUzt1d6CuImMjndAhUWbjhYkn+86qq1uWB
 JrL5CTzlcrGZCS8KZXtsg2HY+j0jygj7Z4eJDvyaWlE36QnmVRdERz+Y/4xLHpjwzXdY
 fqRF9ZhyksIEc0zFSZBjN/jQxiX+pGEAs4U6twRDNwDY1EKZ0Wmi2dasPV4paUpA5Ta4
 HiPg==
X-Gm-Message-State: AOJu0YxkgE6gXsuZncL1Wjo/dfKbDXF4EJTIWMcnvRr5ed40EgZM4rlO
 dqmC5ak4qkfHIzuw4ZV8+W93C6nwhzh3LGPGPiWSveD5kQUcGXEk04qpwfYlt2IeDTy8GT95uBg
 PADjBLcN8RQ==
X-Gm-Gg: ASbGncvMr4LxSVW6QgTLGkC6juj7QS/XCBxgSzQmxu9ihtVhf/33AU7+j6+6EaTj3gM
 9QxoPHEkskXQSTONt4CpHSVHa2aE6aG+/6w6++DzGToRFDt6ZrYb1xztbpy5YDj4usQvNOUODTo
 5m7ooRjrY0hM24UL/P/bYjSv2ZKFAEPEbQtd1bpm7IBIr15uePd1SBfEvg//ruNZgu/ihUqph77
 J8p47c56keg/0gEh3B5uM1LpGGOefBx3ot4ZHJEr4YHTRBwK/M2NTXkjwPPxnvlMv6BilDyJqTj
 KvhmFA+ujZWA8EdfIt3HDTPoNUXiZ+naVhBQc7UsOP3ar++yec6gGX50LCOkO76DpDAPEk50+bn
 YE/tI+/bu8GzuhIo4GLnZs4/ptNI7nRCMUpKbc1W6UjN8A/CHeaGNfCg5WcZLzPtKwuqdEqY5B/
 khvFF9Sf0Fn75/daFtabu000XnUgjm8Q==
X-Google-Smtp-Source: AGHT+IF85XkLg0BRzQXNPalgqzyMpny7LwvkrLwLebNjcVy2x5/oJ5wUtocULaWC8zMsTAEaZEeQKw==
X-Received: by 2002:a05:6000:609:b0:3d7:2284:b20 with SMTP id
 ffacd0b85a97d-425577ecfe7mr4915156f8f.3.1759394597239; 
 Thu, 02 Oct 2025 01:43:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9762sm2651528f8f.38.2025.10.02.01.43.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:43:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 15/17] system/physmem: Remove legacy
 cpu_physical_memory_rw()
Date: Thu,  2 Oct 2025 10:42:00 +0200
Message-ID: <20251002084203.63899-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The legacy cpu_physical_memory_rw() method is no more used,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/loads-stores.rst            |  4 +---
 scripts/coccinelle/exec_rw_const.cocci | 10 ----------
 include/exec/cpu-common.h              |  2 --
 system/physmem.c                       |  7 -------
 4 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index f9b565da57a..c906c6509ee 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -460,10 +460,8 @@ For new code they are better avoided:
 
 ``cpu_physical_memory_write``
 
-``cpu_physical_memory_rw``
-
 Regexes for git grep:
- - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
+ - ``\<cpu_physical_memory_\(read\|write\)\>``
 
 ``cpu_memory_rw_debug``
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 35ab79e6d74..4c02c94e04e 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -21,13 +21,6 @@ expression E1, E2, E3, E4, E5;
 + address_space_rw(E1, E2, E3, E4, E5, true)
 |
 
-- cpu_physical_memory_rw(E1, E2, E3, 0)
-+ cpu_physical_memory_rw(E1, E2, E3, false)
-|
-- cpu_physical_memory_rw(E1, E2, E3, 1)
-+ cpu_physical_memory_rw(E1, E2, E3, true)
-|
-
 - cpu_physical_memory_map(E1, E2, 0)
 + cpu_physical_memory_map(E1, E2, false)
 |
@@ -81,9 +74,6 @@ type T;
 + address_space_write_rom(E1, E2, E3, E4, E5)
 |
 
-- cpu_physical_memory_rw(E1, (T *)(E2), E3, E4)
-+ cpu_physical_memory_rw(E1, E2, E3, E4)
-|
 - cpu_physical_memory_read(E1, (T *)(E2), E3)
 + cpu_physical_memory_read(E1, E2, E3)
 |
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6e8cb530f6e..910e1c2afb9 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -131,8 +131,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  */
 void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write);
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
 void *cpu_physical_memory_map(hwaddr addr,
diff --git a/system/physmem.c b/system/physmem.c
index 23932b63d77..0ff7349fbbf 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3181,13 +3181,6 @@ MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
     return error;
 }
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write)
-{
-    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
-                     buf, len, is_write);
-}
-
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
 {
     address_space_read(&address_space_memory, addr,
-- 
2.51.0


