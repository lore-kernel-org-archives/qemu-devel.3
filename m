Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C2606A333
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZQjD3gtq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VBacqCPW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMrP-0001No-FY; Tue, 20 Oct 2026 23:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMqL-0007aD-VH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:18:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMqJ-0003Ae-Fj
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:18:21 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2FCCF3116289
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yHld9MMMXcLmKS0hkrcHdEUGfxdpa/G/zGBpwpoW6tM=; b=ZQjD3gtqBGGCS48w
 Y+5GqOdDlP05VoKzhWO9OAbaGoej1ShXDdMNPIznPe5qSsYSYLcv5gz/9CSn1dUe
 d0NMVwoZTgFGXmyQPoYg8vW7Xq/nVwt2E+jxptvbbUQNPTfm0Jtgrg3BaiVavB2a
 N7raHqweWlZ9gQPUPeioX+aT+rkEz7hyzchNR/68Ktqf1CDkC48nzjeplPpfDJBZ
 IHqh6yJxm5Nus7vvYHBYu2ZTQ7IZpFQtrjMLcZ58BUdKbjxVL3wbE0H5iqJlUHtv
 3MPb5LcVagHizad+Cdq9us8nWWiUqv+n8KsH21ANLAeuXr+JzRgPnuEtnyBACn8X
 SjaX5w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hsr7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:18:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91b92acedd9so10259826d6.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552687; x=1793157487; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yHld9MMMXcLmKS0hkrcHdEUGfxdpa/G/zGBpwpoW6tM=;
 b=VBacqCPWcd8HEowLUJIU79+p1xQeSoogwd6ScGsE26OqeqojHtDMOBR1Ukrob/CSqX
 roF5RTY++pGaqYZVl7cw2L6fU5/I/k3WGMLtOevHmffXVvyTshPMxiThDg9PLBRSkzZX
 cV48BgsARf1+6A+vNGIIPbz+fcltmuR1ewCFMBmLoUvlcMPNTwB18xDbtGsP4Iq+eJZf
 hC+teg7t8iMb/0m82KAPzqcjX48fTqefIW0WsBEQkL2E3TQanAQEsTgbM4jhzSueJCGb
 3b6CKMFrfiu8Xyesnj9Noox4etynTSGd2+4Q9Q86kBKS0gkv3NqHevAmEd8S1ctc7LsJ
 KjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552687; x=1793157487;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yHld9MMMXcLmKS0hkrcHdEUGfxdpa/G/zGBpwpoW6tM=;
 b=TfIp1NsiUsffvXxDAFaHYDYWi5GTd59WOgownZm7IaXwzcpGojamsjowg0Nq1l0GT7
 SOBnQ9UV2VDGnAclmoi1lWti/GpXyphOXl3mUApDIrP56iSJ++CQzIEaBsi4coTR4geu
 LQEopA74Pf6PabDUr9G0V9T3pLrK8Jms7mLiGqLqlivbNDXR6sNQUa2bWKnEIVaQ8c8/
 b1AjEUxsinfJKzU54n0roractDNI60gLSjY4JLSgpCCoE/HPo9iBBRMNPGR9F8gEQ538
 Z3+DY+ktR2fWtIIb2GGLWjly+nzqJb/CShFjpaRh5loIdQsD7H1eDVzmubeGY6yfSY8h
 oxBQ==
X-Gm-Message-State: AFq9FYLft47dROTJOIuTZJEdS1lX2m8UboxomJT7vxpG1q2iluS1DW3Q
 P6ZIkS2cTdjqFCcQk2oaxCDpoTgc9wH6AqLJdm96Q3UnY8Dkj1NZPXkgHsxkCQ1Xa5u9Ej9bhwR
 o4j4Ge8ChiCo8ZZykepLbN2EKef7Z8+EcckCecYmFfSjBvUR5L3kKEraFOplWEv2umqNU
X-Gm-Gg: AYBFou0HMuE4pEWFQvf4/CYOP9NlYSSzsvfNfRAt2fCI6BnWCUWk+GC6C8z5iLDCtS8
 OTFNVCj0R/w2Ucww3z0vyEeCm73HtlrHnSRC8zuPgc6lsGu8QrvBcdkjuoYxe6KhgdlhCHh7+V6
 6oRnKop4ElYWPlNkFqRfH6ICWL5HNHmCbtl9JqFmsYuAKBs3RLV6bOt6OjwGkux3R27FKjH7Qwv
 YxQ+8GBtC/5L+LAhq+cKLNlH0UK15AkRw+LshEhg9z70Xj6BPzNUVs9wXvrq5N2CbKz9rGV4FMB
 /7oxJwfa1vT0X1duX45z87AIT3jA8xKgDuCRR1gRF8skhbQZfZdeBOI9tYEiJMm76m0047Cj7AS
 Y3Mt+EPNfuGU/fIsLylyWKT37XfDT+Qp0HDivVMQV
X-Received: by 2002:a05:620a:4493:b0:93f:22f1:97bc with SMTP id
 af79cd13be357-93f57f639c0mr206987385a.67.1792552686803; 
 Tue, 20 Oct 2026 20:18:06 -0700 (PDT)
X-Received: by 2002:a05:620a:4493:b0:93f:22f1:97bc with SMTP id
 af79cd13be357-93f57f639c0mr206985285a.67.1792552686366; 
 Tue, 20 Oct 2026 20:18:06 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835f46sm2554462f8f.38.2026.10.20.20.18.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:18:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 30/33] target/sparc: Remove well tested DEBUG_PCALL
 definition
Date: Wed, 21 Oct 2026 05:14:03 +0200
Message-ID: <20261021031407.24862-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad82eef cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=d8nHZlMCPPOsqsKe8PUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX2uYrj9g2DgVx
 Du0REDFQ/JmKjfb98Zi0u/ppaquH/8lIgmrJAwc96C3XKAh6GE/rhFfL8RRs92zA5n4gonFppOA
 R5vudUGWmBeLE9S75VQaxubnKdqxAhg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX4Sut355CNwNN
 ajFsz8SZJlhWDmri6qnYyFzMljnVYiecIQjrAaFC0YFnl4OQuCP4C3RbQ5I6CXOELSKv+vN3uOh
 tkPh9XALDLa/BBf2tp8Pc401hQQTAMHsJ6UOyoJUtjOdaA1rXTyNFWu1mGzKwurMh6uS0M6Dslz
 0O4L90Es6FijbFu6zCoM3JmSTFr58xCZ2UFTFyFO3CzXWyCdDf4cMe4iJuW63dZxQK1Ftntrt4P
 ce3f/dftU2qOd30WSTdKcV5Hc8gjIObbdy8vhQJS7mxWywvWnRx1mR8yZdhc9MFNu4gQfplP9XC
 haEv34PMdn3PZqDu2QRA35DgwVC2zcl2Sgb7omf4jlkQK1eYFYwGasSoxXO/BogouAySy7GTYwb
 /YlFZ9pqdl3ePee+QxbtBQ0quTdQo6oH6AzW3plFjHLCepSouotl4pNSPUP6opILOrxC9yG9fLM
 1lYAN0vIaqKamnWlvhQ==
X-Proofpoint-GUID: lwkPDXtVVMGzkNTVhCg1KU5MsA-3S5m5
X-Proofpoint-ORIG-GUID: lwkPDXtVVMGzkNTVhCg1KU5MsA-3S5m5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
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

DEBUG_PCALL has been unconditionally defined for 14 years now
(see commit b884fc5ecaa "target-sparc: Make CPU_LOG_INT useful
by default"), so the #ifdef guards around the exception name
table and the CPU_LOG_INT block are always taken. Remove the
define and the now-redundant guards.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/sparc/int64_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 60ab0478fc6..10341e0c282 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -26,9 +26,6 @@
 #include "trace.h"
 #include "qemu/plugin.h"
 
-#define DEBUG_PCALL
-
-#ifdef DEBUG_PCALL
 static const char * const excp_names[0x80] = {
     [TT_TFAULT] = "Instruction Access Fault",
     [TT_TMISS] = "Instruction Access MMU Miss",
@@ -62,7 +59,6 @@ static const char * const excp_names[0x80] = {
     [TT_EXTINT | 0xe] = "External Interrupt 14",
     [TT_EXTINT | 0xf] = "External Interrupt 15",
 };
-#endif
 
 #if !defined(CONFIG_USER_ONLY)
 void cpu_check_irqs(CPUSPARCState *env)
@@ -138,7 +134,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
     int intno = cs->exception_index;
     trap_state *tsptr;
 
-#ifdef DEBUG_PCALL
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
         const char *name;
@@ -177,7 +172,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
 #endif
         count++;
     }
-#endif
 #if !defined(CONFIG_USER_ONLY)
     if (env->tl >= env->maxtl) {
         cpu_abort(cs, "Trap 0x%04x while trap level (%d) >= MAXTL (%d),"
-- 
2.55.0


