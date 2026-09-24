Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB426C98324
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKX-0002QS-TX; Thu, 24 Sep 2026 11:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKG-0002E6-AX
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lK5-0000S3-As
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OClKNY2224968
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3co/zBejaVOJ7G1mNfffL/HGKMkldTHz0Hzlnc9AK7o=; b=Q6+zmWgoBqLimTsG
 ykN2qOQvOh3/sSZWW0hoMlRI46s88u46gFRmJs6z8dS65I9sEC8e9lzelloqLDHo
 kV2zW2Z2rglC33rd6ddP6zJfw2YGXLQK0qQ9GGrecmeoP/jphg5W4eZk8M5t13BN
 nKx14L/AoS0WvxQg/4jyydzttfzj6hh8t82wDludOjfa0Gf0uWUbQ3Fku7tb4Oe3
 TKvGtQStbvDUKEw2MUtlvJL843E22gPvLtjgBMSOx0JuqJ3xLrnMt+O0bktrFZuJ
 Uk6pd/9GOKblW/S9x0tUSmfsw/aHUPNDiuX3g1/FsE2OKmXIGTIf+0R+5fhM/y03
 bFmpqw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4650njs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:18 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7a532e31dadso2112963137.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263517; x=1790868317; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3co/zBejaVOJ7G1mNfffL/HGKMkldTHz0Hzlnc9AK7o=;
 b=Dx9lSxP8UGehuszjOceWnDmp8RkjiFEl6xU17+PnLkruYpTPVRyRgZ4jjkRIp639gi
 qvpVPDT3bg+UtdiW6QnLAez03C0MR1iD2X2jbepxoPxSjlDN5q/qUMx8efEPUcBc7Ysc
 7EkkgO2feeQVCxEYdO5t1UNAuXjnLNnQbVx968xnRMLUPAF27eCR15Zq3aJwwLDqb3dP
 gLLAoiun1quMm0nW93scic4i/cESd8O88Lu3Z+GaRV1D3wgcL4NiupjG7sdPHS5q5mpT
 lwHMckUu7P5DvUXORJNuQVj/AqQh6387GWaZFlWnHV+Jz4Vs/9q3efcQyMA2rE8hAd/i
 bUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263517; x=1790868317;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3co/zBejaVOJ7G1mNfffL/HGKMkldTHz0Hzlnc9AK7o=;
 b=qMzFTLWD0CV8NsF1WTZJ+nvTnKncULACFfs3KMxCz2MMyg42j3d9khkuOeK8XCX/ec
 srmZq9/cSBRuevTNQLI5xPdoiVOceT4g0lNWZyL1tJjKTjZxY74iiDp2kFLT30hQpJt/
 vC2f9rNP70Kcn0eIJuOJveSsdhk0dP7LgR4vk0Qm5yUZwR6OKDQ/DKWu0lfCl5hPnU4v
 StVPX3R7uAIbGD/uZSRwWFTIRoh2EscMCRqhm/qQ493a2jj19jwukDzhXHFpgUKXq/hR
 t2UYRuikiWbEsZr8pc3d2GUZAog9ORqmduOWoNbJ2SVxPmbWx8LGuVcv7JWgm3pZV85w
 vEFg==
X-Gm-Message-State: AFuF++licVzMIFSO/ljh5SgjwLzZLjj/bVFc0R7n0BiE/NBt4cZ3UfKn
 nyj/utkNFu2bGRKTu/pVrI21usXLR1ZO0kieMXjVyBkDckHSjukKg/fARA6NEcXouVbQJlnQe/6
 cQxSI1UNv3byiLyskqPbgzCMq463H1h6U1FRHXoUML3r7y2Sw9IBOsup1Kc9th2z+Hg==
X-Gm-Gg: AYBFou1ufRx8G+KDfT1y00LdtmyM3JfvUm4rb1wmS62/F1uoxtTy60QWg89vaYSBl8E
 Hidy8QEPyrDXsx7OvBzVv1vdhOHWy+SxFUDOtjuauQLUF5qgdsqg9Ri46IxqkGOyiK9+3PAZmMB
 x2o0cpk5Rc+dsZWCBNlekCaPVr0VAHzX5QZEOEBI8I5l+CVTgEG4NiO++bs1M/sn5HqxZ9gzNlj
 CnJqobo4nSAwliG53Kfh0Fi7fknKJvTTQ10YeU4b8d5Dcp1SitBNcSS/aNH9Aoyl6NMYACnmoZ6
 suyMcdFpMhUciYGnqbtBTvD+wDmNV5ciUlXBHrvbM53XLjTmBuYBReQp6bSvuDsbRH3nxo9Smu6
 rzqAD2sCyKYJ1i5iPOtMz1juvl2JgGT9SNGY5XHdt
X-Received: by 2002:a05:6102:f0b:b0:7a2:2068:6e37 with SMTP id
 ada2fe7eead31-7af1cea8396mr1452942137.15.1790263517195; 
 Thu, 24 Sep 2026 08:25:17 -0700 (PDT)
X-Received: by 2002:a05:6102:f0b:b0:7a2:2068:6e37 with SMTP id
 ada2fe7eead31-7af1cea8396mr1452917137.15.1790263516473; 
 Thu, 24 Sep 2026 08:25:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe43fc27csm67712665e9.2.2026.09.24.08.25.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:25:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/18] target/riscv: Stub out kvm functions
Date: Thu, 24 Sep 2026 17:23:42 +0200
Message-ID: <20260924152353.36209-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab540de cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=skaBmtu4QlQSHV9KHZIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: AsQyjfOsJHd52EosCq4iWoqru2d7OeJ0
X-Proofpoint-GUID: AsQyjfOsJHd52EosCq4iWoqru2d7OeJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX6KH/yyc1iiil
 zYSC4Ui6fygzghn3JWukb74++QEDEYMqd4hrAa6QFkGUG+AQdZ35iGkEZ+WCj3BwNHWh5y3Pztn
 VrY0/kMf3vghJtOaIjpS7tSgy9PQUqiWvtdsoPM2O8jm/O2OVyCN/7f8Kx0AfN6BR3xcRKyJFrd
 s3+u7fu1IuRVW4i1evlIbQVFiNacgA1tXusibrGZ0K/ovqNZT55nnFM54T1XIYyxgrgm02TXtze
 zKCISlH3h1olXQtZeQnuugmRSRJG/Uq6/RISfffNjUsKi5gIKiCvxl5cItznolu1rZgcFrc094a
 UOOFnxGCrJGhFq/coNjdQXGISRrPjYY4RoRy5RI03ET49DdEIE5cbuhZ8bFkrIlOHd8Ydim9f2x
 hgjIbEkEVGYl27viINo3f8T+PVrJA8WAgLCXupTpnRb1unjr0UwhEEorrepI07GhaqCGNbqE86J
 4oheMmUfl/pwSzAgrGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX0eaUox3Al66I
 tf0utf80+RFD7pPbr9KbE5WNDiu2zBM+LXrsD9rRUoRjx+26hoivdoHGD1lplvuD6jv6T1xUaFZ
 3rTHmyxFhksTnAlQnv5pdQXhD7qQgZo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240063
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

From: Anton Johansson <anjo@rev.ng>

Functions used externally by hw/riscv are stubbed out for non-kvm
configurations, allowing a single compilation of hw/riscv.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260918-hw-riscv-cpu-int-v5-5-f98c5a244636@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/kvm/kvm-stub.c  | 23 +++++++++++++++++++++++
 target/riscv/kvm/meson.build |  1 +
 target/riscv/meson.build     |  3 +++
 3 files changed, 27 insertions(+)
 create mode 100644 target/riscv/kvm/kvm-stub.c

diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
new file mode 100644
index 00000000000..64e39c96d89
--- /dev/null
+++ b/target/riscv/kvm/kvm-stub.c
@@ -0,0 +1,23 @@
+/*
+ * QEMU RISCV specific KVM stubs
+ *
+ *  Copyright (c) rev.ng Labs Srl.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "target/riscv/kvm/kvm_riscv.h"
+
+void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+                          uint64_t aia_irq_num, uint64_t aia_msi_num,
+                          uint64_t aplic_base, uint64_t imsic_base,
+                          uint64_t guest_num)
+{
+    g_assert_not_reached();
+}
+
+uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/riscv/kvm/meson.build b/target/riscv/kvm/meson.build
index 7e924150912..75e35b21506 100644
--- a/target/riscv/kvm/meson.build
+++ b/target/riscv/kvm/meson.build
@@ -1 +1,2 @@
 riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-cpu.c'))
+riscv_stubs_ss.add(files('kvm-stub.c'))
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 42d0f6d538a..e1b51d2bd4d 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -19,6 +19,8 @@ riscv_ss.add(files(
   'gdbstub.c',
 ))
 
+riscv_stubs_ss = ss.source_set()
+
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
@@ -33,3 +35,4 @@ subdir('kvm')
 
 target_arch += {'riscv': riscv_ss}
 target_system_arch += {'riscv': riscv_system_ss}
+target_stubs_arch += {'riscv': riscv_stubs_ss}
-- 
2.53.0


