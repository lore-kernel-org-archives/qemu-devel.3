Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF7CFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJva3-00013k-6V; Mon, 04 May 2026 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZz-00011p-68
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:32 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZx-0006G7-JP
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:30 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-5102582e23eso32561611cf.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777909889; x=1778514689; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/WgX7SoeZhIHg97bvyLdMZe+eYz+Kg1zGjHAsHbNvCs=;
 b=iFh/o4gC83Mi49x1ESK5bHJPE9qxs3HWdA827PVaH45rmjwEHCGVc+aQ5bHGY1DjYI
 u/LqDrmg5XLpxz8T6ovY4wTkWPtrLrBjNoEFLVeAhybaf6FLkKpoE4T9AXlIIeGYvRBF
 cgY8OZ+NSiX0r9QFXUBcCLbrq4kJznxf0SugqV+qXlVu5Vn+xhlA/iVv5+AJTELxs2dC
 kvQuUgTBC5i16RhDF8TaY/Br0/DX2hraX9JgUzdQ52GYhuD0dSNVzEGykkwFRmTR9ygO
 10z1+iL5ZDVplexYeFkT/ZBEjsIRCQNR5M7n4nbqfPKng/iy/X+HfRcaiRcsTcouoO3k
 TaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777909889; x=1778514689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/WgX7SoeZhIHg97bvyLdMZe+eYz+Kg1zGjHAsHbNvCs=;
 b=LNbxcP7Uyy73rCVWtU99tEeXuVnyNd/878QLa7HOsW+rkemVwsEmV6bDpFHGNHboW5
 Rz9dzlXdvwG6RXBpvwjZ5p2m75K3ZJFnfYrXzblg0FjlkxGgmNoPf+eWbNr9DNUu7Z0j
 i3ftrHK64dxhBvrKG9q+A0abxH37QN2Ctw0wSXo58/7kXsQiBTFwGQ12K6gsu7aAB/op
 20VgRNxwdkLjos7QsMMBfI9eo6DnEd6KWoEVkZII7umSGaugdK6GWg4+dph5ob35T3qn
 JyXfdtqv9eBOHvfRosMGsL+CcUznZB+piocbKtxYXVVU3MdHdc2rYfIHS9Fhfis3ZwB9
 u7hg==
X-Gm-Message-State: AOJu0Yx3V3mnYnPUuWPpmGGcg+/jT0XmJzgn9zCZtBG3U8g7KDgGctb8
 RYkhpijl8EQFl/C1nYrb1GEsZJE7rUZIZSlB4A0jAVx28dAa+ymUEdec
X-Gm-Gg: AeBDietoiHhxFM6O2zG1LzerHHhezoyKkV99p+EFxwzYDBrQFcV4os6sskcDQtUIBgY
 /y3eNPxkVFlg9+B4CrVKKdcujW4P9ZKS/N6cO8KxHwZpoSCjj+ZnrxmTJ6K8O3DeFlFRZwFrUkn
 dX+vi1cWhWF6a2BPu9Krm2YoFMU8IFuB05S0eUJAQbntqCput+rUo2R+vR23bVLgHRdpA5DPbhG
 T1iqGbg7VA0UhM5QhaV2A40afb8uPzWrOPOrf8iqiMS+e+DCfGSvAvs7tUwfqaUDwX8HpeYv8l9
 hncdCijD1j6Ls6Nczmb5qIj/LRAYZs3s7QDNUsQ6NUsGP823a2hf66tWjEmT4FijAJrdCsxNmfb
 rqSvqUO4zlF1y+O2EPvPx7KhiDeXuJgIscY4bSYMdyePSr/THG6uXXJ5EPBbD2F43/cbZFfzGLh
 QmTtyqGAC9FOGldrSSdo6aLvXnYGG4rsZlvf+vAZK4/vdhnzBWn8g=
X-Received: by 2002:a05:622a:1791:b0:50f:bb01:985e with SMTP id
 d75a77b69052e-5104bf5260fmr141311151cf.48.1777909888556; 
 Mon, 04 May 2026 08:51:28 -0700 (PDT)
Received: from [192.168.1.164] ([2600:1009:a021:c665:5296:905f:3e4a:eb90])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040931552sm99599011cf.12.2026.05.04.08.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:51:27 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 04 May 2026 11:50:46 -0400
Subject: [PATCH v5 13/15] docs: add MTE4 features to docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-feat-mte4-v5-13-232a648e63c6@gmail.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
In-Reply-To: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909867; l=2273;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=ztIDgqfeOPD6qpIxmbbcUcgA0mWZp1FYw4KgD7jsfWo=;
 b=6hu7QtbwsuzHsPQ9mzvo7Wcu6EOt3HoS8T9hC/HqJc67/1XOstwfK8gvMRWOMnYYoXcrt+7wS
 PaNhj6S4ro5A1jivBZmouqrVDIbsnL6EMC8C+zUHRITgqLNIKH+dZ27
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x82c.google.com
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

The implemented MTE4 features are now present in
docs/system/arm/emulation.rst

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 5 +++++
 target/arm/tcg/cpu64.c        | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 8cd7fe7b00..c660074ec4 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -111,6 +111,11 @@ the following architecture extensions:
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
+- FEAT_MTE_PERM (NoTagAccess memory attribute)
+- FEAT_MTE_TAGGED_FAR (Full address reporting of Tag Check Fault)
+- FEAT_MTE_STORE_ONLY (Store-only tag checking)
+- FEAT_MTE_CANONICAL_TAGS (Canonical tag checking)
+- FEAT_MTE_NO_ADDRESS_TAGS (Address tagging disabled)
 - FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 649d854a65..77b8c2a0a9 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1291,8 +1291,16 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
+    t = FIELD_DP64(t, ID_AA64PFR1,
+            MTEX, 1);   /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* FEAT_MTE_TAGGED_FAR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1);   /* FEAT_MTE_STORE_ONLY */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);    /* FEAT_MTE_PERM */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */

-- 
2.54.0


