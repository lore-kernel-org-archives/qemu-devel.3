Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5859ACA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOL3-0007UO-2Y; Wed, 07 Oct 2026 05:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFs-0000MJ-PI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFr-0000rl-2X
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jnfO2711451
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l4DzCuFgWJ/VtN5tosyeHOeA/qxjj1Pnkutmq33a/qE=; b=IhFw/iiNQEFELHDc
 Yps+QbDOWJiSIaO/LdB82/WQ9lhv1lB/qGMUMkMAoz3/JU/sl7jm368mqa0pPvun
 0ycHjP4La9v+TH6jduAvPyojh65Ta8uzM0Jj/sVClJW64d8cvJLumozi+vOCw8rU
 yj8TSAlA0zRWdWMoEWF+AoXUv5MI/q2jFRwH12hm0mlzy2H1I6TDC1uEHRKTLup0
 oqyVInCt2l4aaPcoDm3HC2Er3ukqmPZGMsWlqFpaqJRYBeTWS20GO2ihQ6BoNya6
 Y8pYAkBTHz9wkQho11TPPoWOm7Xfb3unq9/WeWh28Z6sEgXWRCI7c6JW4I+PQg/P
 PdEEWQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c1s1jdm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:48:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbf2fd504so726996485a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366485; x=1791971285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l4DzCuFgWJ/VtN5tosyeHOeA/qxjj1Pnkutmq33a/qE=;
 b=WDq5o4VDlpraFSrLw+149vojAZ1c4n7nZDwRgcFP2tGy0+HfGGBa1d/sqC5hT3I4Tu
 0cyiuhkpyPtwUoFZa+DV5eIKq342A0YpG/vXprBv3b/5cNumbkEsHzFFCJ2k8EgA2ghh
 uAmSEqn6VfCcwxepIe071Z36e+/Gt3mTbhwryYHCqJabNMZDYVvPONQ+upaIbz7XmTFX
 A1r/8VTk0x66an7wUZTEwjtMYW2LqO7PBPci9Uy31eUKhmarDAB3wWRwnpPpQl9k2Qf/
 5+lqRiXIpBmZ7eqDGy98hwY5fiNBLNiQVwpzEj2T0ZFVjzqO829MEalb67+O8+rZLuVl
 DT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366485; x=1791971285;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l4DzCuFgWJ/VtN5tosyeHOeA/qxjj1Pnkutmq33a/qE=;
 b=wCnen4IxUZeLzNlyKQktsnX1vSUY2UxP4ytyLiqp9gInPadsaCd0WfN7Oesm8L9Cg9
 JE1CzO2+EuEdwtipeJF7SMpHraTP0JmX2zZJJxTLjjMyZBqwew98oeufKEulbkZwls5/
 L0i4cavnEi+du+Cxe7eP/jeJp++dJylNSkzvD5jkdI50LC3D7Fdl+juOOUzEl4a/rj2y
 doW5XmtVRy4QAnVdGDQ0KCpRyMgWiJSGLJNd/zOxSfICTay/241lmhFjgVzB/iN9fT5j
 fcklpwGdCIPLjjdntCYkwWUEUYFbmxu2Sn52JRxagcVGm0aeJJd0gTTeJ1C7u1SBY4bS
 7Nqw==
X-Gm-Message-State: AFuF++nzo2K8U90WhVEJ+3WSqKrgR+TslAvFNzq7Q0WWuuCNVGRlQo+j
 NouW5QTxWmG+J4RRoz4UpHcjJGjoY2OBBBrCAz2zmyP438zTGnI/zGSQg0lOGaxQBzDZi2+DkS7
 Z3iEsFAOKRtxEBYnmhzhH+m+9tjQU8Tl49ASbCpwF5I+q4p3rJXxY35ijY4GBuFNd+yEn
X-Gm-Gg: AYBFou1e8PnDm03nZef6pIVrNgVaRgr/hyN5wOr4sXpyYO6RSWBO++TQxWmo51pji/i
 UhZUwmMrkA399Mm5jN5jT/iWPCH/LjWyAVQ+3gUxci0yRE/ppqsQsOyjm0WnaPwsgMgIHCotm2G
 cMaYc1JRMxRLPdOWLyP7vSEvvZKGzsAcVI4FHh8sGUo2A7dnFfd1GsialvFwQKip0YFWYEgUFEJ
 ymxibCtpv3n1qlCDmRpT8eMQXQ6IW+8MA24Vb3Jf/I3ObImfeRiFnp16C5wIO5MR/yURw9boln/
 Bfr+Wto6dWd/IwCISxweUwyma+GJoK43G2xJB2ml1y20GNRqSF+a5JiS0sFpp8nuRytNnv/o7PN
 78LXaRNeSJi0wZHG3bzV0HjavYKcXwfv3RoBF1css
X-Received: by 2002:a05:620a:3196:b0:93c:7d49:7b69 with SMTP id
 af79cd13be357-93e9b84ad2amr315527785a.60.1791366484793; 
 Wed, 07 Oct 2026 02:48:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3196:b0:93c:7d49:7b69 with SMTP id
 af79cd13be357-93e9b84ad2amr315522785a.60.1791366484024; 
 Wed, 07 Oct 2026 02:48:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a181aeaea2sm27667195e9.5.2026.10.07.02.48.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:48:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 23/27] target/sh4: Register CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:45:11 +0200
Message-ID: <20261007094516.75732-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: H8Huy9TUV2Ogz-9JHX_V6pxpeYftjrgD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXyHzzsqv2pJEz
 GFwhTPw/B/s3TvtJ//R/YHatVQDpQCygzQnN84UfSGnyAzk/qZV+mgbG8DGrM2U9/wXb1Kczccq
 Tyc0C0PsLcvX6lRx0QlKesc+Az/ZuGfXDzMqYodjVxUM6D16MunNSyfelGjlaKtRCSu6ZOzAMtG
 UGp6jobRnH1TmECR/cbu32JpyiKXt9o3VFPmI68wH9/lOYxYNs1UOrO7tvsrTzsag9t1FVn5IFK
 /h07XBhaxKPl9KXqxFrFZpHJYJgLTJ6AUW6SgEse9jQI+Ufc1C/1j3DLB/ECjoA1Yg6ik8rQ2oc
 3sY3bd5gMPHtEpZN5CyIIDWzBjCXBW4bWTpUyyyNguawlgXKtOAzOF27rfuLlaYfIqsJIbkxKRb
 V0jEIULMa3JeQk1vMWwpoZzllzmn26JFAkucWYPulFVciJtNeRl+sPtepNZxNC7y+HuRTAwZib/
 u6mYFG5tlrCNjrat2uA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX9uOoaaiBpI4H
 fIZXndZAZrzDwctofYKckjcg6raiJw9hwnTjZLmRcR3kPKGFV2FRkg3TtLKXqyWqXrXcQ/9WSqY
 unWfLK/nhV/zk0L4/9gmvdfk39xGhVo=
X-Proofpoint-GUID: H8Huy9TUV2Ogz-9JHX_V6pxpeYftjrgD
X-Authority-Analysis: v=2.4 cv=NatzRGD4 c=1 sm=1 tr=0 ts=6ac61555 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Cv5PwFpAbeJYzggoBUMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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

Factor sh4_exception_name() out of superh_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve SH-4 exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sh4/helper.c | 101 +++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 47 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 0fbd613f333..66d6b612138 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -57,6 +57,58 @@ int cpu_sh4_is_cached(CPUSH4State *env, uint32_t addr)
 
 #else /* !CONFIG_USER_ONLY */
 
+static const char *sh4_exception_name(int excp)
+{
+    const char *name;
+
+    switch (excp) {
+    case SH4_EXCP_ADDR_ERROR:
+        name = "addr_error";
+        break;
+    case SH4_EXCP_TLB_MISS:
+        name = "tlb_miss";
+        break;
+    case SH4_EXCP_TLB_VIOLATION:
+        name = "tlb_violation";
+        break;
+    case SH4_EXCP_ILLEGAL_INSTRUCTION:
+        name = "illegal_instruction";
+        break;
+    case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
+        name = "slot_illegal_instruction";
+        break;
+    case SH4_EXCP_FPU_DISABLE:
+        name = "fpu_disable";
+        break;
+    case SH4_EXCP_SLOT_FPU_DISABLE:
+        name = "slot_fpu";
+        break;
+    case SH4_EXCP_DATA_WRITE:
+        name = "data_write";
+        break;
+    case SH4_EXCP_DTLB_MISS_WRITE:
+        name = "dtlb_miss_write";
+        break;
+    case SH4_EXCP_DTLB_VIOLATION_WRITE:
+        name = "dtlb_violation_write";
+        break;
+    case SH4_EXCP_FPU:
+        name = "fpu_exception";
+        break;
+    case SH4_EXCP_INITIAL_PAGE_WRITE:
+        name = "initial_page_write";
+        break;
+    case SH4_EXCP_TRAPA:
+        name = "trapa";
+        break;
+    default:
+        name = "???";
+        break;
+    }
+
+    return name;
+}
+
 void superh_cpu_do_interrupt(CPUState *cs)
 {
     CPUSH4State *env = cpu_env(cs);
@@ -95,53 +147,8 @@ void superh_cpu_do_interrupt(CPUState *cs)
     }
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        const char *expname;
-        switch (cs->exception_index) {
-        case SH4_EXCP_ADDR_ERROR:
-            expname = "addr_error";
-            break;
-        case SH4_EXCP_TLB_MISS:
-            expname = "tlb_miss";
-            break;
-        case SH4_EXCP_TLB_VIOLATION:
-            expname = "tlb_violation";
-            break;
-        case SH4_EXCP_ILLEGAL_INSTRUCTION:
-            expname = "illegal_instruction";
-            break;
-        case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
-            expname = "slot_illegal_instruction";
-            break;
-        case SH4_EXCP_FPU_DISABLE:
-            expname = "fpu_disable";
-            break;
-        case SH4_EXCP_SLOT_FPU_DISABLE:
-            expname = "slot_fpu";
-            break;
-        case SH4_EXCP_DATA_WRITE:
-            expname = "data_write";
-            break;
-        case SH4_EXCP_DTLB_MISS_WRITE:
-            expname = "dtlb_miss_write";
-            break;
-        case SH4_EXCP_DTLB_VIOLATION_WRITE:
-            expname = "dtlb_violation_write";
-            break;
-        case SH4_EXCP_FPU:
-            expname = "fpu_exception";
-            break;
-        case SH4_EXCP_INITIAL_PAGE_WRITE:
-            expname = "initial_page_write";
-            break;
-        case SH4_EXCP_TRAPA:
-            expname = "trapa";
-            break;
-        default:
-            expname = do_irq ? "interrupt" : "???";
-            break;
-        }
-        qemu_log("exception 0x%03x [%s] raised\n",
-                  irq_vector, expname);
+        qemu_log("exception 0x%03x [%s] raised\n", irq_vector,
+                 do_irq ? "interrupt" : sh4_exception_name(cs->exception_index));
         log_cpu_state(cs, 0);
     }
 
-- 
2.55.0


