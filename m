Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A577FCD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBY4-0002ms-1l; Wed, 27 May 2026 06:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXh-0002b9-8c
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXf-0000gZ-Mc
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso39570115e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877874; x=1780482674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RnDqLVwwpHMlklVbyjMP2+f8L8WuXDE5eSfqUEnyh4Y=;
 b=xCPCMSL2hsBzD2HTFnl+puURmwV/TlEyZPhLvUHv7T61VrkH/W2P7WzmcTNOzdgpXZ
 LabqtPox8kFCqEdG3dAF8NgJBi+Vw6lY6INjDSY85PpRVBZNcBV2H65G3zko/d9rL4Iq
 c/kD60dOSxCmMjTFIR4xeXACMoFI36rB+/l2hM9iohUE6b9RICiWc3L68Z+JKjnpC69r
 BJdLm2mW8W6t9pn2CnWXkqqDo4J09jriEpjLmUBMHwFdfxKpM1eHcHM/k3xl1OYyMjNC
 zA1weCN092jsQUG/UxE0ocWw1TlcbMCusrcsDst1CVm+jdl91NxwFRGj6E/DK1jw+YEw
 LWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877874; x=1780482674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RnDqLVwwpHMlklVbyjMP2+f8L8WuXDE5eSfqUEnyh4Y=;
 b=C9Z9ezDmJ/5kVWXaMMMAKnOrDpLcvSBkMYl/ZlISIWbH1Y7VibpaVgVorqmaRxRYFT
 h2Y+sEG97VgugdF93yg741v3pq7vr+qoPn7GgQn+oxk4wNNE/EFn8xP7mUiOqupdH7L7
 KPARM/sSzBiQpalXTtC2kjlOAJko3q8Rst0zPiwBQrzb0bPcR8vSMN6BfvF/K6nW+Lvb
 hPbN1iGQPm+uK8+xpyQpO/difRyvKDzQz/olZeQks5GTsv1OqWksmSllgqlpUJC+Qi7m
 N2IspclgiwDn+d1xoSuQHeN7s5BTlgw/9C/UBzw5GDPyW4VSPndetPFsJPTPOUK+oyVE
 MMfA==
X-Gm-Message-State: AOJu0YxXqha937LpH/yLStZfQiaCelu3rrCZvYzl4HoTZ6rvnEe6oxrK
 FCQWaBpdIktABIfeQ1licb7zGrROrmQMca7ITV/QyjJDPwmCKcmy6i5cRcTXhrJOroTaFQQanGm
 pa1Uplszxbw==
X-Gm-Gg: Acq92OEYltl8L9XXC7D6rn1L8iNWGpSjMGTzM9Jku9r+6wXmwQ/pEU6FH0Qiad9DQ+7
 gYgNx3KFEUX3RgZv2xnoxRuqhPmtiimruqRmOEupvZ/UuAepYAhraex7YTDdd0nu6cKkH/jhuAZ
 PsN3N9LkUbGfPP6YW9fEDbPU8YWm4EOQkusOYTN6N7K5YCR7PM1JavKKrXlrcFU+xyOzdYrn7UM
 E7rmdfh8q1JzNE+h93C5M2FcoCUtuk81K8j4N8a+NO5d+TDb84N5yrInfpkR5T70YywV5REA6jI
 h9f6DiLhQ16T11prDongemS1gXqmC4pZSjSCRmaqAEpaPVkjN6YPe4JAmaPsGSx1ii17gK8I6om
 5/LbZDnjHVhOqny+aij4UyLKiUzIxsebs1Rnuo7hODow5nWxXzhkQxX1Lq4SjxWug3d96AqLDqN
 oA5VulfPCUmwdntlaq/nQLOlohQC/tkemXpujH5LkyigCZhUl0LDNNtA5yOh5DmgXBpw==
X-Received: by 2002:a05:600c:8b08:b0:490:601f:d785 with SMTP id
 5b1f17b1804b1-490601fd90amr247109305e9.2.1779877873843; 
 Wed, 27 May 2026 03:31:13 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045620c05sm386334365e9.14.2026.05.27.03.31.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:31:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/32] hw/riscv/spike: Use 'max' CPU type by default
Date: Wed, 27 May 2026 12:30:09 +0200
Message-ID: <20260527103037.4461-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The Spike RISC-V ISA Simulator aims for maximum coverage,
so can start with the 'max' CPU type by default.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260526095731.63525-2-philmd@linaro.org>
---
 hw/riscv/spike.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 6e16adfe559..f9d00e0d5c4 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -342,7 +342,7 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V Spike board";
     mc->init = spike_board_init;
     mc->max_cpus = SPIKE_CPUS_MAX;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = TYPE_RISCV_CPU_MAX;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
     mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
-- 
2.53.0


