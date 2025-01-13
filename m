Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221E1C02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKtk-0005ZA-9c; Mon, 13 Jan 2025 08:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtV-0005Xd-AU
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtR-0007eI-T1
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:15 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361f796586so44620625e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776451; x=1737381251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6HdlJP/oiGVeqg3ZfL2mL0VTspYLYi3EUJzilx+oDbA=;
 b=H71Rx1zBpsW/rJ4hb9u2EylLBlNZFpglbLTso+jIcI4uh7V9ARrDrbdIehdO/y7CAY
 ahd1jHDNY9kcw5yN7cN044DQvsCCgHnK1Z+OpcljKfA+mRP+kua1EThX5lx+85XG10Ag
 c38bLayAFoopPBSVlqJ0k00J95wHJfAULJjsC/jaesYnfgAz2IwiylV+rNnBSj+T/MSm
 ePCuTlg1AXd3xbHbrhIB0vpnRk9FERvKM2xW3W2tfFn44fToUBWXjUi3ZQF6e0tKCkxC
 +lzuPrsQI5TXdPiPTGrfIsdZaTw77hsGFasBoDQlBsunUwdAllsfWlRlqBO5UVCzpcer
 PQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776451; x=1737381251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HdlJP/oiGVeqg3ZfL2mL0VTspYLYi3EUJzilx+oDbA=;
 b=qyzHn8VbvbD94UWIn58zI3KgZdMEIVD3/KbyNkFmXCHDIGabu9SYtFV0/R7icLPeNE
 zwlqFkGKXdiVEUoLnb/7+gplgSbCnWObktFR6KK6lyYpetCJbsdkNdVKltuzUfs1uJVg
 GIr1+IQ/dydQ+FgfvaODAI7GG7JfvLYcnHbHi8NG+e374dWK5kKR31UndHzKIH6sZtU8
 TLZoD6vOFWTS6FCn8HVzSeaR1qHnCGNP3YDlSFUIVCUrMlNQGIiLe/eFPzdxEualIUOd
 5QGKqyYmbWKrs0kr4KQJnbpBBKJU9YNPXR6YQDBZAvdn0bBlFl6LgpMmzICcFUjRMGgO
 rUBA==
X-Gm-Message-State: AOJu0YxDWDd2WzVKjsN02L1JxQ8B2yfoVc/2eJZyy02xAgLxli1G7YYI
 KmVhu/yw+ncSO/xBlo/wwhOsgBzFJrEyjKH6OuAnRP+FxzIpIpcd/LwBULlm7IFbQSsoYRE8msO
 8
X-Gm-Gg: ASbGncsyVSDLDGu5xzKNhiH/BZRCdSaw1NgxBTKQlorl28/VOpX1TZmSQl+ZL1qhi3Z
 /Pfw9vIPnAEJt19o2aMnYjBxFWhCSBvUTc29uE1d2yXWfJvsQrZ0rYIDQYU4oIBL1k1cXgRlmI6
 TcJhONOFlpohVtydhSKuBrcs07ny7pkWe0TRSpm1xFm3aB4dl1kVJhGdwWEZUeFXB6OV8C/u3Vy
 qRWco4flYcjI91kruu83r10MqRjuN+UfuDUBai+tmrX0qQFL0E04Ug8bH+TU0k=
X-Google-Smtp-Source: AGHT+IGuhbVUlWZBxYAJtLvznjW62+2+7wFumPsC7+1usc+fq86BPNJ6u+Lf9/6LRuONyHnimX/iFQ==
X-Received: by 2002:a05:600c:1987:b0:434:fddf:5c0c with SMTP id
 5b1f17b1804b1-436e2679e05mr192322235e9.4.1736776451605; 
 Mon, 13 Jan 2025 05:54:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] hw/arm_sysctl: fix extracting 31th bit of val
Date: Mon, 13 Jan 2025 13:53:58 +0000
Message-Id: <20250113135408.3164401-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Anastasia Belova <abelova@astralinux.ru>

1 << 31 is casted to uint64_t while bitwise and with val.
So this value may become 0xffffffff80000000 but only
31th "start" bit is required.

This is not possible in practice because the MemoryRegionOps
uses the default max access size of 4 bytes and so none
of the upper bytes of val will be set, but the bitfield
extract API is clearer anyway.

Use the bitfield extract() API instead.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Message-id: 20241220125429.7552-1-abelova@astralinux.ru
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: add clarification to commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/arm_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 016a302e679..01663407eca 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -520,7 +520,7 @@ static void arm_sysctl_write(void *opaque, hwaddr offset,
          * as zero.
          */
         s->sys_cfgctrl = val & ~((3 << 18) | (1 << 31));
-        if (val & (1 << 31)) {
+        if (extract64(val, 31, 1)) {
             /* Start bit set -- actually do something */
             unsigned int dcc = extract32(s->sys_cfgctrl, 26, 4);
             unsigned int function = extract32(s->sys_cfgctrl, 20, 6);
-- 
2.34.1


