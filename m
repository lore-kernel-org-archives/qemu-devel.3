Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C413AE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK4M-0003oQ-6m; Fri, 10 Jan 2025 13:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2p-0000ZD-Aw
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2n-0001Dd-BJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aaRigbghLhObFLWkYcE9jy7wD6yeALPcuEP9ikC2TVQ=;
 b=Ir+C5l9rnfr4f8xTZBsIXjUw/ov5Ab219TMO3cZ0e0dLyB7DIy+S2zb3Mr0xPDn+QVpgnN
 l1ilS5RLBBdp3We8/5mCV2+Dj4eGBxVEnTbpmmITuIszX5yvbHPpqyW+wAFxiV4kWoxXFf
 qxCrcTacOF47N9hQvgyFG1FmzRHyW5E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-0D773l_DPdqI3AexS2IpQQ-1; Fri, 10 Jan 2025 13:47:38 -0500
X-MC-Unique: 0D773l_DPdqI3AexS2IpQQ-1
X-Mimecast-MFC-AGG-ID: 0D773l_DPdqI3AexS2IpQQ
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa6a7bea04cso162678066b.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534856; x=1737139656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaRigbghLhObFLWkYcE9jy7wD6yeALPcuEP9ikC2TVQ=;
 b=e3DTyi4dTt3T17st8nlilD5SR3x4+x2960Nz0/KXywDsVhIfdEyIlh8rBsoXEaHmfO
 BskM/u9CqHi3hvcnSiajtqIJqXmS0t8YoLm4LW0VD++5iQg5lT+VtdTUdB9OduQ6dqWD
 Hq6Oc3J9fiKn1sloUiWNR8Wv//j1QRAW2okESZjgIsUF1sKTxQV5vopX2A4bMRAbiG8n
 vQmM4rYb98U1yiomi60RZ46pSuEuHeq49ppL426aKHcJlclUZU64HBNTpQZK23o297Jf
 ohXWLgj2MIqw6te31Qr4G2rugPSoaUDaKpkuWrrXCcPPznEMBn79XS1d8nIvUKBQMzwQ
 vcPA==
X-Gm-Message-State: AOJu0YzjRLkjlKfnibV4DkUL8hy3lEDqWGxWfNH9YeaTVq7wk9Zr0wvd
 V1ck4x/rLhIvkQuo6HY5PW29IgX4jjiMaaZCokdmr/QNX2Zf/ulZuIi97AJoFDZ+bPxzU/1t6ei
 vtaEEBiAz7yPnRaUglX9hzpa5FDGGkOA/YqnGT52JE7+mJ1E/HNbcmBUM+Eu01DhBCQr+04ntb4
 oLlaD9B4SHuzSPaA3fY4Z84PzFsJl3E9LPKfMw+RE=
X-Gm-Gg: ASbGncunJxBUT+fcgm5J64BedEA5ZsFqG4jLsz27TBw/tvIltvvWxBv1umtINWmzPhK
 RZAtgovb5+P7F7vXip/I2rwYly/1zNBUyStBtamMwSMQk3Z7ffpfsIUjW5yUoex//pOasuTMqxk
 noKbGCWN+uTmzXlFduS2x9YQVglTjCwCEUvEQos+4tLGuoKAiv81LnnbZpetoAMwket6m+3X3M/
 RNld4tXQbmxHTk/V0Aten15ZZD4tbG50h5q9kV3lifMODyiMRJpxHCy2cs=
X-Received: by 2002:a17:907:787:b0:aa6:af4b:7c87 with SMTP id
 a640c23a62f3a-ab2ab6c5072mr1015355866b.21.1736534856038; 
 Fri, 10 Jan 2025 10:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjbRGvz/SJOrjdhXjBii7Z3nMPcidNi5AiVXh3hP/dZ/TSUPmZ7nug7sk3A7pZT5Ay6fZIrw==
X-Received: by 2002:a17:907:787:b0:aa6:af4b:7c87 with SMTP id
 a640c23a62f3a-ab2ab6c5072mr1015354166b.21.1736534855515; 
 Fri, 10 Jan 2025 10:47:35 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b1ccasm193366566b.158.2025.01.10.10.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/38] i386/cpu: Drop cores_per_pkg in cpu_x86_cpuid()
Date: Fri, 10 Jan 2025 19:46:12 +0100
Message-ID: <20250110184620.408302-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Local variable cores_per_pkg is only used to calculate threads_per_pkg.
No need for it. Drop it and open-code it instead.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-4-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 579d9bac955..6d9c85576f6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6499,7 +6499,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t limit;
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
-    uint32_t cores_per_pkg;
     uint32_t threads_per_pkg;
 
     topo_info.dies_per_pkg = env->nr_dies;
@@ -6507,9 +6506,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
     topo_info.threads_per_core = cs->nr_threads;
 
-    cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
-                    topo_info.dies_per_pkg;
-    threads_per_pkg = cores_per_pkg * topo_info.threads_per_core;
+    threads_per_pkg = topo_info.threads_per_core * topo_info.cores_per_module *
+                      topo_info.modules_per_die * topo_info.dies_per_pkg;
 
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
-- 
2.47.1


