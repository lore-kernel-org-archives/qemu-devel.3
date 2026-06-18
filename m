Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2282FCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBth-0003W3-Az; Thu, 18 Jun 2026 08:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBtg-0003UJ-0J
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBte-0000jO-IL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:31:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArtA61536484
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SkWy2cCfro5fILwyqdNmMjKTti2o3MLCOXnHNIeSWv8=; b=m4MjwBK+PA8JwurS
 nIyho/bir2DjqOnYedyeBaSBhhtV5CEQWduhMWGhRIUvgP0iKNsaTfV1plotV63O
 IYuGp2ZsZ44P1qh+2ZXbvggqsRQAGXy52D4nrYzqxGfVlFoEZRjGttyULS37qJpp
 IURl7xPe4nHl9yRTGZsUQ+keTfpuTHS+FjRqiqhCPet78KqFKX9CnGqion0p/XDh
 y1chgusHjw6Vx4XRfgwiF5MBhj6nLQUTA5aUzgM8duKewhybztVo5InVwwhPuX9d
 0ETHdqVkmUePFKaJ6NhtotOwDmcT61CebkZZFeosLGIOIXkOC+Yt1K2CrBj1WpMb
 He9wgw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kkcya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:31:01 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6cfd2462acbso1147930137.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785861; x=1782390661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SkWy2cCfro5fILwyqdNmMjKTti2o3MLCOXnHNIeSWv8=;
 b=a5wn74xbadu5ei12Af6S4W7rL8pCSi7UV9Bc1iyyCKBVRjKo/d0cdgcPstOl72ceBc
 nysWB5ixmTS6IHJQ/Rb8avRg2D7GK2RmPSfobhj8o+23T/fHNRyx/gUJkmGQo/w/KdxJ
 i0vfz247crWvd0aIkIUfB8PDfxsBw9OlvSv6SzkVs4GyLW1yre49w0AE4QxVWf0Yc7EK
 u1gBUMJ58xIL1xhycMS9e3Gp95tmNtocuc5PiMzZ4Rhh4pdEl44InodOZ0op10dKi5VD
 OWpbTOd66dCb3CZYCSc2gJ1i5bnrLQnExI/RKwVqnO6v41AFXcDlQP+JC3uDvu5xL2o0
 Hmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785861; x=1782390661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SkWy2cCfro5fILwyqdNmMjKTti2o3MLCOXnHNIeSWv8=;
 b=U2D1G4AR7OhIkVfBEsbOydUBmlaFZljmLb3GKcHLer8rNroZ7aB27YeMUPOK9wglk2
 7Pi3fhE+Aqh76oV+/Qy2xZ948PFaPKNlTt45xLvGPyBnesB4KdzQiZjQum6ICaLXxOLW
 dQJ0V/GhuHFC/vwDP5BRgTb2128vFX1ugZU/aU6qTn8ffI5kwILVgwiOvKsI5vvQKgZI
 aWDdyQC6yi+MzagmZ65TV8DL0XxTv2jYreybz2fkedLvdbboPd+jN6mkpVaCao/tWtCR
 0YDTCAeKizTbfFzr6HAtiijsoN+jRYMaoGP1P/i/QJEcFW/ledDR6nyYpXLdf3nKPkas
 DdRQ==
X-Gm-Message-State: AOJu0YwqTsic0OrSuCa3ppRXy4VJuEP1FD6We4uW5aPj3XIzJ6MpRYiP
 SJ7bWLbum4Y4VN6OUOl7fVDQZNTyuCP053ob24vM8+o5ON6UFGL5u/I6UE+8ueNqRPFT6XotJHh
 4WaxrXkKEF75bpJGZ50KULyBxvhszNl/63iECgmSCWQFplr32zHB1qGnC6W66i6NzQQ==
X-Gm-Gg: AfdE7ckOcVeI1Qv1QbH4EP6eTWQrobslKpqGCZ8/Yw7fh4r8wsgBblttaWpMvoZlO5j
 vkBOywmS0Nx38RVHEivqfXoZ4QHMoRkuWiY3iPtFTT0DcZHdaPfDEfanpSu+og9sL4OeQwLE3QM
 RHj2gR1JupeGczasDUPDeWXQLbcDzPBYrRAyVo6r9h9VYo7hhjcEPd6Pwbo8931g0OzyGyg8b63
 SGCb8zVPMoa6pAPwPWnZNuc4vxA1jIkgCOGOkcU+XHBnDEK6vctHrhXmWCwAn6+9tmBXw4VSz2l
 mqrPI85K3zrMiXzJf1henClMmsbt8kh0Z8K+TKRbQz9hI8AzhUrueHJyCXi+bTyXVegFJ4M+nWx
 Tk2EyzzbGiDDW/HXWjLLe1wRDVBARQXtZYys9nK+GFuPgU2h/EwsZEstM1i6hNkEYZFqs
X-Received: by 2002:a05:6102:443:b0:727:48aa:f604 with SMTP id
 ada2fe7eead31-72748ab1fbdmr2139617137.28.1781785861014; 
 Thu, 18 Jun 2026 05:31:01 -0700 (PDT)
X-Received: by 2002:a05:6102:443:b0:727:48aa:f604 with SMTP id
 ada2fe7eead31-72748ab1fbdmr2139576137.28.1781785860551; 
 Thu, 18 Jun 2026 05:31:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4ff67sm253214545e9.6.2026.06.18.05.30.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:30:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/48] target/arm/ptw: Restrict PMSAv8 code to TCG
Date: Thu, 18 Jun 2026 14:27:58 +0200
Message-ID: <20260618122825.90331-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX3PxPRNm6cCzS
 SoEIYpIYCTJRgzrLAv0M6FAbeZtiZ64MhLvOU1CDGsZeIqJxlCgryQJoH+EegDY4+Sk5OkfhROv
 TBXs62MehE1ZPHy0OGDx012sbwWq2MfM/iHtbdlFU2JcUvYIEm4aj+abKvxiXzXTBMC5ntyhiy7
 fFgSQ2iq498EOJMf/FJBjZI3tSh+LvPcV5GgcZ0v5cfRrdrgrbqKlgQ04gFBKfhbyzheAgiSf9/
 7nbRhIP/bgJyNkGVZ2b5RqA4VNhS68mV/WlgQl7lOUj5hITczu6TugvcEKyUUDCWxZlUzef2Z4m
 kq8QSo8GbDX6ntk1ZLqexlQ4rnwZLzfMKIpf+yUl9e3uAcckSr5BrQ3BmzZuWOI9H3uDCHvX3Vi
 z/r5aza8aTQcxmsILCrBQKXo/2rKpTyGvOTGD5XrtJCcCM/OS9AF/sNRQ/kwlcTo+e3PYfJp20m
 GJpLv10ZAfBZGxBJNnw==
X-Proofpoint-GUID: 3DBNcMUGlxrEqxOAiWVYTY_7g8y9LCJ9
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33e505 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=wSUaFbrerrTpWb88fUQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3DBNcMUGlxrEqxOAiWVYTY_7g8y9LCJ9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX5xw3eBo8iK08
 gkX70ONG5HlMGIS3CRBEoglQCtl26o/8O5DkMu8/H/pCSUIkTXOnDLqhJJUZllvTHR182wlrF6s
 Vp2tIbFeE0n9G4/opcMci1NkMBEZUfQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Armv8-M Protected Memory System Architecture can only be emulated,
therefore restrict it to TCG to avoid compiling it on hardware
accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260616153432.92939-3-philmd@oss.qualcomm.com>
---
 target/arm/ptw.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8b54018c988..1470de30108 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -13,11 +13,13 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
+#ifdef CONFIG_TCG
 #include "accel/tcg/probe.h"
+#include "target/arm/tcg/idau.h"
+#endif
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "target/arm/tcg/idau.h"
 
 typedef struct S1Translate {
     /*
@@ -2818,6 +2820,8 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     return (ptw->in_prot_check & ~result->f.prot) == 0;
 }
 
+#ifdef CONFIG_TCG
+
 static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
                              uint32_t secure)
 {
@@ -3247,6 +3251,20 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
     return ret;
 }
 
+#else /* !CONFIG_TCG */
+
+static bool get_phys_addr_pmsav8(CPUARMState *env,
+                                 S1Translate *ptw,
+                                 uint32_t address,
+                                 MMUAccessType access_type,
+                                 GetPhysAddrResult *result,
+                                 ARMMMUFaultInfo *fi)
+{
+    g_assert_not_reached();
+}
+
+#endif /* !CONFIG_TCG */
+
 /*
  * Translate from the 4-bit stage 2 representation of
  * memory attributes (without cache-allocation hints) to
-- 
2.53.0


