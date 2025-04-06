Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA814C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2q-0002za-Mv; Sun, 06 Apr 2025 03:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2Y-0002uk-NS
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2X-00021W-5w
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7WTuSvrd8VXQp36HuA065LAelG1aB+o9KpAd4Np8Es=;
 b=Z709vl8Zzl8el5ASFg73D+vjGPdqTXPGlJvlisF9vrqr7K/SoVMSrYJbgk5VSvg+zNdXYV
 Ud7A9Cta45RiADc8pH3hcyg07qFvoLEv4pB4sdEnC2IOD/44Ayg9NL4qUE/bjq6mN+7Xxh
 q1X+YPK5MgPomh6A3AbOvFfWkIc0kSo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-yr3r6YuuNZ29KI4eASGKGA-1; Sun, 06 Apr 2025 03:03:29 -0400
X-MC-Unique: yr3r6YuuNZ29KI4eASGKGA-1
X-Mimecast-MFC-AGG-ID: yr3r6YuuNZ29KI4eASGKGA_1743923008
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so25504825e9.2
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923008; x=1744527808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7WTuSvrd8VXQp36HuA065LAelG1aB+o9KpAd4Np8Es=;
 b=QhpewlZIn2QW8FmTCEGOyR883t+8zCpS7CWITO1eYVfjDa8CAY+Vx0zhYQO5SRM/py
 dvhCRWP37SX02Wi3sd3VGlu5AY/pSQwq3gU8u5lnL9TnPYSjJcfmBiiSvIVTJAbfQf6c
 wE9uL0KfKFJ2taBEmnxtsWLbP8yKlXnuUG4Koi+ziSaLsWfTPYKvfAL1b6yBxpr10tPV
 /9I8sl/PQbL9KiVRksxizehZjdNtVu2pMqIdLkclSBoFPncSV0vdtpRD5Z0jhH3VxVSu
 CkbxSHLhurcb6RLw29gItqTvrdSagBfJGr0igyCzpPWTLSiljkDLButduYDhbOQlPi6C
 Op0Q==
X-Gm-Message-State: AOJu0YxmTJhIFXs4Ukxw9TN3/hvHe963zByNLd7YPkofA7u6yJKGDgLL
 0n9t+uKISVK1xOiCagUNvMsuo++RraM8Vsw31DlEiXCIUVchW1HA4kxwTXGY1HBjBsJLffgLkJz
 EQGLHO9RgVmQpwQnUuW9GLo3xiGNHF6erVFbhGNgOwb2bf23o1oPMYOxTtcTkp1KIQvObRfQb2r
 6RZoctQk9IRV2zdxEuHsTCbaZNV08oTLnK805o
X-Gm-Gg: ASbGncsn9v1nBK62nQRel32ChYuEeto/2QJ/Nnj8n0tWWedRmqsCw48gf3Q2HlmbUa8
 eOVm5zAxCMpjYM7szQv1I0TgjjGAkPSxEQ8llJXBhRPv8reguR5qBaUZHscpxEAA83JOGedrySv
 I4zqlh90Jjoo2+XW7h0htvC/uXZB4NfJ54NuGqRanJeRvhcdkFf6/CAmDoYVQlBuScuvKuKnJT2
 UKQoFuDq27C6hezZiO36TFaCFFWKdteCItzss4yfXYsyYUjqFxKJ2tQJgTzfgqmgRvfw1ROMhLC
 eNd3/uMLR26Yw01q4g==
X-Received: by 2002:a05:600c:1d0d:b0:43c:ec28:d310 with SMTP id
 5b1f17b1804b1-43ee063da68mr55198895e9.10.1743923007781; 
 Sun, 06 Apr 2025 00:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqV/XJOq9pyp2BJRBZbl2idBYITb/OVDnf9mr7Vv7anVtfb4582tyI4JXlUIc1AWHSa36Mzw==
X-Received: by 2002:a05:600c:1d0d:b0:43c:ec28:d310 with SMTP id
 5b1f17b1804b1-43ee063da68mr55198605e9.10.1743923007350; 
 Sun, 06 Apr 2025 00:03:27 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34ae0c5sm91704195e9.15.2025.04.06.00.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 11/27] target/riscv: include default value in
 cpu_cfg_fields.h.inc
Date: Sun,  6 Apr 2025 09:02:38 +0200
Message-ID: <20250406070254.274797-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation for adding a function to merge two RISCVCPUConfigs
(pulling values from the parent if they are not overridden) annotate
cpu_cfg_fields.h.inc with the default value of the fields.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h            |  2 +-
 target/riscv/cpu_cfg_fields.h.inc | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e9bf75730a6..aa28dc8d7e6 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -23,7 +23,7 @@
 
 struct RISCVCPUConfig {
 #define BOOL_FIELD(x) bool x;
-#define TYPED_FIELD(type, x) type x;
+#define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
 };
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index bbc68276737..ef58826b2bc 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -2,7 +2,7 @@
  * Required definitions before including this file:
  *
  * #define BOOL_FIELD(x)
- * #define TYPED_FIELD(type, x)
+ * #define TYPED_FIELD(type, x, default)
  */
 
 BOOL_FIELD(ext_zba)
@@ -153,19 +153,19 @@ BOOL_FIELD(misa_w)
 
 BOOL_FIELD(short_isa_string)
 
-TYPED_FIELD(uint32_t, mvendorid)
-TYPED_FIELD(uint64_t, marchid)
-TYPED_FIELD(uint64_t, mimpid)
+TYPED_FIELD(uint32_t, mvendorid, 0)
+TYPED_FIELD(uint64_t, marchid, 0)
+TYPED_FIELD(uint64_t, mimpid, 0)
 
-TYPED_FIELD(uint32_t, pmu_mask)
-TYPED_FIELD(uint16_t, vlenb)
-TYPED_FIELD(uint16_t, elen)
-TYPED_FIELD(uint16_t, cbom_blocksize)
-TYPED_FIELD(uint16_t, cbop_blocksize)
-TYPED_FIELD(uint16_t, cboz_blocksize)
+TYPED_FIELD(uint32_t, pmu_mask, 0)
+TYPED_FIELD(uint16_t, vlenb, 0)
+TYPED_FIELD(uint16_t, elen, 0)
+TYPED_FIELD(uint16_t, cbom_blocksize, 0)
+TYPED_FIELD(uint16_t, cbop_blocksize, 0)
+TYPED_FIELD(uint16_t, cboz_blocksize, 0)
 
 #ifndef CONFIG_USER_ONLY
-TYPED_FIELD(int8_t, max_satp_mode)
+TYPED_FIELD(int8_t, max_satp_mode, -1)
 #endif
 
 #undef BOOL_FIELD
-- 
2.49.0


