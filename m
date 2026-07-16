Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC25C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLKI-0003HL-4O; Thu, 16 Jul 2026 08:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKG-0003FR-I4
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLKE-00078H-TQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBjAii2506736
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+AcuMBz4w1X
 5F4z0wmXVYFfc0aIM6+1hAQ91Y93OF9U=; b=g4tZa1s49asBUXH9xx2tlE+NAsD
 M2xKDjNCDWhmgygJONLqnawDZf85jiyf4k1VxNbUXIuDZTXGqd67w70NHrYtpVmD
 uzHN5OqCQZWrmF4BXbKR1LcgFiwsNPjVHkFjwkQks8Qq2UQBxv/l9hteDW2hNn21
 utEzgSLIPmu0fIZJzV3PQosCJV/KtlGfvSr31e+xSDJTOAMUCUGvAfkpRxn0aiMU
 A9v/GLHf+TY9yI65MxG2L+AHa654N9RYQBurZLN/gZjzTidlba0+m+/I+r/cjwTA
 EJOO3Jy3tZkYXLF2D1xyXOxY8PFq92rb7JeT7QVZ8dUJDhEgJ7djOiZgTAA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feehvbstt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ee593a5a2fso9150826d6.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205374; x=1784810174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+AcuMBz4w1X5F4z0wmXVYFfc0aIM6+1hAQ91Y93OF9U=;
 b=esoRA+LeShtJAqgIFv+yIwFUpTjpUZp6j9x8WX/rES9/ub0Nap8YPgTIFwxTnJl0hW
 sQXcHOujVfz5xVpj0EfEdxUEMghDaqgZGTuwIw1WmkWsnRhPPOtTpVjd/DnMCW+kjrEE
 jxKM9gypJBVLYFpqWTd4z5PKjw8p9RqXY3W06y+i9vHEPdvyCp5FPK3BpmDv+/LsZiAc
 qQ7ex5ABX1ZJ/weTdgYJ9DHxJuKBjsjOpqZ8jNnDZ9YSeiGAKONnYnREbbK6lf7aRFJ/
 eaLLNat1StWrBOestRfCaB8RjvgVA7h5/xnM9BFqNH1Voc/6va85AeWSGr2YXLrJ96F4
 P9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205374; x=1784810174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+AcuMBz4w1X5F4z0wmXVYFfc0aIM6+1hAQ91Y93OF9U=;
 b=RlVB6tzDmaMQr63DKoYHtA0Na4lI9uTjdxdi4eTrmauu/hncmG8nIHFvGsKvkYJ4S6
 mgzT0olK4gIm1Pap1JQVqg4Oc8n0IiUBuEXgGzKVwfhpSzZqCiHvcts0ixqZ7tLPWTFS
 8yqFCxtJVIvmSJMaTQn87jUTQcUe6w9ZN2mIeFtb7LD0rXkPr1J7E/aeBjy5sPwcSad7
 hUbiHTrvHC1j0B469IKhPK46WiapSGlqUhnM9tZM8o4c5wW0fv0mnraiv+rt+Oa91Lzv
 pmKcSyh16LoyTaj4WtwxioAJY4vXJM4+gJ5+Y0RhT/uyA2K9zZTd7EHS4SODLW7ZnTd7
 vUTg==
X-Gm-Message-State: AOJu0YwUElIv8kbPWhIBrTFEtBIfUqK1/qz2WpNMgEowVa1F7RmUQBt+
 SRS7whBhPMC4hNURfkpYuxAHRqq474Jt/LXqgbrYxmeCLgkrbqdOEigJ1R8tPirX8ytNNsiai5V
 K1fQaGAgxRS5xGnLehaPUcXR4b3DsD7a6KcocyLYvuOgnMCuupifTpoOK7PdqjG0hmA==
X-Gm-Gg: AfdE7cmPF8+EXqghpQZLBNPsMTJ6Yisnq72UmxKRimbAfyDrIw44xjdZHnNvhnT/uvf
 WKocdsi7+5+HVuIwX7fES9+E+ZP69Yoz4x8KML4/u7Eb21u2rp0dc0ck1JpeyXQ9nLScWPDO9Ix
 XaFknMrtV/8KbkLNYrPU0kcT0tFwjGP9vZy8YL6jo7Ea5P3KlkQgQBfziXjiBCdO2gRiOn8JUCa
 wptkSPtd1aKPxs/dvkCaEP6JVAOaOAELaqjxsWmsBVwe6Xm6X4qmwSWJSr3VzbtibB701A/7oBW
 AGrTaNlqwHJDdaLgfEzdAF83xKjhxyYdopXC83fqRF3VNsrRj698HB4C7GJ6CNQd0DBxWBBQ1zZ
 qdOtOwSHtY86F9ZyxAbqRNeM9vEXpLXNLe/g=
X-Received: by 2002:a05:6214:2388:b0:8f1:77b7:9bdc with SMTP id
 6a1803df08f44-90768de19eamr24188546d6.1.1784205374283; 
 Thu, 16 Jul 2026 05:36:14 -0700 (PDT)
X-Received: by 2002:a05:6214:2388:b0:8f1:77b7:9bdc with SMTP id
 6a1803df08f44-90768de19eamr24188036d6.1.1784205373646; 
 Thu, 16 Jul 2026 05:36:13 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:13 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 12/17] target/riscv/debug: Remove breakpoints on reset
Date: Thu, 16 Jul 2026 09:35:29 -0300
Message-ID: <20260716123535.3709148-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZpDd7d7G c=1 sm=1 tr=0 ts=6a58d03f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=o2zggslVeTk9FJBUniEA:9 a=gZLHJPz4sbkA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX0b+3y5TRqb35
 nydryTPAsd/mSUkVsQlDXl7mghk8GcfYVCTb4xlA65KMTqaDCj4lSdNTN9W9zkZp69MNupCmd3c
 HkHBbNeb/mtdZC6BW8NYCYMzB7hxkPgCGyATqzycOStBmjrl/PLCIJCC+UhOrBTIhn5e/Gri7V3
 aYMLxWgybXSo5dLocTgPIdYpvICB6ZtrRzSXA/MqaJmU5mxsEQm+37cPE7y5pkpcNpGpv6AKo8q
 1tyI3l7k6l76w2WO03GfUMk4nJMKw+xsmKPiatl4h2QUv4JzYOUgncJ9qXWEzJ13oLI/XLkPZnl
 xsLu/DQwxGaySvKAxpjOS0b6XfvZtu1v7bX958YDr6uamUM4c0lyXbZK0f2GxRcRRhpJnk7KOku
 D8Ad25xxlSaqedAT+9swEGPuSaQcKHMfHYtxM2W11lpxyYDYUAOgQ/uKoh4f8LB5Vp+YAZZW7Q2
 QcAfaIGq3ssSO+gr3mw==
X-Proofpoint-GUID: 0YHO5iDcvxnipu7Rbqi7mu_E6yBzedkZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX/EF3uy59Jp9r
 fwvdDTp8Hh++293vT36v5HXvDqNJ2eCu6k2VXQ8+gL8LQGH8iWGmb53LMkey6ifirx9vl8KAGmZ
 pegWJAkS0XhP0IX6Z+aJ01GIwkx8xRk=
X-Proofpoint-ORIG-GUID: 0YHO5iDcvxnipu7Rbqi7mu_E6yBzedkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Remove TCG breakpoints/watchpoints when the CPU is reset.
Currently they get lost.

Fixes: b6092544fc ("target/riscv: csr: Hook debug CSR read/write")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 7ecbe01fb2..6cdf89c638 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1162,6 +1162,19 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
 
     /* init to type 2 triggers */
     for (i = 0; i < env->num_triggers; i++) {
+        int trigger_type = get_trigger_type(env, i);
+
+        switch (trigger_type) {
+        case TRIGGER_TYPE_AD_MATCH:
+            type2_breakpoint_remove(env, i);
+            break;
+        case TRIGGER_TYPE_AD_MATCH6:
+            type6_breakpoint_remove(env, i);
+            break;
+        default:
+            break;
+        }
+
         /*
          * type = TRIGGER_TYPE_AD_MATCH
          * dmode = 0 (both debug and M-mode can write tdata)
@@ -1178,8 +1191,6 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
         env->tdata1[i] = tdata1;
         env->tdata2[i] = 0;
         env->tdata3[i] = 0;
-        env->cpu_breakpoint[i] = NULL;
-        env->cpu_watchpoint[i] = NULL;
         timer_del(env->itrigger_timer[i]);
     }
 
-- 
2.43.0


