Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F10CD8C93
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVx4P-00062v-9C; Sat, 06 Jun 2026 15:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4O-00062j-Dj
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:36 -0400
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4M-00014Y-CV
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:36 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id AB3511D0009D;
 Sat,  6 Jun 2026 15:52:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Sat, 06 Jun 2026 15:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780775553; x=
 1780861953; bh=eYcvw03LK/lQ530qh+6y+nOv2u4ZT1Ir+87Ge2U2nh0=; b=U
 iORG0gtCGiT44uF8hYMB8UZdFatWVA3CY+5GFeZVPQm1EwxwBo+8gLqrcnHkcxt7
 jhUsw9xHsIOu0wO3xxO9TEMv3aZ6SnLDTKR8sJ1NNURbtJYyQju0fU1AIwuEAiXl
 UyqBcRbLgdnzqm4dEgAHGEIWeJOzRrwWoM4bc8lXqc05n+20VtuYAxAVxOlCPJ4v
 X+pN8A28b34EYkIVZa4//2in1pa04mK5KlVgfxD7S2AlrISrT4hKGmLboqBnZ8Jd
 QX8+m8Bmp+33FrHnEUDh4tr2seWwizzH/AORr+xPsZ5/uaLT8ls+5LdlbcQ40Qpr
 wsiN3wjTYmkJu+8j1w8Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780775553; x=1780861953; bh=e
 Ycvw03LK/lQ530qh+6y+nOv2u4ZT1Ir+87Ge2U2nh0=; b=I2SyQNeMVf0mSEOx/
 Iyl+PlAWVkJ3VGz9FdvKLtkVRmEmuxYpjOQG+PVjTJ/XQ7euIOyQXqtJvHqNeS30
 Y2nAh6boLTlhPlqAlI7K4dkFJrmT5UZMORtVeYiZmW56c7vgABDGM089vkXxCCuJ
 luc8QDy12swDas7pnM/x7RZoiwHMxo+r0vbbHw3RAn7ww+x885GPzFJv6DJtzycE
 zxLeMf8TC4mdFWrs2lQuciuQJLv4OSWpY7z8LBZn4jH0vS3beY67p+txpTP4QIa2
 h7nP+K5NkwzfMWsyimwaTpZeGawZa/Fywocg176qTzGgcDJDv9/vt5BWHaHeYhzW
 r6Ppw==
X-ME-Sender: <xms:gXokanvGMu5zUq-cMrwqOjFitWZICO8K0JuVYG5qYN9ktL8JA7HDuQ>
 <xme:gXokav77Jl9CHn0Db788j7PQgkX4qTkCUVu2oLIBZNIdDaV7SlG1eoiLW7JPDIgmb
 ad6MYCva7umBaUB06JRhC7GUB3bA95Dp02pan3B5ta6cQfNuVzPui3t>
X-ME-Received: <xmr:gXokaoKHpVDIwF2xGqbQMT3ZSDMjR03_X1jyO0mX0Rmypz80GAOEsi5stYvH>
X-ME-Proxy-Cause: dmFkZTF5V5TJt4YyOidEvSaeu/MRla4xP+DmdZQhB39MOi6suQo+ewwhopiobLPZpZFZya
 cAlJGIfDtnd9YI9euUev0/BPlhx7gFnO282gf6qihxTXQ9XGsNSFgetoCcqBrBvyjHrANh
 atTdGgjKUldYBX7wk7l0Cl09WJIHvldYLH4ZomEKYEpVZT82+Oh5snshv7XK6+9Sb5cWbw
 e84vQB5olzLLZrdcgzNge+k12PyvF6W544E61zazKBZo950akvs+WrgTOdnqD9gQaa29eu
 Mvbl6jhgYAGUnVDqLD0fWkRRImSA3/gMsTXu4gQwDYtEjGvTqg8SUjhCR0pAYP3BvhiEY3
 2ff+gqafSfrK7PvDojuhkOSRkNloJGUd1HukQRK20VHhxNW0M18RqcTlqfapLbLvfUeMLA
 Wl5w0pHHNUwa9r0zguX9eZQEvW8biArySMzCEGIirb/FnwAFAba9GT7f4HlXTsYU8PdXVN
 PlZ5L62FBe+d7d1hKQdNiNvcqZI9KaLApnjQDVsim+IKTI9scSPpbmKQd//yd28BH2M/Dd
 6WEyw4n27UVU/6bKF3O3DTEu5HCMc48SKexUQGisGCgtF6aeiirKmQxl+QDDyN5s0lI6FX
 tKdHk5RrZPTeBkDfmbywrT9167CQ9OYY5pJVecDG8aKpK4QU123OJmLg0kqw
X-ME-Proxy: <xmx:gXokav4B3J5FklWtyafOYmg6mWpo5QoVItCj8Lwqdtk1lmHnxgNGGQ>
 <xmx:gXokaryIANKojmWrjN72T3hUEqZcQ_KNGwwfgoRsRDwupSqnAtWQJQ>
 <xmx:gXokajah9ASZjEx8r5vsvhkHeWHnsmlKAHAv784qdewgpv_1iW_iYg>
 <xmx:gXokatQxmsRGQoMZFGKfjfUC-FoPmiXWrKBPYl-4yKcysqpXtLrvjw>
 <xmx:gXokask6Pefeg7zHHuzg8VhJzRjF7xcZpuIJ8p-VIf3fImNWqy4kKO2G>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 15:52:33 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 7ab2d1ca;
 Sat, 6 Jun 2026 19:52:30 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 4/7] ati-vga: Implement CCE mode registers for r128
Date: Sat,  6 Jun 2026 15:52:13 -0400
Message-ID: <20260606195216.2524314-5-chad@jablonski.xyz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606195216.2524314-1-chad@jablonski.xyz>
References: <20260606195216.2524314-1-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The PM4_BUFFER_CNTL register is used to set up the CCE FIFO for r128.
These are straightforward reads and writes. Future CCE patches make use of
this state.

The PM4_MICRO_CNTL register has a single flag that is used by drivers to
enable processing of CCE commands from the CCE FIFO. Reverse engineering
uncovered additional debug fields, many of which have an unclear purpose.
They have been omitted for now but could be added if needed.

These registers are not covered by available register references. They
are implemented based on their use in Linux 6.2
(drivers/gpu/drm/r128/r128_cce.c).

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 16 ++++++++++++++++
 hw/display/ati_int.h  |  6 ++++++
 hw/display/ati_regs.h | 14 ++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 73fd5e7d23..7724be863f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -299,6 +299,14 @@ static bool ati_r128_mm_read(ATIVGAState *s, hwaddr addr, unsigned int size,
     case DEFAULT_OFFSET:
         *val = s->regs.default_offset;
         break;
+    case PM4_BUFFER_CNTL:
+        *val = ((s->cce.buffer_mode & 0xf) << 28) |
+               (s->cce.no_update << 27) |
+               (s->cce.buffer_size_l2qw & 0x7ffffff);
+        break;
+    case PM4_MICRO_CNTL:
+        *val = s->cce.freerun ? PM4_MICRO_FREERUN : 0;
+        break;
     default:
         return false;
     }
@@ -682,6 +690,14 @@ static bool ati_r128_reg_write(ATIVGAState *s, hwaddr addr, uint64_t data,
         s->regs.default_pitch = data & 0x3fff;
         s->regs.default_tile = (data >> 16) & 1;
         break;
+    case PM4_BUFFER_CNTL:
+        s->cce.buffer_size_l2qw = data & 0x7ffffff;
+        s->cce.no_update = (data >> 27) & 1;
+        s->cce.buffer_mode = (data >> 28) & 0xf;
+        break;
+    case PM4_MICRO_CNTL:
+        s->cce.freerun = !!(data & PM4_MICRO_FREERUN);
+        break;
     default:
         return false;
     }
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index eae3e89617..9259373733 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -113,6 +113,12 @@ typedef struct ATIMicrocodeState {
 
 typedef struct ATICCEState {
     ATIMicrocodeState microcode;
+    /* MicroCntl */
+    bool freerun;
+    /* BufferCntl */
+    uint32_t buffer_size_l2qw;
+    bool no_update;
+    uint8_t buffer_mode;
 } ATICCEState;
 
 struct ATIVGAState {
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index b813fa119e..6591c6587f 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -387,7 +387,21 @@
 #define PC_BUSY                                 0x80000000
 
 #define BUS_MASTER_DIS                          0x00000040
+
+/* PM4_BUFFER_CNTL buffer mode bit constants */
 #define PM4_BUFFER_CNTL_NONPM4                  0x00000000
+#define PM4_BUFFER_CNTL_192PIO                  0x00000001
+#define PM4_BUFFER_CNTL_192BM                   0x00000002
+#define PM4_BUFFER_CNTL_128PIO_64INDBM          0x00000003
+#define PM4_BUFFER_CNTL_128BM_64INDBM           0x00000004
+#define PM4_BUFFER_CNTL_64PIO_128INDBM          0x00000005
+#define PM4_BUFFER_CNTL_64BM_128INDBM           0x00000006
+#define PM4_BUFFER_CNTL_64PIO_64VCBM_64INDBM    0x00000007
+#define PM4_BUFFER_CNTL_64BM_64VCBM_64INDBM     0x00000008
+#define PM4_BUFFER_CNTL_64PIO_64VCPIO_64INPIO   0x0000000f
+
+/* PM4_MICRO_CNTL bit constants */
+#define PM4_MICRO_FREERUN                       0x40000000
 
 /* DP_DATATYPE bit constants */
 #define DST_8BPP                                0x00000002
-- 
2.53.0


