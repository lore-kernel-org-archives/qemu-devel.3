Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BD6FDEE4E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1l7-0002fL-JX; Thu, 23 Apr 2026 17:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wG1l5-0002eV-MO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:38:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wG1l4-00022m-6d
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:38:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NFoSNF180406
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WOSms69dlEV
 u0F65izi2psIjj1p357XYspxgkpokApM=; b=XrBZm9I4kURizBPv9DMTz+p6uVv
 nKXoYdWjX03TCP2xbdCzHfigjgU15lv1j+r8nSuEaj1jD9iHN6FthTOtce0A+U0h
 1yv5yzM7Bz62H6RYfaNXomLfAJiw5tqxB0mLdd3oSEqtSAnyfBO0Pv4nzTqD7LhA
 2+8ydaZG880GcBYmdk44VA1ZD2Ylsbj8oWGadIe9FVziRfJja6eFjlZecDWt00Py
 zudhY/Q3UFtKKCykpO3ftmA9FviuhVaDcQ2mfD8N+yRUU8/p5FmNpUu+ps42YT1A
 EN88rIeFyBQkCOKP1RfZL+5+KXL8wBt5r3iyNjBQBum1gbhR8JgEMSidbeg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqe62ks3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:38:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so7862447eec.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776980328; x=1777585128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOSms69dlEVu0F65izi2psIjj1p357XYspxgkpokApM=;
 b=fmvWfU92nbWfR7xkXs15PGLHTn8124nWtwKIc2jd3MwAdDlV3V1ws6phxTiVI1zNE9
 7+LJLVEbYpqLT2wfuBiiRSTvdZX7QPM/YXa+ubasJmgFe91nf2KLDvCU3IQmBXtwNyVD
 byrJZ8MrB+h+4MKa5bUV57g1/VhGquuZrTENY0XqU05JDEWZzgrZOp53BeGDl90i93Xl
 T6w4x1h0w7YgT2pW22ioFCKxk/EN12GcL+21OSvlCQW3tdA0m1AHg/BRhc69GjebSr/v
 1bq6nih7844acVQjrxY4Hdt4oI/BkKlkSpXFFo6YQGwqiv5xDq5cAaRUCkVVYArGncec
 YvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776980328; x=1777585128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WOSms69dlEVu0F65izi2psIjj1p357XYspxgkpokApM=;
 b=rEwyPDUzinlGkFLYHMneVAC1WHBksAlkA0pqP57sdsOoNI4l6LwSWQOmQdX1JKTXmk
 rKOeQZrtx08HXBXhIYDMYSjEdNjj2h6ypb4ddFxQk3Vj8bqJ8XDyvx9x6NYQCJhPYQQ6
 JgFBefkmD1s4daZYFrH/EKYTK1cls+s2jXE7kKojrkojWUbTA/Ds9Tt4qYkD+8xTzv3I
 ypYlAQO1S4LR3dxDO8c36ISrHowYwlSLfupascMSuzur2FHSGd8H/WSxYaLDvK0tMLWb
 XhvY306u4dmSkBU2OtnEzgbkRg23jE+PPDZWQihjuWPGucniKHDdo7FRYQjH+k4hmUwL
 pgIg==
X-Gm-Message-State: AOJu0Yxkmx/3co7g9fTHO4Scsmp+CA5R4HcdPacE1u4v3khZywbTKA2D
 PX+nrKBVTKXiMx+G04cfk6rUUCYAn5D/9ojUFYZ/y1EFrwg+D6lLEd1yh9rn1mkilxDOJ/vHiWb
 ftaUMy3Prxq81k9MPy7JyjaZA5LzmC0taUvfoNEU0YZ8NTQtpwB3KmS10F95RdKrEBQ==
X-Gm-Gg: AeBDiesZWWz1BalGMMZ3cZRfgkPUxTub+QQgpKnOe80/AbyBXlSK/d1MmVlQ86Lr+TO
 YW5FqSPNP/1TfxYfgg/k6Do/q1oc7kC1po6MUAucVuBrjhuC8FzYWv7ytLPO45EmBxFHIoiOwyA
 wucenUlHOVetXCKvzpTxuiOcJGkjkhmVu8Z+z/Ftjx013l3hGa3hOskVG6lCaYJ8aM9/9DAWzb0
 +rMJrK2KQ5jAb8t1WJlIxoMr8oFpnyeBJuxyDBjBIadDq2QYdqdsUTHiBuuvr0BMSIFGZRGXmnm
 Ka2w9cVSqSwA/5RBe7pkT/RbY6C7a4xuTabLK/p1suLPB8tIFg+1MlY8BYl4GIjQwtD5CvpeGSh
 PNbusgMXLx9qvb8x35gCM5N8nuFB8h1Vg/j/LrIgeIEv7lTNUF7h43wmJ8URQRl8XvDUzd8lA5W
 mfk7Tnbx4bztmcHOho8DhcJWMzKLM=
X-Received: by 2002:a05:7300:818c:b0:2d8:b2e1:20cf with SMTP id
 5a478bee46e88-2e46538ca36mr16884535eec.10.1776980328048; 
 Thu, 23 Apr 2026 14:38:48 -0700 (PDT)
X-Received: by 2002:a05:7300:818c:b0:2d8:b2e1:20cf with SMTP id
 5a478bee46e88-2e46538ca36mr16884523eec.10.1776980327528; 
 Thu, 23 Apr 2026 14:38:47 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e79c2954f6sm30840209eec.30.2026.04.23.14.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 14:38:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PATCH 1/2] contrib/plugins/uftrace_symbols.py: fix symbols reading
Date: Thu, 23 Apr 2026 14:38:37 -0700
Message-ID: <20260423213838.780814-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260423213838.780814-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gHrDpUdV0n1YKVq4wijJuax6-rm13i_X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDIxMCBTYWx0ZWRfXzZ44k0QSl5TT
 gQ93pV6UoWf/JGcCtbZvcnp6eykQcHd25Q56quKPjY5TKGy1X1mfXewF3NNB7fmTUaeHKGin76h
 T+Re2pldTLe5konIEZ4NmZwLJezLQE6OZ1oeQk65c2M57QWJIulGrQaiF7bvBcW4J/bibmxum/o
 ByrBqkEzml3a0dE/s62uZbMPcOg4U8GTMXZrcwCG73wJ3zOc2PHfUwhyZBWq7+wD9kvtG2mWGGt
 sxx4M4laOI7JGJjFrGlB8H+oIn9ZqSxNr33/LSqsocnqcT38Ty41Q18kmybuR5vlxkBKBNa+Kz5
 +QIBeFQHcTcRVPJQtdPTCi9MkpiZCaok2zzJBVS6FAP2v+o5j2if/+9pHjW1mR7ljXnwn4zqkWK
 kPUK/pbHEV8dT/fJgJE533ET9pbPQeZUnOlAe5QUNYKLD3+iA1DkbQiUX0ngwUHaROLUPyPJSl4
 Jz6dAaLbjJUpb4Jq+kQ==
X-Proofpoint-ORIG-GUID: gHrDpUdV0n1YKVq4wijJuax6-rm13i_X
X-Authority-Analysis: v=2.4 cv=Nv7htcdJ c=1 sm=1 tr=0 ts=69ea9168 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ZKpvnbfxhZuoKkEclzUA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230210
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

When running this on hexagon binary, we observe some undefined symbols
without any address or size.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/plugins/uftrace_symbols.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
index 02d1221228c..895fa1a6b7a 100755
--- a/contrib/plugins/uftrace_symbols.py
+++ b/contrib/plugins/uftrace_symbols.py
@@ -36,8 +36,8 @@ def get_symbols(elf_file):
     out = out.strip().split('\n')
     for line in out:
         info = line.split(' ')
-        if len(info) == 3:
-            # missing size information
+        if len(info) < 4:
+            # missing size/address information
             continue
         addr, size, type, name = info
         # add only symbols from .text section
-- 
2.47.3


