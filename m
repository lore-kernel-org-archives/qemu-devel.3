Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA798C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKGT-0006kd-UQ; Tue, 06 May 2025 11:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFo-00050z-D7
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKFl-0002Gd-2Q
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQDtzIzmoV0HVk+AWYcmKi3lcOstOQ+i6JmBjXMM7wA=;
 b=WVG1MVCQvxzpomPd46XaqMndtfpsim8/2stRh9l3GTKcxDbLNx0BG3bgrF4ld3fo/q3N74
 uoVws8lEhih4LRoeoAyjqwwsTF3KT5XGAPefNWU4j5p7PjCBvAZyr7nzAI5XvHt5JcywCp
 bik0QDVyIDHNrI59n+fMx5oI5cgnFgA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-U8XgV25QPEGBtp38tYUTpg-1; Tue, 06 May 2025 11:29:54 -0400
X-MC-Unique: U8XgV25QPEGBtp38tYUTpg-1
X-Mimecast-MFC-AGG-ID: U8XgV25QPEGBtp38tYUTpg_1746545393
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fe32b08so2531602f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545393; x=1747150193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQDtzIzmoV0HVk+AWYcmKi3lcOstOQ+i6JmBjXMM7wA=;
 b=FpXT840+oVJmBNW3Xdgx3vyYX0h32540HuJxs2BGEZm1m1xEsJKXQuIQcXD+odztC1
 +FD8a/2WLAMfQEk642VJGR4p8p5c7VIQ055aeKtSiDE793N/lH2ENot74+jWxSROV9A3
 2B8GnGopGkWVLFRKMYk1XdRzbxGIRgRqRnngUKq4ap2vLFqQRY6Ft2zrnnWnW721prNw
 JyoNGoyBAiNUzS+r4YWchNPixA/R5RZIHCNiNKAYqYP9G+DXCR/07P+u5HR7sAgsGjYJ
 j4WyULc2A+LqOhJrUQgFty9w+H80oFWdeNTChGeYmGDJ1soBGFLxGMpvEO9ApORVOezv
 ls0A==
X-Gm-Message-State: AOJu0YzA3nWDNqAJqpIiSrchz3fY3DpNt3/+Dbk+M7+DaLneqxafny6O
 IP1RLUlya81TA7cpnJF3iapVyLQ+dC8XH9uaFY3dOp1OxZeGU6Q8USUsyGAzF9dJXxzHFb5ZLJ8
 h7Zt8qnd1C2OjnTBGgOzBi8fWsOmNN7dEcTtjis7LbaMQ3IWSrqAlb6Pg0IPnNsgiu2edMDLhP0
 upPwI6k7ouGRE2qJ6KzXmJjV0KNOTgLRcRq2WI
X-Gm-Gg: ASbGnctL8iUon9FiMYKNVbPkyx494l9KIGblpFbF0w3US0dVgDtOb/xzxNOos0N8T8l
 S8NNdQ3SfbkRId4SqIZnK1ShHw1g92ppVrYuls8Qap3cGNefCaODdYiANdVOsgHAx58owsf0MVq
 XhVBm3zvcTvaVCecGpgTlrmZrd7zqDczQkynEw+T0ysUbzvDnJLaUGEOBbOXrhAMHFMnJ+SHWUU
 Irzztc3B5HpBTMYNTvfPJLjG9FIzb4/uE+TKrRJJQgSuuwVT41TGO8TQ71nh6pJM+3tn70yHMmx
 6UThLeXgfwGsywM=
X-Received: by 2002:a05:6000:3111:b0:39f:28de:468 with SMTP id
 ffacd0b85a97d-3a0ac0ec337mr2875104f8f.28.1746545393204; 
 Tue, 06 May 2025 08:29:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlefWrYqRW8bfaeB0bbklCCpIvTWlTckKIyqJeByvCnnxmYVqHyNBcN8USyknxN5IZo7uYXQ==
X-Received: by 2002:a05:6000:3111:b0:39f:28de:468 with SMTP id
 ffacd0b85a97d-3a0ac0ec337mr2875093f8f.28.1746545392872; 
 Tue, 06 May 2025 08:29:52 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b17022sm13904205f8f.89.2025.05.06.08.29.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/30] target/i386/emulate: fix target_ulong format strings
Date: Tue,  6 May 2025 17:29:07 +0200
Message-ID: <20250506152927.222671-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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


