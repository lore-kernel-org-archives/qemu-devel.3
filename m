Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88449CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKsK-00067M-8T; Wed, 27 Aug 2025 14:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqy-000513-BQ
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqj-0005qG-BI
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/uc1qYC35Kqg7WBhThcqVbG6uu5j1gWEoCb6hPoniI=;
 b=Mge2+KcWGWC6RV7QfotuJuD1zU5sZIujzkFz/jX7Znb17gNonXL7Re3v3+TYUoE1x6fpLz
 zA/miT8jO17EZuJZd8LzUU2CzYX94SjPbqNhWQy0x+Dugh5Y4EnPBzXDGk0YzfcKh/InvX
 znqBEmBm2y5tlSphldq0NEIVsUn/3Qg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-SIqtEin8NgqXan5g3NMgHA-1; Wed, 27 Aug 2025 14:26:12 -0400
X-MC-Unique: SIqtEin8NgqXan5g3NMgHA-1
X-Mimecast-MFC-AGG-ID: SIqtEin8NgqXan5g3NMgHA_1756319170
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b0b14daso442565e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319165; x=1756923965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/uc1qYC35Kqg7WBhThcqVbG6uu5j1gWEoCb6hPoniI=;
 b=EmBhF/+KyST0oSQrW5lON/cjT/gR0KmH3m7KxzBdhHc6rvKpp0f63v0zawIJjbB3Cz
 S2ToQ28OAr9JIJLd8lAAvnLtOVGO0aPWLAsZXsIxKudpMG9ivARFQ3/1fudPRr8ZKyDY
 1M+o1ciMeW83lrqCWtJsuOnM0GC//ZOQXSnTSX7Q0YdqVD7JtoT5wWUL17dgVWPOn2ec
 MpBmQJIqHoZAlRm2sOAHfMoeuQ+Ibm5gXP7J8AenjkAuLJH8boDpmRBnPyU6swNf86+y
 rrPi2zqeq7ejToUETDuWhvu8u5UhTrqUnI+siNE/KaMipM79QjculmTOEZbOE9qFsqGM
 rgQg==
X-Gm-Message-State: AOJu0YxtpUA+CiZxY+3f37cvKg7sUMltCer8fLdDbSIT4k5OcNiQqure
 M8W3/+6NvWhm25buINqxtCI8ZHPNvkIJLQW8CAriEVXbwv7z0L5fLJPAVy42Sf8U2tWr4tkezuC
 JH75uTSWQ8RwNAJGhrWGVtfHCddHimZBZh4cr+efsrTMG/1xweFYMWXNvWQPXk14RYs3TXrtGsJ
 MLPFVkfKBTk3usvOwk5QDYIaNIbGc0vZ8hJB3tqbD8
X-Gm-Gg: ASbGncsXQImZRRBAGVifmEBVinhh2Q06dBUQQlUNgI2BJoFfPZla4XPr+9R2FUqT1i8
 1xf2vLEgcVvNT5eqcbfHKbsmKVMAzgQLxlN0OV4dZiCnz77FYoMbUevN85bnu3YQtkqZlVbWLzp
 pAt57SFkDUhW63KIMcmiBK4o8L+mHnle6whXtLoEv4hejD7KeISPuEOqrQGlXU1Msu6A8442tUJ
 e3dV1+p3YUr9wt9EMwvfOB0VwS5iLuAOZS9k4uhLpPNAt8A6PTkuaQQpeYgJ7/1Mf2oZVdCWA9H
 BiNoTdgTkf1O4BcMXpmZlMNwsgt5F+MmqFrBVkuZaQPhXYPg2Api+4rAWNE+xIxPeq+ttDFaXyX
 cGZt/9n+esf2VaUEf0H3krKsBTneJgwfLjuKGm7df8sY=
X-Received: by 2002:a05:600c:3149:b0:456:28f4:a576 with SMTP id
 5b1f17b1804b1-45b517dd9a3mr156841035e9.27.1756319164909; 
 Wed, 27 Aug 2025 11:26:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRdhCR1ll4NZa0A7fixYVw/l3hw1dMLIZe/tVXX6jmP4tsrMKXDpkOau3TNfgqMwp+1wcRMQ==
X-Received: by 2002:a05:600c:3149:b0:456:28f4:a576 with SMTP id
 5b1f17b1804b1-45b517dd9a3mr156840675e9.27.1756319164302; 
 Wed, 27 Aug 2025 11:26:04 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0e048asm39534665e9.11.2025.08.27.11.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:26:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Vikrant Garg <vikrant1garg@gmail.com>
Subject: [PULL 06/14] x86/loader: Don't update kernel header for CoCo VMs
Date: Wed, 27 Aug 2025 20:25:24 +0200
Message-ID: <20250827182533.854476-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Update the header makes it different from the original kernel that user
provides via "-kernel", which leads to a different hash and breaks the
attestation, e.g., for TDX.

We already skip it for SEV VMs. Instead of adding another check of
is_tdx_vm() to cover the TDX case, check machine->cgs to cover all the
confidential computing case for x86.

Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250814092111.2353598-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index b1b5f11e739..7512be64d67 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -952,7 +952,7 @@ void x86_load_linux(X86MachineState *x86ms,
      * kernel on the other side of the fw_cfg interface matches the hash of the
      * file the user passed in.
      */
-    if (!sev_enabled() && protocol > 0) {
+    if (!MACHINE(x86ms)->cgs && protocol > 0) {
         memcpy(setup, header, MIN(sizeof(header), setup_size));
     }
 
-- 
2.51.0


