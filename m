Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276C606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IyEckdRR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X8FFSeFV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmmU-0001GT-KR; Tue, 27 Oct 2026 15:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmO-000183-J0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmL-0001nE-Au
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHODZ3553869
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T8s0fnPifKAzRNUMw/DZqxbEDA4l//VDmIcbiHGjQ1Q=; b=IyEckdRRpMiTUL8E
 6ZdJ2oLTBttO5r27Ak/GY1i5epSG+snMjUHYqPkifVu26BGjD2JWX4hXgo1Z4tXW
 pY80EWVIdb0CQD/u/lX14h/00DAo68zm3ghHIZeQmtNcjNXshKxHRqoGDIr9KJ56
 7jGD4Trmvnuhe5wzdb1n7ajTyQ3rAXixO3giZ0rMET4VwKpJ7Lv5vd0YeypxiACH
 SQpYCc+6IbeK6DvdxV9U8afK1NkygTRZQsTdwRmwk6uLRoWLTzksktvEEKpiCVxK
 w/fj6Al3uJ6Mr4frab3ptjQRVyAPncNI8lWMyDJOjX0sGJiq+rq5No9DMqAZU+TA
 2MmwSw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22wcr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2373e9b4so13759185a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129052; x=1793733852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T8s0fnPifKAzRNUMw/DZqxbEDA4l//VDmIcbiHGjQ1Q=;
 b=X8FFSeFVb3TQtB9+7o+UDGW/IiaoaNCja5wU0gvS1UEO2GTz/oqbHx8fMAB2ddh2uG
 6c1700vvccO7fluFto8gcmE5N5dVeRsjnyDSJppDnX8zDi5qiAAJCXAL09FO7ogJ1Uiu
 PWevJmLmvkL55kg+8y9bMy8aPYhaek3EX+y4ONlx4shFr2wb12K1ikgnowyWoQvPVV5W
 qsx+Nkco0xPfWwKyDuuqnY88WDTmpV8Dqaq8HyWFc/2+qFJowfUYENqbW32atMW6/hhn
 CikuqaUPdyICeFqLM+Eg6+UJaEXSJ+LrnbAngepv3cDQcRUGMPYiwImGpXDHAs2/Wspv
 ZkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129052; x=1793733852;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T8s0fnPifKAzRNUMw/DZqxbEDA4l//VDmIcbiHGjQ1Q=;
 b=ERn4SUY8QQSltrad71xWs9y2mEjA4yX9HEqmyjkJ9omyi062hEcSqy9tmtf+ahq0ca
 8n5hGLPBAps73D/KuUSYvTrZ05NwH8rNntZqI1+O/LFVJrj2qVy32zyeCR8Xuu6GS8Me
 MUVddnno91na1s4eNsJ/qxjI2TFkUtNSXW2EQxGAfLdZhRllNcyNBJrLblx3oQktK/1a
 FttL7HsUL4gKH0jUBBjpJeIzKSd68Co8QUD4L+2Sp51HKqneA0ncjNwi2eDFvUiH2DbH
 88aNXdp7lCbTDu0ckB24rVMawByVJN01KLupwy6thleHRxLA78FFBLWUEu6njngRre9L
 zR9Q==
X-Gm-Message-State: AFq9FYInpq52qqgGtpej2LL78F5vYYTjKICyeNYaBlnpxjgC1kpDgFaK
 Cr7E7LtGpnRzopzeBnullxBj2RR0f8AlP65iJOi3VwkagPKVjj1dWcXKZ0ndpnjQSljPoggg+Ty
 j3FGspD+TFja6TSKucJZ/l7dxiQtorIIEgLMQ/iS8nrI4drcDrzoWC9C+caMpCBZOWA==
X-Gm-Gg: AYBFou2J+WWXFryHsQ8Az/bjcRBcCEoBEHYF/K5Vx4cuT/2QTkTuBGqbw8fN+Mb+m0n
 a01J9RqhdKrkGZfhXpbhle06fi6UgDL9grY2PayWce5pqtW6PiICWMWLnAmOv2hKNX4laxc1k4I
 joKldJqizdYvc6I/jTl3jhrckINmg9Xj+9+EmGSjdH8cWJpYMivFUe5yBQdHQ7ZXpHHVks6ywB1
 emQ8Y2ngSRJ3tEdaqF0xITeizjqaO0TPODMBZYM6xc7751aa2U8fF82lla8jBKdsG2FA5o3JPPe
 U+InGCOap6HYKvbU+1dvgl4eHng94+gpkuBHvSy0V8jl2vbXjU2SLEKW38Lo4BLxRNQWLzBIrLh
 AhpWjzNMwVII+iam/1RQ5V2CRh1SApcD174Me6d9/IPNygJCjLRa1xlEC
X-Received: by 2002:a05:620a:4413:b0:93a:2611:270f with SMTP id
 af79cd13be357-940ef913c7amr1584500985a.13.1793129051723; 
 Tue, 27 Oct 2026 12:24:11 -0700 (PDT)
X-Received: by 2002:a05:620a:4413:b0:93a:2611:270f with SMTP id
 af79cd13be357-940ef913c7amr1584496585a.13.1793129051202; 
 Tue, 27 Oct 2026 12:24:11 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94e6b8290sm2952895e9.9.2026.10.27.12.24.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:24:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/59] hw/watchdog/wdt_imx2: Fix handling of write one once WCR
 bits
Date: Tue, 27 Oct 2026 20:22:45 +0100
Message-ID: <20261027192341.9197-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX6AUgELWh5iaQ
 h4FW0fdawalz+/s6dyeSYSBNW6xutW0FBuueGSW9DpPOtnuLGKP4E6IbkwjlA9lS2+341wFTtYK
 grbVxfsZqF0U1ApONkldkPzWl1aT0jSe6MKStLjGDI4v1I8x1RE6NqYPHFm+O3brWe5T+iB3jQG
 fldrIWsHT2fH4EGsxLDAQYEiCmB8E8DXjV4s1dmMGZbjYnwtyy2qktw80vhiNY+d8BiBafwywiU
 J7qrvrw0CucQAG3FOGKOm4Kkg+a1WnzmaSBgNfaR2OWFJ7VHEiT0wTipP7Tj6wArPA+Gmy4Pqzu
 IRGtA3FhlCsq7lv6pbV3aFBIlSQRGXydyz/LjoWhCDsHygauyfhF6rjIZxexpLopVhIXbH/J35X
 qM2huJt4pspgT1anO0Ev+j8Kay0U0vw79xIF1sTv7bxMrRjAMD738DcNyQNtMYt8ZvOyfATpxBX
 if5Fskp8AMei6lDWO8Q==
X-Proofpoint-GUID: EZsCxf47i-A-DFfrkA_okgMcAKwiqneR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX7mafzEQ+DDL1
 Yc7Cai24DW/+s6lwKVZP3sas8/IwCikUPJ5Gmm0wcW9uYbusmceDhXXP8IiC5ldi6v7lqKaDb3W
 2/JxyFEWs2BCgoNgI5kazWNFCxnhjLg=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0fa5c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=FRSEYCzRAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=OQTJR_iXj6gm-c6kepUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EZsCxf47i-A-DFfrkA_okgMcAKwiqneR
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

In locked state, the WDE and WDT bits of the WCR register are one and
need to be preserved when written. At the moment, the logic is reversed
such that all but the locked bits are preserved in locked state. Fix
that.

Cc: qemu-stable@nongnu.org
Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
Reported-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/watchdog/wdt_imx2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 3283990bbf88..d897ff6e52b0 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -161,13 +161,13 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
         s->wcr_locked = true;
         if (s->wcr_wde_locked) {
             value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wcr & ~IMX2_WDT_WCR_WDE);
+            value |= (s->wcr & IMX2_WDT_WCR_WDE);
         } else if (value & IMX2_WDT_WCR_WDE) {
             s->wcr_wde_locked = true;
         }
         if (s->wcr_wdt_locked) {
             value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wcr & ~IMX2_WDT_WCR_WDT);
+            value |= (s->wcr & IMX2_WDT_WCR_WDT);
         } else if (value & IMX2_WDT_WCR_WDT) {
             s->wcr_wdt_locked = true;
         }
-- 
2.55.0


