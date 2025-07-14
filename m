Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46075C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHUs-00077m-Ne; Mon, 14 Jul 2025 07:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1h-00025k-AS
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH1e-0002FD-SK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pn1f+8iSLRhTUyqVf1Bje+hqAFutT6rdOPYDnkNfnJg=;
 b=AGs5WPvheWiGMm4fQdgzinrGJCmBjtQvrdGiXjDIomj32FosJfl9tV/hmpOEieaW842r/n
 Wtn+/NA5qv8rVRYYhfID/1ByPBoN2dGC0BiViD9tXxL7jqAKH5cblYCFlee+IpXotCEYne
 Y+JxIGhPDq0+O75QaWkcAHqIDAIIYNY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-7LN-6krQN7-GXNe_-iQ21w-1; Mon, 14 Jul 2025 07:07:11 -0400
X-MC-Unique: 7LN-6krQN7-GXNe_-iQ21w-1
X-Mimecast-MFC-AGG-ID: 7LN-6krQN7-GXNe_-iQ21w_1752491230
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so2276309f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491230; x=1753096030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pn1f+8iSLRhTUyqVf1Bje+hqAFutT6rdOPYDnkNfnJg=;
 b=s1tja+9AgqFeADgpfH5dTvBQc4sQ8Ru9LRfhz1sVrZrzXRO4m8s/JG+6bqgiil4xUC
 6VZGsitTmxA4ssQXBvSHz+cm5TVDB2IwvTeibNf2EMGSVOFtsU2hB/frTEpBTgYk+wFT
 VTrenMHLNVRoU/vWTiDdgZ90aPUaMe6FcxoipQK7K4SsAM1kfMCgwF0saogjNYdM5eUw
 mJv2C3kSF55u6watO4kpatcvk5i4+dbk5HbGcXgz5mRBysc3s19y9YUZ9Y6HOrDY7Kqa
 Xjz1U0OdBYlV3O1TJRKFXo6lwKR4YdVQPcEE76m1cJ+OP9BOuaAYbYIbMQKyLfGtaajM
 NEXg==
X-Gm-Message-State: AOJu0YyMKroPimnb9m2MfFIFaa0OHeSU3BNhMFNg05cII4BHtUn1sW8q
 HxATncz+KQh7LlFWhogsLhXHkm+ZVTZzqxr3EttCemsifClG6ew3WReffz8C5z6gxzYI7x7kQVd
 suzNxEJtNoRxxVWNZKmK1C0bEfM4CID2nOU/q/U4pkiZSNCw7JEsSopsCc0/M8GnqHTuG+fTpqn
 io8vLLIHPKjyHYGOji6nblLfWNBznPlM85JuNK5XLZ
X-Gm-Gg: ASbGncv0oeZ1pg7tjp6Lx5D4+zGBUbRjc3v17VhlKtjL/cniNw28477Ye2KJPCm/1oc
 aZNxseufPqEiYwfSYHJpEzCBtHazJXBR3t1VMzrymaXAfa6opt3ZcV2/5wTG+RHmWEoqK7KA/0J
 ODfzYpQpmVup69vNRJGK2E/gTy5wyzTE4RlpA7mUgDuon5K8lWYuFS3J2bbupKUwzwdsAJq/1SJ
 GVYEswvztsrf8Doc30izAaab90BsMvTN1fBEDcZPyu+DU5C3cp+OeQdlZD6xGy09w5MiyYtHlu/
 VpW2FHLIMBWm3hZ5l7jA4VehzQ6/ossmgwjf2+1o4MY=
X-Received: by 2002:a05:6000:40dd:b0:3a0:b940:d479 with SMTP id
 ffacd0b85a97d-3b5f18f8066mr11785466f8f.53.1752491229717; 
 Mon, 14 Jul 2025 04:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9mBfPYxyWyRPaNNjLGf1KGTal4rWuWE4mZVIi1Y3vkGj8rznA6wAb0jCIUF1DzBY+BSYMew==
X-Received: by 2002:a05:6000:40dd:b0:3a0:b940:d479 with SMTP id
 ffacd0b85a97d-3b5f18f8066mr11785430f8f.53.1752491229251; 
 Mon, 14 Jul 2025 04:07:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e262c6sm11924008f8f.85.2025.07.14.04.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:07:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Tao Su <tao1.su@linux.intel.com>,
 Yi Lai <yi1.lai@intel.com>
Subject: [PULL 70/77] i386/cpu: Mark CPUID 0x80000008 ECX bits[0:7] & [12:15]
 as reserved for Intel/Zhaoxin
Date: Mon, 14 Jul 2025 13:03:59 +0200
Message-ID: <20250714110406.117772-71-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Zhao Liu <zhao1.liu@intel.com>

Per SDM,

80000008H EAX Linear/Physical Address size.
              Bits 07-00: #Physical Address Bits*.
              Bits 15-08: #Linear Address Bits.
              Bits 31-16: Reserved = 0.
          EBX Bits 08-00: Reserved = 0.
              Bit 09: WBNOINVD is available if 1.
              Bits 31-10: Reserved = 0.
          ECX Reserved = 0.
          EDX Reserved = 0.

ECX/EDX in CPUID 0x80000008 leaf are reserved.

Currently, in QEMU, only ECX bits[0:7] and ECX bits[12:15] are encoded,
and both are emulated in QEMU.

Considering that Intel and Zhaoxin are already using the 0x1f leaf to
describe CPU topology, which includes similar information, Intel and
Zhaoxin will not implement ECX bits[0:7] and bits[12:15] of 0x80000008.

Therefore, mark these two fields as reserved and clear them for Intel
and Zhaoxin guests.

Reviewed-by: Tao Su <tao1.su@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250714080859.1960104-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 533c9d9abc7..1a2cae6ea1f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8393,6 +8393,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              *eax |= (cpu->guest_phys_bits << 16);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
+
+        /*
+         * Don't emulate Bits [7:0] & Bits [15:12] for Intel/Zhaoxin, since
+         * they're using 0x1f leaf.
+         */
+        if (cpu->vendor_cpuid_only_v2 &&
+            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            *ecx = *edx = 0;
+            break;
+        }
+
         if (threads_per_pkg > 1) {
             /*
              * Bits 15:12 is "The number of bits in the initial
-- 
2.50.0


