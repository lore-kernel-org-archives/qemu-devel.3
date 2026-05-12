Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EAACD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 03:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMdoY-0005RV-H1; Mon, 11 May 2026 23:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoX-0005Qp-Jg
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMdoV-0000Fx-Qp
 for qemu-devel@nongnu.org; Mon, 11 May 2026 23:29:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK8DHn2173016
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=w3nJOb31vcO
 +Ssifc149/3r8ODfugZ0qFwL7U92JD+k=; b=BuhzgWUZsEt9/A5HjGOXJxboV9O
 C796Ztr9d7rd/1+wPaTdA+5b6CbJMPzqpkGn9YnNJMJr5yiKQAliBQWB08raaESX
 8PDosJHqJ3SeD+am49Qfy3zGDsMYpQTSpXZsMV4IS6HYXw7ibboNXvtyBfAxAheN
 SlL1Lv7b0oOArmhUmQ66dBG16I2UxX++eal47Ch+9vjmQDt/iAEo9uc5ZTx/PYOJ
 RmFLNU0hXguzoeRR/mstK73Xu+0r44hfiowWd59mcbIkV+z0GR6pnVjycj+znUSm
 oQ/eWm24THqMBBTTyt2cvk+aCldcIR0zrn/xNuaVe+ktWvuOpeqDog7A3DA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nvj993g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:29:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso6635550eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 20:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778556582; x=1779161382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3nJOb31vcO+Ssifc149/3r8ODfugZ0qFwL7U92JD+k=;
 b=OjJyvZHbnDQb8bQuPUwdhQCOfokg0NXVViZFT4bdQE4w83V6XVkctlqX1ttL9aPZO6
 ldZqlM13ZW2wElbNN6a/GDHY6ZEXyeDrl6F8RcjvK4xHnx6q1q1CNKiiJC/DGvfQg6Pd
 Sad+U+QRpR0Ozb5waRBEg/Ccm8CBrPJGpohTdHwaWdTu81qcg4+uSVbzqlnbc2twPiEz
 Y/QCwL6xgcKPVoT4aIWjXK3LCDwegfwyd+1pKL2I9dCHAZkI5W0oBnASF8uARND22zQj
 ZyYO1faTEIfEVZlgKnbVDTyqAdjFl1MBd8HRGVvL/2PflzR/sePda4yNRhf+WClxOCB+
 23Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778556582; x=1779161382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w3nJOb31vcO+Ssifc149/3r8ODfugZ0qFwL7U92JD+k=;
 b=oMbvfTJwtZ+GXRtlem8tNvkKZhT4AhbfjayEfQQ4GHQJ2H9UUPU/AqzS1L/BOWbV8U
 cKlh7YFCOivC8ekAph4im3SXbLTEho2iRschOEQI14Jo4awha3JNsGm4fqnA4Lh0fhBO
 Ete6b48cZwi9HDudtt7xCSt1gp3BBb6rhZoJWVOgqtik4koGQXpYVeVJlJ5qGz3Y8frA
 4wpbV5JldpwQxSvRwgmrY/Vmx4GTF4QOcCAlggDgawIkp9dBgR4T+ZrhjVIadwg+269Y
 NShRYRZo/ODePjw9gx1LSgFAfNhc4Ynku+3/8vERycw1J6jZ1OJGTEwy0OKuvy0saZBE
 eZbQ==
X-Gm-Message-State: AOJu0Yy86/i90iQIgNHhbbthCgFBUW/X7vfvoEllnsOvZ13YvJBhz7B3
 Dp1J+ovwopQPxF1XiB7E8nMZxb8mfmJ111Y5EQAkqiAX7bYy0AvSe3KdKIFPPmmrJsd2qdpaPho
 L+D6fdDFCnVPGPgxw5IYISWK/4kNzBa6YxT9URlg9Kzsb8VIV9zuRZIdpXFxpTci6vg==
X-Gm-Gg: Acq92OFrRo6DujXcQce3kWfglaB6e3Fs0C3wSz4LEF5RYk53b+QdorSCALJVIX5hhPL
 Ro9vcHUyEHD4F95+3t8HuMoP5aJ7CmTAhohDHS2WThkS19MA12JcTjwmFjffWdqZ+GGqsob83v6
 YBV16UZuedzWGbxyaSu3M7PNOiCSg29ezg1p+omneP/yzIs1H2sAiGzluQNkZ0Sb6iErAp7X49b
 ZwPen1rKuhiCQWklf1jzPmpOWUT/HuUzPlxWCXam/mGf0ydfwCME/UxB7id11WWxlaNSIIAiZmt
 uDTbKgb7AbEvEmguzUnmbKaO+Cs/3O9RV1diROCR49Kfr2s/JTnPO96qybP4WGAJXfQvNElZtWh
 QFzMOL1BVCeAXaiqAsST6oV23Rm6tE+sGm3AmfRwE6jKNf68IT4gmIyAoKUvp
X-Received: by 2002:a05:7300:2146:b0:2e6:e77d:7bcf with SMTP id
 5a478bee46e88-2f54f9442edmr13956628eec.22.1778556581410; 
 Mon, 11 May 2026 20:29:41 -0700 (PDT)
X-Received: by 2002:a05:7300:2146:b0:2e6:e77d:7bcf with SMTP id
 5a478bee46e88-2f54f9442edmr13956614eec.22.1778556580854; 
 Mon, 11 May 2026 20:29:40 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8884750ffsm16054317eec.19.2026.05.11.20.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 20:29:40 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 04/14] target/riscv/tcg: treat all exts equally in
 cpu_disable_priv_spec_isa_exts
Date: Tue, 12 May 2026 00:29:16 -0300
Message-ID: <20260512032926.1978818-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xIlwbvfuThR5is_yZeH0O1tTR2rDIbcZ
X-Proofpoint-GUID: xIlwbvfuThR5is_yZeH0O1tTR2rDIbcZ
X-Authority-Analysis: v=2.4 cv=H8brBeYi c=1 sm=1 tr=0 ts=6a029ea6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=y3KnQKAffZ0f_Lxsw64A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAyOCBTYWx0ZWRfX32haaCCl3P/i
 a8XGzzWUXl9a3rWsWjhfZFylqR//E86yAe1yQTa/KbxDJx/9+nhFboBztZbsWHNCM7UgpsHZxdL
 +Rp1NDvvF6zUWTzvjr6uHU7jZvQxOU+lPBmIYlhf2zTyO+vWDO8MHObfHjjvV5dKOlVgm9im4My
 BQBpyT4L7XouG0fox6OUHx+XlyzWg3BOIb8Rg90hU7oUdvraiSdNBkQaB6fdlAW6PEsJBqXQyH/
 tpVBACfGCq17N/kR72oY8DbWCupbN6cGnoJYTpPg/4ydj/2HkQQZAXq39Jez2TLUz918q5wEATa
 Vt331+k2h2Xo6aoMEf7Gu8pdoLI/2iVeQpOja3uoIaUwOh1TIcEY+hktBylcrCXDai+oHZo/Aht
 IWAw7o8ywpj8tzwwutG6myRKNwfnoyOjPlviGeSYpDpKbPLAums3aMEQnIPdgPLcW18ynGxzNuA
 x55/yjiy17kSPnCjrqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120028
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Commit 7e4f75cadf ("target/riscv/tcg: hide warn for named feats when
disabling via priv_ver") changed the design of
disable_priv_spec_isa_exts to not warn when disabling what we were
calling "named features" at that time.

Back in that time we were adding RVA22 profile support and we were dealing
with a RVI innovation: named features.  These can be define as cute
names for pre-existing behavior/parameters, e.g. 'zic64b' means all
cache blocks must have 64 bytes.  They do get inserted in the riscv,isa
but they are not "real" extensions because users shouldn't be setting
them in the command line, or so we thought back then, and we attempted
to model that by calling it "named features".

This didn't age that well: ziccrse is a so called named feature as far as
TCG goes, but then KVM had to treat it as a regular extension that can be
user set and we made an exception: ziccrse is a named feature that is
user set by KVM.

"Named features" are regular extensions that might or might not be user
set, and might or might not warrant special handling during realize()
by setting other parameters.  And we'll being treating them as such,
which will culminate in the end of riscv_cpu_named_features[] array in
the end.

This reverts commit 7e4f75cadf44ee67809c7ca82645a289a5268966.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a358d91ca5..92406bf41f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -484,15 +484,6 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
             }
 
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
-
-            /*
-             * Do not show user warnings for named features that users
-             * can't enable/disable in the command line. See commit
-             * 68c9e54bea for more info.
-             */
-            if (cpu_cfg_offset_is_named_feat(edata->ext_enable_offset)) {
-                continue;
-            }
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x%" PRIx64
                         " because privilege spec version does not match",
@@ -520,9 +511,11 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_13 = true;
     }
 
+    /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-                          cpu->cfg.cboz_blocksize == 64;
+                          cpu->cfg.cboz_blocksize == 64 &&
+                          cpu->cfg.has_priv_1_12;
 
     cpu->cfg.ext_ssstateen = cpu->cfg.ext_smstateen;
 
-- 
2.43.0


