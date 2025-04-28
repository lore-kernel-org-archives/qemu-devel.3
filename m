Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA34C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J2b-0007cJ-3x; Mon, 28 Apr 2025 03:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1y-0006fh-VN
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1x-0001IS-00
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SKDfMmA0AuQdPUH1MbHZ12CVAQV2+24KqplqqhOMbo=;
 b=Z9x/xtrzxt9IVwJMyB/aqQWmQYXpHrUUm/csUpibNM6A+RvJW2GyAlavKNztDTCdtKQaB0
 4Bp6Xr+/LtVw0OcRc7/HoF50Ogc7v0Rg2l3vQ1JzsAA3VspM6zDMvvOW5Lwj8rliqPlZeZ
 smUtTlhU1ue/V51bCqK3YE/Ir5+utic=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-oAmb4nynNguRcqfHXcbfKA-1; Mon, 28 Apr 2025 03:35:50 -0400
X-MC-Unique: oAmb4nynNguRcqfHXcbfKA-1
X-Mimecast-MFC-AGG-ID: oAmb4nynNguRcqfHXcbfKA_1745825749
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d6c65dc52so31538285e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825749; x=1746430549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SKDfMmA0AuQdPUH1MbHZ12CVAQV2+24KqplqqhOMbo=;
 b=ieSj5NWTYZUKAPXj1rwNP7w0LevZwUmuJTXDmnh+Y3w7lmzYGZbnboTtM+7eS89oJ+
 V/hkd0IjjrTjC1MjtsMi3x9rho/OLxRmsnWdEUhdiLYVnse0NOLkK2EdiSOQELg1skum
 aAt1FIRvgRjwfFULCoPlBa4WxdQrgsj2oQqLQ1n1laiE+y6T/MeevThSMaPBb1rBv6Ou
 g4oBmkxN2SoIYJFKgzN8KN7vK5AgrDm6biLP/5Kk0ybGjFKQptncGOOsxFu7BJGfzER9
 0nNlyRIhgBeGwCLNTKKmqqx93p42rpjzxRkArVcbOeqELtm6QWKItahp5cbarnlVNJ9K
 5ZKQ==
X-Gm-Message-State: AOJu0YwPKpdJcyfxvBBk3BmnVvTFmI1w9reJUTLyrZ3f+oLvdg2fKdzo
 JV+5pcr5x1j+iCV5TXb9auxBGn3kvhWi+FbFFm8SxDssttsLcwVK7Jjh4dw/pg56Vabk+fdiD3U
 GL1LpXF/i05SGzfBvhfvn4BC+3JVvhBjvON51G4mUP9UzglWPxDlQjPX0AqJPAPjog6uRteOKK/
 ZviTcASWSKOcHf0QS/hQjv0XwnAunD1yBkr5vN
X-Gm-Gg: ASbGncur2Zk+rH+8XafFpb7HPIC4RaYzjKbNEXp4VSyZg65XkL+iM6kEkYYwaAkQj/D
 0QG5Hdb/npuw3lsnPfS9R4bq19fxRKiAYsgDeSeOpqAD9WSfciLerBWeOQ0zySnrMGC0wgjbwRr
 Pgvlc/52zY03Jv46L/2b9Cqr4FN5VbwKy94Sw0WJbGjKDDeLcTifw0G/kakvDwqpVhxmhqLaD3a
 ZNCoOa3podM/xQqlNtIV0SnLCK67ZUMOk9FcCvj+BARQbDmGViocN1YGZu4UY+lReJmKmnZA2FF
 5kxMEst2AfT/7Uc=
X-Received: by 2002:adf:ec0d:0:b0:3a0:7a5d:96f6 with SMTP id
 ffacd0b85a97d-3a07a5d9bc6mr4902864f8f.38.1745825748871; 
 Mon, 28 Apr 2025 00:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzsBDvUob5WPzLT77w8H2vOwIFoy2j7LvxRxEebVZakW+ZW+/gspR2r8rpITMbqGQnYyQ0Hg==
X-Received: by 2002:adf:ec0d:0:b0:3a0:7a5d:96f6 with SMTP id
 ffacd0b85a97d-3a07a5d9bc6mr4902844f8f.38.1745825748449; 
 Mon, 28 Apr 2025 00:35:48 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e460b2sm10405307f8f.70.2025.04.28.00.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 26/26] target/riscv: remove .instance_post_init
Date: Mon, 28 Apr 2025 09:34:41 +0200
Message-ID: <20250428073442.315770-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Unlike other uses of .instance_post_init, accel_cpu_instance_init()
*registers* properties, and therefore must be run before
device_post_init() which sets them to their values from -global.

In order to move all registration of properties to .instance_init,
call accel_cpu_instance_init() at the end of riscv_cpu_init().

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e7e9e6bfe80..f1863344e8d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1084,11 +1084,6 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
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
@@ -1144,6 +1139,8 @@ static void riscv_cpu_init(Object *obj)
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
 #endif
+
+    accel_cpu_instance_init(CPU(obj));
 }
 
 typedef struct misa_ext_info {
@@ -2886,7 +2883,6 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .instance_size = sizeof(RISCVCPU),
         .instance_align = __alignof(RISCVCPU),
         .instance_init = riscv_cpu_init,
-        .instance_post_init = riscv_cpu_post_init,
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
-- 
2.49.0


