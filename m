Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743891088E65
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w335u-0003jr-FD; Wed, 18 Mar 2026 22:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335r-0003i2-8f
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:39 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335o-0002rJ-Lq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:39 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-79800183233so5546777b3.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 19:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773887194; x=1774491994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPR+B5HhuRzCWChWo5IsIa4xYMcv5gwsDSjxGxdN6ps=;
 b=bKh81J/4AHgqGUmmfxHajKnHUs1b1shVLeoCNbG5v0X5sg6/h9pjVesCpANr0M4fJb
 Nsx3v+jfgH2ty/sYdHyLMdd97d72HPz1XeA5A1kB9PjcTzYRjBp4zUh1Xh62PBQVQUfG
 VKsziPeKkj+p/YYwqNYI3KNxub5UlDTx52hZrrAwQ1EmMZ2bggppGBHIDf4+t5QdNyGS
 EprseK+dP1TXsxFxikcsw14XVlYX8qW9vvuIbFkZC0dbCKEJQ2z2LOnQPQ0r54orKv35
 CXhp5upLxHdglxQHxhMFGV2nJGcA6Gc8ZPSoXIPKI2qxHidOhSnqzVId3YdC0r5dgvKZ
 IePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773887194; x=1774491994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pPR+B5HhuRzCWChWo5IsIa4xYMcv5gwsDSjxGxdN6ps=;
 b=LllNLNHX9wRO3vFmqXZ4Xnd09BrGvtTZhJWJDfILDbrEDwbHIvegvs1NrwgOevH3tW
 GYt0O/4J1Ovl0zsErU29VjiP7GHXhdtj96CdYGxqtiewGMyHNx0bmE5D7Z1+FlPI+hh5
 Px49la8dp7+hRFFhF+ETtCKc0D/4YTL4BdBSoq5Gq7Cns2doRto3UML0a8ji4JDRU7Pj
 l0Cg/y97P3hrVdSFeT+R+z1nQ7zWkCw84uRs0kLfiozgraxgyd6kEuqdQ7W1htzaHfI+
 RS3EEh+LD/5stskuMAhMJVGz8lwxvXnL2CAfsTYqCOj3oj2vKYIFnIddNoc6drME+kZB
 yHVQ==
X-Gm-Message-State: AOJu0Yws6AbQN3wJO5WyNFByd7IuTiUB8PXTLTupLC5G64IGEZ7JP/YF
 T24IGgn8xrusTg1kS8uhp1BHSmf2KcXIx6GEqTws/XcvAh7O3xKq1+xRGRN11Ck+nxImzPA6Lyo
 jRUJ1vBw=
X-Gm-Gg: ATEYQzz5UYn0gf5O+l4hT+m2z/wd2eVDKjDI9gwi0o05OCxhLClp+YB0cZNnYwgMTu7
 hy4ytZdBLBHMGNvlBFphgzvukthPTYfQpAmMLSfUoP1cYqmesjV6yxdGnKwb/QMdbHOYiDPasny
 mFQ1T9AjKbHnk94vnqQpPQF8P+gunMIrAR1GrdZCKQIEgs1VWO+2UikD7rDINSqRoY0HJc+zfZp
 /QI2sfw7Z0Mpz5DmHms9NtYJ9/aorJNGNjpyDX9lLj4VTKPbtnIamxQhNYYUcRmxztHkf01nIsk
 nzIByg4otP9LlyjXgpF+NKf0lw4fNihhA6kNlqBR08ck2GUBAeDpBm9QTl27gPCi6/Cnx5hF9L5
 Sbqc1+qirFC6ZZ+q3D6yNdqf3Kus4658SqljZPnMwcMwPaEt48KVeoZevSW9oS7ZPTRtbW6zvtR
 vZSNLiFXdQNMzQO7TfGAWsIkE4EN+LEOT9oEGjrvRC
X-Received: by 2002:a05:690c:3481:b0:797:bc42:9e35 with SMTP id
 00721157ae682-79a81b952afmr17720397b3.23.1773887193848; 
 Wed, 18 Mar 2026 19:26:33 -0700 (PDT)
Received: from gromero0.. ([177.146.137.168]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-79a7141eb65sm28159417b3.21.2026.03.18.19.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 19:26:33 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, gustavo.romero@linaro.org
Subject: [RFC PATCH 3/7] memattrs: Add new attribute 'encrypted'
Date: Wed, 18 Mar 2026 23:23:31 -0300
Message-Id: <20260319022335.22523-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319022335.22523-1-gustavo.romero@linaro.org>
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yw1-x112f.google.com
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

Add new attribute to the memory transaction attributes that is used
on Arm to select the address space where the encrypted page resides.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 include/exec/memattrs.h | 7 +++++++
 target/arm/cpu.h        | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 52ee955249..efe9d9c7ba 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -57,6 +57,13 @@ typedef struct MemTxAttrs {
     /* PCI - IOMMU operations, see PCIAddressType */
     unsigned int address_type:1;
 
+    /*
+    * Memory is encrypted. This is used to acccess the substitute
+    * encrypted page that has its own address space. This is required
+    * by FEAT_MEC on ARM.
+    */
+    unsigned int encrypted:1;
+
     /*
      * Bus masters which don't specify any attributes will get this
      * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 87c1787c9b..ebf4e4e01c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2596,7 +2596,11 @@ enum {
 /* Return the address space index to use for a memory access */
 static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
-    return attrs.secure ? ARMASIdx_S : ARMASIdx_NS;
+    if (attrs.encrypted) {
+        return ARMASIdx_MEC_PAGE;
+    } else {
+        return attrs.secure ? ARMASIdx_S : ARMASIdx_NS;
+    }
 }
 
 /* Return the AddressSpace to use for a memory access
-- 
2.34.1


