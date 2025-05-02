Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EF1C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyFZ-0006EJ-Uu; Fri, 02 May 2025 17:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAyFX-0006DO-LM
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAyFW-00042a-22
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746222529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQDtzIzmoV0HVk+AWYcmKi3lcOstOQ+i6JmBjXMM7wA=;
 b=DBIv3dIDKIizgCOdNg7IpFJgkgJEvW25h2tSbyxBOKrwIBTH8ERm+96QF6sd2boOlHVO9/
 S+jE9jBLrV2V12DY/J+JY3p3dGp0NSC0FJa29tROGUbW76vR1CatfAqasSR02kKHyGy2yR
 AHITN8bXM73p/AB9vD8NtPGQKm0hjKE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-JMF35Hd6PyiAKmGjqC_6KA-1; Fri, 02 May 2025 17:48:48 -0400
X-MC-Unique: JMF35Hd6PyiAKmGjqC_6KA-1
X-Mimecast-MFC-AGG-ID: JMF35Hd6PyiAKmGjqC_6KA_1746222527
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so11245865e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222526; x=1746827326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQDtzIzmoV0HVk+AWYcmKi3lcOstOQ+i6JmBjXMM7wA=;
 b=Y8Jnz3hdfiBslVKezZjj/JR0JkOiBywCaRSCPnfkyscBmXdeNdJNOEv/sKsOItc4tT
 ESiW4b9ju4dihMwwy2vZW4itNYeIcBSdDcszYTmvYhYTCgi7OglAt6Y1Fdt2k2A7faW8
 lZ0M7xv/1nVxOe1rqt1RRubLFsJKGhVdd+jQCDEnl8CkU+Y5GVuDuL97BbyTvTMPtC0S
 jtoyzr2GHhAZnaTznLsOek945m7IlSV6z8+Nbcrh3Vg9Y/Q3vzNUqTOaJrkwbLwHfT2W
 jmVqrab5dqxinVQVnHq+DaQaqHoEyGaGuGFFGVhNqn9h/sicGE0xE+q7lnoFhPEIXH3l
 Su6Q==
X-Gm-Message-State: AOJu0Yyr590M6bOuyhLHKVr5I32mJWmVFEkKT/h6z79BtLEzX9XqmGy8
 j32wjNsvJw1EJ75lAelmVzA/DZ3/9eZp4sVSWdbFNiNjrnx8AXSn9e2aY8cm5BfXtRYpbsz/IUW
 G4C+jr4gYvO14Z7fmZlVEsIhn+YgRYW6zfFim5ImBkP4m2TvnyJwQpslrMJU1+VycpTn98NnyTt
 z9fuJe9zfnkwF77OkWHcf/nF6WNASLXNHydMTv
X-Gm-Gg: ASbGncsqepDdxhgOBdpKiiSZFDIOZC5h+dyHboaDVrmtIamMVfrfQyAxxz+LxaobhLs
 mI6MaebbbGYL0MapxwgpLBEy0n4MX+R3rgZP6T5CVFI4usNBnK05MS7Qzo4Wjn/zE2fyxQF+b0R
 EsGMttIuZKsissvZphPJC1quVxW/eEa0O1g+YFIPWmKj7AbQTWH94rZ244osxmz13Mt05Q++aoE
 +JFPKRFRrDo8UegjpscvRHELUz6FHc1s8jxLquylRpe3/S97bS0iMcQPzwIh5QvyGM0sEd5m2fJ
 UWRZgcQFz1lMmng=
X-Received: by 2002:a05:600c:528f:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-441bbea0e11mr41188025e9.5.1746222526100; 
 Fri, 02 May 2025 14:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHbzYC8n8muNxZMT4HixA9pL6hMLK/HZjFp6P2v1cjwH6caPNCazsMdiXiBVr31HUA3puizg==
X-Received: by 2002:a05:600c:528f:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-441bbea0e11mr41187905e9.5.1746222525660; 
 Fri, 02 May 2025 14:48:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8a285c2sm55645825e9.32.2025.05.02.14.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 14:48:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org
Subject: [PATCH 1/4] target/i386/emulate: fix target_ulong format strings
Date: Fri,  2 May 2025 23:48:38 +0200
Message-ID: <20250502214841.242584-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502214841.242584-1-pbonzini@redhat.com>
References: <20250502214841.242584-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Do not assume that TARGET_FMT_lx is %llx.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_decode.c | 2 +-
 target/i386/emulate/x86_emu.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 7efa2f570ea..88be9479a82 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -26,7 +26,7 @@
 
 static void decode_invalid(CPUX86State *env, struct x86_decode *decode)
 {
-    printf("%llx: failed to decode instruction ", env->eip);
+    printf(TARGET_FMT_lx ": failed to decode instruction ", env->eip);
     for (int i = 0; i < decode->opcode_len; i++) {
         printf("%x ", decode->opcode[i]);
     }
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index 26a4876aac0..7773b51b95e 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -1241,7 +1241,7 @@ static void init_cmd_handler(void)
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     if (!_cmd_handler[ins->cmd].handler) {
-        printf("Unimplemented handler (%llx) for %d (%x %x) \n", env->eip,
+        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x) \n", env->eip,
                 ins->cmd, ins->opcode[0],
                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
         env->eip += ins->len;
-- 
2.49.0


