Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B45606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEpObsgH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tr5dsD0R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0ij-0008Rl-6Y; Thu, 22 Oct 2026 17:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0ih-0008Mc-Ge
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0if-0007bL-Lw
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKunmX792146
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SU/IMfYsvHyCND/D0agwHYqz/dXznICB+LmBjN4T+h8=; b=lEpObsgHiEiKX7Vl
 SaEbDe0ZgSCe7AUkQI7KVsPNqUEepP8MypoPi4BWvR/Dlx6OWJ31sx0vlKhD/UuN
 C/cS9eXG52FKsaU9JpDmnTodTbUvscIq2pH0uc7dTts1BH618ZUbTj+i0S7CEo1S
 232sVsI/lMylKb2g9gZyYdAtUnDRo+52lLbvt9Y3/E9R1rfndBNtKBKWNtHDcK3g
 f4gVqkDu+Cs9TPuZmpEbsx4zXLpcrUkruptyK/DzVldXi07fu7bdHd86TPUliyM0
 F0MQMIfPtSHkHwLZf6n9mqNyxwqJ76zRvPEX2+OIkSAvQofmOGSahWSbjdD37cg5
 6sQnZg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk85d6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso31422585a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705983; x=1793310783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SU/IMfYsvHyCND/D0agwHYqz/dXznICB+LmBjN4T+h8=;
 b=Tr5dsD0Rx0/XyL1Xr7Aho3tQ6AvjehKNblX0Vmi+GWA1h3+Tolu9upcMfTOWNz0CJJ
 Yhuda8M6jnJoCGNmZ6qRrZe4OQX9bjve5lmNEBAvM+ID87REhgZjuVZMlaI4s9EkZ3mQ
 7l4n4xRKTn4h4RqptKYEWIyYkknkLQF4ZAKHRMKPCfQnmRlLTZ3smDKVrSl/TKo2zsxI
 Np8w5dN2/oog/c17Ie/glPD2/EkEFxJQgBxwCKDIf68LhQdkE0t7TtRX7TOYBdOB1TDv
 t9qJeivlVJabbu6nEfsAjOy1nHFdilNRWJorkb3evGSMV6t3/Br0mWUq7GPkFmOhXOkC
 SpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705983; x=1793310783;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SU/IMfYsvHyCND/D0agwHYqz/dXznICB+LmBjN4T+h8=;
 b=VrxvjIvAFoavzee3JtVw0RP0ByrLX4Nw73WX9fzPF/jRzDFRRjueYcbE+P5yHDJWqF
 9+hGyxV5ixJgiI7eLBXLcEz9f0o8RZhwyco50NO46hjGov0Q/s5YJD1Ofgu+TD413TlE
 +OtJGlzJ7L34zvIZFrd0sPGTYKdtd5EOFxxbkVSd8k97CTZfbRJUBbpXYiSlZZ7G/2XA
 c/ZwEPczV9Q1RMrZ2c7HIV0L+Z48BcWN8a1pw3A1j8ZYVbJtjkc/NJV3XblBea088OI/
 XwAbUwtX/OAzb4YQDkAUG0Ha9B1PRnbzaiDoS+9fX7a+7iDlWs93gxM78rvqj/HHRaFj
 Ccfg==
X-Gm-Message-State: AFq9FYKw3OuKyVo47fXoRZegO58yNSJyPsimKLYlRranuZ1+oLq4tzg5
 oEMS+sUXJVV1TwCiw3rS311zjTV6Uxl+ofKbMWC8VYRGD440ZizXcbjRFGaR0mp+jyz0uEDdqqO
 CBfkhPNL/dPYd5MfI6Bu9ziE/UfbpJaj6pTBaSX24uE1KXB0H5QGwEbC/kC2cQhHWJA==
X-Gm-Gg: AYBFou2A+KYRbAoiyD9/wJi8OSt9KvHgOFt+I6GWYX0f0CJX8xYKH31mNwGzTurovRR
 wPcEsLDEvPbmNfHG3uYCb2uT4bEgThqxbkUhpCZdFv8+cBzyGxF9SvHHzetzS230jwq0ETf8gIW
 bRFbA/vKbGq546zOc4NaKi+w/SdsiyddackaHUAswKkJGjYXvJU7u1S4871zIKR7monWruaz9nR
 1ONNTh7hcUeKC4bpSM5NAljctN1HFJZb+HDOaajuE3iR048CRhVHQArjET3bgDxA7ObeDw+rDNZ
 K694Ocuy5jr6npfcZWr2+cmdjU+2rysAPZUNEGdazBfFVVrPgakcRfRnPevD4LGBApPYnJ03sUt
 y9udHNrWb+bPqpZuYT5LJGimqcSzlbIG3AgmpsP98
X-Received: by 2002:a05:620a:17a7:b0:93f:2cf4:e6dd with SMTP id
 af79cd13be357-93f6f9a285emr128138285a.51.1792705983157; 
 Thu, 22 Oct 2026 14:53:03 -0700 (PDT)
X-Received: by 2002:a05:620a:17a7:b0:93f:2cf4:e6dd with SMTP id
 af79cd13be357-93f6f9a285emr128134785a.51.1792705982689; 
 Thu, 22 Oct 2026 14:53:02 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3804872csm646663f8f.34.2026.10.22.14.53.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:53:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 14/33] target/m68k: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:50:54 +0200
Message-ID: <20261022215115.19680-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+YKaee/+BqmF
 VA64ebBI3iT8PRkQNAWyYuBzHnFZbIUJexd6gY81tai7o8vLwxvebaYdvwkuIn8svv6AM2fGXgM
 blNKrhbILZ/asRu0TcLDr2/YWgVlceurtwL6D46RZcQSdT2+3kSUMSsUBgybDNIK+tH0KRwBqcd
 Syf6VT0VYTMUoKg12NdRC7ZOkp0DpUlnm1FaQRlghdjv5Tt25TQMNHCks/Hhepeu7ABf4SWuD3q
 hAOaazcJJYCasTtL0fjh9zbFNjWrU5TTr60KrbdR39fwxhn+o7nHWfylkysM/8UCDvmJAMI620P
 NAs+vVxoRsQA0Hi2h96/mt6MMzkERKkw6z1zk5jb2FgNFuOvVQJEEWNptjzJLVLC9FFRFcl4ujZ
 qr9Q6HKSoW6UPxLjDXNyd19EEZgCW/KBS06oPF+Jo9C0x7zcWPTOPzSuqgqEbgQm9ZJZmBExb9z
 Ukgu+1BPKqz9aC9AWiw==
X-Proofpoint-ORIG-GUID: lEHIeNFn2Yw46xrEyHch0ObTomNCoUWM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX65TPok1IrAJM
 YUABrD7jpTcZJ5QHl1pm9VqZjW9Foom1vP+2xJqlTK8KmJN24ZNg3JF04txRVMhcFVvH7AJI4CI
 hFp+oGpDUsm+T7GX/Uk0DCRS8w5qOiw=
X-Proofpoint-GUID: lEHIeNFn2Yw46xrEyHch0ObTomNCoUWM
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada85c0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KgwFk9o9-AijF0zHnMMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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


