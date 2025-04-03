Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0A9C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 19:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0QXl-0003bb-QD; Thu, 03 Apr 2025 15:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0QXj-0003b2-MW
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u0QXf-0006SV-A2
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743709677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4LCsZ1mXliCVBRZYUfxianCN9JZAyKthrFvmlHQQOT0=;
 b=N2UKe5DlH3JoOIKLZIkVfVMU/LTqlwIWYIRe689OuGyL4IZUxeI1z+wftnIdIsDb1OSQe2
 BmfPR3R8rI2MaXf3rjz41jKesvl7MSjgdiOI/8PM8A+7ou6B9xVhNCyR0Z4V5z8leJWEt3
 y+X+pLPEDggmNHGXJ5F8RKGOi1cur00=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-trV0LGPAN9OJomzKUwdBiw-1; Thu, 03 Apr 2025 15:47:56 -0400
X-MC-Unique: trV0LGPAN9OJomzKUwdBiw-1
X-Mimecast-MFC-AGG-ID: trV0LGPAN9OJomzKUwdBiw_1743709675
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac710ace217so100080266b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 12:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743709674; x=1744314474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4LCsZ1mXliCVBRZYUfxianCN9JZAyKthrFvmlHQQOT0=;
 b=Li4bcWyD6E29utnbzrvMKvleRZDeafSkt949Kvf4xACUSthAuXN8+SAdeoYkROMKii
 2VO8PSIeSGPdWX7LavgKaKyfMmsHXnDqEuAC24hXms+xz+NidArODLVPn5a9NbySveHs
 wFwBPzTYu9BkC1ywmaZZ6Hldjx92kF+EDEZZ8WaExiC1D0LsqNHoYu+mqQUGQg5/5wYm
 TpSAe+6nGBPVhqyht9Deb2V8N15xiuJEFNxPM+ynlOeQNjn9ldMXN+saEaswaVUAqklK
 vGCzymn8CBK22nvl+3ek6WdZs5QZReH89q+kmqmm/m2dyS+1t4HDJBr79qwWmgcOR1Xf
 K09A==
X-Gm-Message-State: AOJu0YxB2xkYvyK8gmO33D5+Cqf7BAZX8vuB/6kCaZGLOjYk98UJHNiV
 dWvRUcoORnIs+tsVRZ2vqjIH766+hiqvyZZVSkihnTgLk7JcLEJlD4BQZZeXHaskVdtkJrmtOCT
 EFvn/ft7R+ZXOZ0NeH0g92XY68F3GLmkbM9xMGWAOSL8qZii1/w8hUAFsynM5JTKCEHJRIg0SQb
 f384x5uHqZxD/2IYC268gZsQN1jRwfwnoUaDcT
X-Gm-Gg: ASbGnct5hdzABk0YbM7vxk2sooIuLWwf5W0Jtu0sOXA9Ja9CUq94lDg9XufMEK3f/bO
 uyYEdSfPKB00rSoUslj4LB01YTkEx94nhMhJnYYrOEDsAX8oCONJ/M6+5guG7Arpm9YCyFEEtKP
 nclMDdoDREtldBI1TwQ6UgCG2a6ncn4qAqroGzdayukblENIJ/83rBiso28g1bmxs7BhuWsl10x
 Er+9RXLiGjhbMw0uI6Sbgd6W3bZ6fyJ/dGYg1evArqBNrq96DIrOzPp8j87++1YoShSHHoUYHts
 F+tBMqBX/i41sJoQMqqU
X-Received: by 2002:a17:907:6d0a:b0:ac7:1c1a:d0f6 with SMTP id
 a640c23a62f3a-ac7d1a7dd9cmr74042066b.37.1743709674574; 
 Thu, 03 Apr 2025 12:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJWwmuv6ASPW4m5HivWKuS5ZRT5dsWPADz5fd4MKFZofWr6y30qgN4nUHF/tuMHU3Dm5b6NQ==
X-Received: by 2002:a17:907:6d0a:b0:ac7:1c1a:d0f6 with SMTP id
 a640c23a62f3a-ac7d1a7dd9cmr74039866b.37.1743709674161; 
 Thu, 03 Apr 2025 12:47:54 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.230.224])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe5c45asm138415866b.1.2025.04.03.12.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 12:47:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>,
	qemu-stable@nongnu.org
Subject: [PATCH] target/i386: hvf: fix lflags_to_rflags
Date: Thu,  3 Apr 2025 21:47:52 +0200
Message-ID: <20250403194752.103264-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
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

Clear the flags before adding in the ones computed from lflags.

Cc: Wei Liu <liuwe@linux.microsoft.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_flags.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 32772c359e9..31d76c067bf 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -284,6 +284,7 @@ void set_SF(CPUX86State *env, bool val)
 
 void lflags_to_rflags(CPUX86State *env)
 {
+    env->eflags &= ~(CC_C|CC_P|CC_A|CC_P|CC_Z|CC_S|CC_O);
     env->eflags |= get_CF(env) ? CC_C : 0;
     env->eflags |= get_PF(env) ? CC_P : 0;
     env->eflags |= get_AF(env) ? CC_A : 0;
-- 
2.49.0


