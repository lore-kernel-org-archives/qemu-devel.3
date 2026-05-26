Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BD4CD5BDE
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoXh-0008BN-GH; Tue, 26 May 2026 05:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoXg-0008Au-4U
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:44 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoXe-0000TU-PB
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:43 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso6624734f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779789461; x=1780394261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38NUEgQ0n+CjAx75rAUHYvcnj88xEj14WUJaOeOuOAE=;
 b=vNFLtCz7RL2eMHJ0/ZtYyXyr8vRHkrBoXoComMBwqFAfX6vxpkL+3WyQp7f6WWlYfL
 IobRFSpBc197w7TfcYwRT1MYfsqzRgXB4v8pJz59n+9fRmHcN8IXyblIJbY1AXIAFQD5
 kH2HkuJ7daIJgmgx5gWRHZj45g4HgRi7061wc5xOjmwHPBFDYZGmd1CKY5JE6SfIjlqX
 wQvq97qHf4JU4LWdXg3rIsrO5GRK5pKRsBZxWD/YLfgKKgECTqCqpBaOqVwAGzNsUlR2
 ouDGbnIzSiU30pKZYVS2IZ6slR875SQsqD1J8/YOemUfgfDpArZFvWyjFluDTEwp/0dr
 9Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779789461; x=1780394261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=38NUEgQ0n+CjAx75rAUHYvcnj88xEj14WUJaOeOuOAE=;
 b=OYSi1q6as3bgMWW52+jqB5dOZNy98/vILHf7PTbnSZ7vH4p8ewCu/ORHZNuKnd7NYz
 7VzzETcGkkvDCyKvV2eW0V/tekuAn1u2O09u/nVCLjMkybP6kbCdq6AqNmWG9zhEq2Wf
 q1smEnCuC80L+VVPBA2YLG7ZO4OIMzPB+Jz287Fet1vk46SyLBAlZVrUJgLQxrjgYkf4
 w52Cvg7Su1I+4yTCwxFoW8cpx/Or+oSzbyxUuOO9/bgKhiMu4U/kvSZdYoy9EV3SeLPD
 IknBYtDlxnFEopyTXkALPP7FMEvIQinccFSxQurD5VXWPp9MPkhZ1/cn0u1ll3nwyzGC
 V18Q==
X-Gm-Message-State: AOJu0YzGNDtDNRtim4FJBwQQky6rcRik2KOcyhdJ6BsJWpZkTXUZJCBF
 MD6AR/BUv9EOjZ/4CoI6xp1BzfzK9b8O/YC934NMCfR7CpAYgfm5WOda4lWnvnpwZmo2/QhmKFh
 i5JoXUG/FQA==
X-Gm-Gg: Acq92OGtmJ+MlXrsuUBa82CqUC6VHK+dmDe1J7ZAnLSYf+SkKIvGO/5+XeUd7046kkF
 xq7uY1K1JtZprnGwqktQn9OF32t9cHrtbya55/Vs121EoKFOF9kDfqKj/h7YQD1AiYaKSLDSnVh
 MDXEvA70PD5A1NIRgp+HSisEA8Xl5JKhX+pTJYkwNyk3snhFv309bpEvZVyScz7qpAYnKhYPBpa
 iwoTMBVOUel5j6inQ7vqkqIHMQXyTfXD+hJYG3MGYwQPZj1xNowltcu+a6J7IlzW1yLhIOkbbDJ
 WzYUSy7xbWC2oSv0EeXPS2/6oNGcs7X1PjI6cqh/XdLpwcPTVLK/Bsiez5l3+CpdAIfiqTJTXdc
 JKNQKEBCNMhQWjr4DBTJH1XHdYwyMeztJ8DGu+FAx2MHcpP1ONQhtxNgIEObSvsuAGk0SUI4omu
 YXGQMI46q6W/OxyrZDOdy+1rmUOa7tIYRHp1g0u4PclAvEsRINK4TYJ2ntysHg2axskA==
X-Received: by 2002:a5d:64e4:0:b0:45e:779a:302c with SMTP id
 ffacd0b85a97d-45eb38d297amr31731533f8f.29.1779789461059; 
 Tue, 26 May 2026 02:57:41 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d49132sm34282087f8f.24.2026.05.26.02.57.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 02:57:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/4] hw/riscv/spike: Use 'max' CPU type by default
Date: Tue, 26 May 2026 11:57:28 +0200
Message-ID: <20260526095731.63525-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526095731.63525-1-philmd@linaro.org>
References: <20260526095731.63525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
---
 hw/riscv/spike.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 87fe0f242f5..08eb7edb92f 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -341,7 +341,7 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
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


