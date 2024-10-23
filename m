Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971FCD2E00B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 02:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3QpF-0001XZ-AM; Tue, 22 Oct 2024 22:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t3QpB-0001XG-Lg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 22:10:13 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t3Qp7-0007dZ-Ln
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 22:10:11 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7180f2f5fb0so3201065a34.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 19:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729649408; x=1730254208;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcW/CUwOVFNCzVyQxL/mv8bi+/kDzT9IfUfKurNJVmk=;
 b=PDxssTyIJMCTHY0jdEVQqAHdM9yPviC0XTL5O5LMoybET2Lcbg48Pt2Ao3RL3yBD9G
 5bFk3Fb3gA9bO05UpqJu5Qj/jDjjyUxOejvgVkOfwHOdJSbgi+lSt46t/8a5ZCj8j+tc
 pDJJ79BjPtbPeWmCQcmbyllk+GC9svj16xVm/XvKiBaYDomjLDxkF1DHUFaY4V6n7mgX
 TMuF/PZScOVTFqL3eedwfYm5i6vDxLXKoLb8v9cFCtn9QA3Tcsjh6ArJjMTGJ050S+85
 Ri42eiljyVnpkj3M2FMzw73CNkdb6eFI3QgQYzerZYHGq4gBxGsany27ZcGjgdJ92os7
 uoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729649408; x=1730254208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcW/CUwOVFNCzVyQxL/mv8bi+/kDzT9IfUfKurNJVmk=;
 b=HvOLs0oaFPplKvulAqZnj05fpWK3C95imsvIsxtUQtVqkq+Z5HZfAA3V85ystlMuV5
 zlDDBW2PPJDVs6MHKiQ8kDCimw8O2yKfhESFGZXltg2+tWEb0ikYGhMm1MqvFN82o7z7
 hUIIMcYyLF1mx236wf9HUJEDmhls83lPoEhQ14+1vzsK56kdx9qfacQaNk7JnxmWhdBG
 7Sio3LTPcmbCVWwM4K8LasnsELo7Al0qkZdrZ0pWp03iBBGEKffnrO3T/3pp2pd6Sai/
 huw3jrXbDbmmMcHbBQkJwnoLa4cUP1g/upkV4FXogWKox8sx87yh3L2TDXKT/M3/789o
 jXYA==
X-Gm-Message-State: AOJu0YwrGVMarFvfODdhEBT9pcxW4PX4rp5M+UBm4DtcmHyGPQBmWY++
 qoX0D8wxRCY5+FnDDJE1nRdDufQCD6UFPMIZjx2X79FjX8+QhkF9662ZtNnWUUCFkp3yWM/DhgZ
 LiPF3iQ==
X-Google-Smtp-Source: AGHT+IGKHxHiu3vXEONduE4iDUz/KshhtlVz+8STFHvcTODS+BeaeV8m0FKdtbEtHp3x8AST6iWxdA==
X-Received: by 2002:a05:6830:628d:b0:718:1235:8b8a with SMTP id
 46e09a7af769-7184b330c4fmr1381320a34.21.1729649407475; 
 Tue, 22 Oct 2024 19:10:07 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.198])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab5839dsm5861849a12.47.2024.10.22.19.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 19:10:07 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RFC 1/2] accel/kvm: Introduce kvm_dirty_log_manual_enabled
Date: Wed, 23 Oct 2024 10:09:50 +0800
Message-Id: <6df7d9ca9c90cf021857ef4f06b7f59c3664441b.1729648695.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729648695.git.yong.huang@smartx.com>
References: <cover.1729648695.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Introudce kvm_dirty_log_manual_enabled to indicate if dirty
logging manually was enabled in KVM.

The kvm_dirty_log_manual_enabled will be used in the next commit.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 accel/kvm/kvm-all.c  | 2 ++
 include/sysemu/kvm.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5..a0f3e6e493 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -93,6 +93,7 @@ bool kvm_allowed;
 bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
+bool kvm_dirty_log_manual;
 static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
@@ -2537,6 +2538,7 @@ static int kvm_setup_dirty_ring(KVMState *s)
                             dirty_log_manual_caps);
                 s->manual_dirty_log_protect = 0;
             }
+            kvm_dirty_log_manual = true;
         }
     }
 
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index c3a60b2890..f38f2818e1 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -42,6 +42,7 @@ extern bool kvm_gsi_routing_allowed;
 extern bool kvm_gsi_direct_mapping;
 extern bool kvm_readonly_mem_allowed;
 extern bool kvm_msi_use_devid;
+extern bool kvm_dirty_log_manual;
 
 #define kvm_enabled()           (kvm_allowed)
 /**
@@ -143,6 +144,12 @@ extern bool kvm_msi_use_devid;
  */
 #define kvm_msi_devid_required() (kvm_msi_use_devid)
 
+/**
+ * kvm_dirty_log_manual_enabled:
+ * Returns: true if dirty logging manually was enabled.
+ */
+#define kvm_dirty_log_manual_enabled() (kvm_dirty_log_manual)
+
 #else
 
 #define kvm_enabled()           (0)
@@ -157,6 +164,7 @@ extern bool kvm_msi_use_devid;
 #define kvm_gsi_direct_mapping() (false)
 #define kvm_readonly_mem_enabled() (false)
 #define kvm_msi_devid_required() (false)
+#define kvm_dirty_log_manual_enabled() (false)
 
 #endif  /* CONFIG_KVM_IS_POSSIBLE */
 
-- 
2.27.0


