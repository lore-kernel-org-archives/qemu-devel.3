Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96284F4368E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 11:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgyc-0005pi-6M; Fri, 17 Apr 2026 07:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDgya-0005oI-2m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:03:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDgyX-0002mb-PV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 07:03:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7605ec91so464166f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776423783; x=1777028583; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yL73YMQhrfZa5LTPVabghLe8dhp1yk9RH5dTUzTDQto=;
 b=DfiCzwGtcy2WZTELzd6EwYLJ+jP8n/nRFnsTmmPQXDt5B/Lw0VfeL/eGEQOBz7Nn+F
 RoRyWL5W3whmq7GU4IL1KCZpDdKhr/OElOL/n8SA1a+2W/KJTgWS3kF+JCSr048SeP7r
 wAiThhPdnwNoy7yVNawxDAXRfbx796BPk+Vin00EIewU2tnRik8Le+1RqL1ro+KUfnv6
 BJC/erzx+PT3cnHuaftM/s96Hffm2qG85s+hhmBDl7pw3YcuLadZwv4gI4A0sHYcBxW6
 XAFCXa9O6zZwVEzoPezuo91+255x5kVz54mioqHYfk6LvezfD4Zxqka4IjiL+uH4AqZO
 P0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776423783; x=1777028583;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yL73YMQhrfZa5LTPVabghLe8dhp1yk9RH5dTUzTDQto=;
 b=SeB1Q0BE7U8eQpEgTAnmOgdA0J9JU078D6aBgodUPQJy/mcFk9A41GQBTcuRI7Uzjg
 gaS1bG30t5YK9b91lOQeCTHr7W03UAG9ETCEPYzOQ9Hny6oPWcNMXLcQ2kSpUz9cYowf
 rMwvfUH1DSJlx02GVBj4IACOcG+UR7YCnlSQay5c89JAYDo20qs0JvyrkptZ76vPETAc
 tfoshnIwqjmko+78PzsFaexFx36MpZW2rp23QoqF1ZWbaQCN8MVZRhp1eKhLvv403sIn
 H9bXa+OsZTf00qhR6jSApNSz3DEpw9/zTuK2fqCwaLo022uxEnGFl9oaM5sf+EdRWUXX
 IAEQ==
X-Gm-Message-State: AOJu0YxfaMZ3/axZM2b8XkeBDECF0ymx6rEDJ2o/HAs6QHPULsjQ1Kng
 CUHQthyQpYXpRKyVGWzxPMKaBU+Il3jmTX2/GmpwVzhvPgK9WPKSDFrQqa5fV3GQ5g6tkrUYrtR
 9bxsC
X-Gm-Gg: AeBDiesaSj1z5DWguiTgfb2AQfqy7Vm2qStIXpmMSIfN1HAGQUuxA7aOVFO7Dkw0mxt
 z77zTgB3MuK79u2jc3RjkTdnBpHvpkHARpZa4lFNEZIttTsLVAo5sI3NSvAv5YIeG9SJ6bHwxvx
 rNVrHMuBNPUTExeIFiIb9ci72ubpt773ts6x4FoMeEgjE84fDGodiFTJwj5bEKwVuHLE2EfkUbc
 3kEfjIxbnuVN+yokGNrdp7Y1Uouh8bqWA7EGDQ8zzLymhVIifDUyVPfySasD2PtYt7C3iEAuZNM
 VDEGSzMXyk+kIKqPSzs5FEBtleBGimdGUok1Fx/FY3g/h+S0hzADooAQ1RVXZWQAPjlb7iCoQUP
 35W5nC7Um9877n0G5fSNaPIKhl8dPy4EJVAydF7YQ+EjwmIHA4sNmvnPN/O0x7sqvgKfAUW55YK
 zpcz3mGoPzQKcOYviPlQ79P3wuSOhKi7MRhm7Kje3z27q0rXgC
X-Received: by 2002:a5d:5f82:0:b0:43d:7d6f:f540 with SMTP id
 ffacd0b85a97d-43fe3e237d3mr3584635f8f.45.1776423782820; 
 Fri, 17 Apr 2026 04:03:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:d023:c0db:d3ea:590d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm3811934f8f.37.2026.04.17.04.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 04:03:01 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 17 Apr 2026 12:02:53 +0100
Subject: [PATCH v2 1/4] target/arm/cpu-features.c: New fields in AA64MMFR4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-jmac-feat_rme_gdi-v2-1-7cf5131aeb60@linaro.org>
References: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
In-Reply-To: <20260417-jmac-feat_rme_gdi-v2-0-7cf5131aeb60@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42c.google.com
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

Added RMEGDI for FEAT_RME_GDI and other new fields.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b683c9551a..2d1a3196b7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -346,8 +346,16 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
 FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
+FIELD(ID_AA64MMFR4, POPS, 0, 4)
+FIELD(ID_AA64MMFR4, EIESB, 4, 4)
 FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+FIELD(ID_AA64MMFR4, HACDBS, 12, 4)
+FIELD(ID_AA64MMFR4, FGWTE3, 16, 4)
+FIELD(ID_AA64MMFR4, NV_FRAC, 20, 4)
 FIELD(ID_AA64MMFR4, E2H0, 24, 4)
+FIELD(ID_AA64MMFR4, RMEGDI, 28, 4)
+FIELD(ID_AA64MMFR4, E3DSE, 36, 4)
+FIELD(ID_AA64MMFR4, SRMASK, 44, 4)
 
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)

-- 
2.43.0


