Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341DDC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQT-00008P-IZ; Tue, 22 Apr 2025 15:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOq-00054H-RU
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:29 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOm-00071K-Vv
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:19 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22423adf751so57467295ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350515; x=1745955315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V36uY+E2YpMl5Y6J3G48zQLEZwrQ3yY8b7UF9x5stjE=;
 b=KpSd0+MH12cf7UGQM+1oNWJxv1ZR7wkCD4e+88pglb5h/3p0fZPy4dL3bggorAyQH0
 bxxsCd5s2gnr1GAXlj7T4HIVAi0u8ZbEbEGnppC+vJ2y8GIKroT3UivxDrYABk7cgfXF
 kjlrU+o0PKC1lJoWacENSK30s7oAmwc67AsfG/YUxM1XXlh+OqVUzPyQ1/6wq1+z2NRJ
 U9OFKvj23RhPeOVWeckf2+zxvwZtWaQ0MgqkynmCoPT5Sv6iAS2oukCnVqdPkXZRyG3Z
 nalygDdhY2ZMsjELRjfHjb+swHRGK3dQohzohr+ovFerHuUisWEjIwproK3oGgGN1Cpv
 T1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350515; x=1745955315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V36uY+E2YpMl5Y6J3G48zQLEZwrQ3yY8b7UF9x5stjE=;
 b=MdRX/4wAK2mT2ayaG7IDSWm1bs9F9TjGaaiDEJSh+q2/ZZMRVKjxlsHGdhzW926wTu
 XIZjF7RohdaY3WU9OBEkpgLhJUqtLJ0onRvRfJyOp3bn68C8/Reyz0Lp6yiNlgfixBMU
 2rtwBrcRdp9wpTPBpanX7OR1NdPL5AKVJAFHxbhzX/BwhjAiIwE5xMmEMB6hgO7SK1Tk
 SA3xdiPx32tf2+fPNp43DwEip5gxV6QJtsVk/5DhItqzdM5WiofWKy5zV42CqkSVEbJA
 tZ9tew01kpaJL49TYDQMa8wjLjaALazea377z2FsBLOqmYz77aQST9fs1quD9tsk3Anv
 +UHQ==
X-Gm-Message-State: AOJu0YxG4LbWY1doHlDg5kRqsCkZOzZyU6Xp9RCFGAeZlib0cfWvy0di
 6tHNI36XNm7r/AxqK28zhLqzQ/nmwB6FE9zUnRI4nKvAYyOnkgDLlWZx2Fdo94+pFVEcZr4mkGe
 f
X-Gm-Gg: ASbGnct1CKje5UwLPmOjs2FgOokfG8ERUd/8XMNUdnKTVPVCe1TG6GIpoBr7yrMVRph
 anbVmMVuPnOd6QiWbdlcXs3gK2OU20zivQH3aF0GvgKYY/Uh1OfhNz2UO0na4ZlqULgo2Dd55KU
 VWkyf+tWCOaQP6TuGXTrTwo2jlm10RJyyYRy/2e1LN015Kq2sibMD2bLdxuc79S+AHOjqLlWtFd
 Uqz6055XJz1+y9cziJsQNx4eQS5ED5zSV/5gdMao+3Lv0L7MvsF3ZVVglMsku4jqNnZf68XMiRo
 Uw+TjnEbgiGwMBlWJj+9bY42VJ5qfdDuHm3GAwkMKhZK+aBzvizPIS/47qmu6NaFzTcMAZKwlxY
 =
X-Google-Smtp-Source: AGHT+IGl1TlVX6VNck+BrrFiamT0CoeS/DZUohwA5mRsl33ZvVsWPETGWwCa+z38XJwwYdskxKyR5Q==
X-Received: by 2002:a17:903:947:b0:223:517c:bfa1 with SMTP id
 d9443c01a7336-22c5360c7admr276930125ad.38.1745350515315; 
 Tue, 22 Apr 2025 12:35:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 083/147] target/microblaze: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:12 -0700
Message-ID: <20250422192819.302784-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-13-philmd@linaro.org>
---
 target/microblaze/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f3bebea856..88baeb6807 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -431,6 +431,7 @@ static const TCGCPUOps mb_tcg_ops = {
     .translate_code = mb_translate_code,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
+    .mmu_index = mb_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
@@ -455,7 +456,6 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
-    cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
     cc->get_pc = mb_cpu_get_pc;
-- 
2.43.0


