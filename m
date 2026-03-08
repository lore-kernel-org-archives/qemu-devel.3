Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F6DEA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMl6-0008St-Lw; Sun, 08 Mar 2026 18:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMl2-0008IG-RB
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMl0-0003ZS-P7
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so6649322f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009473; x=1773614273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M77BldNhBLWDAqoR5Ls4NYc5x77VJRLwJ22XVsrrWUA=;
 b=HmXYIYrGSHbyGoh3i2b68BksumpYNVC5LdMkKWsN2zka3wZbtSIdUoLLEyZw/jXhjA
 hXweMrQWwZpFadlruGI/bRo5aSec+IuRoGEqey7Rz9kUDR9BTHJPuoFUrbAtWzySYRqT
 olRrwpSSb3uVOU5Ql4CRKPS9HIWuAm8rUvGCjPBXXZAIbYGx9WQ1DfCkwHHe8t0U2sg5
 4BSevY730UI0J1GQm/wCV0eW8vtbbGNktSk3T7LfyIHLcVlKGogrq/OtC49SMGazUqXl
 8eIkFZW/8LFj5uaQfm5qga0unp1fOLKMF33ilkuEYmYzSfpIn8DtX9O5+61EcrIxylc+
 dtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009473; x=1773614273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M77BldNhBLWDAqoR5Ls4NYc5x77VJRLwJ22XVsrrWUA=;
 b=VxJsvvFhUSg9Hb/SfVjZmQpqzf1qtlRW4qB9MN2VYIVqwr1rxViKnP7VWq0CXzIbMA
 3rjbiEhrxDWDYyWXzn6Q3ekIK8eOVit0nD0QBKzMVvjG86/DQTBubF+7eEF7PiV5ZAGm
 gPTOhph6iIg80TTZB1gfO/wBd06qMIaJ0aG4VF5OSa3c3EUjkV+mFkMl40xbFblQsbhA
 J8AnRMm+vWcJJ9ZIpAf0Tx5g1HKBvX9kORA2ACRvdNk/r00D7Q/3jD9ejFQK1mx6GZo7
 GByUu/OYfjjeidYqcrjEWM8zJHaUpfSv1mfYKcg7pHt+2UGznleOwAZ4e9d1R0Fj7lYj
 +8ig==
X-Gm-Message-State: AOJu0YwvQvUqgT9rltwa8JAJcEqChDmjNisnRQZNwFonC6R3erm6QaYz
 jOIa2iF0ZG8eRKtJbG/oAEe/I7pve656xzu9DRslbnuSOiUIqh9D+IMxIHHc0D1EmEEJl0C4r6U
 dpmLCwMY=
X-Gm-Gg: ATEYQzwEuRNByi447zEQVnt1ckCr8b/sxH16kz3MR/lNpmBSmyDx5UkEjBPj+R6LTHI
 H/Iis2pISE2D/jv7EyX8B9WhnnuH7mGV3vGbys8+VG1+zrxbf68b+ujFV6qPSnO6f7gzktS2Len
 /VzXRWfq6uRlgMs8MWM52YikdSakeXc9uavm3yDYsT/zTVm/JpNku6PWurVzgblzPsmii8rmxF7
 +egAe9+xAxuIvENI53MIATvSEDBKzxldra+eXQdAdMr1dQGWTNoAT1fWVsSgZdh1OZa/gol6z0x
 mOUVJrXF2ZSsiZKtlYuILAnrldnv2giOwbM+f/Omffqu8/eByDagdCLh5zCUiDWXj4QNGStLJr7
 sU3NwJxrjotvDO9H7KIBOGAidTOTH1eWbpE/hxO+xLPl9SpSm1fs1nTVkL1u2N3AHG/nKs/ZVjV
 0nve9HqzxG7c+JKzYXr3ItvT4alAxdHtdvrFsQeTgpwHIfk6m6EW4BGhuuXl5BrED7mm204X9LP
 PO2biToPsOr3AfB
X-Received: by 2002:adf:ffc9:0:b0:439:df0b:2885 with SMTP id
 ffacd0b85a97d-439df0b28e1mr7445746f8f.58.1773009472790; 
 Sun, 08 Mar 2026 15:37:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad1cb7csm21421438f8f.0.2026.03.08.15.37.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:37:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/49] hw/net/xilinx_axienet: Prevent writes to PHY
 Identification registers
Date: Sun,  8 Mar 2026 23:34:13 +0100
Message-ID: <20260308223433.25503-30-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

There are other registers in the PHY model which should be partially or
entirely read-only, but this solves the immediate issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3297

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20260305-xilinx-phy-protection-v1-1-ffc9edd84e58@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_axienet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index d85f8bb23fe..970732b162b 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -141,6 +141,10 @@ tdk_write(struct PHY *phy, unsigned int req, unsigned int data)
     regnum = req & 0x1f;
     DPHY(qemu_log("%s reg[%d] = %x\n", __func__, regnum, data));
     switch (regnum) {
+        case 2:
+        case 3:
+            /* Writes to PHY Identification registers are disallowed */
+            break;
         default:
             phy->regs[regnum] = data;
             break;
-- 
2.53.0


