Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B1ACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnc1-0006ak-CE; Tue, 28 Oct 2025 13:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbf-0006Qf-CB
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbW-0004iu-3q
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JvVLcmN1GqwqMn3Ji8GB67JXuPEUaQwDOot0qHP2ciM=;
 b=Zn4K+8dCzTZ/Sd4UHUkHvkGE4sm6h25l5SGuNfS+lszTBbB0chZdpdPFRLSNMxhCFTrJJN
 M/YA85R4eK23dIAp09GuaVUc5EeSr66OEMzxsMSMaqu59tFSPGHTmwc6MvGXQNs0ZpIhKt
 RL0V9lYaLWLvlEZFQIhZaJILP/7VjZs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-N4rvixHENZ2THnlU46YcEw-1; Tue, 28 Oct 2025 13:35:25 -0400
X-MC-Unique: N4rvixHENZ2THnlU46YcEw-1
X-Mimecast-MFC-AGG-ID: N4rvixHENZ2THnlU46YcEw_1761672924
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-471168953bdso1276165e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672924; x=1762277724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvVLcmN1GqwqMn3Ji8GB67JXuPEUaQwDOot0qHP2ciM=;
 b=MUJ/MrlCBmJZV9bjNJ4FLXx7bZQKb3SER0ZEGKBAkRY6sFPz+v7JNkRyTO+BE7Itvn
 Ip/BEB906sZae23o1+PB5wwgk2Wkmj5KzYrMqihYoQ693w9wUIeb6KGJJ95Nf6+V+IRZ
 TG6aJQVrWtxfJQji1D/wHxq9PWrLp+BpQ0A/kTGP+ju9m9w61bsmPGPCVEu1HEAVHnIp
 FCigRqo7BZZygWwmpkwegCD/lID+rQ0t1T7w80YIGtC55Tna/BiElzDzvgmWmBfoKFIY
 8bJFpBGd7kqV6ARSsYu1VOdJNk6wnOSI7W6tHdAH/jyp20thwuf4uEQ9O/wjrw3Fo96I
 DgiA==
X-Gm-Message-State: AOJu0YzdL9+hOKyU6foE5HvuVyRo7KkG96iPHGf2QgqT3PSR2x9pxy57
 Cr2TH4JLdXiwmeN8hLZv2CkTzhNMJwTgl8kcM1MGSTxMMB1WXhW/mOVnae22lMZFZcc92Xfj29q
 HdcnWumhSlhhe0WVPtBhXqlOY+99Ko37sQabOzUGGObnGXMMJeu9Pvg8m+SX4AsLzKc4uyWCHjb
 X+Rg8IAvDJxNmI4CCAQlTMUT/+xgFm/t6C52uHZEgv
X-Gm-Gg: ASbGncsy9H8Qb7pmLPfGzC2YjmyHFZr2i8mOidcjMVPMdUQ45yMctz3y2USKWNYhis1
 MPMD0s5INFKyE5021SqTO99Lj0JKVWyaSV/asg0O56If2H/SljOEwgJVWyONX6X6zx4vvrgAT4l
 6O9zB/S63tVDDfuBxqxeh8Q28KF4hKOOAIS9DLg9QFhBZf+2bUyM9Ls39C0zluf9FaMEjnO1VCj
 somaTnX3doZOpc7zfaHxaIEXLmh6RDck08ZvrnNtjd2TbVw+UZZj9ZyFh7m7JmH/KqIOAp6hpUd
 JUrhClQAD833H+6Xaq617+wu5+0jmC3dOqgrezzSrnHJlOHea5/7B/N8csiNmlObatBjGekNuYM
 vdRRjpPEBqsI0kPnC2Gf9W1Sc3IVjnCoI0diIonypxDpgrLGdbf2DTffQSV2/hej4IHCpq44qyR
 nPrUw=
X-Received: by 2002:a05:600c:46d0:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-4771e68ff23mr470865e9.17.1761672923695; 
 Tue, 28 Oct 2025 10:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg3dJnndn9MLNODg5OH4lLFWo9eGfh77ZhdB2PVGRU3eRKhfdYb3afomVEo1Xod4ovsniKgg==
X-Received: by 2002:a05:600c:46d0:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-4771e68ff23mr470565e9.17.1761672923249; 
 Tue, 28 Oct 2025 10:35:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e202093sm3555785e9.11.2025.10.28.10.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:35:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 17/18] target/i386: clear CPU_INTERRUPT_SIPI for all
 accelerators
Date: Tue, 28 Oct 2025 18:34:29 +0100
Message-ID: <20251028173430.2180057-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Similar to what commit df32e5c5 did for TCG; fixes boot with multiple
processors on WHPX and probably more accelerators

Fixes: df32e5c568c ("i386/cpu: Prevent delivering SIPI during SMM in TCG mode", 2025-10-14)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3178
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86hvf.c    | 1 +
 target/i386/kvm/kvm.c       | 1 +
 target/i386/nvmm/nvmm-all.c | 1 +
 target/i386/whpx/whpx-all.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index a502437c303..3838c9f5a6f 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -446,6 +446,7 @@ int hvf_process_events(CPUState *cs)
         cs->halted = 0;
     }
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_SIPI)) {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4dea1ed8f0f..60c79811382 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5659,6 +5659,7 @@ int kvm_arch_process_async_events(CPUState *cs)
         cs->halted = 0;
     }
     if (cpu_test_interrupt(cs, CPU_INTERRUPT_SIPI)) {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
         kvm_cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 2e442baf4b7..b9bd9ed985a 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -709,6 +709,7 @@ nvmm_vcpu_loop(CPUState *cpu)
         cpu->halted = false;
     }
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_SIPI);
         nvmm_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 256761834c9..6bf8d5f4bbb 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1621,6 +1621,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 
     if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
+        cpu_reset_interrupt(cpu, CPU_INTERRUPT_SIPI);
         whpx_cpu_synchronize_state(cpu);
         do_cpu_sipi(x86_cpu);
     }
-- 
2.51.1


