Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA35C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcL9K-0002kw-P1; Tue, 20 Feb 2024 03:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL9J-0002kF-7K
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL9H-0000QZ-Rp
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilU+ngAoaU7FTHYc2Q8TyToaavovBkXrTxoRpdQ4t94=;
 b=fpEe/fZ0bobRfv01jMGB7+gh+leYCcwEjCrFSLHgv7K20+Mdgtd1ABnkAZmIOqtM+1Ssip
 Aihy72IYEtm78Yh6VDvjenQQzKdMuhTrzIblzPSyAfxI0geKySFW3YWhGtlVVMmAQzq3ku
 g/gZC5uQ7M/d/+hYOAqDuk3qIhjjV0k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-D-jMGE9YPWmSvkHniJZobQ-1; Tue, 20 Feb 2024 03:06:41 -0500
X-MC-Unique: D-jMGE9YPWmSvkHniJZobQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3ee69976dfso28242166b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416399; x=1709021199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ilU+ngAoaU7FTHYc2Q8TyToaavovBkXrTxoRpdQ4t94=;
 b=rIw5I1vOaykECEv/MElpzY66A40zYRAvnx3zPPjmXhOBf5igYLVvD2StjrFSQ48TEY
 iY5pOCOzdhPeEvlsz4SO5ZwD8G6ZzljYpKBIcE7mOa384dMVeIYjBRvm9qtVglCbavdM
 twvfMq4T2bpeubWT0KlgsskAqL5fwdT29Lc0jDo9PzbXaSU2s9/w60y80wqm/vAltm52
 IWZPctK+lBUVsB3YslZZXRf8P8wTc5OcKIkO9ffBPtt6cDoU22v/SUi4hyIFHYe6pEpX
 uJBZBfuOx5AIy65mPbNKRMGbzQ5nG3/Pea7YPiA5K89vGh4/rNKHuONJLrPhROLYurXj
 pM9Q==
X-Gm-Message-State: AOJu0YzbnS8DsIBNgH618EOLGD0Z+6cdLbb7WHO27eGuUQ1NgI0d+D8O
 TeZLjXiIefRq/vl4TrrbOe3ifN6qEAMx8e1yP0bIUT3N6rxOiZcUWVpyU73bpYUBi9MtgRnrOG4
 5jp+snaOqsS4ys/ZWOI2C+TW9PLiLV8gN+kwt088H5PifOOEDSvncIHeRvU5ggOjtImaKvVsso2
 29C4pF4YUCrVqFRO1D9Sr2zFbDZkKvyNZonnx4
X-Received: by 2002:a17:906:b094:b0:a3d:1cbd:67f7 with SMTP id
 x20-20020a170906b09400b00a3d1cbd67f7mr9428994ejy.0.1708416399663; 
 Tue, 20 Feb 2024 00:06:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcFia9P/w6iK9JN1YCStU2Plsx3QV42DboLuQrksPUPBLbVheRS7EIp8hXx3Vwy90HFLKAOw==
X-Received: by 2002:a17:906:b094:b0:a3d:1cbd:67f7 with SMTP id
 x20-20020a170906b09400b00a3d1cbd67f7mr9428972ejy.0.1708416399359; 
 Tue, 20 Feb 2024 00:06:39 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 rf23-20020a1709076a1700b00a3da5bf6aa5sm3707176ejc.211.2024.02.20.00.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:06:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	qemu-stable@nongnu.org
Subject: [PULL 06/17] i386/cpuid: Decrease cpuid_i when skipping CPUID leaf 1F
Date: Tue, 20 Feb 2024 09:05:47 +0100
Message-ID: <20240220080558.365903-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Existing code misses a decrement of cpuid_i when skip leaf 0x1F.
There's a blank CPUID entry(with leaf, subleaf as 0, and all fields
stuffed 0s) left in the CPUID array.

It conflicts with correct CPUID leaf 0.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by:Yang Weijiang <weijiang.yang@intel.com>
Message-ID: <20240125024016.2521244-2-xiaoyao.li@intel.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 76a66246eb7..dff9dedbd76 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1914,6 +1914,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
         case 0x1f:
             if (env->nr_dies < 2) {
+                cpuid_i--;
                 break;
             }
             /* fallthrough */
-- 
2.43.0


