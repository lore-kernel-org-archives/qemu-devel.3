Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AF606A338
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J4xnyk0e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnai-0001qd-89; Tue, 24 Nov 2026 05:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnag-0001qE-EI
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:34 -0500
Received: from mail-pi2-x09.google.com ([2607:f8b0:4864:3a::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mdspan.github@gmail.com>)
 id 1xVnae-0004Xa-LZ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:17:34 -0500
Received: by mail-pi2-x09.google.com with SMTP id
 41be03b00d2f7-cdd9779aac8so743144a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795515451; x=1796120251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dd3Qh+cLFVuVabZEy0pFyjUo50S9bkDox3kUAgImQ64=;
 b=J4xnyk0e1q+0Mxw8RjchHYvmP6v4u/VL8RCdVAPmh9XV8tlI7N/Q9jmhtggdFmv3kC
 kQE0RTbRQs0CCDjk2FAGad02JGVA1Z8vdSPsWvr3tcrLbbQY6Lub5uMd2lWRAe47RYYM
 5TkliZFCE8xWHXb31GeUYAhIulMN5ztcx/BWkNIVHTpE63+nvip7jVT8Im27eE5ngHZC
 /wexlzdwolcJl5hySVeRSQ+S/pelEd+7xoskmLDxTl+oxIFvVPjUgabCSg66edU2foHI
 7bvQ1rIa7kJKKwTQCszLpYuINlp/MCXzk1KYvZ19Zo2CnzeDkLVgUmZKUQLm/WYV6IoP
 N9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515451; x=1796120251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dd3Qh+cLFVuVabZEy0pFyjUo50S9bkDox3kUAgImQ64=;
 b=LdxNlBuSMIm1zF7nfEl2O3col0QN2joEmC6Dcy20g2Dvy6UkgtOQRGSIPBBt1GTv13
 kdy2ZsegRqevplPbnZR8NwLhxJIHdJBevl02tex1XgUFdt86RdIWTz5G0xxHe9BBq5fh
 g9CzqIqy2B47FTo8OXPsXzgRKKxWUXCEyaNjgyuJLEVaFEKJKPcOFDcjdIbt+dwUeLmj
 T3EsKe2pSk9NtUMaIWIPXt4a22+hhdbrz0cYTd4C9vAm+oc4uy7U2mZtbGYrGHc3abeF
 uOa/e6ZL3gMl4t53eQd/rw67GLNX6uJocyvRgFQU5XkJuFL7fSR7fGCv18iyA7Ztoy0z
 EIGQ==
X-Gm-Message-State: APuU4Z+4Z8SXcDHVsF0mSu1NewRET14YVsVHj4lhCjA5qOJ1QmtjJr1a
 6Dh1HdGkYj3IbjGtueyVNeKiFPHu8H7tXNSf2dNbDFVdMJM/Le5SYWN1De/uiatetyY=
X-Gm-Gg: AZFdTZf+OyW467SFmoMXTKhIsIEe0hGkvxdD4Ft4X4ObUqWeKPvl9vD+r3Leb/6EUsP
 r+lVxbCishs+QcW+Og3TplUM6OJN9XMRn9bl0o0gOuI7IvOOU3ivAP1ye3Ew/FfA2uuuumuDgPN
 o988DRteFKvh3zs/UuAXObEWwZt1A45pQcp4Zt0USfUZPfsVJ7Yn490EDhGkXu15I6RRSbG2K3m
 hMKzeqByxNl4V6YO2D02T0wjGv7Q551UDciCx3kaCi0Uv3UWjlPTI+8DGB82UMvQmsUC85I6WoP
 bOVv6PNHcNQnpMx2mU9+iw0rtlQHjObcCNsvEPuIK7d/F0Hf7kS6Y6Hhh5QKVIJB2/OaozPfB68
 BTjjGOl0c38yATawVuqsz6c7JSDlPnsOoOeB8QkQJ1bAR3QWdZIpODGS9zZ5QpsN8oeQ1hY3iQ4
 pBKkfCHGxG6mPY6CKbDL8Nkg7jNp5h4Urqd7p6s5Mlw0jIzc2S+2F5GqJsRzpktnkhsFCkZuHgv
 Q42u97NvjvmvGuVtukIpkicF0ttG0irv19AYNsreYiebBPGtu8/ombDUudPh3RR63dEewebdx38
 wQKGxzQsqFA0d73NYyMGbYk0F+TJ/jYkGWjpx0pybrQPGv7Iy0++
X-Received: by 2002:a05:6a20:4304:b0:3e2:6ee4:a758 with SMTP id
 adf61e73a8af0-4014e651327mr15560522637.54.1795515450971; 
 Tue, 24 Nov 2026 02:17:30 -0800 (PST)
Received: from computer ([2604:3d09:98d:800:e939:4613:1d28:dfcc])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6cea748csm6627920a12.4.2026.11.24.02.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:17:30 -0800 (PST)
From: Tim <mdspan.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, zhao1.liu@intel.com,
 Tim <mdspan.github@gmail.com>
Subject: [PATCH v3 1/5] target/i386: mask the PML5 table address taken from CR3
Date: Tue, 24 Nov 2026 10:16:50 +0000
Message-ID: <20261124101655.2269531-2-mdspan.github@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124101655.2269531-1-mdspan.github@gmail.com>
References: <20261124101655.2269531-1-mdspan.github@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3a::9;
 envelope-from=mdspan.github@gmail.com; helo=mail-pi2-x09.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 5-level page walks in mmu_translate() and
x86_cpu_translate_for_debug() take the PML5 table address from CR3
with ~0xfff, which keeps CR3 bits 63:52.  The 4-level walks already
use PG_ADDRESS_MASK.  Use PG_ADDRESS_MASK for the 5-level walks as
well, so that CR3 control bits above the physical address width, such
as the LAM bits 61 and 62, do not become part of the table address.

Signed-off-by: Tim <mdspan.github@gmail.com>
---
 target/i386/helper.c                 | 2 +-
 target/i386/tcg/system/excp_helper.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index cb25018e..723e87fe 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -297,7 +297,7 @@ bool x86_cpu_translate_for_debug(CPUState *cs, vaddr addr,
             }
 
             if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
+                pml5e_addr = ((env->cr[3] & PG_ADDRESS_MASK) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 44be98a3..6c48ccbd 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -173,7 +173,8 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                 /*
                  * Page table level 5
                  */
-                pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
+                pte_addr = (in->cr3 & PG_ADDRESS_MASK) +
+                           (((addr >> 48) & 0x1ff) << 3);
                 if (!ptw_translate(&pte_trans, pte_addr)) {
                     return false;
                 }
-- 
2.47.3


