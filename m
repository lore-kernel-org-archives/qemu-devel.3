Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E80C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiIL-0002SN-B3; Fri, 03 Jul 2026 14:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiI0-0001o8-Lo
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:07:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHy-0002O1-7I
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:07:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiHwr677236
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i5CvciT5tad7yGydRdWyMF8oIxQptsq2RqDK/Jr9Fwk=; b=cTm08a5pzlP1ENT+
 hfjfB36eZYYJNdEU2pwCxBjI9oLk+FpyXWIiejTxE7tFJTMtMmWWA+oKz1qsAxla
 HBF57EDtGR7LmXuGObmZVJYm9lzz8GtZO/MEVJ7CLYN3Xy7L9cN7yJu9YxtLnaHH
 81nsHOC0gO5Xwc1uHVY4ygQAXv7uEjyMIb1ibiklzPJm4e6WAoNxsgHZEcrusOyf
 8dDVsgiivAlivOvpWDQy5p+SUU8O3CGdRgelzWfAzjcLIokivIagaSSZFlddf1uM
 pTZe0gBMenT4Ivj1BuMrlaHzhpye3bZJ4FI5klRucys+Qedod+chHt/PN4jUBl21
 reyNyQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u3293f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c12e43b98so8541571cf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783102005; x=1783706805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5CvciT5tad7yGydRdWyMF8oIxQptsq2RqDK/Jr9Fwk=;
 b=N6ZzNlG1DGoumsYyBQGG0gcnh4UhvHZXJ0JCjd6jowSAm+B04JyLAB7s8RMcN3gM/Q
 gdQul/hk/YL7F8VmMdONvwocA99XS+0dsvQZgOlI+6HUyvzeuwKxB2ohjiIoZBuuoL+k
 4SCABKJCasANa8iYIYMc8ZbMHrsbl3eb2wUF1HLUKzTY5EupwFDjkV6wkWHpNCNu0k0S
 DdUvt6ixlBypYq1vQLCKhDBAowxsGk4nKxNoD+2ZXAB7oJmJ+uPzMdZ/7SOQsNJ5cNaJ
 HGCJXZuiP2A4bGi/S9JUsNBeDyKk2/JZbcgmop9hFt7BXeTGpU028POddbalNr4aQ8FX
 VXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783102005; x=1783706805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i5CvciT5tad7yGydRdWyMF8oIxQptsq2RqDK/Jr9Fwk=;
 b=BjSUZxPPlN9VcBoHUqCdcL2sBpdsKK4V2kKeX/aZE7VH0x99hAia6SY+LaZ3VedQTY
 oJtAnZK6BjR22AymqIhC7WhUbkaxpvNuJZQAgboUjyyjwkXCcZlJrSnR8EuRuBrdr/iN
 Ck/evDWXyaVPkObjVfJqkqeWWSb4qceKVZpKutDxkdzRXvUaCXXha50ZUazp06ur/Pke
 hIqUOBIUHzhlxjTnadiF0TEXCX6u9y53Bd7h4iyC1fOOp6ERgqhb4BoObv0tto1ZuQJz
 XxL5Cvub5aark3lYTGDaMp8+3uYENPYFAdDY5zYQCWl/m+Dr2UkVBBWkepCSlCZIOfnc
 C1Lw==
X-Gm-Message-State: AOJu0YyTXg17bf2TaJF7egiSIUutsxGDjM9GLSoKrTauXjTpmSvVIYmi
 GGvOO/FlMYTUH0h05SQ8XZnt9YpjlCTGh780n42TFST9Y6nkWSt197CuJmfkpUSo9doUu7laXKX
 3eA+WsHqQ40vP9XuHzEQijAQEASlOkb87QbfCg5F8Njv2776Kw3U4YtI/R/azc6w8qQ==
X-Gm-Gg: AfdE7cmgOnCuJYP5Mbrn9Me7S1g8+7BFxQ7WmYJ0IEknlSYSaV76ediJUFcsbUpaN8W
 8c4mHYz00XnRPF7/lLdsUTeOmfMarOfCsOoS/2jOL7dOrI94hgICWICGG8vwwNSXidT4CUJ8C3j
 KuyXuI9CQhocyqPRzf55pdI5fon1x+DmwtOBjeAXqSO3AsoFjk04qdnVPslk2PXmrgepiQJW/bD
 cCd6qb7UbGutRn9wyrIRod4JM+6+c2yJ5njznDoZol+uXLAu/wMQf//YRW8g8fX+keooPOkf9mQ
 RAnMXMonr2tXCzEGF/xOMvIYBJw+1Z/QkpIrz2XLJ+yv4JYJrwfOi7jjjlqgd+D5lX/AoUcBF/o
 ADsi8uX4zXI3IyZCQLol9lKFAuC/XXF2EB/X2kNPZXzEjZw==
X-Received: by 2002:ac8:7f88:0:b0:516:e00e:6868 with SMTP id
 d75a77b69052e-51c4c2be172mr8920881cf.46.1783102004561; 
 Fri, 03 Jul 2026 11:06:44 -0700 (PDT)
X-Received: by 2002:ac8:7f88:0:b0:516:e00e:6868 with SMTP id
 d75a77b69052e-51c4c2be172mr8920321cf.46.1783102004068; 
 Fri, 03 Jul 2026 11:06:44 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:43 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 20/24] target/riscv: move riscv_cpu_set_rdtime_fn to
 riscv_aclint
Date: Fri,  3 Jul 2026 15:05:32 -0300
Message-ID: <20260703180538.3346781-21-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3gLFzv8_E9b0pkSOcGWuVnximNkZbdIz
X-Proofpoint-ORIG-GUID: 3gLFzv8_E9b0pkSOcGWuVnximNkZbdIz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX1O8Sr2uxeKHY
 pm9csWIrJpm62N48n96GLRFf6WCUutJvNQjxqt1DYkH+4I0XskgmP/k2mfIGmYZJ5BcAZmFKCSF
 Glf/VgtyqNlqMtEzany8IaAbYQDwQJ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX2OzSynUI5b7x
 gJquG8jzOkW3JNvbyh8ALxcYELF3hK4FZJXxzG02lkpQlgIG3aIzgyZL7g6YnQG3x8NJFPyPlDa
 6Bw9oCXC0Nt9TYuequdfLBNaJw9tTZnM8ng11f8bQ2gfBGKtZqQ1Z295/vfzABMs25refDYjhKs
 TZwUQ46yi3xMq+jG2bx6r39B0dYiWlkvlf6G/FFPWDQ9TlM1Ad0vUxFRGchv3+OGDdN0/kdbwJ8
 gJ42HierfF1t7qNbSv5bUxlM8fBih3igFnq2gNZKhX5+SbK6oVa0/gJHt1sL0Thip9emWdxC54H
 hes2wNiQdU0p1alluesDZN3/dtJjwl0NheTkL44gkQPbDwcUr6gzOe/T8cxoTOf2F/Nz2ndUu/t
 x0o5VK9d5fdwznSb85I+IzJ6q0Ym6sKwk7/Z6deeJGqvduBhIYA3p6IaSVQwa1QjABpOzV5P/by
 HW6SyFHf1sL+p7ImuGA==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a47fa35 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=u0cZ2EjT8PS4VQJ4ig0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030181
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

There's no need for it to be in cpu_helper since riscv_aclint is the
only caller.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c        | 8 ++++++++
 target/riscv/cpu.h            | 2 --
 target/riscv/tcg/cpu_helper.c | 7 -------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index e27e5fb394..361a8d1bcb 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -40,6 +40,14 @@ typedef struct riscv_aclint_mtimer_callback {
     int num;
 } riscv_aclint_mtimer_callback;
 
+static void riscv_cpu_set_rdtime_fn(CPURISCVState *env,
+                                    uint64_t (*fn)(void *),
+                                    void *arg)
+{
+    env->rdtime_fn = fn;
+    env->rdtime_fn_arg = arg;
+}
+
 static uint64_t cpu_riscv_read_rtc_raw(uint32_t timebase_freq)
 {
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 396d9253e6..d6c5d6c1db 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -682,8 +682,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg);
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index aded995a7f..7a1ea53ae7 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -612,13 +612,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     return old;
 }
 
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg)
-{
-    env->rdtime_fn = fn;
-    env->rdtime_fn_arg = arg;
-}
-
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg)
-- 
2.43.0


