Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E0CCFD629
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTHo-0001Sr-U2; Wed, 07 Jan 2026 08:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHh-00016i-KL
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:11 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHf-0008Rs-AQ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:09 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so6358775e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791345; x=1768396145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5YNVHn+fEcYtVEEvGoIpN+2XTdoPVL51JCAEL4vRnE=;
 b=D2UqHxGPX+bSObcAntW5HsAdsFYNZ06ujG3DmrIz3NhjPxVb/NVX7v/fGkI0wZ7llW
 5KzUb3aBbbPEOM/IoMtvTt3L4SRFAnPk02JsF9NDyZkoZ1YfApWS6WM0gnnqPRjWHY0d
 a5FI8arW7lhn/pssOa5XmOMzQHoi+VgeuVeMDf4zcSjSs/UBwzZcBpL9i+/b8ZVQAT/V
 Duo48JLQ5zoKTobumvDL1reCYbULDtSeFOPrmr42tlJTggSsQQlouJN3lM58nATyAqFJ
 2DO5IHmj7XGw2Qpo1oHYE0MwUBL7XVtTa8s/9gjjQ50xd9OW/YZTTWPYd0YMX/5bH7LP
 E2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791345; x=1768396145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i5YNVHn+fEcYtVEEvGoIpN+2XTdoPVL51JCAEL4vRnE=;
 b=n1eU+TRAq9MaxVyO51JFja/sv8DaxLgKqQxFkZki7urkiVijVxKKPI+8iIirV2R+dS
 Q8a/LBD5LuTTk2u0MnugbFjNxyeqYcs9h783Jxk3L9Ga976shO9QAfX6ZMuOx8gOTSoo
 zDnI7jgjBExQIwJ6kPchgPpOZ6mIkh1r9yIGrsO4fsyHzPNU1r3RdWgbGMAzpArvB7mx
 O1YcEMFbxZQFzmr1EtUK2aGU73QjSI0gME2wLDWNJ9dYaC+aN6+swYo1Iq4nXAKjKpq4
 6yjmeS3U7vJ35hFoXI/AzPaCJDuPyw1znX0r4I67N6FUzDQIGF5wDr9s+ciaxmto/Mpd
 Ug5w==
X-Gm-Message-State: AOJu0YzNLAeSvO5hf7qJFWTXna/NIcijnnmll79r7d2FjFrCYffCuJTb
 grEAyebVnkaG2UdnL8wQsllMbO41/SfkTkZhSAdtm+wIR7Q6UDITsBo1phTQsG6bOp6XhaNWaKl
 jB1gvW8Q=
X-Gm-Gg: AY/fxX6b6JI6qO66JlbOU5Q2kJTn8rwAZjpKi7JK5a6rkdkc7tZVlqEHsuQQPvH4DgD
 Oy2QrajtBeODWKJpyN6CoN0dcVDjlpZu7zl32ry3vMxgC1ReGjRea4eSfI8fxDRs+fK/ehwbEQJ
 aIsup+pZuxSDa+vrQ991gzoi82PyomklApQariFOT/270AIjDOiXXKIUPZwu87YaIVmuAMBGRCK
 VCc/UzToNGTrMYq5ox3DDmWC+6oBGRDxgdgiL0FYb4Nn10VgicTOUzNZOqOslgfoj/eRIYQM2JU
 4gj2Wj6IrsKSW4QcNixaLp+InGmppNCaJLFdVuGneh1inm+5gHkYVgweIRwbgajVYaVG+9XwmHa
 W17vMY7pw+HFvdNChc35B/OUKyICT7v9EG3RG36a16IfCoBSVb+JB228mrt/TaAca25Vdjjfqgx
 a5APcEjJban90BaBF5Q/9iOilGpOogrK8gER/+BKeI2NXr1fhoye8VJAbfgWDV
X-Google-Smtp-Source: AGHT+IEtQQD2aRCIInNws4ZiwB2fokk3z9xBU96stolcOMN1Rve7mHcCfP7/bvJlrOVb9N8bF/oKjw==
X-Received: by 2002:a05:600c:43c5:b0:477:a53c:8ca1 with SMTP id
 5b1f17b1804b1-47d845536f2mr26145145e9.14.1767791345161; 
 Wed, 07 Jan 2026 05:09:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6f0e15sm92747725e9.10.2026.01.07.05.09.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:09:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 08/18] target/s390x: Use hwaddr in mmu_real2abs()
Date: Wed,  7 Jan 2026 14:07:56 +0100
Message-ID: <20260107130807.69870-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On S/390, absolute addresses are physical ones.

Since mmu_real2abs() is defined in mmu_helper.c, move
its prototype declaration below the 'mmu_helper.c' comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h | 5 +++--
 target/s390x/mmu_helper.c     | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a4b54dc441c..dfc95702c51 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -10,6 +10,7 @@
 #ifndef S390X_INTERNAL_H
 #define S390X_INTERNAL_H
 
+#include "exec/hwaddr.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
 
@@ -367,13 +368,13 @@ void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 
 
 /* mem_helper.c */
-target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra);
 
 
 /* mmu_helper.c */
-bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
+hwaddr mmu_real2abs(CPUS390XState *env, hwaddr raddr);
+bool mmu_absolute_addr_valid(hwaddr addr, bool is_write);
 /* Special access mode only valid for mmu_translate() */
 #define MMU_S390_LRA        -1
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index ccb53e99ebd..b73d902b05a 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -86,7 +86,7 @@ static bool lowprot_enabled(const CPUS390XState *env, uint64_t asc)
  * Translate real address to absolute (= physical)
  * address by taking care of the prefix mapping.
  */
-target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr)
+hwaddr mmu_real2abs(CPUS390XState *env, hwaddr raddr)
 {
     if (raddr < 0x2000) {
         return raddr + env->psa;    /* Map the lowcore. */
@@ -96,7 +96,7 @@ target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr)
     return raddr;
 }
 
-bool mmu_absolute_addr_valid(target_ulong addr, bool is_write)
+bool mmu_absolute_addr_valid(hwaddr addr, bool is_write)
 {
     return address_space_access_valid(&address_space_memory,
                                       addr & TARGET_PAGE_MASK,
-- 
2.52.0


