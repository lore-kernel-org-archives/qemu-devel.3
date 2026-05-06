Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25EACD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcm0-0000mV-K0; Wed, 06 May 2026 09:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcly-0000m5-BI
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclw-0008Uk-TS
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so99804835e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075922; x=1778680722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d7TIY9G+i221kVT/MKKd9WydWOZ6glVEIgxZHbUxyNM=;
 b=wr9UGd0B+CY99gTY55gPRAcejlNwKPknkwu7pLTFhG/TwjIfvngYQcw0V00ZVu7bv5
 vnwffs2w8BP4FuiDfyezGItkNSNyVk4KzaR7+ne9qy4aK/tWruYuiw0jKLdn3MQb/IHo
 sGI/0qMaPJtSDB0O8CSc8ynQASR7vZ2Gc3BIDpySEOgSvKBCKgHFQ/UF/LlG8qKLhKbG
 lPLpDvkTdsJm6b//Lsu/Nv1jEXO0GPqNPOzM7BXkv2b7ZIecrxpxvCWaPAbHoC3H2q5G
 yRKyAWZDm/NQUGMMGBckSGJCaXOm9itKqzPBDmudAfj2kiF/zdMK5x28vQRMmKdCIyXU
 c7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075922; x=1778680722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d7TIY9G+i221kVT/MKKd9WydWOZ6glVEIgxZHbUxyNM=;
 b=oXzEOO786EPAFRLKTRJwS23dq50t/1yPh89IflEtuElNJjgf3N/LcOpaZWCgcq1iVv
 e0yfsdUcQvX8Hh+HEq50m4vEGie+iWWON2N8khlFV/Jxc+trriwuLMzMYz8CtQBsQzt1
 uHiEd2Fpp8CBofCBR42uREft1Ynl8x02QqNT7Vmolw48jFkcvCYn3dAabbbgfFoPRUtC
 Hw0dUwnqHseKo91uox31VRodg0yMKZXeGMaxuErP4comiFeMA7K0FvPXiX8HwFiGoOga
 FKMx0oMD50161FzrnLSL3dtcM9e3unj2+17v47qptMJ1ok5VGvwEGg95MO6oEXT+cXYj
 H1pg==
X-Gm-Message-State: AOJu0YxcoG4SSpVwesECxQ1O5IlAjBpL5PW2eDMW7UYHHc0IG9xSw/Ge
 gN1jKqUEzXWGQqPymiXuTptx6g9An0upnllx1mKxBTp9FDH4gGHE+mpCUqlOgEjYkd7WqpIPCTB
 rtcfAaUk=
X-Gm-Gg: AeBDieuI6otwA+feFo/EBUnRCdx99haPTkIIoeA4foqEimfLHeuHgxzTyBWV4v2u1FX
 SVYn/0O72S3T7NajR6gBzZGWSGg/EY8FE1kkrSlvWoM84ld8wB0oCU2odHsgxQqeXkCB4gSjLNT
 RSvon/rcYSyY7Xhcps3iq+cbdi3mB+oyVqXAOsE/Or8e+EtDRObskoHkDZa2Bv2U0Ea76dMAy3w
 nJmu8nLeEhwxv4KoUVoBMNK73i0nPyNQc2B48wUYjY5/Cpy4nobGUQNH+p5MoE1UPIAIxJjW3Ah
 GSSNNuMYowM8e2fznFQu+cXLpgmyF1CTmxGqH8YPjgGE40slgXB1Qbosch3H6xAgAUYVL5MZHZZ
 LCUdDkWzxLyF/OMNs6E2u7IIyvK5M9OalRBwwchp1slWUrLyBJwEVWizgtQFPh5xdd5Crn6+MTV
 fjT/haneTUo0YErxDLO5LqAfnHWX6jsxIJwtxqgvnCG74qSmszQF5hbl1hROTPeGpMT3mwCAGUA
 yom8vu5GIk=
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-48e51e196f9mr59171685e9.8.1778075922057; 
 Wed, 06 May 2026 06:58:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505285e765sm12296126f8f.10.2026.05.06.06.58.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:58:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 026/110] configs/targets: Restrict the legacy ldst_phys() API
 on LoongArch64
Date: Wed,  6 May 2026 15:53:58 +0200
Message-ID: <20260506135524.20617-27-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The LoongArch64 target doesn't use the legacy ldst_phys() API
anymore. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable
to hide the legacy API to the qemu-system-loongarch64 binary,
avoiding further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260319104944.66690-3-philmd@linaro.org>
---
 configs/targets/loongarch64-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index 476407f9413..a425b3dbaae 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -6,3 +6,4 @@ TARGET_XML_FILES= loongarch-base32.xml loongarch-base64.xml loongarch-fpu.xml lo
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.53.0


