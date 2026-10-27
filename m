Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B3F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h7IqoofB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eVx5gr8q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmmV-0001K7-Cy; Tue, 27 Oct 2026 15:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmT-0001Eo-QM
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmS-0001nP-8r
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHPof3553880
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Uy+06dFWCh9kmfbQFfAJ7+iz6nG0WFWA/XD5hnsIVl0=; b=h7IqoofBqM2RLCfi
 gXSlQvicQndLW1ojJrWDmFyWFgDf+Bxpr7yn4UniN6rMrmpeQmoTmLGuhR8zBwzY
 lO3zT2dOQvMokRnmO+goju64JugrYS4VAxErL9Nn7NSLRiEdbisn4g7E/CIjiDlg
 0hE0xiR87/4v0fszqWgbRDh2A5KV5eSYPbEZbPggI4ZzCjpRIpAEpbsCz0qo6D7a
 Z8vX9ACwTHk/Utk7fAKgrVIB6dbJPOcP+kIIlX+c13EDhbKs8gbbR2HNj5iM0gsv
 f7bBrUfJzWcwMTfqpl6cgF3EiTSg40PMhyFw2wwx4oW2vfRbYPJf+itGIe96JLEO
 LE5hHg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22wd4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844e383so20870185a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129059; x=1793733859; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uy+06dFWCh9kmfbQFfAJ7+iz6nG0WFWA/XD5hnsIVl0=;
 b=eVx5gr8q4OMjIO6xDX61anyD+bzlEBRnuJ3d4rNs3oaGLbyOYnBZJpNpxRVO61xlob
 nibPui2OEsuqdBiKD8VjL+sl4ApmYNV9rhdnGlPWX3g9YROCh5Ky36d3jvC0cy9lfv6d
 5cw7nnQPpyZGQSr4qyTHAcIQLTMmvJssYqF6Ax10KUx+vDynPOjgHN1ey/K3P66dMKg2
 r18d+tP/JjfTq0Fmoj3yuNdwLy9emtMA+Eucv8+MKxwUGI1k7n+Bvdnkx/0WW4cybN34
 KBH05Hyyp1naGEfpyMFfIiWX71PYNoaRij/jECvDfhxT/l74iwedzhpmxVrBkHS8BVP1
 qoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129059; x=1793733859;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uy+06dFWCh9kmfbQFfAJ7+iz6nG0WFWA/XD5hnsIVl0=;
 b=M37DHlC0O567RKa2k98M/FSL62a7NLjmv/kATv+SHYA3c3NIWfDz3+KXi43AKYDsU1
 YyYQAz0m243bqeGluKeTqM8n9BfffMH+Ck8Yjw47Sty6la0iT8IG4sUP7H4A/u2Z9N2K
 TlckFiNHj9C5pe5ZWq2Z/HivTpfM264uStpE6CUId8Pbbjj56i6Opft9L7s+775OsACV
 KyKmBOWIJEOlepqXd8Yezem1ZPsO/RO5rMMfNacyZjl1HxRfKR+hECSbO6D+lzNTH54l
 clgWe5jbwvfXcL3nbBhu0TKsZl+re2YwT3ZaaxOJq+Nz3nCvvtL6Yq1YzR4V++n55mH5
 fEMg==
X-Gm-Message-State: AFq9FYLEOkXPnMCO/cnrl8Rhfu1SwTsg0l//BtBGIokpKnXYC39TcBAD
 z2HCoMEGNZQgN4+s4p2n1p+Z+57KuMpZZTw/ve6KI/M8rOjSKVxIcrX18senIRChVMWAMj+0DSi
 YhgVqJCYjZcrLIzumM1PrEEDlFJbWP/N493s5wTjAqYV4ngdkPy4XaEb1AE/dBUjsEQ==
X-Gm-Gg: AYBFou1/YKvUEgFsGS5oLPsktJsNnDSkCDuKp4k14pkocG3mbG3DjEh04p2O0/nn9lA
 +GCoU1Q6WzYIFBGxo9t5GDzd/F7prj2BsX+G7Oe1Tzwy+JHnd4EmdM4TV52XQVE+C1KrnLfYBwC
 FGwHqb7MfSco2SdubJX3l53s6SzL9xIeodoMVSNRzKgL98Zy8rsO195za/Xlx6WA1wdGwdJRhUd
 6tiZrFxrcLYkDfjxWJT6c0TYuW+EaNr7L+Fyl0RF53Mz/AaTNjl9jyXyBtXQVBpCkhU1NSnS0af
 I0uLO5FRjPkRdIcwwA142WoFGHdWAbZHpPj37oiYI3IsoMHc7dSU7xEYzKurP1TZWJuS9JcQE2N
 pDPX05+uvmP2OlousTCS8iWC0nVo++M6GF6MeFjGjE8fbzsBUmLIBKvPW
X-Received: by 2002:a05:620a:8004:b0:93c:b10:7243 with SMTP id
 af79cd13be357-940ef7cd3c8mr1549906585a.5.1793129058655; 
 Tue, 27 Oct 2026 12:24:18 -0700 (PDT)
X-Received: by 2002:a05:620a:8004:b0:93c:b10:7243 with SMTP id
 af79cd13be357-940ef7cd3c8mr1549902185a.5.1793129057945; 
 Tue, 27 Oct 2026 12:24:17 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb8e0sm23754001f8f.29.2026.10.27.12.24.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:24:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/59] hw/watchdog/wdt_imx2: Clear WDT lock on reset
Date: Tue, 27 Oct 2026 20:22:46 +0100
Message-ID: <20261027192341.9197-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX355Tx3l+qPF1
 BNlYgb9YS10M2Ht7rIJpJCGFSs2WqTjdcXSgo7Xu/h0rb2R+pYj6wAxUQiGQxSCCfbKjopIEqry
 UiJ59iMyTXIieSD9uegRoMW5unCOX4uM+y/NSXfM1JTfaBjrWZ3wexXzQCdvSAGDIOnpahZNwnm
 eO4kpE94AcwKlkzZwqT1TtBebRC3Yrgt0iE54rabq+ql4flJuM+50XctF9LdNGeCeie+sdBRgT0
 Hv8kr87aHVW7rEbzgefiRbAWgKHhHlowAJXDGJeN9thHIUeo/ElzPRMxhZk7H5Acpbhr0Jz1WXR
 HyyBJ6fkzZFj7dN6UQvvONZqXCPUQhburfGW2pqRrXXGUPKg7EodjYE9zLeFAdffScZyarxrzZ8
 k5OiyUuhZJY7TB1ijnloe14jzvnbM9JIgk6dJr18jWawD5Ne86IUVKymoMA/0RouTdgNZbou2PF
 sGicz/UAPmz2By8RaHg==
X-Proofpoint-GUID: _YGjLK6vDIms4jUpRU67EvCTCg_w_fhd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX09l98oypHkk3
 lkAbpupq684tLzn5RUlJzbu6Wf8fjt9HU2u3+DCmqio4cgKJpyckRFANnXoo7887BAouT3W2HLv
 T8ryTbIHSEuV/c1pOMLFmGVLH4CPk5c=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0fa63 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=FRSEYCzRAAAA:8
 a=EUspDBNiAAAA:8 a=TJlcyGJ42DonENT5ft8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: _YGjLK6vDIms4jUpRU67EvCTCg_w_fhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270077
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

The WDT bit gets reset and becomes writeable after power on reset which
imx2_wdt_reset() represents. While the WDT bit in the WCR register
already gets reset, its locked attribute wasn't. Fix this inconsistency
by adding the missing unlock of its locked attribute.

Cc: qemu-stable@nongnu.org
Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/watchdog/wdt_imx2.h | 2 +-
 hw/watchdog/wdt_imx2.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index ad36b8820d84..fc01fc46e736 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -85,7 +85,7 @@ struct IMX2WdtState {
 
     bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
     bool wcr_wde_locked;        /* affects WDE */
-    bool wcr_wdt_locked;        /* affects WDT (never cleared) */
+    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
 };
 
 #endif /* WDT_IMX2_H */
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index d897ff6e52b0..a15f452d4890 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -60,6 +60,7 @@ static void imx2_wdt_reset(DeviceState *dev)
     s->wicr_locked = false;
     s->wcr_locked = false;
     s->wcr_wde_locked = false;
+    s->wcr_wdt_locked = false;
 
     s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
     s->wsr = 0;
-- 
2.55.0


