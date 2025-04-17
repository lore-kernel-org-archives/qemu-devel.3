Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC84C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 10:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5MsR-0007c6-Ks; Thu, 17 Apr 2025 06:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Ms7-0007OI-7O
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:32 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u5Ms4-0003L1-9F
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 06:53:30 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so460092b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 03:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744887206; x=1745492006; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cbCfnAY8k2Soyd1n/D0nC/2pTKzsneNdm2pbb2owQHc=;
 b=RIC7CshzBm2+A7T45AmgiQdQtOCv7iIxUeCsxbderNno4latHpIhaqmxTEEE/w9ihs
 LhekSRZhk9ikxA6V79c6FbIOsM3SDc2KFI1S37Y0S7FAFT0mvzR2zdlCYlpFyzBDPuaB
 rfik6LaEhKtmRxdLy5XDmbJ1HY1A0y2Fx5g8U+lTZGD/+X7IfmIaTLpLRu6/DHLcUS1y
 rtJxu1fhWqPyL7ZrnbZy+gyoulYgJrkbtVWxN3w/vcvuzelQY0P5q3t0jG/rUW6XIdkx
 /zXkFbwu/YNNsBjw29cxxASp4HbEBixz6+3oJ2CGdbOXf2g1JHhvvAH80KFesR7iV/HS
 6+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744887206; x=1745492006;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cbCfnAY8k2Soyd1n/D0nC/2pTKzsneNdm2pbb2owQHc=;
 b=YXZYNxEDyfG56BAR6qn6lSMz0k0Ot8t3Y8myK0gbJ6SnpNucNGSG2PhWDJS9J74NWS
 G9hs+xkyB0aJi+ABrxHd0coQYS6Yrz317FgB+kaNlZDypHWb5hh8c0Tyudva9ShTON/U
 YFbhJ3XuiKbaogowBV+AMCWCi/TG4U2Yv5bvdL81WbqABRoGYKOS5VZ8y23vOnpE2mCf
 mJLh2QGsOfX3LgX/Wy79WNGL0c7mQG4Jy4lDks4FxnmYcAOl+SBj4pnmu93FXVM9bP7F
 vih3vbI2NA7kYDPc/JdklLUPmij26EvqsJMXZA6JLgsJBQsUmIK6WQ7qdSBA8YPcNZSE
 o5JQ==
X-Gm-Message-State: AOJu0YzovKf12iFQVxBxpIx5cYmIqqvjJZHsHW5Im0HZo2Hh4aDbjPTZ
 aQs9dlh95veErBN9oZNOTU7mqFYANlSUrD96jRHMvjAf8DcFaqAUTuEbIZywYdAl+IDeedEk3L4
 N6jh8OqB5TPBVRIHu4lUYZu6u3YPh1D5Xi0F5l4eR/fK22aKgFqtAjIKQU5dYmV66tU0ZSNS33Q
 6Z8H8U9OtpWxsiHjiokjdrk0Ea8nlOuMT+kw==
X-Gm-Gg: ASbGnctOM6R9tRwH3oUacG4tZC9keEc2CuzdLugEkKsflaQz41eE3429NIMIqYRAyDc
 T7M1gqhHv2c76Ot7h6oxNLW0GJePpwhyihBCOdN5V86XdiK/n77p1Y5QuA/hEl/HY0mvahiD5gv
 latV8D046yw+alZMKsrhR8zMrobHhPwO2Y2Xlx0xNEZD692ddIgR1qhNCFycQNf8koUCkcf00e1
 lcB+dfWVvxQi7nVAtX8an0XNgsbmH+2eBPgVL817fsyToPNCxWJHtJS0mEN1RqsgNZ+cVguiYau
 9tyTsQpLWffu6vMNnuhB1VSY8ZF8ZTQgn9XGVcYG3evtOJCEDEJSZz0vV+19aAg=
X-Google-Smtp-Source: AGHT+IGcw0tpnbx9LmA6EQEP0d8jXvgNFw4H5puxgT4ARXRg6weIMd+yOOKSUy/JqgxMO5Lay+zBvA==
X-Received: by 2002:a05:6a00:801:b0:736:532b:7c10 with SMTP id
 d2e1a72fcca58-73c267fe0f0mr6994875b3a.21.1744887205746; 
 Thu, 17 Apr 2025 03:53:25 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230ddaasm12366251b3a.138.2025.04.17.03.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 03:53:25 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 04/18] exec: Add RISC-V WorldGuard WID to MemTxAttrs
Date: Thu, 17 Apr 2025 18:52:35 +0800
Message-Id: <20250417105249.18232-5-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417105249.18232-1-jim.shu@sifive.com>
References: <20250417105249.18232-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42a.google.com
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

RISC-V WorldGuard will add 5-bit world_id (WID) to the each memory
transaction on the bus. The wgChecker in front of RAM or peripherals
MMIO could do the access control based on the WID. It is similar to ARM
TrustZone NS bit, but the WID is 5-bit.

The common implementation of WID is AXI4 AxUSER signal.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 include/exec/memattrs.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 8db1d30464..7a6866fa41 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -54,6 +54,11 @@ typedef struct MemTxAttrs {
      */
     unsigned int pid:8;
 
+    /*
+     * RISC-V WorldGuard: the 5-bit WID field of memory access.
+     */
+    unsigned int world_id:5;
+
     /*
      * Bus masters which don't specify any attributes will get this
      * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
@@ -63,8 +68,7 @@ typedef struct MemTxAttrs {
      */
     bool unspecified;
 
-    uint8_t _reserved1;
-    uint16_t _reserved2;
+    uint16_t _reserved1;
 } MemTxAttrs;
 
 QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) > 8);
-- 
2.17.1


