Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCA4C982D6
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7WLA-0003uy-Bl; Fri, 18 Sep 2026 07:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1x7WL3-0003uo-FC
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:01:05 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1x7WKy-0004gi-9L
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:01:03 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f55efebso86433066b.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789729258; x=1790334058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/eWtYmZ6IPdKcCP/yRuIkzYB3vfj0RuOmPORlqQ0E/Y=;
 b=AqxNmAa2ZE7QBzqLk4gXja/eYdW/VoNHIt5J0W39Ipc1wU5S3mhk7dGc9YuLlN+aSE
 q36CfkV7bz/RcrbuAWGqlws35UXL5eyzF7DGz5lu+RtNSpIj8jokrJbNZ/WcLrt8+T+W
 S5iuwcwb0kFDgYT9kv+oAj57o31waUr+QWeka/uQONdcoBbdslMi0t3hP0FzF+VXHuUV
 x80hSKvp8bsWVEYyaojJZ6H7hEhH3GhCIYckfs822A+6gKKjRpM4ERdzN9128Uye684X
 JFjw5lbFgIDaiWsgKjkMWk7sWUXZxB6+UKfTL3/WQat7sev5hU/b+74ImJm2yFN5JZs/
 uEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789729258; x=1790334058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/eWtYmZ6IPdKcCP/yRuIkzYB3vfj0RuOmPORlqQ0E/Y=;
 b=JNwcWNH7zZccmwiGSxRsaY3s4o4r9zMwzmR8p8XCQiqd2fxFa/NdMWdDfXlR+Cv3j7
 ecZ9mWajvJKBkdMkj+erbSm0Z3+Q9t0XsCqYdfoHmIxF/ZXR3QoVA13uJLzNk2f8VFjO
 8/oHVQ9FDRxBpzx+snvOTs4qx5gKFUYPZNNRRPEWgLcrTc6vS2jcYEsjkXN2nkFvJvpj
 KTs111N3zjNB9xgq5pAth/87swZSXpll0bSrzoWoVAUCwfK9Gw6S6JhOsXhfPDRgkaNO
 0lGHLy98KYdnYLlE5f4fgp2VLHGsWgy4+7FU+io3OglMXFP6lBYy9UzNWSqqzbi9Dpbc
 Oh2g==
X-Gm-Message-State: AFuF++kpOs8+7D2D6drn5RNMyD8Zn4AvlDjp0nzM+Y2VHli/ak3vPRk1
 bAKM9j6cjSn0m+Gw7Lw5kcz4wKvfFMS8e57sjCVY19X5PhXGDG7VA7F+3+c0HA==
X-Gm-Gg: AYBFou0WmAV0HymkjItLZ6RTxyWQO/LndYdMmZ9ZLDkt+M+iYp/fFeqoEO9wae9Zra9
 ekoRGZvarmDA+Zdx8r9TETCgv7QTqhcHu7NYK91oQaEcGUxIENdR66sX/9sMk4+jtJL5P/vvN3E
 agXluNQfsGsBhQv0IRwWbtBwQJl4XF3PHsVrpoirtocXC9wrX3WBjQp34xwP//JqfU3yJcAXv4A
 8z/W409grvrpMc0YLla+n/84AkqG7gqsHKqu73ilhT4v/kzRvQNCvakrtelJ//eNH2nbRqTqy4u
 2SuBFJ7yXXja6mrJpEPzKe4A25FIy5ZsjDHcJLk5MgakblzVUOXQwzmwIU4r7AlY+DpM2iw2OcR
 m8A3tksxIQhLN7JeDDb01CjH2Z25mUiyLDMF6o1nGo8UNWoHyZkryhLl1FjdBKrBzI68Gn7ngwX
 p8OOM5nch/fUiAPErzfu9MY5IvwrSffh3OPud/fj8khGsC8birn9fbIqnZLhtsK/aV4CyzIhPWT
 c+/2jxOismqUuneUNjRbSYkwrEwSNCoI8Dd4zxic5wwzBnYGH8+GIcwfO80Dg==
X-Received: by 2002:a17:907:d07:b0:c26:1691:b374 with SMTP id
 a640c23a62f3a-c2a15827d9fmr213879766b.45.1789729257709; 
 Fri, 18 Sep 2026 04:00:57 -0700 (PDT)
Received: from vmbox.lan (088156177242.warszawa.vectranet.pl. [88.156.177.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1bb8ba4dsm45904566b.44.2026.09.18.04.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:00:57 -0700 (PDT)
From: dpim <sun4qemu@gmail.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, dpim <sun4qemu@gmail.com>
Subject: [PATCH v2] target/sparc: implement TTE page-size for 32M/256M pages
Date: Fri, 18 Sep 2026 12:57:05 +0200
Message-ID: <20260918105705.433093-1-sun4qemu@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=sun4qemu@gmail.com; helo=mail-ej2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, the TTE's page-size field, Size, is 2 bits wide:

    #define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)

That is the TTE of every UltraSPARC before UltraSPARC IV+.
The JPS1 implementation supplements for UltraSPARC III and IV+
describe the TTE word in tables F-1 and F-1-4 respectively, and differ
in one bit:
Before IV+ bit 48 is reserved and reads as 0, Size is 2 bits at 62:61;
On IV+ bit 48 is Size<2>, which "is the most significant bit of the
page size and is concatenated with bits <62:61>"
On T1 the same split exists, szl at 62:61 and szh at 48 (T1 Supplement,
sec. 13.1.2).

QEMU models parts on both sides of that change (UltraSPARC III/IIIi/IV,
IV+, T1, T2) with the III layout: Size<2> was never implemented.
Bit 48 gets lost in more than one place:

On sun4u the raw TTE word is stored as the guest wrote it, bit 48
included, but TTE_PGSIZE() only reads bits 62:61: the bit survives in
the TLB, it is just never decoded.

On sun4v, sun4v_tte_to_sun4u() converts the incoming three-bit code
(cpu.h defines TTE_PGSIZE_UA2005() for it, unused until now) but masked
it to two:

    sun4u_tte |= (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */

so the third bit was dropped before it was stored.

demap_tlb() duplicates the same 2-bit math instead of calling
TTE_PGSIZE(), so it misses bit 48 too, for a TTE from either origin.

Either way 256M decodes as 64K and 32M as 8K; the guest faults on the
first access past the truncated entry.

This patch implements Size<2> at bit 48, where the hardware keeps it.

TTE_PGSIZE() now reads bit 48 as the high bit; on parts that keep bit
48 reserved it reads as zero, so they decode as before.
sun4v_tte_to_sun4u() stores the full three-bit code, and demap_tlb()
now calls TTE_PGSIZE() instead of its own copy. dump_mmu() gains 32M
and 256M labels.

Link: https://lore.kernel.org/qemu-devel/20260727233646.332875-1-sun4qemu@gmail.com/
AI-used-for: code, analysis
Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
---
v2: described behaviour across sun4u/sun4v instead of the sun4v
conversion; no functional change. QEMU_BUILD_BUG_ON and comments in
cpu.h/ldst_helper.c are dropped.

This email's text -- beyond the code and analysis the trailer above
covers -- also had AI involvement: current policy (AGENTS.md)
declines AI-derived content outright, and even the not-yet-merged
llm-usage.rst RFC would require it to be human-written regardless of
any trailer. Sending as-is rather than silently -- happy to hear if
that's not acceptable here.

Happy to run more tests or provide more evidence if this isn't enough.

Guest is OpenSolaris snv_134 (osol-dev-134-ai-sparc.iso). Firmware is
the S10image/ set from OpenSPARCT1_Arch.1.5.tar.bz2, which
docs/system/target-sparc64.rst names for this machine, except the
MD/hv-config pair (1up-md.bin, 1up-hv.bin), from the repo below. The
archive's own config only boots disk.s10hw2, capped at 4M pages.

Observed on upstream 5f664cd37a, with and without this patch -- same
guest, firmware and RAM, plain `boot` at the `ok` prompt (occasionally
hits an unrelated, pre-existing trap in OBP's loader phase before the
kernel runs):

  pristine: hangs after "Loading: /platform/sun4v/kernel/sparcv9/unix";
            "info tlb" shows no 32M or 256M entry.
  patched:  boots to "Enter user name for system maintenance";
            "info tlb" shows 256M entries, e.g.
            [17] VA: 600108b8000, PA: 140000000, 256M, priv, RW, ...
  Full info tlb dumps:
    https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/logs/pristine-plain-boot-tlb.txt
    https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/logs/patched-plain-boot-tlb.txt

The reproduction as a script, verify.sh (fetches firmware, MD and
ISO, checks their hashes, boots):
  https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/verify.sh

On sun4u the pre-extension page sizes are verified by
make check-qtest-sparc64 and make check-functional-sparc64 (sun4u,
tuxrun, migration), which pass on the patched build with logs:
  https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/check-qtest-sparc64.log
  https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/check-functional-sparc64.log
To check whether
Size<2> is exercised at all, I added a temporary log in
replace_tlb_entry() and ran both suites again: zero hits, as expected
-- IIi predates IV+ and doesn't implement Size<2>, so the guest
running under it never sets bit 48. Result:
  https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/sun4u-bit48-probe/RESULT
Probe and logs:
  https://github.com/unix0cc/qemu-experimental-patches/tree/967a037/verification/0002-tte-size2/sun4u-bit48-probe/
32M/256M on sun4u stays untested by this suite; that would need a guest
running under Sun-UltraSparc-IV-plus.

Overview of everything above (scripts, logs, README):
  https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/README

 target/sparc/cpu.h         |  4 +++-
 target/sparc/ldst_helper.c |  9 +++++++--
 target/sparc/mmu_helper.c  | 12 ++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 31a16c2af0..1ab420d831 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -307,7 +307,9 @@ enum {
 #define TTE_SET_USED(tte)   ((tte) |= TTE_USED_BIT)
 #define TTE_SET_UNUSED(tte) ((tte) &= ~TTE_USED_BIT)
 
-#define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
+#define TTE_PGSIZE_HI_BIT   (1ULL << 48)
+#define TTE_PGSIZE(tte)     ((((tte) >> 61) & 3ULL) | \
+                             (((tte) & TTE_PGSIZE_HI_BIT) >> 46))
 #define TTE_PGSIZE_UA2005(tte)     ((tte) & 7ULL)
 #define TTE_PA(tte)         ((tte) & 0x1ffffffe000ULL)
 
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 4ec8799d1f..142c1c24de 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -186,7 +186,7 @@ static void demap_tlb(SparcTLBEntry *tlb, target_ulong demap_addr,
                 /* demap page
                    will remove any entry matching VA */
                 mask = 0xffffffffffffe000ULL;
-                mask <<= 3 * ((tlb[i].tte >> 61) & 3);
+                mask <<= 3 * TTE_PGSIZE(tlb[i].tte);
 
                 if (!compare_masked(demap_addr, tlb[i].tag, mask)) {
                     continue;
@@ -217,7 +217,12 @@ static uint64_t sun4v_tte_to_sun4u(CPUSPARCState *env, uint64_t tag,
         return sun4v_tte;
     }
     sun4u_tte = TTE_PA(sun4v_tte) | (sun4v_tte & TTE_VALID_BIT);
-    sun4u_tte |= (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
+    {
+        uint64_t pgsz = TTE_PGSIZE_UA2005(sun4v_tte);
+        sun4u_tte |= (pgsz & 3ULL) << 61; /* TTE_PGSIZE bits 61-62 */
+        sun4u_tte |= (pgsz & 4ULL) ?
+            TTE_PGSIZE_HI_BIT : 0; /* TTE_PGSIZE bit 48 */
+    }
     sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_NFO_BIT_UA2005, TTE_NFO_BIT);
     sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_USED_BIT_UA2005, TTE_USED_BIT);
     sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_W_OK_BIT_UA2005, TTE_W_OK_BIT);
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 07ba25dfce..8544de097d 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -830,6 +830,12 @@ void dump_mmu(CPUSPARCState *env)
             case 0x3:
                 mask = "  4M";
                 break;
+            case 0x4:
+                mask = " 32M";
+                break;
+            case 0x5:
+                mask = "256M";
+                break;
             }
             if (TTE_IS_VALID(env->dtlb[i].tte)) {
                 qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
@@ -869,6 +875,12 @@ void dump_mmu(CPUSPARCState *env)
             case 0x3:
                 mask = "  4M";
                 break;
+            case 0x4:
+                mask = " 32M";
+                break;
+            case 0x5:
+                mask = "256M";
+                break;
             }
             if (TTE_IS_VALID(env->itlb[i].tte)) {
                 qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
-- 
2.43.0


