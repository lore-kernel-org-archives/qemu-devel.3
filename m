Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A81C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxb6-0001ve-3W; Fri, 28 Feb 2025 05:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxb4-0001uf-66
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxb1-0002t8-Lz
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhlg3Q2K5K1bxY7tWZCMVwyEFzobAiP5V5WDYQnmQdM=;
 b=RjTSmwvQidiiAM+ZtnhYWahP2xs2O4Sk/UqtgKu/qmC2uRBSKrJFjR5b+BC/7qJZJ2YnJm
 fEBnjSIgIDuHY3eSQ0GO+gsvjLRNzAUqWxRDHNEI6Kw7C1THeof7qvpx6kqfnNrSUywNwN
 tsb1sFMUVIS5d3bupv3oRoN/9KZ12Ww=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-rR33-xDVNpCiJp9sA1WJaQ-1; Fri, 28 Feb 2025 05:27:52 -0500
X-MC-Unique: rR33-xDVNpCiJp9sA1WJaQ-1
X-Mimecast-MFC-AGG-ID: rR33-xDVNpCiJp9sA1WJaQ_1740738472
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394b8bd4e1so10368455e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738471; x=1741343271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhlg3Q2K5K1bxY7tWZCMVwyEFzobAiP5V5WDYQnmQdM=;
 b=wZXPHc+mIbj911wdiSlTHeV5iQgINC0F/hJfoZUWK2o4mZGvEAjwU12lyK7ZYY2GuA
 DbYTklVH4aRXmkdnIOc/03PoofpSkNRYbnJXnbZgIZ8OGyj5A3aRpwefOdpoSlDAsWmX
 whIyeANtd+v5ixhzos7ZDWhV5ClvQbn1a6axQ5bibbMeL2z4ZQwnxwbjRRAILY6rXzGS
 8OLivrCLzSrdf56tMExc8L9tu0IQvWLL9CamPihPeJ0VzchbjFY8ECUaPmEyLAlvUbX2
 IQZzpw3ZEXZuUjCzng1+LWp8VBEPbz6DgorMkAEZ6PAWK4qLL5fsM0unKOTUksA38eyq
 b9ZQ==
X-Gm-Message-State: AOJu0Yw6BUW2XVQLnCmxrjW50xzVA1vTfQ5tjVXqmvz8W/m/ATYEsEC+
 9RPPnCUUHHfth6bOWEVOsNC/0wWg8gotTzSEBGmw5qpsytWW7z88VjePG/12ujQaax+Qac24iJZ
 ePxM9Y/NR2wHsjUGB0XjOqkZHIr6Bcqm2rl7lJ50YVYwR77rMkvvRZo3b/yvjmLIxzc5yzbjmxY
 Heb3a5/Y1FcC3+5aKJr+Oe5GJs0pWvjQw/k2xYlms=
X-Gm-Gg: ASbGncsBTE7b4qel/NN+u2mCNEE4r9ynm69FrwxvV9JF2O4uD6Vl4VoXA1UBXL7WPOP
 BbzgfLHut4HLHai2Z0R6v5I6vcLJXqXYB2JR0sBPTQtl8Q+2H5WzxcD/VIVDq/9tBAcoCV6K+xk
 0CLLFcUPFmweP5DxZpmv6SZGiDdvwB6mWfAL4+nZnOesbOQA0Qt90gTC/XTm8JvKqri16gpWGbu
 lVF3PUDDaaUJdN+wNpbhxF2iqrIbHwyN7Se6qm842RuF39QOTUiC0SCiyFDR4LGQdDRqr4S8OzE
 2S8JdBNveuwdGTKkPSeF
X-Received: by 2002:a05:600c:3ca8:b0:439:94ef:3766 with SMTP id
 5b1f17b1804b1-43ba67606b8mr20533795e9.19.1740738470878; 
 Fri, 28 Feb 2025 02:27:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8RRi0LeyURnPBwwY9mz1cD4hmSVp2C2oPuJY7WgjtMeOU8skuMoYPEqBmwhY6M1WvgyFDyQ==
X-Received: by 2002:a05:600c:3ca8:b0:439:94ef:3766 with SMTP id
 5b1f17b1804b1-43ba67606b8mr20533515e9.19.1740738470453; 
 Fri, 28 Feb 2025 02:27:50 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a7850sm4839466f8f.39.2025.02.28.02.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:27:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 01/22] target/riscv: Declare RISCVCPUClass::misa_mxl_max as
 RISCVMXL
Date: Fri, 28 Feb 2025 11:27:25 +0100
Message-ID: <20250228102747.867770-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20250212213249.45574-7-philmd@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h | 2 +-
 target/riscv/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index df7a05e7d15..3041a4be5c9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -543,7 +543,7 @@ struct RISCVCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    uint32_t misa_mxl_max;  /* max mxl for this cpu */
+    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
 };
 
 static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 244e44ce410..85dc2fe3bec 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2961,7 +2961,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
 
-    mcc->misa_mxl_max = (uint32_t)(uintptr_t)data;
+    mcc->misa_mxl_max = (RISCVMXL)(uintptr_t)data;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
-- 
2.48.1


