Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A233C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtz9-0007Ob-Hd; Fri, 30 May 2025 03:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwx-0002mY-MG
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtww-0006zl-2n
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HbLb3H2jBZcMJMch8FTFxOlzVNoTW2d20cM59CCIjs=;
 b=R4S4Sz/iBbqYmTAjkf5n7qb3lvfRX4FfMq7kfZBuW1c6q6rBudn9lnoZjynsKTa25psxJv
 VK9d1xV/b8I2j6gewizGAkn7iPgiNnjwcQnZi2vQzUa4V5aV3HTg+K18nG2pGSqC9cLnv7
 iOEIczeLDddrOFytu+qrOXJWNH0DAbs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-hqroKK6lO9KmnYLXmgzRGw-1; Fri, 30 May 2025 03:14:39 -0400
X-MC-Unique: hqroKK6lO9KmnYLXmgzRGw-1
X-Mimecast-MFC-AGG-ID: hqroKK6lO9KmnYLXmgzRGw_1748589279
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-604fe4c3130so1406985a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589278; x=1749194078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/HbLb3H2jBZcMJMch8FTFxOlzVNoTW2d20cM59CCIjs=;
 b=euwqwyfFleS1Qi3+J8leWVN1NglAWNmYtBSZMuG+MsSBi8d4XP8LXoErGpk8rsGXCK
 QLctH9kE9vbnjML2oSniUPlou+YXEuL86yPJ4T3Fm3dcF1mi7/984TqXeF8kXcwQQld9
 BxrUTB8DpniQeZ2RSK042ZIv52JOmfr9dgKH/xBx1xdUtk97LJqlEcCVvlts7NA9MIFN
 ap/ttg5hoAMdvDU31qMPd4H6fYsWqyHDSF/gDWlXS5Pf/YERADYRq6HlZs2l8FVjnTLB
 g3jmwAu4tHCJx/zA6U2+n6EBMk42iqydDxcsmQWBKXQG6TtGMOCm34Ga+O9VAbINGM3e
 D+Hw==
X-Gm-Message-State: AOJu0YxTfkY6V752343mutCdjGtLYFfrDCT/m57uhzH/ruww09dqEXjW
 TlzvgO5DriF3qAC5Rl4HZKWXk/XMV39W/PHmr9uI8BGbjj2kHs5YSGdCEYIxgaiJbuEUVV1j3EO
 fdxYhCCMmYnbn7Ff+qkAL1a+bf/68sggiHFhSCB2tcxpFsf2vw9VS+OggWDtaAXqP6oSlbo3xiA
 KdsKAryBiXwV1+qH63JbD9qg6c64ecBhGZoU/Xr3Um
X-Gm-Gg: ASbGncs1OqvGDQcCk0AJqmggROUmU1FL8LDT74absqM1Z/REfq/B7edfRdwCxPjr0+h
 3QavomcI4xEIHr5De/tcXYtQxt12G0t4iHnSH6WYGtTmFmgoXCFd8WkyvNizOVKIVD5e6MQogGL
 jzirWI3o+/zjDQQohq5IL63zkqTy/LuPfSW3WpyF64MQvfh5SbBlGmERqANrZMp0t7PjPdxprZU
 FNmWul9A2yH2f7mL/8oHWtP4SvVU6adQtVn0RGhpWImMBcwwLfctTCON2qlWtctwNWQGxWkMX3i
 m/ccsChbnjLqGQ==
X-Received: by 2002:a05:6402:2692:b0:601:e385:e484 with SMTP id
 4fb4d7f45d1cf-6056dd39ad7mr1963629a12.10.1748589277838; 
 Fri, 30 May 2025 00:14:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmAAz3kyfimRUu/TfXCCwrxCLK3yE6BVWyBQTgrXBU8qg5NojdTgimiNB5pt64maq+Z28YEw==
X-Received: by 2002:a05:6402:2692:b0:601:e385:e484 with SMTP id
 4fb4d7f45d1cf-6056dd39ad7mr1963609a12.10.1748589277434; 
 Fri, 30 May 2025 00:14:37 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c5bed1sm1195594a12.26.2025.05.30.00.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 42/77] kvm: Check KVM_CAP_MAX_VCPUS at vm level
Date: Fri, 30 May 2025 09:12:12 +0200
Message-ID: <20250530071250.2050910-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

KVM with TDX support starts to report different KVM_CAP_MAX_VCPUS per
different VM types. So switch to check the KVM_CAP_MAX_VCPUS at vm level.

KVM still returns the global KVM_CAP_MAX_VCPUS when the KVM is old that
doesn't report different value at vm level.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-31-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 42d239cf8f2..71e60604585 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2431,7 +2431,7 @@ static int kvm_recommended_vcpus(KVMState *s)
 
 static int kvm_max_vcpus(KVMState *s)
 {
-    int ret = kvm_check_extension(s, KVM_CAP_MAX_VCPUS);
+    int ret = kvm_vm_check_extension(s, KVM_CAP_MAX_VCPUS);
     return (ret) ? ret : kvm_recommended_vcpus(s);
 }
 
-- 
2.49.0


