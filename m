Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6C606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OAUq68/2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UsjlTjQ9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmp5-0006hq-1K; Tue, 27 Oct 2026 15:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmog-0004S4-JB
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoe-0002B3-Mj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHOKQ2945736
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LO5GiRPsc08nfkQFqM7ddr3N930Oo/SHFTSn6nDABNw=; b=OAUq68/2+TV9dDU2
 LN5vWgbUxX566lfwhJ8crT62GUDt3e0N4o8GXkqbd3D+KzS08/Z2x3vrX1tdmzm1
 J1tO1lDrEmS7kUGfpTUvYV7oe99ffaevhCAJgWI7n/lfLBy0zwuCWOBnlxgmMs/G
 TDOGlcbllD+nR8gO84npqcFZ2pz5v2rjT+3tcZjFnLt3klC4uV/pNBZkoLk0+hFp
 4ho7ZYZZU11ZofayO8VOAmLw+8kS9+xoICL7QvRJiPfeNCYZ8R3oXLK/TyPLxV7y
 dnnYOxtte01UgwVJqZGZYpVQwjJKtMpmp37tgSBzuXAc/fSmyDBSAe2U8SSKyd4P
 cMHbYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq6apfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5338974c0ceso5664991cf.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129195; x=1793733995; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LO5GiRPsc08nfkQFqM7ddr3N930Oo/SHFTSn6nDABNw=;
 b=UsjlTjQ9hh7PR672msDieUEqW/iuAcplTgGWpctVBr54mA8AbIX/4NE1yTH0QAgOBI
 jKol2S+w6O6Quk9x4jntuFXf/+8jiaVHl/78beeVkeysX5MNmzqpU4THfwjcbEw+dq6r
 NK61zwjEdaRC5DfxzQR2iLpfnTKhiskUhaa3Kh/qa0lJBPxfEGZFnMlafIaZEls+LsCN
 0cNL1FVAPPOczqj/Y6y6aaPfGVgdy/IYCQDcKMBA8IdgTxiK48qgxXg4WfNrBcQJPW0X
 OoWkZk18mixnCDDGbYOQHIDZ37hRFftk/5b2jzEGi5pMWaifXRPFdFCKCCNkcdquQI7k
 WX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129195; x=1793733995;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LO5GiRPsc08nfkQFqM7ddr3N930Oo/SHFTSn6nDABNw=;
 b=j+L29hbkoht4HBGgNiMD14EdRAyZ/z/x93dDXd3+PkiNAaCJRCBlUDtUHBwwghEjNW
 ZFgOsUMYY3ddV5wJp8vXzFtS22kjxq5y4KMJXGDQMIFLNbtoB/Fs5kbRmevbqdeMvypC
 ipLLT+2+0NpeB0qaB6GmMM7GCOSe6OExFnvyeNeee6FbixI4k5IVFhx3nVUhoaXgixsG
 IFhDeXvjGLg+6XtaDxeLZqqWZs62pZLjqGGShkosWLuEwA5L290LLPeBoru4mRS0astU
 0O4KiKiQ34wrBOGA53DH7ty8K4Mw8Qe7KthTzpefGLEQxAqm/y0DmArLersx4KhdWh2y
 294Q==
X-Gm-Message-State: AFq9FYJKA+QSE98TjnWNvMME9O4At9pWrOUwH0G6UEpAy8OEOqLyKdlm
 G9Rpk6T81eiAHl8R5gdrmemlsb70GtewzuvFVcMGBC492HI3sz4F0BB4Ovun5FUmD/gYI14VbIW
 a0e3c1Quhm2txSO1gCyQjr2aJiQkwi4VsaEZTkP3jhlIjMssE4Px2RXz8GW/igEnx7g==
X-Gm-Gg: AYBFou1wNLzX50kGF9MQNXuRUPYNCW9Je8akPaR2UZ82GZJ5VtPf9HYlqtPHZwtoA7f
 3xfmXVoj32AuK0bwV8ozTyKt36DnNC01HR+X/18H9HKzgJGbj6NV64uJl3LUKm4lsOvSBteTvYF
 D2j19bdWRrYm/wLxa6/+aR4m5p9BhTt2dp6X9cZZWLzDkpF5GkTIRjfwff2Tu+KqU3x1WhSRt0y
 MKyi/NNwDvxexWivwdXzuCjmEQRQWJ+FfRDOAiZN0fK7k3V2oxoEfMxsQkZbB42r9qdco7XB3RJ
 uc8cUxl0o0sT00bxUypeDWUnHrQL0zylYdWrdBNFrmBpX5rXGq07xaJjfyiEq1GoiOypsbnxtzX
 oe5Q+oFST5jUm5ya7B3c7HPFOse2DBIp1+zwEwnJPfAhdOpwAgMf5d6vI
X-Received: by 2002:a05:620a:390c:b0:93f:2ae1:ea06 with SMTP id
 af79cd13be357-940ef8db9f4mr1840243985a.44.1793129194874; 
 Tue, 27 Oct 2026 12:26:34 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:93f:2ae1:ea06 with SMTP id
 af79cd13be357-940ef8db9f4mr1840241185a.44.1793129194408; 
 Tue, 27 Oct 2026 12:26:34 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3932sm25836759f8f.18.2026.10.27.12.26.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:26:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/59] Kconfig: Extract config IMX_RNG from config IMX
Date: Tue, 27 Oct 2026 20:23:06 +0100
Message-ID: <20261027192341.9197-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0faeb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=6cOzi8cwvGXr9bhZ1ZgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: fUnb0jmrlPIjIRUXa84Y-vnkIu7YpKgP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX3MHp+KxD6yuE
 wsBv4raIyaXtiSwTHHJah+waPXTggjD86rG1kodEOB01POaBGYkmCT69SPgFW/qtZ4WLNg2QuT4
 dkHrNtCQ2lxWn1GQtL+WYNKDP6FnKLU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX6VMhqp89/O+y
 07/t3JakRE9SBn2yBRkzECLi1BS0/t+mcbUxV+nCyTLv6Uda3c4kpac6LwSVpuebHTwDsDUP3H1
 c2VMUP7myzUKBBU53cnaClcEwqmrI9Zoh8dHjb0001S0Y3PG9eC6skp/uP9eAVPQagGm6MCZ662
 vC78M8ojME+4jmm1N9RX4UjzfLhM8aXoqdOOPoquFn1dVTGiHbL8qkErAw9tAn32Ob0/rYi8lYl
 PzGj1/D9eU9xuUjsYGyQNV2EVBQR1qkhIsYxuNgfDm0a9yZqzWmkVemjHznCceGDAztiAS+srvd
 6PcWZRJ19jhh4QnpmKuM36ruywyY7j38j5K6KpViH0TAB7vCQuXqx/l1D3EENsJhQihUN3YQcF7
 n5q+Yb7UtN7A0KDUYEVzkDyRQZo2UAAiMyLszGV6CjU2R45wGDUvKBQ1pWRsoHv9Sxyy882O6+3
 Kuk5OKsOcoFh/lqExkA==
X-Proofpoint-ORIG-GUID: fUnb0jmrlPIjIRUXa84Y-vnkIu7YpKgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_RNG to eventually eliminate config IMX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-21-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      | 1 +
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 45a67b1ae6c2..53f723661cf8 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -483,6 +483,7 @@ config FSL_IMX25
     select IMX_AVIC
     select IMX_FEC
     select IMX_I2C
+    select IMX_RNG
     select USB_CHIPIDEA
     select WDT_IMX2
     select SDHCI
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8cfc390afd33..d9991494b7fa 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -94,6 +94,9 @@ config IMX
     select PTIMER
     select SSI
 
+config IMX_RNG
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 90f3f89de701..cebc5f0d6ef4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -64,6 +64,7 @@ system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
+system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx25_ccm.c',
   'imx31_ccm.c',
@@ -75,7 +76,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx7_gpr.c',
   'imx7_snvs.c',
   'imx_ccm.c',
-  'imx_rngc.c',
 ))
 system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
-- 
2.55.0


