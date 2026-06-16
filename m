Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35077CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQhQ-0000YR-Kg; Tue, 16 Jun 2026 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhO-0000Sj-GK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:14 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhN-0003OC-1Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:14 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c8583b8fd89so2609145a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604432; x=1782209232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKn6Uqir0rU27VFly5gOIip/ZmHPwqNDrsn5rg+vJ6M=;
 b=XBN5rbYFkyCylV47bZUj/yuzMtnOC06rplTPKcpyJERTe+ivdQ+fe9KYC0WptqSx9m
 JyR8Ad1vc6Z6ke8irF6fnKGhITLjLzQdbI/ZSekP2DPo+eLluh57R/ZZ5SfjtygtEZLs
 UX55xqU9O2wsyoQ3zHZzZfdOS4CDgta9ufpcUv8J5Xaq84U1qZJUzX2qSLPUjUPRD0yb
 CoAgHtnB+Kz2aM8JNCljzcmoM8hDC/xXslr5vfMxICeOHnfdSbIwHi7CQqRAACHp3AjL
 9Wm7CsgcmSZQWJmWhqHKi9jWYbRaakL5kAMuVzAP7A5rsRCsuDhRIRvthjZJKGSfzYM3
 4Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604432; x=1782209232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qKn6Uqir0rU27VFly5gOIip/ZmHPwqNDrsn5rg+vJ6M=;
 b=aKxcWfpRQuNeWxrsvpi5CFm6of8rG/azdzolJv+Wz5zOmxAziZ97AQlOg03a382LJH
 DVbIGcfV6RaRHyUhd1KO9kl264tYR57l2Glnb481Xk+lVUaMk3u9SDMCbM6RjeXTsGto
 sxNb9I5jJG/+Vc2iYOQEZgxigXrie5DwehzdoRv75fV5Q56iSb9c7mRUGTvwPG61mdIy
 Tm8jCTxg6/t/s30o+PD9G9XWymc0sO9cYFszZ4hhIhFkGQncpwsx46u/FzlYTA7rnZFB
 IpYVK2BHiH1a5AwxPpAXcVKTH4NqVGweB/E3jsnzbGsvnDZFOpeiGSgfgpO79SK2FBFe
 VPYw==
X-Gm-Message-State: AOJu0YwU7t2uMLvNHYPN+XFd3kRcbp/WXvZxX5EoYa8ASUOhosoCNG/D
 zndGrO4scrcFrHQlUwZmAoEgLEfNlEDPWqrPqrDgEGhK3v7ERRWByLeHh49/UwUM
X-Gm-Gg: Acq92OG7sUXOLQGYC6CM9KK2sfOeh/GwTO/O84gRbXmHRO7cs93Py/6A/caSp4xVwHP
 2o33DkpXcdnHapFK969AIeT1aONoGmHKzO5VHhfP1s8YAYBSa/kxOOhquU2YLd2rmMikt0OWOFM
 FmHC8wJohIHSoT6+1zjnr+av+Jrt9SFkAP0Op3OJW9qbms189L5uNIIHEw+3USMu9iSb6nG8z1M
 tTyidPhJuOXCDwl5wG+GcNuafiIn2x/hQye7V64tfs6SL87aPhEUSc3z9yOrLRLl5eX+pdc9l5/
 VT6T/ukjObIYmlzAoM77Cq3dMBlrYIRY0t/aP5OIq3E3MVbOOeZXY5anaew7QITIA9dH9Hhyabc
 iI9DDB7+jHbN/y3Offri317q+HwDnkCmn5QRBhOLmSSr/gABELE1f000jQixxxcmfBSdBKQehR2
 owwwRT880sKSIV7zcXb0t6zOKnq9AYEAOvnWMcZsrC
X-Received: by 2002:a05:6a21:4a98:b0:3b4:b216:2b26 with SMTP id
 adf61e73a8af0-3b783c7847emr19949727637.5.1781604431753; 
 Tue, 16 Jun 2026 03:07:11 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/83] target/riscv: Indent PMUFixedCtrState correctly
Date: Tue, 16 Jun 2026 20:04:31 +1000
Message-ID: <20260616100527.1939565-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Anton Johansson <anjo@rev.ng>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-18-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5d01672f12..6477c7de99 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -229,12 +229,12 @@ typedef struct PMUCTRState {
 } PMUCTRState;
 
 typedef struct PMUFixedCtrState {
-        /* Track cycle and icount for each privilege mode */
-        uint64_t counter[4];
-        uint64_t counter_prev[4];
-        /* Track cycle and icount for each privilege mode when V = 1*/
-        uint64_t counter_virt[2];
-        uint64_t counter_virt_prev[2];
+    /* Track cycle and icount for each privilege mode */
+    uint64_t counter[4];
+    uint64_t counter_prev[4];
+    /* Track cycle and icount for each privilege mode when V = 1*/
+    uint64_t counter_virt[2];
+    uint64_t counter_virt_prev[2];
 } PMUFixedCtrState;
 
 struct CPUArchState {
-- 
2.54.0


