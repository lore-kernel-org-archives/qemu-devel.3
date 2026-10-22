Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E7606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E8gZCWsE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xld+W+aM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0jg-0002ze-08; Thu, 22 Oct 2026 17:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0jc-0002iU-Pg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0ja-0007hW-No
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:04 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHt5O2059999
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wxLesOMFpRlSVgk30lwrvhPKo/RNaQPFPMfYQw5scrs=; b=E8gZCWsERfBBoNw5
 mKCOLClCwmETl2ijF1Fsd8D2fOqyuCaU8j1w1uNXmO2Pq1L67lMuT0WcqiEi88Mq
 CPY6wjlbCyy2JegJkGB4zXaGuPgHImMESiDIEihmcfAU0xuFAhIoG11enDUtCEXJ
 TmlYpPo1GUCdtCST8aNAodPMO09LevLZpNk8xA5SpquSwmYSnKKLSrCA5go3g1e3
 pQw6xvwtLTZYehRqZgh5Y65eRBKWjb8UQsTPTzmzJF/vrJ/a7rb0dm9YnhK2g0RM
 19bkebAcvTPzktHbmGq2M+OcCuPV4Cu0tm1nBbTBi+JKHIyfh/CCgwbzWf4K6ALZ
 0O9nMw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahs44g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2005ce21so44317785a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706041; x=1793310841; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wxLesOMFpRlSVgk30lwrvhPKo/RNaQPFPMfYQw5scrs=;
 b=Xld+W+aMAVH23zorWWuOtqCisjhPL2+ilxln9OPWIAsHmT+QMv59q66MXXulX+9JjO
 xzpOTybS8a7kD99Co59sXlWOpyi3X6tAhxgH4f5QOds6foZR2GM+j+Rgza9bmZhmB9r0
 abB//p2YPlC+yOpHa8Na/qeCwB7mXVPKBOQc5f6ybIeC6BMRYMCvLbpLnNeBC0UFwW29
 dDDboS96xSYzKOjbl1YqC/K1+afT5sNdnl0Wcw1x1TkNVkFIrh51MntbSXAG/CpDZSCq
 4JMAYtBOvaZ97jS+rS5C6WD3Zgx4s7UTeHkKACoyP1RCUAJTlnGW8URwMX3UqkhXAAy7
 I36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706041; x=1793310841;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wxLesOMFpRlSVgk30lwrvhPKo/RNaQPFPMfYQw5scrs=;
 b=tGAav2kH1A5noFSLS5OzXBceR8jOZO8zvW3HSko9uAKCtfkUbzbnxiuJ7aMrDdWWxQ
 BBRQq0NtggiiVhkhZL4gcLGOrRbkfSKParpyY7hHuiKTXra2zKz7Xd11dl9EdAISLVeP
 DKQ/lkFwCah6N2rrm5LAk7dkSvP602eRgjWB0/Di/GSpnzDoBy8Y4Kxt8LPpFHj566RI
 9sB8u6n2XNNyMZEubmEgVx//zT8nb0/9RknOm2KW6O8/Lkayo2nCE18pX8wwj63huZ5p
 OgzF23vYsIxxCCSz/rbX2f6NiGzwbzIwQRU7O1xmbxCmTxbXWIYLCPvgkkj30tl6E6m6
 B76g==
X-Gm-Message-State: AFq9FYJ5UrbbVc5nH84hYPGcZTaBPH2/g18CHIHk+pse8ibKLchlp7Jd
 /m9m53yNHyBm/Bpy/JzjG8hG1R1IYdypU6c3pl1oc6DJpBSaIzpp/YgD+bhy09/EkBUvSAm4JlP
 kSIQh3Y2OGWEDMPClTSVCxX3TunfWAGHFflVXoOyDAB9LkikS0E/cE42r2Ocw9kPtFw==
X-Gm-Gg: AYBFou17Vq/lYVUbMmcxuyecYkHPeTMZnxpOWuLH3n+g8HsiIBetWpszJHAHTexEvkl
 MQh7HQT533mWcx2gcoNhghw7LMGbfcGnY4fEtVTaSFrDSRFRfZ4YJUarI/35pq8Dq+qBZzfMUWh
 TcEwA5p48OMK8IEARX674oHQlv6m9Jl4FKE5h0Juk35U3TLbIiYasnejJ8nuGqi/l6krG+qZDtB
 BHUm7ZZHHk51Ne1w9RGeDcINZNC3eJAEW3yej8C8Hu4tj7Y+6swqNDOrM9spc6QP9j6f1G9jwtJ
 OIJMSvaUe0TOofiArkaf7RgacTz1rgYsVsAWRzqQi7xz5wmzhPHlwEt6uTVmN0xfBBS6DIvqYQv
 yOuop/keaBAZwXcS2tujosfQNx7q9J6fyFuDbSE95
X-Received: by 2002:a05:620a:31a6:b0:93e:fc4e:c48d with SMTP id
 af79cd13be357-93f6f9b869bmr135972985a.61.1792706041023; 
 Thu, 22 Oct 2026 14:54:01 -0700 (PDT)
X-Received: by 2002:a05:620a:31a6:b0:93e:fc4e:c48d with SMTP id
 af79cd13be357-93f6f9b869bmr135969685a.61.1792706040538; 
 Thu, 22 Oct 2026 14:54:00 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e37eded3fsm690860f8f.7.2026.10.22.14.53.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:53:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 22/33] target/ppc: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:51:02 +0200
Message-ID: <20261022215115.19680-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX/bai6OkOT4iv
 KXUH14NJVKlrhWqVl3DdvdP5xRuvozHPkerWJcVjn9sC+7FB3eaesAs1cPUPm98k1OU+S9r23kf
 dmkbYS5FJeUdET9Bd35bvPc0E4L/P8w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5eQfDMBYZ+I5
 XKsAHhA0Z8pKM4w7f4E/yi39gxFoyZsL3Cz78udW2PbIKIOQigd6cndaOgwrVOWvdu8Cc7c/eid
 qUNoLkRGP9u1p3i5L+85u+Ltke1CtgZjJyjsj6JmOiGgn8Yq9zQMRdaOAZE2qLWDe1o2Ae/H6uk
 PbFGgXrw/paVsl+nQcVhcfyPXji6MOe98794MTz+Ml8aQok9EZwM0gXW8Ui/LZk9awEBJsAyAka
 pmPOs1ogO3CrwoallAYShnacmJpyS8aEmXHmLao4wCg7Qzg/hyuh1UIqbGPo2wQ86BEKfkMwvep
 drZKjestfaUCfTpiA4jFBUOrRfpP1C5wKQZVjIv9XTrqUIknaDqm96B5R8gB0aN3UXRfEmxBltR
 a3TGo165CHfDSUqxiIqjO60rX/giGoDnVYjE9RsoQj2r1T+dSho06lMjqQAQ2e/Tb65D5F36r2m
 1amwEWrH5PBfFuzCbNg==
X-Proofpoint-GUID: Vg5_hyGxXjcoQAxHfKkCeDL0LNobr3kj
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6ada85f9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=GQJXTKmK7mRzDcunaLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Vg5_hyGxXjcoQAxHfKkCeDL0LNobr3kj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
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

Expose powerpc_excp_name() prototype and register it
as the CPUClass::exception_name() handler, so the common
exception logging can resolve PPC exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/cpu.h         | 2 ++
 target/ppc/cpu_init.c    | 1 +
 target/ppc/excp_helper.c | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb82..4eb7db3d727 100644
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
index b711f9c0a85..d5f9ac28020 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7529,6 +7529,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
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


