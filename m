Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7E0606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JKkL59kR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZHrkl0JY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHya-000561-9l; Fri, 23 Oct 2026 12:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHy7-0004sK-I3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHy3-0002Zi-JB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG3rt43812359
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4N3ewgGMCnNDW96xTy+HMLfbifRt5Y3bSUjDJAd8upA=; b=JKkL59kR83qIet+k
 z5bwrkTJjSBrrBPuMnYsbG4FkxTrWzVqbGjxEYUmBpGWxzU9vLoSKswruRfKKWL0
 tueD6E3dL+5ySJfLDzgrXG9Gc04nID08Ya/kUc8uBbKNs/MT+c2VZUX+3qXOXPpF
 ReanQcGPQwlKjqQ/or7iznMAVs+MTm68t7P8qDMykfyWSBp+UlEsq/NW46hMKSVl
 FVmHdtUeki7koh7b/AYwuycHAqI3a7dKar0wAxoT+VI6ypFgidBqg7aN5BGDMzIS
 Cj7xybUfQPGvm4+BPbrvOHv+vcU7Pw7RU74hrWq0vtCwzj8ySk1osbaDHxilWV4i
 3JuMbA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas881xb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so197764985a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772283; x=1793377083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4N3ewgGMCnNDW96xTy+HMLfbifRt5Y3bSUjDJAd8upA=;
 b=ZHrkl0JYFfu7RPin9gxBry6ApyUTf4DvVTiq1jUl35v8G4p2elBdeQ3n7u7yJfSVZn
 qdws0oHJLgidCKN2uvxmuRDzZgOAjaURiOEZ1V6xYSxA+/cIWLThmuKVXlTLuQoMzscU
 lm3viOzmjqcELdZsiohtToUPEi+pAEPKW7wlpXcltMZcdeFZ52BXU6eWyy+zFo6811n7
 QI4uasG4VDztRQ/XJRI8ByHTaY1Vc0imUTG4XEnvg+JBj/mQTs1TZBJNrmfmNKOtlF9x
 2+ixPGJ/kAthRzEPPWVefLSxYECfQUvEM14E+BhgFpMupVZD3XvT0QVpoa9MoylXuKD5
 Qrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772283; x=1793377083;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4N3ewgGMCnNDW96xTy+HMLfbifRt5Y3bSUjDJAd8upA=;
 b=i9I6fe3uPZXlZxW8U3wsJsVBT2coH2DluCymUml2bA8ci/gCi/djxP7sPTmuYR4smR
 rPu5MAItipwGJHN6MuLktlZ4R+/jTZLWIdr9i9OhKUjTq11IYSzTBQNROOoQFNB+iWdU
 JDEE9Ra7zJ0IuzrBi4Rfox9leu5RTItjcrKr8Gp3tWkpNvRujI9phYk0yToRgw79Uoos
 ZqKvitptotmV4kNw/gR4ZiX/blfsqlc48EocmG9CKAAi39MoC+Tp8nzb2t3o7iN96rzN
 CkQnznEB2GAFKvZZC2N9ghLWYgUR2uFArmyG7oxBw2aFE1QMeOmzBneINLzMxOy4zcq0
 yS4Q==
X-Gm-Message-State: AFq9FYIVofK4PlG+Dhiy2aFt5mTWYFEMk9P6+7Lv/8Mwjx0kMzUrGz4p
 k19P8e9dvJkVBH0efEXoLn5dFZxDfZ3V3TL4bDi1TK/bXQEvgmyx3s41fQCZGlBJ4uQWh+NE7dQ
 s5jXYHnlSpvl+9ObLzmA11MRO6rztiXHT3ahi18we3Ou4XXIDe5Wtb7e9EiFVTIihmk/a
X-Gm-Gg: AYBFou3wzWaSYGLrRKfXYHaP0+52IIqOreavKssxaQ5dC98Mm2vwGIW/+vL1OaMn+m3
 VuAoTTqWk2190KWXzPwiyQnoIjybjjhMJ+wEnqeEu3HKzkPLHXMahxxyyu1CxM99Dsama/gP+Mi
 xVw5zXH6CTCYXcjoKfkqgqtSn3Xn6wBBvSvugX0mrc08CLAF74qqBgVbAw2B/ixY9d/AumXvCqY
 iaNvCIQc98bcSP5VytaWeML5SOBrNZf2K2dNOYH/WfjFzx9L1zPmao6JLwXj8lSPswx179v+mcZ
 WItMv52LaajcpJd8YaO9935emFw+HyqX057XgAy7IaPwZdmzsA5LisZC3fxKKtsvrOItnwZ5GUT
 DCxpmxC/sYv9h3pOUUTo2J/fU2JNOhKDwV4jsAXZN
X-Received: by 2002:a05:620a:19a5:b0:93b:d7a0:d9db with SMTP id
 af79cd13be357-93f6f7de923mr501572285a.53.1792772283110; 
 Fri, 23 Oct 2026 09:18:03 -0700 (PDT)
X-Received: by 2002:a05:620a:19a5:b0:93b:d7a0:d9db with SMTP id
 af79cd13be357-93f6f7de923mr501566985a.53.1792772282512; 
 Fri, 23 Oct 2026 09:18:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b065950dsm13214345e9.12.2026.10.23.09.18.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:18:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/83] target/mips: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:45 +0200
Message-ID: <20261023161332.60153-38-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX5DxSGxos5sad
 6ZVQGfNyvV2OV8mm7zcnxnWIejR0us0NtVD0HKbgJW7SgNHoqVXvFuHh2Wrnkbe/Dzmlp5GPO4g
 zFa7dLK3NN42FkI6jGukT0HyyZ6g2/g=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adb88bb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=IWzrOf9u_v1LvXMeo9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX72Ou4CqhU8yj
 +vg2KbtsP48pvJasNsk85Vp6GhWxcACcyP9FD2Md0pWAOTnwD0Z1PPwuSUL89qGxo2BEF3nF4H/
 LWztzmLNdRb+GUGZAo0hclWmHql9i+vHjxrXBWFWmlgJoVX/mknVvl90q8646Om74LVM1vsT0mq
 dfPRJjwoX0SH+3mhQ/AAZmn/qYYz/DIBz4jLfAWBqk/woUwXkgAABV8rTGAzKZIU8XdzmmE8Tdf
 jHPWl/2PB+QO3XKyKeGe1XVTskP0VtYoqBSzzEop7tzI2SJSGaveT1cMOG46kW3cr+skMIYaI49
 nciPnDz8XvVzdb3hE/8pia5Y4L9/kKXcNtY23ImzyFs0/bFXkAvDicS31dqYsZJ5PLiQXoAugAN
 07u2HNcA/gLuQ+XMc5suwDQ3abYPU9rJB3FSuaDzQh5xGCNoYxvwoi+Hwf9WEXYoDhPFkTXDjwM
 PqpYwvsG5HBVVhgC0yA==
X-Proofpoint-GUID: QMaiImKbALmgVWQEAPuZ4Qtg3KHz-1pi
X-Proofpoint-ORIG-GUID: QMaiImKbALmgVWQEAPuZ4Qtg3KHz-1pi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
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

Register mips_exception_name() as the CPUClass::exception_name()
handler, so the common exception logging can resolve MIPS exception
codes to names. Return "unknown" for missing array entries.

With '-d int', codes without an entry in excp_names[] are now
logged as "unknown" instead of passing NULL to "%s".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-19-philmd@oss.qualcomm.com>
---
 target/mips/cpu.h              | 2 ++
 target/mips/tcg/tcg-internal.h | 2 --
 target/mips/cpu.c              | 1 +
 target/mips/tcg/exception.c    | 8 +++-----
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 5d8b78a70b8..b080c5de4de 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1349,6 +1349,8 @@ enum {
     EXCP_SEMIHOST,
 };
 
+const char *mips_exception_name(int excp);
+
 /*
  * This is an internally generated WAKE request line.
  * It is driven by the CPU itself. Raised when the MT
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 950e6afc3f2..9f230e757d6 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -27,8 +27,6 @@ void mips_restore_state_to_opc(CPUState *cs,
                                const TranslationBlock *tb,
                                const uint64_t *data);
 
-const char *mips_exception_name(int32_t exception);
-
 G_NORETURN void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
                                        int error_code, uintptr_t pc);
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c069aa1c0b7..759a4e93a0a 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -741,6 +741,7 @@ static void mips_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
+    cc->exception_name = mips_exception_name;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 2f02f9be877..823866ee600 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "internal.h"
 #include "exec/helper-proto.h"
@@ -129,12 +130,9 @@ static const char * const excp_names[] = {
     [EXCP_SEMIHOST] = "Semihosting",
 };
 
-const char *mips_exception_name(int32_t exception)
+const char *mips_exception_name(int excp)
 {
-    if (exception < 0 || exception >= ARRAY_SIZE(excp_names)) {
-        return "unknown";
-    }
-    return excp_names[exception];
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
 }
 
 void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
-- 
2.55.0


