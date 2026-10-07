Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953C9CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEONx-0004kI-2V; Wed, 07 Oct 2026 05:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFd-0000Jw-Uo
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFc-0000qU-D6
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jlTI3686121
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nL9noJ5JaxCwh3o7FEV1rn1MVIAs7FNngi8An3Ba4d0=; b=V2IqRhCVrAZpGpji
 wMTrWBQHi9kQMdEPhHtmZxneqVtkon08ZirgWk3CxP+fhI43b1dlHXvYusOHKnqJ
 JLvVG7yznE7Aikk4OFe0lOluxju7UE8ekQ36DfcVgcjU8h0uuc7CCTLazUtiq6w/
 P/W0xDOhV3cqtdgHvnV4XAgUqCQq4T7B/X6D3GZcrpdwSH7zctL12g79Ka6nssWK
 RCtxDbmjtoGO2WrvYDvqyVwDFy2BZtjpO7z2k2P6vpMwfEj6+8q05U3Bv0n0tLH8
 g2qFXdGj5btOgO2scJ/e88IEtsaylnawTEm6vwmDfMZep/Pa5y/lf7WJ2Bd3xyAo
 maGhuw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c609hkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:47:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb98809caso541292085a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366471; x=1791971271; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nL9noJ5JaxCwh3o7FEV1rn1MVIAs7FNngi8An3Ba4d0=;
 b=KCQFtfJuxJXbEr52T2nvgJXrvQzSNupiBSTczAyhMVQK9fyifzqlwm9RcRMw84ezo5
 TT4Teid72IyWAT74w0IPYevY/+jn0s7j7aZLyhuwEcM4AlJpATwEeeDMeyaX3uWg4NI9
 TO7Uz2Jkih8J3EFU7f888u0Gbe/QPebvwhQX96arWhcWwdIkzpEJCaL5hewH8Xe9R9K1
 blkxYbZMhisWGUxGC7/a8ZRnxxGdC5H6IFW1wN9kWmIff1oeGPERZzBDB1GDirfk0eEk
 18soA3Vp8B6eyDHo8YLP596hWMvsbu4vivTbKCEx+cny41GiLNwEZySv+t3HgXQYL9Zm
 sSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366471; x=1791971271;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nL9noJ5JaxCwh3o7FEV1rn1MVIAs7FNngi8An3Ba4d0=;
 b=RDm3Q9u7F1azvGcksccMzrRUReHFzozWNTONYh42JQJlAMqmfTWNHiMYMBKH7Y0Zse
 6AAe8tK4sdUq8mS1Se9vDL8cpTBZOm85dqlN3oOCDTr1t4nHSe+RePMEQV412vBCIlch
 c3lz/vM2npccPmvnzi6qARocY1uAvbrATT9t/plbsWT3IsYq96RxmBZD8J2S1tGfFI0n
 nJDOUMTEOlGh7OAuBK6ZsizPB4yqgU9Tls+VzRWoL/lg7XHn+YoehXLYEbiPT/DdrOE+
 CetZk7cpNevFwgTKt2PoQOFAWHegMCPj5tpL7w/ELRm0lKwjprqqnRMWASacnyOtWPgV
 bM5w==
X-Gm-Message-State: AFuF++kE9vpOpnAxieCX8edGgYgI9nL8sKBLOVCnogHKx6rZ+/RTswMk
 WwvFp75MTieNhfV95eVdNlE8DOx1p9b04KkXWwq0nKlFwPRfaITCSRIqk9OmVMvtQ0Xqo2d2TQj
 5FfxUkhDUTdSHxh836Ppmuk79gvvoJMxxMHEsoe144FZZJNgwDj/1jNRAgKOpiaw+EQ/o
X-Gm-Gg: AYBFou01m2sv7SuRbvftXDS2E+YiXi4AaOLK5cVG5FP9aVPYFFWzfCJb4Iqqce8TV0c
 o/ixFQXh1xAQvIOvf3ECH+/HILRdAxmtvwrhz9xMxCWgmYdakPSEcpJ6WH3VHcjv7ej5wxVSv08
 jRLwrTKvOYq9S2Oa78H85dOxQ8xkzia109L9fBI42wsHSI4P0GF/cgia87ktKN4t8uJVMqDb0jx
 aQdgVZl61DqIQn42GU0NXR7ldBm76eEkonhz9fdp4C/R/eIvZbMvFTvW3JWVMG0lJHY87k/WEEd
 JCc1e5ClGVmQkwyfoH6xHCLaCqq1Wp+OkLvSh5ePotLkHl8cErj4zI5rdF5MhraefAlhHza7qCR
 gQEg7zQ0udNFiT3Jqkfzqz4fBaCYjmy5bGrIDWmml
X-Received: by 2002:a05:620a:890c:b0:93c:5f3c:f485 with SMTP id
 af79cd13be357-93e9b835522mr288664985a.53.1791366470400; 
 Wed, 07 Oct 2026 02:47:50 -0700 (PDT)
X-Received: by 2002:a05:620a:890c:b0:93c:5f3c:f485 with SMTP id
 af79cd13be357-93e9b835522mr288660985a.53.1791366469780; 
 Wed, 07 Oct 2026 02:47:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f54a650sm53888675e9.4.2026.10.07.02.47.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:47:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH 21/27] target/s390x: Implement and register
 CPUClass::exception_name()
Date: Wed,  7 Oct 2026 11:45:09 +0200
Message-ID: <20261007094516.75732-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JfPN4mVLRr2fXreOhfmJclk8bMkPkjrr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXwH+Bb0hv1WGR
 gIP+j9gPbYkGz5y/M9hbJhOFbemzdYCMY7ds70srbjAR1xJAXK48yoVPa9jRRruw7DNUF/C0DcJ
 WMgvOGgNzSXg1xuIpQfRZjWmNCJ82as=
X-Authority-Analysis: v=2.4 cv=PM+aavqC c=1 sm=1 tr=0 ts=6ac61547 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=lKt1HvW_8kBegW_OfZ4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: JfPN4mVLRr2fXreOhfmJclk8bMkPkjrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXzscgzLNeY94E
 vimrS1zwM0FVqkOiZx4ScnO1iSXRa9Jy0gZHDBbmoYlbOuUIAw8YRU+734R49NRT8h877yzIrqQ
 Z3whCDA7Fm3EBfjyou/q9D6aip+nI0E4Odrqgt1iZzyY3IfFmMMasgdlJlJZk2pmRbolNeRoCnv
 BinJ+b8F03Jp1bxxC4Ng55dZh6BxkM58qG+LSfr3Y0ewuehQeODCGzDN4MKkJFtFFDbN5mh+xPU
 oHgfcJ5z/OoGjs5b+kC4OIGI8PMOa2H43Se18s6I/BUZysy/j8hwicrNGNCqrSU/rrl1NO4fXCX
 qZU97mFb+FTrCDdO8JSjvy4md36ulWxoYGtTTt2OAVrsRCb0OwWWrkqXeZ0DWOTalYdxxSVl5QZ
 q4kodz8K494DS1LmRWJECq3xK8uQhkJW4xkb6F4drITtaEAswBiPLXpdUFlDuLujYYGbYd1wiku
 nOJ5CxFCn04/58/pgVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070038
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

Implement s390x_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve s390x exception codes to names.

Use the new helper in s390_cpu_do_interrupt() and helper_exception().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/s390x/cpu.h             |  2 ++
 target/s390x/cpu.c             |  1 +
 target/s390x/interrupt.c       | 18 ++++++++++++++++++
 target/s390x/tcg/excp_helper.c |  6 ++++--
 target/s390x/tcg/misc_helper.c |  3 ++-
 5 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index ef73b15218e..37b6e541312 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -437,6 +437,8 @@ QEMU_BUILD_BUG_ON(FLAG_MASK_PER_IFETCH_NULLIFY !=
 #define EXCP_IO  7 /* I/O interrupt */
 #define EXCP_MCHK 8 /* machine check */
 
+const char *s390x_exception_name(int excp);
+
 #define INTERRUPT_EXT_CPU_TIMER          (1 << 3)
 #define INTERRUPT_EXT_CLOCK_COMPARATOR   (1 << 4)
 #define INTERRUPT_EXTERNAL_CALL          (1 << 5)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 85afc5dec9a..275cc6cd53b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -408,6 +408,7 @@ static void s390_cpu_class_init(ObjectClass *oc, const void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
+    cc->exception_name = s390x_exception_name;
     cc->list_cpus = s390_cpu_list;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index d7e3fd45e4b..c02f7cd2e7d 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -19,6 +19,24 @@
 #include "hw/s390x/s390_flic.h"
 #endif
 
+const char *s390x_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_EXT]      = "external interrupt",
+        [EXCP_SVC]      = "supervisor call",
+        [EXCP_PGM]      = "program interruption",
+        [EXCP_RESTART]  = "restart interrupt",
+        [EXCP_STOP]     = "stop interrupt",
+        [EXCP_IO]       = "I/O interrupt",
+        [EXCP_MCHK]     = "machine check",
+    };
+
+    if (excp < 0 || excp >= ARRAY_SIZE(excp_names) || !excp_names[excp]) {
+        return "unknown";
+    }
+    return excp_names[excp];
+}
+
 /* Ensure to exit the TB after this call! */
 void trigger_pgm_exception(CPUS390XState *env, uint32_t code)
 {
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index d952bb20cf1..83fe65e1f8c 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -508,8 +508,10 @@ void s390_cpu_do_interrupt(CPUState *cs)
     bool stopped = false;
     uint64_t last_pc = cpu->env.psw.addr;
 
-    qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
-                  __func__, cs->exception_index, env->psw.mask, env->psw.addr);
+    qemu_log_mask(CPU_LOG_INT, "%s: %d (%s) at psw=%" PRIx64 ":%" PRIx64 "\n",
+                  __func__, cs->exception_index,
+                  s390x_exception_name(cs->exception_index),
+                  env->psw.mask, env->psw.addr);
 
 try_deliver:
     /* handle machine checks */
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f1c8563af00..a01c5d894e7 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -61,7 +61,8 @@ void HELPER(exception)(CPUS390XState *env, uint32_t excp)
 {
     CPUState *cs = env_cpu(env);
 
-    HELPER_LOG("%s: exception %d\n", __func__, excp);
+    HELPER_LOG("%s: exception %d (%s)\n", __func__, excp,
+               s390x_exception_name(excp));
     cs->exception_index = excp;
     cpu_loop_exit(cs);
 }
-- 
2.55.0


