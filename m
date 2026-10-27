Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ED5606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SoVToIcC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cx+CzMrI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmmd-0001gW-MC; Tue, 27 Oct 2026 15:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmb-0001cd-P2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmmZ-0001nl-A0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:24:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIIALI3486335
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MUjZ8XQWa4jEU0sjHQQGBqqsaGxHNot+06srkoDCqd8=; b=SoVToIcCSpeWap4V
 QtkcSlXRbWKgTeiRK+nXH0g6m/wer071l7CC1OR8nUTdd/TtpYebQGseG1U7oNDN
 xgXIU+qLukMfYkc+1KQTYDAsS0wj/Uut/PmYPiMxAE2Hql/OLT2/NHQ1cISRD2HF
 JM9vFd/ZGB+d6je/lfMxRw08M9w5h6u5Q8TJJWqMkoIOrY992OsaZ2VaqV4ZQlqG
 FUYE0hhc5XZlhlM9i9TqHtE5pJGGfi2vVwQy/hVpLb3pE5anUj+Cha5pH+V6urJ8
 gw8AuMCuR1gQfYmxSTOwPKNFHiQYfBf4MBpVXieAnCYw2jaZkWWOdg7wnAc9lGxQ
 bGrOjA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtc2pq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e92aad34aso29180685a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129065; x=1793733865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MUjZ8XQWa4jEU0sjHQQGBqqsaGxHNot+06srkoDCqd8=;
 b=Cx+CzMrIAusyJRl8AsIcBQQ+Qmd7ZSHM0IndxObj+MRqlwsGe7dCjshAoJ6TWtkfjv
 K7lQOgOFnt3Sn/DbfHU2bZvhelAriwj5L/SP/Hv+IvK/wlXTJtD96G7eUC6rzg4SpyL1
 KuVeo58O0mc1pw1adwsWwD4JhrE3U6LZiOqhI6Wl9D5yPMHSIrPM64HyU19y5wqSkPte
 qPkR3xOp6idgDO/0RaL2utx3BIw5LmFPtWXw7fMz4+syy1w6Xxvg31xvzBGvzHVCO6B1
 jdrZcF0HyEQTkNc2KImK4C4ON39RdMK67fABQKzKA1VlauoMPlGRA65sHt/AJIOVW/fP
 ZGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129065; x=1793733865;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MUjZ8XQWa4jEU0sjHQQGBqqsaGxHNot+06srkoDCqd8=;
 b=eFAV4+8kGLrtX7e5yHUZzZU//FjVXDqZVkmu3W4U4OgjXluh/jPDlD92MZxxYcUmeI
 jIKT/OWr2TLvgsM54q+dto4Q3usjDq2/sBXhbhu6A6gilRpOd/FP2qWUIbiPn7HwVbUA
 N/q11ScHWZvp67eIq5FsHzjhPM6y1gHtDrLB8DwP9k6WQgXe+SeB1cWFBds1WpjOMFeh
 zx7uLo4wPUyxZ91aWu3TBby7e5jhh4Kyi9V3A95ruG0E/423tjRGNyjuScceHBwcYE5n
 KuVW04G0RCDSFHv7sdFeT26d1uHJ2lMNw/SH2QZFDDCcWqgU+33hqaLsQNC5ZGhU7mWj
 7CXw==
X-Gm-Message-State: AFq9FYJBaOb3zLIBNvLgeDkAOPI1uezekNtruofp1MCJt5LizgWsxzwz
 ayDrdjV1p5ezKHrNgh8t7dQgq8B+3yZLmA7A8tw29IYvWtpXU6KlIPOBxf+BT3IJMkC2XyTaqVz
 oPMv6Jlgj5xyCwarmpAu6xcjk0U9T9smSv6fQOdp67mgwtxkzEfOOK8+XUhxPq6Q+FA==
X-Gm-Gg: AYBFou2yTZkwL3cQ8Cr/OEqQ3geQo/NaRItWMNvs4yXBWMFM0WQSgkfWWZ2KY1xQ105
 VurS/Ztl3pLAxOz7eWT0+N45o5WGX8C4Wpyi6fa8gfGXoewmhjXAyYd/IX9Wx9+FQ+WyVJvQkbc
 EAz3MrG/NyfjiZbSYkJThFEgBBmVDPkLhVOrB+lZ4tUAy3u7A21k7/W1J83weVZYIpphjB/JmUq
 WBdjyWGFtiVXn7NGG78BPAmEBUoqUToD4phi8Y4Cy4UOFTR5STUSoXJCaKDQ4Tx9aCLolTjlyOH
 1b86e8/6d9I70yNNpgEesAgVH0+hta9E5jf/NUdiJy5eM3Y4UZmfysoauKdOMwEvA0x7+Eu9TBA
 GMPz5HkJ8Tv3aNZw4crICoK2tyFWqTQ73gO7T/uoMYwU7f7gmAaUwRxm8fAL4q7YIPbhq1FSZNM
 Ilz7aqbCAI4d1JAMn9N+8gvd90WZx8Bg==
X-Received: by 2002:a05:620a:17a4:b0:93f:633b:ee1f with SMTP id
 af79cd13be357-940ef914daemr1744461785a.28.1793129065348; 
 Tue, 27 Oct 2026 12:24:25 -0700 (PDT)
X-Received: by 2002:a05:620a:17a4:b0:93f:633b:ee1f with SMTP id
 af79cd13be357-940ef914daemr1744456685a.28.1793129064775; 
 Tue, 27 Oct 2026 12:24:24 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a952541809sm2032945e9.8.2026.10.27.12.24.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:24:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/59] hw/watchdog/wdt_imx2: Remove redundant attributes
Date: Tue, 27 Oct 2026 20:22:47 +0100
Message-ID: <20261027192341.9197-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX78MSyccoGGHR
 eyS343HbXtKdicvhVg25SjvGf/DbQvIOMyUtVcWK9S5HhvWqtK8lFc+dFF0002Jmjc2eeP8MYzL
 q4g6JB+nX4xrlx2L5gWS5PMnZwm48N8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfXxwriJM41qWn7
 DyQRR9aQhmmIGvkaa3J93McQGUj83AAs4gfPG5jZUm0Wr1u/bW9X44hF+YwfiKlWWa5t+Ez6oEX
 Rq9c29cu6MFm+hlJqIUcOfdRXTeqLoHcxo0EqDJjQwACHytPHH9Wd6kCSKmIz/F4/9hhN6FtQhQ
 Suqa3jc6jS/ME76TEAZnkU4OoAb6xFk8S2k1l93R0tPSTlex6zJx474TSwPafUoeMZdDLFkbQtc
 Aqbqiq65pT6ogRMRVfd4k+JG9CowOCO8Gm6SqyJBtnZ29+8+4iztCl9xRIzfdsl8xMKk85P/e8/
 avWErwG1Lb6VPMzJCJsOJb0LLtNWaQ+eAkKhZfQ2bJKLZtyOaPIwy3cLOR4A9UP/CGx2wrrZrTG
 IkqnxqAl5dj/Rk3x8kzlMe6N4EHNytZg9HRI5ORzI1PUX5Ndr+PLlloge3GsPwfoRYrzUObsa1h
 9a3YoLY+1Id4adhFw/Q==
X-Proofpoint-ORIG-GUID: Ki_maxx5cmwzmQw7lJ_H7KCiPXls1uAq
X-Proofpoint-GUID: Ki_maxx5cmwzmQw7lJ_H7KCiPXls1uAq
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0fa6a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=GO80KPNTYNr9SaPhIoMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270077
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

Since WDT and WDE are write one once bits, their values always
correspond with their respective locked attributes. Thus, the attributes
are redundant. Take advantage of this observation to simplify the code.

Note that removing the attributes changes the vmstate structure which
constitutes a migration break. This is allowed since QEMU does not
guarantee migration compatibility for i.MX devices between feature
releases.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20261006083445.30362-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/watchdog/wdt_imx2.h |  2 --
 hw/watchdog/wdt_imx2.c         | 20 ++++----------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index fc01fc46e736..0bf290395980 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -84,8 +84,6 @@ struct IMX2WdtState {
     uint16_t wmcr;
 
     bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
-    bool wcr_wde_locked;        /* affects WDE */
-    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
 };
 
 #endif /* WDT_IMX2_H */
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index a15f452d4890..c19f0383ad74 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -59,8 +59,6 @@ static void imx2_wdt_reset(DeviceState *dev)
 
     s->wicr_locked = false;
     s->wcr_locked = false;
-    s->wcr_wde_locked = false;
-    s->wcr_wdt_locked = false;
 
     s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
     s->wsr = 0;
@@ -156,22 +154,13 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
     switch (addr) {
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
+            /* WDZST, WDBG, and WDW are write-once bits */
             value &= ~IMX2_WDT_WCR_LOCK_MASK;
             value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
         }
         s->wcr_locked = true;
-        if (s->wcr_wde_locked) {
-            value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wcr & IMX2_WDT_WCR_WDE);
-        } else if (value & IMX2_WDT_WCR_WDE) {
-            s->wcr_wde_locked = true;
-        }
-        if (s->wcr_wdt_locked) {
-            value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wcr & IMX2_WDT_WCR_WDT);
-        } else if (value & IMX2_WDT_WCR_WDT) {
-            s->wcr_wdt_locked = true;
-        }
+        /* WDT and WDE are write one once bits */
+        value |= (s->wcr & (IMX2_WDT_WCR_WDT | IMX2_WDT_WCR_WDE));
 
         s->wcr = value;
         if (!(value & IMX2_WDT_WCR_SRS)) {
@@ -234,13 +223,12 @@ static const MemoryRegionOps imx2_wdt_ops = {
 
 static const VMStateDescription vmstate_imx2_wdt = {
     .name = "imx2.wdt",
+    .version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, IMX2WdtState),
         VMSTATE_PTIMER(itimer, IMX2WdtState),
         VMSTATE_BOOL(wicr_locked, IMX2WdtState),
         VMSTATE_BOOL(wcr_locked, IMX2WdtState),
-        VMSTATE_BOOL(wcr_wde_locked, IMX2WdtState),
-        VMSTATE_BOOL(wcr_wdt_locked, IMX2WdtState),
         VMSTATE_UINT16(wcr, IMX2WdtState),
         VMSTATE_UINT16(wsr, IMX2WdtState),
         VMSTATE_UINT16(wrsr, IMX2WdtState),
-- 
2.55.0


