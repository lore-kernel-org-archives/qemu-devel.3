Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F77CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShHy-00011h-TP; Thu, 28 May 2026 16:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHv-0000hM-8I
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShHt-00053x-3v
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso88164305e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999903; x=1780604703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jP0GXCop7gYtXivLYHpmpxGFlnJFR2jOenxER/HGLCs=;
 b=KL1z4rEaUJnw7p/jtj+eJ0Yl2poQsB3yPTE8XfK4KAByVkscQxJQftsbw0fABRz0Hs
 arV/IjhQO0AJY0ZYf8e4TJKNEmMB6JUIogzmL5Kbv7+Gbh+RHaZHqeY/3PfJVV0AM7aE
 aDxS1U4GfaEsjgUhr1NSraN3kZ9br7wqQIauHoaStAD2Kz9KMYZ9zY1TSpc64fxE2rsJ
 O0Lk33NCshEGuDcszuvj1P+WM8CQcq0ZAOsmRpQWwkF6K6z2K4j8GdZcNH/+Q7H8tuHp
 DXhzKFa7C2oPdGOfC+phycMvpsfKXiR79YCImSQa54zEN9nFjG0vDW7rlM8T9B5vVSLp
 CHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999903; x=1780604703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jP0GXCop7gYtXivLYHpmpxGFlnJFR2jOenxER/HGLCs=;
 b=HqtPvBCpb5S1oMZit1OZdbkndvb4UW2Y2IAmyJixVhS03NED+sV0Xv6nohWEW6rQSY
 keceb7ucx464vDIaBmKEHGUisDx0cu/GqZamnJLtYSfYbMb8waPWDSXhDKb8MibpJZmg
 pPjFsDc2AnBk8kh5Wx7ikRhQ26IbpcjmChay014n8/H//p1p4Y9tPZJZOytH3cjqyWz7
 CIBo2bldfAtOCswBW22yiW6JNFM22E/Vj0LUhBFDDKB8gOj5rLD+ovvD6u9WpHfaTRS0
 yTQqs2BV4ViFJ44qoMCX4j0szs4hv9GULY5reAWG/MZ3/5CM8F5IFGsDuxAoBUf3XU8P
 VLJg==
X-Gm-Message-State: AOJu0Yxq8qcmHH1nYj6aFvlvPC3zXcLQWDoFNbsjn1T2MG+AP+///G6k
 JB1s61fPcOYGCrauJ+FxkCWEGdvTasUmNjuzR5HsvZ+veHBikQTGayIDOpUGncoZl5FjDaDH+T3
 2Ywr5hX4JHA==
X-Gm-Gg: Acq92OHfWdwWS5ZDWBGAscbf2+CfyWXKtvekZeqnTi/1CrPSl/lPJmvrXNnpz6t3C1N
 /m9w8mrLmPf0k+G8C3gtI0pWESYqL5P9SJWYm61jt8dYmOn9t3jP/v96SZoztIq78bQXqjSPv7h
 DPlIipu7N9yf7HTLGEUCES7ccowhTLT3pyG4Cj3Ca5DnHWzF5ZLY8iIf1J3PJrGamellFRnH7G/
 wE487so6CddmB0Qd+vxQVD3KFT85QiKNmV+lRnsfajiahd7dbnXNHrRqI8uWjeStzldJ7cBebG6
 eSmrPVK8Rc7u6wAUx0eYVhoNKig5Emem4Jzu2qzm11jAn+0adyA+L5Eb99v9btf2j5BE/O6WNL4
 FU9ttQLZS92gw8rK4oqqnXq6f8JTpgRHD7KvH3g6L0NeruHdPiCK4cuPLeKKwLwvjtcUNMHwEmP
 8rXxWC9/cPcPxdIScDcIapGZ3Mw4N9KHsV01xprYwyuYsW3MTcTbUhR4n45Eehh1VFXg==
X-Received: by 2002:a7b:cc1a:0:b0:490:845c:a1ea with SMTP id
 5b1f17b1804b1-4909c0b0c32mr384255e9.21.1779999903114; 
 Thu, 28 May 2026 13:25:03 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092654d10sm60447575e9.6.2026.05.28.13.25.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:25:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/22] mailmap: Update email addresses for Andrew Jones
Date: Thu, 28 May 2026 22:22:47 +0200
Message-ID: <20260528202253.49122-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
Acked-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Message-Id: <20260528083920.33105-1-philmd@linaro.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index a35de7cfbd4..34c092714a2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -76,6 +76,8 @@ Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Alex Williamson <alex@shazbot.org> <alex.williamson@redhat.com>
 Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
+Andrew Jones <andrew.jones@oss.qualcomm.com> <ajones@ventanamicro.com>
+Andrew Jones <andrew.jones@oss.qualcomm.com> <drjones@redhat.com>
 Ani Sinha <anisinha@redhat.com> <ani@anisinha.ca>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
 Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
-- 
2.53.0


