Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95681C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHBj-0004jX-7D; Mon, 14 Jul 2025 07:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1P-0001ua-FC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1K-0002BO-IJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8l/csJz6aqWH0HqNXLPqKmWn5tg99krkmHfDQiMl9E=;
 b=MzgGAUkNZvYEYP3pqEWSC6FPekTiGnspjigF5Sji2rI2dk5oaejxlDQDM/xDJ118QGmddA
 qCxZiuo8nkpJdj1k5r0OjlYmQwoq5pR3OK3snWcqBvqPPHghvXf//U788m+wxPlHw+b1zx
 AbZ+Y8I46W3hkngxb6M9B7JeaV6zDZM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-XXLVFf2hNzywSsCsjd1sKg-1; Mon, 14 Jul 2025 07:06:51 -0400
X-MC-Unique: XXLVFf2hNzywSsCsjd1sKg-1
X-Mimecast-MFC-AGG-ID: XXLVFf2hNzywSsCsjd1sKg_1752491210
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4561dfd07bcso3354525e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491209; x=1753096009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8l/csJz6aqWH0HqNXLPqKmWn5tg99krkmHfDQiMl9E=;
 b=XPF6gJoqsAuY6qBoDxzVloJxt2ePKJizzOY6eAllYaVf0wuPoFuZC2DueCwmg8DXVV
 Sf5Q8RAV0z9irvSA8afYuua0Bic1QYz3g4QaE/FqP0w+hcN4hH0z87qy7XtylP7tGVos
 9xnpTcDfqI74cCa5AEdbe/HjI74uxAzG9sxJ+d4l8XuSWUtXCGSeJa/Ax28D7TEOItsf
 EEd5wShQ3cGNZ8gckusmDxbOwm6ZSTG6gFbv4C4NRm6oUSSo5Y18zLPWyyILZK1Bq13E
 fGUZFzNF8+tlrdiaLtFLtGnwxAu179Fjz0rT8Nx3UfTxZVyumUkIRMEp4SYuGh7rhwnC
 qfCA==
X-Gm-Message-State: AOJu0Ywi54o4DaMl1krPuukGRRjEETveIb4o4Q/0K15Jw4GK+VQA29fQ
 z5QLtRJ/vSKyuuEL+BYbSGJ4+WkH3wnw7vqmnoFuyZYniUrmzImh2nJdocXUkhrjpEvd+BWv3MX
 8oFyyclSrky/VoPgiZE6ZXGpx+GKmJjCAq4jc+lZLNaj1hXHHL7aJxMUZ4hBOTgWxDtKeidalTP
 pqsL9u2dUO+HOOOeghEriikV4XO2Y3QEU7+4OJ2puY
X-Gm-Gg: ASbGnctp3aha3tZfJ2047/ZPGQSGA5d3R5nNdz8n/SB3iiAfClgM+jsr1w3UqEb5tra
 xbpi014s+x0366e/gOF9hD76GWCopxb5DV18hhrTDxzGlUDriTZ4bNs+QBr3ExrCUyPYjmHuT0o
 lI4BBpFAXY6dTKXEBU4fOkBYKFX1oEjWIMKBT5IV0F1e8cy/19fiqF/VNpM9IEGjHwkp6VYDOnK
 xw9V8zgwuSLzwl+vU/4QL5M/5FrOHQ06eVAAouf6/zl//0xxKtbFdED3LSJGt55w7R7/Ai5yCUT
 NXUb9zH4XdLx3Vd21SxLHTVvFrHuYWiwS6b1mweqem8=
X-Received: by 2002:a05:6000:2d82:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3b5f1895c6dmr7159568f8f.24.1752491209217; 
 Mon, 14 Jul 2025 04:06:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxmPZwIme1PXX6Qy7MSnj9mcpH8ZntQM9JI2HQvkdeKbMmt7x+0UOw4sY+A5o9bbkDAXGBEg==
X-Received: by 2002:a05:6000:2d82:b0:3a4:ead4:5ea4 with SMTP id
 ffacd0b85a97d-3b5f1895c6dmr7159542f8f.24.1752491208641; 
 Mon, 14 Jul 2025 04:06:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e1d5sm12164024f8f.78.2025.07.14.04.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:06:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manish Mishra <manish.mishra@nutanix.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 62/77] i386/cpu: Add a "x-force-cpuid-0x1f" property
Date: Mon, 14 Jul 2025 13:03:51 +0200
Message-ID: <20250714110406.117772-63-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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

From: Manish Mishra <manish.mishra@nutanix.com>

Add a "x-force-cpuid-0x1f" property so that CPU models can enable it and
have 0x1f CPUID leaf natually as the Host CPU.

The advantage is that when the CPU model's cache model is already
consistent with the Host CPU, for example, SRF defaults to l2 per
module & l3 per package, 0x1f can better help users identify the
topology in the VM.

Adding 0x1f for specific CPU models should not cause any trouble in
principle. This property is only enabled for CPU models that already
have 0x1f leaf on the Host, so software that originally runs normally on
the Host won't encounter issues in the Guest with corresponding CPU
model. Conversely, some software that relies on checking 0x1f might
have problems in the Guest due to the lack of 0x1f [*]. In
summary, adding 0x1f is also intended to further emulate the Host CPU
environment.

[*]: https://lore.kernel.org/qemu-devel/PH0PR02MB738410511BF51B12DB09BE6CF6AC2@PH0PR02MB7384.namprd02.prod.outlook.com/

Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
Co-authored-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
[Integrated and rebased 2 previous patches (ordered by post time)]
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250711104603.1634832-6-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 40f3b5eac88..482979a4437 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9940,6 +9940,7 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
                      true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
+    DEFINE_PROP_BOOL("x-force-cpuid-0x1f", X86CPU, force_cpuid_0x1f, false),
 };
 
 #ifndef CONFIG_USER_ONLY
-- 
2.50.0


