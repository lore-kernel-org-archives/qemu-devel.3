Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E3606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Dtbd3dUZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fJ6Vi0qv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHyv-00065J-UL; Fri, 23 Oct 2026 12:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyV-00056y-9t
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHyT-0002ba-Jx
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:18:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG41jB3812454
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LxdMwygRiC+MDcV2vX2TTd9aXLCl/l0AA4GQ7p5ojoY=; b=Dtbd3dUZqspQiwtA
 e+D6FmdbZnW/be6FJUBy9XuYmBiYM1CjGY2Gx7L8NlzExS3na3wTtebxms6tku/X
 y4R3IFzELUBU3rIIAy0uW49l/e38pkmp8rsObZIem5wqHeczIiOTl5tkk+byZtZ1
 rhTEIOkbad9T93ATjzH0OtYj+tLE1aqyOITxWIZughGx3njMQFwNq0y48C1vCU6q
 HjkxKi10exXLwdf5hLAdy+9D0y+nZeczqU9X60lrK+nqE53k6TxnLMoUBqkqTIGN
 nbstj0aZEZ+68NjYFqi7nk9IqBzfgtrY9DqXZuUtg2fk9dfp6A78oQuEkLpsawvV
 mE98Mw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas881yt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:18:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93dd3c3badbso265819385a.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772312; x=1793377112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LxdMwygRiC+MDcV2vX2TTd9aXLCl/l0AA4GQ7p5ojoY=;
 b=fJ6Vi0qvzSOgSswGxXw/XA0BK5I9z7tA3HaK+yMPlnJpWNO0+6k/Gcden37QueVTOS
 nVSJlTkKOmYpCyirWEWNSRSBrHYuJVKaZS1brck/ELi7jdWJHJuWdziU6GQMssBfPOz9
 VagV9qjKEyg7pG6FxgeuNRHwAwDRyl6ZOumqAZWfz2tjk8ELmnzuYTcjh9y9r9PZgbK1
 YVup+8oPr2DbZ3tWybBE8x2rAtLOWuzxhb02VZLV6eFcDBzd7qVohvLt0h5NZQHowaNv
 hheMkAbL469Tu6RqKabQhQvuGwI5WFcOci5exzlwDzc1VB4COYj9JaEcWITIeYJ8Rbne
 EfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772312; x=1793377112;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LxdMwygRiC+MDcV2vX2TTd9aXLCl/l0AA4GQ7p5ojoY=;
 b=S5QCwDz0x0GviDsdhFepGZB+EfADIDx89XE+RYTM/Q2+enEnz7LluvReJW6Bus3b5+
 XEpoUpU5nUli4I4E0QOCzhVFPie1atlFgx7q3hdNswiR8tsfr2SloZ2aoaTrLljHn6ea
 R0/wf9YwYU/iSMuTWLZv1njQU/qvzR1FBzAg18JqkJ3eCS8Un42AXaez8DmAzxtHABSA
 CCC0Bg8DaS676/BaLGamzPC1WoyhSJD2m5CvNcra63bg5Fsjdm2t6T2Y+oS1Bnvgg2CG
 qKLdqsY8NeVuxo7QqRu6TGzML7FNs2sJC+pYzI2w6Dssz2Ypi2Yesjngth5fiHfO89TC
 2e3w==
X-Gm-Message-State: AFq9FYIVfPc+y9ME6FPqurOxBbhBc6Km92u6bc7lxJl8RsPQ1oklRamw
 cpzCS2cAwDkZFSu2P+kb3vg7yavl500huXBpcN95Q72S2nPaYQ0Cu8eKW+1/tTUZNPzn+YZWbbx
 A0PZuZT0topdHbvSgQRsPlHCqpBK9tD6XXcGdTbHyYz7N1htWkIrfdZr/qVgCeqMWACrb
X-Gm-Gg: AYBFou2Uq5WpqfU7SegRhZzyZ4CsTk1i+oHNZBQ0ZGQ221FSiJSYdL+Pds/2DPbWLCu
 E2YGj4VPOmJYhvp7Kdl34igjUOK/nvdr6DatNUw8P5LYvcobk9N8OgM0fCO+uKmvO23kOOBURtA
 Rls7QJ6WcKkpuOZgVZf+oY9eWJJWtss9z0iiY9Ndf3+9JQupyE3iEik0KYBJMcXA3uEEHRf+e6V
 XrCeE+s4S267SkgJPmLHl924gbdeXIXOlJ0R7hEy299dHiGieBDPGL6C6VkLWsJxCahy3qWkgYm
 TEPTfSuw6JBvtgKaFP5EBSa7RV4Vr3ukpQ00Ig04yUD9y7Ch7Bq892vlgUvAWFRaxK50a08wOYw
 +o/llqZ2rHIzT+wcnWg1x3eBRNIwnPn9r3qoHmWzW
X-Received: by 2002:a05:620a:4151:b0:93a:83d:1d0e with SMTP id
 af79cd13be357-93f6f7c49d7mr481239085a.38.1792772312090; 
 Fri, 23 Oct 2026 09:18:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4151:b0:93a:83d:1d0e with SMTP id
 af79cd13be357-93f6f7c49d7mr481233285a.38.1792772311487; 
 Fri, 23 Oct 2026 09:18:31 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cda986dsm15339985e9.7.2026.10.23.09.18.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:18:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/83] target/ppc: Register CPUClass::exception_name() handler
Date: Fri, 23 Oct 2026 18:12:49 +0200
Message-ID: <20261023161332.60153-42-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX0xRNiipKvv7W
 YBtZvVQ8qMdJplRJxPr3sbwVwoAO8kT7MFZG32gXDVn7y3QIrt1CU2eebLyiSmipIEyBcrFzupQ
 mBxPD03eIANkWFWThLKUd6UA0VFr6w0=
X-Authority-Analysis: v=2.4 cv=OPqyTiaB c=1 sm=1 tr=0 ts=6adb88d8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=GQJXTKmK7mRzDcunaLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX+vYTUSpRwPKx
 l2topkwWPoCgTQO86Qum3Dne68qJDw4dX9ZhocCk8fqbODdAGkuanR0CGN3wPcfDTrolAuF11dY
 dVFBF01yhZN6pA6KLl+GVWajYhP0UsKS4+9iA1kapDBBsvTGEF6e0d5oUkZiomzxiYm4hPK9X2D
 12+kzWcn+vSrjtmeVUsdeeOiUNRdRZx0hvCYvFwrlfy25cltODwB5wI/MuzF4gY0E7YtsVTTq5Z
 5jAFGt/bhMhE+E0S4JjS0mLTs0QzV3fJ2DqhSF08kCQqjYZYYdnYGx2feagqkd9PXVpChjFLNdC
 UpEl5RnvUmRRnpCJOe69MbRILjigr2THebg/oXw/vJ8z8ZW3wi0bzh4TyKFsFJzjNmZ8c0FIRDg
 pEmxddPb7zBybDQ6ZDUO/cWgGWjDfaaAWxhOYgLW5yE5ynVE+9rvASezKmO0mIjCniV4f9is4O4
 t3qspeu/xPAnkPxWWFQ==
X-Proofpoint-GUID: 9IH-nZdOCWQqYjgmuDa_c7spL676pXAI
X-Proofpoint-ORIG-GUID: 9IH-nZdOCWQqYjgmuDa_c7spL676pXAI
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

Expose powerpc_excp_name() prototype and register it
as the CPUClass::exception_name() handler, so the common
exception logging can resolve PPC exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261022215115.19680-23-philmd@oss.qualcomm.com>
---
 target/ppc/cpu.h         | 2 ++
 target/ppc/cpu_init.c    | 1 +
 target/ppc/excp_helper.c | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index fbffc9b3005..0f44096bad7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -153,6 +153,8 @@ enum {
     POWERPC_EXCP_SYSCALL_USER = 0x203, /* System call in user mode only      */
 };
 
+const char *powerpc_excp_name(int excp);
+
 /* Exceptions error codes                                                    */
 enum {
     /* Exception subtypes for POWERPC_EXCP_ALIGN                             */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 89a8b14a393..7f3036d903e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7530,6 +7530,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
+    cc->exception_name = powerpc_excp_name;
     cc->list_cpus = ppc_cpu_list;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 4892cbaeb07..76ac41e964d 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -34,9 +34,8 @@
 
 /*****************************************************************************/
 /* Exception processing */
-#ifndef CONFIG_USER_ONLY
 
-static const char *powerpc_excp_name(int excp)
+const char *powerpc_excp_name(int excp)
 {
     static const char * const excp_names[POWERPC_EXCP_NB] = {
         [POWERPC_EXCP_CRITICAL] = "CRITICAL",
@@ -108,6 +107,8 @@ static const char *powerpc_excp_name(int excp)
     return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "unknown";
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static void dump_syscall(CPUPPCState *env)
 {
     qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64
-- 
2.55.0


