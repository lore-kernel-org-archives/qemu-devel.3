Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843CF606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LtMSw0ut;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LcnA4Id/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0kf-0005Ud-BT; Thu, 22 Oct 2026 17:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0ka-0005B3-0p
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:55:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kY-0007zU-9d
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:55:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHH7l4086707
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C4/hVRi1lXK2ofm0E80sxZt5iktv2pv7XFsU2rulRwA=; b=LtMSw0utiQVR64IW
 ZdR1XRSNNtvQld9zByII+CgM7LinPMRLwHRlw2E014yB0NR2POhgmGoYkFqpAKPS
 avZ7yeMOI9Bkd39gKoNKEPcwKYWnNYDmIdNWFQuP7p/4ATGruAfj1/euCwbj/m3t
 H5XMFxvmoJJ5OCdu4YzEBMrV6i1V1tCCn/PHQULg71D9QlZjbUVx3qzShsIotbIH
 8i7lE5VBtuWMBBJFQdzdzZQmF4wYobngBrSElgebkvLZJU4J0Vz95A0sJDGCfkMB
 9mDVC3jJWYfprI6cOL7u+tBCvydX2NVs4DimWV+Im29wrNaVnJ2AA9YsFihb2nCX
 WHl/Jg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtrptv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:55:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-536720195ebso4708221cf.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706100; x=1793310900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C4/hVRi1lXK2ofm0E80sxZt5iktv2pv7XFsU2rulRwA=;
 b=LcnA4Id/AzlTLxBczsP7RqkjriAmQx1uo9l0cqNHswjr2Ye/fQ3gnZ0WjEfK9ce6IF
 5bCz2fpEL3/DbvoCoFyEkccgXX7MI42exh26ZQDNcHOXLc5qALfimb3PX1NMalidLi8Q
 V/p8HVexZ6FiZtwNzGfmptLDipxSix2GW26kS4bBT9rBDhSazDBZ22lyFtux3WBkhDu5
 vHeLUYTHRlH2obbCQnAOJUwxZlty/3fVBeQ1iq+gSn+O9Mij6QnuxV4qxazKeHSxFdqE
 T4xs/ZmA6vjtbZL6mSvvTD7Nz/SHrV5AF7vOVh8sLeaDR7faq1JS5i3De6gppwdKaWGY
 v7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706100; x=1793310900;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C4/hVRi1lXK2ofm0E80sxZt5iktv2pv7XFsU2rulRwA=;
 b=0HGQp21QzYYuU09cmDUqs/Ws5eTE6zy9/dO/JJq5WApa7Vtqefhkl67od9CfTY8mb1
 wKASeVgTDqwmOfjvlOJ0GGSiSscTL1li7lfemrCZeHd/CzFhGy64CO6spvmwrgmhKA1/
 zQY7pIkvP3w7o7ONr+Z4r+FeSsG7z7RdLMG8SEaHSgLKDu1UR7qPH9JXQD9PZ7S2r79J
 ss9UCaD/tTzo24HZPe00LiOuWifT9UfGhxSNznDRldyxUanE/JFD1JCkqARC3gSrLv3b
 LAapedMPoCNbbFgtqPi+F6nEz9hdD60pOjz0ia5HPgiKJupcH3L52tf6Nzt2tzGrBqWO
 1eLA==
X-Gm-Message-State: AFq9FYKtPCz/JqzjjMBYfYpajfFaKENTR8o7aPj0hGjKQKQGHYFvN3sC
 +bZTIXMd+conqwvjifM32QzOoBbwU3h3OiZZPLAG3sCCnarcctfZmYNtnRJSIZylq2LRqDQMR8y
 JWnXWLThHGlPWImDaf+y6hwzs34GjyEVBjIPk+3vIe06VNexnNQo4UuagqxSYLMo8QA==
X-Gm-Gg: AYBFou0IleBAL39oFguNJyoXx4sJQZjY2QkFioKD4mCeFDG2LztMdy3FfC4FviJnLRr
 3hePKIH9BrdSTwIJbrlEy8CSZgRDv8l7NDg15aTq1iD5HjWbSFV+NAOsDwwnWnhdzYYaMcbWzkM
 bc1YLbKgxFNA3l+9hj3PgjjYkjo5gLjkFzWUG7eDCIqPn4V88FstzjKxneJaTKdZPVqRgG2pcrO
 URw66FDhazfhOXOZKLMX+Fql7In5NT8Kf06MS+w6BKS8d6U7eDxdGqr01BQNcf1k5ndNQvbM8kK
 eHDEXTz3INtOVejsBiT/EmE9RiNAB1qhSjGtFV88WdE1lmfdzznjyb6K0c6bEWBJmhz2vbph3T6
 7JkDCOxNaHoN0MRN78rLb2FTJqASzfC5W7cNIn9Lr
X-Received: by 2002:a05:620a:3707:b0:93e:5769:e307 with SMTP id
 af79cd13be357-93f6f79bc94mr163017785a.22.1792706099823; 
 Thu, 22 Oct 2026 14:54:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3707:b0:93e:5769:e307 with SMTP id
 af79cd13be357-93f6f79bc94mr163015485a.22.1792706099250; 
 Thu, 22 Oct 2026 14:54:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a210487d16sm26605625e9.15.2026.10.22.14.54.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:54:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v3 30/33] target/sh4: Use a static table in
 sh4_exception_name()
Date: Thu, 22 Oct 2026 23:51:10 +0200
Message-ID: <20261022215115.19680-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada8634 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=FjqC8H2jZU1ohCHi5yYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: D2ml3s9I1Cm6Mxja5CuwIJkphamaxktW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXzft/C0cChiyQ
 4wsFiAHUb1FPPND+wHySfDNqm5uSTyG/51rrFmLiLnPSyxTZLqEL2HbQd76tOrIObqS6wxS41fF
 +/UXCiHgACJIU5MX8Nk54tL16abjWFyzkeoyeH84WzPhlAnsiSwy744iNY8TEnZm0DoqujG3toq
 pL/9axg28Df3NNpyD1grLstjfBrNTAHFmguSW6TD1zcEXprw6ffEwJGGh6F5uroP6GkQB7r6C0+
 Hxr3p41cRvb8vDo0osH80bdZZRA6S9Oz7mzSKKccYfVK/sDwHzi9Lza0snrR78P2p75NPerMhUf
 GZ+oQPwycqTm858ErGo9mRLP5m1WcAoYhLUUaxFciGFHXBgCZ/LdqDyeDG6nbVYTlPuUl5R9qbO
 l/8SIbCdB4xMpQFiItVG/GxyRWX4Qm5wyY819g48tbjcD7qBTvexouAhME9WfDMlK10fnvYEdsw
 9B6LZs25yUxJqlQXoRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5/UKHS0SMHqV
 ym9p6zcE+CDzhUX0ZdTITGf5dJIVIRZeUpp030JsZJShwf5UFX5/yLIcuBx+muPnmd9lJ9N/zzN
 hpBq9eZodO5kf9WHqBqmcQ/y1oNjbZ0=
X-Proofpoint-ORIG-GUID: D2ml3s9I1Cm6Mxja5CuwIJkphamaxktW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
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

Replace the switch statement with a static lookup table.

With '-d int', unlisted exception codes are now logged as
"unknown" instead of "???".

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/sh4/helper.c | 66 ++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 5856bab6983..96465dd94fb 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 
 #include "cpu.h"
 #include "exec/cputlb.h"
@@ -49,54 +50,27 @@
 
 const char *sh4_exception_name(int excp)
 {
-    const char *name;
+    /* Exception codes (EXPEVT) are multiples of 0x20 */
+    static const char * const excp_names[] = {
+        [SH4_EXCP_ADDR_ERROR >> 5]               = "addr_error",
+        [SH4_EXCP_TLB_MISS >> 5]                 = "tlb_miss",
+        [SH4_EXCP_TLB_VIOLATION >> 5]            = "tlb_violation",
+        [SH4_EXCP_ILLEGAL_INSTRUCTION >> 5]      = "illegal_instruction",
+        [SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION >> 5] = "slot_illegal_instruction",
+        [SH4_EXCP_FPU_DISABLE >> 5]              = "fpu_disable",
+        [SH4_EXCP_SLOT_FPU_DISABLE >> 5]         = "slot_fpu",
+        [SH4_EXCP_DATA_WRITE >> 5]               = "data_write",
+        [SH4_EXCP_DTLB_MISS_WRITE >> 5]          = "dtlb_miss_write",
+        [SH4_EXCP_DTLB_VIOLATION_WRITE >> 5]     = "dtlb_violation_write",
+        [SH4_EXCP_FPU >> 5]                      = "fpu_exception",
+        [SH4_EXCP_INITIAL_PAGE_WRITE >> 5]       = "initial_page_write",
+        [SH4_EXCP_TRAPA >> 5]                    = "trapa",
+    };
 
-    switch (excp) {
-    case SH4_EXCP_ADDR_ERROR:
-        name = "addr_error";
-        break;
-    case SH4_EXCP_TLB_MISS:
-        name = "tlb_miss";
-        break;
-    case SH4_EXCP_TLB_VIOLATION:
-        name = "tlb_violation";
-        break;
-    case SH4_EXCP_ILLEGAL_INSTRUCTION:
-        name = "illegal_instruction";
-        break;
-    case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
-        name = "slot_illegal_instruction";
-        break;
-    case SH4_EXCP_FPU_DISABLE:
-        name = "fpu_disable";
-        break;
-    case SH4_EXCP_SLOT_FPU_DISABLE:
-        name = "slot_fpu";
-        break;
-    case SH4_EXCP_DATA_WRITE:
-        name = "data_write";
-        break;
-    case SH4_EXCP_DTLB_MISS_WRITE:
-        name = "dtlb_miss_write";
-        break;
-    case SH4_EXCP_DTLB_VIOLATION_WRITE:
-        name = "dtlb_violation_write";
-        break;
-    case SH4_EXCP_FPU:
-        name = "fpu_exception";
-        break;
-    case SH4_EXCP_INITIAL_PAGE_WRITE:
-        name = "initial_page_write";
-        break;
-    case SH4_EXCP_TRAPA:
-        name = "trapa";
-        break;
-    default:
-        name = "???";
-        break;
+    if (excp & 0x1f) {
+        return "unknown";
     }
-
-    return name;
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp >> 5) ?: "unknown";
 }
 
 #if defined(CONFIG_USER_ONLY)
-- 
2.55.0


