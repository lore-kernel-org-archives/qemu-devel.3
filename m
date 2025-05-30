Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD97C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtz5-0007H0-AM; Fri, 30 May 2025 03:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxo-0004G0-I9
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxm-0007Fe-Ud
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j99FLrHZ8/z3mkKY9xpHPyH24ekACWxNaTSxClfAH/w=;
 b=I6HFJ3dqtqrFQ1amceEN+JUGt9Knu01amszjabG1fSKyFu9nWH/0gq1oJZEwKQlu7C0rQY
 EIeeFURNW2bQtV19cKhCAr/yAozpmK8UaqJEM/GP+objC1OqAJl4wHRkG8s6lvrSiANWvD
 PyF6ZrTDNd6CsjqtdycEQ0HaWZ1kYUQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-Nb1DhgMAP_ySx3vacYJgWA-1; Fri, 30 May 2025 03:15:32 -0400
X-MC-Unique: Nb1DhgMAP_ySx3vacYJgWA-1
X-Mimecast-MFC-AGG-ID: Nb1DhgMAP_ySx3vacYJgWA_1748589331
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acf16746a74so116092966b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589331; x=1749194131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j99FLrHZ8/z3mkKY9xpHPyH24ekACWxNaTSxClfAH/w=;
 b=VdqAwopN/0+17TBu27g5TZPnQh1uWbLNkwEzI/GvWrlMHwAEoanoQXZoI8WfEx3daP
 TyBm+hws1sdvlkwH2kNbV0tCIaV6uN/6Kah7GVm5BOW3Hyv6M6L9qV1tFW75FU+wiE4d
 HsdI3NSlG0j7kt5ecXqfPBA22qZn1xyfvCG1ynCmD4JKyu6So0sQrwEs61eBWeMFKOto
 ydVEZa3RenXrWuLkgNAmQxON+GPUbGNQmm0z1JK8PedU40puguf2QFsQdUfq8mnXg8bs
 VEbtD5XG45LW87U7hxO5s4NPar0E8gvPXVlSTqrLtE4XmqvErJzIz2a6eXrq/DyBOmdP
 bt9w==
X-Gm-Message-State: AOJu0YyIY4SopPfTGwfE0iKrMOXfL8wBJ9Gz9oP7SrYmDHkMkYFj9Y1f
 WMXqbUIM/2rphw8G9hpvOdqAkZup73VcONP8LWwPqQ1J4RFD/4DlCS5zqfbxvvne1w5sQJytHUr
 WPkU6xsIL04MKLZ564U1I2E8BunzkBLY/+5crxnEbg3DNsfRSZemQRxm2jyJCjBAsVD+R90oBqW
 hZIoGKsmdgyReRtnW0qDMOGP6w8a+bKiwjiot3jd96
X-Gm-Gg: ASbGnctCI8TQ526QoPwFUDlaehP6yZnhDm+npLkZXAj58xggf1L7wJI8gfZaVqu77sm
 yaYucFpED2yGuN66nORQWxOEF6R0q9e8XyjylBbnsmhr0PyoZO4FiPNgUaQmJdTdfrMcPqBnt2d
 +kCDcmjJ8ERYWltgFBAU4z2DETok7NpcFagzDPl0KTVGEjJLKc9M8j8OdYI6BJ9af8bt96uIdO3
 qX8bEIiQR2nRn+ZAUYYi8AAIVShPt3Gyl50RCbxIcs9PSAE3D7Q6MgW19z9SguJY2HV57OW3ycS
 iSMN2tlR/zUR2Q==
X-Received: by 2002:a17:906:6a21:b0:ad8:9c97:c2e9 with SMTP id
 a640c23a62f3a-adb3224582dmr238591766b.1.1748589330693; 
 Fri, 30 May 2025 00:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDg3ySrYTKo/ofdiHRIDm2X7ooj5PdIQJhFiTGUb5P3izQO4E3C6DMzSWGQwpg6QvhKBt86Q==
X-Received: by 2002:a17:906:6a21:b0:ad8:9c97:c2e9 with SMTP id
 a640c23a62f3a-adb3224582dmr238588166b.1.1748589330207; 
 Fri, 30 May 2025 00:15:30 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82e846sm274443966b.70.2025.05.30.00.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei Wang <lei4.wang@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 63/77] i386: Remove unused parameter "uint32_t bit" in
 feature_word_description()
Date: Fri, 30 May 2025 09:12:33 +0200
Message-ID: <20250530071250.2050910-64-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Lei Wang <lei4.wang@intel.com>

Parameter "uint32_t bit" is not used in function feature_word_description(),
so remove it.

Signed-off-by: Lei Wang <lei4.wang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241217123932.948789-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 383c0b35d48..6258027ab15 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5771,7 +5771,7 @@ static const TypeInfo max_x86_cpu_type_info = {
     .class_init = max_x86_cpu_class_init,
 };
 
-static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
+static char *feature_word_description(FeatureWordInfo *f)
 {
     assert(f->type == CPUID_FEATURE_WORD || f->type == MSR_FEATURE_WORD);
 
@@ -5810,6 +5810,7 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
     CPUX86State *env = &cpu->env;
     FeatureWordInfo *f = &feature_word_info[w];
     int i;
+    g_autofree char *feat_word_str = feature_word_description(f);
 
     if (!cpu->force_features) {
         env->features[w] &= ~mask;
@@ -5822,7 +5823,6 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
 
     for (i = 0; i < 64; ++i) {
         if ((1ULL << i) & mask) {
-            g_autofree char *feat_word_str = feature_word_description(f, i);
             warn_report("%s: %s%s%s [bit %d]",
                         verbose_prefix,
                         feat_word_str,
-- 
2.49.0


