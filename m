Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879CAC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegYD-0003oT-Ch; Tue, 30 Jun 2026 18:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWf-0002ZB-38
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWX-0003hJ-Gv
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDc9l2959972
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z+xL8MKC11RapxyAXs8PHasCSN7xyle5CPBeAQ7XaVc=; b=LdH3R2n+uqp1aojd
 zK7nv3xMfiBbpfcq6YnS729RcOtuUtOJCgsCuF64d7fJRqrsnNXkHjRI+7KqyC5P
 6IeEJmOu0B1UobQSo2ms5pLNsWI16DSJFPnedgpmNOAB8MAwE04C9fxdTgLGloOu
 qB2RupybpHBAEQ9qf2SriNTWCiumoZIm8y49xmIrUW/WdHmcWpguaAeBNMtss/85
 ZlIZCOdIj3hD8C5qzy6nGNXB/eI2Hj8DB+1VN0j09ddubqcws4lZYpws6Q2FFts7
 OL6HD35WZ0a1vZoWAhyNo8knO23Mp/qfzGG8YNI3KHo+mKQsffRcjrWONj7zcML6
 /6TO3g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j9113n2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:43 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5bbd01d56ecso2064118e0c.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856903; x=1783461703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+xL8MKC11RapxyAXs8PHasCSN7xyle5CPBeAQ7XaVc=;
 b=KtKGMtCK9UGqkyyN+GAUFdyCJdecKZINek/vztCB5W7adrha60q9E7TR9vFMXyXONn
 zdY76ykBTIWUTz9Zd2z0Jt3sIBHYL+0M6oA6kHWsCYp0hKzWwFDAMmNUzTYaSSiekN5c
 NeIH3JnCtSMpsSKWPJRrCoJ9rowt7ip2wyeMklm6sawN3NzTmQJ/wh7Ct1Y4JQpLTxxi
 104j+F5kpYi/5ZZ7lAQgDDtCQnnmMop2C5NJzsSwhwfYgRFRpylz8kQtHVHYkRK1sZ0/
 VjL4Xcv1pJ4jDl6iLs3iUgq8StC31X2+qMdhhjhuyruGOjdESZDAxBE1JS8ezCKzI3w3
 Cexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856903; x=1783461703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z+xL8MKC11RapxyAXs8PHasCSN7xyle5CPBeAQ7XaVc=;
 b=VPTZ0E+h9QZcodu52Hulp+5F6ENHp5TP1gBLvkVxu/eclmsQha2y7P1brzP0PNX1Sa
 yNvlt7fivhFVcnbJEEzUXTqnrBqTkJ7+yD5jYZluAqRuzr1PAoo+Oi4kgjfpgK+5foAN
 986kb6xpquvuDLpRGxPBLxIphzezglxuXtvJa0wRKAS2kHUFsDN7OYpgZu1j+5MdYIQd
 gNa0ZnBoEZULAnwslRDFCMVDcmy5kQGTC+bveONS15H+DQeIMNJ9iAfY18M9QptAlJjh
 5DMUKfxzWUWrxVouEblu9a/LM6icrBIiyX8b+HxVMKz0fTlxNkKMAwq9vujkQjkhwFNw
 J+Vw==
X-Gm-Message-State: AOJu0YxcRkajf+mughJMW1DzcavYIVvQgx662x5xX4HPOiPAaa6EMUE/
 d0mQzbjnMf9+xn+95uo18pHK+mf8ZI9dQtfmycBim7TfDqtTSipr2wgEdbCS9ncPbJS324cg2TT
 OTaz+4Uv1QjgXhGf7PQICYPVKLYgrNBxLVsJwktCEFt9qa9UGXhjNjhlTnkhx6P6dlQ==
X-Gm-Gg: AfdE7clIUeyZ+JGTFzmrcf4jGYIc2ED62CgGsUcbbfe5ud3zx3LacYrGID/f+Zn1bvU
 XwfZr3PhAw2b2iAsKZTtnVc43plxK3iOSUUrUA3jdclY9X0dcPMn6DATS1R5rrjwy7WDFuE3Plg
 /V5aP3SS3OMCnqfh2HtHOhb+GEzJI8AI5t7b1b4DMqNkfK3WYcWcfkf3lX78FqaLpPB+kZC5sb5
 lh2EEyr2uZGe6JFCwFKYPId646QNsubTUYqadIcxXg/hvxDHPnDgSNavN94EQpdPK2q/YzXxQIj
 0XknyJu+fB9QaShend4KvxzREBHC7jZa1H1AJaoUBQxTTIZeRo07Wsz4T4irCeuE3vWtrcZCZau
 4XFYUNjgBdWFXFBFvxfgmxsdkJLRDex5eqAvY4rVVojLmEA2g5gXjaKLT6mfa1hSRMCe5
X-Received: by 2002:a05:6102:cca:b0:728:53be:7c87 with SMTP id
 ada2fe7eead31-73a365e95d4mr2746745137.7.1782856902978; 
 Tue, 30 Jun 2026 15:01:42 -0700 (PDT)
X-Received: by 2002:a05:6102:cca:b0:728:53be:7c87 with SMTP id
 ada2fe7eead31-73a365e95d4mr2746658137.7.1782856902490; 
 Tue, 30 Jun 2026 15:01:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475641e4618sm11302940f8f.9.2026.06.30.15.01.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:01:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 05/33] accel/mshv: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Date: Wed,  1 Jul 2026 00:00:32 +0200
Message-ID: <20260630220100.1289-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LhW03g8OaB7lCIMxTNar22XBON7riU_o
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a443cc8 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=3ch_I0QHNd5-WzArR2wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: LhW03g8OaB7lCIMxTNar22XBON7riU_o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXztqgoAoueHoI
 PBRvAqcByWnXsK5HVhPUdPkmAaoZ99GHuNNmRQOSC+g7NjAFr/m5rJfJk+zbfMV8nzMCjRBox0p
 9BMyhpMHVqjqcUkHgaFVRGetHzWg41k93jkW8GU+bKnDrxhV2gqyDD8rrHCha0i1F3FGemTdV0m
 4BKBqRzPbhQ/H6LF/z6P5MdKHQqR/QvFmLOPcGf1XX7vyLHy9rrcoRj0w2/bS21Zoucc5NFT4Ma
 aBN1hv+WSnClGlz3N9yr6Z1recC2U69YUxLhfaVhzi7GTRv0sGv9frkUAxqB82bf5Z/auXv4kcS
 GntGvCsI7kNjIJS06dwlHuoJiwMYKIc2a6Thnni467T+QUgbsCFy3sjSBxe+xcpIbv8t20uhKGU
 wotLiBZdUPaLHPUrCM/JLueS/HnR6mNe8ktPAY49qVjX/oZhDP7OYnP7NTS4rcZZIhWyR/pj4tg
 tL6mOGAu0bPEyzVJTuw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX1GO+fSnjyHt/
 hDtYVgWRVj0yjVjgQRkn314wdBlUrxUdEq0hH+XUH7ROnSEUikOwl+br4XFnqEVbDzbS0RXkhMg
 v41wlkVnvY3Q/uStO3/phPdFJHpREVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

No need for accel-specific @dirty field when we have
a generic one in CPUState. (Other accelerators already
did that in commits 6f13a0ada01..36ab216b81d).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/mshv_int.h   |  1 -
 accel/mshv/mshv-all.c       | 18 +++++++++---------
 target/i386/mshv/mshv-cpu.c |  6 +++---
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index ba3073888ac..b91c4d661a3 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -43,7 +43,6 @@ typedef struct MshvHvCallArgs {
 
 struct AccelCPUState {
     int cpufd;
-    bool dirty;
     MshvHvCallArgs hvcall_args;
 };
 
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 9452504ac28..1959baf6672 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -531,7 +531,7 @@ static int mshv_init_vcpu(CPUState *cpu)
     }
 
     mshv_arch_init_vcpu(cpu);
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 
     return 0;
 }
@@ -617,7 +617,7 @@ static int mshv_cpu_exec(CPUState *cpu)
     cpu_exec_start(cpu);
 
     do {
-        if (cpu->accel->dirty) {
+        if (cpu->vcpu_dirty) {
             ret = mshv_arch_store_vcpu_state(cpu);
             if (ret) {
                 error_report("Failed to put registers after init: %s",
@@ -625,7 +625,7 @@ static int mshv_cpu_exec(CPUState *cpu)
                 ret = -1;
                 break;
             }
-            cpu->accel->dirty = false;
+            cpu->vcpu_dirty = false;
         }
 
         ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
@@ -746,7 +746,7 @@ static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
         abort();
     }
 
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void mshv_cpu_synchronize_post_init(CPUState *cpu)
@@ -763,13 +763,13 @@ static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
         cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 }
 
 static void do_mshv_cpu_synchronize_pre_loadvm(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
-    cpu->accel->dirty = true;
+    cpu->vcpu_dirty = true;
 }
 
 static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -779,7 +779,7 @@ static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
 
 static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         int ret = mshv_arch_load_vcpu_state(cpu);
         if (ret < 0) {
             error_report("Failed to load registers for vcpu %d",
@@ -789,13 +789,13 @@ static void do_mshv_cpu_synchronize(CPUState *cpu, run_on_cpu_data arg)
             vm_stop(RUN_STATE_INTERNAL_ERROR);
         }
 
-        cpu->accel->dirty = true;
+        cpu->vcpu_dirty = true;
     }
 }
 
 static void mshv_cpu_synchronize(CPUState *cpu)
 {
-    if (!cpu->accel->dirty) {
+    if (!cpu->vcpu_dirty) {
         run_on_cpu(cpu, do_mshv_cpu_synchronize, RUN_ON_CPU_NULL);
     }
 }
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 126ca40b481..1c433c408c8 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1692,7 +1692,7 @@ static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
     return ret;
 }
 
-static int handle_pio_non_str(const CPUState *cpu,
+static int handle_pio_non_str(CPUState *cpu,
                               hv_x64_io_port_intercept_message *info)
 {
     size_t len = info->access_info.access_size;
@@ -1748,7 +1748,7 @@ static int handle_pio_non_str(const CPUState *cpu,
         return -1;
     }
 
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 
     return 0;
 }
@@ -1909,7 +1909,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
         return -1;
     }
 
-    cpu->accel->dirty = false;
+    cpu->vcpu_dirty = false;
 
     return 0;
 }
-- 
2.53.0


