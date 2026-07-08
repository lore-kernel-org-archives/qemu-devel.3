Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EECC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTjl-0003W7-Oe; Wed, 08 Jul 2026 10:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTji-0003Pj-MO
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:54 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTje-0002za-R2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so4135785e9.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783522729; x=1784127529; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0bQRiQE3yFRUC3oRXnyYCWPGCE3WgRVkbmnChPN1h+0=;
 b=r93REINIE5nwjtmas0KBqdNqWW8cYMOKal3t2pZ07CVO6lJO/zZQbRliwwf/Sv3Hmf
 ZEy0UfZQR7cwnLjNYUWuiaA9gFfQYCwe4kfPNMHQC2Ez6aE/zdz5oplSP0UFbIzLYaId
 eKvqRqfOuMnfpDCRO5SB4+q8JG+bL4GiMFikRAOENC99BojY3oXETeoA9gJkjb3rOClD
 DTD8xYUJdI8gpXUxpMd3Xl0FS360asDbsFFNs1hJMQC+XJk7OdyuOdH63IK4Q0FkqISu
 7zPCawhaiy6Uh+ck5fNh7bnwA68oKvcbqqwgl02ExWDBAE9sUnzNWQFAy43/poi0tJ0U
 y3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522729; x=1784127529;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0bQRiQE3yFRUC3oRXnyYCWPGCE3WgRVkbmnChPN1h+0=;
 b=s7lEtEcmZPBgyeebEH11ngcLlE2/2hw9kI5fmgLg6h872aUAoL62Lds2ND5OMS1uJK
 bY23RmDWxv+tazT6gO0GRPGUHMgnrJai6GO3f2TzxaT6jJJqZBWczBt58yFKw0O2rIfK
 z69m5/T6AMQ9EXIinCcDcjCj9IUJGgf7DYWduBafO00DUhpkfGWgvarTvBnBwg3O2kCP
 Zuc0/F3MJtsM7LFIDs0J8abwPFzRjyTUInIzhAnhy02QMN+a/hLFlARLyyE8A4pTC6HY
 gLHVmzVcgTVgMKgFVZrQ+D3a80Vz9U7pMKRek5ZYmRk61va5OYh4GBBfGDNMhzZ9hTm9
 5drw==
X-Gm-Message-State: AOJu0YzS1fQNQ9v0SiQKixN9gcMwgCswMYGzOpBcffzNADSIjYzUdLC2
 iILWrbazPvYBLbexiCT5e+01Umx2YUKopK012AglQDEtF5QF96612lV6rAb/TjVC85U=
X-Gm-Gg: AfdE7ck5hyfxQwKtTLCke65YqMExifnUPl3rZ19+h5e0hQXa/9QBcg1v5ApAP/qie/d
 IuDzK+EpX036FKYP8hdHUiE0nehOAe/PZIMO5TiWo/B5DfArDmzjJSSnqidt2zVi5xezroIlBhQ
 9dx7exfQOD/7/s2ZFfyHhBSySkevZwg+Okhkgr2gDQT4M5fXRHgV57VXzY3e810AEG8S5P8mDHB
 ct/IGQK2i1C4d7C7wD0EuRI0pR7kAqzH/e7HhyU8OtoyW1V+EcZdvdJT0LWAMjRzWINkUVwHOrw
 8Xmo1sc00o9lhesXjs3s8nrgzDLWGBwcwgXF5s3ZxJpVEr1YrlFVwol9TX/OVlj+8AiOp05aqXc
 uwrMEI2+8Xobp8D808WCuduQYR/jsFxaYRqfPnVYMZIE92JqefoqA8D3l/iBA1QNvSriacGe+d3
 xKWgpW2RH7GKVA
X-Received: by 2002:a05:600c:1d0f:b0:493:aaf5:6e04 with SMTP id
 5b1f17b1804b1-493e6843302mr29977525e9.15.1783522729156; 
 Wed, 08 Jul 2026 07:58:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a6d752sm39343725e9.2.2026.07.08.07.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:58:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 753B66013D;
 Wed, 08 Jul 2026 15:58:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 7/8] docs/system: add FEAT_S2TGran[4|16|64]K features
Date: Wed,  8 Jul 2026 15:58:40 +0100
Message-ID: <20260708145841.3032079-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

We already have the logic to handle these granule sizes in our stage 2
page table walk code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b4b65694ff5..903a5f90880 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -162,6 +162,9 @@ the following architecture extensions:
 - FEAT_S1PIE (Stage 1 permission indirections)
 - FEAT_S2FWB (Stage 2 forced Write-Back)
 - FEAT_S2PIE (Stage 2 permission indirections)
+- FEAT_S2TGran16K (Support for 16KB memory translation granule size at stage 2)
+- FEAT_S2TGran4K (Support for 4KB memory translation granule size at stage 2)
+- FEAT_S2TGran64K (Support for 64KB memory translation granule size at stage 2)
 - FEAT_SB (Speculation Barrier)
 - FEAT_SCTLR2 (Extension to SCTLR_ELx)
 - FEAT_Secure (Support for Secure state)
-- 
2.47.3


