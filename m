Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8313CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEzg-0004GT-DV; Tue, 21 Oct 2025 12:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEzW-0004D7-UX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:13:45 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEzU-0001aV-Np
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:13:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7800ff158d5so5214175b3a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761063215; x=1761668015; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Y13V29TyEhcjAwL5nFeY1ayHUoKW0GaN/z1B8E1GJk=;
 b=AklSlcxxHGTWnz6+yiR5QYj8IneBSb5AiHH49OkNZCmAx48cyuCkP1Xf5KH1vhkTrI
 pE8RBP3qy05XpkNxbk+70UmOqTqknuIx+45nwBj3hXFlx+//Fz+5U2DsBldenOx/yuP3
 hpCaaPhXi/Yizn4cduifL1lD51kLMxnyeL1FL83aJ3N+GDUQERi5KG9A7d/267BdwLXG
 VXVNWv6/5UwJ3+k4EBTpc38M9jH+acdyhW+1ZsPD24QoGcX5MM/scb14v/x34pi23Vtl
 O6EnO1bAcVWW0YCgOGwrPjy1RFayJU2zYAWg4SsfIVuZ9GE3tNt3pV6FCUqKScMcSmAS
 t0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063215; x=1761668015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Y13V29TyEhcjAwL5nFeY1ayHUoKW0GaN/z1B8E1GJk=;
 b=vOq71aMiJBaYO9PUcVr1zrW3P7yEXq/SoTfoXkLvApZ1G8GFG1urH6xDX5pcOABITV
 5QCjz1jVNOCX6YfDlkKShIQjxJYYFwtCUJSJZIxo4UHTFF1TWqSZvbk2Qa7nZmUT9Zns
 NApFakNRrPTXpq66L7fegQTzuEu/Dzzw0PAKhBYCAohclNDTDRx/quPOEKl4sd0HoaZL
 uw5k2rQn+rzNfFe0JCBxUFOeKp/7ms+OrBb+Fk5eNVt8QjvVPPt+q0ySH/Csgg48aeLN
 V3W05E9AeiJURfy0MsmnsAMVCE5LHAfp2g7bBYQnbyqv1yvtCYysZSdpqVUe517WwwoK
 A0YA==
X-Gm-Message-State: AOJu0YyDs/7fgSClZlAmBkga0wg7uro48FVO6Oha2b7x+m8BsYWCoPky
 lW6//AD79gIG39vh1dfrS58cEpQMQ3GWFm1KEGTtd5QeeT6wB2vwZgDBJ5UWv/Oz4cmnuUrWHOG
 TJCOwxYI/lvcoIynHHh4ygV40sCDfUoCTkwrkWu4M+lpTvDDwn4pOaTbdakaf3zmFh9gqoDE+0Y
 7L2g0wavgB4awgfEFQbqNknvLZ0MBxhkWigEuVqA==
X-Gm-Gg: ASbGnctRx3Tzmei4227eMk55D+IL1VXiavdIEZuXbenE40L9fSDVzbb/A38aqAbz2/c
 o90HKJ1AFJPb4y2g2veoYNbQtbHvTBfH4FyHBI2PrmiFxlr+T7BwYwL+O275t/dVbSFv7RNizmO
 65i1mn5hBWOcwHHepzhXUF+t6NlAv9p/JsELOn8nYmJNX1Xn312kZImqGp1fe6lRL7NOSoIYQsx
 VPbmi4qGpNiznKxgzgKbb6wAZbGAJx5OE7P11oeNQXmJZ8xgaQkeFG636d145IymWOrfAWebtOO
 SL+ishF9zkugatSs+zs2rDAcAjU5hdtkwOVNkUL/gsfMx5gKTWtwXnkQ5chzUXUJbbCQdmQ9aCj
 mY6hUOT2dk12wg7q6Bx9oMHExYju5N8Y4aHb2N6Wae7MyCl+APTQU3rXP1VIjcv+Zv7VmRPXKiM
 CJYn/EMKZ3rtlvt4rWs7/OGg==
X-Google-Smtp-Source: AGHT+IESq+Wree+qpeUxnR7Xwrl5wv4lQYZ/VsJBAAZNIYY2fKNL9WpYZZTIkByfOojT6r4EGL3dvw==
X-Received: by 2002:a05:6a00:94c2:b0:79a:f5eb:3dce with SMTP id
 d2e1a72fcca58-7a220d5792amr20550258b3a.31.1761063214459; 
 Tue, 21 Oct 2025 09:13:34 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23010f7c7sm11731157b3a.54.2025.10.21.09.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:13:34 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 08/18] target/riscv: Add defines for WorldGuard CSRs
Date: Wed, 22 Oct 2025 00:13:14 +0800
Message-ID: <20251021161325.585278-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x430.google.com
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

Add CSRs for 3 WG extensions: Smwg, Smwgd, and Sswg.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_bits.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index b62dd82fe7..a546545ff3 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -468,6 +468,11 @@
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
 
+/* RISC-V WorldGuard */
+#define CSR_MLWID           0x390
+#define CSR_SLWID           0x190
+#define CSR_MWIDDELEG       0x748
+
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
 #define CSR_MHPMCOUNTER4    0xb04
-- 
2.43.0


