Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D4606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XwHmfqsf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dHI3RBBJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl33-0007wS-7T; Tue, 24 Nov 2026 02:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl2w-0007vL-JR
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVl2u-0005RU-IC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:34:34 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2k6o43701261
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jRebKjtZONDZYMu8y/NwvI2S2smh/6YpJeNEBml2pYk=; b=XwHmfqsfiHpkl7oZ
 g9NCN+pKF5mmTzIiLNDs80uh8eEdYwPLnclIFfXP8KYwXIjQnJwwcdA788tRVhX7
 QR9IJMzmrbRYJc89KJnBlJtvFswQQqZnkULRa3s7zEYzE5Q/cpmEZ5Jo18hauFle
 1go6F7GEqTPYiisnSNHoDInaBgot+L6/7+aq6Ezw5oiHwsMLCKHtJaokg1zl7CIy
 da448gkdmiYlJJpw7Zoorm5U8GFR0xSYRxo0QA+6NnPuI7rN0XcRO4iN4A4lgz5A
 dXDWBBy5iXzqOF7SPTHFqoHZDxTEWCjUz66tiqzxNfjEXibvgCBrHiCzmRij4Zdn
 qtV7fg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky1a2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 07:34:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9495a1f5e47so681715085a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 23:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795505670; x=1796110470; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jRebKjtZONDZYMu8y/NwvI2S2smh/6YpJeNEBml2pYk=;
 b=dHI3RBBJGAEhayEAAZsoXH4zVS1EidJBnAcl35FNxTapYCS2mwf2Y9N0e3e1/lvXZP
 Noi6vTbIwIfyYuNG0HhxWI5IAGOm3Q+jykn7uF97prrzE9ffpetrRc6tkDuHWhQ5TTWl
 OJ8LFN0bn1jAUUDCwekPa18OHI6KjcPgcXlSqX5wgCwswkgWteEjA6HMgoXZKJFVYo8k
 QxLzdZ/f14EOq22Kdu92PSb6c7rC4EF+pmvV5n8HRUtSRl3P/XjLS2KG00M7r08nTAgz
 Os9G6ecvWcFsUmji+FZc4HWITfBCBaxHzayoDln6WQln7xiAcDv13YNVFfr6ag2UJkUw
 y/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795505670; x=1796110470;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jRebKjtZONDZYMu8y/NwvI2S2smh/6YpJeNEBml2pYk=;
 b=d74Yf4p5rxzEviQ+mIllZXe+DyjCkc82Myy5y6obf9aAr5cpbyxTJiN1my2cYLtDI8
 L0KWR+AMnrxw05My296zhpZStsOd0lmKeHX6jVsjHikq+gCbqnTMONklLVol7Xgiv7VO
 kUG8WAJNOnDaunikFC1MfdK++FfjjuE1Auuat5q/KUU/Ys4E4ywSkjna3/o4cpGw7Z5B
 wfs8jcTVRLT5IvX8xu6ntqusMzbCyeajBq4hAyJFYAMzhnYq6YdvhspWbInGetSMQo8v
 BCjLcvyv0REMPFm7ZVH5w3mM4q7LS9D6DiMO6Nvx0O54Te7tX2C0bBmOSapSdd2lu9Q3
 OJsg==
X-Gm-Message-State: APuU4Z+zi8b4W51GBt9WMNEIq+MVhUVxm+/V4q2BoNo0MxbI3rB9y3es
 1NiEKb2WaVQ0AKEBzbD1r4DAqW6sY/AOjAFRWoRamb62ng88ZnQGeRWYin1AuJ5mvaafAJszllu
 BTVqdyhjw7P9VijIQSd/Cs9sJZhCscRsAFj3cd1SPugncvuXzJtQESYWSWQRU3ZTtNfbR
X-Gm-Gg: AZFdTZfkM6c97fuscLnnivXUlQk6qhWOfCZGfHGvR5ATl3FP4Q9OB8IuZeINYd2/8x1
 mF2cePrW5LBklNxZtQ40pE0VjDizDlkT+dZifsDPYMZbgNIF4urZSYUbxI4FdSjk+y/ywuouQcp
 N6G1o4PDu5xwo9zSD6lYnq3RIPzFvx0e64u+inAQcVXzgtIqThG7nj3VMSpAdU0zNccQTZIaVE0
 mslFDhxA7WRBst6+b7EKxI7g0iMREmQFaWuO57o028CI925NjYOUoF/iud/4dQfrop0Vjw2DQ43
 NW4FtubGsCjRgFg7w0CXpqeWbP8ujv3MUp/HRjLdRkNylicVEW2odp8+4CYVlKYdXh95CUPKCEL
 mNPY54rl91B/ls5ZMhG3fPTDAYNqlP2L+TVm357EznZr/Hwyrd/kCMmK7kswGX2qrFtb3ZPjdoJ
 iZDHbNRmgXGJQtaQ==
X-Received: by 2002:a05:620a:a1d0:b0:949:c86f:886d with SMTP id
 af79cd13be357-949c86fadcamr1657897585a.12.1795505669777; 
 Mon, 23 Nov 2026 23:34:29 -0800 (PST)
X-Received: by 2002:a05:620a:a1d0:b0:949:c86f:886d with SMTP id
 af79cd13be357-949c86fadcamr1657896085a.12.1795505669292; 
 Mon, 23 Nov 2026 23:34:29 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b2c5sm413485585e9.5.2026.11.23.23.34.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 23:34:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH-for-11.2 3/4] hw/sd/sdhci: Treat Software Reset bits as
 independent pulses
Date: Tue, 24 Nov 2026 08:34:04 +0100
Message-ID: <20261124073406.87537-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124073406.87537-1-philmd@oss.qualcomm.com>
References: <20261124073406.87537-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b053e06 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1oZRn4_ppHO_UlGkvrQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: wuHRWTvFgPrEs1V6cPvjh9CyG0pklocf
X-Proofpoint-ORIG-GUID: wuHRWTvFgPrEs1V6cPvjh9CyG0pklocf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfXwkuA59+PDzER
 arceaWpvAPGUVB2ii9WjEh5w3Ud63N6CugW7c9Z7w7Oi0j46NgTovIP2p6RoaH2PcYAbpZ7VIzR
 vyOXA164SOE0URBWs7e9AKXqcFkvq3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyOSBTYWx0ZWRfX+kLyoxZdI54i
 NvS3kcED2XgwDWDbwXuYAGoMPYek5bYf5um17fNp4DLVR97EOfIhuBdOlFI3y7KjZPMQG0iidXS
 XLrLo9jwRflqdsayDoqML5lWVX44WEdUNJpiGS/hE0Bb27JLG673ok58QhHA/MyA5ZwfOXLT9w7
 XwDi/JZH1VYvKP8NyLynoFhMwm5Fat57Wq+Wkcfp1m9e5gTyJTyPurz5NJLjZGFCyfMsmhh9iw7
 cC3bJDoRbszuC8aKCtY9HUJWExc0CYCbsgrYswAIHFdLQ+xSvBYiolN7MRKrdpp2Icn405OOCGt
 IYzMDb8Q0rNbm1iMkg0buFdp7+kxP0x2IbuV1kNVga27ohe2VlTM2JxGWvX3T6/AxtUuWvJL4n6
 0y303eVZdQIBtxBAdrw1NMrPNkGWWXrb5OkU9hB2E4C4xkPgQrRCxMXhfLqn+HnkUzXIUe+RRiO
 cyW6EcibDslTk5tJN4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Writing Reset CMD and Reset DAT together (0x06) reset nothing, as
the register was matched against exact values.

Apply each bit independently. Reset For All still resets everything
(SD Host Controller v1.00, section 2.2.16).

Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4745
Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 695de6448f89..9bdc898e7f54 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1237,27 +1237,28 @@ static inline void sdhci_blkgap_write(SDHCIState *s, uint8_t value)
 
 static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
 {
-    switch (value) {
-    case SDHC_RESET_ALL:
+    /* Each bit is an independent reset; Reset All clears CMD and DAT too */
+    if (value & SDHC_RESET_ALL) {
         sdhci_reset(s);
-        break;
-    case SDHC_RESET_CMD:
-        s->prnsts &= ~SDHC_CMD_INHIBIT;
-        s->norintsts &= ~SDHC_NIS_CMDCMP;
-        break;
-    case SDHC_RESET_DATA:
-        timer_del(s->transfer_timer);
-        s->data_count = 0;
-        s->prnsts &= ~(SDHC_SPACE_AVAILABLE | SDHC_DATA_AVAILABLE |
-                SDHC_DOING_READ | SDHC_DOING_WRITE |
-                SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
-        s->blkgap &= ~(SDHC_STOP_AT_GAP_REQ | SDHC_CONTINUE_REQ);
-        s->stopped_state = sdhc_not_stopped;
-        s->sdma_boundary_paused = false;
-        s->norintsts &= ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
-                SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
-        break;
+    } else {
+        if (value & SDHC_RESET_CMD) {
+            s->prnsts &= ~SDHC_CMD_INHIBIT;
+            s->norintsts &= ~SDHC_NIS_CMDCMP;
+        }
+        if (value & SDHC_RESET_DATA) {
+            timer_del(s->transfer_timer);
+            s->data_count = 0;
+            s->prnsts &= ~(SDHC_SPACE_AVAILABLE | SDHC_DATA_AVAILABLE |
+                    SDHC_DOING_READ | SDHC_DOING_WRITE |
+                    SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
+            s->blkgap &= ~(SDHC_STOP_AT_GAP_REQ | SDHC_CONTINUE_REQ);
+            s->stopped_state = sdhc_not_stopped;
+            s->sdma_boundary_paused = false;
+            s->norintsts &= ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
+                    SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
+        }
     }
+    sdhci_update_irq(s);
 }
 
 static void
-- 
2.55.0


