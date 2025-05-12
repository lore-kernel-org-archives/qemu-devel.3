Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0796C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPsO-0001yy-TC; Mon, 12 May 2025 05:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPs7-0001g8-UA
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPs6-0000nW-E5
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZA5SCwWHXAhyr4Kf82ZD+UAmXzefk5lJ18SLFdHgZg=;
 b=GYu5DuqwMpPzsTmTjRajdo86ktY/uBW4w3B8247Sf3Bpi0DDU3f8gRqmdpISOHOBqDCV02
 YNaILrdN0jSIAFoJ1NEHLLMHmRUpU/BnvyG5TZ2NMRTa74JAUkLbssSmdCwRxsXW7dideF
 NX0TkCNvJIBlbaqAARFZ1ZFIET/pftQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-CFQ6WhFwN32OqH0Ryynt9A-1; Mon, 12 May 2025 05:54:51 -0400
X-MC-Unique: CFQ6WhFwN32OqH0Ryynt9A-1
X-Mimecast-MFC-AGG-ID: CFQ6WhFwN32OqH0Ryynt9A_1747043691
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5fc86ce3c54so3182775a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043690; x=1747648490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZA5SCwWHXAhyr4Kf82ZD+UAmXzefk5lJ18SLFdHgZg=;
 b=jkZa57LpwFymDpcSuiCCTUr3EsFl5lGtjf4GWg2OE2YZ7K5q4XVj3HIDWUFZamq/KA
 yrZiIYiVKRCjrDEfdHg3wONYDCqymhkg+28sqgui6h891bMc9xm0DsdQijzcq+dK0NEE
 vVRdV9kELbYJVQb0irIJtJkVroPdWY/wn84J4F+Pq9Y3ub+HsL4pdUeM5lwQ3lITJ1af
 nAFnPYE/rHOhqi7cEfhtScBpCDFtekX5yDr+dbeoL32ve4RKhdqWtOcPgMS8KIvjthKN
 ZO631kp1ABBiDleoD7Oy6kwjqxcxJUmMTX2bJDdSnpM5ALp9HGme88AdU/eK16kxuTUn
 eGpQ==
X-Gm-Message-State: AOJu0YyKWKHg3I4T1SLn0aBRJIIxDxIaHcj74XTlxqM1C4mGfGdXlXFW
 tKskuZDUiX01ZaV2ywOPjQ2eIxFjmy5TkMi1wiEeO7I4fy/cXDu6A5xob+5XA28Fa37FIOkC/Kc
 VY22OtvXGgKyGpP5R6FY6FMaOgPF2qAsXepHfSl3MxlWDyVzKYu7JNpFTQlQQp1oIjWQJkypYHy
 hqvXKv7i3M1N6v9JGb8FWZ24qEqy1/0B0HHu2p
X-Gm-Gg: ASbGncvUP1/YUQwRlYbH7N+TE0olYYr7+iV5/+GGjfGcpnSIp/SKSZYi0z5u4M5t3HS
 fz+vMeIHMySIV1wvVQpGcsfOaw3+qX0kuazDNjsSRhYsHRMJ2IcEU4xyLhh4a83dR2F/bKm4CPA
 +hyGXOrNB7SCVjgA2kqCmHeYbVcqriL+3EkUP925nkXnjwgoySwMCWYrhN/C4UmpoMCiZDVvA/D
 bA3juDUOuf9C9UesC8OeFBZcQ9wrk7iAey8GjG7PdV6vkBd+m2GJAPbSwRRP0M8AcmGcTHXBAUx
 +DYOJRqGZmNgglSHOfRBaGgLipCPL8vqDGovgSlZTNehHCA=
X-Received: by 2002:a05:6402:520a:b0:5f3:857f:2b38 with SMTP id
 4fb4d7f45d1cf-5fca079cfa2mr10997927a12.17.1747043689772; 
 Mon, 12 May 2025 02:54:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9N3qFXgyGh2a41TpQ5w1/ZAa4dlBDHyTki4sj35gA5jCcraNVFU3aiECXwXJu9Lu5TeFNTA==
X-Received: by 2002:a05:6402:520a:b0:5f3:857f:2b38 with SMTP id
 4fb4d7f45d1cf-5fca079cfa2mr10997905a12.17.1747043689316; 
 Mon, 12 May 2025 02:54:49 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fc9cc26614sm5534537a12.25.2025.05.12.02.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 25/26] target/riscv: remove .instance_post_init
Date: Mon, 12 May 2025 11:52:25 +0200
Message-ID: <20250512095226.93621-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Unlike other uses of .instance_post_init, accel_cpu_instance_init()
*registers* properties, and therefore must be run before
device_post_init() which sets them to their values from -global.

In order to move all registration of properties to .instance_init,
call accel_cpu_instance_init() at the end of riscv_cpu_init().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f4d4abada75..2437d53d4bc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1083,11 +1083,6 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
 }
 
-static void riscv_cpu_post_init(Object *obj)
-{
-    accel_cpu_instance_init(CPU(obj));
-}
-
 static void riscv_cpu_init(Object *obj)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
@@ -1143,6 +1138,8 @@ static void riscv_cpu_init(Object *obj)
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
 #endif
+
+    accel_cpu_instance_init(CPU(obj));
 }
 
 typedef struct misa_ext_info {
@@ -2885,7 +2882,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
-        .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
-- 
2.49.0


