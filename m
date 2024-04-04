Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FFDCD1288
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsT4M-0006Wt-TO; Thu, 04 Apr 2024 15:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4H-0006WV-QW
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4D-0000I6-QT
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3437f70078bso999664f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712260087; x=1712864887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FucEMxPV3laNKRFI1lQP1t/ZPj6SOkzkcUkgKiBhmrA=;
 b=Jdjv+cp0cGc0iTOvaPnxnhR+8KhnjhT4L/JV1fhTNz7ek/QQg7fx5gVNPer6FLcRKS
 6lBj3tF79fgymcHRjF+iVmEihQwyEi51Yurmmu913cqoI9gi2naKsaBC73qAcmnNAU7H
 N1V9PlCaPqdqpfNJgh1Qdge0R8qP62IvNnuPOqFIYEn2ZREMTVh6zoM4lPOh4JtBzOjD
 JGviGZUZ2lKJPNx2giJW9s+bEwz15nBgfX76sFOpSzTj200hbUwGHkRfqTRu8jf6Iove
 v4DhoRQllkpchfzEY+L0hd4H/+Ru9wICJMhJUoIICOroim6njWd203Umq9D4aiN4xgON
 3x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712260087; x=1712864887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FucEMxPV3laNKRFI1lQP1t/ZPj6SOkzkcUkgKiBhmrA=;
 b=OkaVgq18x59bhEYdLPh+/x/ubmVluL5zkDgZqeBvgxhHV2xTeOIhsPVxnGJR/rpweN
 UfGW3JWGYcRZGeHYY1bic9pCpTNqewHG2nL8DEU/2P5hMs+jAYSvILgFItf543DYCK6S
 /RMcwbWOwUhTdqVQXgRnG/616SMKjieui488Sa4T8DEZm/I5CWQo3MGjhvDrM13P+BkK
 g4oPVxacCyxO7HBHeCc6FIlIwsnEL7H6ZJ8bbQ9btgwd7z3qW3Kjfh9pXYoQGakJ6/SH
 zdZgYPDxLUQ+ChzalLcYErXjKLnkOrsC6MP3wH20WB6ady7iWxeMUh+RrKkugLsOsh3R
 sddw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKrk6CfFxdScrOnQaXzm0GqltEa2Cl15phC1RyiumG/9mnLiI57dJt1qgsvb1Tc3YsC+W2BXcFVrDksv3473bXTBuuhKs=
X-Gm-Message-State: AOJu0YyB6P/r1wRWqk/Sv2w+Obn+Y2HXEdLZOl51DEj5WKqi3mmAcggJ
 qbEgJAdaRdbc1Z5QFTMHSHfiE5+lE2vYwu+1wbz3g8Dnaagl8Tu2lfPW7XuHQqU=
X-Google-Smtp-Source: AGHT+IHelurwZcRoNT93+kyXlOYarqOMuHymrO/28BJtMAGQ1IDHy7bJZL8Fs+ufvbap6cK1vAiiVA==
X-Received: by 2002:adf:cd91:0:b0:343:9884:2fe1 with SMTP id
 q17-20020adfcd91000000b0034398842fe1mr2595576wrj.68.1712260087322; 
 Thu, 04 Apr 2024 12:48:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 d11-20020adff84b000000b0033e7a102cfesm158078wrq.64.2024.04.04.12.48.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:48:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: [PATCH-for-9.1 1/7] ebpf: Restrict to system emulation
Date: Thu,  4 Apr 2024 21:47:51 +0200
Message-ID: <20240404194757.9343-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404194757.9343-1-philmd@linaro.org>
References: <20240404194757.9343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

eBPF is not used in user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ebpf/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ebpf/meson.build b/ebpf/meson.build
index c5bf9295a2..bff6156f51 100644
--- a/ebpf/meson.build
+++ b/ebpf/meson.build
@@ -1 +1 @@
-common_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
+system_ss.add(when: libbpf, if_true: files('ebpf.c', 'ebpf_rss.c'), if_false: files('ebpf_rss-stub.c'))
-- 
2.41.0


