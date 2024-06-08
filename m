Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9381EC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXz-0001Gp-S8; Sat, 08 Jun 2024 04:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXy-00018q-RU
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXx-0000Dk-Cv
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJL4G6DZbP63BxtynbmGzzcFW/nfu3SZI/XSGkVfEGk=;
 b=iK+5JkS2f26Bm24fHSUcX5T2U+FB44ZR1fsf7uiUpW6ookIHDYn4dj2FPT44ybpr2eatmM
 vaafiu5e/K8b3wWu6qrynl2xUL2ASfQED99ryaQn0m+nxY3CN9IWg8z++a8goUbbSYe6k7
 wo5L4Vpug6EjCbwRtPsA3yD3VtNAdws=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-Nq563lP9NiuvzgHEUCCfww-1; Sat, 08 Jun 2024 04:35:31 -0400
X-MC-Unique: Nq563lP9NiuvzgHEUCCfww-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ea9aeae4e6so25100001fa.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835729; x=1718440529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJL4G6DZbP63BxtynbmGzzcFW/nfu3SZI/XSGkVfEGk=;
 b=W+enkNi3KaDJTlN/1P2mBLvs33hx/t3/pJppe79eNhorQdNv4DNRjWK4jZVlPpPb1Z
 2fM1PGlX4VvXNcs+/kSbUVqNlefmm5fBOYqlm7dL0g6Uf2EBWzBdOWJPHWBFj/ftWG81
 qTMydeaCEbLiBXjia0KvfeB9HKCJsnOGbYKZp+mhMAiPyUZJlgtHlI4z0DSdsfjrBraY
 zMaPdSY8bBHqZoH8/Y1dsQM595q+BL7hwzWiu09reHil9BbwlRQtpo/F3u3DlXpi2dCH
 yryDVLllaMfT05I7nacQAbNJc/HRJzdBjRA2iNpBr9foPspvnh1BdIa4YeimpUXICavW
 Yw8Q==
X-Gm-Message-State: AOJu0YyHAglQBd2E6vE/Q6KUjEodKfbJf6R+Q/uixPcaZJ8KU4XsJe3p
 KapS6lOvrTF9ZbowzZp/lBNIzQ5Yo2NpEdUIXVO/r27RA56aTguYILXsFUDAKATj6iIqAA4d9CI
 56EWXdCLMq+fijZjx0P1GDZ7h843N97TaxKUe8yilsAXNcnAb8mFigW4cS9rXQprey1oXZG0kBf
 MEGh89TlD7KhbCfd9p9Wc3UYKsHSmzjAE7bFCr
X-Received: by 2002:a05:6512:104e:b0:52b:fb4:1283 with SMTP id
 2adb3069b0e04-52bb9f775ccmr4608711e87.15.1717835729474; 
 Sat, 08 Jun 2024 01:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAL4Nq0kxJzAORqtSRfKtyeHQxPgJR77T4oF9k9E0XQnZk/1o0IeFtuM4JTsBJWuLfU95g3A==
X-Received: by 2002:a05:6512:104e:b0:52b:fb4:1283 with SMTP id
 2adb3069b0e04-52bb9f775ccmr4608697e87.15.1717835729147; 
 Sat, 08 Jun 2024 01:35:29 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070e2fcsm352999966b.154.2024.06.08.01.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PULL 27/42] hvf: Consistent types for vCPU handles
Date: Sat,  8 Jun 2024 10:34:00 +0200
Message-ID: <20240608083415.2769160-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

macOS Hypervisor.framework uses different types for identifying vCPUs, hv_vcpu_t or hv_vcpuid_t, depending on host architecture. They are not just differently named typedefs for the same primitive type, but reference different-width integers.

Instead of using an integer type and casting where necessary, this change introduces a typedef which resolves the active architecture’s hvf typedef. It also removes a now-unnecessary cast.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
Message-ID: <20240605112556.43193-4-phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/hvf_int.h  | 4 +++-
 accel/hvf/hvf-accel-ops.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 4a327fd5260..30e739a2b52 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -13,8 +13,10 @@
 
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
+typedef hv_vcpu_t hvf_vcpuid;
 #else
 #include <Hypervisor/hv.h>
+typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
 /* hvf_slot flags */
@@ -50,7 +52,7 @@ struct HVFState {
 extern HVFState *hvf_state;
 
 struct AccelCPUState {
-    uint64_t fd;
+    hvf_vcpuid fd;
     void *exit;
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 6f1e27ef469..b2a37a2229f 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -400,7 +400,7 @@ static int hvf_init_vcpu(CPUState *cpu)
     r = hv_vcpu_create(&cpu->accel->fd,
                        (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
 #else
-    r = hv_vcpu_create((hv_vcpuid_t *)&cpu->accel->fd, HV_VCPU_DEFAULT);
+    r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
     cpu->accel->dirty = true;
     assert_hvf_ok(r);
-- 
2.45.1


