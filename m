Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32FFC5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyp-0005w2-4R; Fri, 30 May 2025 03:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtx9-0003Ar-DD
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtx7-00070h-QP
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MAEXlDz/nyqiodlRnx4Z6LTprHwVep0Eypq0CTqZZG0=;
 b=F2FDS6EkvDTc/W8CqO2QKy/H5AKuSAijof8euiV7YNmSGeE8uxj2vULOHCsfkEi+hTgJTp
 0Xs96a4WrWPqrUGiKAzONoLIJdxyB/e7C2uLoLBpEJlwFOuxvDgW1Mw9hEzwkjjZ95Ko/h
 OnxfHeMZJdMXQf6irLt5ZpwwU6DLnRI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-jGEphESwPLmA1OQZd9sq-A-1; Fri, 30 May 2025 03:14:51 -0400
X-MC-Unique: jGEphESwPLmA1OQZd9sq-A-1
X-Mimecast-MFC-AGG-ID: jGEphESwPLmA1OQZd9sq-A_1748589290
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6044cb24c07so1766885a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589290; x=1749194090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAEXlDz/nyqiodlRnx4Z6LTprHwVep0Eypq0CTqZZG0=;
 b=kp6+/LUhxx/EpJZHLS3zC0aVRM6v3kC06Et+HrkaP0jSCvA6lNHHnDGQGS27KHLUtJ
 E8MAc3yPBPxrCUEcICWqPsbYieFe1s++6J3s8QT+N7jK05w46teOUkZnC2MQgu1R5CO7
 JMWAqLaig59dBByYw37iQQInLovadEZCPUqaSaO2bEF45nIYzwXGEsyYmqlt0jeoSaJ5
 +MYAGR1N+aqQdRbWLuJJ7Mtvk8YNsqKsMi8CyuVqDB67dGTy/0xNzw75lNv7vG50i0nc
 aZe61RCZPJTe83RB+FZ5guxInlsqmk4PSk9Dugnc7Da1is79C8ALOelrxoXGnOdwOHpz
 EBAg==
X-Gm-Message-State: AOJu0YwVbrumDjohYB9ZgCISnJ+6BZGrIcVOFy0fc/nsLAnxDf4+4sg9
 so1yh1hmW6gdNxdOuEa6R2feqlfTErjyexgFbKijpZknTISkjZ7tZg2EFraR5cYMsZXDmU3TWUS
 PYm9O4oy7DT+QtHqLeoMIrrSB34uLdGnSWiNzk6u/cHY93F75XwmJVYmrTBMXetzmZ4/HWiwaGl
 x9hkcRXN88C8XRpEjEAYtkocy54ZyPNri0UOMJ0E+n
X-Gm-Gg: ASbGncuCm+5oRzN/5bH15lvYAEiIkJQpvOn5ORk9Nbfx1Zq2GZO6RaTdvzDNqSziiRj
 hhBJyrmx9c+EwLzbUBRSH6aLMIJeZsNdW20d6CLz0dN0aDTO/XfhSRkl54Ya5aa0Wnklgw2gES7
 5x+szaY18YS2gQIeBc0p+k7FjfeEKAp8jaiUVFedmf2YbUTrB3S88x8n/2mPwfYU0Rby5+8ZuWB
 U7k1AHRcXpeLMd7ExMoqeDR3VaZVFQfrX3QuAFTSIThIuHsn1dYwWIUQfPfvbTqhnmdp2TBq2AU
 y5wItFjAdX5imw==
X-Received: by 2002:aa7:d901:0:b0:605:7f67:5148 with SMTP id
 4fb4d7f45d1cf-6057f675189mr737422a12.28.1748589289892; 
 Fri, 30 May 2025 00:14:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1G/T5/jflLfxnHWN5OvFdkllSxpUwgLtSaZ7oXLkjFreKJ+JUQ4P4Yytm5Hsmtwg+HnOufg==
X-Received: by 2002:aa7:d901:0:b0:605:7f67:5148 with SMTP id
 4fb4d7f45d1cf-6057f675189mr737397a12.28.1748589289465; 
 Fri, 30 May 2025 00:14:49 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c5b6e9sm1198971a12.23.2025.05.30.00.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 47/77] i386/tdx: Set kvm_readonly_mem_enabled to false for TDX
 VM
Date: Fri, 30 May 2025 09:12:17 +0200
Message-ID: <20250530071250.2050910-48-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

TDX only supports readonly for shared memory but not for private memory.

In the view of QEMU, it has no idea whether a memslot is used as shared
memory of private. Thus just mark kvm_readonly_mem_enabled to false to
TDX VM for simplicity.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-36-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index accaefb4011..344e560b4b8 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -384,6 +384,15 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -EOPNOTSUPP;
     }
 
+    /*
+     * Set kvm_readonly_mem_allowed to false, because TDX only supports readonly
+     * memory for shared memory but not for private memory. Besides, whether a
+     * memslot is private or shared is not determined by QEMU.
+     *
+     * Thus, just mark readonly memory not supported for simplicity.
+     */
+    kvm_readonly_mem_allowed = false;
+
     qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
 
     tdx_guest = tdx;
-- 
2.49.0


