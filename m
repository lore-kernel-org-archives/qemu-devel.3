Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1E1C02198
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 02:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgxSS-0000Gi-Qk; Sat, 08 Feb 2025 21:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgxSR-0000Fe-1d; Sat, 08 Feb 2025 21:54:07 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgxSO-0001Eo-FD; Sat, 08 Feb 2025 21:54:05 -0500
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2f9ba87f5d4so4667307a91.3; 
 Sat, 08 Feb 2025 18:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739069641; x=1739674441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OECC3Kx/J6h+c9zd/MNgk5sxZHcHGBgSRgIZ+2LsnqU=;
 b=qMBwLlRoO/2FJLxUbt60G9WV6GegjCcEBSRTsCckLmTD9oqP3zHTAJq1CQquNdlDBE
 /CXTlstwhPWgxvdMnkIkIpr+w+gsIBCXJUN/zgPR5/7ReT9hg2Vp1sVfWFBKzENkgHH1
 f3hA6qGZ1gb594Lm+mU+1iEv/kQMjlgsAzXABNrl5JSjuNwibIRjcvTBaLTjfA3UAjqD
 CoJnfxBDWnqmbQerjq/VtX5l4d+V+hHTJt/43ofIMYXRIJxosPOw3Z9cnuI71wkjIobF
 Mcg+tnL8a21c/6IVStn0jftCei0HBlow2evQogdYXOwP8c2aARL+y8lZbo2wbHb4ZY0k
 2hOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWPmPQp0o59amrqeNeg7ERe4N4ujhKZsx1x8WNpHB2+44z4mAIjMVCzSUqTpG0+PhRQvfAQ3FzsQ==@nongnu.org
X-Gm-Message-State: AOJu0Yx+W8T/4ZarcZ5oSNqpUjZSWHhZ3gPzzP157I8aGOAKURTZ/bix
 bAhxErjjxQwmVKmcOGlqkqEj6gRRE9ZWiDxxIHx1/DwztmRdE+VB07ESc0i1
X-Gm-Gg: ASbGncs3Wxo6J4QS+kIFS/JR9ZztcygAIXKWx9xrcIIlhw2tjyukyeKZhWN9PDNQYpc
 gbsCIz6TpspXaoAcUpqNFaF7SXOM13LDTLVUlBxl3Tr/kQbDEMPtdA+ZIw1WPdKVzUL/ZKdzv7V
 mkR7+ATSNrWrE0Y8RBZr1P6oi91QPvxodXSqq2DYY1wjSLEm+eGdofoMyS9ZylZQyAmCb/8aE3T
 55B561SdrGdOahyZybXWYTtaDk0AAnhxgm5Ub41T3K/OhMIoy/X/N66WZ4urueKW7Q+WPxwV91S
 o5gcvToA1zSbWkbGg8YRz032HAvFypRty3TUWXhovHvu4+4=
X-Google-Smtp-Source: AGHT+IElRIL+zFthLR00itAg66E0dO2mHuhyoihchVSUQvU73mKip+S4aRBMkOwcJvUQBxf+Qm1iOA==
X-Received: by 2002:a17:90a:f94f:b0:2ee:96a5:721c with SMTP id
 98e67ed59e1d1-2fa2417c12fmr12141832a91.21.1739069641393; 
 Sat, 08 Feb 2025 18:54:01 -0800 (PST)
Received: from localhost.localdomain
 ([2607:fb90:9e97:4903:dc10:4530:8a3f:fdb6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f5786a07bsm33070645ad.115.2025.02.08.18.54.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 18:54:00 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH] hvf: arm: sign extend when SSE=1
Date: Sat,  8 Feb 2025 18:53:58 -0800
Message-ID: <20250209025358.43533-1-j@getutm.app>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.51; envelope-from=osy86dev@gmail.com;
 helo=mail-pj1-f51.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

According to the ARM manual, when SSE=1 the data item must be sign
extended.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 target/arm/hvf/hvf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0afd96018e..28886970c9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1876,6 +1876,11 @@ static void hvf_sync_vtimer(CPUState *cpu)
     }
 }
 
+static inline uint64_t sign_extend(uint64_t value, uint32_t bits)
+{
+    return (uint64_t)((int64_t)(value << (64 - bits)) >> (64 - bits));
+}
+
 int hvf_vcpu_exec(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -1971,6 +1976,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         bool isv = syndrome & ARM_EL_ISV;
         bool iswrite = (syndrome >> 6) & 1;
         bool s1ptw = (syndrome >> 7) & 1;
+        bool sse = (syndrome >> 21) & 1;
         uint32_t sas = (syndrome >> 22) & 3;
         uint32_t len = 1 << sas;
         uint32_t srt = (syndrome >> 16) & 0x1f;
@@ -1998,6 +2004,9 @@ int hvf_vcpu_exec(CPUState *cpu)
             address_space_read(&address_space_memory,
                                hvf_exit->exception.physical_address,
                                MEMTXATTRS_UNSPECIFIED, &val, len);
+            if (sse && len != sizeof(uint64_t)) {
+                val = sign_extend(val, len * 8);
+            }
             hvf_set_reg(cpu, srt, val);
         }
 
-- 
2.41.0


