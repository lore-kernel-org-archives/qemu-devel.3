Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442B4C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegaS-0007vx-8O; Tue, 30 Jun 2026 18:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegYB-0003lz-Bb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegY9-00047Z-Fy
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:03:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDmIW2937296
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OijKqTgpoJMIkQ3TU8uTMw7WZJkBtSN0JpdlSaU0fwI=; b=ERGTrbzsPGCWmfb7
 0DaqqX14r+StzVohOz/hrmRcIvIW2UTFCWeUte+fppRIEJX0SShgCFao5LQKl/28
 GT+qOJj2rveXwWnymgDhIXPKViz8rI7Cc65SRnpFTebPxUfTooEE9W61xqkfsjjw
 40XLMDKS8EJDX7QJZFikfxYFtRAK7TTktIKUTVIa+HC6c5sgSHtrXKhjwH2CmTj2
 QzHKUWVJMeSGlREtwCMHJcQ9LOSCVqp8225CCU59derRBO2YMDX7c+QMRI0hGpcy
 kz5w0doKcHWnxhSDT8w2qWP5MmZXY4XmnLvySS5wZDfVg2S3RzzSCoGyzl/s4y3n
 lOL4NQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0a3yf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:03:12 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5bdaa7039d7so3329651e0c.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856992; x=1783461792; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OijKqTgpoJMIkQ3TU8uTMw7WZJkBtSN0JpdlSaU0fwI=;
 b=P4X4SyC0tIO9WdKWtBPwXQLxYv5qBClRyY4Z0m1cqhBpZO/vJcHjqgUZZoSted34iq
 JB2pkuUc//5YDQUjNCUChO59QMhZNaw3gy0AB4o0oRlbRj6KArJy1DO2hVE3XqrWDB0G
 KyPhvIC1nPjV98C0gPtQZCbnG4557IK0caK8T0YzbMe6FvzL8V8IPTr8dmeeAfSDno0v
 usYgdL+l2rXhlvZq9GjChej8E43gnIfCIykN4rYqt1BM+ykZeDxUHQZedE9rMnL8B208
 Gsafc6srLnbJzdWM3M1LQF6QP2lCffGWpkeGNKSUF0yD32XgHXobMM0rkLZkiSVVBvte
 8PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856992; x=1783461792;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OijKqTgpoJMIkQ3TU8uTMw7WZJkBtSN0JpdlSaU0fwI=;
 b=l9bASzv9qA3qW6yu9kclohzluQyYeH89Pc0GUCH9V58qd93gLwO0r2xAsNbVzhAuSK
 k9W33DSyMpdYVf9ewrM9hgT3ytI74mykxJhi+muAZJT/o7/N4SCqg44IBWWhrg9JgdJf
 Ar+1oSlHjb/QxeJr738Kzjrgofrupfy0akOk4wnfRv9tXzAKj1cRHrohmlXW77lQwLnp
 mtWP1w14erhG1e62RPVBj6K8XVmJpezJGUAjlWvu4J3pu1/qeDt8yKluQ51JnmxDRYjd
 BWtuPyo+H3RDWL48o49XEgJJLLD6mzqAaOCT/8MG7V/gB/GehA88N6f5f5Ci69n5Mkxl
 0Ttw==
X-Gm-Message-State: AOJu0YxVybVVXnXlYosMVTmfYSHn+0KEM3jilr0KrPt+mTjEE+9cpYYa
 aSHbrBcpufAOiqLPuHsKyayrmSUd/RTyr+W2UatysTme9cLxsF8iO5M8AqdQfwV8AOePSNkqxSS
 682Z5vt+FEnnj75eNewTTYD6/HYDxkz0WlCR9GsMj09nCGxlnS9N5f+RhtUrvrJoVXw==
X-Gm-Gg: AfdE7clo/EEriMfctEo0pDh0rAS4fWPVUHyAroYj4qvw+qPjHhe22aepd7/1j+PfBoA
 sN/pPj71Zx3vPvt0AAIzqNbbqOn3ZqD/MzO5I2+oZRckXT5OKy3cE5o0mi/ypjlCCUZ8TKbvqsM
 F6G0IgnD6dm9OUIF+voKZ9lPBGpyF0pp/KoKdk+XtJ14u1ylso9lOPxZtFGLYeCtecj9r/8yBF3
 zLI2lytbi0aJS0FUOHuJMDbOwHdoprry9xACVetuqiqF3kFE7ml54R+Sw55UxwFeDdVDgRXiQbI
 z0tW18NI+OJibO/3t6yHNDO9XF6dGaS5nJk8D9dXQwtIRU0H0ruFVKZ16JhZr2u3Nt4oYqap2+g
 dMNr8HdVphEmEoRp/kaHl5DhhaANv7WxVHU9UZv1V3tjb/EIjlGVTQQO0muE/jv2v3eCB
X-Received: by 2002:a05:6102:b13:b0:726:717a:696f with SMTP id
 ada2fe7eead31-73a38838216mr2991097137.25.1782856992390; 
 Tue, 30 Jun 2026 15:03:12 -0700 (PDT)
X-Received: by 2002:a05:6102:b13:b0:726:717a:696f with SMTP id
 ada2fe7eead31-73a38838216mr2991078137.25.1782856991924; 
 Tue, 30 Jun 2026 15:03:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4d2a9fsm27705845e9.6.2026.06.30.15.03.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:03:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 17/33] cpu: Move BREAKPOINT definitions to 'exec/breakpoint.h'
Date: Wed,  1 Jul 2026 00:00:44 +0200
Message-ID: <20260630220100.1289-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX9e8bZwNg7i8i
 dAYUXu+MpL9wClgV8NXLlYNJySjCJAUJoBVhQkt8wRXLdavuQvEYNcxFPsLXAmURDSgapeLm9oP
 4g9DKLJwWekCTYkPs4Q46lxxWsJlS5LgVC50Ismv5DhUcR1nJttyKKjVk+L/IfQydToKSBopmU8
 M2lQD7gRaRhby+8GV0C+uZpVKcniDWbo834qD3OEvDPg8R/9CBqTcZgkPYhLrUhDWo6KJPR/bBw
 yVA2pcoX3Z4rbQOuiZHlmHpJ7t/7d2fUQqhH8rinq3YoUz51SPeJL4Wo/5SML+vBJPHYayqvEZh
 3dXqzgB/XcGByrcRBoQWSkPPh42s7FL5XXkiuny/kAs3uVt7uVgaRTeNXe2OSi4wlmhIWUG6iGD
 /xEC2eRwZGkGOC/KKr/X4koFBGXUaoxo/poZeVLn9Z0NyiePdGjU3GF2iuuGhl6LNspAbDgmb99
 SYV7dX8gn3ByBeNrDVg==
X-Proofpoint-GUID: eqD6KSeT_debOF5WKO3tFL91oAeQQ2K_
X-Proofpoint-ORIG-GUID: eqD6KSeT_debOF5WKO3tFL91oAeQQ2K_
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a443d20 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=yZPQLu4l72ctXTxYlJYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX4v40on3shDQB
 srccBte7FAKw1cn/Qcq8WoYKj9WQSbibtD3C6fTDLuYYZuYGAIBQt5RNlQB9WZhgjlrbaiDaJwd
 wU5UqMe88hzHr5jt/IhTHZX/Ylz9lPk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/breakpoint.h | 14 ++++++++++++++
 include/hw/core/cpu.h     | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index 95f0482e6d0..cc6fedd09fe 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -12,6 +12,20 @@
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 
+/* Breakpoint/watchpoint flags */
+#define BP_MEM_READ           0x01
+#define BP_MEM_WRITE          0x02
+#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
+#define BP_STOP_BEFORE_ACCESS 0x04
+/* 0x08 currently unused */
+#define BP_GDB                0x10
+#define BP_CPU                0x20
+#define BP_ANY                (BP_GDB | BP_CPU)
+#define BP_HIT_SHIFT          6
+#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
+#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
+#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
+
 typedef struct CPUBreakpoint {
     vaddr pc;
     int flags; /* BP_* */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 60a23d6f38b..b1df615792a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1138,20 +1138,6 @@ void qemu_init_vcpu(CPUState *cpu);
  */
 void cpu_single_step(CPUState *cpu, int enabled);
 
-/* Breakpoint/watchpoint flags */
-#define BP_MEM_READ           0x01
-#define BP_MEM_WRITE          0x02
-#define BP_MEM_ACCESS         (BP_MEM_READ | BP_MEM_WRITE)
-#define BP_STOP_BEFORE_ACCESS 0x04
-/* 0x08 currently unused */
-#define BP_GDB                0x10
-#define BP_CPU                0x20
-#define BP_ANY                (BP_GDB | BP_CPU)
-#define BP_HIT_SHIFT          6
-#define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
-#define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
-#define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
-
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint);
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
-- 
2.53.0


