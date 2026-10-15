Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3A7CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtS-0003rM-6A; Thu, 15 Oct 2026 14:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtL-0003pJ-F3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:23 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtJ-00012L-Ta
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48b0d19cf7eso176312f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087760; x=1792692560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QlAdzDRH4L9j8iLxK2DOsfuLtCkW5/Q+25BJ+uoOAqw=;
 b=QAkNRMg+IV5MIS6c0sLN8IVqyjTLAMRHR56d3V2m+jEnPkbI2vJjto+NOlOQzK+U7t
 iK5H6Rfy344po282FVtKtWxE+bTFqp59aB2TrkDHUP7kpGl4GRxMRplJd8tSfdIXv5bT
 I3PdwFa/1Gw5A8690Jrh2bPXPmLj5iDK8lAkv9ANb5QhIygqWOMWpUq3UetlC9AgA3Bd
 GeHvTZ4PqOgzRhZfqLMZqQoX9BrzW1n4Q/ssunULwm9Er/UgDWvWBsdMBWCCDn81fsnQ
 YyWVY9AYf+qBLJB0BvxluIBK+CzAWGnWN68SA8KZ4DuQEQExE/l0Sm1gmHdgGsfG22SG
 7ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087760; x=1792692560;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QlAdzDRH4L9j8iLxK2DOsfuLtCkW5/Q+25BJ+uoOAqw=;
 b=EebORdOdQN1500hnKBIXAy5qQCpg7msXW9WK70P/uYyU8f/6HEVNyyceCL0hblv9e0
 pU/1MQ/vCGRMpjdPYaRfuH/NM9ypEVEATy/iZFJBZy3ujv5td+NO+3DrY0wZIQ453w3w
 6qhzpf2tHU62N0mlZvMCzxTyGPs7NZiUxT7uqivSZqXsMT8ZAhIDNW/h6iCV3Qqviq6J
 ZeYGyKIFmxe8/i6P7aWpYOBrLdMrQHGUl+VhrLWCdE1r3m/3nP0qKh2K9KDwUEAbgAPE
 sw/MCcAcM5pVT3HAF8loiBzS402uD/rWG1jOWixderdshkv7NlfCFpOAOAnJiEs4liAu
 5ZuA==
X-Gm-Message-State: AFq9FYK8fqeeBxrJuqy5rP3ZmQ3eyljNIr8caZ90OcnHqRntgyoH3oQT
 pPB+hA6uGPCjyG0n4mZNV5jBwUbMoeu/bYZce+9qUwNBaSxZJDeSpcUQaRc5RkdNijpyG+uNpFn
 RY7IdMTg=
X-Gm-Gg: AYBFou1is9mvZEF4lcwJa1Xf6LtM4FDsY9TVlsDlkNEsdeBDnvPjBYMuxOHFQfbzJAo
 4mlMYxeuPLVnRtRW9Ick+GNDSCkMmBJKE2+kK/fmkxnFef85h6lxlMn/L/eaTz9x7ffFI2biMJC
 OSklD/+EEPSIVSMVwrq1ESw6r5U+8G4O0J3suj1gj+a0OKUWNn+PUXH3X8OVSnbMpYEicw8c4fD
 Bd5HR8WyKXI7QV1tzmbgcIlmRhxJmW2foUbEFmPW8M6P21Ki3cBy319zB+7rd7pvW1rEK24CDbP
 JosN1GMULhEEWtt1lGNVxlyV6XLcKyM+EDrsxulCYDkaIIf6ozvDfuJBJqtB5B0R1SKy8CeOUaU
 4w/y7H8VwUpm46IjFCNtd3yaJsAhvnc6gR0NxiTZXoe+Vm3XqIRh9HzkIX+eviCrXcsutly3gJL
 IUhrAXQ5DvkDZeZunpIcARVaNBE0G6WlmXlIw9nXnQmh4UNh1OyVECtN7ie6r9lb4Cdq0sx10ww
 Pvu/JlT5iL9dLq6DNFSJaXfwRSY6Mw0ghbc+Lw/hyiNm2uGP2t8BOQrxItqCSItl30CBXVMdBJY
 p28=
X-Received: by 2002:a5d:56ce:0:b0:48d:faa4:af9a with SMTP id
 ffacd0b85a97d-48dfadfab3bmr1736737f8f.9.1792087759813; 
 Thu, 15 Oct 2026 11:09:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/16] hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual
 value, not 0
Date: Thu, 15 Oct 2026 19:08:57 +0100
Message-ID: <20261015180858.1863407-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

IN the code for handling reads of IRS_IDR0, we carefully construct
the correct value starting with cs->irs_idr0 and adjusting it.
However, we never actually write the final value into *data, so
the guest will always see zero.

We didn't notice this before, because Linux happens to not care
about this register value except to check for the presence of
virtualization.

Cc: qemu-stable@nongnu.org
Fixes: 405ad2e76f13254 ("hw/intc/arm_gicv5: Implement IRS ID regs")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20261008092327.4036856-1-peter.maydell@linaro.org
---
 hw/intc/arm_gicv5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 08878193dfc..ebfb0878af3 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1433,6 +1433,7 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             /* ...which means VIRT_ONE_N is also RES0 */
             v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
         }
+        *data = v;
         return true;
 
     case A_IRS_IDR1:
-- 
2.43.0


