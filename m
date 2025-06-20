Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323C9C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeoM-0006eT-Uz; Fri, 20 Jun 2025 12:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoJ-0006dr-En
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoH-0000Jw-Ui
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sGYtFnI+UJzF2rX6EpStjzkEq0FKTxfvAu4tsZnx1Y=;
 b=ZSJnLVBiEwmM1hYZqgZjmcTu6FMeFQ9ksjTBcEEc2R0bl+X1F5nrdvb0W/y/Sft6F5rgEI
 0trpDwqQoX7P53rhc/2Tsh8qOXZ44UCxGE+nkJCuF39/gmvTSFDjEegXKOv1GxXGHAOZgH
 GyuyeRBAN7H/gMZcAJ08wqMLrMBZrqs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-7eGptlFuNii79jGXiuEIig-1; Fri, 20 Jun 2025 12:41:46 -0400
X-MC-Unique: 7eGptlFuNii79jGXiuEIig-1
X-Mimecast-MFC-AGG-ID: 7eGptlFuNii79jGXiuEIig_1750437706
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ae066127959so30854466b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437705; x=1751042505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sGYtFnI+UJzF2rX6EpStjzkEq0FKTxfvAu4tsZnx1Y=;
 b=jMsTHtbWehxuRi7legc/NTOY0Jml1+qfn7meNxpz661RQ7/zDOOvJj1CWm9752ULSU
 GrCc7wynxP/KAFMvj+JyHXEqaaS42Vz80v+YY1z8b9YMRtI9JRdi7ODODlomITpDAxqo
 ttGQpVGqHosmQlEi1NGOzjjvBtRa69c8L095qZwpTvosD1Uwb5/vQpsuiboupDTk5Ncg
 MjRvkzerT8ALddij3cqBK/NQK32amzrIpuoKAFoRGrfH+QKCgulmNlO08y+VTPhYzEOg
 PpUemFHF3r3tVWxsuZTjrMC5bgiGLy89igTn0x6s8MR880NW/RVh5n6Yt1RpmaGbRuCE
 QG5w==
X-Gm-Message-State: AOJu0Yx2SYzJqeDZVSxLBzGQql7iJZYlXQMT86iTc9+e8DIpq0IgWAsS
 35lOh+tPqA1YwwjqSzAPY2NX92JVpoBk6bhPrt3nsR42e3cJLRE980g0hS7g3GCx/SgVWjhofv4
 9dVVwEFlGpR1jrjSqU3WFS5ZM9y4+KCnnsPsURNIfsOcep8wyETokwp98f2js8ENHNqNgkW9bE4
 O1cO0RZ8hOquEGqo6BDWmtPEoRnYJ6Bo+08H/P2YDC
X-Gm-Gg: ASbGncu1VT8HFkSVgPXpjlDqTiO2xR1al8JXee+bTgLegjN4oigQEiMjzX/3rsJO1Z8
 xvtPFva7OWwXXe/msD6MXHU+RIJIRZQ3lnndduGc1Q3cQXWZj1V4ZRLERKeqGtH+Wm1V2xHo7Ia
 TyDMzrgm6gvyCFt8eOqGQ8HRtTLm8nyDbov00+xlHQusWyytdp8Bqt3usVmWlJbJNkLBb+/KpIO
 t2E3hZkln0f1mkB4ZLb+P7o71q2d9TNMSK0OnNd83/+4tdd3VJMqztuM36ANGn7c8Mmy1jsqZsa
 YC40/7XFdkPUROzKfuJzwA9MAQ==
X-Received: by 2002:a17:907:3f29:b0:ae0:54b7:f180 with SMTP id
 a640c23a62f3a-ae057baf2c3mr281740066b.42.1750437705029; 
 Fri, 20 Jun 2025 09:41:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETsHycDkaEDSnsNqaOPNEigIN/u35z+4nFC1syE49IfRV3zqhZ6G0qMgBXC4bKAqfqiLg0yg==
X-Received: by 2002:a17:907:3f29:b0:ae0:54b7:f180 with SMTP id
 a640c23a62f3a-ae057baf2c3mr281737866b.42.1750437704599; 
 Fri, 20 Jun 2025 09:41:44 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053ecbe9esm184555266b.44.2025.06.20.09.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 18/24] i386/tdx: Error and exit when named cpu model is
 requested
Date: Fri, 20 Jun 2025 18:40:46 +0200
Message-ID: <20250620164053.579416-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Currently, it gets below error when requesting any named cpu model with
"-cpu" to boot a TDX VM:

  qemu-system-x86_64: KVM_TDX_INIT_VM failed: Invalid argument

It misleads people to think it's the bug of KVM or QEMU. It is just that
current QEMU doesn't support named cpu model for TDX.

To support named cpu models for TDX guest, there are opens to be
finalized and needs a mount of additional work.

For now, explicitly check the case when named cpu model is requested.
Error report a hint and exit.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250612133801.2238342-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 820ca3614e2..2b52de9d71b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -739,8 +739,14 @@ static int tdx_kvm_type(X86ConfidentialGuest *cg)
 
 static void tdx_cpu_instance_init(X86ConfidentialGuest *cg, CPUState *cpu)
 {
+    X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
     X86CPU *x86cpu = X86_CPU(cpu);
 
+    if (xcc->model) {
+        error_report("Named cpu model is not supported for TDX yet!");
+        exit(1);
+    }
+
     object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
 
     /* invtsc is fixed1 for TD guest */
-- 
2.49.0


