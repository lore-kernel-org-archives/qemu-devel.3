Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189BEC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMpL-0004AF-Eg; Fri, 21 Aug 2026 06:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMpJ-00047S-2a
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wxMpH-00038P-Af
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:50:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9M3PG2006429
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q+KDuQ2I/KnfM9bv8Lb05wGUziB13ZFXznw0mkhbS0g=; b=Nm6Nm6xlLxfo8vOz
 D3xeYJmR2voi7+et8ETXxApW6EsJ+OlznFZ7Us4xAsuveC2xDW3yKmH9eDAuSnjj
 ft1N1cp5s7epZckKpKUcuji52ZYat0ipS0jp+hBWhnHzKb+3koMJtuUSLUVZgsDj
 BNK7UX9AW0hCqmYbr+ZWtBBoX1SAZibzvPrBGAWNGSV9FAqU1FlMklkxTuDdnMgm
 0OGfAOyRVnJ/Rc4ECCP2mMN/0XGMNlBXbUfjVGCjOO6Ssv8MQpJH9zESCZjBWcpq
 y05u6FAWBDKZSXKThSk5QSyufs1FI40i1zYL177FfZ+cTY4UvXRc3m+Diipw2mUr
 BA/r9g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gddh63k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 10:50:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso8275431cf.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787309408; x=1787914208; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q+KDuQ2I/KnfM9bv8Lb05wGUziB13ZFXznw0mkhbS0g=;
 b=O9Z5EH2pmzB7YmYCaJTI97eIMEECqWl11Qbnuw1G0wCt0J38XLGOn7BNQg/5vI+138
 NwisdS4flSpCbIGZ9UevaeDMtvbkb6rI/Rrx2Ogf6hpUIOfT3J45UlKmOD/0iz8CvytY
 iH0Yzrqa0VWolwyWdmVv2R2j+N4Oao+9z5a+asAaRyg58s/K69HGU1hWxW+qzxhtGiFY
 velmukswV6obaca8HKtuz1a6PXuk/ztCI7hc2Me/tFUrswBO6DwxnJFz7aQEvqAcROPr
 e8oA1FyWqu61FU5zkQvNR+B9ImjpWXA7NsMSgAtg5TNwCuAOTfEreQM+8JHvKafn+vVV
 jrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787309408; x=1787914208;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q+KDuQ2I/KnfM9bv8Lb05wGUziB13ZFXznw0mkhbS0g=;
 b=ohDrjUjUYCyPGLQxc4YmXCHIO90oEnYBZd2qr6tezWeTsZlzx4n2UvH07+NKZ+iwvC
 Oyjd+qMrKbKZKAb99hhCfTATkcIVruXSn79akbCxUN4WHwa5+/2ZmYYk8NXAVFWlSM/u
 8LRCFsL/ImsnlvL5OlIdmOiykMFiPvudCTyGQ9Vg+aWDo8zjJLyS0Eeyykk2RHVybof7
 Pjlx6CPOjI0YH7kpTnzfrxHc/Lqq+65WEjSq+9VNKgTI3oG58Rp/uCKC9rF806xT6nMf
 Al7TH53S/wevvTO9+2QnKGxhQG4KerfP4QVNdOYBHQCzGbRXI3EWJ8jQz3MqfR5ofPcX
 +Lug==
X-Gm-Message-State: AOJu0Ywzjp1e0BVzmKpWEkjgq4MghRo/cEWpzk025SCyWxu1+i3Ig6FT
 QVveFqP16wKhA+Gf7VuFd5KRvxfmN/3pTpgYckLY1mDj2HPqlHazEi2Tpb+8w/vR2k3v9wdI3tj
 wNfQaEVA6K9ozco0jCAdjFDfC7/Sl7rd5YlS9tGDF/yazZpUp4Pm7IvgvVxLB9SOdArGs
X-Gm-Gg: AR+sD10IPpQ386Cidv4Gf8G1FnLRqVYuurDUrDWuXTP1xYWzFJCuKcL94aBRtrISVBr
 12SmPk1zrtD58lRRK+aQNp4qOBwpnDXz5mY6WwUcUdqXdi6zmI+k/ePKWuxw7QtVuMnTRrQ6b5G
 h0afje0FzaBuPyJec/hOnnSxPxRfjc/R1umBHdWrOaPommSxGBax5UyUthPPgx56qslEXWHz7xU
 j2eXGDLHH6blzgdzV2jjci4UmEjf7xQxXPfbPSUn9B4acIVtUDJ/Xg2wOJjXySp8j50G+QgFZTi
 v+Rfd/soqoMakc/EmwBQWIQ7PPM9Ka6bmzmRwozHQacszNXX+vnNczLVm9+U5UFewBaeFZlwD1g
 dMO1DkcD7ZSJ/qqbYHbbbo4oTP3MRwj5Ic5WmrTJG5w==
X-Received: by 2002:ac8:6543:0:b0:51c:1117:c7c with SMTP id
 d75a77b69052e-52df59aa4b2mr44702321cf.25.1787309407709; 
 Fri, 21 Aug 2026 03:50:07 -0700 (PDT)
X-Received: by 2002:ac8:6543:0:b0:51c:1117:c7c with SMTP id
 d75a77b69052e-52df59aa4b2mr44701901cf.25.1787309407283; 
 Fri, 21 Aug 2026 03:50:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14cf0a3sm16136022f8f.32.2026.08.21.03.50.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Aug 2026 03:50:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 02/15] cpus: Add const-qualified CPU environment accessors
Date: Fri, 21 Aug 2026 12:49:36 +0200
Message-ID: <20260821104950.32108-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821104950.32108-1-philmd@oss.qualcomm.com>
References: <20260821104950.32108-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX0WVijdcCivQB
 8Bjyx47mF1tZrV7TKrfZzmBE6ek0Gt4qFO1HaUpL0h4o8oyf/KNRkDA2HBBmqZcMzJDZx6zs+fY
 Ce7Ufy4+3lMlg6rlFF+8u319VBTD7xE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4MSBTYWx0ZWRfX6pRH83w+4MT+
 li1u5cv/EfndaR7t3dhI7OGjde32OlGg29ptQEIULVleMZPT5hBTXeq3ykhbf2N7XaHBL30WxCa
 7D0A8loTY3e8qXLB2YDKiKfrQQqcBg+6Slf7eGhxtrMWuQ77/0C7diTwXtg+JSVx3MCb4YhpgBb
 ZBLaApuVHSIDyKgTMxnXDqxTJR30UXDWMMV6rCe1LQssoylWIonZAlLVKrb59xglZCLFgxgfWvS
 gYefiHtAjRzqCEWqc0rwrn/DSxs9wT3u8rMmOOcZ1zPhUH31wP/ephCf+hCfYQEGg3Aq5LKO10w
 NV4Wc90HpuIWHkd6yoD7IzrcYR/PPTkkhA7rK7j5l6KEca23LK+gXZxuKbILf+ttYcRXEUH0XaB
 A0/1VQHSQaAQSgvVIJoMcXqPo67sVvy4UPKpaBiTYHN7WJfna14gB2uezxjG2c/ZvnMZT+Lpni3
 NxSy+sIZoWJO4fSvpPw==
X-Authority-Analysis: v=2.4 cv=ApHeGu9P c=1 sm=1 tr=0 ts=6a882d60 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=x16qC-9I3E3lrIGWYX0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0jMeGXf_l1G6CbMXAXDfT4mTmCMtkCa_
X-Proofpoint-ORIG-GUID: 0jMeGXf_l1G6CbMXAXDfT4mTmCMtkCa_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use _Generic() controlling-expression to add the const-qualified
variants of cpu_env(), env_cpu() and env_archcpu(). This allows to
safely access CPU architecture state when it should not be modified.

Alias env_cpu_const() which is still used.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Following checkpatch.pl errors ignored:

  ERROR: spaces required around that ':' (ctx:VxE)
  #46: FILE: include/exec/cpu-common.h:89:
  +            CPUArchState: \
                           ^
  ERROR: spaces required around that ':' (ctx:VxE)
  #62: FILE: include/exec/cpu-common.h:101:
  +            CPUArchState: \
                           ^
  ERROR: spaces required around that ':' (ctx:VxE)
  #90: FILE: include/hw/core/cpu.h:605:
  +        CPUState: \
                   ^
  total: 3 errors, 0 warnings, 64 lines checked
---
 include/exec/cpu-common.h | 30 +++++++++++-------------------
 include/hw/core/cpu.h     | 17 ++++++++++++-----
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6594f7fa1be..bffef677607 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -85,21 +85,11 @@ static inline bool cpu_loop_exit_requested(const CPUState *cpu)
  *
  * Return the ArchCPU associated with the environment.
  */
-static inline ArchCPU *env_archcpu(CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
-
-/**
- * env_cpu_const(env)
- * @env: The architecture environment
- *
- * Return the CPUState associated with the environment.
- */
-static inline const CPUState *env_cpu_const(const CPUArchState *env)
-{
-    return (void *)env - sizeof(CPUState);
-}
+#define env_archcpu(env) _Generic(*(env), \
+            CPUArchState: \
+                (ArchCPU *)((void *)env - sizeof(CPUState)), \
+            const CPUArchState: \
+                (const ArchCPU *)((const void *)env - sizeof(CPUState)))
 
 /**
  * env_cpu(env)
@@ -107,9 +97,11 @@ static inline const CPUState *env_cpu_const(const CPUArchState *env)
  *
  * Return the CPUState associated with the environment.
  */
-static inline CPUState *env_cpu(CPUArchState *env)
-{
-    return (CPUState *)env_cpu_const(env);
-}
+#define env_cpu(env) _Generic(*(env), \
+            CPUArchState: \
+                (CPUState *)((void *)env - sizeof(CPUState)), \
+            const CPUArchState: \
+                (const CPUState *)((const void *)env - sizeof(CPUState)))
+#define env_cpu_const(cpu) env_cpu(cpu)
 
 #endif /* CPU_COMMON_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 81af7b9ee1a..0b5bb81b35d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -594,11 +594,18 @@ struct CPUState {
 QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
                   sizeof(CPUState) - sizeof(CPUNegativeOffsetState));
 
-static inline CPUArchState *cpu_env(CPUState *cpu)
-{
-    /* We validate that CPUArchState follows CPUState in cpu-target.c */
-    return (CPUArchState *)(cpu + 1);
-}
+/**
+ * cpu_env(cpu)
+ * @cpu: The vCPU
+ *
+ * Return the CPUArchState associated with the CPU.
+ */
+#define cpu_env(cpu) _Generic(*(cpu), \
+        /* We validate that CPUArchState follows CPUState in cpu-target.c */ \
+        CPUState: \
+            (CPUArchState *)(cpu + 1), \
+        const CPUState: \
+            (const CPUArchState *)(cpu + 1))
 
 #ifdef CONFIG_TCG
 /*
-- 
2.53.0


