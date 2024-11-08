Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792AED64070
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Swi-00043a-OT; Fri, 08 Nov 2024 12:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swg-00042X-BV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swe-0007e0-JB
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GXeQjTNaAPfh0xkQIuz07mE5z10C7JXikWrLJP9TQA=;
 b=Q/9p/L97xoFshEaCSrfO4ALKHkGgyeLcoiLoBMIUfPW6atlz/vb6Cz3Rq8lTFanVU0IEN3
 u0ovhaJJb0iga8Z4f7JQpcFBUiL2vXfxou5EyhYO/1QOkISytoUvbm0OhVHY82Yy884lFK
 TBSDPV5kBJZq+HNOOUyCsD61a3bNxKc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-zQWRrsupPve4QVJTf6FJFg-1; Fri, 08 Nov 2024 12:38:50 -0500
X-MC-Unique: zQWRrsupPve4QVJTf6FJFg-1
X-Mimecast-MFC-AGG-ID: zQWRrsupPve4QVJTf6FJFg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43163a40ee0so16536875e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087528; x=1731692328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3GXeQjTNaAPfh0xkQIuz07mE5z10C7JXikWrLJP9TQA=;
 b=bNafdDMPXzm2LNjjiljRa+FrBBOOdqPNw0CYV8Tuwu8kMhuyvTeAPDBmSw+P1bmkIH
 iLiymJCMCeODO4ZxRU2kZCtwTcG1J1OpN70jOJTKCE/aJD+38uHhS+Sc+lcbxyFH91wg
 mc2DnLupiR1poRrr+ICd7P+RpyhvUQd419OCRIaSNY6giUgl3EtakD/6qzeP0SJGcZkh
 6e/Hvn2XC9xMK98w6LjYkY84+C2Cq6mRZNveaDycr3TaZloRwJy88lSvPuOBpW1OXpII
 HS3WdrKF6TRc052NcMX9KdwnkK6BXG998yjseG+/jHKMUhq+8seSvqWU+wzmgeGnS00n
 lgSQ==
X-Gm-Message-State: AOJu0YzIHClrgQfRqSvaq5qdBNKRYClQrIpFIV/J4G0gh1I4hQ06RBrU
 gv5gCiW2GRp/LOLWUIm5KuI8BlaQZA123esPD/2SyA0GoQsCu4c27lriIPwSGAYDEjzZ3kPYSk4
 Fr27Hg7KUUFt89cxz+l+B32tT9roThGRSuX9AFaef/q2ReCHW3Yg/OakS61vdGaAov2/7Og4vpa
 mFWEBpUJ5736ZcUsVA68+E7ANlb+s9+q9n8BvGP0c=
X-Received: by 2002:a05:600c:5488:b0:431:9397:9ac9 with SMTP id
 5b1f17b1804b1-432b7507c16mr27491735e9.15.1731087528395; 
 Fri, 08 Nov 2024 09:38:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlkz4ZEgRzi4wK+Q6KLKZwoggSXe4KyLkGIoJFHOM0+9y3TVeg6ZrI/S7YZ15hK7ln/pjxVg==
X-Received: by 2002:a05:600c:5488:b0:431:9397:9ac9 with SMTP id
 5b1f17b1804b1-432b7507c16mr27491535e9.15.1731087527956; 
 Fri, 08 Nov 2024 09:38:47 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9707d3sm5468676f8f.19.2024.11.08.09.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PULL 09/13] i386/hvf: Fixes startup memory leak (vmcs caps)
Date: Fri,  8 Nov 2024 18:38:24 +0100
Message-ID: <20241108173828.111454-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

The hvf_caps data structure only exists once as part of the hvf accelerator
state, but it is initialised during vCPU initialisation. This change therefore
adds a check to ensure memory for it is only allocated once.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Link: https://lore.kernel.org/r/20241105155800.5461-4-phil@philjordan.eu
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 68dc5d9cf75..8527bce6eef 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -239,7 +239,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     init_emu();
     init_decoder();
 
-    hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
+    if (hvf_state->hvf_caps == NULL) {
+        hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
+    }
     env->hvf_mmio_buf = g_new(char, 4096);
 
     if (x86cpu->vmware_cpuid_freq) {
-- 
2.47.0


