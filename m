Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD04C79FAF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp8V-0001mf-S0; Mon, 05 Jan 2026 13:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7T-00017N-M0
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:57 -0500
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7P-00037B-Dd
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:54 -0500
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8b1e54aefc5so15053785a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636940; x=1768241740; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=udHcpN8ZZZt21zmciD7G8BASxGfZmLICDSByJJQKjAw=;
 b=VViVQYq1/5eOSa2IUEdWOvF5imujBC8PLtJfF6ibqMalmjYQm1JXpMRU6j0xV91APS
 RqKxTsHueCq6OpbhroQlxjtV+s0Kn33PrDUljnH7Mf4406iD953mPUrJF47a1hYseEY9
 g9NcqO4dcST7oU/x7ZOywNeCFuMv1EC60IsNRFpSE956uC2wgZwm4xy54rfl63eGPoyv
 LYChPrmDVsyjtA6omZ6IMa7KV3DgKo/HWQ2hPpYTqeKiJZ/TSopkSyFsOPh8a2HT35/k
 rOR5v1dfgT3tSl+J2WHf5q7/cBZmV5n15rHqxXiIxb+RC/+kXMwqkmvi7+v7SncGiHQw
 f6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636940; x=1768241740;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=udHcpN8ZZZt21zmciD7G8BASxGfZmLICDSByJJQKjAw=;
 b=t88JL9NWnXejsZ+Jn3VGpYiCGsHxLbMnWV/EmPnQjDq4u3coHhsQT7KP2v0LT/MzVl
 VxBGNhJufRfmT+uNAFKOm1jGkgzyeOYUMmC/bOaR0KG5xlbTHD692xqDw39IjBdIVh1v
 ULVqBVHKj5r82YjLs5nOV7VG9G5n0o2e4Tb+Pe2Gw03Zzjn+VvQzr2wkZRZagCpwCwUK
 SPPsN+EwMLv+tHAqAh9iEAEii2AqWX+5X/asheVV7cedMQXsS0pO7QKNRcV3s/bjsLcx
 tWzTcjV4uH40CgZnhMlPUAnhTnnX/h8sT8xkvV32tNkLV50od3sb1CuAHwrChxZE7wQy
 mAMQ==
X-Gm-Message-State: AOJu0YzUTrCPuTCIZ2McvtfBhD8vUPeoAKsvwRUQ6rUqX6sU3QE/RXkq
 2Riw/kLpp+I7mQKINPd+PybkdybHA1RcE2DxGSssHhR7d4QmMzYMkWS2
X-Gm-Gg: AY/fxX5du4yD1JZXat+UShznJVK3NC3s/J+bs34I3bUPn46MnQT4CUaLiFWunEf6bep
 44TxIjnyqTGF5pB7l8poSb5wHYbLtk8qjWjeuFlQJ2PO14o7K2hLLzuakC5AL1PxBYaRErf1EOZ
 jzX2b0lxSJbdy23kQuJK8WfhIWqIJoxCFhFuCFjLFQCCTVISB8JU4z2EeqwNXTLS7SlW5+RXAMU
 99ZG47tonqZ13fgUUJPxVmF3AAMClCFM+GWqJB8M4xrc+CsOJ1UtKR54FPmLpu7VdSvwI7SuU/S
 ynlZLxA3Y0OR5guYCVkObNENZwG6p9L8fSa3FLqo/pKhzrGzkLt9n3dZOH37ndX5TIogaZociBG
 nEUuG6t2vYYmzgl0LROONSWNxbg3+5HGu1m/b/O26YZJLnSqvyokP9V8QINbS3jOl9k2nAhTBjb
 EzZhWTeyS/j8vG0y9nx1zgIHvW
X-Google-Smtp-Source: AGHT+IEH1q73W2xEmNCuPVoyRXFU7CwblIqnnjCeffn+13De9y7qMnrq+Z1Usj1DLFFk8Oq3949RtQ==
X-Received: by 2002:ac8:5e0d:0:b0:4ee:24b8:2275 with SMTP id
 d75a77b69052e-4ffa769a0a5mr6418201cf.1.1767636939776; 
 Mon, 05 Jan 2026 10:15:39 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:39 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:14:59 -0700
Subject: [PATCH RFC v3 10/12] docs: add MTE4 features to docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-10-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=2273;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=DsmbxIwUBXC/gS0c7G0YS6d9ziseoKdUCW31wFQg4u8=;
 b=7hq6iEvTw/7SdRedRqlvPiN7gXImWHLziKMoojuFus0lGNbf1qb1QAjzwnRwFSfrvYKkEVybz
 ixarxY83VGVDFVqdLBO1SeR2wLoDOvp2mHrJqMq0OfkviO3gECE5gVO
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The implemented MTE4 features are now present in
docs/system/arm/emulation.rst

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 5 +++++
 target/arm/tcg/cpu64.c        | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 31a5878a8f..12662189fc 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -106,6 +106,11 @@ the following architecture extensions:
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
index 917db5bb09..4ba126f4f8 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1281,8 +1281,16 @@ void aarch64_max_tcg_initfn(Object *obj)
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
2.52.0


