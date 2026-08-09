Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C149BC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBF-0005u3-Ha; Sun, 09 Aug 2026 18:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBC-0005qc-Cp
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:42 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBA-00082Z-L7
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:42 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so1140527a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315179; x=1786919979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T1H7VF/d42IFKoSTDJ1NFiOykSCIxfrWxgFii+Z0hmw=;
 b=RK6iD846Q6jU6tLWfW+EpAntnNCcmlr/QSTfdZd+xSTIR66I8Toqvitv6AMtGCsMpj
 ovG/6qD985kERxxtC3Kog+STfk0IHrN+6g+s8YPAt1F7GDcIpXjKj6jZ6u6eeMeOFn/K
 OePP4rBMhdW8dwxS+qEzmfj3x776vfXjF+btCCI8c3rjXVoE3ugQ3FRSOvlxwoo0jSa3
 i7PYtAgZZgM/hHdTpVSr2BPn1xwfPrSNdJHjjtPjC/qUsg1TI9x8+92SEeieOm3SlyQ4
 YJ5eH7s0TavTsmjUEAL9Lq6vevXYBi9ilDXZ0nBzFfrPBj0RrBoF1q+8Bw5+Z76ipkj9
 7Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315179; x=1786919979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T1H7VF/d42IFKoSTDJ1NFiOykSCIxfrWxgFii+Z0hmw=;
 b=mX3Q8kIAirWDJzoUAeJqTmWSkbBpbeX5KTjnNBuHeyITfsqBaISlxFGEfrglhdm8/H
 knjbMknL5YseFgUVN12/BCDGYTxgdBJcHMvYrBsrmcXj9b6U8IPInry7WfMgwZTWsU1b
 XzNoFXbwAaAoRIpka5Lm1TU5mTKhDkb2Q60TPJu8hblPa6ujDbYwmgfyDuwslkzAfbCo
 l67h0FKbeXQ3XkOK3KdslfAZectiUqwkTg3K2A33yUzJuNqDX3gTNbpUmPbQuMsBq2yK
 u4FDwdUcCmeRmzTPtEWUJx6gQHPu9SXXECUZSf1/PzdZ6GQlQFWj1SxLQBh10Ugkjy1Y
 Q7VQ==
X-Gm-Message-State: AOJu0YwU0te/jUDTZf7kp+ynjUk577FBnabuRkTCoOdcmVWdKha73XL9
 h4PfX1QKFWPvfigrHn/M8lLg3SqOy+otW1dUhCknYRhdme8VF/mceX+T1xAuqGsdazIwn/Ppd37
 eY48S
X-Gm-Gg: AR+sD10nRQJPyJUJPWm1oOVD9wKkNYDu+0oY7GdtjRNv/sjYHYLFehWi79buNzYa8X1
 o0UddgiRUXfqdzsbZrvwfLvYOEDXcOBCg8TrmTfFGHJJ9dg1xiWALkuCJFVOFHHeTm5fWP84AUN
 NN5Fw8dds6DBvWkxDu+X6/GUAsb/YsyA6syNXT9YMlptGiV/Gm6YinxqF3m0PsRTmXOaE3+WqOw
 Bx0Y908OMA1nNVK9d6M9JuTbSHUg7VgIqOkeK6BO78RaXnOxJyvDNYLVjgMS7AdkOPv9Jq2eu4X
 jqsU95kejQ2SnygT4SgT6AT+Ub3me1CZSXbqb0NHQ4iqGdD1JcjBHolijWg4Bh2Lmpjm0V3E6d5
 NwVtT6uLvmiPnIQHAAQVv9wYrMqabPdHrSk5ycIuNr3IERmlalE52w0FSaIW2CYLcHCv4CJkzwE
 aA/HQ/KzrDGV+mAJHWOZTPm0bv5UCYP92tfybeW2JbF++R2Ilx3AbQoYUGAIAnKSss+hxDxVl0m
 e7guF9AqutFgh5qan6G
X-Received: by 2002:a17:90b:2d84:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-3903c58ece8mr38289616a91.12.1786315179095; 
 Sun, 09 Aug 2026 15:39:39 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH 43/56] disas/riscv: Fix isa decoding of rev8
Date: Sun,  9 Aug 2026 15:35:32 -0700
Message-ID: <20260809223545.730664-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

The encoding of rev8 is different for rv32 and rv64.

Cc: qemu-stable@nongnu.org
Fixes: 02c1b569a15 ("disas/riscv: Add Zb[abcs] instructions")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 9442a6c115..4141741d79 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3292,8 +3292,16 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 0b01100: op = rv_op_rori; break;
                 case 0b01101:
                     switch ((inst >> 20) & 0b1111111) {
-                    case 0b0011000: op = rv_op_rev8; break;
-                    case 0b0111000: op = rv_op_rev8; break;
+                    case 0b0011000:
+                        if (isa == rv32) {
+                            op = rv_op_rev8;
+                        }
+                        break;
+                    case 0b0111000:
+                        if (isa == rv64) {
+                            op = rv_op_rev8;
+                        }
+                        break;
                     case 0b0000111: op = rv_op_brev8; break;
                     }
                     break;
-- 
2.43.0


