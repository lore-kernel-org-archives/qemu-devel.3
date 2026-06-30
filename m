Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F22C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegZN-0005Ia-Ex; Tue, 30 Jun 2026 18:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXw-0003Lj-QR
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegXt-0003zq-EY
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDeLX2920093
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZHA9oyIZ+nrX6vsb6ZZDJzajrIq4tDDe95w5tKqJuSM=; b=ZtghZkHqiS57XdSL
 GFtMjk1ZsYt3+Cd0r/tZEdCXGkbZlK9SoA45cjQFbVEMhiDiRzR3efRt4C/kcIib
 Lw3VEQSQG8Cfhknt7Ro6Or5Vzwz4CcEsv3xlp591lYJM/Q3zbIGXu24r4MP/6xb2
 blDR0QKLP1FtdFaToecrYkAA20wcWYNK9fCMXkXLv5XK+aSElUIBO+uYEicXoIjS
 E/VidzuOLwgQPTdWso4Upmtz/hczHE5jkgnMeoADBL6E82nIRbcDDmQtrXV+XDP0
 mCr0stSbm8/ayAZnVq1T2Wo2PNxTUyuY8+zimYqiKt7ubJNJRGczRDtZOIrBBwm4
 MjCcgg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jvw8uf6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:02:58 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bd4b488c10so5719033e0c.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856978; x=1783461778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHA9oyIZ+nrX6vsb6ZZDJzajrIq4tDDe95w5tKqJuSM=;
 b=DkEl/qgnRH978kkBsJEQPVFArNRJgKJkpVavN74bP4Ui+D4MI9VOo54IRxt0RF8Y/Y
 XxB1lQNBzKJNXjq4s2g6DKViEur3ciowWfFO5o7dyjSpMjCDn+dfTQxm2hgMKwI30+vF
 f9fY2vadoJ6EARbiosMCzTaabNS0DNYi6O5hlB0gqafiyaImEW+SNpRych6MTi2MIS8e
 i2wPKlllML49Yg+jXFlWc6plv1hOvGiQr5lJD26+hJsYo3stsWCURMqT6aQLZ434+uMe
 Pud3zAHIjGYAikDcQX4ZSq9zdc16j1wiuhz+ytigbSL4/LWAtnq8o3aHAujVCE/cuQ1i
 iT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856978; x=1783461778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZHA9oyIZ+nrX6vsb6ZZDJzajrIq4tDDe95w5tKqJuSM=;
 b=JUfrlVKlmuMwUlT3Exzs94Ew/og3ipnCtSP++NRxvqG5xeE/chZSklouZMKX60fiWM
 hrr2Uo6YuqzXRkGMAFgKlxfLir4LQB1iuxLM3s8nYW9XwhpyKEZcyeuOlGI0uTxoGh4O
 XVXoieukV3C5X0gp/UQ4tZ4vLytFcLuNlC0yqkdRpJVICb31MfOW01p5+h2xeUVKjsEt
 zZVSjp1X+BwYREw8hLpW047Ry3v1wLtz9v5AD16II93oai7tfff2HV5K78MInC7IVakq
 YcZkPe58FJBg+AxGMc/WO7lWk8u8KoMVeXPtukWRg7OQ/c4hlCp9GrGEmHr8GUd6hBmc
 2i3g==
X-Gm-Message-State: AOJu0YxGh5tyvsGQ1ZMHuTHDsMzyZli5p7Pk46oSUG5gy8jY7qM3gVxK
 pa8I3czF9L9uYKMdm+RyTs821GdHYvmSzvs1/DZ+ZCWil8vKIE8MZ89R8PKrAfoJjXf9bdKOhru
 5+aZVI2kh/mtx130IbKDx1aMKl0jcTCT6AMs3JwqRFchA6U/iK/l8XA102/Y44041fQ==
X-Gm-Gg: AfdE7ck/38OntDNW2C/AC5VIXBysccbB1Aurcdx98aHjJF3YCfNpChbum8u/om7DVYe
 PFIyKw85JO9shwPnO1YGKWKg5iGxcFCZuZuDdr5oOiztGHMRdDvQHfaAcauTbEkpqGJofUWaZ1Y
 gj3CfZDhDLkVM/QoID9fpiVUGX+VhalD28oI8y1r0DIOSjVlJoYxdnWRdJ7esLI/XeXBXkRJ/+B
 4CoPq1xVQkqCt3RJst9KGDN4Hw7E0CnBVTJkupBdzuZbg9Wl8dIeS2oyev/Gq1FAbwC75rCwZpK
 fV58yWHHKdJZPeDak7s3RqW9SD3CuSYscUhBKrN/7Nrta4Szi9M4dCagS71vOhcKZa3nyY4YH8E
 njQvPHl5LCs0P6yyc9qskv6JxXYiFhQ7ADAn8Fg828uWfMyEhlYrO3AK6NMQeFS6/Eez5
X-Received: by 2002:a05:6122:4582:b0:5bd:bcb1:453b with SMTP id
 71dfb90a1353d-5bdbed729bamr2483861e0c.10.1782856977724; 
 Tue, 30 Jun 2026 15:02:57 -0700 (PDT)
X-Received: by 2002:a05:6122:4582:b0:5bd:bcb1:453b with SMTP id
 71dfb90a1353d-5bdbed729bamr2483813e0c.10.1782856977284; 
 Tue, 30 Jun 2026 15:02:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4540aesm26070855e9.0.2026.06.30.15.02.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:02:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 15/33] accel/kvm: Hold have_guest_supported in KVMState
Date: Wed,  1 Jul 2026 00:00:42 +0200
Message-ID: <20260630220100.1289-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EgtqZDDQq9mmCOvsAnF1Axtq8TwpVSb6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX+QuoB9hWCpuO
 471pSKiA3aRrx3u3qoErznsPOpuN4QtjccdZaRQNH/U5mt1N7T50cquqdIZwnkeMvTvWxQKmnYM
 7tpeu82RKIQHtdqEXp904d/Luq3dH+A=
X-Authority-Analysis: v=2.4 cv=JKgLdcKb c=1 sm=1 tr=0 ts=6a443d12 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=O5kNlQXW-qQlE3Y8R88A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: EgtqZDDQq9mmCOvsAnF1Axtq8TwpVSb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX7EgVTOzMKzM4
 74QIIveT6qwPMH1UH+7N6trZ1RMNghhXW1NWJb8TD6lW6i1WH0OY2Gy7Dw6Be8DzK0KCahD3TMg
 XEc+4W9DFXZvFKTE+xZ/YvxfckNc89DXp0I98NWwapMmGZNdKM3xoe19+vcNVPcl+jpC1er9Ham
 1T/62U6QyVJ1VFoHAnkh7YTgUQTNartOmy0jJBfIqMNCwsGO5s3UhUiqn6JK8dWbig5w2Z/YVBp
 VOivNaqBFyOA9HuCptGRx6N+khxAmNYiLDqwJonoheOaxpP16p7Fp13FTL/1mvWFIlDxig2x2L9
 02q9l+Wz2iHV7KpLoPHntCLWNHhl+SUyEBW3ICdvUZCkScmCXsgtUxYM/XlwjInCZwo4MToHBfE
 3I5UTUdsi8FUBd7Zh/wXWtoVj7jJq8HNElo8u1H6z/Gxz1B2gF6wUegPpFe35AqWSct4kg6Zhcg
 KyUX9tyRjpu4knMl1OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300215
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

Prefer to store per-accelerator variables in the per-accelerator
state, rather than as static variables. This is a good practice
to allow concurrent accelerators in the future.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/kvm_int.h | 1 +
 accel/kvm/kvm-all.c      | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938d..49e90cc0235 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -113,6 +113,7 @@ struct KVMState
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
     int vcpu_events;
+    bool have_guest_supported;
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 1231c010fce..80d8ef1a974 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -104,7 +104,6 @@ bool kvm_readonly_mem_allowed;
 bool kvm_vm_attributes_allowed;
 bool kvm_msi_use_devid;
 bool kvm_pre_fault_memory_supported;
-static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
@@ -3040,10 +3039,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_sstep_flags = 0;
 
 #ifdef TARGET_KVM_HAVE_GUEST_DEBUG
-    kvm_has_guest_debug =
+    s->have_guest_supported =
         (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
 
-    if (kvm_has_guest_debug) {
+    if (s->have_guest_supported) {
         kvm_sstep_flags = SSTEP_ENABLE;
 
         int guest_debug_flags =
@@ -3835,8 +3834,9 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
 
 static bool kvm_supports_guest_debug(AccelState *as)
 {
+    KVMState *s = KVM_STATE(as);
     /* probed during kvm_init() */
-    return kvm_has_guest_debug;
+    return s->have_guest_supported;
 }
 
 int kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
-- 
2.53.0


