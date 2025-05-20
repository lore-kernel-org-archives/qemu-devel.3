Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FABAC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKor-0002lm-PW; Tue, 20 May 2025 07:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKo9-0001qc-Vc
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKo7-0003Pv-TT
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fl19oZy/IVwWxj46KmzPq64RQnPmJ1lzr3l6M+JMxA=;
 b=IvVsC6hN9wpYl9T4nhOEbnGWnb7SgxGof0X3u4LVscnK6Cl4LiUibqf+yHTkpVgYCvsfql
 6YIwNT6/R75onCKtbHFhA66+FEi8GxCnAiZ3FqkFWSRLz5cJ50lPigcxdn+TSiAqNSFv/D
 TqHQk5sgWWs0UVkLEFhiZ1QA+tqXmYs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-iILmuyNFP6Sn9sWVLQszCw-1; Tue, 20 May 2025 07:06:50 -0400
X-MC-Unique: iILmuyNFP6Sn9sWVLQszCw-1
X-Mimecast-MFC-AGG-ID: iILmuyNFP6Sn9sWVLQszCw_1747739209
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ad540ac3219so322668366b.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739208; x=1748344008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fl19oZy/IVwWxj46KmzPq64RQnPmJ1lzr3l6M+JMxA=;
 b=nTFUYX0z19ICidz+DnVmsZQ3lxy4B5HKBclacB3dSzn8JutwIkKP2iNnk6UVY7+/Yr
 Urd88f+OGwNomPXR5FndtjCK4KCxpWUxp5jVXOAGcWy3rykkGUkNtEo7yoE97lwcrwhV
 +ItbpePPb5IGBCjk8hl9TSEI+kW7EHfuhTBk491/kwtsVPdS1R/jxypnyfvSz6rM/Ntp
 A/LKXh4s1CCokkhcshJDLSy7ex/cverkme/DPwn+qPDWSwx2sdSn7F+9g3kw46kxSxAV
 jmwi9Us9DBmBtTlsjOvfeMHa4ubjuXemHkPuhKQfk2wJWlCtwIcD1+s44FUyTwbPy/ci
 vdIg==
X-Gm-Message-State: AOJu0YyfQ3X2kWTcBxxnsrNsOCL+ARlymplUpsFoJNqFgGt0iW2YAnO+
 AI1R+rY15IuuoaGRgOIg8h2O1SdXDHE2NQhpmnie58IRSgbI7acW1F4YcK/KtE2vuJg02nkBWh1
 HzC69TbhxG5YYSLf0YsRN7kCllsbEB7vdxSjj3DI+lwMqZUpEdAY8HR5NOEqfHtzHXA4XXhnfMk
 FsYrVexTfSq+oPhDo5FeNqsHX9j58EUN9H5wod+s31
X-Gm-Gg: ASbGncuwwT1sgSH3BoP9xpDQ2Chh3Pcb3bs6Q0u4Djd251f6KiNdZ7NOY37g1VpOU4I
 1vZMdX3ngD2P9rAwX5tEmBcR0vq1KApaHVwwa+OWKDhBIAYP96SDmE/mpO3qWub8LpNhd+e5qXP
 xVgHJJhbKM4kTB3hKJvt3XuMVbM+Bsm7CjilZBrf4RunYExfW8+lbFZJtJxcUK+Pco2Q43lpboM
 3edaxrbXVOC9q8AYW5B9BcZU4t8Qz4iza2gTdf/EHwW64wfaVRs08pLJi2nC0010CsYrIKl3Riy
 DGHrdvqZ70o+OQ==
X-Received: by 2002:a17:906:13d2:b0:ad5:4b45:8386 with SMTP id
 a640c23a62f3a-ad54b4587c7mr877466166b.41.1747739207931; 
 Tue, 20 May 2025 04:06:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoLnIkej2AfPbFHLczB5BzxDpSg4/1XU1ILNfthjstmg0yAocdmTocEc7JjRPufiCu7hCrRw==
X-Received: by 2002:a17:906:13d2:b0:ad5:4b45:8386 with SMTP id
 a640c23a62f3a-ad54b4587c7mr877463366b.41.1747739207517; 
 Tue, 20 May 2025 04:06:47 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04e821sm719417366b.17.2025.05.20.04.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/35] target/riscv: remove .instance_post_init
Date: Tue, 20 May 2025 13:05:29 +0200
Message-ID: <20250520110530.366202-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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
index 640aa958fd4..629ac37501e 100644
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


