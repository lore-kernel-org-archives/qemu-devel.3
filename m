Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCFDC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUss-0001s8-3O; Sun, 05 Jul 2026 18:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUse-00010K-Sx
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUsd-0000Wp-2D
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:00:04 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxKTI2868130
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eygAFTCQW0B87uY1lVPXWDPzg3gZxNFs2eCC7PkFP/o=; b=YPv6ISWyyUpQfl8a
 UHfdhRQYdAdyVFANjWsNZDDqRt2LO3sUI5A8ID+3UEq0Wg8/RsE9BZQbK3fNUlL7
 09hXtapHpEAt6beXKKVjhIEQ6XTaLwv8A1/aRZwGHnqCuXQ3IRjfuRbmbf2WZH6X
 2Bp+3/bIaVmPQ6FZOS8ZMe/FlttfMsDVehGgvk8gE/m/sKwJOv+StJ5Z+ocC6PGq
 Vgnt+3TdwuHf5T86yCO6y6T3wlcyOy+Fn9A/NSgGqax2Ptj+X5oRAlCbQ5WTnl5Y
 xz2vygun2bLcI3eIkwqiQE3pyQLecHTkKtR7iT/YAomPCiB4AdZY+6aIut0URXU4
 lDGwJQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4sum7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:59:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e55f0613cso183697485a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288791; x=1783893591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eygAFTCQW0B87uY1lVPXWDPzg3gZxNFs2eCC7PkFP/o=;
 b=XZEsdnbomPKWMCMp6BGX16+M4JbdLSFuPBUzJKx17TkMee/CrBAeSiFd3g6cePcnia
 zDhri3vwEhKnJm6HaLDlLTEzKV9ucAUx+Pg8LNsJEswVPXGIlWwXf1b3zytsUzI86OJQ
 SxV2jpR0B6jg2MsDNT7de6x+BsvSVmbA+OX7vQGKHdepCFJf0mGqgXKD4ua9PGBYUi4x
 mtdjtzyEQSzQZWIXKjDtMsTme5+HBgiFAsO0mXRZx8grhm6znG/WxuK3ROlOquHtm+5+
 t+AjmF2QwaWUSsEUTkaAk8B1l032gjhoWfmS/E34j/aOlATzbCrViYUFNbh56ZtqBltj
 1HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288791; x=1783893591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eygAFTCQW0B87uY1lVPXWDPzg3gZxNFs2eCC7PkFP/o=;
 b=l80Oy4lIKn5D9j0INIs1n5sXqzkODpnzchJVQbg1iAaCpkogaPpUccN0xSlH6x2kyu
 fqr7fOkDLZKgSNwG83VI1NJP45KEsLZGqfKrtkcbUhgrz8SVRdoNG5v+ICKk91Zb4McH
 tdKYmvhp2dtLDX3gqot0PGJ2e0YpkQKiYOKv7RKe9WDKmJ07Ntm/EKOoeQRnWRzJbhc3
 mX7vUUbDE8YXg79u6RWq1GIBjyTeFy8hVHPRvE6uOEYVTvMupvddUn8M36vxglXSr8z2
 8W0CfmLLi+7kkcrCa6QtAZ90Nl7zourgCYVBO9C7Xi3WrPh1PJWzBUXFC8kBMltWwvLM
 PBTw==
X-Gm-Message-State: AOJu0YyTZQ5GruU9E81jaElIKDPZu0vNsY6gghNGCN5DE7W3h3Q+AU8C
 TzwMvhivlGevtVeO3FmJ2YFXG/6SplzwzXTs1Rnvj5RNoDuXGAdtqxv8maCB1G9Dw3DkUpG3G9o
 IpkZX2T/PjRasWHw6lxtYc9dLPaxaD5O0S8YnmZT7yWw8XLFC9fMonTpoMNvrI5Av+w==
X-Gm-Gg: AfdE7cmz+LwNJ+uQIyPRlaL5KoFBwnIMRHshHezkFqkX8a5TIXrOSnITT2iXhyn05TT
 2lQD+53t8wsI/RnlTogOM21tZOy/6BuD4/Ek7OPwl3OaUDwTt6eypAutQS98ywp/JJISXDozL90
 zU8Sm8vXZfDtrOqpA8rgzxB6TwtETwFYvkcovZnNzPBURI3TjGEKmUY8JVnkzx5LfhjOSigSPRv
 EDHIwBpXsxAXRpbsYq4G+86Ou1yFXS7ghuOWzya5Dn2qVLmhEHAjQ6hBLm5Z+TqKUjtPRCXNkgg
 9joKPCqsj7XkTSj40nYJPjANJJHA3XDv3g0+ZadiuskhZrCeGc8pYGOsx6inHFUQ7Cao3Cqt4fq
 a2RWyLIkjy2Drm4rw33wnG4zpMi0KEYc3vkp84X8q3l8JJRdiKeud1g==
X-Received: by 2002:a05:620a:19a2:b0:92b:67e6:4b71 with SMTP id
 af79cd13be357-92e9a526e4dmr1129631185a.72.1783288790679; 
 Sun, 05 Jul 2026 14:59:50 -0700 (PDT)
X-Received: by 2002:a05:620a:19a2:b0:92b:67e6:4b71 with SMTP id
 af79cd13be357-92e9a526e4dmr1129628885a.72.1783288790272; 
 Sun, 05 Jul 2026 14:59:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bf7efsm323538915e9.14.2026.07.05.14.59.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:59:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 18/32] cpu: Move cpu_breakpoint_test out of line
Date: Sun,  5 Jul 2026 23:57:14 +0200
Message-ID: <20260705215729.62196-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX3ebGV0g4sfSk
 2Zv/4O326WLM+4+iLe8qk3Z72Llqjk8qtjdJ3EPWc65jeBAg59RFXf2JduBgPQTMz3YMmfA7caj
 vvkA+VA4pNwT/Zh7ft+VvBMY0glvylY=
X-Proofpoint-ORIG-GUID: 2EUr2lUc2DjJSWhnvqPkFg-uO2Cr-Xjr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX36DC299PlZW5
 EIavGCpC0NhDHFjouxs+NDoaxgb1fKf2vTNSU6vKTIA5/6HETSrdhjOXN72LYNCq2jVspFmy/pd
 wpUZD19JeTlryLJ38qhB/ujmxZbQJQbyIxbOnmOjh3xUHhBFN6j8mgTFmgml0AhgqBanAmCxZQ3
 R3Oc5Oh5hmRTvtLbTeaLSfJlZBPxpU6WE4arXwCJOJlA0B4R2ctNyNQZ7bXGPPmif/up8qqerJr
 cFB1Kn0B3jzJuaWQqOqcqiiFZz2Lf5Y4ev+fhF329x81O+MLBT1/xZ+SiTUX+oNA3cs8j1SPPga
 0PT9wPak5bzF6Hx6NvtDpHafcFRBfeOCR83gX7he6JNa+uWjbeQkX0ejBxe8sx0gFs4nKAPxTPh
 M9WmY5AOvI2MbQCvixrLtD1qpzNwZ5eDniBSvYMOETluEWFpg4omBRk8icdj47JJz16lDMXsbp8
 GwraxUuAjrYKaOCr6Mw==
X-Proofpoint-GUID: 2EUr2lUc2DjJSWhnvqPkFg-uO2Cr-Xjr
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4ad3d7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f0gnTpezwqI1Ju9rGxMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the function to cpu-common.c, with the other
breakpoint functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 16 +---------------
 cpu-common.c          | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 60a23d6f38b..31753f331fb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1157,21 +1157,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
 void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
-
-/* Return true if PC matches an installed breakpoint.  */
-static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
-{
-    CPUBreakpoint *bp;
-
-    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-            if (bp->pc == pc && (bp->flags & mask)) {
-                return true;
-            }
-        }
-    }
-    return false;
-}
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask);
 
 /**
  * cpu_get_address_space:
diff --git a/cpu-common.c b/cpu-common.c
index 988d057d844..adb76b3a786 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -388,6 +388,21 @@ void process_queued_cpu_work(CPUState *cpu)
     qemu_cond_broadcast(&qemu_work_cond);
 }
 
+/* Return true if PC matches an installed breakpoint.  */
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
+{
+    CPUBreakpoint *bp;
+
+    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+            if (bp->pc == pc && (bp->flags & mask)) {
+                return true;
+            }
+        }
+    }
+    return false;
+}
+
 /* Add a breakpoint.  */
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint)
-- 
2.53.0


