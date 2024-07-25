Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2223C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8If-0004k3-12; Thu, 25 Jul 2024 19:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Id-0004aA-DS; Thu, 25 Jul 2024 19:55:07 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ib-0000m0-LS; Thu, 25 Jul 2024 19:55:07 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so301235a91.0; 
 Thu, 25 Jul 2024 16:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951703; x=1722556503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mop112vd42nzsXR5SxpQiWNuj10AcG+7wfZ1FcSPXq0=;
 b=b2bsH8thuABGD0qZ0esOZ+UMsmkO6GfdjYVRZ9tEmSPQ2MDjiLguXmlmb2mum9+zQM
 mPXiGFDDgUmb97GK9m6twShLkrYlePW0Tq0TGZhc2ZwwQZ3XSLNjX4aR+F4TtTH5uZth
 NfdqZ4WLS04hw5M9Z9JLJdxbbw1O1o/UjuVzjoczQxWpYB4YD0vu3lj7unf6+MimxoRN
 knN8H0HiY+VZqDaMjzME2X2c09Uw0DoDxNRhssduLsciFk3nZjNCOjeQqOp6yVzHLcZQ
 WHwy/mRm1Wi/lqRCjFjQQxrGzPzW8+l5o51zWOZ9qtIqBZ7+OBwGunEvTXwB+QdJQIgr
 iYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951703; x=1722556503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mop112vd42nzsXR5SxpQiWNuj10AcG+7wfZ1FcSPXq0=;
 b=Ti7bdyKQvzw+yYiRwZzpjbyFDlFlpYhFif9kb3QFhDU914jXjIYrswPueWCEPvUksK
 96aanwuNCkFVA/HUEz4bACkaBgG7zkaFN15dyv3YqxGSymiFNYiCH9zkFtZj7LCFzbS8
 PZ/AR0fVS5y9ZZw0+6jnq+a0olWI99+6kix4vGfXBtVK5vLHtDq9XdM5FXMjmr02zL7a
 1PBqwrir9G0V9fDDpSxIfRL0Kmn2zSUZJ1NHnVuTGTgDENDS8LF9LTQw+IZFbZCGem+J
 QgDiGs95ihx5LBNLUa2bFQDH0hVSL0lMagcFyHO4M+9fUWMTjjJXJ1f4CYvQzMvgUzkX
 BFMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2OkZCH3ums6OxH83A491zKi+1h1mJs0n3G7BwQ9JWPODFVk34Y/nW7Mh0d9dGrxpv1eYvNVRbJVKn0O339wztBrLR
X-Gm-Message-State: AOJu0YzTcdQd+n2tyy6lj1h5LkPy5kQ+cBSR8RHpuxgD32icNbPZeKA4
 3Xwv1Xva84VVVbIqqUf324kX9iXUcgw7bKecciWg/fjZ4r/mXogLR8TLNg==
X-Google-Smtp-Source: AGHT+IFFCk9pr7aXkG6RPlKBd0Wx55eCbICyqmXXxsccu691tAA5Gd3wRUNmBdFKRGXQD5ztRJdmGg==
X-Received: by 2002:a17:90a:ba89:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2cf2e9ab041mr3911897a91.5.1721951703230; 
 Thu, 25 Jul 2024 16:55:03 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: [PULL 09/96] linux-header: PPC: KVM: Update one-reg ids for DEXCR,
 HASHKEYR and HASHPKEYR
Date: Fri, 26 Jul 2024 09:52:42 +1000
Message-ID: <20240725235410.451624-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

This is a placeholder change for these SPRs until the full linux
header update.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 linux-headers/asm-powerpc/kvm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 1691297a76..eaeda00178 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -645,6 +645,9 @@ struct kvm_ppc_cpu_char {
 #define KVM_REG_PPC_SIER3	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc3)
 #define KVM_REG_PPC_DAWR1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc4)
 #define KVM_REG_PPC_DAWRX1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc5)
+#define KVM_REG_PPC_DEXCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc6)
+#define KVM_REG_PPC_HASHKEYR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc7)
+#define KVM_REG_PPC_HASHPKEYR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc8)
 
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
-- 
2.45.2


