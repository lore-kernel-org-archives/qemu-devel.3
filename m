Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27808606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aXciUVnc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rev8sqFE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmtr-0001qI-Vt; Tue, 27 Oct 2026 15:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmsU-0001I1-EA
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmsR-0002ne-PU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:30:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHWsj2452042
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iuy5kmfyJfbVBoIPLk2UIrcSnRiKJcgu8ySMSx0JkWs=; b=aXciUVncvEygCdXS
 FtjzFNCxFMVm8w+dH47AmA6xuDTA1bSQQpTKBIhaQiwT/yz4cSV4Iseai5nU6rq3
 rBZ26VPCJlPLYecfLh5qj06jZm75PRH5NhNqG93tCbt+TrEBmAe3VIG+kC6gsKaB
 Did91rp8Xwui6GXze7YgGH4EBR+D3+J+YdzzOTROtTohVExHHKr/IJtad6kMm+dy
 Ov0Q5dza5xIR1jj52gmMmC9OzpzwWV3lVPNUULf3a8oZWSsi3KuNly3YDJHQ9DWG
 NEykRwlPDR75L1ksZRPdAzj8ESiv2WXaORpKG+VyaAlKJUc14j7rGGMx34w4NAY4
 FWX3tA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy6g0v86-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:30:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2005ce21so20983385a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129429; x=1793734229; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iuy5kmfyJfbVBoIPLk2UIrcSnRiKJcgu8ySMSx0JkWs=;
 b=Rev8sqFEQabv1TlK6B9GDM+dd+La7JB3VM498qF6q6L2PXaLkL2X+rrE9rOg0peWr6
 roacsmlRpR66ABqvxO6JVGieRhFs1G/+owwsoUMvWPJLjeUEdU0wcsooKCGOI1554hzI
 TVtgOddkBIaYcsoYMkhYkBilSIBkwX8XZPtbQANuBYK9jts0yeiXW+HB/NjTOzIWt9Ft
 TyT2xv+QSLFQye4VTkwyGr9RDFm3p+jXBWySM0N8RXq4HqNSTOOx5FV/C67Xa5LaCU9x
 pK4MOHOEckc2aS372kE5ehrqqd/xM8dGnZRw7i1XZO8wy0Ogrmr9yYEKiFqfyHjFaRDk
 5STA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129429; x=1793734229;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iuy5kmfyJfbVBoIPLk2UIrcSnRiKJcgu8ySMSx0JkWs=;
 b=cBVgl9SpiBDTw+LmvOcpyTGGkmFetjRwIyciwUPLB8Ggf9sbrlkQzxUOAPjRckjz8M
 pVphO7hxoH3YIrbNNtmEPOxMoM/MnoFDsh85jAPpBxj/5i3p15FCXpJA24v51jki9MOl
 JP+BZhlaY0al+M7D0T90OmRHM57n5Ub2VDb2OSMdXmRw1HGN29x7YGAIPaZ4PQFHonap
 ayee25RCMVQ2G5jTEsu2O2beMuw+lVQR99gh6/O+WOD95QFJxGKJGWltbqhNG2DpYibr
 h98XLyhr6TAJP9wZUbC9KoBXtRYmET+2620oNuRjK1e2ZqgDR+2+8Fyg4TOq6MWlLsZS
 o6dA==
X-Gm-Message-State: AFq9FYKvTp4PQPgdJGex/uqrVHs6RzyS4d1QBNuYlCAZuuFhdB2zlQd8
 nwVrJE22Kvzpe3NCFSMjKSHiCTAipi4ocdgRiQCkOWK1ga5N+CPbPQxDEg5WCtpPGiiZdD30FOe
 evo5COn8oUuU9g0xQurialyceWr1lrkrumrUZgjx/ay8WTLJZuCa+/ICIvSLjxuSOYw==
X-Gm-Gg: AYBFou0wC9lLrykcH/HgYhztLRTa34iIkn0qpCJDHdxjkKJn19bfzCD/zHQloTr/4a/
 xVh/TIyi+CP9a9ZJZGeE3WLtWweCk47fb4496s4I0hpnxMd1W73jM9B8hEBwK7mxP2Hy0t8lyFJ
 RJBseLeF2a/DkMHElpNqQAzN2ClXdQLOA7+KaRbTJk9is+JOSYrQJ0Pj+ZPjXOTI+o5D498PYTx
 2qP2Q8xAYtA/x1X88oi6FmnJ9W84ciVTPJ9yXZCIQ/Nqasj9UYqVP125qRrv4iYO/M7wz8yrVxO
 QPD9nR59wLsftwlwwo3e44tWBaG9QFOXUVQTvgUsSJtonyJVRXQhfL0MEVHNTxzutjNRrqNdBkO
 A9afImAmsKQ+6f7Ge3F2DMdo8CcntVesNa4YCyAdCwGAtWSa6+BLMvTVZ
X-Received: by 2002:a05:620a:2b91:b0:93e:fc4e:c48d with SMTP id
 af79cd13be357-940ef99945emr1540576285a.61.1793129429194; 
 Tue, 27 Oct 2026 12:30:29 -0700 (PDT)
X-Received: by 2002:a05:620a:2b91:b0:93e:fc4e:c48d with SMTP id
 af79cd13be357-940ef99945emr1540565385a.61.1793129428055; 
 Tue, 27 Oct 2026 12:30:28 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm24304761f8f.53.2026.10.27.12.30.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:30:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 59/59] qemu/arch-defs: increase width of QEMU_ARCH_* masks
 enums to be 64 bits
Date: Tue, 27 Oct 2026 20:23:40 +0100
Message-ID: <20261027192341.9197-60-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX9HDt3g4yfHWu
 Rsq6qtgNB4wxwvcECeF7A30WVQTj0O4DvxqF9DY0hqc/Rb6jvPLhZ5q09WpziRSkajG8I5Ilc1b
 EpYA7k9+z4+Lf+cnvUa4aTgDSSa3Kkc0zSq9D58HfoMK8pynCb6F9Q6x+lGBdXbI8xGAy5vO5Jp
 gRNxxm8D7NWB4qUhYGzkGruvrnWSWMRT0QCJTWZNc2Ct8Z/KTIrq06nESnScp0wgYDQy5aUY7YY
 i7R9m2rcjks4cTLHroeuLDzzKqRCVSV+Ibj4hrJRjFN8HHN6l2afcqnnqwkdN+cURIOI6K/oDy0
 idHFE95INZgsSBj91QRq2ALlMuMK1pbwYS6sfOnFae5IVC3rw53DFJFPTF0Qt1npnVEf14chCRG
 sxpiMrcaL1whymKoMIoU4Bd84Ldk7/bsY+QRhn1CE83j69S3fDcx8HN4m5EXRvMB/1GpDToOIFi
 lvR45zw8HO03GLyjLFQ==
X-Proofpoint-GUID: xWVLvpvQccjpaZVRFvyORsyaiiiCYtyA
X-Proofpoint-ORIG-GUID: xWVLvpvQccjpaZVRFvyORsyaiiiCYtyA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX5uXs+H07+Em+
 250ydRYwvLZRmRMOXp2V5GkNTIBEHBl70h8M3U+hBHTauxV847OuGfNrsihzrYdSaIYioG7Owhv
 XgYY22Moo0B94VhZ9wuM/rUteSY+S3s=
X-Authority-Analysis: v=2.4 cv=dKgzC+Zb c=1 sm=1 tr=0 ts=6ae0fbd6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=mgfkhx_GbAYBFjwR9pIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yonggang Luo <luoyonggang@gmail.com>

SYS_EMU_TARGET__MAX is already 29, nearing the 32-target limit.
So increase width of QEMU_ARCH_* masks enums and related types;
So that we can add needed Linux user-mode targets to EmuTarget;
And also enabled the possibility add more system-mode targets in future.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261027061504.2213-4-luoyonggang@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qemu/base-arch-defs.h  | 7 ++++---
 monitor/monitor-hmp-internal.h | 2 +-
 system/arch_init.c             | 4 ++--
 system/qdev-monitor.c          | 2 +-
 system/vl.c                    | 2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/qemu/base-arch-defs.h b/include/qemu/base-arch-defs.h
index a6478c2d3fff..f2e3bc542030 100644
--- a/include/qemu/base-arch-defs.h
+++ b/include/qemu/base-arch-defs.h
@@ -9,7 +9,7 @@
 
 #include "qapi/qapi-types-machine.h"
 
-#define QEMU_ARCH_BIT(target) (1UL << (target))
+#define QEMU_ARCH_BIT(target) (1ULL << (target))
 
 enum {
     QEMU_ARCH_ALPHA =       QEMU_ARCH_BIT(SYS_EMU_TARGET_ALPHA),
@@ -44,7 +44,8 @@ enum {
     QEMU_ARCH_ALL =         QEMU_ARCH_BIT(SYS_EMU_TARGET__MAX) - 1,
 };
 
-QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
+/* Keep target-specific masks within qemu_opt_set_number()'s int64_t range. */
+QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 63);
 
 /**
  * qemu_arch_available:
@@ -52,6 +53,6 @@ QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 32);
  *
  * Return whether the current target architecture is contained in @arch_bitmask
  */
-bool qemu_arch_available(uint32_t arch_bitmask);
+bool qemu_arch_available(uint64_t arch_bitmask);
 
 #endif
diff --git a/monitor/monitor-hmp-internal.h b/monitor/monitor-hmp-internal.h
index 4e2430551abf..b61d27170767 100644
--- a/monitor/monitor-hmp-internal.h
+++ b/monitor/monitor-hmp-internal.h
@@ -69,7 +69,7 @@ typedef struct HMPCommand {
      *     Allow to restrict the command for a particular set of
      *     target architectures.
      */
-    uint32_t arch_bitmask;
+    uint64_t arch_bitmask;
     bool coroutine;
 } HMPCommand;
 
diff --git a/system/arch_init.c b/system/arch_init.c
index 1ad2f3d6f78b..b8362b12a6d2 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -26,7 +26,7 @@
 #include "qemu/bitops.h"
 #include "qemu/target-info-qapi.h"
 
-bool qemu_arch_available(uint32_t arch_bitmask)
+bool qemu_arch_available(uint64_t arch_bitmask)
 {
-    return extract32(arch_bitmask, target_arch(), 1);
+    return extract64(arch_bitmask, target_arch(), 1);
 }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 8185822daa71..b3ca619f3c9f 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -54,7 +54,7 @@ typedef struct QDevAlias
 {
     const char *typename;
     const char *alias;
-    uint32_t arch_mask;
+    uint64_t arch_mask;
 } QDevAlias;
 
 /* default virtio transport per architecture */
diff --git a/system/vl.c b/system/vl.c
index e766402f7e19..c40c0596fde3 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -917,7 +917,7 @@ typedef struct QEMUOption {
     const char *name;
     int flags;
     int index;
-    uint32_t arch_mask;
+    uint64_t arch_mask;
 } QEMUOption;
 
 static const QEMUOption qemu_options[] = {
-- 
2.55.0


