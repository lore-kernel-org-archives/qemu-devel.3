Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D6DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqE1s-0001hK-V9; Mon, 16 Sep 2024 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1o-0000w1-Jh; Mon, 16 Sep 2024 11:52:40 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sqE1n-0000Y7-0Y; Mon, 16 Sep 2024 11:52:40 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-205909afad3so47653695ad.2; 
 Mon, 16 Sep 2024 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726501957; x=1727106757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=SniowYEu2Ls+XDjIQZeeBDMXttEtXx+RhU6YQBfFb5/AWTi7JlIiDKnb7woBztiM+B
 hQa/s+Ifz7x5K34Rc57/CIBszIGiW/598nUnKrVEJUcRa6W3lahA8ZY2c72a2LyMBt5W
 pKYWAV6B90LXXIxe2O4YGPKW4FWvuTbh3L4G6aLgBKWRGYalE7sPzsKtFsLFoCGItzv1
 p3f/hV9Ot1/0LhY6a8xsXYWJhlqG1BWHPJQVziWX3S1obT84+X9H8JrQFkG7qLX0GEDv
 GPJUomXLMM/Ht1TAXzwoPIi76a99VJcAesFtVyIJenbbbw2eJJnL7yHI8OHWC1hSzJd4
 d2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726501957; x=1727106757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=k0gPnuCYhMFYd18d9lsULvs8k4aSAJoP3nXhkCRQFozoCK2uEqeTI/ZU2P1Yu7E4XJ
 /WSTLvSwjg3FgP+HgJpgl2rTEQ0JpZ3Uth6z0sYc3/5WV+JuQnOHbF/A3hW+4sESKj4i
 wGuXttZZyEKCnCbh1G6FoD7FYxtAc7VWwEB0Mi+4XVXoLKbds0ygJlI1QFaqqFSSxM1b
 8VCqHEJNxsuNrHF3IDtnWXhRd6X8DGk8PzUEWcT+FWT+qW16ilVxFQicYI+Y9sNRZ5RJ
 zLhQ6/scugZ/6VWel32U6Ohw3HDpqKc7lvqRpBMxHPqWCux356LisRUzYZLi6nu0hAgg
 BheA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpfmesb/cL0etB6BzlDLnFjVJwOBP/IGkqOHljRO9i6pQAfNM8ygZbHhit5NsbhMX4TibTpxnz2ikF@nongnu.org
X-Gm-Message-State: AOJu0Yzl9DD2nNnZbBD+dRJ2PDcZ8UgJ8CakXpHH+ltmRyUeXUGiJkvJ
 In/7esL5uG8CSB+0NMI7EF/XZkYD1dTLdARsop1gqd8o/1mMX0MCmDQyBQCr
X-Google-Smtp-Source: AGHT+IH5p/iRr7iIS/Ny3bBbsGfR12QgknIk5rUaknXx+oSjoKlfkMkwxShX7afkWPvgJ5+Y8Tkpig==
X-Received: by 2002:a17:902:f550:b0:205:4e4a:72d9 with SMTP id
 d9443c01a7336-2076e30651fmr265652415ad.7.1726501956810; 
 Mon, 16 Sep 2024 08:52:36 -0700 (PDT)
Received: from localhost.localdomain (27-32-110-191.tpgi.com.au.
 [27.32.110.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946046cbsm37482545ad.105.2024.09.16.08.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:52:36 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Mark Corbin <mark@dibsco.co.uk>, qemu-riscv@nongnu.org,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 17/17] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Tue, 17 Sep 2024 01:51:19 +1000
Message-Id: <20240916155119.14610-18-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916155119.14610-1-itachis@FreeBSD.org>
References: <20240916155119.14610-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Warner Losh <imp@bsdimp.com>

Added configuration for RISC-V 64-bit target to the build system.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/riscv64-bsd-user.mak | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 configs/targets/riscv64-bsd-user.mak

diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
new file mode 100644
index 0000000000..191c2c483f
--- /dev/null
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -0,0 +1,4 @@
+TARGET_ARCH=riscv64
+TARGET_BASE_ARCH=riscv
+TARGET_ABI_DIR=riscv
+TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
-- 
2.34.1


