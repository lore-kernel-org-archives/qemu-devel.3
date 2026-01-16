Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F883D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagQ-0005BZ-Ff; Thu, 15 Jan 2026 22:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagM-00058m-Ob
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:30 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagJ-0008Pf-Id
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:30 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29f2676bb21so15494325ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534761; x=1769139561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mY8SF4Lgdoetp90UFxDHJbg0kRe28ldzal692R5R0k0=;
 b=rG3ESfC282dhsaymJd7TwLxVkpw+G76IniuPgTWDrcQizPH9f7/0DDzSu1EuDEtvKm
 7j8/uY7wtTyLgcv1JkWyx5/EAMUrQXrl0szhdXmK0sz8c7NdD2bCQjqTEfAVRv8i8xZV
 2/S+DwU549MRct2zOxdipklPbL6CFgHVKx1PYUPka7YY3XYUYmStBy+Ywez8v7w+Da6a
 tF6YHwIqVA0d3cnkExgICB+EGNiRm3SbtNGlpuOQqL68dik1KwkS2ZknbUZeaCdRzqKd
 Az3YbQfBMq3o3LFrT1ikcdU5NRP9YoqBdlgzL1GAgI5nBS3wlFMbLWlC5umB61c8iUmb
 0d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534761; x=1769139561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mY8SF4Lgdoetp90UFxDHJbg0kRe28ldzal692R5R0k0=;
 b=NZHq3K+j2VOZmtfgb8+3Np8LfpCIO8VcqMqpWej+tc+kD/LpWB7fsvcv2dI5MspRe/
 WkNjNNIh72zoTqiV+nkEpEgLhdNiPm0JvvkSeXpkfzqLVHEozyEBhYzk0AHA6rSxF9Im
 pfIkwxoQ2ovVXkNFmtEjm4KgD5iVLT+5EcAfvx4TPZm/WhjcX8cvXAtQscxCWTCtbuS4
 iqEuIPGcjdnQljf02MsmjPwuwdhksRwaEtlMfgR1Bonvv/Nh7AkQDLSKtISzNkgbwFq6
 gILDfilEhC+yopMESOUTGQRAomYtt0b8lCPjq/r0LPze+0S9GrT26wIDFbaVWUj3Ak6F
 n1bA==
X-Gm-Message-State: AOJu0Yw0S9bTq62Izqjha6acka7Pqg68CLQo0ysIUgAN9KJK7QEFMYpn
 +ELhn84Hn2HMmu/9gw2kSekI6IIHqyvl6Oqzz14tlJmqFnTpPaaIXyRN9hZ2cKavhhnFP6lAdlo
 15siqCeIKxA==
X-Gm-Gg: AY/fxX7rMo/9hqw3N6xG/qlgNAvO7R+rmQDh12Em6pX95XfHfeHsfWQtvTUx0WT3/wk
 oSOA5u3toHT69t5NghlpozLqR8is/b/j+pa/6jx1DbARMepxwlpX72Ofg8mWGA7pAXij1EM2Mk5
 OdRac2glsywx5XV8OFyC4eOmUX3cgKKkxu+VHFIgMbUG0QmKXGw+KuF+WfRAhiohCiAAQ0Z0eOo
 K3Ww3SfEaNcp379rVQ0bLv+aeS9clJr8j3pmQJ6LZOXUenqDRF3qUMJzjwBdPOWp4lpar8AT36c
 94imqVVgR96bghBjbmdey1KAEYyU4PVMdtDKvWN4toMx7D1cBg+Wp3DWbMLQ06YPhHLqZ+wt7f9
 F9QVQOyDup/fNKPLyB5rleLUeE2ZI3KfOWtrYhgqhjWbpIruo6K08VHY8F9LBagGuyLzJNpXIv5
 rm6pO8sYkAApFOntcnQw==
X-Received: by 2002:a17:902:e54d:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-2a718965566mr12515535ad.61.1768534760907; 
 Thu, 15 Jan 2026 19:39:20 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 48/58] target/arm: Drop CONFIG_ATOMIC64 tests
Date: Fri, 16 Jan 2026 14:32:54 +1100
Message-ID: <20260116033305.51162-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a986dc66f6..8b8dc09e72 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -757,20 +757,12 @@ static uint64_t arm_ldq_ptw(CPUARMState *env, S1Translate *ptw,
 
     if (likely(host)) {
         /* Page tables are in RAM, and we have the host address. */
-#ifdef CONFIG_ATOMIC64
-        data = qatomic_read__nocheck((uint64_t *)host);
+        data = qatomic_read((uint64_t *)host);
         if (ptw->out_be) {
             data = be64_to_cpu(data);
         } else {
             data = le64_to_cpu(data);
         }
-#else
-        if (ptw->out_be) {
-            data = ldq_be_p(host);
-        } else {
-            data = ldq_le_p(host);
-        }
-#endif
     } else {
         /* Page tables are in MMIO. */
         MemTxAttrs attrs = {
@@ -798,7 +790,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
+#ifdef CONFIG_TCG
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -903,17 +895,17 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
     if (ptw->out_be) {
         old_val = cpu_to_be64(old_val);
         new_val = cpu_to_be64(new_val);
-        cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
+        cur_val = qatomic_cmpxchg((uint64_t *)host, old_val, new_val);
         cur_val = be64_to_cpu(cur_val);
     } else {
         old_val = cpu_to_le64(old_val);
         new_val = cpu_to_le64(new_val);
-        cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
+        cur_val = qatomic_cmpxchg((uint64_t *)host, old_val, new_val);
         cur_val = le64_to_cpu(cur_val);
     }
     return cur_val;
 #else
-    /* AArch32 does not have FEAT_HADFS; non-TCG guests only use debug-mode. */
+    /* Non-TCG guests only use debug-mode. */
     g_assert_not_reached();
 #endif
 }
-- 
2.43.0


