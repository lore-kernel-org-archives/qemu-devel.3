Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D44D2F344
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 16:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfhP8-0002PV-6U; Tue, 13 Jan 2026 11:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1vfhMp-0001lM-0v
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:35:39 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1vfhMn-0001J4-Bx
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:35:38 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60DEjGG44080357
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 16:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :sender:subject:to; s=qcppdkim1; bh=9I+s3RFaLpGY78PprFx8m6igGbVv
 VrkZ6bOrmBQ1jMY=; b=LD9vY1zinV1SLeiQGx7BQgL0LWq0GpD/ebwF2jBPSdzx
 ak/oHmnom4ZZhyV5RJJPDu8nFAaSripHar2BmvBk7FIhShV0NCFCOt8CPZmsIHbQ
 nf8AnorUJ/m78rNSakCVViFMMAq/eTl2Bq38giVp7FrnvkMWiUPN4sYT4OrmA1VG
 iBB9p1K7xsyaLdVs5YRbWUmaCm+pHDoRv+ZuMU118qgDy3GAI85mwPUcvDpB8RWK
 BsyztpgobcLbmikW0nKNdu5qhrAQj3FeUPN5/+6DT1eVZNCmedB2kIWnsQ7vnAUY
 +HHhA68RGDGl0E6i0fMOuwemuXKlcYkGroz5oG3VjQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnr3e8dpd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 16:35:32 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c52d37d346fso2965608a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 08:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768322131; x=1768926931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=9I+s3RFaLpGY78PprFx8m6igGbVvVrkZ6bOrmBQ1jMY=;
 b=EW+Xl8EJAq4zrYS9OyaEHsP8p4jcxzl5PfTHWAAEiquWUOkO93j2ZKj/fFWOaZtcfW
 8zUpVyICcfeopTa95dmaudMOWXmzrBnlerdUBi02d2dsE0s9GD/9F6LsMGIAwN4kgmax
 qRUuk1UJi2xWnJ+Lrc14aGq//dbs4zIxhs+Qg1HRFw0G0X7+YseXwjLnSsR/NRo51FPI
 N53fLJcNdPRBXkuaKcfjMK7XPmtjxU5V+4++s6sblU0PRoQaTP9FX5Zpci9gylPxXle3
 Ocu86vnzzJNJ0HCOcSu1cS7nmvhdmoJj+1tk/mfg+oLVREeSs8qg4FfCS+BFIgCVhNEB
 n0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768322131; x=1768926931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9I+s3RFaLpGY78PprFx8m6igGbVvVrkZ6bOrmBQ1jMY=;
 b=CJAfGrYHRTOcXsiAOvTcDgjRxv5bctE7rrFQG1j81XZu4YtJsA9tm8nGpsb5ErGcDM
 yMOaWjXm7XAb1zuiuZdtyAL1METgR4mB+PbWaJWkE6o//m6Tp9vGb5f1UQ/DDFnCRQsV
 HeEqaLI3R10cTO59FqW+TZjIUEqUO37AfPvt77Z3nE/2rN0H3zwIhK0wRmisAa8h7ewc
 LonV6ho5we4ufMbH25ZNHh64nut5IfInnOoZhlCMewi/s2W8ApLgys7JYaChp4ZvimiN
 nk4ZW7RL/Z7sfK8C8vndUm4bFmDQTOIqY+K7PYKlmPtsAmOOgeZO0EkvzFrCATlf+ZsB
 bdNA==
X-Gm-Message-State: AOJu0Yxh/XkRUFUJ983a11LXZQMesCc/drvGnF2jFRSiw5Om+pFPV5wF
 ntqec3oHTkmHVDVwudIBpaNLNXy0Hi2/8kE6LYnwMYsK2TR0J/VWuqNG8ziQ/UKmhHtBnso7o5M
 p5XpJdHrQWLPMPtCIUxJnDnESVq7Ss6sVJUzFJDCw5wgDY0Pq4+xkQvCwNhEOiIMH9g==
X-Gm-Gg: AY/fxX6u9bBT3tMRcdDNduPcgDHON+PtImaOC7MlkXKm1+5VP8gtJGwY/rSvFbzozXb
 1bp6Amr8y514m1+GW4qfhQOv3rmX2TEIux0626LIesYSTirMaFAJ0b5iz3wQExqXJDxvscJQ45e
 1UnizNbeFITjTrjCXGX2iFd1XRsOmRVnYPJNLQ9+Eo/5+85DczAbqnavhgWFKUXZ9xr1kGTG2O6
 RMxXSgSHALmJDrL+1/4BeUbBYIdJ8guYBog5j3jSPmjisr8kPll/bFiLZYOkGCMUqsvWeHqde6r
 BB7jFVi/NpA73gD2bTTNzipDqd6/4WLnp9ew2TWNPr4URJnEWVVWqAYIHbXeJ6JcaawXX4uWozo
 D3fVv7eGMs9a2e0E/bbWaC1ACvaMLZuUgep9gr/OQVKRiRGlYo+SWNiGt7lDfSQxi7A==
X-Received: by 2002:a05:6a20:1586:b0:35d:8881:e6a3 with SMTP id
 adf61e73a8af0-38bd99c20afmr3401283637.10.1768322131483; 
 Tue, 13 Jan 2026 08:35:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx46vAmQRKPD2gIysc3AbVlOfIGCj0X8YwSqqhaHfM43NJK6xDA6gXk8+j4EPJ0eEYBvd0lg==
X-Received: by 2002:a05:6a20:1586:b0:35d:8881:e6a3 with SMTP id
 adf61e73a8af0-38bd99c20afmr3401255637.10.1768322130985; 
 Tue, 13 Jan 2026 08:35:30 -0800 (PST)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc9e7e8afsm20315644a12.29.2026.01.13.08.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:35:30 -0800 (PST)
X-Google-Original-From: Sunil V L <sunilvl@oss.qualcomm.com
To: qemu-devel@nongnu.org
Cc: Anup Patel <anup.patel@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: Update Sunil's email address
Date: Tue, 13 Jan 2026 22:05:21 +0530
Message-ID: <20260113163521.2857839-1-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TPFIilla c=1 sm=1 tr=0 ts=69667454 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=MJxHuVPQAAAA:8 a=bDdBU3oEAAAA:8 a=69wJf7TsAAAA:8
 a=fFt6l-wJOQKDRENaSxAA:9 a=3WC7DwWrALyhR5TkjVHa:22 a=f8rhrtTnV5ySubrffgDN:22
 a=DN7SgORnOiO7RqxRx1GC:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEzOCBTYWx0ZWRfX3M2JVRQYLwt8
 FoUurey2iRQvolVcAuQYlvaln5kRYtP3a5w9Njf4zK/PvN7yaNTAEB9tH9wKR8EHLlvVi2nrP5z
 yOe6LPAqn8YMXirhqgYK3CRPYZOo2fiYeV/FyfQyvfA7MzX68fPD/4XkaXSLqgjyzfiGumJ9jRz
 lJa8gtmUFGFS74Qawbpl51l6Vnk/9+3TVsaF1cKO+zEPHepkOLed+nLecCYiiNa6ilnmUKdBbWc
 pnSj4/OIxZ5SeK/npZ1akWpV/NxR+vaPIclTfMW2s457Vl6k7wHiU1mq5VOgPz5JsMUIHDYByHC
 0N94j0Ofj5C6E84Ced4IzJFk1myml8ItdoZiPStKkKYpZz36qkXDTYlyzbf+AGAZ6Jek8uVnmi3
 ONX4xvN7kmL/A34m8eJ4CNhfFiTPLJwjQvEa9smnyCCqQ7CbMm8g448TJ4D0t0t5MXo0DReBO8B
 8cMUzKf9OQrHdfFB1Vg==
X-Proofpoint-GUID: thnm8yAV0aljEIq-Wricd-lym0LYwdUd
X-Proofpoint-ORIG-GUID: thnm8yAV0aljEIq-Wricd-lym0LYwdUd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130138
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 13 Jan 2026 11:37:59 -0500
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
Reply-to:  Sunil V L <sunilvl@oss.qualcomm.com>
From:  Sunil V L via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sunil V L <sunilvl@oss.qualcomm.com>

Replace my ventana.com email address with oss.qualcomm.com address in
the MAINTAINERS file for RISC-V ACPI.

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d16e620e01..2248cfeb60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2190,7 +2190,7 @@ S: Maintained
 F: hw/arm/virt-acpi-build.c
 
 RISC-V ACPI Subsystem
-M: Sunil V L <sunilvl@ventanamicro.com>
+M: Sunil V L <sunilvl@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: hw/riscv/virt-acpi-build.c
-- 
2.43.0


