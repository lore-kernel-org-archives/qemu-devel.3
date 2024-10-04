Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76977CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlIU-000282-NV; Fri, 04 Oct 2024 12:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGf-0006xR-VP
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGe-0006Ch-4G
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g34hFuq4ii2wuTNDn7bYc7U1NVX9JTZP9beViRxwess=;
 b=JnJ0SjRXMq157Vx68FfMOhCyxAea9zywyYsPBXpDcCpPtTA7uioolBk4Werj/SBYCBbQz8
 L5Ua5NFyGUe5uSxqreJMkE5uixRUhXxwH5Xy8mL3k08AiEeVqCrn1YBGkdTPIHTCzm1+t2
 eWfr/81bjEjS0qX7cyzgrkjW7Lh88/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-bemiRuiLPUa15LKc8J-uZA-1; Fri, 04 Oct 2024 12:34:58 -0400
X-MC-Unique: bemiRuiLPUa15LKc8J-uZA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb479fab2so15011555e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059695; x=1728664495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g34hFuq4ii2wuTNDn7bYc7U1NVX9JTZP9beViRxwess=;
 b=Xm7ckab0RndPkdNdQsTAmUPO0dc5r4xwhrmN6vToaxkr82+gKtUJRZ6D4HHuhAB7+f
 ux0T5DPpCIT0I3Njvms3OIgzh9gzoaFtn+2MMgckhpAE3IIja0oHEAM6o+YeB1W9T6/L
 4XFMiHDuXq+dsPuJg4vgyPjDIbobddSxBgeOk2YqBLwaZZbYPv4nO4G34y/8vzBuQOgh
 hRi/PSBMgXLQwickziYR5RRRdnQQnfsxREiV7fqueF5ZOxUcliEOB9yZ4HV+H4PQDsZn
 Qpp2UKXqbYZoGzSe+B/QVN8nYREJEwrSbLecrbDUuV5NgBIC38t2I/wqtL1ZA9gUfSsS
 rZZg==
X-Gm-Message-State: AOJu0Yz7Vll9PUzxsyJ0tYZrsK+cVqvF4G0h3EM+8z52h0PVGBUIr2n+
 WMAFEl147KATjpQNvnU3/dD1sApluQblry4iGl/O2O/kHBzKGl6qrjqHfj0gl6FlTBisqqlcwRi
 R8e4hiP9b7DH/lXxSzZc/P+BJS9R+mlvpW+6ZJzv16qb3JR4KCDRQP6d6G7kJRpyk+/IdgMI4Zh
 UCN9hmJsCNowg+A602hf03/VP2afE+R8i9UqRUTXo=
X-Received: by 2002:adf:fd45:0:b0:37c:ccdf:b69b with SMTP id
 ffacd0b85a97d-37d0f720763mr2077785f8f.32.1728059695281; 
 Fri, 04 Oct 2024 09:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELdKljmSPFfr1nvOsl099TKUeQUAnfaZ19buy+s06EKRbkpCvAbcaeiWQ3QXZje9Pf/0FwUQ==
X-Received: by 2002:adf:fd45:0:b0:37c:ccdf:b69b with SMTP id
 ffacd0b85a97d-37d0f720763mr2077763f8f.32.1728059694780; 
 Fri, 04 Oct 2024 09:34:54 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1695e36dsm25679f8f.85.2024.10.04.09.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Fabian Vogt <fvogt@suse.de>
Subject: [PULL 12/23] target/i386: Expose IBPB-BRTYPE and SBPB CPUID bits to
 the guest
Date: Fri,  4 Oct 2024 18:34:04 +0200
Message-ID: <20241004163415.951106-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
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
2.46.1


