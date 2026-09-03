Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2793C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24rl-0004v7-Vn; Thu, 03 Sep 2026 06:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rc-0004gv-1P
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24ra-0006P3-59
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:40:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH79B3203906
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dne/OGC4mh9pyhzlIkAn9W4ObefJYz0B+1JlIG0OZSY=; b=hInlDRKI7Z1maLlY
 ZeWZ017SS5jGTZV1K61zsk7IvlQHkY1QWzf2iyRpCbuUATWdCQTaVEh/PlNQfXE+
 SM5iqu1C7uC5X1JSzevzlYwwNuxYJfx87TMXNGTaZ4oU8ehHY2blZU78HP7MphHZ
 M+2xF9JmZb63E8aoeYLbJ0bPmnhLtXDkN8YtjwHTGpkhdpzkoRyZcAvK3KvQcNpi
 UCGawf2moqurd5hkO1ahKQ+jWS8XwGKlJ8z6BnO8fxPT23tWtYY48BvGjXg9Ih6x
 Y0WVqQFsf0bVftI/7yaV2HtHv7ENF+uOSqZQnNXbzgRtl/2hoAhkIe0bPyy6sI1/
 Bqy+lA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10h6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:40:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e53b8a302so440549385a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432008; x=1789036808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dne/OGC4mh9pyhzlIkAn9W4ObefJYz0B+1JlIG0OZSY=;
 b=PNaB14/NmjXpwrw8696zC/ahV9Ez3tZIMOQHuRx/FIOMR/toNgeX8ia2gYT/x3FZPC
 Qsf6YgGAekOX3sw5o9uhbV6Au0BB3N/MtUfezKwiqkYzyPt8H8i7mn6Fynp1DwnVw3jJ
 zZkFWOOSHkejAvZREH52fJGZZvlwl/FpKHRVq8tMxD+3tWTkVZG2O5Ou6ue6Obn4/osk
 j/v7fFhsEYk9+20PQMzSCXIGl3bHd+u3hfO4ldS5LmZW1t0Y1T1/jkXbGvSPmB08IjCi
 3iJ07qoI0kPayjZwlH79mp1C81Sq0+rKLmPu6XR0QHd/FhUQUyWxq6YSvgfiSgBdj85e
 KdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432008; x=1789036808;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dne/OGC4mh9pyhzlIkAn9W4ObefJYz0B+1JlIG0OZSY=;
 b=PKWY905PObX6HdIkTRXZwrhEVVZ/07FAGqnfFAtcGytcYvyJGOhqIJ/jS6NDjjWdBL
 KTAIgBdUS4nBuY92fJPFbpG43jt7gGOFqcqG0rQRiBA4lz8Fc6q37lTcEeqMJmounD6B
 tAUt8DnLGGF2OGr1A2TIAMPabR1xZA88AaTcCB+8EzibcbWu2kdIXGD+P3gkFP6bQYIB
 LmYaDc8K2pLsugsMmweUFJYfaio7fV4N9g5XRfW0Xff91QXvtv+3nosmS6cSKGVFiy0g
 32zc5F3aPF22tzL0+KKjQjb9CK5eJlGsB5PiZGtXdVYOy1gnOMqkA8QRWevZ+mIefLZA
 0Quw==
X-Gm-Message-State: AFuF++mf36fyRilNncwxvaZ7bPuU2VkqoR7fagCX3CmZeTety+lDk4Hn
 R+pSb9CXMjNCRIcTnjqmv/PXJeQXwwzwAmI5MblEfEzMjzLBrfgSWH1qSs60c02P3okdx7zfmyw
 zb4iiSZZw5wfjSFtuZGgdz1TinyWQvNwHepGpfkkxIKO6771m+XVZ7HNy+iTN2esYNA==
X-Gm-Gg: AYBFou1lfPzbQszXhaZc/gQPyhPEgROe759pTYi7nwINv3OUscIvqyHv00HWOmdwTmT
 /2tiduZIK3jCUBXCklLt7TpfbpagX+lUQmSoEtdHo6iDcgHrttFv66OhmiV8Ha4AiZLnYog4IpG
 uHsBej85E3xYNOGcDzK0HwipMmFavzA9cuGXexhsn4bnxi+5YYl8tzOTKv8vh4lkH4qD/qj+xWi
 vcLeUdxf2mmH5oIQgiqtm4r2tiDx56NxFdS8bpYfbnMkSKrLeAnHswy+WSwfwpjF57+Zd7uNKHp
 IOAb/ml5n5swWDoVKmx/SquhCvrVyzKeKb8IuYnI8ktAoCQzd2MZgQl1EzdNXgaGW5hUGhRRpXJ
 wRsSKIQiOdm7wx9RVftbFv1vjq8cD/ubO5LgBoc1x
X-Received: by 2002:a05:620a:4109:b0:92e:5f90:c0de with SMTP id
 af79cd13be357-93960f28e64mr1282459285a.22.1788432007668; 
 Thu, 03 Sep 2026 03:40:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4109:b0:92e:5f90:c0de with SMTP id
 af79cd13be357-93960f28e64mr1282454285a.22.1788432007020; 
 Thu, 03 Sep 2026 03:40:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6024a8sm60064285e9.6.2026.09.03.03.40.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:40:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/51] hw/sd: sdhci: Migrate the Host Control 2 register
Date: Thu,  3 Sep 2026 12:38:48 +0200
Message-ID: <20260903103936.62355-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX7gEElIVCTfxX
 gtZ3f4FMMOeBfWbPn48z6qKMUvghUPyOnNjVdoZzhYvVyRT+ZhqugW0nT/5EmSrWDlxmv+QEw1I
 xodJeftgkWfYqhcrHh65tQ6c3AMZmas6zKoAnNicM6sClPmxI+Ha9aHcn2Dzc0YCuAAL5oYeKfD
 uK/yE3blY6BwQDDJlkJ7CLMdsmsysYYUlw2cRkWyS3VirP3Kwv3c6erd/4cG5f0kN+9F8/mo7fM
 DCxCPDB58WfUdaFg6X4Rhe7uI0Cm0YiRKDDkLUINJZlnuKHv+6/17HP6YtX9I5d28fFAq9+M9AU
 Iqq/oZoALKN+1jA1C64UPB5WScxL3smNswhx/dti4ER4oP2wUDgPPSiRd1oeyl4m/iThmQfOSbW
 57sQs2mekTBjwBuepMamwL99ZQ7wv8he/CwVmd6EoI8DD6MmOrJxkgt0+T8kO+K4hM4jh0jIU2E
 gvolEUrElOsFo70IlVA==
X-Proofpoint-ORIG-GUID: Rj0E6PwT7BMm3n_ln5AmlILBUjSO33Wt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/x4MDzwLf1zU
 hYsrbcMBKkdnI0HlUSkyoHYe6v2ovVrSEXObtHMGSz4ce5N5mrYhME+Ooagx9nh4ReYsbCOHvMo
 dgyyolsjR9XMIKPvyqGBNLa02CdhVGM=
X-Proofpoint-GUID: Rj0E6PwT7BMm3n_ln5AmlILBUjSO33Wt
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a994e88 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=pBWpA1RrDOO-fWdppnUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bin Meng <bin.meng@processmission.com>

The Host Control 2 register has been part of SDHCIState since its
initial implementation, but it was omitted from sdhci_vmstate.
Migration therefore resets the register to zero and can change tuning,
voltage, or DMA behavior.

Migrate nonzero values in an optional subsection. Clear the register
before loading so older streams retain the reset default without
changing the main stream version.

Fixes: ea55a221bfc0 ("sdhci: implement the Host Control 2 register (tuning sequence)")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260723151853.2143177-8-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sdhci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 02f09187272..101fbcf2ff9 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1470,6 +1470,24 @@ void sdhci_common_unrealize(SDHCIState *s)
     s->fifo_buffer = NULL;
 }
 
+static bool sdhci_hostctl2_vmstate_needed(void *opaque)
+{
+    SDHCIState *s = opaque;
+
+    return s->hostctl2;
+}
+
+static const VMStateDescription sdhci_hostctl2_vmstate = {
+    .name = "sdhci/hostctl2",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdhci_hostctl2_vmstate_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(hostctl2, SDHCIState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool sdhci_pending_insert_vmstate_needed(void *opaque)
 {
     SDHCIState *s = opaque;
@@ -1488,6 +1506,7 @@ static int sdhci_pre_load(void *opaque)
 {
     SDHCIState *s = opaque;
 
+    s->hostctl2 = 0;
     s->sdma_boundary_paused = false;
     return 0;
 }
@@ -1562,6 +1581,7 @@ const VMStateDescription sdhci_vmstate = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
+        &sdhci_hostctl2_vmstate,
         &sdhci_pending_insert_vmstate,
         &sdhci_sdma_boundary_paused_vmstate,
         NULL
-- 
2.53.0


