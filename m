Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2A4C87FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueckR-0006ge-Hk; Wed, 23 Jul 2025 12:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckN-0006Yu-7W
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ueckK-0007CB-Ci
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:55:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so52573f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753289710; x=1753894510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xPRVtFyOEs0a/mnfXfxmFYMGExKwtE9UrYxqSOjaOvc=;
 b=pGgmJNTiicDHXT4IL3r+0gAMEYxKemHk8AcUUA/PjQcaJ8kmhiALkqvV+DtN/4rHBA
 MrObCv9BxsLv3sMj8sGTLUeskCbk7ZScvxrj5u7JHgZMDwWhbC9iWCDoAtNokCwDB9QB
 3VngQDZrMygjD25Qh3l+WZXLO4nPnDGVPvzt1iwNWS6vEtM7bu43Md9C/6dkBdbakKXm
 /T0KquRa6c4ipyAjnu+SGkLZAOpdTAbIcnW+pXhTVFoubJAFxQWxCmuBo0krhM5/OW7m
 XpbMJJU76ikS9sWjktsWnZWav+LWz/EiMD2HwP9g+5DOVxSCjjYD/x/8utejM1DzDlh6
 6bCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753289710; x=1753894510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xPRVtFyOEs0a/mnfXfxmFYMGExKwtE9UrYxqSOjaOvc=;
 b=fbs7rphk9EeNEsluZpbQTaMR86xXTv6QpYtW+mwe0ka18gfoJp22DGQq7gLCHy4a05
 94ZgMvNE4OpIbBKTIrtVqMqbewMpBc5A/zQimh1HZP4rsrfMaPkqvhqHStnyTW7jYd64
 MysJFnY9co09b55jyyw8MRJwc0XGq7gQW+0st11RgwVgAsWkHJy58D903N7Mte35nDiq
 USP82FeDOk7iR0wRf80YATVefiBUdhf1BBjoSpn7a8Xssowe6PmojjrkACgu5pJG/rfP
 jn/wfaIqiJQhbacUPhFmmWB+Jt9+MqIlEYVyhBM64lZb9cIIKhhR+iY0v6GgHXyP/SuX
 k3JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr9Px8QCkJfobmD8vxeSEZrRdCH0pk0k67FQcCdMxURuh4LLNEChFzr/Mv/UR4Q8vAhVR5WGhMZaha@nongnu.org
X-Gm-Message-State: AOJu0Yx7CixxoMHSwexhrLU9gNPChwo7BAsdQJjWFSy0meK8fQ/7pLHT
 bMCzFOoEtUiQ21s040i+K89wFtFD82NdRZX3vPX7CJJ00Rmn83OXz+xAUJYMm6D6CbtgL1Mue6t
 /4+aM
X-Gm-Gg: ASbGnctwVKFlGBo/4nSyKL4hHSRSCmq6G6zfKNrdt1763ew6urDs8nt0qQh2tacElVr
 ikF2CDnskXCGc0X8X8El9x+cOUTqKF4ABI+N8BmXiwsbkAy4J51JQuquzQRiJwLlu1Uw3fV7oRT
 uWc2xMKA4xSG6+YQmixaZVYvwF9Xn7ygCH5+TcqDytGGfBtiOGSq1snTHM8lIdTgC+P8ZOEgshx
 w3wtvS2N6MsgNotGqbdrv9UIWpFd6Ihrj6MWS4CEJvMZzOvV1cwLw5OaDnSRATRdmiSC/qY5tOG
 FWMlY2odJC0XpPvqckopUClGIVKt7gxf/Kfj4p02d5an23y4xHGzwg5rUSe2jqS73jv49wJ3xGm
 uI5LIt5z4u0vAPAonNrnl0ByfFLuy
X-Google-Smtp-Source: AGHT+IFJdjRZrY/S3niiPLVHZKOWDLC/3BuP8ocpwN3JSOYD0JGgcdZwhnpRQi8HuQ+C/2JcNoe/og==
X-Received: by 2002:a05:6000:401e:b0:3b7:5802:f51d with SMTP id
 ffacd0b85a97d-3b768ef3c11mr2964410f8f.27.1753289710185; 
 Wed, 23 Jul 2025 09:55:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458693cd224sm28559825e9.21.2025.07.23.09.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:55:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 5/6] target/arm: Pass correct esize to sve_st1_z()
 for LD1Q, ST1Q
Date: Wed, 23 Jul 2025 17:54:57 +0100
Message-ID: <20250723165458.3509150-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250723165458.3509150-1-peter.maydell@linaro.org>
References: <20250723165458.3509150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Our implementation of the helper functions for the LD1Q and ST1Q
insns reused the existing DO_LD1_ZPZ_D and DO_ST1_ZPZ_D macros.  This
passes the wrong esize (8, not 16) to sve_ldl_z().

Create new macros DO_LD1_ZPZ_Q and DO_ST1_ZPZ_Q which pass the
correct esize, and use them for the LD1Q and ST1Q helpers.

Fixes: d2aa9a804ee ("target/arm: Implement LD1Q, ST1Q for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index d0fb4138d21..c4aaf0cc45f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -7219,6 +7219,20 @@ void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
                   off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
 }
 
+#define DO_LD1_ZPZ_Q(MEM, OFS, MSZ)                                          \
+void HELPER(sve_ld##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,       \
+                                 void *vm, target_ulong base, uint64_t desc) \
+{                                                                            \
+    sve_ld1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 16, 1 << MSZ,         \
+              off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);       \
+}                                                                            \
+void HELPER(sve_ld##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
+    void *vm, target_ulong base, uint64_t desc)                              \
+{                                                                            \
+    sve_ld1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 16, 1 << MSZ,        \
+                  off_##OFS##_d, sve_ld1##MEM##_host, sve_ld1##MEM##_tlb);   \
+}
+
 DO_LD1_ZPZ_S(bsu, zsu, MO_8)
 DO_LD1_ZPZ_S(bsu, zss, MO_8)
 DO_LD1_ZPZ_D(bdu, zsu, MO_8)
@@ -7283,8 +7297,8 @@ DO_LD1_ZPZ_D(dd_be, zsu, MO_64)
 DO_LD1_ZPZ_D(dd_be, zss, MO_64)
 DO_LD1_ZPZ_D(dd_be, zd, MO_64)
 
-DO_LD1_ZPZ_D(qq_le, zd, MO_128)
-DO_LD1_ZPZ_D(qq_be, zd, MO_128)
+DO_LD1_ZPZ_Q(qq_le, zd, MO_128)
+DO_LD1_ZPZ_Q(qq_be, zd, MO_128)
 
 #undef DO_LD1_ZPZ_S
 #undef DO_LD1_ZPZ_D
@@ -7632,6 +7646,20 @@ void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
                   off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
 }
 
+#define DO_ST1_ZPZ_Q(MEM, OFS, MSZ)                                     \
+void HELPER(sve_st##MEM##_##OFS)(CPUARMState *env, void *vd, void *vg,  \
+                                 void *vm, target_ulong base, uint64_t desc) \
+{                                                                       \
+    sve_st1_z(env, vd, vg, vm, base, desc, GETPC(), 0, 16, 1 << MSZ,    \
+              off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb);  \
+}                                                                       \
+void HELPER(sve_st##MEM##_##OFS##_mte)(CPUARMState *env, void *vd, void *vg, \
+    void *vm, target_ulong base, uint64_t desc)                         \
+{                                                                       \
+    sve_st1_z_mte(env, vd, vg, vm, base, desc, GETPC(), 16, 1 << MSZ,   \
+                  off_##OFS##_d, sve_st1##MEM##_host, sve_st1##MEM##_tlb); \
+}
+
 DO_ST1_ZPZ_S(bs, zsu, MO_8)
 DO_ST1_ZPZ_S(hs_le, zsu, MO_16)
 DO_ST1_ZPZ_S(hs_be, zsu, MO_16)
@@ -7668,8 +7696,8 @@ DO_ST1_ZPZ_D(sd_be, zd, MO_32)
 DO_ST1_ZPZ_D(dd_le, zd, MO_64)
 DO_ST1_ZPZ_D(dd_be, zd, MO_64)
 
-DO_ST1_ZPZ_D(qq_le, zd, MO_128)
-DO_ST1_ZPZ_D(qq_be, zd, MO_128)
+DO_ST1_ZPZ_Q(qq_le, zd, MO_128)
+DO_ST1_ZPZ_Q(qq_be, zd, MO_128)
 
 #undef DO_ST1_ZPZ_S
 #undef DO_ST1_ZPZ_D
-- 
2.43.0


