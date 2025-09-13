Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F030CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLKb-0005eM-EF; Sat, 13 Sep 2025 04:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKY-0005dl-Tk
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKX-0004aS-9s
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757750996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W3FQSNcvluKEhgLR2MUjySlRLq+bsJkp7JvA9EI2Wgo=;
 b=eE62OVQM8Yo3CBY4+2WX00BJdOh339jury3TBQFALfX0RZPsq8wlSVJlz+8QDLUFxtsV2X
 f0CXrE9k2LDtkLBnEn8q6DUuo5g2yzaisyKF0ql0AncSpCD2iwpg7H5cNNK5gwJgHYs2NZ
 PEyjkVL3vgwOK6HjhuD/LZgPOTZb+Uk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-aDbVHittOVu2GW_oBFtIYQ-1; Sat, 13 Sep 2025 04:09:54 -0400
X-MC-Unique: aDbVHittOVu2GW_oBFtIYQ-1
X-Mimecast-MFC-AGG-ID: aDbVHittOVu2GW_oBFtIYQ_1757750993
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e61deaf253so1679723f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757750992; x=1758355792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3FQSNcvluKEhgLR2MUjySlRLq+bsJkp7JvA9EI2Wgo=;
 b=EInxRhdvQfDyDQxBw0FOtfzH2bThByPDB15neZLoV06WxAqkdsbQjTd6602ROpYQjX
 ZI9MtGRC1T4dz59Cqfd+LHx6LXKhO8rptfJHwOzUx4NOEk7D2BXCtQWzJ5NU7Bm+gPgi
 tJwnLCd9PAEpn8pe/vtSJtXa+mwRRMYte2yKM0A6Voof1vUZo56nzjqkEJ407MrxEAnx
 FIHPdIOzcWZ3DHMgNDHPqACoKwJyi5FyqBlDJ/h/AYZ5SaUog+RN5qZebLZ4QywJe9/V
 QnGgflnlGjxlIYlbR9ZZS2ENvUJTUuDmDwkCdm26RF8l4VBbx1hTLPD155mcoJxFFOTE
 iwdw==
X-Gm-Message-State: AOJu0YzQLbdK9mhcIpkCaDGgBV4DBPVcB7XuEJcILBIGjJme15nzOZOM
 YxQV24PhLN6uIGgYWmhcijjOsaKYcLAgMm7gzQUA/o6koxC521CpcqGyhLaTUGf6lOOr8Ziw5FP
 1YxFxKLSgJZ/c/d3eYZTafu6swxZ21NeiU9LSD17l8uNvFhTfQeShBxbufn7ZREzkP/D2aIcQrx
 0jAZeQx9Vqj2Khc1lI/DUsmOT2TjWy/SHbEWUfmPC0
X-Gm-Gg: ASbGncspYotinz+aM24+UUGJ2ZKFAU49NMFiBHoGQH2otX4TKTTCSVfPulUEJjlZXZj
 GUyxcm5HrqecyJ4TO0Uu2L0Rg2HLigvotj3kkgPr97yfgzXaOoY7LDbgXfgaKOP6JSKEpy3C4Q4
 TSgu8SJDTamZ9qdxT+bPPOgFJiAte9H5WWLxSt3ZeWioF1SVnX+LrQNOUBxkjXDQEaNs1Jtd2+g
 FH6q4p4m+PG+eUYEGtCje6In9NEwdJz+2enWZW+0bFuIW4uXFSB7mr68YIc9R5GS7TmGVUCPVi7
 MrlJBRYFnEZcQEYNTidrm9KmOx0lC/k6U9zD+HAULpdKgcFBE3mkwwkHzv1WBnrMTPww7oI6Xj/
 JuTNZbDsBFe6JZPsG36KDwY8Uo07u2TwTM7HzQYpC2OA=
X-Received: by 2002:a05:6000:2dc9:b0:3e7:63b0:bf3a with SMTP id
 ffacd0b85a97d-3e7659c4bd5mr5226726f8f.22.1757750992518; 
 Sat, 13 Sep 2025 01:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOrMsYxce00FWS810mn+9CrTDxSmqK2caK+bFHq1pDk2ZjdcVfKQ05qesbvFHUn/5rMaZvkw==
X-Received: by 2002:a05:6000:2dc9:b0:3e7:63b0:bf3a with SMTP id
 ffacd0b85a97d-3e7659c4bd5mr5226693f8f.22.1757750992048; 
 Sat, 13 Sep 2025 01:09:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0187f0a7sm51624775e9.3.2025.09.13.01.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:09:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/61] target/i386: limit a20 to system emulation
Date: Sat, 13 Sep 2025 10:08:44 +0200
Message-ID: <20250913080943.11710-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is not used by user-mode emulation and is the only caller of
cpu_interrupt() in qemu-i386 and qemu-x86_64.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index e0aaed3c4c4..651041ccfa6 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -110,6 +110,7 @@ int cpu_x86_support_mca_broadcast(CPUX86State *env)
 /* x86 mmu */
 /* XXX: add PGE support */
 
+#ifndef CONFIG_USER_ONLY
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
 {
     CPUX86State *env = &cpu->env;
@@ -129,6 +130,7 @@ void x86_cpu_set_a20(X86CPU *cpu, int a20_state)
         env->a20_mask = ~(1 << 20) | (a20_state << 20);
     }
 }
+#endif
 
 void cpu_x86_update_cr0(CPUX86State *env, uint32_t new_cr0)
 {
-- 
2.51.0


