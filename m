Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A4606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dqpv8BZw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W0J4yYZ8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHxn-0003Zi-2Q; Fri, 23 Oct 2026 12:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxh-0003GL-QC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHxf-0002Xj-Qd
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:17:45 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG6CZi2215814
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lg2VdeYIGJVJrhK5sQ+Y2lqv6jQurQ4Am9+SyZxywyg=; b=dqpv8BZw9aB0RM3a
 ku4trE7DJ5L0ThR4cxBrSBcSFOoG7HoYxhJF8gkhyTd9Fx406AyLeRWtfMBA1e90
 RbTpbxO1nA3Lpgo4mgoECO9PcghnD831qtklbTDk/Y9pTzwdwDF6UIZn7AEOeDTi
 hyJ7aon9wRlHt8CsDc1qBqKFNZmXOmBcqpg4Mk0EHujHroY2As8QMO8AXZTEVzxV
 I5HL4NJ6AYnABYLM1PyqpNFoyJQ5u5Wehjwl9o/d2hzttu+fbD5tuFVNmbHsn4Y+
 OkbZ7T1n9LfbxqHnScdH1UcoUer7fFenwUk+5NBZgtKgugkNPuY6GVrrBk9YCndZ
 JHvafA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgatc81eu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:17:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf7856ffso230932585a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772262; x=1793377062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lg2VdeYIGJVJrhK5sQ+Y2lqv6jQurQ4Am9+SyZxywyg=;
 b=W0J4yYZ88LObh1asPQna65HFPooNKpxSnZ1I23ud3dWGViMY1Xhd+FxcyYCQYZU9YM
 hESE0bOZavDv8Pi2wcMFeYdGC9ENpzzyeY0WaAOrkm2xozdep9NSkLJllwG6p2mUOTSp
 iLpy2QYU7lK7wX31qbW6jvEFG4JnEpkI1YbbgymZOYoJl9+ZPSQz3cX7EgTpBEaif80V
 2Tu6qI3GkdB4YlVPaoGPmYwcItKTA2K8f5Kew9qHJGkXjQoSOMfa5nNr55wqhRMUQFds
 kK9hfaAYZsmUDygDQyCRMrHmGvtisoTvFWJhQssNanknbJ6ETZ2Hc0nP5HzWmRQaOGcY
 /WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772262; x=1793377062;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lg2VdeYIGJVJrhK5sQ+Y2lqv6jQurQ4Am9+SyZxywyg=;
 b=KLg4vYLpS16q17AssvZD5pINAYRHVUTjR2OIl842J4ceQyF8fPqoPvJN2TkIMrVvcZ
 6ORl9zGQXWUFolwNV9tzpubnNaAUdopyxipq0JZMFe8SIZb/M2IDKn5wRuWmUIFzaDKO
 EHWtdvzpoJ8VM1OoXJzjYEm5mqrVVG6G7olxHADX71k9VKdL6FVX7fRkCzdyG0lBKHN5
 mJahruHmFrE5/ep4b8SzDHJ0wDSUXnwrE6u4K35bqIhZviWi+Wgrd5D2e/EFDSyg9FKM
 V4nFzA4VTFKAoz1n6FMLowfGIlecrTQbQZ1wOQ4ry4d68qvyM2oGEXt3tsmiG8L0/tAg
 r1vw==
X-Gm-Message-State: AFq9FYIqEilOV0rNTJzTxmbt2qc/d0rLspP7Von3eeqO0H77RzpDM/aX
 NpdCI4zRFPJ/y3ld0VcJMt/H3C22/q9/cxb2JGFMN8RcHS+ku2Gd2OxzuzLlfTOv+d+V7vR/e0k
 1wO3yHj7vN4gAtAcpSpqfSjtyDdyUeEQqFYGMmjL6PKFEOdfTEKuPFNrT21qp+btXp2rT
X-Gm-Gg: AYBFou1DPtk/IP4CeG9QLLLG99Nno7A3gFir5arRv0Zeq8uhdBK6bhId6r8YRVT1ahv
 74jNEEnuvn+Tg4mGyToYOuB9qz5EXuBPRlv2iqExJSYMZZ1qjtWF6K6ESrF5Z4ifi0UwQRLPUgf
 a8+qqsZHt9wBQa/MZhvn3lTSIsWe+TxIxxgPMAebX1y3NEth7aZTRPuES7LstzRDrbzQPFOdQR1
 3PXDLUz/kadddbTgTVri03d8kRFlZlwJ2nZmu71UIzX6Lqics3ongAa1aN8zRGsCRRgJBCgU6dk
 QtqV6HS80rvSc+erCjptW7cwnNQpp9sjnPTnFgGr1e03dWCQ8r3hjxoDB59xiB/BM4SwlbRluWf
 p+rQ6QMeGe/8710X1r0WPHYIiNgxX1t2eeO04rDBq
X-Received: by 2002:a05:620a:2586:b0:93c:29b3:3525 with SMTP id
 af79cd13be357-93f6f7c4fc7mr518093485a.36.1792772262013; 
 Fri, 23 Oct 2026 09:17:42 -0700 (PDT)
X-Received: by 2002:a05:620a:2586:b0:93c:29b3:3525 with SMTP id
 af79cd13be357-93f6f7c4fc7mr518088185a.36.1792772261454; 
 Fri, 23 Oct 2026 09:17:41 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d42f4c6sm697150f8f.59.2026.10.23.09.17.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:17:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/83] target/m68k: Use a static table in m68k_exception_name()
Date: Fri, 23 Oct 2026 18:12:42 +0200
Message-ID: <20261023161332.60153-35-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX/XQ5Po+1cPJn
 anlq2F3PhJBErWXHUlbsk+HmJ+vSFof1bZRnbYuVIRc9UAdTIkRIXpNX88XNCOhF0V/FiTVTUPu
 XdlzCR8CUV/8gMz3CsJjhV7x0xpN6JCXlEbX99e0/Xrk94yJmMBiDzINi8rf+qMd1zHvM31SZ08
 NCwZobPMAaysH0LkKC7r09/Ag6TzFOG46zlp8UuoYkOlW9rbU75q2919PcGBlHZaoomf7ah8q6d
 Ie8NI0BfhJexsuv8sls1LNMGvsb2OB0BmicgEje8tms/FIq7m92cLTSSaqA5OzbTvmGITSColvQ
 fKdFnJaznBjdofkv59Vly6JdMbBpGzwdzg8L2NK7jXBzzsQVeoG9GPIwT52lxOU9TysaXygESQR
 EfDCi0uddNxzQ9ij3E1tpSBfYQmZAA7sq/UZB7vjtukAlJnbXogKWOjbGXXPuxr2nbc490cSbHq
 5J3HdWQIenHk/Fo17Og==
X-Proofpoint-GUID: _nFZHvYhE8d-u_2JRGFzMcg0jHp3Y8nF
X-Authority-Analysis: v=2.4 cv=Scxi5fRu c=1 sm=1 tr=0 ts=6adb88a6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=MrkvrxfUm_GaFPyPbecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: _nFZHvYhE8d-u_2JRGFzMcg0jHp3Y8nF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX8Wljo/PGn+b6
 8iUrnexAHMqN0rHsXvTr8lzdQq6bdGCtPZDJNyWHduivU1LH3JTAKNeZp790yesjQ726jivCXhJ
 qRznQDzJPlgjAq5Ya7ZRcJ6iOm36bHQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-16-philmd@oss.qualcomm.com>
---
 target/m68k/op_helper.c | 153 ++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 99 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index c600f83ddbf..c9db8a1b39d 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
@@ -84,107 +85,61 @@ throwaway:
 
 const char *m68k_exception_name(int excp)
 {
-    switch (excp) {
-    case EXCP_ACCESS:
-        return "Access Fault";
-    case EXCP_ADDRESS:
-        return "Address Error";
-    case EXCP_ILLEGAL:
-        return "Illegal Instruction";
-    case EXCP_DIV0:
-        return "Divide by Zero";
-    case EXCP_CHK:
-        return "CHK/CHK2";
-    case EXCP_TRAPCC:
-        return "FTRAPcc, TRAPcc, TRAPV";
-    case EXCP_PRIVILEGE:
-        return "Privilege Violation";
-    case EXCP_TRACE:
-        return "Trace";
-    case EXCP_LINEA:
-        return "A-Line";
-    case EXCP_LINEF:
-        return "F-Line";
-    case EXCP_DEBEGBP: /* 68020/030 only */
-        return "Copro Protocol Violation";
-    case EXCP_FORMAT:
-        return "Format Error";
-    case EXCP_UNINITIALIZED:
-        return "Uninitialized Interrupt";
-    case EXCP_SPURIOUS:
-        return "Spurious Interrupt";
-    case EXCP_INT_LEVEL_1:
-        return "Level 1 Interrupt";
-    case EXCP_INT_LEVEL_1 + 1:
-        return "Level 2 Interrupt";
-    case EXCP_INT_LEVEL_1 + 2:
-        return "Level 3 Interrupt";
-    case EXCP_INT_LEVEL_1 + 3:
-        return "Level 4 Interrupt";
-    case EXCP_INT_LEVEL_1 + 4:
-        return "Level 5 Interrupt";
-    case EXCP_INT_LEVEL_1 + 5:
-        return "Level 6 Interrupt";
-    case EXCP_INT_LEVEL_1 + 6:
-        return "Level 7 Interrupt";
-    case EXCP_TRAP0:
-        return "TRAP #0";
-    case EXCP_TRAP0 + 1:
-        return "TRAP #1";
-    case EXCP_TRAP0 + 2:
-        return "TRAP #2";
-    case EXCP_TRAP0 + 3:
-        return "TRAP #3";
-    case EXCP_TRAP0 + 4:
-        return "TRAP #4";
-    case EXCP_TRAP0 + 5:
-        return "TRAP #5";
-    case EXCP_TRAP0 + 6:
-        return "TRAP #6";
-    case EXCP_TRAP0 + 7:
-        return "TRAP #7";
-    case EXCP_TRAP0 + 8:
-        return "TRAP #8";
-    case EXCP_TRAP0 + 9:
-        return "TRAP #9";
-    case EXCP_TRAP0 + 10:
-        return "TRAP #10";
-    case EXCP_TRAP0 + 11:
-        return "TRAP #11";
-    case EXCP_TRAP0 + 12:
-        return "TRAP #12";
-    case EXCP_TRAP0 + 13:
-        return "TRAP #13";
-    case EXCP_TRAP0 + 14:
-        return "TRAP #14";
-    case EXCP_TRAP0 + 15:
-        return "TRAP #15";
-    case EXCP_FP_BSUN:
-        return "FP Branch/Set on unordered condition";
-    case EXCP_FP_INEX:
-        return "FP Inexact Result";
-    case EXCP_FP_DZ:
-        return "FP Divide by Zero";
-    case EXCP_FP_UNFL:
-        return "FP Underflow";
-    case EXCP_FP_OPERR:
-        return "FP Operand Error";
-    case EXCP_FP_OVFL:
-        return "FP Overflow";
-    case EXCP_FP_SNAN:
-        return "FP Signaling NAN";
-    case EXCP_FP_UNIMP:
-        return "FP Unimplemented Data Type";
-    case EXCP_MMU_CONF: /* 68030/68851 only */
-        return "MMU Configuration Error";
-    case EXCP_MMU_ILLEGAL: /* 68851 only */
-        return "MMU Illegal Operation";
-    case EXCP_MMU_ACCESS: /* 68851 only */
-        return "MMU Access Level Violation";
-    case 64 ... 255:
+    static const char * const excp_names[] = {
+        [EXCP_ACCESS]           = "Access Fault",
+        [EXCP_ADDRESS]          = "Address Error",
+        [EXCP_ILLEGAL]          = "Illegal Instruction",
+        [EXCP_DIV0]             = "Divide by Zero",
+        [EXCP_CHK]              = "CHK/CHK2",
+        [EXCP_TRAPCC]           = "FTRAPcc, TRAPcc, TRAPV",
+        [EXCP_PRIVILEGE]        = "Privilege Violation",
+        [EXCP_TRACE]            = "Trace",
+        [EXCP_LINEA]            = "A-Line",
+        [EXCP_LINEF]            = "F-Line",
+        [EXCP_DEBEGBP]          = "Copro Protocol Violation", /* 68020/030 only */
+        [EXCP_FORMAT]           = "Format Error",
+        [EXCP_UNINITIALIZED]    = "Uninitialized Interrupt",
+        [EXCP_SPURIOUS]         = "Spurious Interrupt",
+        [EXCP_INT_LEVEL_1]      = "Level 1 Interrupt",
+        [EXCP_INT_LEVEL_1 + 1]  = "Level 2 Interrupt",
+        [EXCP_INT_LEVEL_1 + 2]  = "Level 3 Interrupt",
+        [EXCP_INT_LEVEL_1 + 3]  = "Level 4 Interrupt",
+        [EXCP_INT_LEVEL_1 + 4]  = "Level 5 Interrupt",
+        [EXCP_INT_LEVEL_1 + 5]  = "Level 6 Interrupt",
+        [EXCP_INT_LEVEL_1 + 6]  = "Level 7 Interrupt",
+        [EXCP_TRAP0]            = "TRAP #0",
+        [EXCP_TRAP0 + 1]        = "TRAP #1",
+        [EXCP_TRAP0 + 2]        = "TRAP #2",
+        [EXCP_TRAP0 + 3]        = "TRAP #3",
+        [EXCP_TRAP0 + 4]        = "TRAP #4",
+        [EXCP_TRAP0 + 5]        = "TRAP #5",
+        [EXCP_TRAP0 + 6]        = "TRAP #6",
+        [EXCP_TRAP0 + 7]        = "TRAP #7",
+        [EXCP_TRAP0 + 8]        = "TRAP #8",
+        [EXCP_TRAP0 + 9]        = "TRAP #9",
+        [EXCP_TRAP0 + 10]       = "TRAP #10",
+        [EXCP_TRAP0 + 11]       = "TRAP #11",
+        [EXCP_TRAP0 + 12]       = "TRAP #12",
+        [EXCP_TRAP0 + 13]       = "TRAP #13",
+        [EXCP_TRAP0 + 14]       = "TRAP #14",
+        [EXCP_TRAP0 + 15]       = "TRAP #15",
+        [EXCP_FP_BSUN]          = "FP Branch/Set on unordered condition",
+        [EXCP_FP_INEX]          = "FP Inexact Result",
+        [EXCP_FP_DZ]            = "FP Divide by Zero",
+        [EXCP_FP_UNFL]          = "FP Underflow",
+        [EXCP_FP_OPERR]         = "FP Operand Error",
+        [EXCP_FP_OVFL]          = "FP Overflow",
+        [EXCP_FP_SNAN]          = "FP Signaling NAN",
+        [EXCP_FP_UNIMP]         = "FP Unimplemented Data Type",
+        [EXCP_MMU_CONF]         = "MMU Configuration Error", /* 68030/68851 only */
+        [EXCP_MMU_ILLEGAL]      = "MMU Illegal Operation", /* 68851 only */
+        [EXCP_MMU_ACCESS]       = "MMU Access Level Violation", /* 68851 only */
+    };
+
+    if (excp >= 64 && excp <= 255) {
         return "User Defined Vector";
     }
-    return "Unassigned";
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "Unassigned";
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.55.0


