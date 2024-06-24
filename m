Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A8DC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgf2-0003sZ-Kc; Mon, 24 Jun 2024 06:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sLgez-0003s7-Pi
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:10:53 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sLgex-0006J7-HS
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:10:53 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a689ad8d1f6so513582766b.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719223849; x=1719828649;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J5C8/LOZwWnw4oPYfpj66xsC6jUWr25QNl7ZvLDyOtY=;
 b=JNn/YVznMJQSV/ZXlnUfcJXJVqrQ6vgEPxcowDFAlsJ+eMieCPhKPTIlwpMIZXrMMv
 z4DO+tCYPXDjxi8h22qUPo6U/nByBLM/w5FlddG9Djkl3QC45L0DMmfvVL8R0NSsA6Sc
 0IFw6F1pV2dwyi2iWXyfDHiyW5yA6PzwdxyRdUlU/oxEXFWABlyYA23z2UmSjUpGnhB8
 tXy/HYRWd1BmK/aYZeMzQpD3cQOBT9pA2C+pCcrmwBJmE66NZRlQhyt/l4ax6Apkqaca
 x2GFG2I5I5EoOAttIHMPhKhgIgSMK63gi9z5+wckOQ61L8z0LFqO8BG8tr/n1sf26vhc
 kIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719223849; x=1719828649;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J5C8/LOZwWnw4oPYfpj66xsC6jUWr25QNl7ZvLDyOtY=;
 b=GZ5L4IzbB25nVs3eNKXDJ8NW49CH9JlQPuLnbqvWziNPpJCkquOCvN//NiucMkowLh
 pKO0EszA5+eAXABwkoyYF+UINlT1QF9fRjYhmlZuyX8CRULGeCmItFKFYMLTbigurwGC
 STs+nRdirhRdSgrfHpltZko+B974Kvm94WDiOf0QXw1ROYuR1BUI5Hw8lEYNg/+NmUyk
 Dk5/rDThBPMqdUi/452r1OEcgdlUVTex3gnIFHy7ouEje+nftVecQ2hoqM/sTorYUyt2
 eWNGsfyocw2LUoKNkPPPYPCEV9rIRV3HvmfLOKdmuIHsnQped+HJsZyDlX4RqUX5YE2y
 xQsg==
X-Gm-Message-State: AOJu0YyqBiyT4/I/eUXr0xIbGcwsIeUgwWoFbIZnm8X2EZ8JuLaDcJJC
 ZSCf76G2k8HpE36uRPEZ1dU0mBIoaqKOiOi61V6j9m8kIDk1w0N6DKLbIF5fIQcc3dOUzbKhIa+
 erg==
X-Google-Smtp-Source: AGHT+IF4dV0eLIKqq6MFL6dSZZqyCciH2qpJh8kxJrATpu+SrugqwlsU9zRn2eCs8PJvOnCYSHWkaw==
X-Received: by 2002:a17:906:4e95:b0:a6f:9b06:6b42 with SMTP id
 a640c23a62f3a-a7245c85a63mr230504466b.5.1719223848810; 
 Mon, 24 Jun 2024 03:10:48 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-17.customer.bnet.at.
 [89.104.8.17]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7246114f68sm189138666b.91.2024.06.24.03.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:10:48 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@daynix.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2] Cursor: 8 -> 1 bit alpha downsampling improvement
Date: Mon, 24 Jun 2024 12:10:40 +0200
Message-Id: <20240624101040.82726-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::633;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x633.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity maps by
turning alpha values of 255 into 1 and everything else into 0. This
means that mostly-opaque pixels ended up completely invisible.

This patch changes the behaviour so that only pixels with less than 50%
alpha (0-127) are treated as transparent when converted to 1-bit alpha.

This greatly improves the subjective appearance of anti-aliased mouse
cursors, such as those used by macOS, when using a front-end UI without
support for alpha-blended cursors, such as some VNC clients.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 ui/cursor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/cursor.c b/ui/cursor.c
index 29717b3ecb..dd3853320d 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -232,7 +232,7 @@ void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask)
     for (y = 0; y < c->height; y++) {
         bit = 0x80;
         for (x = 0; x < c->width; x++, data++) {
-            if ((*data & 0xff000000) != 0xff000000) {
+            if ((*data & 0x80000000) == 0x0) { /* Alpha < 0x80 (128) */
                 if (transparent != 0) {
                     mask[x/8] |= bit;
                 }
-- 
2.39.3 (Apple Git-146)


