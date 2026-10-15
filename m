Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16073CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT4w-0005FX-Cf; Thu, 15 Oct 2026 17:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4J-0005An-Tl
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4I-0002Rl-Bx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FKooHG3462711
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=m5gsmpoDneZ
 5vkCRFDDLsspJIW/qHFCUi9G1F3cG2zw=; b=gY0uehQNkcGdKAzY0fInb8Duffo
 i3tv95gr3UNM8bTkXukhCKx/qxaii4hy6TY5WVjjrHgyubxVWS7dMnkFnWAjD1Dl
 JqMNEtSJay7tCJu1Lm+qZazydhwFPiAwMzTQNXl4lZRD6WKsMy6S8C5mMAaLubPm
 ThTPi9ImoDFLFnHdkkYru7qrMi9hUbEw3B4N1ADP8EXjqNdETG4+BoYNvAae0WE8
 LCTvwMhyY4eUsRU/baMwB1JtuDGS5BgZgnptNbmJ7Hr1eFUwI71pptRXgE98d29r
 pAIEPtZXkrJikj5Ou8q2YnGCxThDzrROqjmXeAKoajDiXdwud0vJaGdULMw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69v4y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a6d30f66c9so572323a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099972; x=1792704772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m5gsmpoDneZ5vkCRFDDLsspJIW/qHFCUi9G1F3cG2zw=;
 b=R+U0Q8K8TN+hJwg653Adl+ZX9/LIMkjG9LI1sahCwTLuCFrSRVNbimCXKwBVRbPc+4
 rtS9RMW6Tv684rQgM8v2zHi5TfHYkteipZuei9EDfMMYg29L3BgKkztSsH+qMGla0139
 5OpKW4KvYh1oIC+naSVWT3vZfllGcdecCAD/8y5Ed/tHTVfsvmVPy3ValjymoQkfvL6J
 90vE33baP1AWDR+dF3MClk3nlqLWSRoo2Pi+ljWIk6Ey96o3zD+kWHWepTiQXNETuVD6
 4uxrmmqE9So+9sqsNiACu/4xp6pvoWei4HFFMQoN5LXo3GF8evNJySyk8UWztrtQSr3o
 JZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099972; x=1792704772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m5gsmpoDneZ5vkCRFDDLsspJIW/qHFCUi9G1F3cG2zw=;
 b=VlPPsLzhhq/Bx2ZzaOlw1eTxJrIXwqkRqQqn9bx4GDnwOrMNb0iCO3r+5vEdON34aM
 pkDUl1I9Qlz87HmTjgp9KS8VVLdB0gEKkcsUmmFDiIoU3zuT2AowLbyuIaspBa09QK84
 YWg6a8SgCm3H4NeqICBGG9dWhToXA+rY+Fjl4GfhkLTRi5u7If9sLPZ8E8OHbIEFZiK3
 TVg8mRxOz1IjRQTg/X8RasQEspH3cq5K+RXgvByH6ifX6OhSlQrfJfH+nTPOIYp8N+A1
 wMNWLU3zyJYlmm0YY2Ej8X1KlqrGqWKnX+n50DIvaq9TYJg0GULF3BMd1ecrQp/r1EO3
 k+pA==
X-Gm-Message-State: AFq9FYIM1t5MMXeFO3nwbI20c4xhpEpY++hOIPN+GOhqEk4I9hRk/KIz
 iJDeu92rKdjcKayHIBJQcWuO9LLjeCEfQgLPbH8Ft7YqQp074Jj52U7OsZVU4I7mTVzNYcg70bs
 PUk+NG7ZhtL44TubQpOtXXW3qCXcl68Fv/cHh0hDPHEHvQmBllm6SAx679NhQgA4mKg==
X-Gm-Gg: AYBFou0aLP56XBF6sjc2XntNd2Z02E4QRzJ2pcALJaZ1dGRaNkC+jzCfK8ftO60u1ok
 5INpgF6SnmA5dZahO96qw1FcKIvXKYtuBwO7iexeOTWRlSVz0etFU1q7el4J5MbcoACNP+Xbvvb
 7hrSS3cOwJHT/L2Z/raYM4JdwwPym9yHihUViG/FMcyE2RPQgdhn5662fFbXCFe9EFrFRWGZxOm
 sNAGm63aQpoIG7/ZT2LfQCQjYy3iArZpdvQMtdJRrzbxR2jXObsyt3vQwmRMBN6V2GJuYevotqu
 mvvraywNIMg0QUuD++9lFrpfUK3RD4Z8+lCMqz1MzLgQF+Sv/nw/2OVwHIGl3Q8oNQ+6xu94fT/
 xROuc1vaXIsnTde5L5LuaFI5UPCaQIcAPUORGhULJ7jvQR+7oDehVlfVUTZ6i78U=
X-Received: by 2002:a17:90b:17d1:b0:3a7:a3c8:8f4a with SMTP id
 98e67ed59e1d1-3acbb7ffa6emr768697a91.18.1792099972281; 
 Thu, 15 Oct 2026 14:32:52 -0700 (PDT)
X-Received: by 2002:a17:90b:17d1:b0:3a7:a3c8:8f4a with SMTP id
 98e67ed59e1d1-3acbb7ffa6emr768686a91.18.1792099971810; 
 Thu, 15 Oct 2026 14:32:51 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 09/19] dump: use get_dump_info sysemu op
Date: Thu, 15 Oct 2026 21:32:26 +0000
Message-ID: <20261015213236.157767-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SJbsq2oEv4dPEv3igZGBNZP89EpdAgZY
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad14685 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VElpqANncUZJAANGsKUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: SJbsq2oEv4dPEv3igZGBNZP89EpdAgZY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX1fp3tsLXm1Ij
 sX99n9xJfavk9QgUdIt8a/5C/0RzPkjun7n0ZkiuGaVY0xJMU8h7yNHuBmPPqntU7MezRX30h+3
 bmhz2RlaChSI2+kiSGMSG0asMsaFxepuDI8hd83ZrSpl7vep27Z2KdZuvP31ax42igY8Sce8n2G
 V4ZvqOosJrlRdEagEYmvOJ3j7xjBjvGgT4t2snPyO6GJdLlHJKosPDbiEFaJfXbMz8XfuO+AKAc
 U+HZ4oD72deg3PCPYExMDEBW0ujR1Tq/xlz3fWtDtK7iMVwAYiP1R0cysXqNRy1dZBCSSysHaGz
 fjYB0leHqqxUfsFTz7WJEEGeTnsNG6eHUKgNJK3b2b130ucSSXUsts7xcLUAuZK+BM5JFx2seEp
 UocOiU45k1fiSz9yAwoDiMlYqxV30CRJYHq90sm3swijrr5dkmVYjPz8iLZn3kdn/r+uySHtC9U
 Fcoem+xYdmX2o79OcAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX9Lyh6Qi6Bz8D
 3qAqZwaBss+o//kN3dtJp8zD1X2D9hv1Wh86b1IQCH9eWVIphNU7/3xXWqEyPyrbqIsAlg+syV4
 sBlNddw05ZOraNVyiSDg47cI1RlI1Sg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
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
index 52be7258a5d..e43e41838fa 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -32,6 +32,7 @@
 #include "migration/blocker.h"
 #include "migration/misc.h"
 #include "hw/core/cpu.h"
+#include "hw/core/sysemu-cpu-ops.h"
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
+    const SysemuCPUOps *sysemu_ops =
+        first_cpu ? CPU_GET_CLASS(first_cpu)->sysemu_ops : NULL;
+    if (!sysemu_ops || !sysemu_ops->get_dump_info ||
+        sysemu_ops->get_dump_info(first_cpu, &s->dump_info,
+                                  &s->guest_phys_blocks) < 0) {
         error_setg(errp,
                    "dumping guest memory is not supported on this target");
         goto cleanup;
-- 
2.43.0


