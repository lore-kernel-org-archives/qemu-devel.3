Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43300CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfEs-0004mA-0X; Mon, 08 Jun 2026 15:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWfEY-0004PB-LF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:02:03 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWfEW-00073Q-7k
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:02:02 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bf36a6905cso32547865ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780945319; x=1781550119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JnkKp8lNNdjWP1yeW9fTNHFX59ngT8FyvaClJL1DmMw=;
 b=VvzDhV3OoanO1CmEgdf4xYtPHQu3pYeK/eKIra6JJ2ln6mtUW0Y3C0H2kXya3QYFEH
 3+uC5QWvGQURcfwGtavVjiMtbOm64dxh5j6akP9P3XlA1JCynWq/jBQYasK4UPaFtQlq
 vN2iw2NKFuT9xVbLrWgZgBJypYIoH9tFpNx3OiOY3e8fJsbSzEMBEO1kRGz6hzRgthAg
 NTxQlltjhuLD3Rq5vDtBd5L7+bwQe7mRDDZTTH19Tu+ICQtXvLZVWR42iaWD43duXhww
 Tywtf0Q64gpVwpo8w7TJ2BijpuVWkw4JAvB66+Utsyv5Be2jrPRQN/CjcpxpwlHcG3Mg
 j4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945319; x=1781550119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JnkKp8lNNdjWP1yeW9fTNHFX59ngT8FyvaClJL1DmMw=;
 b=ZrdyWJrPIIWnkCCRRqpXz94LdL1rD3GXZxpmMJQVeARvl4slbIpmAJ0sIMZ5wMkGQb
 zJG673DpYCqko3zNS5dgN7xegqTRrV04qybypBVeyLOKBIcjUbjbgJ2+OY2l9zgdd06W
 LrjYqKrBAUi7VqnPmclhw3zSZLbZyz9kWBbpNzcUGYh/nHb/MserVaJEOlmknBY7KNej
 k7AncWd/NJuK2nOi6Hr1gXpoTRTIUt/UFjSktlFBkSzUdJe3ZDPSju8ondnsyWplw4NO
 m9cFwlO3WX3KMDqL10pZEH6cmuZMFP5vWTpX72wDZ4h9pLs0PjV6WDin7TA6FTzLvNuE
 vKUA==
X-Gm-Message-State: AOJu0YyfyrmJb8uZMtvwAN6shgSEt3zqxS5l5isqBYpgF984MpcPl+dH
 yRUb0EixMsv5qx5+HAQ82fP6DXO5tPVbCJVDjkGJZoRJFEODBeFcVTXE63dDOpy80UR+Rqhl889
 BPGq0uCc=
X-Gm-Gg: Acq92OHvjkfKEmk67HI2DWLtwDH1L0Pwo4xCnOGeEt1n+WNWqBd1H62zqfryiU4NYc1
 VYLvchlqH7oNq2JBpl0tNpPLiDvhZM6MM24ziJsMvwUlRHp/AZacl4ELQPG8rgwuPtTV8VIshoo
 l89lMiabac5zyINNwwPPev+3gz8NVC2GR2P2CZW4FSKvjDNUhpv4hnX02vL7WdoAUxBNUYJSp/1
 oMlNyM/bbIwBHnwP2/85AtNnMtEt+jcnlP9o8XhlTFqFq+o0XeSOY7YX6YxKZ3lgcnnG2n2ZNzE
 Q/tT2+yAp0KwrjU5LbTlXdKTdX3HV13zNqohxZkkyrbFo992zXcG58lLYGNghxW8/oS8+sb5Xif
 xfn+6aKyCOWa2FHHqKS1xzng0zn3WcPmoVCmzCYtw5IVdOK+wwez0AzW20/mQ/Q7OVk+epo0SAW
 ObwnDKbi4nSl3Qrez/bojP6DjsY68FQiWZ+M08wDWbtVqe0zETUQ==
X-Received: by 2002:a17:903:fad:b0:2bf:128d:f7ff with SMTP id
 d9443c01a7336-2c1e7e88263mr190940165ad.16.1780945318765; 
 Mon, 08 Jun 2026 12:01:58 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c24edbb49bsm60900875ad.38.2026.06.08.12.01.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:01:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] fpu: Handle all rounding modes in
 partsN_round_to_int_normal
Date: Mon,  8 Jun 2026 12:01:55 -0700
Message-ID: <20260608190155.637067-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608190155.637067-1-richard.henderson@linaro.org>
References: <20260608190155.637067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Missed float_round_nearest_even_max and float_round_to_odd_inf
in both switch statements.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index c86fc9ccc5..deb712e092 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1127,6 +1127,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         /* All fractional */
         switch (rmode) {
         case float_round_nearest_even:
+        case float_round_nearest_even_max:
             one = false;
             if (a->exp == -1) {
                 FloatPartsN tmp;
@@ -1149,6 +1150,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
             one = a->sign;
             break;
         case float_round_to_odd:
+        case float_round_to_odd_inf:
             one = true;
             break;
         default:
@@ -1195,6 +1197,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
 
     switch (rmode) {
     case float_round_nearest_even:
+    case float_round_nearest_even_max:
         inc = ((a->frac_lo & rnd_even_mask) != frac_lsbm1 ? frac_lsbm1 : 0);
         break;
     case float_round_ties_away:
@@ -1210,6 +1213,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         inc = a->sign ? rnd_mask : 0;
         break;
     case float_round_to_odd:
+    case float_round_to_odd_inf:
         inc = a->frac_lo & frac_lsb ? 0 : rnd_mask;
         break;
     default:
-- 
2.43.0


