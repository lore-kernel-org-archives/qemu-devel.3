Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2FDC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bJ-0001Go-5J; Thu, 06 Feb 2025 13:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bF-0001CI-Cz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bD-000195-P7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDa/P6A4hBHQJCiarxStLpV2pO+dqpAl69C6M2CZXUM=;
 b=baNUEVsOzGM8ZL6+ct9ycYsBCEoDVGxvsefwt49QYwRnMZOsP45o8fZkYi1yNZ6Eq3KF95
 TMD5cis8ipMHAl9IDdug0f8vtbLuW4ofFW7kjUKIgpE8Uojivh3595q4WGunPfx71YpTDR
 hPcmARJyRfSpPsBaF3X9VSBUJMhMXJo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-OUmqGXvCPrS8jv0c09cIhw-1; Thu, 06 Feb 2025 13:27:37 -0500
X-MC-Unique: OUmqGXvCPrS8jv0c09cIhw-1
X-Mimecast-MFC-AGG-ID: OUmqGXvCPrS8jv0c09cIhw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38db0b5405bso599830f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866456; x=1739471256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDa/P6A4hBHQJCiarxStLpV2pO+dqpAl69C6M2CZXUM=;
 b=wnnppcuXNfj+/r3DPFX5A5Sm7H28zy68qFlCoVz8dQTjQsAFbhVUw6i6Ft4GAXd5LM
 sWiwQCC6EeX8f2vrppSjXVU6OX4QoeuVidZJ9ABkDfS4QS0Eyi4YIaonH8O3fqJi/3KT
 dmgM55IDFNu+mpCNGKEQjZgnu3VknIzyreMW8F3d2hLSR+spyCTBc1/R3cdQ6ezK4gkE
 JA+WWRVrGX+cXyCnTzbqQy+YxAFSzc6J7TPFYKzejH2RkNTiS4oiTKIZLwWc8xv0zPpM
 VR03HMnx3LCHjPkV3OTgt2WyPGMkOpwHLZWMkR3GejejyxW6VeUpzwrcj3e78Uw0fcnj
 b6dQ==
X-Gm-Message-State: AOJu0YzX4gMk5i1qf/iLWL6M2PndqmF0zkw9QkZCpAXX9FTiJ+iM2xpC
 aJ6/CJYLFE2g+rVAqhqajkZVHyMA5y7rIeWrZ4wHl0jGUVLyaLHFxNI//eAmf1hvKgbuCxn9b7n
 PL/DGwhFDYOAsc7wCGXprLeItFmGEx+ahdr0sZ+Og2Ce5zSHuvCb8JXxQL9ymAqmumtGo0qNhYZ
 jAlx8UAqEoohTkINghz/gHLIdaP8hx+IdgWVJtoa8=
X-Gm-Gg: ASbGncvboP7r3949gCZU1FcRXZcMSClZAUlG3XfVxGsrM2yZOfcXauMLSZTGtf39vPu
 Do9N8dP7k353SAAYBFyKFNffg3BO5a9iKoGBTmAC65i0o8MzF2ScjmEHEvlaWLESjXp/INU7j44
 S498/jMTls4D7FTD6EMO+aoJMVsm//06XG6AJjOrQe5U6wjGx/fnLy/giuUqrBvh6J2ljsL8Whe
 4/ZjGdUvB8qpiGz2FxIcsOiKqLD7IaaEmwflYfdFgI9/kMj7PhJHIpuGZL8DDucFJsh4I0VEkW4
 sClFzVE=
X-Received: by 2002:a5d:5f4e:0:b0:386:3bde:9849 with SMTP id
 ffacd0b85a97d-38dbb251efdmr3159524f8f.12.1738866455993; 
 Thu, 06 Feb 2025 10:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGsaQ7qF5N2Fe6k1kvfu7fWbq1iH8InINZsDwOQR7jSy51LQ4+33N5jJFCKSfX4cQhE8M0UA==
X-Received: by 2002:a5d:5f4e:0:b0:386:3bde:9849 with SMTP id
 ffacd0b85a97d-38dbb251efdmr3159511f8f.12.1738866455640; 
 Thu, 06 Feb 2025 10:27:35 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfc8a4asm27499975e9.32.2025.02.06.10.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 10/22] target/riscv: move 128-bit check to TCG realize
Date: Thu,  6 Feb 2025 19:26:58 +0100
Message-ID: <20250206182711.2420505-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c         | 7 -------
 target/riscv/tcg/tcg-cpu.c | 9 +++++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5c6ba511ef2..8fa05912698 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -709,13 +709,6 @@ static void rv128_base_cpu_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
 
-    if (qemu_tcg_mttcg_enabled()) {
-        /* Missing 128-bit aligned atomics */
-        error_report("128-bit RISC-V currently does not work with Multi "
-                     "Threaded TCG. Please use: -accel tcg,thread=single");
-        exit(EXIT_FAILURE);
-    }
-
     cpu->cfg.mmu = true;
     cpu->cfg.pmp = true;
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 1cbdef73dc3..46cd8032c79 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1014,6 +1014,7 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
 
     if (!riscv_cpu_tcg_compatible(cpu)) {
         g_autofree char *name = riscv_cpu_get_name(cpu);
@@ -1022,6 +1023,14 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
+    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
+        /* Missing 128-bit aligned atomics */
+        error_setg(errp,
+                   "128-bit RISC-V currently does not work with Multi "
+                   "Threaded TCG. Please use: -accel tcg,thread=single");
+        return false;
+    }
+
 #ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
 
-- 
2.48.1


