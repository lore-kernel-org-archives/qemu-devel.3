Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C44C282EC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdTu-0000p8-9l; Tue, 04 Mar 2025 20:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTL-0008Ox-AI
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:57 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTI-0006zm-Ha
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:54 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so4730832f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137770; x=1741742570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stXxHtQ0ysec4RTH3tLbFblvlwVcUcFY/+2ohtZUeAg=;
 b=QlgXeVICKr9WPBfJuln9+cdlJfTLPQdaGOTowahZtbNU5Djyg2hYkHcfnT9oxckMeJ
 9d0vKhQYkv6qHQ4ZJaB+un7/OyVBQ4+XSZWS00KIxjUM2p2kANztSnUOd0x3Z0e0QFE7
 7M15bgk7Uh0qbe3dtlnIrFZ7H4MBvl7FJzi4iu+A70aAmgT5Z6ZEnF0SrwAW+VAt7zO/
 lo1npBcjz3hvfQR/s47LjUiTlNpESckRi63vlh2UC8pzjO6mPQBfOwhuWRqhI5Q6oN3Q
 9+uyukkqlgc0sU53NFWVP1mdMaRUc5chJi4slZE4+bVJEFwY48QXq/AS1UgLIcAKQmQf
 AVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137770; x=1741742570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stXxHtQ0ysec4RTH3tLbFblvlwVcUcFY/+2ohtZUeAg=;
 b=XH1ozMt0DVrDR2oEZLDd8x67Gasxtwb/Fzgb+E8wCbBVfWgtO1wPsoY8COegGd3v6M
 oY5/kiQx0iVE11vcTZG497Smjrl5NahVhX1O532R773X2oCLcRQyT2y3pUyrJKSb8Jau
 MryEh82H3YvSPjmTfCNTdHdJQWyXRfGJd1lVbfyZZ3i3GYRs1+pT17FBhHRcWNNM5U54
 F/8AHRQc4pBs04ygmYtvWA6BfkTGgWMAMZyKic6SYAUMRWl+OwFd2ZbSnQwsKzZ8ONi6
 cqigMGwYgwjhZMH7uvh6iBZv69kFjPx3CJO081WbAVx5Fc46DRxNSl5eRGfJ/yfgR7Hb
 BHug==
X-Gm-Message-State: AOJu0YzeMyssBD+NgodaLCc+cv4qP+LfK7+a7Mr9XPu12XkbKuWMBrxp
 zrH/KTGLFd8xG9Dqso1VJIctlbKk9lH1akk7uoJDeGFRRC4KPvxrVtAsqEN3v9+1YVRdCMPDsz8
 I/w4=
X-Gm-Gg: ASbGncuScK/0JMqYBTDZo5aYDKnk5OdX+nFEBaOGgNAl6D/8ktfKprG5qdzVsMeSzOF
 o9ew/To6NfGogPV5IBR+1wf+o2U0/JpDcrfdkZRiXSkBw/9MPfhZhkaJe3w/FsS3kVhflKjkSV2
 sELXlWixzm2cxk51vxTFZ50Zu17XDQ4jNuN4FAu135fTuAioYa8XkAOHJBnIqOY1Mdk7pHEAuhR
 zhAYN56qk8oaNZd+LfYOhv02u6DouadnoDfcPU70Uach7Pml+pz0uaYTkY+GhwB42RdPDMVhwNO
 s8aTWU0pE9nUo01LoGfyaxmKIJ4c9TSyQ0hyYMyMIggRaES0XbTGeVBTeIh+ohG2nacbkrMRdb8
 uJEz68LQ7LAIal/FhLhs=
X-Google-Smtp-Source: AGHT+IGz19L3Zveyac+y+96ofS6J9afQGtwp7wWdiedlNiSy91Nl8HBB0BZk+QDMwd9rjoXoDre0gg==
X-Received: by 2002:a05:6000:1546:b0:38d:d0ea:b04c with SMTP id
 ffacd0b85a97d-3911f7bb84fmr763818f8f.38.1741137770058; 
 Tue, 04 Mar 2025 17:22:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e479608fsm19575557f8f.14.2025.03.04.17.22.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:22:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 10/41] hw/ppc/spapr: Restrict part of PAGE_INIT hypercall to TCG
Date: Wed,  5 Mar 2025 02:21:25 +0100
Message-ID: <20250305012157.96463-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Restrict the tb_flush() call to TCG. Assert we are using KVM or TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20250127102620.39159-3-philmd@linaro.org>
---
 hw/ppc/spapr_hcall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f8ab7670630..f987ff323f8 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -299,8 +299,10 @@ static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spapr,
     if (flags & (H_ICACHE_SYNCHRONIZE | H_ICACHE_INVALIDATE)) {
         if (kvm_enabled()) {
             kvmppc_icbi_range(cpu, pdst, len);
-        } else {
+        } else if (tcg_enabled()) {
             tb_flush(CPU(cpu));
+        } else {
+            g_assert_not_reached();
         }
     }
 
-- 
2.47.1


