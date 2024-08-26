Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D790C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 21:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sigq7-0002Av-Fb; Mon, 26 Aug 2024 17:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3u-nMZggKCv4lgtpgyutmuumrk.iuswks0-jk1krtutmt0.uxm@flex--fanjason.bounces.google.com>)
 id 1sigc4-0001aP-DR
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:46:56 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3u-nMZggKCv4lgtpgyutmuumrk.iuswks0-jk1krtutmt0.uxm@flex--fanjason.bounces.google.com>)
 id 1sigc2-0001qg-GF
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 16:46:56 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6b43e6b9c82so112958577b3.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724705211; x=1725310011; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=l8WpacnFuwn17dhgS1WlyNZRw1pDH2hsyX31j01v1gQ=;
 b=hEQugQzv12k1eny1Aa5h/5gS28etTJDdYzhlheT0m2bH2rRQw+hZNXBxsmb121xzUM
 1DqhnQCkR5Ua2UA9+U1ZZNQtjBGVCo+DAm2Mil05rUFxYCNKDSmF6QIQAT6Irwdf4a9p
 9k6Z1Hh1JO3izzNjgrtDTgXrhVGGU+lItRh57JPaKBvjj+g5/qebzgWGYc15w6u4Wo5A
 dQDxd86fowVo6fpWJP060kP0Q5Ne/UuytULKr6dRiDm/aWsZTVjB3uNvF9dLWn5ProtS
 pzAIY2YUMgIWWWvJBVesivzXjbG/o/aAhbUqaePIVidaMj4UrNIDUnBRocFYT+8UiFZ/
 J/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724705211; x=1725310011;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8WpacnFuwn17dhgS1WlyNZRw1pDH2hsyX31j01v1gQ=;
 b=H/a58RIHOkv0HejLPFnp+YafHErMlriIWoDFfqg6lR5s4Xk33SZoZ5scOKXwR/GGfj
 Njfr+CjDCuGepVtcpP3wCpC3eUZYzPU0Pzy5nJ/7d7smhQO/UO77OJ5eHumXpoTwJoDd
 /cEKrNTmuzOZao4MqlgA0lF99UTuCTqFEfZLFzNMypvNrj94sDmqk8zCgY5qeLYyuQ9k
 BNabZSexm5wNFXWlfsVR22VTfgYRqenVcUDnVdRKvb74eKOSATSWsoen5LWg2rsIVpf5
 Df3PAHPMUJuLviUJrGH0C6uM9PbVssWYJZn309qCv4AKgKa9UwIs/MDWePb9Esz5n8Gg
 U2oA==
X-Gm-Message-State: AOJu0YxyY2tG1AScs5bZW66x+3LRMcpcnUANIHwP77lgyaXbzbYFPOuz
 xRgXerBxegf6BbVBQCWKIMkAkZxIB9XYRve70OqXikIbkFBmuZUNMRsJLVtHtIIOMKo0WGchH8f
 1Z7FGD/vE4g==
X-Google-Smtp-Source: AGHT+IEIRFTNPb4u70wTtBzfKWDMBeLFvwYO2qhhkI5GvYuc4T3bhMj7XKxNBzyCqeRopeTV+B/E0atEqM3oaw==
X-Received: from fanjason3.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2730])
 (user=fanjason job=sendgmr) by 2002:a81:e404:0:b0:6be:9d4a:f097 with SMTP id
 00721157ae682-6c6288afc7dmr2146477b3.7.1724705211237; Mon, 26 Aug 2024
 13:46:51 -0700 (PDT)
Date: Mon, 26 Aug 2024 20:46:28 +0000
In-Reply-To: <20240826204628.3541850-1-fanjason@google.com>
Mime-Version: 1.0
References: <20240826204628.3541850-1-fanjason@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826204628.3541850-2-fanjason@google.com>
Subject: [PATCH 1/1] include/qemu/bitops.h: Add deposit8 for uint8_t bit
 operation
From: Jason Fan <fanjason@google.com>
To: philmd@redhat.com, richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Jason Fan <fanjason@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3u-nMZggKCv4lgtpgyutmuumrk.iuswks0-jk1krtutmt0.uxm@flex--fanjason.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Aug 2024 17:01:24 -0400
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

Signed-off-by: Jason Fan <fanjason@google.com>
---
 include/qemu/bitops.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 2c0a2fe751..d01c4b42f2 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -459,6 +459,32 @@ static inline int64_t sextract64(uint64_t value, int start, int length)
     return ((int64_t)(value << (64 - length - start))) >> (64 - length);
 }
 
+/**
+ * deposit8:
+ * @value: initial value to insert bit field into
+ * @start: the lowest bit in the bit field (numbered from 0)
+ * @length: the length of the bit field
+ * @fieldval: the value to insert into the bit field
+ *
+ * Deposit @fieldval into the 8 bit @value at the bit field specified
+ * by the @start and @length parameters, and return the modified
+ * @value. Bits of @value outside the bit field are not modified.
+ * Bits of @fieldval above the least significant @length bits are
+ * ignored. The bit field must lie entirely within the 8 bit word.
+ * It is valid to request that all 8 bits are modified (ie @length
+ * 8 and @start 0).
+ *
+ * Returns: the modified @value.
+ */
+static inline uint8_t deposit8(uint8_t value, int start, int length,
+                               uint8_t fieldval)
+{
+    uint8_t mask = 0xFF;
+    assert(start >= 0 && length > 0 && length <= 8 - start);
+    mask = (mask >> (8 - length)) << start;
+    return (value & ~mask) | ((fieldval << start) & mask);
+}
+
 /**
  * deposit32:
  * @value: initial value to insert bit field into
-- 
2.46.0.295.g3b9ea8a38a-goog


