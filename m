Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798B1C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLW9-0000RU-IN; Tue, 06 Feb 2024 08:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW7-0000Oy-Is
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW4-0008E8-Fg
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40fc52c2ae4so38781035e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226175; x=1707830975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UYUQj98bbU7K8bCUSnxlmHCzo3manDoNOSQ2wWBClxY=;
 b=ORbbrOJjJtcQa8VpKiqXg8tY37aePU8QLWQR2Hx35BPaKFT7geVIUIQKU1BaRLiyd/
 n2C3Z7ReD/OiaS40wU3JJsxjTCHH7g+RyMtM/Wz8qfUGpK3558o2y9DxOOcBU91ZDWHF
 znLSUPs2W8Ks6T59eTmGDKoZzDZPXV3EFiZg8QfaJVYucqmg2Dko9EF1ejJrnZaqoq+g
 fvfhRUJgVT/fG+YJz2DswH97qMfBooqa+hPmhoRJm9yU/I2TDHFsEsNGKbEtLA7Q02aE
 R/6b78aXCBTuY03yFpfR2pXOgGQDkLax8XOsbWAFYjXsLqpxLnJYC5K6mtpA9wwYQBSS
 L67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226175; x=1707830975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYUQj98bbU7K8bCUSnxlmHCzo3manDoNOSQ2wWBClxY=;
 b=cuBPLb/LUcwse74WW/moXFgl2HMqwZZ5gH00qNd+8KhRq5o7i0pVuFJk8A4tS9oXp3
 WgDRFge9l+WG/Jgt6uwKTKAxS8RNKzOuVsWkThWXSvBwgoGzaFz44a1zkipww7510oxz
 W7n7P3jz6bVp+6hJS3gWCIm7H1mN7mdv06onZHzrPIeEsM41X+/iV29Di037xBSom8YW
 Urxyr+pAZNT/Va2x2ht2cGCQPGshkF//xuSbUegDgKYlOWVCAOqdAeHGQ/kIsFRkRE1/
 +UjYSEiGPBcVGMtgR5xLDdJ+3yOdJYE357iu+O30eOH+az8afuubQc5Px9oOmcGnRReo
 nfPQ==
X-Gm-Message-State: AOJu0YxBvxVxlL7gR/v2+HG6CWbtwX9cS7mxNWZ0RfYRMByqAZCKCwpf
 Ke0qUVjlYAfm0WMawoMhfFeCmkBX6NzmOufVqj2NfBnkyvvmoKCvmxmfNGIPinQ=
X-Google-Smtp-Source: AGHT+IH2Cc78X7hKdcZqkQzj9IhYeqjAWZ0ZreqyoXDbmpACEwOm86fbJl57I1PvQXxuZGer2mfnZg==
X-Received: by 2002:adf:ed0e:0:b0:33b:17e3:60d9 with SMTP id
 a14-20020adfed0e000000b0033b17e360d9mr976730wro.1.1707226174900; 
 Tue, 06 Feb 2024 05:29:34 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWuZDECeXToWo71JfToqMViQWidwu2iSsTn6PCtvEkmwCFPW7afGs6iN0N+svrKXTZRV8oyliAgvxosw+MS2hzTo1PJBTQ=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/13] hw/misc/mps2-scc: Fix condition for CFG3 register
Date: Tue,  6 Feb 2024 13:29:23 +0000
Message-Id: <20240206132931.38376-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206132931.38376-1-peter.maydell@linaro.org>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We currently guard the CFG3 register read with
 (scc_partno(s) == 0x524 && scc_partno(s) == 0x547)
which is clearly wrong as it is never true.

This register is present on all board types except AN524
and AN527; correct the condition.

Fixes: 6ac80818941829c0 ("hw/misc/mps2-scc: Implement changes for AN547")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/mps2-scc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 6cfb5ff1086..6c1b1cd3795 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -118,7 +118,7 @@ static uint64_t mps2_scc_read(void *opaque, hwaddr offset, unsigned size)
         r = s->cfg2;
         break;
     case A_CFG3:
-        if (scc_partno(s) == 0x524 && scc_partno(s) == 0x547) {
+        if (scc_partno(s) == 0x524 || scc_partno(s) == 0x547) {
             /* CFG3 reserved on AN524 */
             goto bad_offset;
         }
-- 
2.34.1


