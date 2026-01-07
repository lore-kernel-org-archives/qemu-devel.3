Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978A3D0D160
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdY98-0006J2-7I; Wed, 07 Jan 2026 13:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdY92-0006Ex-VZ
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:20:34 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdY90-0005iz-PF
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 13:20:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so24229335e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 10:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767810028; x=1768414828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWsSLsG+wvPELoANhMBDw363Hn8CM9W1tE+13sFYpjA=;
 b=bo2WNQ4f2UMFnBz66weLiWDJPlshh6qbf4YxZWFzsjEXR0NBbevCl2yozDwY7G/LXs
 Q95GmiUQEevR7PRXBR5fGFMVTVl6qKAhqKPIzZ1vKwmuYqLOCKcNO59hTSZGZBgY7Qqd
 bonHR42f14gSk/47VnV3WNypmngdYvYnQOAQP6od3XeopIj5ZzQpmm/pUrOUmBjI0ahY
 GoLNrFuziqQ+gS/da+FLuQHZG6HVsyOAA3qqZLOBN5MhQh8Tbwrm2CWOk3ljrKnqnWbf
 cbdZEIWrdXPnEthK2jH1XZGxne7DbV6gTSxt4Hkum/ivsvsaZczRiubdYdzagtvR41ML
 JgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767810028; x=1768414828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tWsSLsG+wvPELoANhMBDw363Hn8CM9W1tE+13sFYpjA=;
 b=mxvYbZrP7qDNlFjxY26LrMoDTfNCSFcdYA7KakBlgT3sh35+GRIGYFOma5FcrPx+mr
 lBG+QVg9KwmAKLps5LFYWd4XWaK9Qrsnsv61d448vlxdBTKmDt6oi0h8d+xETwaVGA/Z
 1heDHqBlXZJTeXnKoesR4KGTEtd/CE9+u/FCCfPCw+b2FZ4x2p4RZes1D7yc1ECvoq6d
 VCJE4s/lKdss6/jB/JKPhTK+xoE/aS3PkekCNqKqT+m5gua64QXP13676EQz+HHLTq72
 6gxJ6xXQ7YM2mem4xRVtzYAltZBIG7g8DYpTN3gHs7T1fyxP/aoeYm8mYaBu+Un7cPm7
 BVKw==
X-Gm-Message-State: AOJu0YwURkTCiagdzwJxxdcCMphaBmTapMXeMRdzrO7LOm6SVc6cIM2Z
 jdMbGRG5uCOGlI2IFnPAWkrkJBOQqSTgLbTwSyxCeiFfg6UoZOozHpovGrrT3DKlCpZvDdt5i56
 TfscOcAA=
X-Gm-Gg: AY/fxX7xRE5Q87EAhbaqzTxFwSgthXxDIqlk6ZPUzIuOydlF5fJj+VcAO1bbhto8+d5
 41t5UjoIfEJTEuRzJPWsfrC/cH+QWytiRN57SYYlR74YmkDOhtcY9uSvr2jiTuWRdzhIt9zmqok
 TTDo4PDj/Ysxk8y/xOXMFSxwzXLFbn9lj+6zUWeX/hDVmRn/BtKs+eev4jzU1j9hNYazEMmCH9V
 ktHlW+mqjNtjdHcTMTSaTWmR5Y7nrpgwAGzt+0G5YNcAW1cm9xMFTkDk9KoNarzQhvqi85AYGvJ
 2BY0WPtRsrvC72Lk1n2Ur3SOZ+TtHh/f9aP7EDVBNwSsLuo83FNp37MO5y1v0jF8CMZNUa7r+B8
 FlJ/Wgr/ePaIbj3wOXA6U9aZGANauJNchJx5v94SizCRsFXrxvAXU7c/pUVnbm4cVDbBInFXWci
 V0OC2eTOET4toGxZjjkf5nvRo4vh3Q+s+avTmW9UBh0nR/oRu9w9LUFwJ8ZtNi
X-Google-Smtp-Source: AGHT+IGqRyOjtS41sckwiyowNgjcQsad9x2KyCCpTop1x6cKsfJF1oZ8FVI9IOKBIEMgZfP/HRXMXg==
X-Received: by 2002:a05:600c:630f:b0:46e:1abc:1811 with SMTP id
 5b1f17b1804b1-47d84b3b75amr39154085e9.27.1767810028459; 
 Wed, 07 Jan 2026 10:20:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm12106291f8f.8.2026.01.07.10.20.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 10:20:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: [PATCH 1/2] target/i386: Include missing 'svm.h' header in 'sev.h'
Date: Wed,  7 Jan 2026 19:20:18 +0100
Message-ID: <20260107182019.51769-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107182019.51769-1-philmd@linaro.org>
References: <20260107182019.51769-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

"target/i386/sev.h" uses the vmcb_seg structure type, which
is defined in "target/i386/svm.h". Include the latter, otherwise
the following patch triggers:

  ../target/i386/sev.h:62:21: error: field has incomplete type 'struct vmcb_seg'
     62 |     struct vmcb_seg es;
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/sev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 9db1a802f6b..4358df40e48 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -14,6 +14,8 @@
 #ifndef I386_SEV_H
 #define I386_SEV_H
 
+#include "target/i386/svm.h"
+
 #ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
-- 
2.52.0


