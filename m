Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDEFEB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu9e-00005N-DU; Tue, 10 Feb 2026 15:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9N-0007yd-8R
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:57 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9L-0008C8-9t
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:56 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a79998d35aso43705625ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754554; x=1771359354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+C4usfFJxntIkaYUwqttNHLWY0mMsZx1f8GtcALX8k=;
 b=pPvHKVBgtAYrT3CVlB9LKwc/W7Bf75ZhEB8njwhCAX7DAt81O+DgwoacX2X375nE9N
 m12Vy5CnMQwBcAcw+n9k8mFbIXgzZ4R+xsGSlVrdr3KxNGCGwNS7my13AEnRHAXwn9X0
 QHchoTY6kXX6PL8CNMATeMfwtjZ72lgzOQaLZuNm/6WZKq75jpHvpUVoEJraAqnGUilV
 F3QLRawOwJi1GluaeV1c24Yfp7EAKz96V9hLU4Wfc83Mo+ya3L8t3TJnRDWVWjKWKB9y
 7iePpJ3SsoxCMzjJUAAsz742TlA6Qng7FMmY/MMsNa/Y7gncD94hnvRKa55grYzm2mIN
 2fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754554; x=1771359354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P+C4usfFJxntIkaYUwqttNHLWY0mMsZx1f8GtcALX8k=;
 b=ud/+HJbGVrAdXTsK01AiBSEmiU59slAFAPneRAy3EWvN4ylQRcvUkpRlfKavlcflJE
 VFC6GzLUXO9N2HNcm4lI3Zl4IEQwf2DQOgvTnT1cswGSIGhLVOkUABl6mhEx0QrbdcrL
 HqUnALu081PDveoqKCIupfjcwdLVhKJPm7vYK3/JpSHxrvJFmmp27MA3DEOjHNQjLOfW
 zUa9vmRslC6qU441oRN6L7aZl8FGZBR/CnkX8s2fi2LXR+VJ49GgsHHg29ofjkdVmzGV
 0jUmnYWvFax+7o23uHGwKCpmTQ/lqLkjJveasQoHz+8PE51ickv7WOzmPvdb1LZvXdwH
 cheQ==
X-Gm-Message-State: AOJu0Yy1ga/2HVR2W3IxxJZZdYAy+saKGV7GvGQKKD4ysMUOvcG0VPLn
 W92it9bC6EQopkNaJcD6iBfy3acQxkKXP528r6YjLLHCdkk/z5X6tLKw5MlTTBXCofDBn1CkljH
 +X43K
X-Gm-Gg: AZuq6aK2qANi20y3cWkV+2C8M8fbobEbDzFk6Iv/ApQkYfuYurdgwl8+eHdd8A59f3D
 99QvnMZKCwAG6m/XGu62YbzOSi1g9Z6Lq61/7lGKC9CpcPAa7+5qL2UQiIFfPVurr6Gl8cVAgFd
 81ghQwYyCyBRmLUD95AaU57t8vj/o57pEG6m/4DUE+vUAQHSLuYWq8jy0lV9eOjRGCWWjZnvEB3
 o2jYTrFGr8qBLDmrzfBG4DH+UpUhq3XjQIef0hNSVMq/wy0+kphDIoPc/xxkB2kJddeJBA9zeIb
 pwaRVYk1pz5xXkCBK98Kct7U9qP4hSNdngjfqxLFZoCRjvIuFEiQrgnumyuFyY5DqArM1s7VDcY
 vF4FvRoiVQZJ6KvIi9SkUG181tgtfXjFL9cQRWXdhKt42a+qV3RKWuZckuxLLA8bEH9rYaSeCxF
 njDZ8PZqqcEtVf8FPw1Y3K6Ugna6zclwrzW4JBTAJWUq0sA18kmoJZi0hpUQduH52nlxVD08pew
 lqe
X-Received: by 2002:a17:902:e810:b0:2aa:d630:cd5d with SMTP id
 d9443c01a7336-2aad630cde5mr114918085ad.44.1770754553610; 
 Tue, 10 Feb 2026 12:15:53 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab0b392cb5sm38523225ad.70.2026.02.10.12.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:15:53 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 10/12] target/arm/tcg/translate.h: replace target_ulong
 with vaddr
Date: Tue, 10 Feb 2026 12:15:38 -0800
Message-ID: <20260210201540.1405424-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
References: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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


