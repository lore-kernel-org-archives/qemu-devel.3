Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE0606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h1r0nYxi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LOI83ABC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI0i-0001Mn-Dr; Fri, 23 Oct 2026 12:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzp-0007ux-HI
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:20:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHzn-0002hK-9A
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:19:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5xk32109280
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jd+4pzJ7im+0aRatKtS9GZJPrz/2LMxwKX/dw0iF9dg=; b=h1r0nYxiSdUhSbJo
 +Lv3eTHrL8nyUjvKyaldzRwTFjQQOgSihOGzM5NquT6oUoTsvPIUeto2x/Ij7tjp
 kY5/9PdBuaZkTngNyoimXqNOsu+AdI5Sb7AvfDwgiud16i8ppH9KWtCF52hg4nUL
 1QmAufxOGhQ1Bj8SZ7kdGY5pan3fNLk0ss3XV3Oy44S71+Zm1UAz24aOUbsj8scD
 M0CL6srZNgcRxV7//ui/LRzcZdMqAsWhTIXiWct87z4wXky9iH60lqFvHB07nlXE
 /vWZLPnst7wjzuHNLhIMElYtXCOj+RPtBCGDVzgUxFFqtydK65pzazUnNmm0GcT5
 8oPRAg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms4gs3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:19:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb6391e89so230439685a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772391; x=1793377191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jd+4pzJ7im+0aRatKtS9GZJPrz/2LMxwKX/dw0iF9dg=;
 b=LOI83ABCgha683b38IxD+N81G/pmivcsPyS6FP9dZ2BfP34N+9mqPtTSD60Mss6y4P
 86FQBKPCkhFVZxAx22VKSY+s6ToqsNnMs+uc6FEXxpo1Fkzzv1tsWSo0/ws7BpRXYMxv
 yzAWS1t82+OwCFJOI3NNV5XM6Y8HBpUX8uiaXOeM8U/NknrMn1M6/1wL/PmO5kZY3R8Z
 olJSt856zK6wLYiKeroTRTgCeuYEMGvZz3XHRrEt7N+ENN7JaRihDIIAc3B89jkyzFLI
 u1pSeXUzDgsu/PvGIWxb12SUBwnlEMOXattbmHwscZ29FLpV+gTFc6M3hyhYHCLn4RBU
 KvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772391; x=1793377191;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jd+4pzJ7im+0aRatKtS9GZJPrz/2LMxwKX/dw0iF9dg=;
 b=TAZzBMOvlOoBYSZw/8OetIbl45WBYyYyoSNgwuBBzGUnlx+DOT7v4ZmHz70TgtqKMj
 TirY/fQr2T9rptRPoL+UuUk7p/uqSquvpUrFV3vPDFbQuiimDYsmCwsIgNVMne+V4Ia7
 FuHjLJjbWAXOSf+yp3jn+v4Nb/6DY1hFU/O1cXKSpsDjWGGLORpejclQc6HDWLMf4N+U
 Y1H0t4YnLxN0QRNebw8yeoyOgr3vq7ac5YcTPj9aufv2/yD5nHZuvJNyB3WZMnJW+ppR
 1sSAjIZUpEO+1yOxrHUBnEMnZg3CX/3D+S6hPiKmLviplHiPfq2LYPC947kAHzUsthpL
 +yzA==
X-Gm-Message-State: AFq9FYKRxWOi/IJZlK2g0eAT4zbHHyo3hjCMEYtHcgO5h3AOvj9Wwahs
 LZKs39BLtK4RejYYxBu8XVUsR3gnf+WaFxdvS3skrSPs1NhQ2UyDP870PcQVVAXFi4rycQqg8wV
 bWNs5vCfpUc8UgsiO2DUofHjxhTQoIofGilvJRrIUHPOXhsru0iDxj4/3RBaunSX+HVQw
X-Gm-Gg: AYBFou32G1JeTBQVMZKs7pI4ZPHrmdwrSNuJ0L4hWpaSlcjKFMb+hlBVQFY/WfWpt5D
 wqTPKBruOX1uxMt83GyeIRvQvZwZDssRNo6ak4e7pMqoMcGzfLmJe52zkrQEN20k9N/X0vmUJ9+
 26RZVzhZAWadjZJey+us2MEfYceUrqoP+8UQ9bU32b2l8W5WuzEESeyBYtSav4FEbk0LMe7dgL5
 VcK8giasrImxAKyIFrbw4koDYGvkdCameQsg+X+PPoLPhvnDWcLzQ+mQ+lXMXPE9nXnhtDoaq2h
 1jJP/6hEdU/Y5CLwscSjhMjcVENkXZeZmtrgB8J/vN7ztX5ZNTyo0vmx4dFDk3v9i8rqik5xgPk
 lg0FkoKS5O/3W5OHcB2DbA4fczos6MLMnBpLuRTa0
X-Received: by 2002:a05:620a:6008:b0:93e:9934:d179 with SMTP id
 af79cd13be357-93f6f8399f2mr484729585a.56.1792772390717; 
 Fri, 23 Oct 2026 09:19:50 -0700 (PDT)
X-Received: by 2002:a05:620a:6008:b0:93e:9934:d179 with SMTP id
 af79cd13be357-93f6f8399f2mr484725885a.56.1792772390203; 
 Fri, 23 Oct 2026 09:19:50 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2a9062ce5sm18440385e9.1.2026.10.23.09.19.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:19:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 52/83] target/xtensa: Implement and register
 CPUClass::exception_name()
Date: Fri, 23 Oct 2026 18:13:00 +0200
Message-ID: <20261023161332.60153-53-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX7QHScnnUzlHO
 qFvnj74TM9CIrXpT/3nZT5CYE698qRbQoJEqc2TmEAR4/2G8M5efX8Y73IPzQeZP3jisQoYFKxU
 bg8V712aQOb+aYlBoyNo8fNcZ/WjjaARhpGgkd58GzkrCEhtF+atT0v3WQWBhiAXDUPFDLtgya0
 zPvlx+M6MF9TqfWtBfN628D7c4XLsCys6At8gG3Bq6xfIyitmiZdkAztvCruZWeE/zMCvxj6hwc
 cCnsbNkSXu8wENdeIsJOq3wcTxWw/P3sQuWI6JSNbc4dmcuET/9qAMFhVofpUi1DbX+B5fgCclQ
 LtWmmWCtP7ZFnCDaLTdjI8cm9jnTU3ljyJUFbM8f0QkrmPf0+7OVJm2AfWcGZkd8Gn+zN/Rrj8R
 psruwGci5hr15GkDPWpzk6A6+urNyuWrkYKSSYFhCSl0mOl+YDHZg+N3GFMV/B+9Jv1AFYTE400
 dPQ2fznwzgKxFkHziWQ==
X-Proofpoint-GUID: _1OhWvvqtvRbJsfHSFFuQbkusR5-czET
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX8bUE9VPSAk2R
 uiSBL3DzbwZ7WL7Rt4epVQksAh3JhoorZRIzuEJkfv2UbNpw8OBzFn2udpEfZ6Z/pjGpewV0xIE
 ayVpbegSHG2agx/NhDMW4IbaRrK3Zb0=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb8928 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-R6i_BgWeFa1qxdD66wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: _1OhWvvqtvRbJsfHSFFuQbkusR5-czET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230064
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

Implement xtensa_exception_name() and register it as the
CPUClass::exception_name() handler, so the common exception
logging can resolve Xtensa exception codes to names.

Use the new helper in xtensa_cpu_do_interrupt().

With '-d int', xtensa_cpu_do_interrupt() now logs the exception
name after its number.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-34-philmd@oss.qualcomm.com>
---
 target/xtensa/cpu.h        |  2 ++
 target/xtensa/cpu.c        | 24 ++++++++++++++++++++++++
 target/xtensa/exc_helper.c |  3 ++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 49d6ad9083d..3440c27862b 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -262,6 +262,8 @@ enum {
     EXC_MAX
 };
 
+const char *xtensa_exception_name(int excp);
+
 enum {
     ILLEGAL_INSTRUCTION_CAUSE = 0,
     SYSCALL_CAUSE,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 99c8bd4b5fb..c193396928f 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "exec/cpu-defs.h"
 #include "cpu.h"
@@ -239,6 +240,28 @@ static void xtensa_cpu_disas_set_info(const CPUState *cs,
                                      : BFD_ENDIAN_LITTLE;
 }
 
+const char *xtensa_exception_name(int excp)
+{
+    static const char * const excp_names[] = {
+        [EXC_RESET0]                = "reset",
+        [EXC_RESET1]                = "reset",
+        [EXC_MEMORY_ERROR]          = "memory error",
+        [EXC_WINDOW_OVERFLOW4]      = "window overflow",
+        [EXC_WINDOW_UNDERFLOW4]     = "window underflow",
+        [EXC_WINDOW_OVERFLOW8]      = "window overflow",
+        [EXC_WINDOW_UNDERFLOW8]     = "window underflow",
+        [EXC_WINDOW_OVERFLOW12]     = "window overflow",
+        [EXC_WINDOW_UNDERFLOW12]    = "window underflow",
+        [EXC_IRQ]                   = "interrupt",
+        [EXC_KERNEL]                = "kernel",
+        [EXC_USER]                  = "user",
+        [EXC_DOUBLE]                = "double",
+        [EXC_DEBUG]                 = "debug",
+    };
+
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
+}
+
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -347,6 +370,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, const void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
+    cc->exception_name = xtensa_exception_name;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->get_pc = xtensa_cpu_get_pc;
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 7cb67d179a8..ff71e5d6462 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -236,9 +236,10 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     case EXC_USER:
     case EXC_DOUBLE:
     case EXC_DEBUG:
-        qemu_log_mask(CPU_LOG_INT, "%s(%d) "
+        qemu_log_mask(CPU_LOG_INT, "%s(%d:%s) "
                       "pc = %08x, a0 = %08x, ps = %08x, ccount = %08x\n",
                       __func__, cs->exception_index,
+                      xtensa_exception_name(cs->exception_index),
                       env->pc, env->regs[0], env->sregs[PS],
                       env->sregs[CCOUNT]);
         if (env->config->exception_vector[cs->exception_index]) {
-- 
2.55.0


