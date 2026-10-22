Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F460A2625
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MuHo615Y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xl0muv20
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0iC-0006TZ-CC; Thu, 22 Oct 2026 17:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hv-0005et-UG
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hu-0007WZ-D1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:52:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtOO0861296
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PnDaPK/4ShlOr8hWA57YjTr2Wsk2EE7NRCFq6Krj6Lk=; b=MuHo615YViJi/0Gy
 upivd9lwExNQtLym5NcOD4vUqaeowEshedujyalBxPtbYgdjDYKKAG/zCk4QyKt2
 MZUL5T+iEVehw1RsuAZ30ODWbPUYc9p0ehPrKRumpY/fyzUEelQ0gC6zP41idYvJ
 3MXffTq10DkBbpq5qYdRi4TX/NyLjcjwAeAEMiBpsdgvVpb2N9yVP+Fo11zXUWrc
 Q9yDi+v8cf89B7o8xsr854oyDWDnD3icZH0spACII7SiUymu3FapXmAzb50JF9bi
 8oF/OpPV3PnSsKEak4Ha94J5MS/FulIFOo0EnyH/ggbnShyNTLN6QM7ZQQSzGZpi
 6d/W9g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0h9cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:52:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f33438950so54337085a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705937; x=1793310737; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PnDaPK/4ShlOr8hWA57YjTr2Wsk2EE7NRCFq6Krj6Lk=;
 b=Xl0muv209HjWdF0YzTrhAeMB8lEHqPpCUN2Jgpavd1oKo8X9HpzmXMTffrezc64KjK
 lzVYznXp6TYiYfmBu2mqNGn7xlWFZKXJRN8il1cpwg17ICo80e4OQi52/EgwKKFccfFn
 6VDiy52y8UHzJSPGrwBiiO6Hc53PUA7FgeKQv12jQ8a/9ZgrqzHmKp9F04Js/qQT0AvH
 pefHkz52SdvZbmVceQuDaqwEFdl6tPDGrtW0/EQINuArTSMTiA/I4Qt1hv3858L8R+j/
 tHjER+AL7Gu0WloYwRX7MsEFB4wL8Y81TNkpEQXHKqYohd4hcYABczXJugg/Dc2Q6VxL
 Te5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705937; x=1793310737;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PnDaPK/4ShlOr8hWA57YjTr2Wsk2EE7NRCFq6Krj6Lk=;
 b=gRkYGX6OSOga32y6IjbBXyFfNjYcZ6LMj7h2lhziAX6X5NgGCa1mISL8haQVZcHYvl
 sb8d5HqvU4+qaqSOQ67BwG2hfj+LjrtETTSpDXCrzajXSFQlDQoFDGoLsbU0EyZM4MvW
 imz/YdNFtsHhuiQGHwr+bRWTQrG1Rt0qaRq3ZWt06ORM00qO9hUDQPhVslxYs+PFPqSq
 eGBLsZ/hFW0Pl2c03i7inMJ/YwB6Y7pC6LX6EmxeAPw/c8254MFHxoBlgAk+7jjriQVW
 k9lxO7P1hGKPiDGN8KrjoVbE4B0SnBUBhXLL2FGaXvSXDAU1VU93La7v08BMcre7lFlq
 dnjQ==
X-Gm-Message-State: AFq9FYLJ3btTOjqwaIPW9Sz5KN8eiB1M0P+kr94hITC6V/tNzpSB6cP+
 Rv5/N31Y2nNJ8eFF/scJHBCdp5QAA3S4uKqHzjRxoC/F2SlWrHOVZlTO/M/XYzfmdnZWgwmTLqo
 IncJqnA+PcJ0zdm+/+XXtOuQdG1Hr7BzvpTMHHa7RhTEaKxhj2X2RG2C21YctpGiZ6Q==
X-Gm-Gg: AYBFou0GRY/DN4aMtnhNN+1KpYMmNfpK/YNERhFxRobBXuxn6wWf7L2VPxeGShXjCk4
 0/7DTeyWZa9L/QXD9eZNiqStPr6w9MXPsPIkGr1SqEcJnVwNvkAWDTFRrrv0CyJiqfl5Sd9q9oW
 hz2ykIqy9flPZc69NNE3tw+xdl4jDsMsqxHyzinmQS+3vX/wuwoN7HtYLqqVHRSiH+wpTojpu4m
 XrzqkbyzBJFyb9LChpqA3cC7/fuAoZ6f6+52IpcSLeVz21bj4YYJ7H72eJamSZBsrKwh+oNdRYC
 DHaHg952fHDcy4v8mO6b83s/aaRW1YPeGTZtRXx8HVYYW2AsQQJLKHvvaw8Ruk+MautYJPiGqrC
 pwVLYmnouk6s6KONrG4cYJ6fwp8HzMhsmePL4mbLL
X-Received: by 2002:a05:620a:454a:b0:93f:2aa8:c550 with SMTP id
 af79cd13be357-93f6f65785bmr146607085a.26.1792705936835; 
 Thu, 22 Oct 2026 14:52:16 -0700 (PDT)
X-Received: by 2002:a05:620a:454a:b0:93f:2aa8:c550 with SMTP id
 af79cd13be357-93f6f65785bmr146605285a.26.1792705936418; 
 Thu, 22 Oct 2026 14:52:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a211b29394sm11199125e9.2.2026.10.22.14.52.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:52:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v3 08/33] target/avr: Implement and register
 CPUClass::exception_name()
Date: Thu, 22 Oct 2026 23:50:48 +0200
Message-ID: <20261022215115.19680-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EPffeOXzrgEvLfO_1ar4dHZv04qO3qm8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX9/XsNZJ5oigi
 l5D780ehMhIno4g4EhikXuR3yw5UzVdVw1l+x+X0j5s+KjyG/qecJss8Pdt2tAyYAKYyXtufopj
 hiJyuFeGK9UjM5L/MaG8Tmp1670n7wkd3U0F6KoCnIowfw+AqMoDaYyeh9ohUYnXCwwiYPev2dy
 v2idZ53DziEt+w0eqE35eOeCCqsodY9M5IcFQAiS7imAucs7MOm7Y44aP99KrhUCbua3tH4pxLk
 5hYrNeTsJk32/2wo4mYPN3C12kW99Zt50s8PZW1wZ6dP6uewwAKb8Wq3KWLNZyULCWFSVUtS5NE
 NEk2ywKHNBVhzTYLWpFKP0XGxkJK8fG2Gn1Cj2WmjigTwuLx7LTL89TpNSi3V8AgxMKes6Zhawu
 SIRSFlU2A1PG1ffoLUQqfikaDRcVBWV9YEuCBqmqZFr1spWiyv5d8v2/2jHrm/dCRP/1Ar1NWdV
 TZXO7kN3dUjeT8If0+g==
X-Proofpoint-GUID: EPffeOXzrgEvLfO_1ar4dHZv04qO3qm8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXw9DsMl4UQOZn
 hcm3sNgRdqFNNaFvfUFOKw6x/Zyaqd1aaIzTAT2b6gIlPF3rIJZ2EaOCHrJWw2B7tzpDVBc8MhH
 5v0Ib2gZrdc3QmhS9b8tuO3DkfDTsyE=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada8591 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RaXvhhO76RXaS7NGOBEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

Implement avr_exception_name() and register it as
the CPUClass::exception_name() handler, so the common
exception logging can resolve AVR exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/avr/cpu.h |  2 ++
 target/avr/cpu.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 1e4e839bd83..b1b5b637617 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -44,6 +44,8 @@
 #define EXCP_RESET 1
 #define EXCP_INT(n) (EXCP_RESET + (n) + 1)
 
+const char *avr_exception_name(int excp);
+
 /* Number of CPU registers */
 #define NUMBER_OF_CPU_REGISTERS 32
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f8409f32ab9..4b1445e916c 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "exec/translation-block.h"
@@ -258,6 +259,21 @@ static const TCGCPUOps avr_tcg_ops = {
     .pointer_wrap = cpu_pointer_wrap_uint32,
 };
 
+const char *avr_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXCP_RESET]    = "RESET",
+        [EXCP_INT(0)]   = "INT#0",
+        [EXCP_INT(1)]   = "INT#1",
+        [EXCP_INT(2)]   = "INT#2",
+        [EXCP_INT(3)]   = "INT#3",
+        [EXCP_INT(4)]   = "INT#4",
+        [EXCP_INT(5)]   = "INT#5",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 static void avr_cpu_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -273,6 +289,7 @@ static void avr_cpu_class_init(ObjectClass *oc, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = avr_cpu_class_by_name;
+    cc->exception_name = avr_exception_name;
 
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
-- 
2.55.0


