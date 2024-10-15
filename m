Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E825DD216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iMs-0005f1-8S; Tue, 15 Oct 2024 10:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMj-0005Zj-4T
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMh-0003Id-Dc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mCbkqnavCwlsR7zpYlSM7glzfmtMNxLyPCch+Pjdqc=;
 b=XxDYkrqJCfp8IH9OmfC8+o5EW38FQTwZg3WKORzNdYSnPmLfX8/ksZMhfVLN5r2OrKO38z
 Q8k1NWxEc6xy7fuNPNIDxubMLYJ05GycJic+Jd7ID1/+y/hvt++O/+ZWyp5iD0weUZ3cSo
 AFFyXUNGoVnRruRBc7qx3uTH4Q7E/pA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-dS89bwXvPZyhoKcwdjrsKA-1; Tue, 15 Oct 2024 10:17:33 -0400
X-MC-Unique: dS89bwXvPZyhoKcwdjrsKA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43113dab986so47944305e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001851; x=1729606651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7mCbkqnavCwlsR7zpYlSM7glzfmtMNxLyPCch+Pjdqc=;
 b=oInlvIHWMkLgLbsIIplJ0JaqxJK1GuagvJ4ohpDiJygKInutFV2c9BNxSB642uCGMY
 4hfFEPGxQSWb6/cPjHHZXhDU00FjtwUFx5GinJYy1KNf1WXf7RrFCxvgiwIw6mb/JkJU
 og2eiZx8U/pTEhXqrVJ+E+UGtHkxcwygidYOEFtK2qxQrmqoD0/QGmyuZqSbJdA+Hw7V
 HCBJUPZ5kPZWw8eWdvTcDVvrdvGJ7YabIs8jKYZJpUpdPQP/A1O4EwQvU57ydfcvWIdy
 ckTSG7cZvNIbaOOD3I/YXTZIMtz1p0aqEqhd6QVTzn8Xk5HVhLHFs0oAf9QAM4liDgpU
 Afrg==
X-Gm-Message-State: AOJu0YwoNt4M8iAcpZ4Ld+scAOZVr2u99ZAvcZb3ovpfbC4dHqm1SNGl
 hd1wMI2C3dUFDSRUNG4MILTJtroE2VUTGVKBEo68/kTjkVONyLIqT1jdkDvJdAUPUTJy1WNxP2y
 A6i7bbHf8X5wIi6xqoohu9hYuH/yCJbQB/4v1hHmfDuOsit3LGyEyN6mtK/GeZa5v2Uv69xp042
 qbK/aAfGEVCtzV3bcEK3QCgj/OpxUYLI2efOreLeU=
X-Received: by 2002:a05:600c:c15:b0:42f:6878:a683 with SMTP id
 5b1f17b1804b1-43125607853mr128479105e9.22.1729001851534; 
 Tue, 15 Oct 2024 07:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGUsIt7B3QWxyESwg2EYrsMLygHfkaByJ68+EB6jpYJNd4wR9w2zX8Qn24H/R97UGr2sktxA==
X-Received: by 2002:a05:600c:c15:b0:42f:6878:a683 with SMTP id
 5b1f17b1804b1-43125607853mr128478795e9.22.1729001851071; 
 Tue, 15 Oct 2024 07:17:31 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f55e002sm19499725e9.10.2024.10.15.07.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chao Gao <chao.gao@intel.com>
Subject: [PULL 05/25] target/i386: Add more features enumerated by
 CPUID.7.2.EDX
Date: Tue, 15 Oct 2024 16:16:51 +0200
Message-ID: <20241015141711.528342-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Chao Gao <chao.gao@intel.com>

Following 5 bits in CPUID.7.2.EDX are supported by KVM. Add their
supports in QEMU. Each of them indicates certain bits of IA32_SPEC_CTRL
are supported. Those bits can control CPU speculation behavior which can
be used to defend against side-channel attacks.

bit0: intel-psfd
  if 1, indicates bit 7 of the IA32_SPEC_CTRL MSR is supported. Bit 7 of
  this MSR disables Fast Store Forwarding Predictor without disabling
  Speculative Store Bypass

bit1: ipred-ctrl
  If 1, indicates bits 3 and 4 of the IA32_SPEC_CTRL MSR are supported.
  Bit 3 of this MSR enables IPRED_DIS control for CPL3. Bit 4 of this
  MSR enables IPRED_DIS control for CPL0/1/2

bit2: rrsba-ctrl
  If 1, indicates bits 5 and 6 of the IA32_SPEC_CTRL MSR are supported.
  Bit 5 of this MSR disables RRSBA behavior for CPL3. Bit 6 of this MSR
  disables RRSBA behavior for CPL0/1/2

bit3: ddpd-u
  If 1, indicates bit 8 of the IA32_SPEC_CTRL MSR is supported. Bit 8 of
  this MSR disables Data Dependent Prefetcher.

bit4: bhi-ctrl
  if 1, indicates bit 10 of the IA32_SPEC_CTRL MSR is supported. Bit 10
  of this MSR enables BHI_DIS_S behavior.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/r/20240919051011.118309-1-chao.gao@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5535f4e6ab4..9a6b9e9e51b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1148,8 +1148,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_7_2_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, NULL, NULL,
-            NULL, "mcdt-no", NULL, NULL,
+            "intel-psfd", "ipred-ctrl", "rrsba-ctrl", "ddpd-u",
+            "bhi-ctrl", "mcdt-no", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.46.2


