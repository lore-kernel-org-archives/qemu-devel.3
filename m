Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC401CD8C88
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVx4Q-00063m-Lf; Sat, 06 Jun 2026 15:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4P-00063D-N9
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:37 -0400
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4N-00015K-6v
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:37 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 0AA251D00094;
 Sat,  6 Jun 2026 15:52:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sat, 06 Jun 2026 15:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780775553; x=
 1780861953; bh=nlSoiJFut4zlrPI04oIqyb4zXy0cP0gtHqD0d3Usq4Y=; b=y
 J43miqL+5733OYSlJ30xKIa9aQkv7D3YH++uUaVITJymf48WvbaAHuqbPSr//mMU
 M5vimsdjvoqn9N9m8AzedarZ7m29xTZq9umZXPSUovV+lMUkde062GTnSG6kvrwa
 b5enwYKRnQN3p3dMvgivjht7jJIOTu55pkSfSPYOdSCPg6keVBODJx0KVCI4nBTH
 8R1hJDkIBmgpWbXLHoAFb9kp4KWKeflHV+7YTuSnUy0b9l/ZWgDppY1IwtQk7ka8
 XcCgG67P4a0n5ZjB+W5YjHP/1XMiavZ2AY9Q+hqliEo2oNiT60CtPaS9X2ojN9HQ
 B8reB+USOoMN4v38zMvFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780775553; x=1780861953; bh=n
 lSoiJFut4zlrPI04oIqyb4zXy0cP0gtHqD0d3Usq4Y=; b=C+ehsztSMhO1cJnjB
 VzmFVeGUmV1G9lf/HN6EwiQtPZep8Ork2t7MbyoAtPTjchdESjpEynjxpg9H2hsT
 ojirxBR5tXgaX50ahEX1v4sEcw6F1sBLHMem+vN9Y5h1/zru8A+bwZa3RzKWjFyR
 Vq0gysO5pCVhfP4ReqcTS4ENBSwPPGj/2UoAyPn9eH+a+bJ15wJUOZ3UY+W//Thg
 SkiW3fJ7WKWIG0km8DeB1Q1YLypXCcvxfb/CoKKDwtBOqp1535Jl9GZSdFvW9NtK
 L/CcDI0Gnqif44/uhvYVUYKerBDAYHfB5EMxUX3S0dNCwn1cFQXqzVYvubWT0E1z
 kh7Ng==
X-ME-Sender: <xms:gXokap2FqR56LI8D2cDT59ZBwhr_e9HuISh4AbVbKBdt8u_HA21ZFQ>
 <xme:gXokanjpxmCZwBjHB8GNnKik2BJ9ZYbHa8JK6gdZpXh_putt7C-bMiQogtdkvD3qq
 qilW7SfhKnH29CrLfVYK-Wwc0orXRQR7jwGlb0rws-hCiKCWjRCLF4o>
X-ME-Received: <xmr:gXokanRAkWkvRRFpKciaHdMiw2lMD0rMWlpbSENkdf89Nzz4_dTIwbvtdaJP>
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
X-ME-Proxy: <xmx:gXokaggte15N79PAgcvKPKJ8s4O6Myzzw2hMnkttlK2I5RnPS0N_Fg>
 <xmx:gXokav7XqMK_IXjU1aHq-9lGPQGXWYQbG0Y4bhxf0OwVoncwO6KKag>
 <xmx:gXokalCsqwAxllRIyGn6Jx701ndrG7JpFiJ2hCr3miFN6IjJwF227Q>
 <xmx:gXokauZHey1QfYneVc82u0PW9_bqy2DIo1A7uuMfa21a4XNse_Ny_g>
 <xmx:gXokanPpixCFE9s5VKqP2wZ712I-gKG0tzPAmbzj2grux3gv7wEGG0QT>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 15:52:33 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 3f21faf4;
 Sat, 6 Jun 2026 19:52:30 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 5/7] ati-vga: Implement CCE mode registers for r100
Date: Sat,  6 Jun 2026 15:52:14 -0400
Message-ID: <20260606195216.2524314-6-chad@jablonski.xyz>
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

CCE setup for the r100 is simpler in that it defaults to freerun.
The mode just needs to be set via the CP_CSQ_CNTL register. Modes are
explicitly stated to be compatible with r128 by the M6 register
reference guide.

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c      | 8 ++++++++
 hw/display/ati_regs.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 7724be863f..e1ba64747b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -342,6 +342,9 @@ static bool ati_r100_mm_read(ATIVGAState *s, hwaddr addr, unsigned int size,
         *val |= s->regs.default_pitch << 16;
         *val |= s->regs.default_tile << 30;
         break;
+    case CP_CSQ_CNTL:
+        *val = s->cce.buffer_mode << 28;
+        break;
     default:
         return false;
     }
@@ -767,6 +770,9 @@ static bool ati_r100_reg_write(ATIVGAState *s, hwaddr addr, uint64_t data,
         s->regs.default_pitch = (data & 0x3fc00000) >> 16;
         s->regs.default_tile = data >> 30;
         break;
+    case CP_CSQ_CNTL:
+        s->cce.buffer_mode = (data >> 28) & 0xf;
+        break;
     default:
         return false;
     }
@@ -1318,6 +1324,8 @@ static void ati_vga_reset(DeviceState *dev)
     s->host_data.next = 0;
     s->host_data.row = 0;
     s->host_data.col = 0;
+    memset(&s->cce, 0, sizeof(s->cce));
+    s->cce.freerun = s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF ? 0 : 1;
 }
 
 static void ati_vga_exit(PCIDevice *dev)
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 6591c6587f..ab2b5b59b0 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -128,6 +128,7 @@
 #define PM4_IW_INDOFF                           0x0738
 #define PM4_IW_INDSIZE                          0x073c
 #define PM4_FPU_FPX0                            0x0740
+#define CP_CSQ_CNTL                             0x0740
 #define PM4_FPU_FPY0                            0x0744
 #define PM4_FPU_FPX1                            0x0748
 #define PM4_FPU_FPY1                            0x074c
-- 
2.53.0


