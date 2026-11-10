Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544160A2635
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xAn+2LgU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQl9k-0004yu-Dq; Tue, 10 Nov 2026 07:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8j-0004Tl-VT
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:59 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQl8e-0006bw-Lo
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 07:39:51 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so18189885e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 04:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794314387; x=1794919187; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Kc4N9LhpSiJsL62rS5INfTOvk9Kzv8rZRKUiJyaoQA=;
 b=xAn+2LgUy5S0XmC4J1xYC1a661eshShbNoby0Am9ULIWiIfd4AMn2ImN+ydwO05f3Q
 WQPHp+PvuR/HXk/RXLdOQIDAmmj16Dfk6tUOXw57tlXdDlLajW6EmBfC3GD4d0Tjx56C
 8DVmhPbL5TyF6/IwbN3RznAj0Ltq2nBjG6SMOFKP+Dyk2HweKK1XJRQI5bTFk7O4gEl8
 MleHlZHUYr2VNMAjsrgenZ6m6+h6ykOTncPM8nqQhfnVx/wMENxAzHtgXOK39p4pF0EY
 Tle3/qshrmMHYVfs/njkTkRyPJA0El1g1EgtVx0zHzcQ8QZoLKN9XZ2WiE3ESXRiFPX9
 eLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794314387; x=1794919187;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/Kc4N9LhpSiJsL62rS5INfTOvk9Kzv8rZRKUiJyaoQA=;
 b=f/bebrEgt4xZ+IpqprIHZCc+CushCW03o7TKHeczFG9/fpattLY6GMsSAadtuN70/f
 plfijjRmrp14r1T7MY7fa5o4yN9XbpeP94ewoQv1J4ROo0PvmeWspNY5ycfZ3FC501oo
 xQa0jT8x83KNJYtAOlo6aJ7mzcJjrsj6z3hc1eSz3bENPR41fvcOwkJ4obIQWsFuCBkL
 orcP+9L5m5qJVi/3XSHcFM3zzuJkixymI2I7gWZUm/Cr+YO1YNPZi83qJZHmEUubPJXn
 vUNgbq5/o8TTXS9y1rreS695K8tTPC5M63dkMlXTxL8EBWqxnMOUBEemKDSDHOnlcp5y
 S+3g==
X-Gm-Message-State: APuU4Z+oLvb+P8jJsd3eOekWPLMmR7r9qmX9Des/4+u2ff1XZIa3OcUX
 fjeeZ3R2fSqy0/tIp2H2HbsWreD7NIUoLFrQ+6vW/CUx00Wy8oyXS7u1WfnO0d3XgHQ=
X-Gm-Gg: AYBFou1pkCU3HkoAu0iQDJIsEueP05TgYBgTxjLGwRZ442ZxeL2nusKPkMT5DWMW5Xc
 xC3NXlPrIuikYaMGECAU3oCuNO8ycXR4ppTseZxykU4JQHPq515cfedfsPWWHGWz3KNzvd7p9H7
 Uv6lSLKia1gbNmViishkAqQp+6/8NZmCZAsSoIi3u1/vdlnlUIS3I1H7/bng1ZuxXm5uOU9pE+f
 VKyHFLJiU+Pfiiy5zjsiim+iEOaI2mgfeI5tzhgGSyg4SN/OVe4Z/yZuTeg28bHaF9S+ChkcKFP
 mR5+hNr9PmTpiHKpgkSSc7Gpid9ZktEkKFJd97XPRUiG/GXU47neaWTbT54nPYda9md7Qygb6iP
 si3rUEOv12WXM80LyFZ1x1z4RdsuzL3YYHKq/cnV8uhD0XXJCwjDVbIKxaihLaiNr1qB7zySPJY
 O7i8E/xK46qEc1xH/uHuaTExh5ickXR6XMLnUDW0wvsZb2sL4i8fXFXUpoHcODPvKXFJdJjvhKD
 bX4aLC8a3tqViYQ2yfNx3L+r+IcRVq3f7lE4stVPVv2o8Te37X58EJZS+XiwfMyG9Fr4hWAKVM6
 CIALocTvPErs1j8QbmB4RgqfEHnuWGBqsUxjz78o/bbVSfpR8QV64HBxR76CZ4B2Y8K4bsFr3tF
 afAnc7c5JZyvQaTHumNts9UGA5nqf4yxGiOCXgcWPMfqU2jhh1voCG2y1/PyByAmaCeP0JGN4l8
 YxIo6IFohYe8glbCE+FH9+pUL22uvyrgpWWWIie70D4FkluNVJWwPgU6LLFChEdGpd
X-Received: by 2002:a05:600c:3486:b0:4a1:e250:b191 with SMTP id
 5b1f17b1804b1-4ba023418ddmr43263495e9.17.1794314387209; 
 Tue, 10 Nov 2026 04:39:47 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233e5d7sm47638475e9.1.2026.11.10.04.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:39:47 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 14:39:33 +0200
Subject: [PATCH v2 4/6] virtio-snd: don't allocate pcm_info zero-count buf
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v2-4-d5b654217676@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=yxp7iBS/l17Fu0c98HhLNb1LlykoROVGE/SlH6EzIk0=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8xCOeY4hRCxQL7HvEF10HTRyU+hU9+kaQ89r1
 Xy1RD/r0oKJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavMQjhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdAcVA/9FpnumXT2sm/Vf40+ilWIM+5oq2hNDek
 qSRGSB/u5S/jD2EjmToJEqDcPRG0+3FYSl+946DDhdUt2csKoiksafvLQBs53Ir3AsC6eSmWHQu
 qoaNutjodLZch2iFYPcH+Vm/lfFNsksyo8kweLJgXqOBbvrRWm0J7Wnc3gyj5bAbPaM7dk1uplz
 T2Z2dK3Y8nyp3F5cEqPGP38xt7Vy+32gOG+xkKohBq6U83xcHzbyEkRIAPohRT2+XFLNBT/kqTt
 n43/H51cAhu2CTpCowkpZUCNQbB4xP3tqGZ0QOPJBNbe0e4Qr6k4qRlvV2LAsjkeeSQrOuWFCT4
 3ZGtZMaFs238eMCUL7Cs+qosxeAtempHKagnztWZFly/lHo9eBVYZaLH7WOaZk+zgmAJkWZvmxu
 NcyhInlUPe7QbjK2A08zTStnkAu1ccF09LIV748DExRVITZQf0dayoM1i8USdotsy9m00IppSJ1
 XU968VRzzMbGbPgSzS/dFlObfWKdGxwtyyCGX6e6vlB6vbe8BBhszFNAMFprbnR9WapmZZqrHsJ
 WGLpp1p7R1PoHckC/cG+4lF3UpvyYQq3QcS74NJRKGTulWuLGfBoHRcEAtgxLbYjZNJDsSoYgnH
 9V2MDMk0bOxWgGS0h85+jkyzY56WGM9pqtETnonpZDSmKf3Njgmg=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

g_new0() might return NULL, which is UB if passed to a memcpy
implementation that does not expect it (not in the usual case).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3778
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 89406f0a3a..a7d749f24f 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -267,6 +267,11 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
         return;
     }
 
+    if (count == 0) {
+        cmd->payload_size = 0;
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+        return;
+    }
     pcm_info = g_new0(virtio_snd_pcm_info, count);
     for (uint32_t i = 0; i < count; i++) {
         stream_id = i + start_id;

-- 
2.56.0


