Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA685C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3Ui-0004wD-Gm; Thu, 23 Jul 2026 20:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Ug-0004vp-S1
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3Uf-0006AC-8d
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NMStkw697119
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2E+d2cOmS6x
 1rKTDiBbNQkIW4FjPxt/CcEDHDBgw+Co=; b=f0B/TVApCu3Cc9rsryKXDSO4VCx
 VTUYr16PwLs3gbLyI1fV0Mve8vN6cUZF/f1GO8uDvVTLouz7FIDO2iu03jUcJDIf
 uLo/lnvqVzdQMjSjGAG8d67Uho0kNZRmvfM1kxkTo9RIMZx0QKbTXRYxmzAyRFLk
 O3EcnEYQBKEn+U81UHPv1b6L6LyeL8S3kumKsXjJcMtooD46+ooZ8dgVM/YdXY8Y
 IsmIK7k/sHoUeyFmAtYGJcjhnwEvZwtvlk0Oo5K4leIkGZa/Yg5OmSFrBYpcnLXX
 o3s/PWXKKHvmaaRCVQVcd1gFvJ6hABveLzEktEy+4s0UkuINIQNVOd+JPTw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkusrr7te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so1679087a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851823; x=1785456623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2E+d2cOmS6x1rKTDiBbNQkIW4FjPxt/CcEDHDBgw+Co=;
 b=GrjsIEvHtYdJw7khw1vtuLeO7L8uxQ3eBewUUdXzfbtoDq9Z1UpQ2KZ8WRoTkSs4Ys
 hrtdT1G7yPre8rF/KN9DgKtG90Ty8nKyAbM+/mdkAGJJTr3o7uoZBlEIctkz6eYPCDe2
 FmzTlOqmKBA+6ZeMgo1R8L0kWxzDEWuBxxPhXTLZtlENCQdUtKN4Y2Y0ZMe1wp1umxO+
 ScpCRe5J2JOhZ02FNAb/PFzyCpoBx6QFjJAQ2i9S53dCjm9zPtLT2TjsILeOdhIJJcHg
 mOEYZanQo4BrOZXYPhFkd7TTOf6UIRJKjv1TuMCgEulFdqvcv14bT0exNp/5hFmdihQl
 RTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851823; x=1785456623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2E+d2cOmS6x1rKTDiBbNQkIW4FjPxt/CcEDHDBgw+Co=;
 b=iI9DRygssvgZR31DhYvZLf0PthtPaDV7OOHOx7RqMjSo3uv64tPppgy/C8+pFcmw6l
 glk7gX6fQ7UtrTL5bX5M3n0JDptKhYnsMvl/Zgtyxc4Dgn5EPlUzDS2PekWPn34GeoTa
 hlELzEQXSblJVWxePIC8/ztlb7BkCJC5Afrf3LNuDlJCgcGbCajXEEm72tnssYU5U9tq
 ptsZBzdxfopKYpTzNa6/NT6hwWQ8tUtBbpjYytbW7f0AKStAXniSQykp2wAGWAbjtwo8
 rQr5HZVOtMBgOIzADZeLN1/YWhO9w3n3yWKQa5wOaYofEStP8vfWW9SyEOwwAjo0mZ/f
 uMZA==
X-Gm-Message-State: AOJu0YwgF60PWsY+f+e71RSEkPSwIRZMQzep/kcHGQPJ8Vvgr51o2HvW
 4QAdtO79EGyjnNGmq0TFsH7nWb4Xba6bP90tduG2ABseaLunvzaXv+BWozMk4JXSogjLdY41mMb
 rpzAlEThxFCHMPNQkk8IUK2F11x31ZA6/WCOGaGr9nBeel7wZXKRG+8rCS4aARJbkBg==
X-Gm-Gg: AR+sD12/AFhAxeUIpcSBMoa8kiJ07QfPTWC+o42VLkd+ETfu1tyiqqbtiqBX6GtLsEs
 f2BZZTe35l3eJPEVHfaH9hW2pr9Yt8Goljo2fBwJksE5JGuobWsLEsdJDwfouUmE4p1PO9awkMk
 yxnfVraAz+t34hqjFUfWNcdNpf3MnhFNnzUqKMroljNdndr80qHiPgKUnmu+OMhJZkHVVbA5z+c
 QppAtTueTcFUz2D3qN6edR0rfzmVHKHVAMS3ZrJItyXNf1DeomE3kJ8uN5dQFwl9zUuDSRMpT7K
 S4ZdtF3HK2rrB5Pha4PUQEtz+f721qdgaLY5WHgN83L0JKtfreiXh3+6imbtg5Rqj6iFqxhnuoj
 s34EejpRn/gk4XacVkpAmt+gFgLIgL3oXBOMGBVR887fS1SvdBREjpqzQ5EFiquDtQTVo38o=
X-Received: by 2002:a05:6a21:e082:b0:3bf:a0e5:999a with SMTP id
 adf61e73a8af0-3c44b18de48mr5831092637.48.1784851822817; 
 Thu, 23 Jul 2026 17:10:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:e082:b0:3bf:a0e5:999a with SMTP id
 adf61e73a8af0-3c44b18de48mr5831057637.48.1784851822415; 
 Thu, 23 Jul 2026 17:10:22 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 19/27] include/hw/core/boards.h: add
 DEFINE_MACHINE_TARGET_SPECIFIC
Date: Fri, 24 Jul 2026 00:09:39 +0000
Message-ID: <20260724000948.234657-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX0nmNSzoT43p0
 iY6IMHNXfWQ7WslmjlYANMZ/IUZeJWk99pZWsiApDuRcxLPjvo8b9ps9bt6clA4kNWIG8aM8tid
 wVdD4pIxUYorKyuX2LTC/3V4MeAfsv0=
X-Proofpoint-ORIG-GUID: EQaXYcbi14Oc_iwVH-t5Bz1w0017XeDc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXyLMZPDWuSEou
 0pPM64peY5uFKNHJKt0/rU6xwm93fQwJ4L7SbYcvqcYXCCVufv98Y6IKOfzVy+nmidLAmM0aqtH
 jdTSs1xVfYV5QOAtlVmp0n+cq0KeYdpBKhj0obwxRXwSSm2vZ0uFS98fzFoYDPy97FPDtmfZczi
 esRegJnsOuUgXfQigqYqnZmWjUaz4SduP2Y04Qmnbsfa/KWzWrpGXBGvtgta0s6WFVP6Zo6vxtX
 Nye0vBksDP3TNcD0JaTaSMyZVkSR1ZG6A7e2r7mAeGGwktsF3OSAfkbf1hUUPy9trAWpjtmFqMq
 hY5iTLX0AeSyXkITNnc/zcoTxiaLarv6pE7dgDwFtNzrw/2Gk6F1n/HWDZ3hMrdObXB13xmo4Hy
 vSJ9y38xxUQDMzR8ExIUzerkqzyXjEhdlgbKUcaNeldsPkv73JSm457/AkSqoTFximgUBuXidrn
 2mG8zN85eRvOouu4HIA==
X-Authority-Analysis: v=2.4 cv=PtejqQM3 c=1 sm=1 tr=0 ts=6a62ad6f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Drpi8JZk3zr7esNuAscA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: EQaXYcbi14Oc_iwVH-t5Bz1w0017XeDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/boards.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 29c68931d8a..c963e956157 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -8,6 +8,7 @@
 #include "system/blockdev.h"
 #include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
+#include "qemu/target-info-qom.h"
 #include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
@@ -546,6 +547,9 @@ struct MachineState {
     DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
                                         (const InterfaceInfo[]) { __VA_ARGS__ })
 
+#define DEFINE_MACHINE_TARGET_SPECIFIC(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                            type_target_specific)
 /*
  * Helper for dispatching different macros based on how
  * many __VA_ARGS__ are passed. Supports 1 to 5 variadic
-- 
2.43.0


