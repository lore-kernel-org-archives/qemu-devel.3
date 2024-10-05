Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1896CCFB422
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxEHW-00069Z-QR; Sat, 05 Oct 2024 19:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHV-000696-7i
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:49 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHT-0004Cn-Gs
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:49 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e221a7e7baso306037a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728171226; x=1728776026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iSrAwBk5bZNjn8Zy9dmgJJyBe5UY35yHEd3GQKBCY9s=;
 b=vX1IofKsRV/7IAjSeG7ywlmW0XpG/kDofsnXgLzMWL7o9ecSupAYSvZAFu1/Qkr5pL
 qUJLkP7Owy3iU8qurguln5Y7hZwrZtRc/pRZDEq3K2DzUekMppCM4PRzLyFlvdfY7xph
 kdeZ8ntM0pYi4dUkmB1tQUsx2w6+RLOaxUrn2A4WIJhAh7eXcQgkmwjo9x1YeN4fVZlR
 ep22mMIxZNog9bH61dFruruqj4J/Q4DTNHNOVQivqp/g8GW4fmbVu85EIvImmCw1RUYj
 ObRYh7bkhvov8uj2xqwTTk2RJsPcHdqSSJdy7aw0Sjrk0VDkNicO4yCmB/mEYlzIkmSN
 OSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728171226; x=1728776026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSrAwBk5bZNjn8Zy9dmgJJyBe5UY35yHEd3GQKBCY9s=;
 b=HEPPjnvTIAHqI8MvMpjxCKaEYs8OmFWl+zTLBM0V5EjlYPRuB2HIGJ96fB9CAxm+c+
 BKkyK+x+duVWQXzcIlK7QVSx8YOy+MWMJdWqGy5+1/Ob4FgZz4eMxEBDHRy1NeAJvrhl
 +/6rblQOt6gwI80/kTSS27KiIpIB+rIIYs5RYeVQRtZzySV+8HycLStcJI+o3RpfyXNB
 sTD5/FGVEmTq4Ch9Lfca837LWNAP+KRYvCy8eYUd/+9jzF+EkoFs1uY+HzaupK0Nyx9K
 HMYXweprGnobdAAFxW1sw2mCW/unEHuJIhukSyKDMuPoYngxKeSQTQuelEedyINlRaty
 /HVw==
X-Gm-Message-State: AOJu0YyaaHwAaefiLzztkzrW/P1C2CrDjwW05oHuPEmZnTiL/L6Y3mFy
 yOxsE8NPnxYxfy8SpXTFoqJ2nLS4r75kGPHBHpx6N6/5hmLdwAPZ7XXdiJaaay01YmW/UMquuit
 g
X-Google-Smtp-Source: AGHT+IHPygXoAfODKkVSyX78r2O0tORNeO6vaVpX19zvFu5DbI+hpqVrp7ylmK9LKjpPfMFrCyFZLw==
X-Received: by 2002:a17:90b:206:b0:2e0:8e36:11f with SMTP id
 98e67ed59e1d1-2e1e6211ba2mr8684086a91.4.1728171226049; 
 Sat, 05 Oct 2024 16:33:46 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b129cc2sm2394600a91.51.2024.10.05.16.33.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 16:33:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] linux-user: Fix parse_elf_properties GNU0_MAGIC check
Date: Sat,  5 Oct 2024 16:33:35 -0700
Message-ID: <20241005233343.503426-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005233343.503426-1-richard.henderson@linaro.org>
References: <20241005233343.503426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Comparing a string of 4 bytes only works in little-endian.

Adjust bulk bswap to only apply to the note payload.
Perform swapping of the note header manually; the magic
is defined so that it does not need a runtime swap.

Fixes: 83f990eb5adb ("linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2596
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0678c9d506..52c88a68a9 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3121,11 +3121,11 @@ static bool parse_elf_properties(const ImageSource *src,
     }
 
     /*
-     * The contents of a valid PT_GNU_PROPERTY is a sequence
-     * of uint32_t -- swap them all now.
+     * The contents of a valid PT_GNU_PROPERTY is a sequence of uint32_t.
+     * Swap most of them now, beyond the header and namesz.
      */
 #ifdef BSWAP_NEEDED
-    for (int i = 0; i < n / 4; i++) {
+    for (int i = 4; i < n / 4; i++) {
         bswap32s(note.data + i);
     }
 #endif
@@ -3135,15 +3135,15 @@ static bool parse_elf_properties(const ImageSource *src,
      * immediately follows nhdr and is thus at the 4th word.  Further, all
      * of the inputs to the kernel's round_up are multiples of 4.
      */
-    if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
-        note.nhdr.n_namesz != NOTE_NAME_SZ ||
+    if (tswap32(note.nhdr.n_type) != NT_GNU_PROPERTY_TYPE_0 ||
+        tswap32(note.nhdr.n_namesz) != NOTE_NAME_SZ ||
         note.data[3] != GNU0_MAGIC) {
         error_setg(errp, "Invalid note in PT_GNU_PROPERTY");
         return false;
     }
     off = sizeof(note.nhdr) + NOTE_NAME_SZ;
 
-    datasz = note.nhdr.n_descsz + off;
+    datasz = tswap32(note.nhdr.n_descsz) + off;
     if (datasz > n) {
         error_setg(errp, "Invalid note size in PT_GNU_PROPERTY");
         return false;
-- 
2.43.0


