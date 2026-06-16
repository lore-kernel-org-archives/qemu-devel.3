Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D62CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVon-0001xG-P8; Tue, 16 Jun 2026 11:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVol-0001lq-Nk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:35:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoj-0005FQ-QM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:35:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxaBT3731593
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 quGeWyIj+ay0uGXkySM3O/jRcX2BsNxbJSEHdVFTLB8=; b=Erm6BYKzAVZSZUta
 h2XedqyI/G8jnzM9UTvUyPBPif4FiABxXaQUz/Z0xqXGyH5lnBTOT9FFU5qzWLmg
 d19pcZMXwXmoIYTmji5E8m6MFGdQ5eTOnq+I36it/Q5LPxs5DX386SwDunUEudXN
 O/put5VwAp+bNE+wff0ISv9sXr57Yj6ECuxASEPe9a+kzPnyALvWNw5PoqzLlugo
 Ji/fSrVxuXtRqsB7VP0JfmWzrZzc2twY9ZoHD5RCS4QkyCkERYxqdPVaHU20QpvF
 na6J7Rpk/yUnmXp823RH9MxR0M33lhpGm024tRS2wIqiXePOCJW9TAknoom17Mxi
 UBPUxg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1yst5eb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:35:08 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-59eb3f8969aso2925331e0c.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624108; x=1782228908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quGeWyIj+ay0uGXkySM3O/jRcX2BsNxbJSEHdVFTLB8=;
 b=GkDjQSlA0ivZNEaOwia2Sq8j3dmZaPy60jCm8jbLP0c24BnCotivVeIMYns8/H7/EW
 ORS4Ub9dHXnApboevKqn0v0tb5oHt74FUrJuc9SS1TXCPWFBrXhyMSdAFK8lahe0CreY
 8vt/mFOBX8gy7Rap1rj3p1kb+rdmiBmp7WmXifwaTgQ7eGrBpQj7yMNY/AeAyOxrRR1n
 5GbW7uD77tz0BU6+VlU7V+eSIQMTEYQNAzdC8zucUBfTP5NIetwK+pr/sQ8HcjgbLFDE
 OQiJF6Y9v0DtqkUQPd3FhtMCR2mmVAksik1TxXrMlwI71EdDlGd+EJ6+nVKkqLzOgIBb
 GiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624108; x=1782228908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=quGeWyIj+ay0uGXkySM3O/jRcX2BsNxbJSEHdVFTLB8=;
 b=BbMai9VENl3txuZY3tOa8+0ayGOihombEfJjYUwuNQyHQNgs+EOoMp90DZjnp/6bk+
 qO9enbo5n5rL6RfZp34M1Wr6YngPYZ4uAOOYnA/n8zbe/6Hc80rsp3STo6M9RLWLBa+a
 9A+/QVvu7btZ0qHgf8twgEAockT4qTVp2oD/qOI2DJg5HWA1slniuFoTUou9MF0EPpEv
 q9ekxUGMYyynMvkcYiYwgXzjREM3UuwRU70FcEr/StaTpgczMo4xEMdowLDREBywsNVE
 4KiaMQwn/lz7F0MWOGMmsI7pTrnFTRhaJm8aIGUUaq3Ig+GgBmCZumIDt+3i5Y7gfCpt
 c+0w==
X-Gm-Message-State: AOJu0YywrID/KTFkZV4IxMCIRQ1VrUjlEWSdcJ888qyeJezwwpzGvdni
 GIOHzfvznQ2mbRwQIKiPUmZmeP4mKAmFh6LqH7I0ie73HOGCL2JcbEXbFfN3chXSi8xC5FuoRuP
 sAaC9nTt2+JMo/aSq80LAo47dwamMC6KaKKgbR9BVPDVkS3ECo1PqvbYKn6jk/Jr12w==
X-Gm-Gg: Acq92OFmtHEl3cdrXdN5nKGuyJdGPeHG6LWtFsaduRWFGDKgGX/OOVy0natYziBWuR2
 Xnl4IQLHIzMmt5Q/RCCpp8FuytDr6JGSubBQvYiqTW8s8paq9tY0oZ+zNYm4xPidimF2/DGFSnK
 MUOmp7bpepr/R2ciQBnuOOwtK1Faep3mF0KVMdASFDUfzlp1tQ7ViWrz8grdAZjqVZdhEiaUXEw
 CJQ2KO/3uIBbokmZwN9VoqCCOrnE+0oiThpliT4Is4VgZfQawyxUcCRAqA0Cp2zqrtscefYWGbL
 FrJI7AJ9EyGS0QrKhfnBHKC2S3BSZ8U1feoSBnEV2PhVxBYpfHIApx3u5pE5YhTKcBtzXI1Kj6u
 x4k/NxUYfUpZ9OJYTT4pf3cdef3AHjlspfT3nyaZkkRHeaRyagPZspueKLWopKdwYhddU2tcqip
 ZzbOo=
X-Received: by 2002:a05:6102:3749:b0:6d3:9409:d1bb with SMTP id
 ada2fe7eead31-71f60c13d05mr7776383137.19.1781624108010; 
 Tue, 16 Jun 2026 08:35:08 -0700 (PDT)
X-Received: by 2002:a05:6102:3749:b0:6d3:9409:d1bb with SMTP id
 ada2fe7eead31-71f60c13d05mr7775842137.19.1781624102712; 
 Tue, 16 Jun 2026 08:35:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26393asm48210285f8f.5.2026.06.16.08.35.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:35:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 4/5] target/or1k: Have exception_helper.c absorb exception.c
Date: Tue, 16 Jun 2026 17:34:30 +0200
Message-ID: <20260616153432.92939-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616153432.92939-1-philmd@oss.qualcomm.com>
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u9PuYID62X8n-yGcn7UyaLudkA4nviEA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfXyJV6oEv4+Fol
 rkCUri3h0BWidxbmgdIEt7QQ+mUTWbHpslEDs1UOLsLR4ySiJfaX8U1WwXngJtcHHOwlBMBPq35
 RU23vP7FmUMlAFzKkBI71IQAyAXs7ys=
X-Proofpoint-ORIG-GUID: u9PuYID62X8n-yGcn7UyaLudkA4nviEA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX9L65SDuGqTNj
 0eBc0FHNI0ypTTXRuogphGlg6ws2fXJuRh1/t8rgey4Zfa3uJJ+u/nzI4Xzd2T5XPHG3hsFJfyy
 oWDj8sPZXFKGmj5Fwb6x+xS+lrQ7Yon8S35ymumxcYncI4QVwEdUxNsbQcGRvnzL3oiWIm+uEj+
 k7x9MBydcDrNhkJhZ+WS3cXnjy6Ka/EuUPufrq3MTfx0BhCtjRi8I6fyXJ9Qe7JWtnIJ+FJGppe
 rZeWUu5uUYgJtp28UwIKXmdETmpEClwv31F8PrC+MmUqNgE6YI7Cn14KypLE2I5Sk+LMeaHbQdO
 vZ70KLOe+S0NnkLH0q4rq4x7SmwzU+Hv2P1a6Dxktx4VqNUlxrtGRm7PY/JNpAAT4ARSzehE9f9
 FgA4fuzXmF9ST/Nhr6Dx77u0qj6xZbKB7bU5FJcByzibERcMsvfeFRYvB6tMJJCm9mO0WtCrs2F
 WkuSKHRb1rrSndQS9dw==
X-Authority-Analysis: v=2.4 cv=JJcLdcKb c=1 sm=1 tr=0 ts=6a316d2c cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=GxDvOs8Khul7NjIAD50A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160159
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

OpenRISC is only available with TCG. No need to keep
raise_exception() in a distinct file unit, merge it
with exception_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/or1k/exception.h        |  2 +-
 target/or1k/exception.c        | 30 ------------------------------
 target/or1k/exception_helper.c | 13 +++++++++++--
 target/or1k/meson.build        |  1 -
 4 files changed, 12 insertions(+), 34 deletions(-)
 delete mode 100644 target/or1k/exception.c

diff --git a/target/or1k/exception.h b/target/or1k/exception.h
index f62fc314c1f..654ac9e515d 100644
--- a/target/or1k/exception.h
+++ b/target/or1k/exception.h
@@ -20,7 +20,7 @@
 #ifndef TARGET_OPENRISC_EXCEPTION_H
 #define TARGET_OPENRISC_EXCEPTION_H
 
-#include "cpu.h"
+#include "target/or1k/cpu-qom.h"
 
 G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp);
 
diff --git a/target/or1k/exception.c b/target/or1k/exception.c
deleted file mode 100644
index e213be36b6b..00000000000
--- a/target/or1k/exception.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * OpenRISC exception.
- *
- * Copyright (c) 2011-2012 Jia Liu <proljc@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "exception.h"
-
-G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
-{
-    CPUState *cs = CPU(cpu);
-
-    cs->exception_index = excp;
-    cpu_loop_exit(cs);
-}
diff --git a/target/or1k/exception_helper.c b/target/or1k/exception_helper.c
index c2c9d136528..3e76acae9c3 100644
--- a/target/or1k/exception_helper.c
+++ b/target/or1k/exception_helper.c
@@ -18,9 +18,18 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "exec/helper-proto.h"
-#include "exception.h"
+
+#include "target/or1k/cpu.h"
+#include "target/or1k/exception.h"
+
+G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
+{
+    CPUState *cs = CPU(cpu);
+
+    cs->exception_index = excp;
+    cpu_loop_exit(cs);
+}
 
 void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
 {
diff --git a/target/or1k/meson.build b/target/or1k/meson.build
index 7cea45287a2..dba5044b655 100644
--- a/target/or1k/meson.build
+++ b/target/or1k/meson.build
@@ -5,7 +5,6 @@ or1k_ss.add(gen)
 or1k_ss.add(files(
   'cpu.c',
   'disas.c',
-  'exception.c',
   'exception_helper.c',
   'fpu_helper.c',
   'interrupt_helper.c',
-- 
2.53.0


