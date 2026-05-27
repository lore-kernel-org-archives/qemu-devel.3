Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0212ECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKUC-0003iU-Pz; Wed, 27 May 2026 16:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSKU5-0003go-7d
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:04:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSKU3-0000lV-Li
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:04:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RJK5si1478047
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 20:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wKvzJM0/pfMzRrRrsF7hHywoPZdYNpspiCf
 KmJ9YSws=; b=NpVol1TAa0+coqjZMAZSQkN1GwvIY0fwVZcs6pHiN+McdaR3h00
 C6zybYMTAFR9eABRVaBp7bTbGJq9vq6GFYnrHUng6uwqWAiV1DWy7C9uaTHImcKx
 wjAIHR2nzeeB6wcVTWulx4lqYyxXu0V0+y13xQ61PcMM08oaxz6IbkElsSjUc/0E
 daITBMuZP+V8JRcaZksyOW0PK1DbGxzQYrOHsv15N9Qrzfcr/GvYTWnQgTSJ1z7Z
 v4gy5Fx6wNLwlUNZk1PjxPQrmmAR8Lfl8XbhoAWeeUfffX9CqMkmUszvHNM+afju
 zsD2hxcJD392RRvCQ7xn9UcVQH9jAhzYuLw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee0a89tmk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 20:04:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516d58f74b0so67337871cf.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779912245; x=1780517045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wKvzJM0/pfMzRrRrsF7hHywoPZdYNpspiCfKmJ9YSws=;
 b=F8pTOwk9h0d8kkbPOifrCKIIU7rrn/9hEWIDmJrUiUKcihOZcFFYApw8l/472CmU3d
 A4pWj8QrFV9FVbdyDZiBA478QPmaljWCkdPCTHMhs4kLnd8wp8uUmByK+xC4Hib5Ld+b
 qG/ZjVu/zECblQzig+dI7DrqvF2vEoPn8KsDL27LhfXPmfi+pL9DYmPYqEznrsu5WuKq
 kI5qweuygrnEIdS6TH4l185XM6IeceAW/v+5zkTpFx3f2RueUdgJ3prT3JdXHpY7ckMx
 mE0JOu36fBNGWyWZMGTnn2ZgrJOeJUZcw9/QcAtHlu67OmuxGiv2xFMxSlPgUyZooHa/
 6jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912245; x=1780517045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKvzJM0/pfMzRrRrsF7hHywoPZdYNpspiCfKmJ9YSws=;
 b=mdVaeNkmZ33SulXFoqjgxDYixaMlWbk4+/sPpdGVeedk03W48Pv4oeicZNIgimfZut
 rGnWliNzke7N7disk1KKv9uBJxmAz2o3QsIQ5fwVooTWke4p9G9Hf0Tpfh1zrsN5Mysh
 uJmvYnINXGMB3S/evcEaUZxF9NL+wtKe75VlxqjlSio7TfuSSqCQ+R/t5Ljh04QyMf6w
 5G0rXsvG3y88qlQvg+jXvoTWUXwhG+q5xB5yfydbipCpsoD5KbZ7m/NHFDeOru9atA1K
 o3QId0+3VnfzYk9lqq57H7+3JrXAOErcR/oUQJBrOLvtTPsegVsQSz6sWmakaJLrouDL
 eXTQ==
X-Gm-Message-State: AOJu0Yz8gHutIHUPy6U98CH0cwWJOD3VyOp/j/+kl8Mxyb7854fJpIwL
 P/Vdb/lBseP50jWSRGRUVXXgsRvbYUaiaTPUOn8mf1XHMLrFZ8KyljfY/ERHTDFnZGkGY3+uPya
 OhvVypCajywMTtBPRg0QpQu0EYoLxUa/rc+hP6Z5xbemwOxfqlra0EVSK9rOWYozDtQ==
X-Gm-Gg: Acq92OE4Mf6TVYzRFRRrJmZSWEZ0culo8bZxWKInGm9Js0ZRPnUX3cV2SUAbxVSJhr2
 Rlp5mtjPHFOaArErDHCT5KtGlCO1kRN5pxX8BWHEBqfjm5x1F3G7qFMTeL3WMZoIxypZWMqQJI+
 8FCPyMPS80psa9BWTasqyLxQEqPjV2LdHW9IGFWSVs9Z5G3luz04B0IARRemRU64EIRHZkGLN9k
 GR4hErlii/NHN117JRgIdLX6OscaUAwMP9IgF9wWaT5Dkhmcn3M9te6OHATl1bkQRPqrkQfuMVx
 1wcU31Jk2Wyk6+v2Ine+j8JKJY8h0XAIp7BMCZqmIQefkRxJYBvbYhp+M8K74lZsuNHXzJr0ozK
 sJ+0PnGwNIqvAP1niUiUi6MZ+4mkbKXSDDWUk9Oo6kqhJ+6OEaJgOypkEMpClr8jp2j5bbQ==
X-Received: by 2002:a05:622a:d11:b0:50f:f0be:dc7b with SMTP id
 d75a77b69052e-516d436f66amr265104761cf.39.1779912244904; 
 Wed, 27 May 2026 13:04:04 -0700 (PDT)
X-Received: by 2002:a05:622a:d11:b0:50f:f0be:dc7b with SMTP id
 d75a77b69052e-516d436f66amr265100061cf.39.1779912239639; 
 Wed, 27 May 2026 13:03:59 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517069f2464sm52069441cf.2.2026.05.27.13.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 13:03:59 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v2 0/1] disas/riscv.c: fix inst_length()
Date: Wed, 27 May 2026 17:03:54 -0300
Message-ID: <20260527200355.2068879-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XrrK/1F9 c=1 sm=1 tr=0 ts=6a174e35 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rzjuppfKegOKSJajtWEA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: zbL9N2JOqz24Il2Zs72T_Ks8cz6N5xST
X-Proofpoint-ORIG-GUID: zbL9N2JOqz24Il2Zs72T_Ks8cz6N5xST
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIwMCBTYWx0ZWRfXzQNlltxZcPgo
 5YxLASJc6Us7GalDGmZJedv3R3sa89Amy5xKOKZbl3CKRl+0uJiJV/vcCk/gekR6fmcGFewK4q2
 SnAfNEg7dnARYdGScRjJF0djkNqyJfDyeKGSytq7OLGHH3Jw5X5/MybLVHA5KAkFBC0CAt7uNP6
 V5bUyCI1SrmE/9iBDReWuGsA2r9SavsQ8276FSJGqZQWH0g/Wum/9XFrgnlJh98Q/SosAQ9p5EE
 CVr+xye6RDMhyMkUbVcOfSodkvYlsjO+AkLwCcaQN8M/nbFpTHSGpCGUhvrSe2bPqrwtuhJ06zZ
 gJjOvCD/YC77gca4o0VWTqZIuDoB0tOLBMIIh5a2JpUepRiJubE3wghF7OaAbxpDiU/4hfrsm6X
 A+rSJYGhz0pK4aCziUNMkJYzzmUlZeOCAHrtUgtn8JA3ilpsf/+CY3LXUJhgWPSEP6mC1AUFqjE
 v+vK04RbpM0rd5t//7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hello,


In this new version we're fixing the disas function by reducing the
encodings we support, which is super fine.  Thanks to Alistair for
pointing this out in the v1 review.


Changes from v1:
- support only 16 and 32 bit inst length as specified in the RISC-V
  unpriv ISA
- v1 link: https://lore.kernel.org/qemu-devel/20260520173522.1794433-1-daniel.barboza@oss.qualcomm.com/ 


Daniel Henrique Barboza (1):
  disas/riscv.c: fix inst_length()

 disas/riscv.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

-- 
2.43.0


