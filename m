Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526CCEF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmEo-0007FF-WA; Wed, 04 Mar 2026 08:26:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEX-0006nJ-2q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:50 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmES-000255-An
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:48 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-827307b12dfso3648825b3a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772630741; x=1773235541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xoVHZMGwIHVc1AAyHkV4+1c3n8WPRC9rpBOR+WC3rg=;
 b=CYG4ZVXpef502fTd3B0HhDv1WmuhD/2FQjibylydCw903NVul2F71wn6J5Qf0JmksB
 i9r+u+V7Zw+4gkiFq8l9FN+yvoFaQVQicMy+QcN/TZuAdtb4cN3PRxizMLUz682vNXKe
 YMyGcY5B6p8LvxDispZkYCiBJG1j79fjileRcKzTGO3ANqckATXaZQvc7dZ4zpONx4Ua
 XVn90ZI7RzOORYgKiJ/TG7sH5HhgZKI0rADLWpbC/WrgQVwR1T/CKSqwRpo/1ka8o3lg
 jC15XaC7hU6jK8f1CPOvxVnbMfy3Bcn7vhbBQaPBwgFxHG/rism6wrpCpI4LMbVUfJ1a
 fd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630741; x=1773235541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1xoVHZMGwIHVc1AAyHkV4+1c3n8WPRC9rpBOR+WC3rg=;
 b=tRPYXkpDAAaGDJ7jGARdBr0ZiQF71siVGA+9CpPJce1eCikfTNbx7VtQwa7CI2pjSD
 tGdrNhbx85YARFzRsXFfiDvWabSiPfb12vBvVXCGR3pncsfO8s3knvApSI8qt5H7YaEi
 6Ap2NyGQc/Zxl683O4DMtxo2YMEL4RcTMvu4+vIOtal/ehGukTFYmP5+1EUhrGTCdCwX
 j0Q9lmIbqpDEwnpXITdHJBA1xKLapDKIZO2KKOBTTMdGplzCxTeoebr57Tbd16pP+KIp
 miJynnl9Ji+BS/TDRCKNf25mEimu+kRTLevojOIgWPsM4lE0xfgIPKX65D0NWqwFqTR1
 kGPQ==
X-Gm-Message-State: AOJu0YxteBJ/Ae33v7USjQ/S9d4/i5po6PZgW7/HtmWTMnF2AkTpeIkN
 47/KQfmDPr3DvJOeInGlcO3ExW0jjXHVK5SUpGTc3Z77MwBwWgxpcH5NomnHGqYof+9I/PKjQ5x
 1uCiV9EB7SYqrd0J4OydgkfMLrl1y3bGMp+kZBpTurIB8GO8W1ATtJuLQOtgbQGz57JRPQ5hKWQ
 7H9MQywfa0c9fFGhwvqUe9I7v37WxZPRHuKXjugId50Q==
X-Gm-Gg: ATEYQzyq1+SVRcvNf0+inLUTwbqF2tXIsjC0RS3V6VkuT/0a3KnMquKY+iO0iNUzcY8
 lw1Qu8edshCPvc+uzFl51uO+uOCeix6m86PcFs75Ymhy5ET7p229rCyN9vg/EpbSwQIEAfPW9Os
 kqw1BlBlx0vD1Af3FGJulfCEUjeDyw9bzItsivuYEK5gvL3L0PIJHEMn/30YCkdf3CS3yS2Iy+v
 2j895iOrxQGIk6KV8rVHxduuz+ACO5fRx8FLy9azznpOTJAVmqPGSpuipg5LFy3x53VLthRDsYR
 VDOcgpW4SegGRD7ahAb736wRbp+DGm11mP/s/c6sh+nCwxr9XOJ+ObQgDncgQ2yDcdrbdKORSTZ
 pIpsUGyhpmVRNN7FhG2NiNbqQ9siE59Y4JAE3Zx+JCBmCLBvdd5hgcWenf2mkTZpEq7Cu8yMyZN
 xLQRVSlLw/4UyU85oj6ORCSSleza9g/YGK/TmFxd5Il/cyMTBV1G0quAyHsNstCftNQKVbVCVkz
 kCSBdYClZVi3dm93l5gBpk6DlA=
X-Received: by 2002:a05:6a00:9083:b0:824:3ef6:a815 with SMTP id
 d2e1a72fcca58-8295d87b143mr5519962b3a.8.1772630740504; 
 Wed, 04 Mar 2026 05:25:40 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db1d6dsm16968505b3a.26.2026.03.04.05.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:25:40 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 9/9] target/riscv: Expose Zvfbfa extension as an
 experimental cpu property
Date: Wed,  4 Mar 2026 21:25:13 +0800
Message-ID: <20260304132514.2889449-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304132514.2889449-1-max.chou@sifive.com>
References: <20260304132514.2889449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 376517755e..73cfcbdf6f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1379,6 +1379,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
+    MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
 
     { },
 };
-- 
2.52.0


