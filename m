Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6F7C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtwsq-000434-HV; Tue, 11 Aug 2026 20:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsp-00042W-J7
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsn-0000SR-SM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso639832b3a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786494708; x=1787099508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LHHf9lErbFSypMyAoUXaFTWJ3RrOkvtGjLDJ7p8sn0U=;
 b=e+1/9Oo9Eo6kqTpfqrOzVTTclEBGQjygypkm7e02tmNf1YCiQysyXwML+CPth99vop
 JsWXQ+NCbzt6I/6JZomUYHnyqg6M9EcLbZ8jyp9J13Toi9MicND/r7F9WJ2JH3JZBSKK
 f7bwU2qTowsSJlm48B0esEcc+6CA3DeXDMAa0Fe2Aq8l1MuIabFXnC1mFGQ3dasEd/QT
 TQjiugeCgJAi6HJKrNL4q8Eom8v/F0z1FChxUv4k6WUMgl2hwqtcoa6R5hnNgDPLt2CW
 G1K1+uw+2nVkatSlutRjmhUFK0f56zIGjyH/2q9v8dSXjN25IkNkSWvOco+Mu0M6QmbQ
 G86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786494708; x=1787099508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LHHf9lErbFSypMyAoUXaFTWJ3RrOkvtGjLDJ7p8sn0U=;
 b=RQ8gJnHWP5Kj8FTcEDmyz4FPFh5oLNVhiKZzuPIJ55dBfkPG8Y+8B+42K4wAYtqDbN
 4Pb9HsqlgiymAU/LTfIflP+V7zzjwxaBaeVneKA5R7nr1Myi1Cmd1wo2kHPyvhqHVKzJ
 lnEWtmwIL52LvB5GMGA71HvZXU21KDTntEocbWQNFtfSU6QxiFOq6PVwaH2nzScVOBhu
 oTYVQnE28r81Fx+jAFyCg9GnZKIPWtmQ+Beew6S+WVq2s/j6iov+pVVHHedzCmOTnlBQ
 Im+/T2c8vXIRmt4OuqfOY+DHZvQaepB9URlCIfFHnMWtkLnQJVKMJGR3rBFs0jZBayDn
 5XxQ==
X-Gm-Message-State: AOJu0YzlLznjBqlBIM1n0A1BUPFibWP/kedtEQoCDpai+mMq1EFhmZGp
 cm/2xm9w7GpN314cyveBXbUM8Yqy4yaRF5H65QgfOK8BYA8j9IfK+pimn9k+sGqB9l3d9zvP27g
 slROR
X-Gm-Gg: AR+sD10GQXoZsFoASGZBRJfuMthsC1ClxSk8lfImbUvLZpYFhuYXAAV/tDpdn91PU3w
 KlM7LBfjsefZuHEO7jP6m69J+SAicC9CS55ImLgiotciHzESyJoVa7vCaIKZDcTFGs88jgQhlsw
 M9yljWmGjjgDLCEWL7okFoB3BXj5ZsXwhCQ2GCZ0IapKJwQOOXu5fYxF2JrXxAAdK0d+wU58fue
 +dvpfX4hecCwDNCQc2xEnPmBOGCrAJs0s54ChRtHzSIBTj/vh4PyMAtbxGA/7aC9lGsdsQVMNTe
 l3Yjv1j78deyWQUmNhNj2G6K43/B4dA5X+h38tWkzo5Rh11rHNPhIJAxRN85I6/CvC/uPeg19gD
 6rM7pweYDtgauaF4EdIsQ/fk7ruofVeEHc3LjQiYEq3oPRPR91k1o7iQ3etiF6doEvbwQbOQnVb
 5dnAKcMew9ZAuS2bRO32MGbxc4VQe/6A9gcZcDmcjqJnN8Q9lJsUVkaqpowcCI2Rwpjuha/rmGV
 JEkBGrvsaPL+qP0xedEotQFxtJ2Wmo=
X-Received: by 2002:a05:6a00:800f:b0:845:3914:f039 with SMTP id
 d2e1a72fcca58-84fb5509b7fmr1219330b3a.26.1786494708348; 
 Tue, 11 Aug 2026 17:31:48 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f2587fsm321466b3a.49.2026.08.11.17.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 17:31:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] util/cpuinfo-aarch64: Detect FEAT_CSSC
Date: Tue, 11 Aug 2026 17:31:39 -0700
Message-ID: <20260812003143.225228-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812003143.225228-1-richard.henderson@linaro.org>
References: <20260812003143.225228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/cpuinfo.h |  1 +
 util/cpuinfo-aarch64.c              | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index fe671534e4..c32c04dade 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -12,6 +12,7 @@
 #define CPUINFO_AES             (1u << 3)
 #define CPUINFO_PMULL           (1u << 4)
 #define CPUINFO_BTI             (1u << 5)
+#define CPUINFO_CSSC            (1u << 6)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 288074c08f..0b4f8a747d 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -72,6 +72,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
     info |= (hwcap2 & HWCAP2_BTI ? CPUINFO_BTI : 0);
+    info |= (hwcap2 & HWCAP2_CSSC ? CPUINFO_CSSC : 0);
 #endif
 #ifdef CONFIG_DARWIN
     info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;
@@ -79,10 +80,11 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     info |= sysctl_for_bool("hw.optional.arm.FEAT_AES") * CPUINFO_AES;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_PMULL") * CPUINFO_PMULL;
     info |= sysctl_for_bool("hw.optional.arm.FEAT_BTI") * CPUINFO_BTI;
+    info |= sysctl_for_bool("hw.optional.arm.FEAT_CSSC") * CPUINFO_CSSC;
 #endif
 #if defined(__OpenBSD__) && !defined(CONFIG_ELF_AUX_INFO)
     int mib[2];
-    uint64_t isar0;
+    uint64_t isar0, isar2;
     uint64_t pfr1;
     size_t len;
 
@@ -101,6 +103,15 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         }
     }
 
+    mib[0] = CTL_MACHDEP;
+    mib[1] = CPU_ID_AA64ISAR2;
+    len = sizeof(isar2);
+    if (sysctl(mib, 2, &isar2, &len, NULL, 0) != -1) {
+        if (ID_AA64ISAR2_CSSC(isar2) >= ID_AA64ISAR2_CSSC_IMPL) {
+            info |= CPUINFO_CSSC;
+        }
+    }
+
     mib[0] = CTL_MACHDEP;
     mib[1] = CPU_ID_AA64PFR1;
     len = sizeof(pfr1);
-- 
2.43.0


