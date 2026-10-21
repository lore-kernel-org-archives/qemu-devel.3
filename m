Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745C606E87D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fHkOgYMR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q08HFRoD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMq2-0006s4-BO; Tue, 20 Oct 2026 23:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMp4-0004kz-Vv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMp1-0002xj-Fc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:17:01 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2F5Se336955
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PdLK6u7tq/yz0P0iF7Doi4UM43eIYN0OLasV3GDT2vU=; b=fHkOgYMRTnjiV+5N
 +PrplU2M2RGa3jxm/6r74ILatDMZADVf+VuVgRQRglzpWgWkH4pLkWO2WSReI6Bn
 /3amvW4o6cnxxwHUSieCiG/6ZvQa67DmuLCZf2GRfRETnp45PR7GhxagpFcGU79f
 etQTbCmZdmn7m/v8XmI0LuYtimgSFfDMwOgl9wPqiqYzaSjkqt2U5msaEQB/rYjE
 GI9+4CHrMvk0EBD76eDXmnjQzAkFuxovQ2uIJiFU9iBffy8PoGZWogev6CNnmXkI
 dMI66Pedr2RHl8hwxTJEVCYArZWvNoM5KyFqQqrNHlGBiCPiQ1Ja1gPyZDy1joph
 +KdFAg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabhrh4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:16:48 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so6700296d6.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552607; x=1793157407; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PdLK6u7tq/yz0P0iF7Doi4UM43eIYN0OLasV3GDT2vU=;
 b=Q08HFRoDN/jgLJ14h3duL4FC39ODPgGI0qFBwDtuxycpCjBIbhQwz71+JzbdN3v0en
 n3Y07r55w4ZysVhkFE3zTgpmS0R1xS729hs3g8IhmbfzsF/vvzTLqG1KvkI2TWLOayTr
 /zFRjxzo4JyGEEpbyKDfjVbpE8hu7yv2zROaGVJk2SIOn+taCIfYsvVmpdyzAlRW2Uxf
 DE/RDYhFpOzQWfDp04ivcfxE2bZOljczIkTLffcf9Gx1BkilBcxqvsHBnUmme7rHNMWV
 xtCJTvM1wh+6IM3OFD5fzBWdVNE7CWA8pCHz8v658tTmvKXXt1sZQPMB4goZ+Cc1tMi4
 KC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552607; x=1793157407;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PdLK6u7tq/yz0P0iF7Doi4UM43eIYN0OLasV3GDT2vU=;
 b=2K/ivo0kGZe7nHfi3CNrXezQHkGxw11C50Wt1/aCbFBaylF7dszisTCrNVB2oVXQ9L
 6qqBvg+u3QETsllwA96SJUVQWM7wIUgGZY9bsFT8Zd2KWVxGDU/xsTUq3aeX9hg9JoEx
 IeoZmGJt6zVplEv9D+DfEU3eiJo2XKT1nNh44p1Kj4ZowXj4j5CjFtfay/LnXimANo2n
 vLdURng9GAQo0BBTtlSPlyZUmcDKUt754Wt23ST7qwjMzwAjoTygy5HdXbNMz1ioBMFz
 1DfHKU4ZY1yRRht1DgeHr2qqbGHAnOHnQBiO91aWSuJ+k1AZzws26WdClgW8ClP7K1Oa
 zUXg==
X-Gm-Message-State: AFq9FYJ0RklH7NSz8WInlzrAJ6CmhzEk7v6EILTdSuKQBw9hizP1MWTY
 0HzX4nPgQADn8J0yUnyTtZ4D9ae2sBe/fPcUjiLLgcaRekAG+p0yM0teBvBf/LPKF7Gee49+DWT
 CRxep14ZbQrxiRqpdBUE+e30yeJkV3Q8CXonO63whGNRKOqRrWKU5eu7wXbSDZpKTEU1w
X-Gm-Gg: AYBFou0lhc/DpaEn5yPYYAbJVdjDPCbF3xbE5s16J2/O4BqVkVS+cAXgbWQR5YxQ0BO
 hk5kb8R2RQp0Zkxn9yVvDcMGXWstsNwXXXiXnAFSGF54piKiLwgfMm1IlkMUvnQ92CvKL0xc06T
 Ju7pf6nIhNvhriQWgdhhCBiVg+exRvYNutIYmbLgDVNWe02+yYb6j2YFNyy5Lig7S0UbQYIInCn
 4spUIHc8cyuWFytP1w2arYO6QcqhL980QpqNJ9UIuJD4dtDOtY9fHYlJC1bc4XrICyssrjXF69d
 dt/5uW6xEvXvhSgJ8i9ltjJeyb9o/tEfYHtoKX8xdd+B9kxj6DrAc5fuWQN0dA1rP4ewgoC8v2L
 wkd3BehdJ4vULvpc+qYbiB7cQ/kCG1eBfaVhfkTDY
X-Received: by 2002:a05:620a:258b:b0:93c:8544:6ad8 with SMTP id
 af79cd13be357-93f57f70fbfmr194777285a.28.1792552607161; 
 Tue, 20 Oct 2026 20:16:47 -0700 (PDT)
X-Received: by 2002:a05:620a:258b:b0:93c:8544:6ad8 with SMTP id
 af79cd13be357-93f57f70fbfmr194774885a.28.1792552606590; 
 Tue, 20 Oct 2026 20:16:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb80f05bsm41137525e9.3.2026.10.20.20.16.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:16:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 20/33] target/ppc: Register CPUClass::exception_name()
 handler
Date: Wed, 21 Oct 2026 05:13:53 +0200
Message-ID: <20261021031407.24862-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX/av02cFxE1lt
 cUeL51t1KvUsqp0qp36cZdQvxBZ5SHXL/TCA5vQ/AeL/fHFhc/Dc/YMCABnqawWv4ykAe7D7x94
 1z5uFNPMJSYtV8k31BTkqD1XbLkv9bs=
X-Proofpoint-ORIG-GUID: ikQ2XpiFM9ZSpvhPzCYDbdq0O0OFX9aG
X-Proofpoint-GUID: ikQ2XpiFM9ZSpvhPzCYDbdq0O0OFX9aG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX9gBNGev6Fu9l
 EJgUj6VXni/OPd7xG2KyBUZDycGZnTVtH2YrCt+NwEzcQkyut9yrrcQnMBIB7JHb+K2bq7684oK
 ZuHcoIMZ+8n1Grmzpxo8jolcUrcjQTwiF5nYx/mIo+2357FKvjZzWyTlzc5AaPB+xvAEW3srKqa
 VichrflUZM0Y43bBZ5g7EC5fatqvigcCfDDwo1i+ahbnPTOoTAAVPHq/YwsetAfmyhCpSlpsLus
 SAhrbmnSDc8QFxvV70I4C9G5m5/B+fUYfWo92SVPBeUuM0o+3LsvuSPVlZWZq9dauqiJM1cT0Ru
 JNWy5yy93GKeR/Wp06+EU6qJI4ZS6yy/xsCLcNzWbvY3xD5AUnra1/tVrolyJa1udwjBW+wE2Aq
 UErHEHB1EpwOPa3i/Gjw5Sp5lPe7gEW3eMAF1yVMcbeOcMwZIlf4l3un2qVeGxNhQOgH2QsCrpb
 hxzo+F3KqpNex72ZXdg==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad82ea0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=GQJXTKmK7mRzDcunaLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
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
index 895127fb2e6..66675f1fdb4 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -33,9 +33,8 @@
 
 /*****************************************************************************/
 /* Exception processing */
-#ifndef CONFIG_USER_ONLY
 
-static const char *powerpc_excp_name(int excp)
+const char *powerpc_excp_name(int excp)
 {
     switch (excp) {
     case POWERPC_EXCP_CRITICAL: return "CRITICAL";
@@ -107,6 +106,8 @@ static const char *powerpc_excp_name(int excp)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static void dump_syscall(CPUPPCState *env)
 {
     qemu_log_mask(CPU_LOG_INT, "syscall r0=%016" PRIx64
-- 
2.55.0


