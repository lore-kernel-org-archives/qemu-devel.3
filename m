Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A32CD8C88
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 19:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVx4R-00064W-Ht; Sat, 06 Jun 2026 15:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4P-000634-Jk
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:37 -0400
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wVx4N-00015f-73
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 15:52:37 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 6510F1D000C6;
 Sat,  6 Jun 2026 15:52:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sat, 06 Jun 2026 15:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780775554; x=
 1780861954; bh=JU47ckYMaVY5abiZQe68DY+qOGTl1E6dWVioYh90/9o=; b=y
 cWK5vZUkkiYjM8qFmW1EyFza3dO6DgP4R4Lu4IpulKm+kcYZL/lo3wZlpfXV5dWq
 YY+GiuHBpD+mFLL6KMWG9wADkmWMeflbXw3yxqmRAEZ51mVChUXl9DmZesW6gMka
 DeJ1f6sBuNlghdr4P7YWShqGQLm80FJIa99q2/69jzOuhyGqmCSFYzsVJiFk+0BR
 ZnvU+s99iOejgMMgToyXdcsOOKDriEm6t8A9oMnahRdf7vU1TQart2+vKjnVacJk
 vaQivklLfVz4b2siqdvTvVSyM9gkaFUhYyADPyu6ffAhkQJX2Tpq/aVLoxAcvyB/
 PzzwOIb8mdD+s1QR80ecg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780775554; x=1780861954; bh=J
 U47ckYMaVY5abiZQe68DY+qOGTl1E6dWVioYh90/9o=; b=IdRSR9I4zSj0G9E0K
 vM3PM4hRe0we/UoadBMG8zl5A18Y5DB3p1Af4wByxSqk4i0LNH8BUURtVBEKV7TH
 +VzXYOSdspnskIxvYLwIvtbhNG+IIC/KKUfc2etGohr2Xs3kHe431tCnePOgVnvP
 qeciMTJdvP7iVr5BO7SykWpaoO893NkdLiGvk1LdeqTAlWz2QJFT4kDQzJhkXvJZ
 wmckIZJ9WpZ9NlwRQwd7QWjA8fMXBMz5Vw7BwuJL69JSC5/mOXB8ZSZg7IZqs/nR
 ZezprPLQFkEZ5ZD++VKXKzLx7ks4qdZXPiiz36St+7LOKfWuh0CfveJ0Ev0HONTm
 bJv2g==
X-ME-Sender: <xms:gnokatw_W8ubv9270pFJlD-TsmISMGxTwC6UG1fWZ-sBE8-xsPV8xA>
 <xme:gnokakvQ2-lqWISu6oYyVcoXR-5rGzGOCwFk2NbZjUfmbjht1zOSVU04lYVQWQD5W
 P3PZSHsD7rYM8l0f1xM5WfePjBLysDIy_-UGfCKNeK04MpOPZk_HaVK>
X-ME-Received: <xmr:gnokaksaXVNVQHmChggx1-nW1YDMFW479aPUaRZOXrg_4PmCqYNV9lU60OF7>
X-ME-Proxy-Cause: dmFkZTFtS/DgiDRsmxLlnIdNQxSskzYRlZOMKhoKqJRpJHJkH5h0DOq+Yem8nNJpxA5+Rh
 Veu3XTibzWNFWpt3nC8cZB36Qz5px7qK8B4PQXVFbl0LiPm2Ns4p5kQNLEE7RZKUrANYeF
 Se8oMKKfIRkKHqDE/O6Ttv7RzzQOyuXONOuX55saMbOjPctNzM+X0PnEPmKV4kThJGTGI0
 vR5U7wh8mMmQaUWgAYOnG/UVKXqDATwI+qVNGRdMTtkh8pV8l/EzYDRiE6bGId8ElosW3H
 gOHOnBi2u6peFiWdr1BYvKzVGdaW+oSoEKN4XgRzgYqgG9SC3DSoDje+8Xjl+wBws3N4bI
 M56t0i4RC9NTMFJQvxJSdN+Ul7mvEupdjd/zYUlYLSg+7/lPZxP+EsE0Huk19v8Pt7uxJp
 ww6u2dW0UuXGhUuVZbYnTUxRO5R8S4V4k/Zof1xdzewuPPt5UNYv9QUZAmHlIIJM8iQGBo
 8V4icVk9ce5CQxjSWy6nvHR9sIrHQuECzhoC5QfHRGUMx218yq819iXKIfm6mA67afnOtE
 AbwIOexhgLJShtlZ3hricRh9XFSpIEBMgACmHgujgOttRhiAYHO+YU0EzzY5YSrdTCqulo
 cXzR0r6eYBdoutykbvp7H3sCeUBX0gc4dJgz4PZDnuJtL/Bhea72jekJxelg
X-ME-Proxy: <xmx:gnokapMXMlRnpbE5gBar1o9H_bLTmOlDR_lls3vML-jaXDtnkCYmWA>
 <xmx:gnokai2XZ3o7LJiNMeI8KFcB8D8wi1-qm4vGFPMXYMa3JahDdNR0XA>
 <xmx:gnokalNN-51nRVICtvJc53Giws4lRDYVoPP6IHuz_gyWVWQUHhHnjQ>
 <xmx:gnokai2Iz7s7Kz5wBIZSjAolU1odmj3cEr37b4CjXgv6rM47zhfAbw>
 <xmx:gnokai7L9gTiAprDeUc4QyUUKUeXy2-0P7INHEE-JWQMW5a7xx2pM-3W>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Jun 2026 15:52:33 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 5af95a9e;
 Sat, 6 Jun 2026 19:52:30 +0000 (UTC)
From: Chad Jablonski <chad@jablonski.xyz>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
	Chad Jablonski <chad@jablonski.xyz>
Subject: [PATCH v3 6/7] ati-vga: Disable GUI engine MMIO writes when CCE
 enabled (r128 only)
Date: Sat,  6 Jun 2026 15:52:15 -0400
Message-ID: <20260606195216.2524314-7-chad@jablonski.xyz>
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

When the CCE engine is enabled, real r128 hardware ignores any MMIO writes to
GUI registers (0x1400-0x1fff range). Writes made by the CCE engine are
not affected by this.

Testing on r100 shows that this behavior is specific to r128.

Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446) and
Radeon QY (RV100) (PCI 1002:5159).

Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
---
 hw/display/ati.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index e1ba64747b..582c646a3d 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1183,6 +1183,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     if (addr < CUR_OFFSET || addr > CUR_CLR1 || ATI_DEBUG_HW_CURSOR) {
         trace_ati_mm_write(size, addr, ati_reg_name(addr & ~3ULL), data);
     }
+    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF &&
+        s->cce.buffer_mode && addr >= 0x1400 && addr <= 0x1fff) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "ati_mm_write: wrote 0x%"PRIx64" to gui register "
+            "0x%"PRIx64" while cce engine enabled, ignored.\n",
+            data, addr);
+        return;
+    }
+
     switch (addr) {
     case MM_INDEX:
         s->regs.mm_index = data & ~3;
-- 
2.53.0


