Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2088FC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFEL-0007fH-JJ; Tue, 21 Jan 2025 09:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCF-0002Qf-Mq
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:44 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFCA-0003Zt-7M
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:25:38 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso41095965e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469528; x=1738074328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLtjxkwdz6L1VGr45Id+Wfm3w9Chh81Y/cb2LCx94qE=;
 b=G9NCpxCkXb7KaCQ/IPs055hnOPgDAQKTXS147FrPUPJZEDwuRmWsw8dZeYFL50hhMn
 uTRR7cjbmR+Y1utadxek5uxcLgET2vjG1QD0O2W9Ec6Kf9b5Qp+z5cx4TD/iVfR/9LSm
 YzZZl4VwHz0qbxf9LWxeFTf/e/dbldDcELLxe96rQjBHsOPIiLgh2TpHf9iUW9YKq6sW
 nINPuW0qgw1vn0/JvsLmE5e5eWmV4IOlUoeNEc4m8JGGkkaiVvxicX1Me63LwDaMEk0H
 y4yo75TRVnBlDhz0+ewA1Rk6Zy6VF8nzDU7cIFu2doGHKjMrxsgvgygvLM+RPAlj/GDu
 4L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469528; x=1738074328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLtjxkwdz6L1VGr45Id+Wfm3w9Chh81Y/cb2LCx94qE=;
 b=eVZ7cPpbfzAxApEGJT1fiuXicNRvEgwoGf40QtjAL5k6FQlQhY3xU75ruNSJK72Pdl
 iuJwV7SCDji9V3chCdyvDrvi2VM1jp1S6WaCBqxe3r0VJYfe8DsfPRtCcFohFjswH5WU
 l7c9ixPqLppDBhN6O7Jms/0dZ/HbnAAFRDzF8XqpjZ0AdsKVwCWc/chYMl4EY6NHmKxH
 FaXttBZAqc4mu2871C0n8Ff46kSX9B/hADpk1ob7Q9PFnANz8AHGUVOgkHS678VMrhBs
 jx1XYMvfmPtU2Y6IKxaaLlrHzBCeisbeLWYh2D3dfZFka96l04t7tYxMR5KUkGkbHCeP
 u40w==
X-Gm-Message-State: AOJu0Yw/273QdrkQrXjGsoVc6Z+cPtWnb21K379Nthlru8NlXehxNf1Y
 0WbOIk0MFaD/708KXxD6EVDgiG9YMHxymkOf+/sKidzq372rUoaRqpAH93K4o8iKmuQTJ/uJLo8
 qDf0=
X-Gm-Gg: ASbGncvWXSizqbGCrJF7kQEAWXJxb2+IDlRmiep3At5LNMgtOBJiJ9Zu2v8yxYDiT/k
 lOes9iudRwp7jMDSJbFUS+FjHIRGfcZEZY8KNUa5WxjV5xMOikros5VS4f558rcKmjhnUn48WOy
 Uzi+gpOAx4yPL+ilY83zTt2PsmLaqcHOAW53bNR3AxtoqjWva6N65A4xwBk2OX31cyGYtaefbfN
 THl6OtGGuY4JCGhnqGDLmGLUfLvD555TVDX0+wv5bqrmGlLr72mIueRnclG6kg8U9vCk7OSCyvV
 MCBQl04l8WXqIhkT3fakhxrDBPqBlHXdl5ZCJwqedpOH
X-Google-Smtp-Source: AGHT+IFl/O4MKtba9v34wpsx1JISKH5fHpqun99JFLA44cDthFrGsVsrvg7dwbDEcTwqpfpZD1Dg9A==
X-Received: by 2002:a05:600c:4e08:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438912d5426mr194266845e9.0.1737469528605; 
 Tue, 21 Jan 2025 06:25:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890420412sm184694965e9.18.2025.01.21.06.25.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:25:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 22/28] target/s390x: Restrict I/O handler installers to system
 emulation
Date: Tue, 21 Jan 2025 15:23:35 +0100
Message-ID: <20250121142341.17001-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a750e7a343a..6e2c98de97a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -356,6 +356,7 @@ void cpu_inject_stop(S390CPU *cpu);
 
 
 /* ioinst.c */
+#ifndef CONFIG_USER_ONLY
 void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
@@ -373,6 +374,7 @@ void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
 void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
 void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1, uintptr_t ra);
+#endif /* CONFIG_USER_ONLY */
 
 
 /* mem_helper.c */
-- 
2.47.1


