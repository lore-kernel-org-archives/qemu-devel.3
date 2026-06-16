Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8663CD98D2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 00:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZdhI-00021W-4n; Tue, 16 Jun 2026 20:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdhC-00020k-7N
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:59:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdhA-00083g-Ev
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:59:53 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLSwUi274624
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wpDFQqe/i30
 A1HqdCZQ6BGqOps2hFYSOdsjhnuUvPq4=; b=gI4fictdbNkXBRMEj3098hToJOa
 arptZY5ww+zTyLc60zY4P5JTKohXa+RNl7bTMJle+TMoib4mFhiGFu1VbzvNXbq+
 O7mNcwC9V2E/0moVpZewMQwmlHL/bLT8fNSblBjQtpBgsYCl1IK7Fvj3imjjTa1J
 mUwshHzuWPDr+eqzTPRYOax0+4S/RDWhUa9lyfR+UNDLJyz9TDhoU4wlLQhiXMTa
 CqJdW3FuBVE+V9cLDI92TYe0FJzuPpQGFqQ3md9d/M3nL6nj98Uhxd9qJ9mj2Pla
 IYYZ+krqJ8qI4UczIxvFiaCGeh6KpzuhYfUEaq0EhD9W9FhT2ayDSB6GX8g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueemgdmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517dadd84f8so92741651cf.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 16:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781654390; x=1782259190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpDFQqe/i30A1HqdCZQ6BGqOps2hFYSOdsjhnuUvPq4=;
 b=IdVFGJVI1S9IpoiihtW/FyVce2HRTGlsVbW9Fv7ODwan4oDURnxIHDjaxqgXnH/lXn
 0NtBTyHRLdLMxT/C5ALzgxd9OWzPOKXTTI/ikiqTHs9VN6mGRme17hailJYSb72gF1HI
 QzdsBrIWD7VJc984cSl0y8Ckv8AxQN2UDGtdORFfKagys13+qiVaxgMp8Pyp7Dpy3Tsm
 Ux1pcmuI70QPy98AgupEKcziGwnrGARKGBzTVrp6UIzi5HwIgbkYiIFXGIoUEB9+KAVG
 sHr68TNyZFVXHxQiSJSxCfw/ivlqznwds8DfGU5fa+2s9OXcLmObrifTIHzI040GenBf
 TKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654390; x=1782259190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wpDFQqe/i30A1HqdCZQ6BGqOps2hFYSOdsjhnuUvPq4=;
 b=btJGh6afFka8DRqyGl0Y4jj2efdRBknGfjVaN7HbR6EBHFlXn6r6F0UgWnqoTgZscw
 qyESOgEfkOF7ieg1leoWJSxAiTa9LrJoDEr4CAEU8dMuJID+f/wPSW61dhM4bQOr/2PQ
 Cg+9wdIzCnlZ/bRJn5mUN7sNxhLh0/xEyWsygwMEGb+vaj2B4LhQgS8eJxHZ/Q7ZflV2
 Gdtgqg76BX80yS6VlbMnk1BlB5leqQTipMi9bx4JmIYfVpi7/SVYxHDkzq9t7wlz/EGM
 /bwP/ncXdjYWxrn2rXHKUXuuCCqi/fozthvvzMADdD0c1A+DHjBK45dmXn+EyWqsnw7h
 cDLw==
X-Gm-Message-State: AOJu0YyDeuscJr2k4rTfJX7j4DHm/zb7F2wEkKkLwuzGxLZlMAuoDCxn
 o6/sFTINuw5hCYDe4/Y4GcP0zVb6DLO9D5oABziutJapg6VOufmrY0mJZ7iLKh17+xSmoQrGAt8
 Nat40ZmJGL85rmAvXgm42zN5Kva93KA57O1Y8wy4n+NL6hj0Kt6D4aoyH9NNramplMA==
X-Gm-Gg: Acq92OGJftddMUvFSZHd2QK2sz1EfLx3WOYKBB2Ybhei7gBZw6nI0k1KtrxrqnntKhX
 ichrJfQFppos+8Rz80jxfIAJxMhpswyiQWD2XCBi4Mz/AEoVzVTV2+aXjiEYemwQkOhW8ASSmke
 9aNK4JRLVOM5JIUmR3I7vC4hCF/FyKlz8CChCTNT+2cD9mKeINKrG6dCKViY/unSgATaVHfpCvQ
 FMMrMoJd4K4QzsvPbcBScKO+GFYlZxIYiazwv4QU5fGa1z9QXeSO80NEJWg3aWqDFuM2ATYxNe/
 jWjnIqD9Tdp/J/tJiTZ2GkyrwqXYgphPZRqR1iAUmbgB6ovHqybhsRZHfkOnQ0E/xWVUSIGei8I
 Dov3isH9JSBmkfQKo2oR5sHS+E6N8HHCQExvfOXSWNcN2ZfHuvOs4ZE48SwE=
X-Received: by 2002:a05:622a:243:b0:517:8d40:7c7d with SMTP id
 d75a77b69052e-519a8e5ba58mr25966451cf.29.1781654390101; 
 Tue, 16 Jun 2026 16:59:50 -0700 (PDT)
X-Received: by 2002:a05:622a:243:b0:517:8d40:7c7d with SMTP id
 d75a77b69052e-519a8e5ba58mr25966191cf.29.1781654389667; 
 Tue, 16 Jun 2026 16:59:49 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f132178csm50191986d6.7.2026.06.16.16.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 16:59:49 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 2/5] hw/riscv/sifive_u.c: use intc_phandle in plic creation
Date: Tue, 16 Jun 2026 20:59:36 -0300
Message-ID: <20260616235939.1358663-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfX9VNaH2hkDEfz
 oVE1vJlIToAUC44QECm0JFME1QR/10AO8i1/rvwKIBdhLaXFlEHs/WDfh1NUPlHqMc4UOpyhZFk
 R96lTdPU5EcZ4hm4QydedvCYnsEf44E=
X-Authority-Analysis: v=2.4 cv=D4d37PRj c=1 sm=1 tr=0 ts=6a31e377 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=rRz0n67az6SdDS5ShVgA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: zo_cPmQ39jnx9njNVP1-20KTG-ISz_NR
X-Proofpoint-ORIG-GUID: zo_cPmQ39jnx9njNVP1-20KTG-ISz_NR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfX9dfxyy55pT5q
 803pTYcpk0p36PI/HZc560LjT5j8BwzyWgBCx4et08pxT9jsMqY67c+/xqqDihon//v5Ll5l8h5
 9lGZ7OWsezZUbkLFGbocqebSj80ETHH35yS9tMji6QTr0NRNxRDCdtzUw4J/7us9j4KbJnruq4j
 6ACcoGOjmMQFBxNgbeCyLdDi6dFbL45Pa+DgRcb8UwYju6xLNlqwpJu1fuMceUB+0g3yQeeaRDR
 KvbCims8ZjptCrFMfHca9Cgg2mME3yYy1vmCCoJFXTedl3niqPRalRG2ZYlrf88I5kDUn1Gduap
 iAADa2fsOmrAhfFfcLnLONt2hOSoeqTMeFCC/c+n/T+nlAAhirnJ/pL8olYSwiLlNaHatEd8wrk
 Yktgmy/WJPlRCTygpd7YogtyCXTVN+yFm2rfztXXLCLxtt79CUqT07Tjmr9bTrPsFI3ml+6eCIt
 JKS9bqMoqXtDms7ymmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606160242
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The info about intc_phandles for each CPU is already stored in the
intc_phandles array.  We don't need to fetch them again using
qemu_fdt_get_phandle().

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/sifive_u.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index fda9a09f06..b3468254f5 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -199,20 +199,16 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     plic_phandle = phandle++;
     cells =  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        nodename =
-            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
         /* cpu 0 is the management hart that does not have S-mode */
         if (cpu == 0) {
-            cells[0] = cpu_to_be32(intc_phandle);
+            cells[0] = cpu_to_be32(intc_phandles[cpu]);
             cells[1] = cpu_to_be32(IRQ_M_EXT);
         } else {
-            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandle);
+            cells[cpu * 4 - 2] = cpu_to_be32(intc_phandles[cpu]);
             cells[cpu * 4 - 1] = cpu_to_be32(IRQ_M_EXT);
-            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+            cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
             cells[cpu * 4 + 1] = cpu_to_be32(IRQ_S_EXT);
         }
-        g_free(nodename);
     }
     nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
         (long)memmap[SIFIVE_U_DEV_PLIC].base);
-- 
2.43.0


