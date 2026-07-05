Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DDFC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUsu-00023e-Bb; Sun, 05 Jul 2026 18:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUsm-0001RW-NP
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUsk-0000Zl-Hh
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:12 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxdBZ2859781
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7tIMKNTooY0mWH2w8clXt9i3UzLCWRfh1sTC8E6MetQ=; b=Q1Ujnq5FSORn2Sew
 svcJmVpOgWKceSNVN3d8+LffMklURs1WxhlyxnCZNxks807gXXyC/VPP8OoJvVv0
 CX6SNJ6cJbKP4i680b1LfxBI0ME+4QmVnnbd4TeoHBJtc3ne/qaVdz5Z/4lacPQD
 JvG1o58pJlouQdTSwAyNVblVN+jI/MBO/CwX3wuJAWzDMUxOl8HhV35TbDoC2Vtr
 brHW1dQ1U2Z1xlJUQ5M7vZapbAIL7jgjyVj1mDa0MvPpp3kfXpN7ikYpkyUylxUZ
 tDwSvbEZDecagDLXUya06gv5eYpTb1dspHNgFukDb7LBieEFhnBcrKvnFAwjyRnW
 KdSV7A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3bgn2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:59:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so56218301cf.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288798; x=1783893598; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7tIMKNTooY0mWH2w8clXt9i3UzLCWRfh1sTC8E6MetQ=;
 b=LbxHU5HATaXIAlVZBqiKtr/FsPP9YRt7OoyJxRy+WYug4rxIXDa4y6cxtwv6CaVEdV
 ZceN+SC6Cz4Elgam6glB1//JyXf+V1ek1SzSd/8i2wdHydgAs8xNh9bTDHPRGAgkYVZC
 gORLC1dKl+W4WX41CGZ9ub6DjxYQ74ncKn3gnNG4tCXOMgmpk1rwtB5/Q2fGqPQg/Zzv
 WIDSeuhF14j084wlXMRCO5zMsNQGz4lYXgzcGm+H1MmeCh9qskke/V4p/tUGD4LarKZh
 1XQojX7q26O0FirJkvP0LnxcHlgxfBfM6EPYDFwT5Jc8ztUjUS5e6hAcfic0m+9YjibA
 ssqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288798; x=1783893598;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7tIMKNTooY0mWH2w8clXt9i3UzLCWRfh1sTC8E6MetQ=;
 b=DVGgdboNm3R4CJFD9mbBG2NJW9BjrreBWxF+y2SJD8I8g99AJy2BZfFWjNHIqvVxbT
 yO5EqBGHxQljjdUy7xNYrCF0Xf8BvliJtnIEqW5LbjefMYPIoOYs8DIdldrgztkeRJcT
 20Z9cPeboQEqml78zJHt+Kz2TufCSuTFdUDVnDaWupOwXrvQMYwDCkfqNjKV7ZSA76LS
 H2T26rkWSNdEfC+utphKU3Lha3OgEA1uflbSCWFxK5jy3/gCw9Nf7Hb0A5v9PgIsgp+K
 bBviKZDF0IKwFU4VdOFICwgr1V2cfu1E0xWc3YSsGqXEq7m/TvvQwUfNhuN8exZeoIq5
 10rg==
X-Gm-Message-State: AOJu0YwTOkuelEohIlt0Pg26jeEeTQHv94weiWiaBzP76iocRG8W7Ny6
 E0bnHO+d2kXOx7UxMXmk0HoJdPLIrEIrmR9Vzbxjei6H23g40exXI/rhFTQMPMQ+O6hEZEIn/UF
 dck8KYOTTFhr4syroPnq1ajr9MOX7xjNf1NtcWxETMM01OofzEonB/ZEqWJjr/cmwxw==
X-Gm-Gg: AfdE7ckDCiZ/7mQCc5fk7nE2Ie15ktDgWhYZSRyODyKgZMDck9NSSenSOwyvFZ/BIj5
 zgGbpjtLDSNx1NbOVA16ffUlEa/47e7pOw+Sbt9LPHD5KxLQUgC2Q/AzkHhY5cyRyynVLLtCpTT
 VWo7KdDImVLxnXtbzzyPh2Olzjd409+O7gA1RVy8heuXYq4gnLFR0a+oFzP+Ry1OPuVFFw4d0dN
 TUDlSuSC2LaT/mA/zSXJaIV5KdV5kTvPIA6ErOp6lfMz2fQtLebPMqGv+qYjdGaTMNJrWvu9bMd
 L+mhQ1cNhWuaaEfbS6LuySC2dfdZQBcFkeVgLIdwzLq7ptASfwK2Jk3ckLPhTzF7fqeVxCd/Eyt
 v5UMCPL5V9eTEeIAI761DPezcnCL5UjiyubCm/O1QLeh12iWV67Gllg==
X-Received: by 2002:a05:622a:3:b0:517:5e3e:526f with SMTP id
 d75a77b69052e-51c4c2daac9mr114273261cf.52.1783288798236; 
 Sun, 05 Jul 2026 14:59:58 -0700 (PDT)
X-Received: by 2002:a05:622a:3:b0:517:5e3e:526f with SMTP id
 d75a77b69052e-51c4c2daac9mr114273071cf.52.1783288797864; 
 Sun, 05 Jul 2026 14:59:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm18740971f8f.33.2026.07.05.14.59.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:59:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 19/32] cpu: Move BREAKPOINT definitions to
 'exec/breakpoint.h'
Date: Sun,  5 Jul 2026 23:57:15 +0200
Message-ID: <20260705215729.62196-20-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX2mLmQYL4GCq4
 Ii5c/kqyTjMtLGO8rC7ouD73ak30BkoxlTt+7hU6fAdMqP+sgjKiriWARGfilYkeh3F/dt+KVl2
 2DcZwNSCdPpD5HBMPUKIDkZ+khEPOAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX8nQTLixUo+Iq
 g4mDwc343FzEffGQ3V8uu/b+4jwJ790Kf//sW1rDaraPOT8IXMLhXsLCmRRupUQSoZ9O5QcisPP
 +BzKh6GH5aIAOlfC603XdEXYRXu3py1eIT5/CmI5Wp24lUmWSU9RHraS4AGXt6AWcVxFVbbE8Sx
 5/i+Q60y0uoq4sk00oeI7jgdV5SI5rm6XGeNvcGvw5BAfuy81PVW4YXGKqb1oUTikw24hvPFjyK
 sXnnw3WnLy5nNp6HnWcb2ZAc0iE94BJ1MjPSR+Vcomo6x6NyrjgvW/p8urVyB2j7N85QCd7nQEH
 jRXMpV9v1JAzdJ3Rcf13f6NFv+n/Fqb7hyp2OpJ73q/Dv+BN/LB3fi03Tq9vG0MTqvHACso29xL
 iW6L58TgGC9oO5pNqx91gm7v1DNf/+kljNhxJRSOMCjOdB37Ltuy9nyDky5Rs2GqlGYqPcA82ya
 jXvkZy3jzT+ZOvrnbQQ==
X-Proofpoint-GUID: cemb0za5ci7FoSHRmdHSgqFBWc6jW4u-
X-Proofpoint-ORIG-GUID: cemb0za5ci7FoSHRmdHSgqFBWc6jW4u-
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4ad3df cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=yZPQLu4l72ctXTxYlJYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 31753f331fb..e5b68bced3d 100644
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


