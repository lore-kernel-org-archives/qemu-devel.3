Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D79C19F4F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RSx-0000Ym-GR; Fri, 26 Apr 2024 15:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RSq-0000L2-EO
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:35 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RSm-0002oN-Nb
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:31 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a5224dfa9adso458924766b.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160542; x=1714765342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnqT/8KLlXL1A5GjOlmM9XBc7s531rVah3xCrUywBWs=;
 b=Ji4Ua1XCpcu/s4+b+Xk1OStGLCOaPVhLeOufT2H0YXy6CMSTQyRze2tOpW2zUIHgoz
 2gAj0XAPgma4MQPWaiyR232g9XD6jzdKp2BY+Ekdo6trYcgAmhdDmXYWLYAS/CWbYyRt
 UHKYt3yYGaJFwpvtKfy5addaJrUmW92wM7xZH4vwOJOQIisTZq/Ikv1uMGTb+HbnF+4r
 j/QlwgNW23c7/V7RcU+Vd4i47kUkfh9fi+KDHbSjOdaDTtQhbnwaqXoOxi2fm7AfcHWd
 xxlgLPxKxCJmpyJdcnjVai+9xusOOJphGrlyi53TX+bYf3xdJp+eYMYEpPadY56Vukyr
 FCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160542; x=1714765342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnqT/8KLlXL1A5GjOlmM9XBc7s531rVah3xCrUywBWs=;
 b=rOSuwzRyVF79EjaKbFy601anGxSB7/qQVBroupAQmvfT5Csa4se9Ns38rms6B8SoBu
 lgPnS3xg1NYdvEtd7etyUL/BxwZjcmHvdBlpC/O2zb5+h/I6L/q7W4tpsHMK2pPu8L+g
 Q4Ow8MEu3s0m/hKm2meekk4+hPyqvcf/mQexdmZf4XDYlwMbaeccEnvpqCr1kVhWi4RE
 FQTK5gMTpVTyEwE3AuIdyoG4Yc9XD2gmN1lH+qXQ0ZFSxMmKbYO1VgkTHBERP8/XfqxQ
 U3oI021Jq0T0dM1eLbZMfNmHiJ9ekACDIfbSP6IztGEs7vwmWrfuafB5zZQP6bPN6yRX
 WEJw==
X-Gm-Message-State: AOJu0YylEXQ7WVA1vkL0Sd6O3o2i05nL7nprD75oFyz/HxkJUwjtTy2p
 FPf0+k8yjhWAqvJPx2sgQkvlUFfLHzE8DZz4clFrSZagMBbpsppDkRTr43TzHYAVdhDfCoNT90I
 nA/M=
X-Google-Smtp-Source: AGHT+IHzESwQA/fKDkFZyUH5qViM1lZPmcV+yr3DMDaCJVv+GCYotLXwIDWjYbqQP0SwTmX1jsWmkg==
X-Received: by 2002:a17:906:1950:b0:a58:9899:89ab with SMTP id
 b16-20020a170906195000b00a58989989abmr3098213eje.22.1714160542218; 
 Fri, 26 Apr 2024 12:42:22 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 q10-20020a170906388a00b00a46aba003eesm10856553ejd.215.2024.04.26.12.42.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:42:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 03/38] exec: Include 'cpu.h' before validating CPUArchState
 placement
Date: Fri, 26 Apr 2024 21:41:23 +0200
Message-ID: <20240426194200.43723-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

CPUArchState 'env' field is defined within the ArchCPU structure,
so we need to include each target "cpu.h" header which defines it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20231211212003.21686-2-philmd@linaro.org>
---
 include/exec/cpu-all.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1a6510fd3b..b86209fc49 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -391,6 +391,7 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 #endif /* !CONFIG_USER_ONLY */
 
 /* Validate correct placement of CPUArchState. */
+#include "cpu.h"
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
-- 
2.41.0


