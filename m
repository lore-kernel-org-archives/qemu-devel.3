Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D89BCD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBsW-00011D-Rj; Thu, 18 Jun 2026 08:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsV-0000uU-9v
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsS-0008LQ-I3
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArtiI1536470
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gK2TIMtKhAchzcc8U6UUXcqgB5x0P/ckIy6XJBVG+Ns=; b=JeSgF5r0iuz0UUQ4
 Kr1rcVcB/11tX67/+IHF+/7rd9HFvTDg1D/haeodbFWJgRjE6en3H45C3vHlHRPt
 Io3FxEYOaALlx1IeNJxo2ShaqFTz1Y0gTJ5AYJ8wZqYfNWJKy0l/63zymW86/oxg
 Yfluj+epM6C0o8Gmb3NOmMe5cW1QbjLEu+lgmqveObKLYo7EwW/taI8njwC7X3WH
 f8kcd49Z/7fUTD1JCVs1zF4djPIt0DuSc1RARsYGIw58pIcIPOhuOp0CrmVVVW6n
 DxdrGtAX6O9i1HlbFG8vQzV7rktnE91XgmIotn764vsmioXifOyRszLFOWC+DO10
 iMvrzw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kkctb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:29:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9181f3cc5ecso413494285a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785787; x=1782390587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gK2TIMtKhAchzcc8U6UUXcqgB5x0P/ckIy6XJBVG+Ns=;
 b=dBoXdhRJghJxTKSNbO8+TboviP7UqemA0P0QLXhx6L7RFbdwNMS/i/Q61TlwC3OYJ6
 SyQx+bOeMaUo5+mm330o7MctnhT6Tgm6cQ4snB8ilBSfJCQ72xRzqbfT8PVjCqucftR0
 81L9BcrkS4ROheZ2tfroJqupzJbED5aRuY5GGoOcSnTIFS44t0veh6SHPOr5+o7dJ8eW
 96L2jrfWIWt/ybk6hk5KPXOxK9aSmcAkzv01J7JwrfMxLqU0vVtcDsr+BkthvGwYSXg1
 R6OV6Vn4FuuRopy8ZVizt8tjTMhu2swDt/1kVP3j2/sRsqcmiL9dQqz/cdUZ4NSfZWzW
 gcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785787; x=1782390587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gK2TIMtKhAchzcc8U6UUXcqgB5x0P/ckIy6XJBVG+Ns=;
 b=O1svlmOtQDxvq2leO5c8OTFPtG/ikS+AppHF3ddJTuaRhQWBl2dWm6L59230JiITyk
 ZfzhngEt0UqzcHwyS/i4VlmfPypEkMJzzwuaYj0qppNZmYilaNOLpXqalDZ39OAdSKkd
 k1L1CFO8RObnJfZm974b+RayFMmrms4fYTh9FH/eoqWWcuD7/YwvUKXb4pP2r/McLr9n
 r5C6fsZJwiO4epHuajnqOfs7chBJFmMbmHSuXVOQ7En9WaKXyKhyly+PTHSsHYFL7k26
 cU1u+lrI07TzVaYFoPrc55aiselqL32fKIhaQ44Mi49ftKhiVQSKxD9UO5E0OIqE2Eux
 xBig==
X-Gm-Message-State: AOJu0YxuauKFk4lmbvln2FQ7wtvpI2O60DjoUgFm8SoHLunViPzMbAad
 QrS0nbEUIVOnBeM8XRhJNxCaYNnFmAC67IBZKHyXbCnZdr7T+/1vuxiE7d04W3WJ2o8ebz5onZi
 w9VBxFMQNvPVS9CBLG238yfeW3HlP8wKeIUaH5w6dbycLnWKCf6/i91AhhJVFKQlvyw==
X-Gm-Gg: AfdE7ck4AuCsXG+a6lM4JT0A3gjO/1nWQtqiBIht/tUv49AsdIUkyzSVE8gkcEjWqMH
 pS08V4u5NtZn+ZThnD5rXxUtMIoJzJPwDvP+jhGDKSvUW6E6n9eKZsi5+udF2eiHktXF/7GMT42
 5eBkEEynK6AuaQcw96XFkLXIDBHgeqpl28qkC1L17F+EiR8jjjz6hVzypWUt8tgbptPD46dU6i/
 iaUNY9MF2B/9+oWB3Q0Xpsiw9Q3XAjXH0WP/Y/iRFMH5GTjO+iPvFV2paa2fja0ejAaCD1SQhhO
 OwdKSGuPmkUxiGxQSauXWVrqFpYJUh+NEjs265vhn3V6P5gHGrBuqZ0sP9XUqg4OV/TWjpxCHJV
 E90Q+5vlSbWfN6cfLtGVnvdsploUtWe02E4w6VYN4YmT4yzlaz3JhVdmc7oflNT5Se3aY
X-Received: by 2002:a05:620a:46a0:b0:915:fc16:2ae0 with SMTP id
 af79cd13be357-91f09d779f6mr524729185a.25.1781785786983; 
 Thu, 18 Jun 2026 05:29:46 -0700 (PDT)
X-Received: by 2002:a05:620a:46a0:b0:915:fc16:2ae0 with SMTP id
 af79cd13be357-91f09d779f6mr524723485a.25.1781785786431; 
 Thu, 18 Jun 2026 05:29:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a159d06sm52253615e9.0.2026.06.18.05.29.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:29:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/48] target/s390x: Factor common s390_ipl_read/write() helpers
Date: Thu, 18 Jun 2026 14:27:48 +0200
Message-ID: <20260618122825.90331-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXxl7qQsbBUwbI
 Il9/CXvmPaI8nu/2lAwAdwzKclbnwh8JMDU+0pQWO1tEvcA3rENepbeX1C9+G5M5qZqUlLp47a+
 bDDzLkhhiUt3hoCE3pE1LSml+ytXexbHcVKeWxjCAvWZ5Gy/8eUc/pxB08KrqxMoFin5fTuXElV
 fnaqQFgAfqrAdnhoSme6j+Su7Z2G4VwJwHNQghUfm0zzVVS+7Z3pBd9KkPat7/kPOEJy43Y/kCE
 +6FzEKAKBwT5/e9lxnTfN1PT1Bt0Wa65+1ZLREhmjZ0Gu2Pzh1cwh+S+L6zqkYiHIQEY+k91Hso
 dVZSqd6AOnJv7GO7T1+mLW2Oj9S0gZN5OItmPPiYH0w1mIIqR1xiWoRaMx0LTV0PxzYb9FE/1Qb
 GKonXxnCZJJhrJpBf+KjGpdZKtqUh3ryafe9xbiplsxpJ0+uZc5X3stzr6eA0jsO9WDuhPmYiRG
 qf4jo9rUWHfC2Cx4dMw==
X-Proofpoint-GUID: M_-XqpbFC0Sn1OU8lqyXy13xPCwG_Zci
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33e4bb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=5U_tvQ_toz4j2hBgumwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: M_-XqpbFC0Sn1OU8lqyXy13xPCwG_Zci
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX6o0lUAeD8w85
 ULiVjhGkofemVQmkmBB+/jw5dblcSTA0bPPsYoctXpQ81pt6ZorhIdsVlXRSYzUiBF0Al/4rjuj
 /IPQ6M2gnijJzpy4Ch6ESBfIjSMTw4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Prevent duplication factoring common helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Message-Id: <20260616020839.19104-5-philmd@oss.qualcomm.com>
---
 target/s390x/diag.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index da44b0133ed..bc1791067d8 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -73,11 +73,30 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
     return 0;
 }
 
+static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
+                          IplParameterBlock *iplb, size_t size)
+{
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
+    } else {
+        cpu_physical_memory_read(addr, iplb, size);
+    }
+}
+
+static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
+                           IplParameterBlock *iplb, size_t size)
+{
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
+    } else {
+        cpu_physical_memory_write(addr, iplb, size);
+    }
+}
+
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs = env_cpu(env);
-    S390CPU *cpu = env_archcpu(env);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
@@ -114,22 +133,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
-        }
-
+        s390_ipl_read(env, addr, iplb, sizeof(iplb->len));
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
-
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
+        s390_ipl_read(env, addr, iplb, be32_to_cpu(iplb->len));
 
         valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
         if (!valid) {
@@ -164,11 +173,7 @@ out:
             return;
         }
 
-        if (!s390_is_pv()) {
-            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
+        s390_ipl_write(env, addr, iplb, be32_to_cpu(iplb->len));
         env->regs[r1 + 1] = DIAG_308_RC_OK;
         return;
     case DIAG308_PV_START:
-- 
2.53.0


