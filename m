Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD95CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEam-0001Kk-FJ; Tue, 09 Apr 2024 12:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEaB-0000eS-7K
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZz-000866-PS
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2+pS5gGAJTQx3c6Aio5nN6ovM54dMMDDl89YZXL1qo=;
 b=J+WbW9Q90WhRXJaFPYAKhcUM6BOn5Fp7MNXDsZFcrBIRphAi2A5J9cE0LspfdTZ/+GUX57
 +BXatZZF7UbTPlWQ7RtpVL2OA6T8ErEsjz99f38LYcuAL24q0ho+D9TGQxlP4PJSOahakL
 FAc3UyFy3zelLDqNOqe1efIMwWPajj4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-rscPBydFM0KV37bJbhXq4g-1; Tue, 09 Apr 2024 12:44:01 -0400
X-MC-Unique: rscPBydFM0KV37bJbhXq4g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-416b3409164so2866115e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681040; x=1713285840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2+pS5gGAJTQx3c6Aio5nN6ovM54dMMDDl89YZXL1qo=;
 b=Iz3SIClMXGX17aDo8NFG0UTHlokfzqHKVpwCku3KbrShTV+c8E8bN08EaMf/6wYsK6
 blQ4hWqpK+TeuHDM59sKv+BH2ncOBUZPmdinQWlCoXT6ww1i8oIJvO8tibbe64D38V6w
 PXLPKNnQApB37UVfXcEKGZPUkVQpTXDJoDPX8Tp1lwYkKJAhwDgwvyTEhnWFA54qzAi3
 D1o9JOYMZZaSrI4pRvwodD3DeMHXnHUOZEgHatbl9Tmg1hVHgeVNCWp0dE4pPHdmE336
 T5jmtvu4KLurA+YdVFioziJm1lObkvMIdWfu8yR9BG8MFIJhR24+jLJWF4PFzSuh7k1o
 wU2w==
X-Gm-Message-State: AOJu0YxF613MOCmgLmxKAIrq2Zts0HXzLyIe2h7Hy+OKs1yr9X6joLny
 mragcDTUY7+oCPMrIQOgQdwQEc20C6cSm/Jj1jpRxVDH6MWxchpu0rxUFFE4kh2FrOQ895WKU3p
 Ds5e6l8gDI/qR+BUUR9mwbZGneIsYLa6xqOIKejh5t+6RokAIexL46CHkkNGvPHz4OWJu/tLfbt
 0eAi8KcTVonVY/oFA7rt1EVm1Pm98zkp2ZUUJ8
X-Received: by 2002:a05:600c:4f94:b0:416:9836:c33a with SMTP id
 n20-20020a05600c4f9400b004169836c33amr181474wmq.29.1712681040210; 
 Tue, 09 Apr 2024 09:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXeNgaMig3JtXnmDOkU7DLtwG5/kMlXyMtyekxLNZ6BCAub5tZqwKT7wt5zqSKqUwCH/AvIg==
X-Received: by 2002:a05:600c:4f94:b0:416:9836:c33a with SMTP id
 n20-20020a05600c4f9400b004169836c33amr181465wmq.29.1712681039945; 
 Tue, 09 Apr 2024 09:43:59 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 jg1-20020a05600ca00100b00414688af147sm21015170wmb.20.2024.04.09.09.43.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 12/19] target/i386: merge and enlarge a few ranges for
 call to disas_insn_new
Date: Tue,  9 Apr 2024 18:43:16 +0200
Message-ID: <20240409164323.776660-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409164323.776660-1-pbonzini@redhat.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Since new opcodes are not going to be added in translate.c, round the
case labels that call to disas_insn_new(), including whole sets of
eight opcodes when possible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 720668e023a..26e4c7520db 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -6866,9 +6866,8 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
     case 0x10e ... 0x117:
     case 0x128 ... 0x12f:
-    case 0x138 ... 0x13a:
-    case 0x150 ... 0x179:
-    case 0x17c ... 0x17f:
+    case 0x138 ... 0x13f:
+    case 0x150 ... 0x17f:
     case 0x1c2:
     case 0x1c4 ... 0x1c6:
     case 0x1d0 ... 0x1fe:
-- 
2.44.0


