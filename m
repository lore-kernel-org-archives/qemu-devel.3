Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12BFC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlmZ7-00085s-Nd; Mon, 20 Jul 2026 07:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlmZ4-00085G-VS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:53:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlmZ3-0003Ur-GR
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:53:42 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KAvlTs2458147
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3gyoZecx2HuCCDG/JhJkdO
 8C7TK4ySlCA12puV1Bnuw=; b=dIlzbbpP7s/+3quIGcsFLAUW5o2eK41Zt6r4L1
 BndgCpj2pRHIUwqAV/OQX06tVSIJk3AhgWit38u1PpWH9lcJHF26f9oLy44zJUNF
 7WlKrXoEuRxjqan6N/RHsgguJ3FkYh9ZFF+OcWQE6nqL9LR9lR7gv9+ed56X1bPa
 aKvLXKL4gEVcnUhZwrXCiyVTxfGj2pRynD9NqcjBP/0oGWqcle01IhmbyxA9Kv26
 8fpOtwipIeJzyAdpmxJ00yPk8EkPZ9OwefZqVQJz/3Zme+Swkw8Ip8R6jQTNkl7v
 ZgDw3C0IdEz4o64TWUMjAJ5vC0O+FM/h595AdrJn6fBOkMCA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0ks8b3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 11:53:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so239801991cf.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784548419; x=1785153219; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3gyoZecx2HuCCDG/JhJkdO8C7TK4ySlCA12puV1Bnuw=;
 b=RroD3TDL5g28iyfAhAN25THsatun87F0uWUaaWW34kh3XN1hmSyOx/0S7in9Vs035I
 uD03Ljg4tk3tdlQAs3FebkXIgUOyMsEVoSng0LxLZj+HymunVq//GLsXQtZ2lTKlJ0xR
 28zBvALJMRE/kRTfcoH4y3KUpxbc95nqVDZSHR4VyAbtdAWABS8FZ/DEnjicmrt74a39
 5pDleCnmCdH9SCHAZ7Umsz3qLX+0ia/CYY/W4gsDIVpO2vxDqZB+GWI4GyMG3l8PD+eg
 mpL49rJGreLkYyhSXXb8Wgw2zQVhvVtfy6ZVyzaMabCae6jPWEZz+ogQ4Y3uXhJfewFP
 gaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784548419; x=1785153219;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3gyoZecx2HuCCDG/JhJkdO8C7TK4ySlCA12puV1Bnuw=;
 b=YYlqU407JOsaVCqkuZTGdmHk2sggo5nZE6aw3sz2xVIOswRebvCBPdfCD4akt6PKGZ
 scEntPUuq+o0o1MNmvLm3I6/Hq3lTKJZK8U2IxqvE6/7PPYVue4AjMrbeB1eAY3oh5K7
 XeFTTnlTMGVmQKBEuvaypNA6hoDfdEEKWSoBE9RTuIfV1v9r1/ygVhVcibzvQnv5SLKP
 8wgQ8H3pViVGgiAU/VS9EG/hdxBKKWNYN5vRluRFE03VmBZSYDrnxgk7mDUQvq4QliWy
 X+rvi9aa+GYxyo8gmeL2djU6F0WLx82d6kuxRgnJvTC3YFGdWP+gCfkBAypDcQslNMVe
 6uvA==
X-Gm-Message-State: AOJu0YxAEhX++gsQW6JMvQaXBPDLxWrCsSimKI3Pz/ytKTN54xx2Ju5W
 dLZPuO7pi/4yBmr1CmllnYO8PjDr5fasyfrQemiZqkhFsYUDm9N+Ko8p2S2Vgmv7l+s+2HlDp4i
 vKVZln4tjh4VQm39s4BGbbdmtxUJn+NjYKxuUPpHEBiesMalFd3+tguoli1ak6SxxBA==
X-Gm-Gg: AfdE7ckaTreozuoy9le9nxq27Ge5tMTISHAbRvHhVM4DvRTsjBTK9bTX/iay4fR4C9z
 0FIuXF1IiDEDEtgAZgPvMeKk1tIk+UK2NhV1AlNBOrU3L/SUKczm196q/PR5hUhVe6nG3nQRA3Q
 7FnvZhMABQUTWG6lX9NVhBKyqoOesyWw/XbSyAy7F0M214QSjH7p8zYNg3JiKkX8RX7kJCJn+5t
 QI45mT4K06aKzuhJu8J3ZHnRbffCb4oLMgWjxa7XymOX4pSKoQOVe/sWk6cB2ZFYkhnhYgyFIhP
 bZ0I2vVR/n8tLaOrhPEWHhWembd9LcHNktP1jHj2UHKRobC9EK1QVcy9zncBrOrTdqU5UEks0BU
 +H+KYnczn56xFCvK6Tl2tjyhDkWOTv83xqGrCqasaPzPf5YlamUq76BwoBA==
X-Received: by 2002:a05:622a:3d0:b0:51a:8c9a:8fb4 with SMTP id
 d75a77b69052e-5213f2788e9mr123146321cf.69.1784548419269; 
 Mon, 20 Jul 2026 04:53:39 -0700 (PDT)
X-Received: by 2002:a05:622a:3d0:b0:51a:8c9a:8fb4 with SMTP id
 d75a77b69052e-5213f2788e9mr123146121cf.69.1784548418803; 
 Mon, 20 Jul 2026 04:53:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2692a3sm241202895e9.0.2026.07.20.04.53.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Jul 2026 04:53:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Matthew Jackson <matthew@pq.io>
Subject: [PATCH] hw/misc/applesmc: Fix a typo setting MSSD key
Date: Mon, 20 Jul 2026 13:53:36 +0200
Message-ID: <20260720115336.75063-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NcaHcgvFM_N8lhLk2M75jAWDYbk06X5D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEzMiBTYWx0ZWRfXyS871LRqeVnO
 m7s044Y4rOiFTrP1i74Cg93TJjFOc/+lg16UU9YSv/YKyE791J+pVvIzuixy+agG9Yi+VjwRp02
 GTACTM0ygkDi/tNjO2ZjS5iYgBF+sjk=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5e0c43 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=17tSaWqMGGc7pqR7pAQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEzMiBTYWx0ZWRfX4ubYmWG5bR4A
 qQxiJpnTveg8kCpq5iH0BVcdplPrHUrtJ5oR4DWedBval4W2SLR9qcUmx9dGUf9S1WnmM7T2pmi
 dEx/2AP/9sDthDoSmFWPGx2uHcR0i3bTP0xa6hz1B77LE6+JqRF4UBCIkqvT/U6NileUES5W6lt
 4yInzih0qXXk8gcpeji0VhlaaxvrjICgLpf+u6X6/DZ4DwBpJ89OyDhWF1/il24UouJMs1uqcWu
 OUQZ1BgAFz3ISsBdIrHCgbakWIe0bvBl4pPhxInIUxBcRlA4dplQ1whAWtmfCcc55tjzYgVCjo3
 KehMeziFRbni6qy0J3HR4s1lKIctF/bDlIKpct6VQJntRIuSWZ+hfm3IUC4HMBmZV+YSXcPRoch
 wj/bA/TxRY8hOEGMa4f6bA1TMiISP1hcbuxDct+aRmO/E6mwiThirCNqG/Zso3LbZ0LE4PT+av/
 SHlut/A7S/viqOEWAbw==
X-Proofpoint-GUID: NcaHcgvFM_N8lhLk2M75jAWDYbk06X5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200132
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In commit 1ddda5cd364 we meant to set MSSD=3, but due
to a typo we ended setting MSSD=0. Convert the two other
NATJ and MSSP keys to use hexadecimal notation to avoid
similar copy/paste typos.

Cc: qemu-stable@nongnu.org
Fixes: 1ddda5cd364 ("AppleSMC device emulation")
Reported-by: Matthew Jackson <matthew@pq.io>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/misc/applesmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index fd96f5f245f..d004e8b4431 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -333,9 +333,9 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
     applesmc_add_key(s, "OSK0", 32, s->osk);
     applesmc_add_key(s, "OSK1", 32, s->osk + 32);
-    applesmc_add_key(s, "NATJ", 1, "\0");
-    applesmc_add_key(s, "MSSP", 1, "\0");
-    applesmc_add_key(s, "MSSD", 1, "\0x3");
+    applesmc_add_key(s, "NATJ", 1, "\x00");
+    applesmc_add_key(s, "MSSP", 1, "\x00");
+    applesmc_add_key(s, "MSSD", 1, "\x03");
 }
 
 static void applesmc_unrealize(DeviceState *dev)
-- 
2.53.0


