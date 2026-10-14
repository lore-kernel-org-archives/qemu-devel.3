Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839DDCC6B30
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g7-0006zf-K3; Wed, 14 Oct 2026 19:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g5-0006yv-RN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g4-0006RY-8c
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:33 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EM1UFx152725
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hIHJIzhKQzz
 +XxbGJEJ4fAADKXjaVM4j4u15jHqvEY8=; b=RPCg4ZCA/3Bnz1oYvdiQdtrHRPN
 szm9x/QBhrlEMGrBg/MQs42bsqKURfWL48RGhVDZ1zlAQf14O6uJxiHiuXzV1r1G
 cwb389GtfOwYQ9YHluHgbV2w2MMt1nT5ElFHJNWyh+HRZzeVlpF98ag3GaJYMbJ9
 jAKxTWaBtqQ57ohXFIf6SQXhp3G3aJUzQWHt/aK4PRQUfKUKC9lUKcbROUcrOoi2
 75bYvh8gdbXIxPWeMhI2LO/Xca+W4IkXJYrpDj9E07iQjT1DU+HZDcRFNmSnPBRm
 zIC+OORt6O7ufUzucssH/OjqJCDUXNWi6I8iN/jfaxeoGLTncco1OixNUoQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aek3uc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so8896833eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021589; x=1792626389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hIHJIzhKQzz+XxbGJEJ4fAADKXjaVM4j4u15jHqvEY8=;
 b=gtesFGxji7gM+8jTl/honAFFBvl745J7Gsb5FL/eCS6sXsVWlq5wII6EzDmyfxmrGD
 qYCe1AB94GIx4odQGF1Icb5qHOvrsOFrueCe8CHxcDTGei+J9sSbnReJ/338GxT0nUFX
 xkPFlZfyefiUydVxvoL4uA+AmnQMjlhc3zy6+OS8HA8Jim/SXrKvxsajrqNUMzx3mpSz
 cDkrVDvOamPj4pNuc6yVOr7mopVnXRYhHtYkQ4ZRDxTwmL00LH9AXLd/Gbu3arHz/oOq
 VbGzsafMC1pENSOfgCyy2BnXRu7U6doegaPCzgOd5EDkG5TFviCjXcBGccBPi1zQTjF2
 uU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021589; x=1792626389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hIHJIzhKQzz+XxbGJEJ4fAADKXjaVM4j4u15jHqvEY8=;
 b=pEPQC0rd+sGZzRKxgMEUehyh0obsDHL67PiBIcut3pTW63Vbh+pvXEjQ4b1+5FkGfg
 JxhZ7Ur/6nowL3T4Qrve61vBMb8fzwFJcQYe1ZIQWg2uY1p6s+wz4vEZcEyZxNpB/0cM
 024Ab5NrY4Nx3ElFRI6Ntj0qTN2DGcahzMwyEZzcXM6NMRk55mZWbuIIfGgwm4r0Gnrl
 KcJYX42EtkfOpDh8CRGyG4eDKzelJVCE0l8/nvzg217oIAmAySFkf7jYvL2wy4VbdpLG
 bF9H3QguAa5aJ3dGkR6MP3ORUWnCyC7ymZCkQlo9xubTp8wzlylNczvFEa9YeESQ1Y5A
 hKAA==
X-Gm-Message-State: AFq9FYK79A6vJ0SxwERaufWa7UmMqeRGcG5fJZEZbfT+hA4aHFVxnS1o
 BPwijU7p+OaNu4LKybFByL8O/XlaiZXU6gl7MPQzmk/Nu0kCLepkMy1ul8gYhc3/knmoFvJkha9
 IdzhHkUXdQhsMQJXbILlPRWcsh3LklEIVpwMPd3jWX81g+2wLBwk/vqdLZD7Fizg3SA==
X-Gm-Gg: AYBFou3fB1GZ53oIzU7p0Vh+TIrage4EQS6dtQHlGv+BUGjlHycmHd9a8vERXSOXR97
 fGoGFSPlie1web9bTxOy7SwBItN0/EGgAi2M2qb9srTLWD8OrvuKY36yH9B10pijZW3qSDJPkUq
 DMAnZqV6TsnE98BuBRienrk2YDkPhLm4iwznK1KwMWpdQmELNVPPENeSCQB8UnRVCx1PxgydeX2
 s8unxBDS4gSKqCUH97tIoX0B81bppghf+AK04pFsxvIB70bewKs+8xYwhCJhrDlHmasTqq3tmzr
 VQroElR3P70klcHDr5k8Kdwa8KRaMzXZTLNht1yXN/fbpaN5LzrN9SjCFjoY0Zr/P6MLN5aAqYU
 qB1KkhS9/IiSInm442wICBKooHENOpJgCfGSrvjXH1Ox3BKorGzo1Z5h86V5b
X-Received: by 2002:a05:693c:87c4:10b0:356:4b46:9393 with SMTP id
 5a478bee46e88-3564b46940amr20546115eec.24.1792021589241; 
 Wed, 14 Oct 2026 16:46:29 -0700 (PDT)
X-Received: by 2002:a05:693c:87c4:10b0:356:4b46:9393 with SMTP id
 5a478bee46e88-3564b46940amr20546085eec.24.1792021588466; 
 Wed, 14 Oct 2026 16:46:28 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 09/19] dump: use get_dump_info cpu dump op
Date: Wed, 14 Oct 2026 23:45:55 +0000
Message-ID: <20261014234605.209084-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YfBydrEJpL8EHxCubWOqZwRd3EmKaRZG
X-Proofpoint-GUID: YfBydrEJpL8EHxCubWOqZwRd3EmKaRZG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX7FdYFh40g8H7
 14E22i7U2N8yxB5Im+Yl4y1eY8k726YDgN62D27y+5EHk8/i6+0cbImDOwf6kDz+37tmjxxy//3
 p6s6CdwpeTGYalX81KGO7AbeB+B+DeE=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6ad01456 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=NYN0z9OFfclgqhKjobcA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXzdc2Tvrc0rS1
 wmRDx5BhaKSAqgfQaelNKkQWZXZIeV25S14yz2vurXnRkUpsnxzcy0UfSYQp+ngfYAkmYe4tRoG
 mpD/A2qcW5RRSuXxfDD7QYUj3nofCcHJCLbj5EQHfksKu6r/xuDyrzoVkLa/jx4c0VUncv//uq4
 8TKSPOCy2e4Nm99bqPY+s1YN0ha/btbDffSDZdFN/ReaManweO7Bl2sc44rMa/0vEFMWlRTAPl+
 5MWA7X0CBJXUaXUYeyMsw7+Y2ouPlpHNQFlt2Fl4FmTqdRADLuJ9bnj0n4v5FS86YjJikxjN6o/
 8enOQFRobDhCwRTTdY3B004lgEBQBKuoqgXRlhZzdp8LT+OcaZg1V3POWJbdwBCwUzGtF6TrGcJ
 JeKpkTlOpqNmoYMOfOMj4kaMZzJpmq/dItyFbZXRqulXWxuTz6DxRTkidxto1mZT1Y1hjizLrun
 nfv4Mf0eXBUFWO8U08Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Now that all targets implement this interface, we can replace the
cpu_get_dump_info() call with the new interface. We still pick the
first_cpu, which will have to be adapted when we introduce heterogeneous
emulation.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 52be7258a5d..a08a1eff3ea 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -32,6 +32,7 @@
 #include "migration/blocker.h"
 #include "migration/misc.h"
 #include "hw/core/cpu.h"
+#include "hw/core/dump-cpu-ops.h"
 #include "win_dump.h"
 #include "qemu/range.h"
 
@@ -1793,7 +1794,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     VMCoreInfoState *vmci = vmcoreinfo_find();
     CPUState *cpu;
     int nr_cpus;
-    int ret;
 
     s->has_format = has_format;
     s->format = format;
@@ -1852,12 +1852,16 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         goto cleanup;
     }
 
-    /* get dump info: endian, class and architecture.
-     * If the target architecture is not supported, cpu_get_dump_info() will
-     * return -1.
+    /*
+     * get dump info: endian, class and architecture.
+     * If the cpu does not support dumping this information, get_dump_info
+     * returns -1.
      */
-    ret = cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
-    if (ret < 0) {
+    const DumpCPUOps *dump_ops =
+        first_cpu ? CPU_GET_CLASS(first_cpu)->dump_ops : NULL;
+    if (!dump_ops || !dump_ops->get_dump_info ||
+        dump_ops->get_dump_info(first_cpu, &s->dump_info,
+                                &s->guest_phys_blocks) < 0) {
         error_setg(errp,
                    "dumping guest memory is not supported on this target");
         goto cleanup;
-- 
2.43.0


