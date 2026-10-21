Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB05606E847
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NBnfWMJI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gYPeypDS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMpr-0006Mw-5p; Tue, 20 Oct 2026 23:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMo5-0003rQ-S7
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMo1-0002nS-Vm
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:16:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2FJ3L2393978
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SU/IMfYsvHyCND/D0agwHYqz/dXznICB+LmBjN4T+h8=; b=NBnfWMJINd+IyML8
 ZWJvmtVkKTmVKHcfO/uV1CV0tHGv7DCFEXTAXulx9s5pjTtRZ9Lv6ffFisX30YS/
 93Cw/DBqNBoGpRa1fGeCDg5vEPBsHcN/1RlP58VNYho0Obi3YQ4WAK93PNIDfh5a
 Lfpul6aVNVrHIYRh3SY/mTJxWgbSh+lBmAqu41XdqkZ5vjF4BDeNqmdQHsn20op7
 4GxatXzqYrPHDIIOE1XvFJU+6G7vwuHknPxlyrobTOU2606xBpODFxba9/Yew2EC
 XaxvevYYThqKqws5SwExW+5PVVkcEI+KCOfRXxcSkZkfemG0XIN9fErs/sR0O09H
 q6bbAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb99grd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:15:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f37c94ceeso255628885a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552554; x=1793157354; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SU/IMfYsvHyCND/D0agwHYqz/dXznICB+LmBjN4T+h8=;
 b=gYPeypDSfaf0gkgaz7pKergcMxWXiiAVUPCLnUtm1ODN76/x/anHG9Nt8JSM8v2Zn/
 NhEcHMU5UqHkwETLXE8vcMSBEcgXLQj5oZa4lPbs1G+a2Gr2Jy8/hvi4qJ7PXP+9y5Nq
 HJsxFbgalm61/aEvqqbCwGVXjetQhqGVyzktqAfYDOkI3dj9g8phyD3f9ZdR2huRGwoa
 EzJWx3oMhihm4MuJWqRzJOm/gNDAskv/TxJcAHnvCoHWLjdZvXu85tS4jXzrysQTw27A
 zqZdtSCgKcQdIOAd0HjJj9HdD8+HS4YvcMWGQcD2n822S3xOxiyyQcvgaLNgPUHfpVXn
 gwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552554; x=1793157354;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SU/IMfYsvHyCND/D0agwHYqz/dXznICB+LmBjN4T+h8=;
 b=QR3Tm+5GIj6hO41W6hD5/fl4Q4KJEvJrnDn06gkJ7tw4kAGv/EOoL4rK/B+ZGkeaNH
 +mtABG8V/9qVOG4H0UIVIzEFrj+yS0UQwO0PLQDmGkcN/5AWOG43NBpV1t+ouucqeq44
 a7998UXk0vMMd7YP++wW3nSk87LjGOR6GfTyghu8KtFnZN5sDwNmPtM2FK13zEokg9av
 lgey4YuBX/dqCI7XRlLm2OKbI/8Sq/CMRIOaY8xdKb7Ow7ju1KXGR2sminKS3dTAVTDZ
 8PMM7OZP6uBrwkZw87/blb/w+92DizSfQoc+w3lcoH+X/KjJOrWFIDd/Dy3Pvhyewv/H
 DlYw==
X-Gm-Message-State: AFq9FYKVjOY+Vo4lzdUbY0lSWsykhD8BkPp3M1w4BGLprB9pUu00YKiP
 QzPflhJahX6fZciETcLB+f5qy+JokhzCigoe/kB9AuqinZOp5KYmZQyxUFpewwDwhzYgzntb5vD
 qUz4gpKhubtZImx0F5BTjqyjlWd/jvSkQEoYCwoxBxDdXMd6ZGODYb2+7snxpiLxvRzkU
X-Gm-Gg: AYBFou0ZJW4Ot8uFlO90q+JF1z/asgSrq0vcxST9a02MRINdHIZpHIAqTBUqNzZ7C9L
 khu7v8WFlMDoJjlOONAwHKRbAjxuXnx3VlpZyrUiWG8aO0lAMwHqGxvbsaqrEEiYV5N0Fj8qhA0
 QYY8WP6mRGruvIpjLqi4MbsOsGOHh4MBaODSgZy4I4Q8z2MaHTVW8mhogaowBIA4mKNxUv78SEl
 XNopR1pbkihNbiifHDqSYMDnIxs0ZY1X8n2JHZP34PBkWkGPJRCqw8jyumhY0tUmAXOgTF+ly2z
 5HVVLafUL4jZvoBreS/2at5s/KwDJRLrNPAQ8Qg/xRjW0uHK6m2rRYBb4bWjWWKm80PIBnkXYp+
 NHs6qlXrLzYdXxjKpX9UVwhgxBnCqtW70CHcNgtRu
X-Received: by 2002:a05:620a:444b:b0:93c:d209:4ea1 with SMTP id
 af79cd13be357-93f4c67fe3cmr603051385a.24.1792552554007; 
 Tue, 20 Oct 2026 20:15:54 -0700 (PDT)
X-Received: by 2002:a05:620a:444b:b0:93c:d209:4ea1 with SMTP id
 af79cd13be357-93f4c67fe3cmr603049285a.24.1792552553544; 
 Tue, 20 Oct 2026 20:15:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25840115sm2344008f8f.48.2026.10.20.20.15.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:15:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 13/33] target/m68k: Register CPUClass::exception_name()
 handler
Date: Wed, 21 Oct 2026 05:13:46 +0200
Message-ID: <20261021031407.24862-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXwFZG5gOOkSx9
 IM4aE0NWVqFgClDTMJFRL0KY6gMyr6zWC9oppCJJTGVJKEr+P0NqUEE7r8fKpmueQs+Rf7A9N3Z
 eZ8uQkBhJIlcDEzZ8r/CwqnV1zcc6E4=
X-Proofpoint-GUID: TDWftoOnCA_wgITleqabMnImmD16flW0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXy/qDg/BC1Iq/
 DH10RGzlwB33OIzXJ0C7S/1eWVjzOb95verxRO57q45e3rsW+yR8uwbAw4AoQelI5xbe87jNGLM
 GvbRxbbaCL/97fL9oKVpuNisM3KLvSnBMpAIuSRRfnjZLP6n1EDFFhc4uNCxrY95rNRCjqYu8lT
 RWba3rr2Xl7FnOSXy3KUSEBYRIvSfdzeIW6xoM/1py4Ljjltrsc4xwosbo19hFzBJqkaNGgWkxE
 LrClsqM/LRGEH9x90Rdi9W04vUPgj5pkAvLoNNm5+JxJUXRbagbMkybN+vhlBfoWHyN809Mzgji
 EM1LIIZYgS6yycmRZmIxhkQqETXb6B5JS++1yZjUrx3HLASGH19gVNf9dlFqRrY4Cc1X/f7zCiV
 7mmLkWbkBOhcE899os05PsTlmVSfw6eK8BraQplH1GyoFulZRA1J0dilcsztxnLCH9W5h/p09T7
 oBLSH0azeTsKGNb7Wvw==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad82e6a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KgwFk9o9-AijF0zHnMMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: TDWftoOnCA_wgITleqabMnImmD16flW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Expose m68k_exception_name() prototype and register it
as the CPUClass::exception_name() handler, so the common
exception logging can resolve M68k exception codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/m68k/cpu.h       | 2 ++
 target/m68k/cpu.c       | 1 +
 target/m68k/op_helper.c | 8 ++++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108c..44b4afc41c6 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -69,6 +69,8 @@
 #define EXCP_RTE            0x100
 #define EXCP_SEMIHOSTING    0x101
 
+const char *m68k_exception_name(int excp);
+
 #define M68K_DTTR0   0
 #define M68K_DTTR1   1
 #define M68K_ITTR0   2
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9b52ad5fc23..7d5dfd8e529 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -730,6 +730,7 @@ static void m68k_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
+    cc->exception_name = m68k_exception_name;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->get_pc = m68k_cpu_get_pc;
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 38f7a689814..c600f83ddbf 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -80,9 +80,11 @@ throwaway:
     cpu_m68k_set_sr(env, sr);
 }
 
-static const char *m68k_exception_name(int index)
+#endif /* !CONFIG_USER_ONLY */
+
+const char *m68k_exception_name(int excp)
 {
-    switch (index) {
+    switch (excp) {
     case EXCP_ACCESS:
         return "Access Fault";
     case EXCP_ADDRESS:
@@ -185,6 +187,8 @@ static const char *m68k_exception_name(int index)
     return "Unassigned";
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static void do_plugin_vcpu_interrupt_cb(CPUState *cs, uint64_t from)
 {
     switch (cs->exception_index) {
-- 
2.55.0


