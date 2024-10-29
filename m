Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1455D2AB3D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 13:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ltV-0004QC-H9; Tue, 29 Oct 2024 09:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5ltL-0004Ow-Rc
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5ltJ-0004sA-L5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730207047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WeDRNxekEYihTsixUQdXV3kTi+xv/VScjBpg04RytOY=;
 b=cRG/K4C73IKa3oj0doU5gwtkAGnDgz8Mzvr0quuEWxhxHCc8ocemNUaz8/kFIbPmDYUekY
 HbRLhyDO7bqdre8YKWzpSJu56ZKvHIdm5v0M77dfS5M++WaynGgmJtl5zcUCMKjpd5TuFy
 bDhwLrUq1U6ZgqFsWkfiDJo8CEmMCaI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-8ROoe2nLPZeNlnMu1fOU9Q-1; Tue, 29 Oct 2024 09:04:04 -0400
X-MC-Unique: 8ROoe2nLPZeNlnMu1fOU9Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43163a40ee0so41476915e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 06:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730207043; x=1730811843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WeDRNxekEYihTsixUQdXV3kTi+xv/VScjBpg04RytOY=;
 b=he+dSN9GzPRZ63lhlb5j9svR9bTlWEdHpmQEq5MOchasOEi03REZZeiqrtzQ92MNnL
 +kwhTW0DJfV4IvFVRIX10sDdSJnvOeueNIYGMcf1RMi1XCy9ajWWoU8s4OwpdFCYTwi5
 NmJtNw7IBmzYsksIrkNazmzxRhvspl8OBR96iNFToeBk/YYU+G2GfBvhRB2xCu+NkkIK
 YdjxhZwD9akN5x1Xfq9ZkSXC58mUUZNZdx3K3NDZf/jbewnTsLJTcfXFnyYHB61Yinuo
 h18hTrj5SqBaDqd9ZqnLm+x5S4R1YdRKM7RitcG+y7ZeUU5UFYdJ8sxl+jPWSAUrfOQq
 v5tw==
X-Gm-Message-State: AOJu0YzLvtlAmBbrH9DAFHRenW6zWa/pIXzNdvAvbaP+pv2kJPEhhV4N
 1YFq6dvmAtP3asFaw4yMnx8XdeCzDX9hVLNEodJXYQ/Zp2VJibExlomKnFz33lFaApMrbZhun1C
 y3NQNItkUVRsa6LJ5N2GWhAPf67bqjrtynxYrnro/iB+75l4Z3tpWdgU6qLkGrpubmRGrnQEx47
 sEtHyLlZjzBFtJ6O+Bg8hLCUuhoOF3GLEQe2+79jg=
X-Received: by 2002:a05:600c:5118:b0:426:627e:37af with SMTP id
 5b1f17b1804b1-4319ac7065emr108445005e9.3.1730207042943; 
 Tue, 29 Oct 2024 06:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK1EFXb99xDPMzqvKew008+Pkybg4gr34Q4YNdDHg/Kq6Xdm5YvU7HOqH/E9tsOme7bzHvfQ==
X-Received: by 2002:a05:600c:5118:b0:426:627e:37af with SMTP id
 5b1f17b1804b1-4319ac7065emr108444245e9.3.1730207042254; 
 Tue, 29 Oct 2024 06:04:02 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm143353545e9.44.2024.10.29.06.04.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 06:04:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386/hvf: hide MPX states from XCR0
Date: Tue, 29 Oct 2024 14:04:01 +0100
Message-ID: <20241029130401.525297-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

QEMU does not show availability of MPX in CPUID when running under
Hypervisor.framework.  Therefore, in the unlikely chance that the host
has MPX enabled, hide those bits from leaf 0xD as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index e56cd8411ba..4b184767f4a 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -110,9 +110,9 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
         if (idx == 0) {
             uint64_t host_xcr0;
             if (xgetbv(ecx, 0, &host_xcr0)) {
+                /* Only show xcr0 bits corresponding to usable features.  */
                 uint64_t supp_xcr0 = host_xcr0 & (XSTATE_FP_MASK |
                                   XSTATE_SSE_MASK | XSTATE_YMM_MASK |
-                                  XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
                                   XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK |
                                   XSTATE_Hi16_ZMM_MASK);
                 eax &= supp_xcr0;
-- 
2.47.0


