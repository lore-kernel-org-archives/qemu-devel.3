Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616A7606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RoFOz7+7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZDGtKNWl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwz-0000zI-J1; Fri, 23 Oct 2026 12:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHwt-0000dE-U3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHws-0002Tr-A6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:16:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG35Nm3734786
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 quANPD0R8cRc6wBqj0s/GIq9GVRcVT8gyf2HEgXPPYc=; b=RoFOz7+7XF6wqNN5
 A1e+LiVbYU5sDIvjisxlOUQA+at1ymWcWTnNDKKX69Sp1YvHZZACeayWkqAOorHG
 RnN+veh9qd+XmkvOAXhDqZPYXm7QYMdUy9Dnnv2YkgqxmMnpizFPWO6mZoVaQD4n
 Y5pNBDu7zR2u59XVNFEbPkN8OsKYUjzHqqlMP4cs7y2IcgMYc6Z/NQb/W8M8m4BD
 8m1UqgceINxoixDbdIQK9Eqvcj+56H9WZogNBSFYRyxExta0r64cIxfOWEaLyzFG
 1AKKu5bzg2C86GDt+d/T6sGjHYrOrf2quKM3n/TVcKuW6hAZmmYVglcwH4fjh7W6
 zQcwCg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarug254-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:16:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf7856ffso230747985a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772213; x=1793377013; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=quANPD0R8cRc6wBqj0s/GIq9GVRcVT8gyf2HEgXPPYc=;
 b=ZDGtKNWltLKrwMmjSt3I3wZtt1+MH7tNZ/TKeoSzckyAfMiimUk+b6TiZ3WZbcwttV
 9EU1DVX5eurwupMPIgV/wd11j072DCiURrO5sJmhxaikZN6NlzzFwGKaTWXv/Fff0a49
 UBf9Nvt9pKFHK87F4o8TnNjPKv717QPnf12ONpkwzPWCxE3mTOUSNAj0tY4P+wXbT3j0
 beTCKaHeg06r2XflPY9lw/SKOZdVKeeo6pL8yd9p6hDlMhNjl8bmwtb5uKOLz9uyD5x+
 1JWiGo9a8Jq/w0lvj88tPh3jt9Yn3D+q28a+VOhymmotkoXDIJlQEcXsTXOGgM84C17R
 1kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772213; x=1793377013;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=quANPD0R8cRc6wBqj0s/GIq9GVRcVT8gyf2HEgXPPYc=;
 b=pMefrV9WuCP7hpDG3rVaBYFxBjrEpsgNib7yJNh3txLjyTNdEmVhoDd1VZ11MhRUZj
 y0sElKuYluVBYANDBURFXTU1qpG1oxtJXYWbo5+eEpUPQAFDjI5UsqLL26vAZSzqodne
 OZN9N61B2bPhgm4PZGaRmg0Eqhbetu5wVE+wTqNxWyYjJ+3BnaTyp2h/KwQ7R5sjxVhP
 asH4P/7wkQaLzg6fgmwqb1nHbsCT262wh8QRprA6QXHc3DXwweRvnQombqrlmCtZOfOe
 GG83j473DCHdeN98BDTlwa5L8NEDGXbpev6jW9fqBHTYOCH6vE6h0M5v5hwcUDJQ4RKq
 Izlg==
X-Gm-Message-State: AFq9FYIIgAG39vFEhkhgqbC1I9d5TcNOdCxmTmM5mTuDuKHION/ChoyQ
 AcQG1D0Aojt61sH4A5FTVcQqvMDvKUdtJPWUtlgOWcNr8mymphMKHq4csDOhfvb00Q3QGG8mj9N
 vQHyJe9Rqycu2i7h0kBJ08Wjcdp9cGKE/zRx9EGZeIcMTw00YrKTdIwaDLM0QZel5ubSA
X-Gm-Gg: AYBFou2XFtWd8JVlaLIgY128bYgjRShpi2xlMvsT9siOxKxYm3m8jTyI0+Ot0CCEB8b
 oUr25LEBEpme6NAqvOLeWjU+kQcHvs/VPCdPS0wgh1Y/kv/Pdknw94eEs1tjFKq+3M/XI8SK8yb
 Y3SI/66W6372LpBue9f2a5773NHe7xCHwzuNh03fxgqOziBOprTnEGsjkylbFQE8wPq35lhKTRW
 YXjZadAZtdi57ldWOdwdhQuo6+HMRy2Pec03M1oHRSiNuhvO1T6h5syzqxalMbTpKsDjY1DMbKs
 o8ET52F7o+ghjFD0S1XHUQrgA+hWHi2NIn48DzwxkBu/1B7y8ajieKRAZNWvsJI6SV3XAIx3J8L
 l0ILLXRdHr3RYDmq+/D9+oGfGExQIwhrLs90DwjWb
X-Received: by 2002:a05:620a:25cf:b0:93e:fc4e:c48b with SMTP id
 af79cd13be357-93f6f824b19mr512747385a.61.1792772212583; 
 Fri, 23 Oct 2026 09:16:52 -0700 (PDT)
X-Received: by 2002:a05:620a:25cf:b0:93e:fc4e:c48b with SMTP id
 af79cd13be357-93f6f824b19mr512737385a.61.1792772211560; 
 Fri, 23 Oct 2026 09:16:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2a92a4444sm16214895e9.5.2026.10.23.09.16.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:16:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/83] target/avr: Implement and register
 CPUClass::exception_name()
Date: Fri, 23 Oct 2026 18:12:35 +0200
Message-ID: <20261023161332.60153-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX2BU20t/6UfOn
 DiZAViu9gjXhcu4zpInkTf5cJoCB/gYSUxFe7mNyv71HWxhsD2Kd3Reh3KxUBX1LCFcwWDWBvaq
 AYVwlqdg0rOoJWUpE+kYlLsIUWVDo7A=
X-Proofpoint-GUID: Meip4afI_jjlGtvdG3-AQRPSF-fr1tPB
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adb8875 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RaXvhhO76RXaS7NGOBEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Meip4afI_jjlGtvdG3-AQRPSF-fr1tPB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX+GFSQLsMbo4O
 4odwcQ/70knIbSvoA+TtIGYyNBoMIXEqZIhl2nP5bi4J8RmckJCzCuvshNf4NjFzi+FnH5sxMzd
 m8LuFNoqWAFO1Us/FEFAObykhVlYl7wHnsOLxVq1AVJ0s7xuznHG+ZZmOli2/MowVVHecVMPnVu
 bYiuUYvRKCCy11kDsHm8+pMoWG4fTb5Ngj2962kITLnLZiLszGyVqkqVB2aJ67HdvjSLrD0AVqs
 PKIB6Pk3MnohQz7BdxlXlQtZrk+HMRcGVFlZnm45hGm4FV4BwO4L1Q9QQs3D7d1kEgceHeTPQxT
 T1JkPTJOJdyuOjMTZkobjgJH8dLhL61fBbdRBLF2ehk9ZzB1mSdi+EpNiu3+mwnwqruGoAv0m7N
 w7cb6lanPKi2lZTcc4zvUlEpJm64rsBm16OBWiUxCDrGsXksn8c2A9T+WwN8C0IX+GmrUB2irci
 502kNhCHM4AXXEvHk7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
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
Message-ID: <20261022215115.19680-9-philmd@oss.qualcomm.com>
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
index a01e6fa4751..244871e5e63 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "exec/translation-block.h"
@@ -257,6 +258,21 @@ static const TCGCPUOps avr_tcg_ops = {
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
@@ -272,6 +288,7 @@ static void avr_cpu_class_init(ObjectClass *oc, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = avr_cpu_class_by_name;
+    cc->exception_name = avr_exception_name;
 
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
-- 
2.55.0


