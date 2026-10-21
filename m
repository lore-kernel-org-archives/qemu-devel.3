Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259B607BEE4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A56libe7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BgH/CfSy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMog-0004TD-5v; Tue, 20 Oct 2026 23:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMnp-0003EQ-QL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:15:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMnn-0002fl-Q8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:15:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2EtV2299884
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cf9Hw2+gVq1VRQ9Z2X/nBW/OhfF9R6c39gpwv9fH/lo=; b=A56libe77Orql3Aw
 mwpY/ja7kudyvJtBurNMlkACiERG9wd5CksHScDNFcsbCl+Ho988SHV0/jIgiF2N
 96KgN7dmmqWgfyMDZ6lEcexOVkYmScgeatrzwriZ1GzUAYEgcrV8YW2oGpI7+d23
 NIvfcVIOUl38KjZp18eDprrS9l8wszaML849B4/xeld6VczHSccZ6yfAeR9SlyKj
 nGLZqz4J4yy6yfcM//YnE+7EsddAHcnmkDqRIb0N8IpNRY8ASz1xFCuhbQX3OlR/
 VkBUkwKKsBnEhJCAMPmf++gDmKCGUq5Uf2psmUFGEDi6+zWgNS/ih+7zOutYmoJG
 M/BS6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4spty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5363763b556so6361201cf.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552514; x=1793157314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cf9Hw2+gVq1VRQ9Z2X/nBW/OhfF9R6c39gpwv9fH/lo=;
 b=BgH/CfSyKyWuM4moK0G+l3PO6XhRu8g8mWpwTO7YiBSmMotGq7IlVFaksnlCJkgKq+
 UwMrYtJjCYd74EpqR5h42CnTOx2/oiaZ5/5FeHJezzVr2OfQNljyKZzy16fIceeAOhE8
 s8Z9LaazZF4dALFkGiNx/wHW1Vo8rXRnQztiCl7JPEJk0GxLCG1xftT9JrIoUjAFU12h
 l+xIXDeYc5dGznwECUvKsyiSjZfsI6YU27a8RpetTdWXc3U1IpA1XMnoalpuhihvtmH0
 woClIWLa2pbdgDsPcqjGL0DMK7DdaPxy5ltJf47jfGgw5SE43eYLbYHETTxXR3IS3tZT
 dIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552514; x=1793157314;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cf9Hw2+gVq1VRQ9Z2X/nBW/OhfF9R6c39gpwv9fH/lo=;
 b=q247Wvq+5mkZAoBvTN9/TeTJbUGXI11ehUWU5ZdCQT2M9yaG/Ab9OdaFhodmb5nj7+
 G3yxil4UwJlpABanhuA6G1R4R2Bgv2yUk+5bIcCamwZS8l9XaHB8mkg4M3hB3aYniigX
 6G5YOETDkR7iTNcsQy3154iRfOX/bwJrJH8uVo3pl3SfUYL4sImwbKSI7vJSO8yyVNg2
 ++TFvgM4rwCkb+GD8A4QS0xacuFlM5iTX7KwQ7VvugEB/XBWQBdKF/PyN0x5qvlcHaY0
 yzhWNI69ZNl/ttqx/3UMOBvM5rqqms3sU1JXFWIYhGJuSOWYGaExo8CG9Px4xBgtn11H
 5REA==
X-Gm-Message-State: AFq9FYIvXcNpZe3hnZsQRiD2fuqQaNwoLkFvsMVn+NEMhJKY0/Zpiu+C
 bXRcUKL0QssNkizfi2BOfZuGjXw5HO0dy31bxi4xniMJqKYTypWM5fNc11Ou4cj1Eefrqj+Yd+A
 zIpngEd28ICVPvhO7ExOTJmuAVS/Jlkgh8qaL/uwetVp0hvmciR+SZIZX3oWJKu3M7215
X-Gm-Gg: AYBFou0LEN7s0ZJf1VEWdKuDbUQCZj/0kXeoL4K9/JNDcFSkXu3Frg9slcwa2O/y/F+
 r9CUiLSnmSXQ3/+GOz3SzEsNoLzpuQ/mSzjDaFQSz2pBsyEo91cyQyaW5fI46cn0a1JEwYiMtHk
 wRm46zUQSFuaktbiBhRApIxnRL7XdkH7cv0TLbDS1uynb/zDgMTmdpFaJQKTaIB6rhrJyvphdqk
 589smpvmNtzGhZssZD11rpS6w+x17XC2tvKd19IuNwpAEvrCcm9/sxG7QJ+djzcYh2Tk48rd1gT
 gzntKQ3bqc75WiNpqJLD4ubpYCIEazVZpLzh2GnZ5IEnaZLeMiHn27PvyS3PEgDvI+dTlLruVFp
 SVQc7XYgnoOAjlM6ZeeuZ8DCqBs54cAEATfpz/DWV
X-Received: by 2002:a05:620a:6087:b0:93f:567b:6157 with SMTP id
 af79cd13be357-93f57f63035mr220286485a.46.1792552513599; 
 Tue, 20 Oct 2026 20:15:13 -0700 (PDT)
X-Received: by 2002:a05:620a:6087:b0:93f:567b:6157 with SMTP id
 af79cd13be357-93f57f63035mr220283985a.46.1792552513088; 
 Tue, 20 Oct 2026 20:15:13 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e258358c1sm2461142f8f.43.2026.10.20.20.15.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:15:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 08/33] target/hexagon: Register CPUClass::exception_name()
 handler
Date: Wed, 21 Oct 2026 05:13:41 +0200
Message-ID: <20261021031407.24862-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X7QbFO3WKeuQyHiKPBUn5nlDqlEq_tYP
X-Proofpoint-GUID: X7QbFO3WKeuQyHiKPBUn5nlDqlEq_tYP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX1tlRxTMg9HYW
 hwbHvdfavzzywWLShgYT4ihZc+Fes7+opPjpHG1UPYw4YkgiHsa/Ub80uKoWK9S578jO0p0Q7kt
 mMsnZlL8cJqG/Wrl1czVchNeM3nhICE=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad82e44 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=L0AECS4D--PbZBcdiJkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX5ped1s9Filq+
 OEqqwC+mstllNtzt2ZoSpn/BCrfCPVKEfo3g3pIaLnCDgLtLVqH8XUNHeU7qIFTz/axJgOgx6LU
 mgAijb+/f8WKzx+m5LXCRe0DTVRZv0uXa9tX0ABwtefLXyNRT6KlJkRE8DqTSI/49NP4VvxCq/T
 i6ehvKRwnHEbIxhRD44n0TeXE0XA1YL0VtDgdxSWFuCgIDkWQXG+FzW0SwHPuZH67VtsJaN5RJl
 w/9YUs4zVg+dhmijJD4NMNZBLiK1+VzJhImURftNMavuSkyTVhikU1ap9KoIYsAGGrqeWJBd/Ss
 dahzRCma1uMTeIKKtvEBsDrkk2H716R1I6hgi2pfK6KqLApvxKSCNbS76Mu7kZhnSZT4I1KgBo0
 PwqY6IqUITqEjH2f2z1tafdSDNruxMHm2nyL8mvJwhVn3eHg3+2HkxEOwmEG0e7cvKcxbEKQUlt
 vx5kmOr2A4h/14opxCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the hexagon event_name[] array via a hexagon_event_name()
helper and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve Hexagon exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu_bits.h |  2 ++
 target/hexagon/cpu.c      | 34 ++++++++++++++++++++++++++++++++++
 target/hexagon/hexswi.c   | 30 +-----------------------------
 3 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index a8fba4aa188..7d1bdfcbc71 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -61,6 +61,8 @@ enum hex_event {
     HEX_EVENT_INTF = 0x1f,
 };
 
+const char *hexagon_event_name(int event);
+
 enum hex_cause {
     HEX_CAUSE_NONE = -1,
     HEX_CAUSE_RESET = 0x000,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index f20d6de6f63..962f00bc36c 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -318,6 +318,39 @@ void hexagon_debug(CPUHexagonState *env)
     hexagon_dump(env, stdout, CPU_DUMP_FPU);
 }
 
+const char *hexagon_event_name(int event)
+{
+    static const char *event_name[] = {
+        [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
+        [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
+        [HEX_EVENT_PRECISE] = "HEX_EVENT_PRECISE",
+        [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
+        [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
+        [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
+        [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
+        [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
+        [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
+        [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
+        [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
+        [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
+        [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
+        [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
+        [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
+        [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
+        [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
+        [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
+        [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
+        [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
+        [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
+        [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
+        [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
+        [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
+        [HEX_EVENT_INTF] = "HEX_EVENT_INTF",
+    };
+
+    return ARRAY_ELEM_OR_NULL(event_name, event) ?: "unknown";
+}
+
 static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
 {
     cpu_env(cs)->gpr[HEX_REG_PC] = value;
@@ -841,6 +874,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = hexagon_cpu_class_by_name;
+    cc->exception_name = hexagon_event_name;
     cc->dump_state = hexagon_dump_state;
     cc->set_pc = hexagon_cpu_set_pc;
     cc->get_pc = hexagon_cpu_get_pc;
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index e7362b56650..19439658392 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -735,34 +735,6 @@ static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
     env->gpr[HEX_REG_PC] = evb | (exception_index << 2);
 }
 
-static const char *event_name[] = {
-    [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
-    [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
-    [HEX_EVENT_PRECISE] = "HEX_EVENT_PRECISE",
-    [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
-    [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
-    [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
-    [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
-    [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
-    [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
-    [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
-    [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
-    [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
-    [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
-    [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
-    [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
-    [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
-    [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
-    [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
-    [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
-    [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
-    [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
-    [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
-    [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
-    [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
-    [HEX_EVENT_INTF] = "HEX_EVENT_INTF"
-};
-
 void hexagon_cpu_do_interrupt(CPUState *cs)
 
 {
@@ -775,7 +747,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
     qemu_log_mask(CPU_LOG_INT,
                   "\t%s: event 0x%02x:%s, cause 0x%" PRIx32 "(%" PRIu32 ")\n",
                   __func__, (unsigned)cs->exception_index,
-                  event_name[cs->exception_index], env->cause_code,
+                  hexagon_event_name(cs->exception_index), env->cause_code,
                   env->cause_code);
 
     env->llsc_addr = ~0;
-- 
2.55.0


