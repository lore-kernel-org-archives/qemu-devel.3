Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191E4C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQvL-0006ha-ON; Tue, 18 Feb 2025 11:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvB-0006fB-BH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkQvA-0004Oa-20
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739897887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+esdwiismL0ZSGv8f69YhOdOOMZ1fy6AECAR1NtpDpo=;
 b=iYFUTQmplNns3WXujBbH9U+ZZ2nZJSVqYqtSKyNHXcxNpTC2Iu5ipooj5uXxfWQQMMtyRg
 yXAcFV7l6PTbw0qQ7qUaU0vZw1+qecp7FYB646ITNULKpgTgWDgPMupmH7GVe6eNKkFMWT
 1Dt+Y195KvN4iVUZb/A6/83QXwVUscM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-rDHLKhyEMN-AJr1l1zklVA-1; Tue, 18 Feb 2025 11:58:06 -0500
X-MC-Unique: rDHLKhyEMN-AJr1l1zklVA-1
X-Mimecast-MFC-AGG-ID: rDHLKhyEMN-AJr1l1zklVA_1739897885
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43935bcec79so34089535e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897884; x=1740502684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+esdwiismL0ZSGv8f69YhOdOOMZ1fy6AECAR1NtpDpo=;
 b=Lk7ER430xHEmKpIQm40Doe1DhD/Nved6GErXoXyIU+bsxHWXoSawzfjcj1XdwT4Qar
 O7O5LU3EKgzqXEhXHG8QJPopC0clqc86Mi9o/oX9mM4jcavwGkjLSkFdbTESvNdCLUTB
 j5aUGkJ88dxMq5gG5qpC+tcuxY2R2QYOyz6SVDRiKZwtHqkF3lHrJH0gHLDncRA7gnAU
 VZqSXzphj/fznGy/U35JK/py7IDh6g6QDtZc56WGjo42HjXOlONuTF6hXBSpii+wkwg3
 woNKiiXbXDXqb6VPeDS/i4hXvaK682xU3zh80trCeRoKCtuBOmUfFPqjTrIA9FeccXM4
 /NoA==
X-Gm-Message-State: AOJu0YwAS+VhA48FkWslbi1iHpJoqddu/wyyAZ+69f+k0aW9XOOrpslJ
 rP3C0AzNydcJSV6Lkg6DZv9YNBmMgLR2Dlw9IOq72gvhQrlfvpfKu45nrlTGQaVFqSU637F+yho
 eNPT4Lt1zmizVIqWyLqY1GLr242rSmIduAsARttEBPj8piTMlRdCW2QiJD9kj50Lj4vlsfTOIs7
 cpYVcPU3M8UYYUT3uHfySRqczfxTBqmkStaep0v5s=
X-Gm-Gg: ASbGncsAab4nHovx+PO0CEsTFaUNb6Dl+wjqmeeDM0gv9RceEckd8Xv8I3+nfAVz8gq
 LfhFAJkKJ4JzVmB3oUiFJGuyz6Dlmho2Mr4IAUBqwdg9/Hgsxybu3nLU7S9cYxUCWiXmfD+2zul
 3PJiFsGvR1YHw4Myrx4y9wjQrzHOxz++1XH/5fYYQHqT/sUPCrDf8/kjuaryHRhUK2sfGsy/gcG
 y2yQ7OxU6gg8mvwhjfB7OFeX242wUF2OUqsiRsAyM8kJac1/ahLfBW/C7PlNMksdJBOoSM39kd7
 gMXqj0aazhM=
X-Received: by 2002:a05:600c:3b0f:b0:439:8c80:6afd with SMTP id
 5b1f17b1804b1-4398c806de1mr52570235e9.26.1739897883678; 
 Tue, 18 Feb 2025 08:58:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEmCNoRhJ6GyLeURPKFT7LPObFUDCLIxYC/yQ23KPIJTGfj19ax9Kp6atg+IYUl54UUN24vA==
X-Received: by 2002:a05:600c:3b0f:b0:439:8c80:6afd with SMTP id
 5b1f17b1804b1-4398c806de1mr52570075e9.26.1739897883288; 
 Tue, 18 Feb 2025 08:58:03 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43983264ef8sm67690685e9.4.2025.02.18.08.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:58:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 3/7] target/riscv: assert argument to
 set_satp_mode_max_supported is valid
Date: Tue, 18 Feb 2025 17:57:53 +0100
Message-ID: <20250218165757.554178-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218165757.554178-1-pbonzini@redhat.com>
References: <20250218165757.554178-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Check that the argument to set_satp_mode_max_supported is valid for
the MXL value of the CPU.  It would be a bug in the CPU definition
if it weren't.

In fact, there is such a bug in riscv_bare_cpu_init(): not just
SV32 is not a valid VM mode for 64-bit CPUs, SV64 is not a
valid VM mode at all, not yet at least.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cca24b9f1fc..7950b6447f8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -442,6 +442,8 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu,
             cpu->cfg.satp_mode.supported |= (1 << i);
         }
     }
+
+    assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
 }
 
 /* Set the satp mode to the max supported */
@@ -1502,7 +1504,9 @@ static void riscv_bare_cpu_init(Object *obj)
      * satp_mode manually (see set_satp_mode_default()).
      */
 #ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV64);
+    set_satp_mode_max_supported(RISCV_CPU(obj),
+        riscv_cpu_mxl(&RISCV_CPU(obj)->env) == MXL_RV32 ?
+        VM_1_10_SV32 : VM_1_10_SV57);
 #endif
 }
 
-- 
2.48.1


