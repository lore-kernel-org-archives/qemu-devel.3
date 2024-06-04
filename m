Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4FFC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwo-0006YG-1L; Tue, 04 Jun 2024 02:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvq-0004aQ-1b
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvo-0007dQ-FU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZ/rj7m6cLO7de6ZysToEWwgEswsxdau5PmjJS2f+S0=;
 b=WMndHJCqcmvWanL6/8rTpGTrk+cQka/zoATbDfc+w80CS+vex/69zNiJMVxQbSwWD0SFhB
 a5k96fgXSc1Pbp9smuEP90RH+6iOt6CZRlSCeIOI2q3hwsCiAzMuvqwyxPfcyze8elGkEA
 WccF1gyZyOzRqEog8LJsiErL5uGcV4M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-NU2cPqtqPeCiLKnx_fBFmQ-1; Tue, 04 Jun 2024 02:46:02 -0400
X-MC-Unique: NU2cPqtqPeCiLKnx_fBFmQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6929fc5b52so45032666b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483561; x=1718088361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZ/rj7m6cLO7de6ZysToEWwgEswsxdau5PmjJS2f+S0=;
 b=ZnD/8yx2gNh1q+Lvhqe/BRhL9oAMiIrL85/nwjNNTU4NFPmSylBgwIWtW9+As8CQma
 NEeAM5TjGJcKQul4MmTZOkrUTzyVzeOq/3+VaHZR9qVPwgRiMhAbNUNQp6fmwdij+daB
 zwvHSS+So8b5JjDoX26Qochi+2iW/1DV7C3I6SLFDJx6uWjBavMGqkK/IrMSU3c3E3iw
 vAS9Jju6U58bsdlYVOGuMTGdG5H6ZCVGDcp9GxDX3pAE45uI7DZv34QahgQmMsGiPoat
 40ZHh9BUfxkpTjchLCmFMDbuL/eJRW/6mwdG0Nu8SWTdtcSlJCcRlKPquwRbP9i2DtZ4
 J2CQ==
X-Gm-Message-State: AOJu0YxeBMOosKIzwVg7ovSH8rIJwfeMjX4a+cWhGh7H6zIbcbsV66Mv
 kpZvHASW5cOfBXO5VcNMNtRjFOBACQpFpl6SfGN3v5Rxm6ZbjyckCflxlTffIT5JNykJFv//YJG
 uy7n152Q0R9LvpnZi/MeJOARZKy3aX3B5QV8vSAVNq9YJC/J8QA0JjolWRBsvkO9pXPq1nA4cRU
 WCQ7373f7WXCPhS+qOPi+sHI7nJvqoapSGgaKt
X-Received: by 2002:a17:906:644b:b0:a64:41ba:e7ee with SMTP id
 a640c23a62f3a-a682022b606mr799117566b.32.1717483561136; 
 Mon, 03 Jun 2024 23:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBuoyF8wBBN8za6E8s5M+GsmQ++6rvnfHmCsUpbdXA/437glGoC0gxH3BCcVABu0WAX/fYGA==
X-Received: by 2002:a17:906:644b:b0:a64:41ba:e7ee with SMTP id
 a640c23a62f3a-a682022b606mr799116566b.32.1717483560807; 
 Mon, 03 Jun 2024 23:46:00 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6866a69125sm542203666b.118.2024.06.03.23.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:46:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 39/45] i386/sev: Enable KVM_HC_MAP_GPA_RANGE hcall for SNP
 guests
Date: Tue,  4 Jun 2024 08:44:03 +0200
Message-ID: <20240604064409.957105-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michael Roth <michael.roth@amd.com>

KVM will forward GHCB page-state change requests to userspace in the
form of KVM_HC_MAP_GPA_RANGE, so make sure the hypercall handling is
enabled for SNP guests.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-32-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index eaf5fc6c6b5..abb63062ac6 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 
 #include <linux/kvm.h>
+#include <linux/kvm_para.h>
 #include <linux/psp-sev.h>
 
 #include <sys/ioctl.h>
@@ -758,6 +759,10 @@ sev_snp_launch_start(SevCommonState *sev_common)
     trace_kvm_sev_snp_launch_start(start->policy,
                                    sev_snp_guest->guest_visible_workarounds);
 
+    if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_MAP_GPA_RANGE))) {
+            return 1;
+    }
+
     rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
                    start, &fw_error);
     if (rc < 0) {
-- 
2.45.1


