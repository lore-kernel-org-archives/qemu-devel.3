Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA602C282CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxb7-0001w2-MT; Fri, 28 Feb 2025 05:28:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxb5-0001vN-8W
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:27:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxb3-0002tj-Ho
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eG4hWUOrVItyzZ2vvf2lH+BDjG5h1hdnnPbPZaWGpQ=;
 b=S9ytifbILzWoHr3lLKFsWa7YA9S9/73h4Ln5W8I5I7ZlvRAlUlERnFqIoL15TCsyYZ4AZY
 llE7AEVNt3LXWgOR8RRx30Yp1t9jsQ5lrk5OMlpGg/VqrTxUHc8QIU1kHyFYdaxiGvuwW1
 keXCt7Qz7c2MXwjeoNqm6qXwnvSsH1E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-vF1d--nmMr2rgiRn8akdmg-1; Fri, 28 Feb 2025 05:27:55 -0500
X-MC-Unique: vF1d--nmMr2rgiRn8akdmg-1
X-Mimecast-MFC-AGG-ID: vF1d--nmMr2rgiRn8akdmg_1740738474
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ab4563323so10538285e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738473; x=1741343273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eG4hWUOrVItyzZ2vvf2lH+BDjG5h1hdnnPbPZaWGpQ=;
 b=FvPsc5PiFgFoIzFkqgN4bEcDwodXRI0cyKHcV4qksUJ4wYyVEHF2Wbx8MRr40yvpeY
 2qWkGH03DfJAkm6/nUeAoJlKZuTulmZWH1XHEE7/isByh6f7ORW80RBOamTYYHWHkueT
 Cx/IDeVYEBMlunusSZN42JbqfM/iykoNHmBcpAgyzM/NvWf7lW6ibUjbH0A4S5QKZnUv
 06uCYJcwYjQxoMqqsajQ4FIFzd8BslpFUXUR/7xFIru9oVwwGZZ2zKyK+C7pE6i+KNrp
 03tM4KiQyPqmLWqZ5vi8CEz+5hUFgFRjTlOO1bHrQOOcdGvVpFX5j1l44HXbjXq39YOg
 Wf/A==
X-Gm-Message-State: AOJu0YyVommLym1wzgvOqi7Oo0Gs+U0bnRGkwWkTBuHtbRd95eqPKZgT
 aJacNUElsQnqteOFxH478jeNWDZegoMgFFOeIHcwBDMpDj0NU4nzK/+Qo+7nw2Tp1xn1O6WnF3a
 +btmx7xEtquJRoz/fEW815yk1Jf+wvqLdwVBf3MsQ14DK2V7cFgyvPzph0yZVlwZWG1ZuIcQWiz
 NsVtLdui95oHFV+pY8oJ4G83BhYVIJyBHtEGddj+0=
X-Gm-Gg: ASbGnctIuHaJg2rn3+GuHECEN1uHG5qXqkmzTfB3eT9nirNddblbkhdh0iEGCwLmLi1
 ExpBFx+LvrRB6DC6PW8MhB8u5C2hrRqs0sLBothVq5AY/UksSyCSMarxJenQypyH23xHE4Andkn
 yRz+3uerHLvPgFckJCM6fwIUS2dqX5hQDVauMzMEUA7jKmP0gDbduWLyZPdIsPlobs4FKhuP9m3
 xfpC9AMp8LA8skJ9aI2X5w6MBPtr48qQeQHEVKImeh4njDIjcFrzbzPVJ0y7zkwxQie78wJWV5T
 jtELb1EGUI2GaftCuDOe
X-Received: by 2002:a05:600c:5251:b0:43b:8198:f6e5 with SMTP id
 5b1f17b1804b1-43ba66e1dbamr20809935e9.12.1740738473139; 
 Fri, 28 Feb 2025 02:27:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhDlsGNz5Vnt/vhCpu8zZ7f5K9gOnGMs0p1ZBKmBDCXW7Lhb2czz4wbKbucDna1T7Ykl4jIQ==
X-Received: by 2002:a05:600c:5251:b0:43b:8198:f6e5 with SMTP id
 5b1f17b1804b1-43ba66e1dbamr20809655e9.12.1740738472583; 
 Fri, 28 Feb 2025 02:27:52 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7dcfsm4835387f8f.55.2025.02.28.02.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:27:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 02/22] target/riscv: Convert misa_mxl_max using GLib macros
Date: Fri, 28 Feb 2025 11:27:26 +0100
Message-ID: <20250228102747.867770-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use GLib conversion macros to pass misa_mxl_max as
riscv_cpu_class_init() class data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20250212213249.45574-8-philmd@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 85dc2fe3bec..f05b72ac873 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2961,7 +2961,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
-    mcc->misa_mxl_max = (RISCVMXL)(uintptr_t)data;
+    mcc->misa_mxl_max = (RISCVMXL)GPOINTER_TO_UINT(data);
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3063,7 +3063,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
@@ -3072,7 +3072,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
@@ -3081,7 +3081,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 #define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
@@ -3090,7 +3090,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = (void *)(misa_mxl_max)                \
+        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
-- 
2.48.1


