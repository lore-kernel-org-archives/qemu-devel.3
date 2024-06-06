Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CB6C27C55
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 13:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDV9-0000r3-VY; Thu, 06 Jun 2024 09:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDV8-0000qj-Un
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1sFDV7-0008V4-I4
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:49:58 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7025b84c0daso834140b3a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717681796; x=1718286596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRMNydqF1SwQs4xQ+2Ln0gRuBTZiPCbYFW9gmnDA3Kc=;
 b=gJIBJV6F7OtVMz3r9wAf/uVKHO99I/dd6/xDDXth2KO0pg47qc7bpelzMqJLjjbuCn
 4kRlZHnew/7IcoaKPGrSPQUgMJszIqeVtUfQ9+egf3fabKz9ekBoOu1oB01YR3Jc4Bft
 Aj5Czp/Wlk5CQ5cJLLxlVXQv1gGSaS66pzzKc9Qetjdkdt4LT67nleTCBJ8wnscFgkHj
 8v9zD+KdZU95bjl/nxVioMaiIKVwOx9CgNIeoPitoyGoa5zO+SGYAtoQG+7Y/EmeYDjp
 TfaElzfoKkPRGjzQ2jZ30E0g3B4R5Gd6/B7RcMYRvMNqsVwFpbisrhdIhICY/8qxXvfD
 va/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681796; x=1718286596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRMNydqF1SwQs4xQ+2Ln0gRuBTZiPCbYFW9gmnDA3Kc=;
 b=Z2Dhcxc/fulwYwhnonR4B3cNIffy6jMU7/NAllcYqxEtZH/0ZDYAjxZGABNCh9QepW
 L8GLm1DqvnRtbZ1IcAvVuWIDZYwb4pCgxn/djEI0nB1d+Mgr6qKXxn/pIGRM/oUNM6Ef
 Iwy7FZTzN6cbxeX4DKsAx8IQEQJlG4DHqsIKVidoucZIdV/ulWa6XZ2Tbgikun9bnSWm
 FW7Wwv+Z9zB7nNo4pm6bopVlkG+LOhPTWfxY2SMhfeJ+GRKPzN9/dLqRVrA5GWlmEsmO
 GLhh52EWJTUIV3CBss8B7WeU9+CNZV7D02SqynuFGyxl63E1s96x2aPvfTS5SEGk4OAq
 gpsQ==
X-Gm-Message-State: AOJu0YzFverDn6tLor1S40bXAPebQ8rKdSjwEYNAvU1rWAImSHxPJgjf
 hWiSVJkW37DtptLuLYguKItAUMpK6OdHAZh+7Q9zYUp89L5PTkNAAEjYtZWInNy1NFR7HxtJ6Tv
 1xVivdNiSlLPZYNqa8rw9hp+1oOH1G93sMhgkZpBnaBgNZkca5N3nAyedA1bzASls1hkRNsE52M
 0hSOs4bUCo+08bOEhz/sv/ltxcOMZfer4goto=
X-Google-Smtp-Source: AGHT+IHZlU8OJwBBgPAHKVEnCpZKJR1aaCMpi93M7bGGEpSmTnRmn4mcFGe3eKguHd+AKZxaNNmnmw==
X-Received: by 2002:a05:6a00:1894:b0:6f0:c828:65c1 with SMTP id
 d2e1a72fcca58-703e594b16emr6182824b3a.2.1717681795701; 
 Thu, 06 Jun 2024 06:49:55 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd50bc86sm1150919b3a.175.2024.06.06.06.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:49:55 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v4 5/6] target/riscv: Reserve exception codes for sw-check and
 hw-err
Date: Thu,  6 Jun 2024 21:54:53 +0800
Message-Id: <20240606135454.119186-6-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606135454.119186-1-fea.wang@sifive.com>
References: <20240606135454.119186-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Based on the priv-1.13.0, add the exception codes for Software-check and
Hardware-error.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 096a51b331..c257c5ed7d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -673,6 +673,8 @@ typedef enum RISCVException {
     RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
     RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
     RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
+    RISCV_EXCP_SW_CHECK = 0x12, /* since: priv-1.13.0 */
+    RISCV_EXCP_HW_ERR = 0x13, /* since: priv-1.13.0 */
     RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
     RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
     RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
-- 
2.34.1


