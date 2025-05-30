Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D789C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtw8-0000yq-Rn; Fri, 30 May 2025 03:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtw8-0000yL-4Y
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtw6-0006t3-L8
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfP7gKVErJOlig7HlJ7HLKaFhaDV2c2A57Y5ud1kn9s=;
 b=cJpSNSvXPOm4iqQgMCfykBfujnWt+QUCv4xnNfPDEzfLaf1ODaXI2fxOhlaeIXf9ui0nVS
 26q+fZvFACLuc7tdrVG6b/H5/7G902KWJoZSF+gUEa7Up0i0RHtmcUu9U8JjgovVYAohnB
 5SZRfr0+FI9OELTMYWQxO+D+bgV202o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-hIxxBnZPNWuDvQ2Txim6SA-1; Fri, 30 May 2025 03:13:48 -0400
X-MC-Unique: hIxxBnZPNWuDvQ2Txim6SA-1
X-Mimecast-MFC-AGG-ID: hIxxBnZPNWuDvQ2Txim6SA_1748589227
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so87600766b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589226; x=1749194026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AfP7gKVErJOlig7HlJ7HLKaFhaDV2c2A57Y5ud1kn9s=;
 b=a0xwG5mOh0H8m+5QRPO1bWIormUdYF3jgkWyP7sne0RMu6ByvLKEvIsIg+f5/liR8b
 0+8C9VWGWcpB7/aBRHWReAYpTWpkAUrbf021YgzXNHduADr8it9UPaBVhJM8MoqpDV9N
 NR0s4mLwWQSULAztOxzPc8a4Gix4Y3ADufbJAK7wFPTNRBCnK3gkwP08sqmXXB0nBtHk
 E/aNZOlJSRWH9FHtMIUi2Fs2OubxgDJ4qUSs5hkMjqP5GtG4QzFInmWlged/eXGzDFCp
 9B2Je5lcNDyaDIr+wq3MpmLUxJTh0RKPbG3HgRVj3TNoJBSIsdGP5J7LXkFkEt586AR4
 FKwA==
X-Gm-Message-State: AOJu0YxWzkgqb7XtpKn3PrBriNlLdWoK4DGRHoAu1uH/EPzsqCPfY6b0
 4xUDdgKMsVVr5GGBJeANqCj49pd9vy3Y4RO1MojYP3TpXoj9VJK1TG3zACd3NAaRX8VKHd2PaSL
 GvONLINIWgViO0hleTWPGHM5wswLcvwV1wEHd0l8gpr6c53M4rzD4mo4nKCUtewoNTc1qoixUKT
 7BOwX2OOs3r6RnaseZ/6g7Fuac4IG8t1VbHBu3TQcq
X-Gm-Gg: ASbGnctTMWFGwsf+g0VBeVJHwmOkj59AkaD4AN/mE1Tl5WzIjbDFlJhYy+TNX/RQvFn
 0fgLfJzSWjAxKptgP8zHhF5mJzjsqk5tBsiXLBnn/75ETZ+laGFVUC6yCZ3pe0ylxIa3yVILtXl
 iNmemtR5+N/aNugnv7UeayQeLO6o8GVpu+gBsjwRDu3u5Qc0hDUx0PYsErXEpUvhsGaP7CBKGNq
 xciRpZvaHq84EFlaJCBX4sUAr/4fbmxquxJLJJBwWu2YyYAuYlCJ0xDig1IP5WCZOIFXZbWaaN4
 1VrpjqsJpM+Yng==
X-Received: by 2002:a17:906:7314:b0:ad8:a2cf:76f2 with SMTP id
 a640c23a62f3a-adb36bfb56fmr90142866b.48.1748589226518; 
 Fri, 30 May 2025 00:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyd4QPhL0FAlyQL2Io9GMJJeKJvq+ot5VIn7SFgHyUs25QBhk1OTrDEguWbciwsQsqdVFv9A==
X-Received: by 2002:a17:906:7314:b0:ad8:a2cf:76f2 with SMTP id
 a640c23a62f3a-adb36bfb56fmr90140366b.48.1748589225946; 
 Fri, 30 May 2025 00:13:45 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb2fb63cdasm133502266b.120.2025.05.30.00.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/77] i386/tdx: Make sept_ve_disable set by default
Date: Fri, 30 May 2025 09:11:52 +0200
Message-ID: <20250530071250.2050910-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

For TDX KVM use case, Linux guest is the most major one.  It requires
sept_ve_disable set.  Make it default for the main use case.  For other use
case, it can be enabled/disabled via qemu command line.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-11-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 32ba3982ff1..a30731b1a3b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -288,7 +288,7 @@ static void tdx_guest_init(Object *obj)
     qemu_mutex_init(&tdx->lock);
 
     cgs->require_guest_memfd = true;
-    tdx->attributes = 0;
+    tdx->attributes = TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
 
     object_property_add_uint64_ptr(obj, "attributes", &tdx->attributes,
                                    OBJ_PROP_FLAG_READWRITE);
-- 
2.49.0


