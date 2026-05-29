Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF9ECD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 01:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSmDU-00082e-G2; Thu, 28 May 2026 21:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wSmDQ-0007yz-71
 for qemu-devel@nongnu.org; Thu, 28 May 2026 21:40:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wSmDM-0002YX-Ic
 for qemu-devel@nongnu.org; Thu, 28 May 2026 21:40:46 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SKkVrI1540472
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hc/4XavwDnE
 9cden9W2CP6uolLGP4NfepAX7g8ga/NA=; b=jtK+s/glntFbGffDDfAPW2jOASO
 fxcG/XIu/PNylJGwdNyS5n8a7/ZNRrMnACK5twBkNfa7LGlgVUKs8Yw1uJCKF6qf
 Gpa9BujkYrXKZC64Bj/V7qoAWN2eeUAF4qXMfemWqVKQqqJF7dQueltg4bgMztqm
 MjMJr1t4ttDHX/0BLXHcAoGI1omzfia6EWfXnjRik9AG04y/Ty1nJl2+3xu+XjAs
 vdtwEkECBzECfFP9bOH4ynHvbNnyMKysT7T6gO00J21lx0oX8rYzTi3GSOF7o5H3
 n/BH853F/diyLvQTu8I4mVdDuITJDlYHl8WxSb60SOG9mRlnx5PJ8VrF4JA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety4sns2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:40:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304df51ff3eso1060707eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 18:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780018837; x=1780623637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hc/4XavwDnE9cden9W2CP6uolLGP4NfepAX7g8ga/NA=;
 b=T5/iYF6MQrNw0q61WuwJ2SJrzQi+kgToa9vdTaD2NblECMJ+/uFXDHoipWMb9w9T/V
 YoyoMzUZDMqhQKdBGoBLjl+QUiK1RcZurm9Mw/q1Rdu3HrK6AzmNxN3IyJcft1gHSXx/
 mmaJHEJsvSePMoPXKJ3hZlLfdgdanP2J3EOZvI/9xzBkUD+DRzzEEy0l1OYga+82wDMZ
 Wl6KUPTkt3MgbIXCJfwMZC/kUfoTuI3hj8z/UZRWvIlw9Xvi/tjomL7eKZuDamRmAnRE
 6qsM0axqrru5TDaK5RcI2m5ktwWw513G5m5ybNK8xLbu65lVZmgTRublBS226iMeR1uN
 nr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780018837; x=1780623637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hc/4XavwDnE9cden9W2CP6uolLGP4NfepAX7g8ga/NA=;
 b=kYXPeMtzUThqFBibF/DtVPW1J5gEOGwAfbOTMKug70GwDlD5ldQ+xbgQPZaMe3Ectj
 zu7MD0ozNKP1dVu5dXT1ojSrmH1ttPR4qTcaeVlS/wYd7i+mZOioQiTWC2nRJtoDDt99
 kFFN5FRsefDn+5IHwSr4zMxVGeRpHV+XW12a8iJs/oiOeuLsd00G2aVOW9jHy3LJQi5b
 Alrwu3GAacL3GZ+rpb2iDCDilQd+yD9yBPyc6qOyccgnoLYvCqm1WR0YN6e5iIRXr1YN
 BIZx31Sy8OHuVsySpI7slTRTwSIPDvNSKSi70Jxj4efQc00hXBxyoRkpV1ALj6Cl4agI
 6rDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Vg9SM8tMbPkUnGHBwAmLVPH8tvNnFGPB4MNzz8a5w+zAa+b0xeX18PxpEFf8GDpl7Bh/dH3dWNd0M@nongnu.org
X-Gm-Message-State: AOJu0Yx1KUde3M0Nik2jDreRpIENiYUY6yPgvI7CaFYvrlNCE/QpyMgL
 xfw0fj/gbD1mLouUOOm88ca+RQuIj1QtJIBhSYSThqB9NRJ8ZzC8POK0LMEO39JXKlxInMscE81
 ebKqz+oH57Bbj1HyaKqiH4pL9RpybyAWPTmsXIhIoaGY1P4x9rE7q0hfY1Q==
X-Gm-Gg: Acq92OHd08CCNUNLUmPfDt+v4UY9t4qIN/os4iZgi5a+LsK0TujAupbK8L3gb1j3f+T
 /fPNxcjYnsdrt9B4Un/8qgr6A7snrkX7YTBAslMDUcoZuifwrqOmAE+LixU1miybcEDeHJI978f
 rXWNYQYkfsWbO3EMIyEao4/hBZTz+qjmf06l/G+7KOLigxVPfZEAHu0TzT8ew5KtwuL8f/ZCmix
 MpKLFFirajFA5txMioCkq3zEdktDbUjrzJnrCUKPE6W7wayh8HjBxB+4tOWXy3d9NPfC79Hxxsp
 BGKOLcKhTyhG1xggETSXqtgx7qPhtMbup1sTf2+40nJl+lqHktmn57fcCcozNgu4/V3qTGKy0gc
 2nC5tU84J2U7T0Ohia/HHjZkQdyVQurRoPBpXYBKdkfrlBtCARkMk5RUjTOwtzwlNvr7BG9uTWC
 2Y7H4oJuqMBxo=
X-Received: by 2002:a05:7300:5710:b0:304:de43:130 with SMTP id
 5a478bee46e88-304ead928bamr423654eec.2.1780018837110; 
 Thu, 28 May 2026 18:40:37 -0700 (PDT)
X-Received: by 2002:a05:7300:5710:b0:304:de43:130 with SMTP id
 5a478bee46e88-304ead928bamr423644eec.2.1780018836547; 
 Thu, 28 May 2026 18:40:36 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm237263eec.4.2026.05.28.18.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 18:40:36 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, jithu.joseph@oss.qualcomm.com,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/i3c: fix CMD/data FIFO depth reset values to match
 real silicon
Date: Thu, 28 May 2026 18:40:33 -0700
Message-ID: <20260529014034.864722-2-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Kcp7F3vXb5Dau6NBVOaODLyhJPOR9zrZ
X-Proofpoint-GUID: Kcp7F3vXb5Dau6NBVOaODLyhJPOR9zrZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAxMyBTYWx0ZWRfX3zbsZVOd7YM+
 5hNs0FS9wDUqjp1lCStjTQjzjz5dPFAlVj2v4wjqZJET53wnfQOs8Cx8vQTPpTKIJIR9N+/tuGp
 6il0KxUv3ZQcQVDDqjBE89/vqtpkyeiQZrqRssdgtuyhkRThJJJz8num1rIxBd63X12b9fxrbHw
 ThSMQkKY7mx/APQ1l2EfVX7kfhkoWM0Q2kvLZkc6Md7ZyyPKdQhTdtix4FNNr7pH8w5e2OrMZ+2
 BiCPjIJ5Wj5mgZtkvdNndx4C+tmJhnojZU/c2Mk5kv/XbG+kmRCqcjuIbt8avQneWYczFyKhiNc
 Q8OJ9CPFhmmsOiXSi5W1yFgsDB2VwanNoOcymPHGfsDh+ZIG9zSKgYyj6QYCoxQW9IRsDYNDb9S
 3TcXfauzlL9kKAJHEMV4dvlKxBevYcqhXIM7nXcQKxQ43kS5nfDojh9idOH8kG7pYuAAztfmgye
 kDNWZUl2pdbMPqIQlAg==
X-Authority-Analysis: v=2.4 cv=S+TpBosP c=1 sm=1 tr=0 ts=6a18ee96 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=elZh02Osp3llZ84QUAUA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290013
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The Linux DW-I3C master driver infers controller queue depths at probe
by reading two status registers that report free queue slots, which at
probe (queues empty) equals the full depth.  It then uses those values
to gate every I3C transfer -- any batch whose word count exceeds the
advertised depth is rejected with -EOPNOTSUPP.

  QUEUE_STATUS_LEVEL        (0x4c) [7:0] -> cmdfifodepth  (cmd slots)
  DATA_BUFFER_STATUS_LEVEL  (0x50) [7:0] -> datafifodepth (32-bit words)

Per the AST2600 datasheet the reset values are 0x10 and 0x40 (16 cmd
slots, 64 words = 256 B).  QEMU was advertising 0x02 and 0x10, making
the kernel believe the controller can only do 64-byte transfers.  The
visible symptom was -EOPNOTSUPP on any I3C transfer whose payload
exceeded 64 B (datafifodepth = 0x10 = 16 words = 64 B).

The underlying FIFOs in QEMU were already allocated at the right size
(fifo32_create takes word counts; the existing defaults give 16 cmd
slots and 64 data words).  Only the advertised reset values were
wrong.  With this fix the guest sees datafifodepth=64 words and
accepts transfers up to 256 B.

Fixes: e974c6957576 ("hw/i3c/dw-i3c: Add more reset values")
Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
---
 hw/i3c/dw-i3c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 17ff484c5df1..e1bcf083210b 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -282,8 +282,8 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
     [R_QUEUE_THLD_CTRL]             = 0x01000101,
     [R_DATA_BUFFER_THLD_CTRL]       = 0x01010100,
     [R_SLV_EVENT_CTRL]              = 0x0000000b,
-    [R_QUEUE_STATUS_LEVEL]          = 0x00000002,
-    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000010,
+    [R_QUEUE_STATUS_LEVEL]          = 0x00000010,
+    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000040,
     [R_PRESENT_STATE]               = 0x00000003,
     [R_I3C_VER_ID]                  = 0x3130302a,
     [R_I3C_VER_TYPE]                = 0x6c633033,
-- 
2.43.0


