Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42567FC5910
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYTj-0002ZX-0P; Thu, 26 Feb 2026 05:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvYTe-0002XU-FU
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:20:14 -0500
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvYTd-0004Kz-36
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:20:14 -0500
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1270ac5d3efso547974c88.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 02:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772101211; x=1772706011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PTQfQ0Cp2HeDcEXCvcCXQf0PTtazv4JoH+8fi3PB4dU=;
 b=S0bLIHkGTKVaMJep/VeGiQTEjHKNfUCjFqNa8D7avDdC3d2/Hj6WU7woPVla8kHYKg
 p4M5bSNNcNBKZooVMgBpkn4yUkm5HZdaPcXIwR+8T8ayl/vlnn+a8PUR24zgRswUQq8y
 VGRZ4xWkc1glOI8hYim2cTlE+pmAZPojMiI5Z11MgPiVzmVchKpo2jq/YflNjfTqwuKD
 kCNBdt6S4ZlqIxkDOO8sNmgqDhK5rxRLd4M05D1ifz7zXVf+ULMAGmFzmU6GVUoRPS01
 jaxc3PPRXCkTxxNFlA+yh2WUaWSLfPEl2w1B1nef8nrerX+KV8O99CDVo3bZAIZkE1xW
 rr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772101211; x=1772706011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTQfQ0Cp2HeDcEXCvcCXQf0PTtazv4JoH+8fi3PB4dU=;
 b=aXPUedz/CcKd+4D0a1U89s1VUCxuG5kGJrKRPQXJoqyMUu1F4j5OJFcqI+aWCa/X7n
 eD4ww2CAtCEsgeN9KEpOmtvM7Jmr6xBlBulJlFWiAwiN63qAT17CX5XC99TbIey+7Lss
 Cw3T+NFX9yo42Nu4LT6TzdOC1AQnrvL2jxSDsHXuffhtj4GaXKzmiFLsg4LukJvNloUV
 w0QTbR6XEc94bhc/8dtWdHhnj3ajNZlOLdbqTSjNTuOygcjvho1E9othzZhpX71u5Bhw
 au5AGMjzDLvT1y5irwyVFG511B/FsTovrJC7/8028tfhvwsgZ1BA3ybZVczVnqIicme/
 b49g==
X-Gm-Message-State: AOJu0YwxF4n3xLbC3WO9d+cJUwS6Cb8bbPC1gmApwzCSAV322FoZHvRk
 VSD9IuOpU4CzZD8KoHiw7g69KPlBe1/TfseebkkBz7jbyLFXR0Haocl4k0/nlnJLWTs=
X-Gm-Gg: ATEYQzyphzxnjF7h/Z3gShRSjJpynbSMfy+KePreGyxClKskJiQgoElNgHSoEL16UKI
 EsRku57VO26SnixXL3FIMIaoTBG3SfJYYosiQSOSGLSSvGZ9vh86b6QaV0QUbWiHXYRLUoIqy2m
 IUBbwoZUMFXYs0O3v8Ge0+U8AhcEx9F5ZJ2demXbok8Pt4q8J3ukrL81dmKrn3NphSW/IdWvqBV
 VXWgvW3rK01EYOWkrfWlJeDYaN4lgQz8feK2Xar+SN4pqN1+UwaiezhafnuuG8p6qnZP7M+s6M9
 D33z5ohTegIH0V6B+VvfQDtVcPRh/7mgNSeO9Kpz4nWiqa8z887VNSY5iwpubgQVhiOpnpXNgw9
 r1Escxl1rtZxftCb7VD6LneIMttkNHiXU/tp0myMIRfTu810ZZqOGVJCSJJxHk01xMKKFWOk9UH
 JSRUHln0lVErNmhDZBCyl6ejvsHqxTHlxvngDkfG2OMUG+raDyr2OknXzCuMnP9RoFaHK4UA2hp
 +1Em1iFSvPoi4+0jGf7kjqrvaU=
X-Received: by 2002:a05:7022:61a9:b0:11b:9386:8256 with SMTP id
 a92af1059eb24-127869d8d7dmr1176270c88.43.1772101210648; 
 Thu, 26 Feb 2026 02:20:10 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a52ab0sm2318517c88.15.2026.02.26.02.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 02:20:10 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH] MAINTAINERS: Add myself as a reviewer for RISC-V TCG CPUs
Date: Thu, 26 Feb 2026 18:20:08 +0800
Message-ID: <20260226102008.146928-1-chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add myself as a reviewer for RISC-V TCG CPU related code to better
participate in patch review.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 233d2a5e71..4923715c9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -333,6 +333,7 @@ M: Alistair Francis <alistair.francis@wdc.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
+R: Chao Liu <chao.liu.zevorn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: configs/targets/riscv*
-- 
2.53.0


