Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78202606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mWhDDRCF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIsye-0007sS-RG; Mon, 19 Oct 2026 15:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xIsyb-0007qo-Mv
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:24:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xIsyZ-0002mT-Uj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 15:24:53 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso1919488f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792437888; x=1793042688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dEhS52YSSx+Bo4+B0YLxWr+435JocJm9cSkUC1QQivI=;
 b=mWhDDRCFwB3ACNzKsETORXUIeVw/ctwQp/JqVao697nevdUCirQ09NX5RvXN4kYFbM
 WY2I5SOLlPOWUnipf+HEFHDDgnmPz66jBnEWqnYR2KDmA8KaJ9Q8uy7j/OBa8O3tAzo7
 QGM6GCQYX5PZ1qAArIxPU84vbW+NVaFkZCIhDkBKMNR/cjOICsydt9nWbA6CuheKfgD+
 Xiz/wpFkcFeqLKm1R5faKt0N7GKK4uI8eB0jLueF2XV3eTpJoZ6CCUgIAj8P/FHxYZXx
 PVOUbW/cybZ37uh5o1eNPfe0H3Lo/uZf9FwiKAvUT36u+Rzw8kPZjWMtd12GBJE0w0UU
 H73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792437888; x=1793042688;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dEhS52YSSx+Bo4+B0YLxWr+435JocJm9cSkUC1QQivI=;
 b=L5BQR8y0axLoPl+vHU0VAVjDCN+UAqLUKCX/NCv9P8LdVLUPvsv1jOYPIkfv6466fc
 ctXvYuMRXjI+12DP/Y9CHjYJa2i9z3hU7WE/sOs9j625tCpq3n2KiFVsbBosIw5DvqFX
 KD3Hy7hSJf39Pw+QP/OgeqjmBYMOWHwuwSFImMvH8NV32IiqC/+vWRN0KqUUVYbWb8Ms
 4UOghXcGNKDezPucI7wPR8BP09QtPb6HTzsV4T4qXuQCNgz7wxwO2CzQVjdoshPAkVVS
 W/PfWfAscLwZ5TSzT+wLepClMJOnAxqRa+ojQGtjIxzMlw89GS7C9SrXcn9cFFlr/qYp
 RWlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWtv5pI1SAv2DRi72VHD/MdoYugsKRrQMTjb2cazKHucJdnuitfuzHi0jK5+fPdxPfM4j4gcWR6Alp@nongnu.org
X-Gm-Message-State: AFq9FYLQpdwS0VNGVWcE60I+TyNSVOoGJKE/EHiQnINFdz49NGiVXD6n
 /9or2qQtcnWdQawhmLcF2+rT9o1ZN4E8dHaer9SeaWTnYGTVeZ5Ith02c3Wbug==
X-Gm-Gg: AYBFou1FL44rJssDR4HBPjfnSKS/ROnZA142vvSfeXCdCFhIPRQ/RAIFsLWCp2EaSAN
 f5sm1/KsRJqYm1IdYgzKSevAV+8H3fy9a7tdwKeg+A0uHCM+J6pzfoNeAqGNhJQIV/RgAyudYKn
 T4+2uAc///BF12Bkk3V6k63/31w9nVS83+jhqSATi0PflHSVj/KCxo5mlsbVjMbyioClxpOPsRt
 wHXwD8bJ7WcdhD/GP/DMi4n6uKYU0UZUGYJU4Z6WJvouv/5ElAJEJuXkLRwAfGfsMgW7ziDJNAq
 LpPyZOgNktKygEQbQnMBGDxuxVsQxzSyALYMX+tKzt7+2e+Ss94bb2ONC1Jmc+O+BSq4Q3a8+IT
 gdeEfY3WoaSXoZXkhwsl/eHmHCg1jTaNRBPC0MLu7dfb5jnmWusX38WQWvqgPwmGt3efogYETJY
 1+PH87bVCiZJVnJ1oz5xvSllYz7FjPK7Vnfi5lAEaYumUvBTB1PlEDAhQirsGkLjL86pECno8+e
 96aDpaOxxhRObEqalpDC9gultEmuSKdgJE0hvhoUx+habLmF9v1yIWB/WtWnqfttkq2wHvjR+AU
 HJPP86Ofyz9q9HemUWY=
X-Received: by 2002:a05:600c:e549:20b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4a1d7624601mr113658355e9.26.1792437887909; 
 Mon, 19 Oct 2026 12:24:47 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-1ca4-1800-ec6b-a832-f355-434e.310.pool.telefonica.de.
 [2a02:3100:1ca4:1800:ec6b:a832:f355:434e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cce2fbsm11868055e9.10.2026.10.19.12.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 12:24:47 -0700 (PDT)
Date: Mon, 19 Oct 2026 19:24:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 QEMU <qemu-devel@nongnu.org>
CC: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_02/10=5D_hw/misc=3A_imx6u?=
 =?US-ASCII?Q?l=5Fccm=3A_Update_PMU=5FMISC0_reset_value?=
In-Reply-To: <20261014045605.399684-3-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
 <20261014045605.399684-3-bin.meng@processmission.com>
Message-ID: <DA4CAD0B-7AE8-4486-AFF5-E156CEA09F8E@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 14=2E Oktober 2026 04:55:52 UTC schrieb Bin Meng <bin=2Emeng@processmis=
sion=2Ecom>:
>Commit 56a11a9b7580 ("hw/misc: imx6_ccm: Update PMU_MISC0 reset value")
>updated the i=2EMX6 CCM model so U-Boot sees PMU_MISC0[REFTOP_VBGUP]
>set after reset=2E The i=2EMX6UL CCM model still returns this bit clear,
>causing U-Boot init_bandgap() to wait for a state that the model
>never reaches=2E
>
>Apply the same reset behavior to the i=2EMX6UL CCM model so U-Boot
>can observe that the bandgap has stabilized=2E
>
>Signed-off-by: Bin Meng <bin=2Emeng@processmission=2Ecom>
>---
>
>(no changes since v1)
>
> hw/misc/imx6ul_ccm=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/misc/imx6ul_ccm=2Ec b/hw/misc/imx6ul_ccm=2Ec
>index c4f6e372fe=2E=2E4accbcbeed 100644
>--- a/hw/misc/imx6ul_ccm=2Ec
>+++ b/hw/misc/imx6ul_ccm=2Ec
>@@ -592,7 +592,7 @@ static void imx6ul_ccm_reset(DeviceState *dev)
>     s->analog[PMU_REG_3P0] =3D 0x00000F74;
>     s->analog[PMU_REG_2P5] =3D 0x00001073;
>     s->analog[PMU_REG_CORE] =3D 0x00482012;
>-    s->analog[PMU_MISC0] =3D 0x04000000;
>+    s->analog[PMU_MISC0] =3D 0x04000080;
>     s->analog[PMU_MISC1] =3D 0x00000000;
>     s->analog[PMU_MISC2] =3D 0x00272727;
>     s->analog[PMU_LOWPWR_CTRL] =3D 0x00004009;

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

