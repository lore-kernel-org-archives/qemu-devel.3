Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC83CD98D0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXPlr-0005nu-Vm; Wed, 10 Jun 2026 16:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPlp-0005lW-Ka
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXPln-0003lq-HA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 16:43:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so92154985e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781124205; x=1781729005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwHZ9gYg6F3c24UR8lvzGRrX0K3Wt5/wFulUFwGmu88=;
 b=BNsUMKfURb/TAYuStHJC6WuukS50fbcFkd/A5bVMlaXoUIjgSbIhbzt3GutJqrj311
 NvMFudtR0SiuOqTm5dLVdC7jclcHyj+ejjA4bu8t+bl+LIlB0lmcajA0Sn2EmkHSaLbN
 /8opj/6RyPo9bHo41EP1HrRcA8iZc+JISSaqednEw/MG4GAE4jQhQYPapHKrcBP/yua8
 DqCH7Q3LTyPySJeNoF9UqFF7DB9VS4FVflMv6zWhgBfLERXzlVSxOBSSLXCWv+GplCJp
 maICIBZiRX8BSp3QHwZofYnvYPUMQhnIBzFNV+RRIjOENUXiHZtD8lL+M3qHyO1pHR6K
 lO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124205; x=1781729005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hwHZ9gYg6F3c24UR8lvzGRrX0K3Wt5/wFulUFwGmu88=;
 b=nZBza6J2cDbg/TkKQ84f3hefAfWnEjic17zky40FMeTXYSkpfE21bZzY3CZrJxseOO
 qU6onVhe6w1VvcyJL2yz8wb5FsUTJsBfEPEwlOlzoE4+eHGJIH3yMuZdnuxG19uLpi9q
 8ISz/+qwUUWDohFqKzddRcP6qKc2rdRtm9wCWoiTIUjkHc0D1jqJsT93Z9lSZnj8zUD+
 3FFAO0bHLfQD8ZM2O+5o3CIpt5Xg/ZaRmqCej2hc3lTgyWLiZfsPbXelSnmEH+FlyKBN
 l5UwUxqgR7KLbPkjlktaG6BrR/OH/ANW8xzCl8WEUsvnhxzmkxqhtfFXJqv8FN4YQaqU
 yDgg==
X-Gm-Message-State: AOJu0YxoiI1YwnxOTGVOpdtLpn4fIZVbTtiz5UGomAzh1Ti0vuH34NH8
 8BdzTmpeKFLYLvre7g6BAnHJYlRVf1I7idZoRZoBSoEMS3np3xx0hVbyQ0a1n5+9wbQ=
X-Gm-Gg: Acq92OEXrHpE3AVd2QTKngJd0pz7GGjYOwwZYHGlOMfOSMnvRj8SCSdBQN/OImpbaC2
 wSPTc2+nhaDl/iRoBygTDFBqV+dCKETFKb7IhVRjaxZ5KZXovQXIOh209pTnUbXhlqrf6n7K1SS
 IWI2uzVCiC2fnkE+//qjo1Lzae8d7DdUE6fpqFkCE+7eQE/t5U9WBQ7c1DO5Q8NDW34U/Umm2An
 cNxNymqQl+wIiU440I0yk5AUqvyk+TjgR50pBRL0zcQlVd5KU1RzxkekWGSum6gd9PaAHkyfimo
 ekwL7LIHXIvPlNXVChaIWpltR8jVqFXTv5CV4YddGdFaPN34ev/s8eaWSb6gW8mhx5325kdpl3C
 FKZydqnFvGitwq64wUrxT7ukBp8KKtxljOeborRU9KffwXuQ0E32RIK7w4QBMIYqJDPE11WiJLq
 tK/7WEj01YnIy6JwnU7nuv17gyQfmvSxtNvQ==
X-Received: by 2002:a05:600c:8486:b0:490:e196:6574 with SMTP id
 5b1f17b1804b1-490e196664fmr34202005e9.13.1781124205618; 
 Wed, 10 Jun 2026 13:43:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490dc47d4e0sm92781315e9.0.2026.06.10.13.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 22D7A5FA2F;
 Wed, 10 Jun 2026 21:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/6] target/arm: split evaluation of CNTHCTL timer IRQ masks
Date: Wed, 10 Jun 2026 21:43:17 +0100
Message-ID: <20260610204322.828645-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260610204322.828645-1-alex.bennee@linaro.org>
References: <20260610204322.828645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Whether the physical and virtual timer IRQs are masked are independent
of each other so the checking of CNTHCTL:CNTPMASK shouldn't depend of
not changing CNTVMASK.

While unlikely to be seen in real life we should still make sure we
behave correctly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9dd8fdfa41b..f4aae0a4072 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1802,7 +1802,8 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     if ((oldval ^ value) & R_CNTHCTL_CNTVMASK_MASK) {
         gt_update_irq(cpu, GTIMER_VIRT);
-    } else if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
+    }
+    if ((oldval ^ value) & R_CNTHCTL_CNTPMASK_MASK) {
         gt_update_irq(cpu, GTIMER_PHYS);
     }
 }
-- 
2.47.3


