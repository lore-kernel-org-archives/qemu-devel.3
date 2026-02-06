Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24A6E9129D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDMF-0004QJ-40; Thu, 05 Feb 2026 23:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDMC-0004O6-Ez
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:12 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDMB-0003VI-0h
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:12 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81e9d0cd082so284322b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770351730; x=1770956530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+C4usfFJxntIkaYUwqttNHLWY0mMsZx1f8GtcALX8k=;
 b=Xgf/4GKWQrLp7uCoQYRUzCqyhSP4HADbAM6oRmrtDC5QtlPw0ni1xUEOiLS00DDBJm
 EwhsiCjtoNjLvZQW8MFPNowjtCdV3jcsWmUD6agEEGcUQrs1gwnF95TE2cXEZ14ylk/5
 /H0m2sYb4411muOr+AWsXOAZhcabVbhk1ufVrotR0PYJzA8GVvtTTquibUSDwbmHeQGh
 WplUD10pGLBctLhAhQQz7WMax5CzgzqYtpdrIuH7eIMzBBNX3xMX3QLy5mPC48CVXmLT
 xH8RrHMT0CAe3Lx+WUit8GC1kMP7aPTjIZVF1YHxDlOJ1kQMweHBq9Rvw30kN90DGOIc
 X5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770351730; x=1770956530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P+C4usfFJxntIkaYUwqttNHLWY0mMsZx1f8GtcALX8k=;
 b=IwpJezXEVKAqZKDsKiyzc/wZNHaLRj9Eby52a7GTSxVP4kEmp39cUcyoTQYXsQ/Xnh
 uzN9AALLUijNnqOEVZ0Ath2o0lrsm7SJZqsByn7efkOScqk//OIPuKab7mMp8qXIv3i1
 ZiboBL0w6yS3lvOCb4oW7BqtHUMU0k9EXN4duVkI0SvoQFvy2uG61ew9KgeRBYutFKYL
 s3rDkFdU4WdC95i4KFbDAw/FIngyzc4Kw2DveCLAzCGBm7cIqK8AM1ip+aB2w1DZ9HNt
 1ZKkrgKQi6lDuk5pgHi7N6G00At5R5sHN8w4r1P7/TfRfDjm17xJlsbkWl4ucf5wJST2
 s0Tw==
X-Gm-Message-State: AOJu0Yz5wn0CtqeKZj7rLs75vN0F9dOCr9wUBKjCzts/O8ibpGktzFZ7
 6Dw4pLP4CgkRO/RBuJaTdWieLw/+4P7pPjmsO57hZLiPDYDP3bn3g7HCRLYxCl5gi+PBZ5gCCc7
 Qi2/6
X-Gm-Gg: AZuq6aIORDlsZDsrCyO3MtJhaYZxL3K/FBniy3u6ZiO+MNn4WO5z+2T2xL29Z+VjUmI
 F5e3/E0bdo7RxLVC29A/beLwaD0po3GKbiLbokElZyqUXffIYxOzIV4r1YSLJM4ruZulW7NhYyo
 IIXQjIbNzEN0o9lyxisisn1ldsovPD9K4WYLg7SvOjgxLrl7Kky2wj79y6BAE1tBOkEj6eeK9y2
 ijWxc8q3KhvKQ6ahTQu9UkvKsNoEf3g67Ifr7OvJUuSsq/AnWzuUPUX+z2CrnkE2zoe1g9pCFWp
 Isu4Xsn1MyOXItDoZk9v8DilSPeUZfDWrNFgJQxKXuH3WxNj2z+KfRtZ8m2ncKkvDhYYCQy8qIH
 PyU7YnTCm3LizqorGzr8bVqbH7/3pZni1TDfGumAS8fh0nijl9cyXuSL918buZ227Agr1xMnd/Z
 ObaBC7KdMSCmYwhTgz82cTWHl4uXLgBeulv8WS6foW8N17gU3bRzDyDNtVH3czDGZR
X-Received: by 2002:a05:6a00:17a7:b0:81f:4963:4967 with SMTP id
 d2e1a72fcca58-82441773190mr1309967b3a.57.1770351729674; 
 Thu, 05 Feb 2026 20:22:09 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244168fdf5sm926914b3a.17.2026.02.05.20.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 20:22:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/12] target/arm/tcg/translate.h: replace target_ulong
 with vaddr
Date: Thu,  5 Feb 2026 20:21:49 -0800
Message-ID: <20260206042150.912578-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 027769271c9..2c8358dd7fa 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -18,7 +18,7 @@
  */
 typedef struct DisasLabel {
     TCGLabel *label;
-    target_ulong pc_save;
+    vaddr pc_save;
 } DisasLabel;
 
 /*
@@ -42,7 +42,7 @@ typedef struct DisasContext {
     DisasDelayException *delay_excp_list;
 
     /* The address of the current instruction being translated. */
-    target_ulong pc_curr;
+    vaddr pc_curr;
     /*
      * For CF_PCREL, the full value of cpu_pc is not known
      * (although the page offset is known).  For convenience, the
@@ -56,8 +56,8 @@ typedef struct DisasContext {
      * pc_save contains -1 to indicate that relative updates are no
      * longer possible.
      */
-    target_ulong pc_save;
-    target_ulong page_start;
+    vaddr pc_save;
+    vaddr page_start;
     uint32_t insn;
     /* Nonzero if this instruction has been conditionally skipped.  */
     int condjmp;
-- 
2.47.3


