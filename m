Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8588EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMYc-00013t-7m; Wed, 11 Sep 2024 08:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYG-0007sL-Uf
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1soMYD-00016Z-Gm
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726058064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UrN7D4tivV0tP1DhJlOSWVjlUhO1d1hy6W2UrVe+mlY=;
 b=YnZNpg0wqZZ6VojMqzE+OVJLrs7V3+NtidlRmfBBYqY+pYSGOG86iRPYUUdi73ytCXrIk6
 MH9A41sKFr9iTNHYeH/4oDNyf9gz+1dXIZYXZz4NCn+VtJXI26YU7dZKwzom/+VK+uxIRr
 kDsFI0zGMhWI+uexLUHiFRaoUeMhGBI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-xhJAdcUZNYqVr7zIFk2Wdg-1; Wed, 11 Sep 2024 08:34:24 -0400
X-MC-Unique: xhJAdcUZNYqVr7zIFk2Wdg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c301db60so2872543f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726058062; x=1726662862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UrN7D4tivV0tP1DhJlOSWVjlUhO1d1hy6W2UrVe+mlY=;
 b=KGSYDYfQ891U9VqNClG5RBeD5pqFzuj66z4qcD+Fw7uGiqW6Py+rtDrM1buG17zfZI
 LhAYk/Ji56/gD4bxMLzkbvGBeum/K61OOEE0mWKTfNwBizHTEcEVX8GRigmrQaBvC5g6
 lb4Jq2DW43oftZBZevpp7dxfg/EFV1FHePCiwW2ZkXUIQrI/x3W/s/tQCxzPIm8XXKdx
 IGYIZvxfWxL5+dtHuJqkMmAugbB+bXxreggq0j6JGF7HvtY6nBdGr2i2P+n9NG4nt25x
 ABURYZH/1CF9BJa224SfmVspj1qO/b6XjZrNUuf9tl8unya7NUgukXJ02uCspIP1OWI7
 RO5g==
X-Gm-Message-State: AOJu0Yx9Q6+CbudYEry2sHl2XjJsBk3Hg0kBRXBkBT1fh/b+BsItH3kw
 1UV5HnfL/RtcTmSjWsRqwxbLmQLHhVdnygkPs29pQ5ycQR/XaePLClMyDlx4xiniy3dUoura4So
 uVfORiPMPGtB6fq84tFRq+/lml6XM0Z1YbuAoVlqfAjdvU2tSTnhXqT3iBGvvVUILzNI7ylM59V
 P+kjQ30+VH4ZEMx18JiXpiZQR7cLp5Fu4kTxDGFbM=
X-Received: by 2002:a5d:4402:0:b0:371:a70d:107e with SMTP id
 ffacd0b85a97d-37892685889mr7410250f8f.6.1726058062109; 
 Wed, 11 Sep 2024 05:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc+Xq4e8/dTvEEQA4QDseIOmVkIgTO67keasg7fRv3bfJF66PtEtbBmMN3DrWYzSvO3S6hdw==
X-Received: by 2002:a5d:4402:0:b0:371:a70d:107e with SMTP id
 ffacd0b85a97d-37892685889mr7410228f8f.6.1726058061589; 
 Wed, 11 Sep 2024 05:34:21 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956de0e2sm11439107f8f.105.2024.09.11.05.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 05:34:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Fabian Vogt <fvogt@suse.de>
Subject: [PULL 12/17] target/i386: Expose IBPB-BRTYPE and SBPB CPUID bits to
 the guest
Date: Wed, 11 Sep 2024 14:33:37 +0200
Message-ID: <20240911123342.339482-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911123342.339482-1-pbonzini@redhat.com>
References: <20240911123342.339482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

According to AMD's Speculative Return Stack Overflow whitepaper (link
below), the hypervisor should synthesize the value of IBPB_BRTYPE and
SBPB CPUID bits to the guest.

Support for this is already present in the kernel with commit
e47d86083c66 ("KVM: x86: Add SBPB support") and commit 6f0f23ef76be
("KVM: x86: Add IBPB_BRTYPE support").

Add support in QEMU to expose the bits to the guest OS.

host:
  # cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
  Mitigation: Safe RET

before (guest):
  $ cpuid -l 0x80000021 -1 -r
  0x80000021 0x00: eax=0x00000045 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
                            ^
  $ cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
  Vulnerable: Safe RET, no microcode

after (guest):
  $ cpuid -l 0x80000021 -1 -r
  0x80000021 0x00: eax=0x18000045 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
                            ^
  $ cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
  Mitigation: Safe RET

Reported-by: Fabian Vogt <fvogt@suse.de>
Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240805202041.5936-1-farosas@suse.de
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 31f287cae05..ff227a8c5c8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1221,8 +1221,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "sbpb",
+            "ibpb-brtype", NULL, NULL, NULL,
         },
         .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
         .tcg_features = 0,
-- 
2.46.0


