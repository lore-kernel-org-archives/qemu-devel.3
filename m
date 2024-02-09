Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470F6C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOe7-0007on-R0; Fri, 09 Feb 2024 06:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcd-00063N-9n
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:45 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOcb-0000nx-13
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:00:42 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-363d85fda93so2280265ab.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476439; x=1708081239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fg+LZAt5OtmBmqmGwDnU/PTtHPHeBRQ/ECrQKN68ExI=;
 b=YK7UlrLWEWWs8i5GekGVetwWNdOKkbf35FeT0pEFXR35HAG5Q9zP+S7SoWUkHw5PsB
 j9QBgXWL1n8WKTaaxrWB6t9izYy9cbKbKrO/0UxJBIHH+h4CMuxNGgkarQUL0ojt6OZH
 6jCMm2e+F7SC7GTHzFh2tBKjwgPGv0c0gn8sF3gb6EVcAi7pz/uK17z+RDNBv3WejctE
 vv/GzBe0mnrNv+vnGzeXeZQZPu243nNPJ+OS/so38sNPa3fy68wRedqr/aSkyuU0pAl/
 KOUwyY5n+hJMwe9Ym6BgZmP6C02z6DpriBrqOr/d5wUSmtj/eJATlMJX1+sCBGUpRaJS
 CKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476439; x=1708081239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fg+LZAt5OtmBmqmGwDnU/PTtHPHeBRQ/ECrQKN68ExI=;
 b=ptK8fpJeHeoZPzT7/pC8YbsQEtNw65q6kaldNBur1otF8NmYWirIVMIU9dv2utZUyn
 h3c3maPU3cauPxnjcypk0p2ifhtL2QyxrwM7v2OAzJ+1rYU52qid7ddNIQnIyyr2sJ83
 vpM/RIePV+DpGl8tzuzrfgCrCBbszROAEnQ3iJOjs9e2pjQ7B70XLU1+A0AkCfMMR+lB
 UtjYv7XGZ9LSRQOOnTA78s38dYJ2WCvVROHrOIgsvGwUq/qVylLxuYRqo8+9PxPMETwW
 HORI7b2Yssy2zdVwj5+oLej+5UorhlM/9oU/WMIXesRYXTR8B8JB4212dO4Th9LuxrqC
 znkw==
X-Gm-Message-State: AOJu0YwU/yd0KUakqUrRoZsmHvbhiGTic19AVIRqXneoZ4pNkcCrO3C4
 Ic0zYwoYG5Jv5wkyAwIFjaXYA0BnVfuQ24ybYP1z6lWrfF7Ll1pwLvX2TIx0453nCQ==
X-Google-Smtp-Source: AGHT+IHpZzgmCG5f9p0TN64q2p5IQ+18hIExwAAdACsaZtTtT0qxcua5n7QHSyUlekj8kfAlQ+eqng==
X-Received: by 2002:a05:6e02:812:b0:363:e31f:eb0e with SMTP id
 u18-20020a056e02081200b00363e31feb0emr1518748ilm.7.1707476439672; 
 Fri, 09 Feb 2024 03:00:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWJFOTdJQ+C7RtfhPACr6ZqX0Mls2ZmZJ4qaX6qksp3jek+q60m89KVXb0abkqFchwA88vj0CbvevUPfu/A8KtqBkksjodDRHDZQv0ADOgbuQLbtBbSPjy7YCGZCi9aJ+WeIKN1hmkSeqb4V66nKeWXn8qj2e/mf3qAhF2RC9urO14=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:00:39 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/61] target/riscv: FCSR doesn't contain vxrm and vxsat
Date: Fri,  9 Feb 2024 20:57:53 +1000
Message-ID: <20240209105813.3590056-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

vxrm and vxsat have been moved into a special register vcsr since
RVV v1.0. So remove them from FCSR for vector 1.0.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240130110945.486-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 3296648a1f..fc2068ee4d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -32,14 +32,6 @@
 #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
 #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
 
-/* Vector Fixed-Point round model */
-#define FSR_VXRM_SHIFT      9
-#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
-
-/* Vector Fixed-Point saturation flag */
-#define FSR_VXSAT_SHIFT     8
-#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
-
 /* Control and Status Registers */
 
 /* User Trap Setup */
-- 
2.43.0


