Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AD606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wde75VUy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMwx-0005zF-R7; Fri, 06 Nov 2026 11:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMw4-0005pN-C0
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:37:09 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPMw1-0006P8-Dx
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:37:03 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so560390f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793983020; x=1794587820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oUo4+D9Mg8LRDc34U8PXawCEJelkdTLuEOZ0iDVwa0o=;
 b=wde75VUydq1NjKsbaQYp/l2wZ4G1wHI39sCx6CR4zXcqNOcce4eNDc71Qu4NiH8kSu
 Hqi9TPrfiFUFrjWv2KmTn8KagG2SvsBhaNpymmnGX5np+/8Hu16MsA4aJ68EIlmlwCk6
 EtKGODnKGxeznTId4WtGFThpxKM2IcuEVOCK41CL48UpPbpcVX52yNF1zIRRVG/uTLHT
 CXN51edRu0w/MvE3VcPLbbzGryFxvTxorOTQb41ixHGSOBBfZPLvo9PSxW9zL0AjFEPX
 /H2jPoxHqBCf67TlkVQXhlci5C6pgiN5eYBise+xt5DEY5YPtvN6sUbnWOYFYlWzPa9P
 joCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793983020; x=1794587820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oUo4+D9Mg8LRDc34U8PXawCEJelkdTLuEOZ0iDVwa0o=;
 b=TVVsFFIuzxP494wPcgqHRjsvIvbpRJo109SCZj/F010HZolO3S0mfLsO2hWvXDZ/5b
 wuVJzBOQEQPIkjHmoS2qWGAk61hrofrvHlklWuBx3OxqF78FzPNAkCR9Ikoz9gpeOjWd
 WNvgxg03K5sz/F5Sgbg1Hx53pXeb9MrHP/MnnUb+rfwng7VC2txNswpe2591mLBQm1uR
 lSt1ZK579r0/Wcv2r9WhGJ6TBJxWLWaL9wfbPirWZ7/LFCv6AAIW58sj0vbtmzxMEjse
 2PkvoASwrzJer328QifIxyOHk8wiYvFB1Kqqyb7xH2VNDPM2T3btNVc9T9Sb5XR2JMRZ
 wJ3A==
X-Forwarded-Encrypted: i=1;
 AL+hErHbTATVFjLJ1GfbMnk0Y0vSPzQgSNwX9AaOTM27ElfAgj7jNHnDJHGT8p8GLpH6xpVgl+dmMg6IRTB+@nongnu.org
X-Gm-Message-State: APuU4Z80WjX0c7zczvilovKALycswydfuTYshEjZ60u5QP/Gz6vnVyj9
 10Oee4D5pFnDlHpj2/fKkJpsIOthfhLVmXr/lxX+9dn9HOHDSjnrKJQn5iBIUitAmBw=
X-Gm-Gg: AYBFou0MWtVamPns/FXoKOIdmlarM7X+w/ryPg0d5VU3rfYTGjhZNtzi2sktO0/7h80
 yOUHGTilGGeQiq+Fm2aX1UNmweVnHOqNvZ+tlEGGdzrssvcAY3EOZtGH6dq+UybVoz4y6/CejLV
 Mz3NCiD/LVW0m9tbH5N14xvWSZ7a/3GvrAWcnsWun2sHxRXG5nnUVDTaq0NlL/4DyM38ym9lISb
 nFVaLX/ES7OUJyOXLDeWPdQ5YVJVuCHPd3aYziuntAsP+FEAMGCQyBnWfRVYjwgW/3wp7L91jfg
 meqvi8VCh4RqdGoy77GQxDhSbf6EUtOsmgUhdaWGrGaqwSW4PEIfqu/79KaChIEWBot5bDZZ0nC
 W1kFK0P+qzHWwAjCCAKdhtszfthb8Kdb/6pZP47ZE7smYJW32AgJrfBNscbgOTdoOiroaWQ5TV4
 0gJhNbXsggpGa1EsHkySJsItaNgYmaHMS0iQVc9YqEDFXHpAe0hqX29e3wUJetNeYxC8djl9JW9
 B5dCGo8aZN3CUHSNn+J49NCB2KFO5/yIltBBiUQEsVlHxoJlbMXsciUryVlECHwrbK6Tvi7yea5
 sX8OGU767qK+LcGFx3o8xyXRZqbwgkhzZEdFC6ZHvXh7qbk4tHycGRKob2zUaEG/X9906h9BWyb
 TtKLi70uJ0eUhm3NRMAH0Nq9xJt4Q6zWiBA==
X-Received: by 2002:a05:6000:2c03:b0:493:28c4:331e with SMTP id
 ffacd0b85a97d-49328c435cemr3559926f8f.28.1793983019907; 
 Fri, 06 Nov 2026 08:36:59 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d3d60e78sm4517912f8f.1.2026.11.06.08.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 08:36:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 for-11.2 1/2] hw/watchdog/wdt_imx2: Set vmstate
 minimum_version_id to 1
Date: Fri,  6 Nov 2026 16:36:56 +0000
Message-ID: <20261106163657.3825938-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106163657.3825938-1-peter.maydell@linaro.org>
References: <20261106163657.3825938-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In commit d9abd0253be90 we made a non-compatible migration state
change, and set version_id to 1.  However we forgot to also set
minimum_version_id to 1, so the state struct now incorrectly claims
it can accept migrations from the old version 0 format.

Bump minimum_version_id also to 1, so that attempted migrations from
the old QEMU fail cleanly.

Fixes: d9abd0253be90280 ("hw/watchdog/wdt_imx2: Remove redundant attributes")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/wdt_imx2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index f8129625e58..abb8edfae25 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -224,6 +224,7 @@ static const MemoryRegionOps imx2_wdt_ops = {
 static const VMStateDescription vmstate_imx2_wdt = {
     .name = "imx2.wdt",
     .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, IMX2WdtState),
         VMSTATE_PTIMER(itimer, IMX2WdtState),
-- 
2.43.0


