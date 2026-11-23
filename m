Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A59606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AEYQYd2E;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W0dC0Suw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcvY-0001DR-6Q; Mon, 23 Nov 2026 17:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvS-0001Aq-Jq
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:18 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVcvR-0004wu-42
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 17:54:18 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANJuq962862102
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NX251KI4AZX0EVz2dDEKdpAg+yp94uTiQl//PlcPbI8=; b=AEYQYd2E09cx1guC
 67Gr3tnF05arPB9iIJ5YmfZ8chnFeLQL2hmGELM/fWirDQcJ58PWSjLBTlhyx22f
 +ydZuxFIAcJGKyCqEJNmLACSkVfEDaAF3jUc9PGvi0Q1H5XfUeW3i0bNZxjuAsdH
 HcxAzTLAOTNbPpRvFxFRPegs+SsCMNJpYw1rjWcJkQSzEM5uLEguRh1IUUZvo2m+
 Jsbt4oA50eJniaPg5/95ZI+nP6oUYJfdC9HPX5h9pflCoK/PqzVkZxrbuCVTEqVU
 bWRCNNqDrCUTtW/WheqO17ipBf/IHEIVwZfzZ1aKB7UNYAfF6Jd/c22WCfhxXYsP
 Ap75Lw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7uts7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 22:54:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9496ff065bcso535763885a.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 14:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795474455; x=1796079255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NX251KI4AZX0EVz2dDEKdpAg+yp94uTiQl//PlcPbI8=;
 b=W0dC0SuwEPLNlkmsepTEy4qE/JeqzjGg65uMbKAd8OeaRkrpZNY1HP0hecE/+4RJxa
 ZJDDfh/pFb5lqgmJQ5DSad8HU35mMi2SZN83yv62I4/0cF/pD2Qoju7iXzGSRkMtzYhx
 uqxUUTIOvlwnKLVs4v/46nxNUhJL189LANZIrR9N4PbK1kPzTwXbajlL9iL5Xm9+O+Vb
 ntgBuP87JT/ReamzSRvQh/amE/j84/MTYDic/NwCIPLFt6OEM2FxHkPa1ymsMyS4nORO
 MP8fqVNzk7hXp9IXOdZJG3i8+MQPqgswo17SK2upm3aBNx5KNB8AUVJnLxiLD3w+gm57
 gtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474455; x=1796079255;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NX251KI4AZX0EVz2dDEKdpAg+yp94uTiQl//PlcPbI8=;
 b=NOTPVbKseGDkSCXBZIRtvGxroAQ/79MvFMSwk9kdu68IvTiMrrm/474TvB+IRfI5AQ
 uDrfNppqmP51HbtYTXiil4UD8F0n5QP8HT7w6MIla9yUixk8NL1z53n/RKMVgBNhbR2Q
 mG0J0rSNr8YGqfnrbisftHOQ0YNZ9m34hjR9PwU+6t0gRlHxbXTGYVkJFTTmlhu8jCzX
 5BUkkqllll6qsHTZoKrpq8hQezZuTnbd5G06LQ2KVWXi9RdEEhkIMJYkW9ZjLjsu9mXN
 lF/rTwYFgzwNC+4/xfyfE+Bif29u+Uyd/WQCl5Lzz4zsKrW2gErhF+OPs1Vm0riYBkja
 1cFw==
X-Gm-Message-State: APuU4Z+nRFV3/yZjIWoE4x0kkyobyf5FiPOMQZIjryjN7IhOqpW/Srp1
 S6fGvOT9vrBHuXlbK2V4qKGA6vYBqvngTcTGLz0VVPdaKl8N/mldlIUsosreuKMly7ZNb6jT/SA
 m68Wlsb8qe3KeTldt+oumdbx4H7B5BvvPAyOUMkscNHxb39tdSTyqeKTTxu3iSPC3Qnlc
X-Gm-Gg: AZFdTZdf8Xj9j/o99zDBOT6kaz7qB9Ejl616+ITcrPzW4xfLn30fx+Rudl4wji/tN6+
 8XU9zBOWHApi5fs/xeAbTchFTcF4W7Yzph++qTci+9rZzAL30sr4+oICYQQlY9Nml7pCPpVLkwU
 rdeMF5eXPNOu746aEUNej3h2Ap9lQykGAmkg0CsRh9ulk6Nzb1X0LwTMnX6xOFeHHxOw23uFq+F
 cQGM6yRHpLvS5aPaNMNj8Lieze29snGeuukweG8L2zwe1t0sQvPV9xWrYnKSEtJ72hjUJiYHSi2
 BriCOhB+Bxx1tZJptSum4zdiqKtd74ZMURhMaE+nZEIna3XMpp+KxJrSNOzj0DLde5VL4plurlE
 LXfP0Lg0KmumZEoMsX18/UivU0NgSUgiVlA0rzvh7EHmrV7K40qb7NFC1SCE9EtfRxIOjHafNJk
 EOJYKRtWFFOLIPVg==
X-Received: by 2002:a05:620a:240d:20b0:949:c60b:7b5a with SMTP id
 af79cd13be357-949c60b8807mr1367589385a.52.1795474455575; 
 Mon, 23 Nov 2026 14:54:15 -0800 (PST)
X-Received: by 2002:a05:620a:240d:20b0:949:c60b:7b5a with SMTP id
 af79cd13be357-949c60b8807mr1367587685a.52.1795474455172; 
 Mon, 23 Nov 2026 14:54:15 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b1ebsm26037899f8f.33.2026.11.23.14.54.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Nov 2026 14:54:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-11.2 3/9] hw/sd/sdcard: Do not abort when writing DAT
 lines on invalid cmd state
Date: Mon, 23 Nov 2026 23:53:43 +0100
Message-ID: <20261123225349.54981-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123225349.54981-1-philmd@oss.qualcomm.com>
References: <20261123225349.54981-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tmcdQlMmN3gOcoI5DONNH7bxZSvWjZbU
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b04c418 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=ti5tf6mvKQuLTk511McA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: tmcdQlMmN3gOcoI5DONNH7bxZSvWjZbU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX9znaxRK4A6LQ
 mSEYhuvEKoxuWh8OisK6QCob5dwDWCDXMmZg3K9+HmSiwxW7ceMbhncRQIWFJamq0XTZkH4WOLq
 VIeO+bRJ3P1YUcTEwdd6nPQuXAQbdls=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5MSBTYWx0ZWRfX4MoT5DykgFLm
 fqYWw88RSbgxKgVJSa2YuFSXESz97EPAOiuagYzBVGnRCs2L8dWbnj9Oc85JhRLZmWorHEJywkH
 tavoWM4MkpW/+t62RSBR80kFtmA5sMtMAZb0v60RPr8oBYpkq+HLxDy+JpRuolegLcjV5jGLSHN
 +LCtox1pumj7swfxcvvub6l7HaIh9oKK218DfI0FSJgMvPm7ryYxyp0J6lfDVZ0WDLUGClL+kB/
 UnoqUl/17GBZj5+HpblKPHTzuLINAXWBprXU0EtX9IEviecOiE+iMfnB/qaO0Ki/4xhSzxKRWTa
 /nijP4IhM+VtZIufC4J1I5xJK0o9BC10fWS5BmIxFDOyLPppvCOd1iYL5l99/beyACVlrCGOHKx
 uKYQyS+1X6L1PkVHi2sxLdKYJsTsJ9RuDY97IwBb9qi/j/20vHyPWNCASL89LvNErKT4GJlzmg1
 M56vK4maDc8cp/1rBhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230091
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

Since commit e2dec2eab04d, an illegal command resets
SDState::current_cmd to 0 but leaves the card in the receiving-data
state. Data written afterwards reaches the g_assert_not_reached()
in sd_write_data():

  CMD24 (WRITE_SINGLE_BLOCK)   -> receiving-data state
  CMD2  (illegal in SPI mode)  -> current_cmd = 0
  data token + data            -> sd_write_data(): abort

  ERROR:../hw/sd/sd.c:<line>:sd_write_data: code should not be reached

Commit bd6207903eb8 already fixed the read side. Fix the write side
the same way: log the guest error and ignore the data.

Cc: qemu-stable@nongnu.org
Fixes: e2dec2eab04d ("hw/sd/sdcard: Remove default case in read/write on DAT lines")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sd/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 04870c7b3962..d82aa35f6f87 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2819,7 +2819,9 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     default:
-        g_assert_not_reached();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: DAT write illegal for command %s\n",
+                      __func__, sd->last_cmd_name);
+        break;
     }
 
     return length;
-- 
2.55.0


