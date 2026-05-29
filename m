Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872BFCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Go-0005uR-Q3; Fri, 29 May 2026 15:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3Gd-00055r-Kt
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:16 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3Gc-0005cG-11
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:15 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-69d8f70cb0cso4722327eaf.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084393; x=1780689193; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TJKw9ntV/Q2yFHpEVRYGUEahB0rXJZjAtu4I0qozEHc=;
 b=i/Y0maWg6s+jvV9wgwq9TysI+7tWu8F++YPfRZy8cs+FpzwCE/YwQATAfr32vLUicL
 WQ5v9T7+QumIL+DOMgcoGJcqCwrfINnI/6HEZinHMZj9LpwB/E3hswqCkKRSvVMQekJN
 66cPxk5VsIptcr/5sSC9Ora/2e1VsIkv9TwDYDQt0STrJfbMprThjKCyM0mU+ivzGuxL
 N082f+P+0kC6SDgbFRDKXFR0/OXmWpAxxBuxBK6/ttpmoxYIjG2vEeOES3g20mjL6lwR
 FzuRvmuxnulrEiE0H7mVTbailke/p3OifsADUc1pgTs1Jjfh7Z8cAi9t5hRizN77X8jW
 vWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084393; x=1780689193;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TJKw9ntV/Q2yFHpEVRYGUEahB0rXJZjAtu4I0qozEHc=;
 b=p2K4AOF5o4SbCtm2zLIdCPXDhHtwQicpC6EtvFiLFbI9NsoTnZ82YNa+Mbb30VzGYm
 Fzxz6P00QYzHhi/bOeEZ+fT56OxfJ8Gb4IsNfnAFJQlDjVui83WtbuMAjpfKJ539qJrH
 Gzu0nIeEx5IqbFFdebVLlzKpLcn98AeiZbVA4PczsiohCDOb+cbmhTqoEMc6jq6Fsd0X
 JD7SKBWJq01Z+udvfI/pYaVGI3Ys0/M0MRB/6VYvwLrrslnROyoDFKi7wfKW1UxxSd6U
 Gq97mMTUMXPRygCwKVyS4kaRpuiaDERTo6Pm6jugyFhvVZt2IIpCCnVumoryTujYsuB1
 E7Qw==
X-Gm-Message-State: AOJu0YxtQDXEt7PlxQF2+zcqZ11+hEhil01IwK/hqBx/nB4J5XEtipio
 Jrz9hBy0pAa4fuw0UnR2YylQHEe/RlT0SLhPaXot1PnF2SVEjRiqDDvY
X-Gm-Gg: Acq92OEuxVMpP4FLRgpCxMRrEHoeKH/Bz+mvlZPUSQcZBweY8mDGnmaoDLP5dgd5F2N
 JTbsMw52uaNnWiGaexGnNcY0ky0srVUHomcGXanjsTlS8nOxUn98oP9nkL3rxdo0tBrq0IElkDI
 vRVP+lSBttTZqQxkNg+uUb1dJTxyk5SvKv7wim4iiV6jl42To1ABLNwJk/PLzv5NUEkx0ezXBpk
 I2Ow4waBsjHNdudiG6vhZyZoLUfllOl/toRCOUv7OtAszVeTM+hDwKsnAJOp+706mmENwvhtk0Q
 lZlNi3Il3wvgANn4cYTZBrgvm9853DLgLaciUU3vmzI6+csSGbjTdYTj8ZMxaND9GqBTJxCMZ5g
 6N4EVKXi+oPTQ6uWUVwvoq9EsKv5wnwIcqHdjnVaGapnjoU2/fBqc28Be+WoVDHdWp0bRjmOvdd
 id3Ao3j7SgEiPR6Oh/4KmRlTP4xS5VmPVCRxHLEj3KJ14=
X-Received: by 2002:a05:6820:1986:b0:699:b131:d587 with SMTP id
 006d021491bc7-69e10436d38mr383784eaf.11.1780084392825; 
 Fri, 29 May 2026 12:53:12 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:53:12 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:53 -0700
Subject: [PATCH v7 13/15] docs: add MTE4 features to docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-13-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=2175;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=dYDek0cM2AigowKbRtIvnJyxcZsnT2aDCHX5pbUTS+M=;
 b=HV302SNuYCnwzJLjqOjay3OIwb1ZFNnrKsTekrmU31CT+vp40YQasOAjETXYzNIgCc3ye5oj8
 H4EsvWl4ksGBQVeuM+SPQop1thKvT+qq5Hq6qEsVNjG8BNf7iFaCGBq
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The implemented MTE4 features are now present in
docs/system/arm/emulation.rst

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 5 +++++
 target/arm/tcg/cpu64.c        | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index e44b3016be..eddbc12ae7 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -113,6 +113,11 @@ the following architecture extensions:
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
+- FEAT_MTE_CANONICAL_TAGS (Canonical tag checking)
+- FEAT_MTE_NO_ADDRESS_TAGS (Address tagging disabled)
+- FEAT_MTE_PERM (NoTagAccess memory attribute)
+- FEAT_MTE_STORE_ONLY (Store-only tag checking)
+- FEAT_MTE_TAGGED_FAR (Full address reporting of Tag Check Fault)
 - FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index a377f67b9c..eb4003c732 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1295,10 +1295,15 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
+    /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
+    t = FIELD_DP64(t, ID_AA64PFR1, MTEX, 1);
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
     t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* FEAT_MTE_TAGGED_FAR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1);   /* FEAT_MTE_STORE_ONLY */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);    /* FEAT_MTE_PERM */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);

-- 
2.54.0


