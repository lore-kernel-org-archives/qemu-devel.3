Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637FBCA0EC0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 19:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukSJH-0006Dy-P6; Fri, 08 Aug 2025 14:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJE-0006Cu-8k
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukSJC-0006fp-HK
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 14:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754679557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kq5SJZitYm77HsWLsoPLECQfDLAC1Pk673DMPfDg9po=;
 b=KjOI3uaEOyshB+IVXD16QUwgSddX+ZWOp5dNc2Ur01Lp5lT68FBjL7AqnK4VC85cTqzsDc
 +v66Q66PZqIFtq17nQfJ1v3p9Aos/UpBZKICkmB2hUatMshtfHZJ83QGZBgeXSRpZqhc2E
 xmCwWjICkHSk/LtDF4uYB8inE8fpvVg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-QfBWc6ZSOe2HFBH56MEqDg-1; Fri, 08 Aug 2025 14:59:16 -0400
X-MC-Unique: QfBWc6ZSOe2HFBH56MEqDg-1
X-Mimecast-MFC-AGG-ID: QfBWc6ZSOe2HFBH56MEqDg_1754679555
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b7892c42b7so1610397f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 11:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754679554; x=1755284354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kq5SJZitYm77HsWLsoPLECQfDLAC1Pk673DMPfDg9po=;
 b=cOOcNbE3VIRB5zZ7WxkwyGct1it3jL+sO3kbL5n9BPxX1CMkF7EoFH+m3TPadqi+sW
 6nELp9+CPxY+HbH0vt/U3O48EJC7Yk9zj/tr3wbECLxLM2K6uMgdG9beeWQFjtEET4Mx
 Fc9kCbItCROw+kliU7DFnP2+nUhQWiUr/SW0m4lndakx1niTY3Hz8hakPZ8PZxSKH5Yy
 ksXSGdVAz4Yh0KVT1Q4rbMuK7PrgdbBGPlLXbxCzArYvT8st63NB5EkpK52BP1Lfso1k
 e4Vmpro1SmhduJUo4HVq98g+Vcm/mJqwGdo1dcNxwJjLq2AI7vng7gvAGRCn/gGrglAg
 E6yg==
X-Gm-Message-State: AOJu0YxVcWHwFp2ymliTpyfsEdaFFclpf0v86+HDi+8C/swI3gLg0snf
 qT3+17DWRHI1t/vfPReZiflaXiZjb4Lw6Gy4iIa5YrSMgY/52U8O8DJFGemQtYx68VgN9TpBdbi
 0uVIDxUbFLNgTWATgUdkgd0K5N4j1OueS1+7ixANg6BrO4K01oN+mTlP2JwJqIyoOJkkTakIQyK
 KHsFBs4Z28PdgaO14X0a4XL1r9xtYpPxmzHVlfJEK3
X-Gm-Gg: ASbGnctmWQ5QuisGiBmWpdhPuMvU4oKFCNJnb7bRdgqIXn9Ee94Cn49OdJxtzfQD0Vt
 Un2jJUVnupuJzIbz63SAEMKrfL5lv7UfKyqxQ09UIoYH8VH2qjKNWddkyC9yzviFTvELlQUisAR
 hwQ0f1tyKSG3qKKvsrqk3p4u/y/I82wK6v8UuHBsfNWyxJ4C+3Hg9D/9Voip4Owvmvmo7YIx0cK
 Pge/2K2qMJ2vkNmSrpXkb3s3g/QfVk7JiXyiDGa5/E2x0494bGf8UM3gs3W6KKxzO2wB1hm9uAd
 5KvDanaHRx1YticvoXnSuAHgg27qEHKLi44nxsgfAPDW
X-Received: by 2002:a05:6000:18a6:b0:3b7:825e:2d28 with SMTP id
 ffacd0b85a97d-3b900b49901mr3270946f8f.9.1754679554216; 
 Fri, 08 Aug 2025 11:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3GFDu25FZWrntGg8UCYix206t1pksINbSXuuV13Jy1TNy6Fr/3OSao3NK0zEvqZGvg25hWw==
X-Received: by 2002:a05:6000:18a6:b0:3b7:825e:2d28 with SMTP id
 ffacd0b85a97d-3b900b49901mr3270931f8f.9.1754679553724; 
 Fri, 08 Aug 2025 11:59:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.234.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e586ad64sm143572105e9.20.2025.08.08.11.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:59:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com,
	richard.henderson@linaro.org,
	peterx@redhat.com
Subject: [PATCH 2/8] accel/hvf: check exit_request before running the vCPU
Date: Fri,  8 Aug 2025 20:58:59 +0200
Message-ID: <20250808185905.62776-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808185905.62776-1-pbonzini@redhat.com>
References: <20250808185905.62776-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is done by all other accelerators, but was missing for
Hypervisor.framework.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/arm/hvf/hvf.c  | 4 ++++
 target/i386/hvf/hvf.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b77db99079e..478bc75fee6 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1927,6 +1927,10 @@ int hvf_vcpu_exec(CPUState *cpu)
     flush_cpu_state(cpu);
 
     bql_unlock();
+    /* Corresponding store-release is in cpu_exit. */
+    if (qatomic_load_acquire(&cpu->exit_request)) {
+        hv_vcpus_exit(&cpu->accel->fd, 1);
+    }
     r = hv_vcpu_run(cpu->accel->fd);
     bql_lock();
     switch (r) {
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8445cadecec..b7c4b849cdf 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -749,6 +749,10 @@ int hvf_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
+        /* Corresponding store-release is in cpu_exit. */
+        if (qatomic_load_acquire(&cpu->exit_request)) {
+            hv_vcpu_interrupt(&cpu->accel->fd, 1);
+        }
         hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
 
-- 
2.50.1


