Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ECFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBGC-0007qd-Lr; Mon, 19 Aug 2024 18:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEr-0001rZ-QW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEp-0000mg-8n
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so38751555e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107953; x=1724712753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfFtvwBUu6O5iys7XE1dWmkEu565Z9xC0zCU21IHrTk=;
 b=dUQya8JDiDTeZj10U3FuTExL9MYWkrIW9I6W9reYNgC9WQ0eG9EEkVkHGAS1ColXHR
 5oTwuVDeaqvtFEn/j0qmycx+IjNNQmYc6Nw+pxplOpJKxoT1rRK1/Dkh/8/qJ4wdodHE
 Fo9Jlgdfn/K8RxDo0nyt3k8xJhgCWfr0fg8z7OONdNHih9PG4/9k0KJg82WPsUAam/fh
 u5dBu2nC6UQ/aApMowBQ9K9NxN8kNH4TBEAjhJnvhklL2JdEMAagPVEt3tjGRFIlNXYR
 NVj34ZHKF75iFg/c0cwHqBdrY+PwYjg8o1OUkBkYOM9Zvh8syO3+0nrIQ9AlTqKmPacZ
 kgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107953; x=1724712753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfFtvwBUu6O5iys7XE1dWmkEu565Z9xC0zCU21IHrTk=;
 b=RCYGTvyTr9h561UOX2dYuq9jIzCosz9OH+oRoclHwmOJyRh/F1rSlNNWJ9nLJ+6dNH
 BwPOxQp+zydaYlYOkLY8j01Zx9o1gVHLevjSDNDUR9DqR51vmL5p/AG8oUXKUPXpzqOl
 gi1crrbCbLMqec67o5Ctpx4cUap/k0cKgdWaWjdPZC4l8LUfg+knhyAitfe+GHVj0HQd
 RxtZxMabFZaY6JPuF7RbYRY8cKnP6Klf9ou94qwtNfJGMWRCt/tUcBnNr5XpcVbHlCBk
 gYgCSv0OwCeqMmmxdWe4PtKsE8ZITS++wMnvKTGUF6VlTw1mLWHeUtHbbQg1RLP0PdHA
 ohNw==
X-Gm-Message-State: AOJu0Yyx42akQu1UMRFYY+g2bS6w9AiSL8gdYnfdLbH0bafp6b7TRojT
 FKG++IlswqwQnhpOk4WvgjPf+cBODHVRjnURKNS44Lrd9aMSojNeSdukvJdr0tQ+ZSMvIg7FSPN
 Ilrw=
X-Google-Smtp-Source: AGHT+IHrQr4YwIT9vzFLmUWWj50emigoEoElZZMUbBMnBJhvxKUtG8dDJm3ZwXFuFNKG2TBfWqcy9A==
X-Received: by 2002:adf:a408:0:b0:368:4910:8f49 with SMTP id
 ffacd0b85a97d-37194315ae6mr10221794f8f.12.1724107953195; 
 Mon, 19 Aug 2024 15:52:33 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189896be4sm11657731f8f.77.2024.08.19.15.52.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/20] target/sparc: Restrict STQF to sparcv9
Date: Tue, 20 Aug 2024 00:51:12 +0200
Message-ID: <20240819225116.17928-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Prior to sparcv9, the same encoding was STDFQ.

Cc: qemu-stable@nongnu.org
Fixes: 06c060d9e5b ("target/sparc: Move simple fp load/store to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240816072311.353234-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/insns.decode | 2 +-
 target/sparc/translate.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index fbcb4f7aef..5fd478191a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -644,7 +644,7 @@ STF         11 ..... 100100 ..... . .............          @r_r_ri_na
 STFSR       11 00000 100101 ..... . .............          @n_r_ri
 STXFSR      11 00001 100101 ..... . .............          @n_r_ri
 {
-  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na
+  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na # v9
   STDFQ     11 ----- 100110 ----- - -------------
 }
 STDF        11 ..... 100111 ..... . .............          @d_r_ri_na
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 113639083b..c803e8d1ba 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4521,7 +4521,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
 
 TRANS(STF, ALL, do_st_fpr, a, MO_32)
 TRANS(STDF, ALL, do_st_fpr, a, MO_64)
-TRANS(STQF, ALL, do_st_fpr, a, MO_128)
+TRANS(STQF, 64, do_st_fpr, a, MO_128)
 
 TRANS(STFA, 64, do_st_fpr, a, MO_32)
 TRANS(STDFA, 64, do_st_fpr, a, MO_64)
-- 
2.45.2


