Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03194C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LCJ-0002ks-NJ; Tue, 01 Sep 2026 05:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCI-0002jA-6W
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LCG-0007ge-CK
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:54:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681796up1211380
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E3SfK96pT8YRclCFPnBfRXnNdNa7xUkHM6rQR0k5Irs=; b=n+wl+FZwqYIFm1YD
 9FNfDUq+LgRCI18hZ2MB11iayEdLHs7BaUEBAY8js8w6cJt+m3Ee1/8lIqkKyyI8
 SlSO7jg+WQ6lwI3uRZHAKEhHNby1hB32lfgVABuxoDdkBozJazdG0SmCCXGxLpMj
 sggnTGDOARvaDqi+LZOobEB5GYpp+JvelOH2BaaftJl1R1n0zTZeaB379MCsMQdE
 nU2HyuKdqi37OWX5Ng7heHdqvGyb1+Ea2tp/zEA9kMM0zfEx+4otdUHJNG2rljA1
 XfcZ3yFlN/iWu12DVgf35TyJ4zzc0Fu6VBz4hDYT8P8PhhSNfrvMr1ePf76y8eoz
 SI4rfw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdnk8sw42-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:54:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90ce9ff466fso70667916d6.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256456; x=1788861256; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E3SfK96pT8YRclCFPnBfRXnNdNa7xUkHM6rQR0k5Irs=;
 b=FN+EVG4uL3KOXYfKXBhOd78GhDO9xd2sd3tnuv/ONvrxL6gxO4WtlkFmxDRreL5roe
 UNAPbkIBmJcR8WxGuWPrQ9nbMup7zuOvDO2Oa4agNUNBSWc9MlOHwyWm0B7brD0KLt6Q
 wZ/IYDVmlxyMmbAAcpVkJnpr+MzeYK95z32dGjnLf9JAoh0NO7EGEDUL3QZjjKJb0oK4
 LX5DZf5vR+F2ALXWLNmaKS4PC0Y67/MCOlY3yFOhapL7byqeCqwd2Zft15amhWkPcves
 A4xuubztiFeItGATsnzm2LXRHTMR+1euVdkIvVc8Se20I2H8weMy7FjHrNN6spqCk5Rs
 aMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256456; x=1788861256;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E3SfK96pT8YRclCFPnBfRXnNdNa7xUkHM6rQR0k5Irs=;
 b=OUgvNmK1h44w6/9j8xQp1dynPosgIct4DslTbR+t9lp5+BxcLbQ/PvH+0H3OiDT4no
 sLUH7Ckno1EcK5qd9mlcPKVeGGLHyEb9y1MDqL6P7p5zbwjx8oBvs/mMdWGzVNW47GKb
 OHP0avAGiDdireJFC+vpVzLe+w/txj6Lq5RCEzVFW51Htc5hgztAJ91Y30QuknLsVj7q
 HqIPaOOuFNFBNA6EV6ivdj38yjxCj/9D2TENbK1CfkDBeoSin1TCrys0LGbzQGx6RAbR
 BHuaJj6ncpkFn0YIFdenuJT5GtFggmxURX68ud2fts94K6yAEAHUfJe2uGqDp/Z3oQnt
 1HFA==
X-Gm-Message-State: AFuF++mksGYHQT7mMONmEe9g8JzDNONPXyCUy0nw5x+aQrVaO9sTBvhe
 B85w0MhEABPqFfXFWIAUJcQygEnIDX++f83wy6BFWIP2sT9Sia06mTFGmFhEyZtWJz9jR16l/ha
 cfNJO5kfrUA6BQ1/RjzULzox7JozqG8MKE8CC7a49Iy8c5GMvc67GaltfOYDqKXTShQ==
X-Gm-Gg: AR+sD13nlsHhRcsr5FyAfmGzya/kauPZLwAHD954gNuPt5qAGV/YhXPrCIZaO75Xi74
 E/eXivTZoxxoj/Y0gzMBTU/6HzlPYiZrxeOMxhq/iEdqTqh2N7pYTSIqiQPq0uHdBHKLXY0tvAN
 MqloxunypZWRC19IPI+o7QidGDB4VSlTytM79cpv6bEHyPlxAshNQdqAB/xAn/7hAgQYIBFAaav
 V2Gn9yJ3+nxiUISKegVkYDSjOY7mQs9SIhzvmM2Hr145+1KQmjb2QhMGs4ZFJ/DAtyaZdZfmVSz
 1MzG5UyC2gTvzZBADqGHlJaIt1Ce01qDPKzfBQSkVqEos3whwz0sxf33iM3Nnz+QKNL4F9saazS
 Gh0CdcEZxzlfhTL2Bbk6NEYFiDEea6i0HoJeRHGrn
X-Received: by 2002:a05:620a:29d4:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-939134fe550mr3708541185a.0.1788256455786; 
 Tue, 01 Sep 2026 02:54:15 -0700 (PDT)
X-Received: by 2002:a05:620a:29d4:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-939134fe550mr3708535085a.0.1788256455173; 
 Tue, 01 Sep 2026 02:54:15 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b926874fdsm344672775e9.4.2026.09.01.02.54.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:54:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH v5 14/21] target/s390x: Constify S390CPU for cpu_has_*()
 getters
Date: Tue,  1 Sep 2026 11:52:20 +0200
Message-ID: <20260901095229.72018-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=f6p4wuyM c=1 sm=1 tr=0 ts=6a96a0c8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=mU8mmpTTODwToQi1tsoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX1gd6/vNVRnRV
 hmltS9pJg4xCxDSPKgfbk17cR2vvmmDZ+C01F53Pr1dkGidX+A3W4tg6sXBDcrgHGu5BZlY1Qdy
 onHHF9/MZDCF+tpGB8kfkyyu1CRySVblCWEZBNphtTbsfy1pLbCDND2k/QXUaAhptJ3pGzwslf8
 5TD2fVloIkqGhUyM1RP+KkYbZ9Sr7EeXcueAl1de2pIGa7lyeHm+PG7g9OolyxeAk9Tw6YBJq17
 kSP2X5umRQoL/R4+ZtJwgwKHLFmP7vgiMRJxqy72RKsxFXZKbxeXneFsE30RZa8w7RViAn3Deta
 AWcGdXlxaWC1bvJAdV9iGnZYpUcJS5W87eFQmbHXpbH79AoPDTe1KX8NLcdJ8J+TYnFSBzSZt0C
 BwyVgbTiCD9EN9bPLWWkEsMQladrLibE2jXa1i1TPS98z77ip9OHoPvAGXS+Lkc/Ny5E0P8RHjz
 0BugtcUCv0Y+d4UJNVQ==
X-Proofpoint-ORIG-GUID: nihXGHXzb6qrKTNIVOrGrU7n6d4bCIq0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXxlFHz/Zcm/dx
 zTT4CpKOowdPE2T6MZ01mr23+nDb0tFytoAsRw4XjRDbBQ7P+4Zk+jlcbs7q2dF30x9x8jb2Gbg
 towGbbg65t/rSisG8dD6qXx6NSg0JC4=
X-Proofpoint-GUID: nihXGHXzb6qrKTNIVOrGrU7n6d4bCIq0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the const qualifier to S390CPU when the argument
is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/cpu.h            |  2 +-
 target/s390x/s390x-internal.h | 12 ++++++------
 target/s390x/interrupt.c      | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index f55b79ef8ac..998bbb0d7ff 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -854,7 +854,7 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return 0;
 }
 #endif /* CONFIG_USER_ONLY */
-static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
+static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
 {
     return cpu->env.cpu_state;
 }
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index c23ee1c8476..df1297b5c67 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -333,12 +333,12 @@ void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
 int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
-bool s390_cpu_has_io_int(S390CPU *cpu);
-bool s390_cpu_has_ext_int(S390CPU *cpu);
-bool s390_cpu_has_mcck_int(S390CPU *cpu);
-bool s390_cpu_has_int(S390CPU *cpu);
-bool s390_cpu_has_restart_int(S390CPU *cpu);
-bool s390_cpu_has_stop_int(S390CPU *cpu);
+bool s390_cpu_has_io_int(const S390CPU *cpu);
+bool s390_cpu_has_ext_int(const S390CPU *cpu);
+bool s390_cpu_has_mcck_int(const S390CPU *cpu);
+bool s390_cpu_has_int(const S390CPU *cpu);
+bool s390_cpu_has_restart_int(const S390CPU *cpu);
+bool s390_cpu_has_stop_int(const S390CPU *cpu);
 void cpu_inject_restart(S390CPU *cpu);
 void cpu_inject_stop(S390CPU *cpu);
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 1dca835c5d8..d7e3fd45e4b 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -139,10 +139,10 @@ void s390_crw_mchk(void)
     fsc->inject_crw_mchk(fs);
 }
 
-bool s390_cpu_has_mcck_int(S390CPU *cpu)
+bool s390_cpu_has_mcck_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_MCHECK)) {
         return false;
@@ -157,10 +157,10 @@ bool s390_cpu_has_mcck_int(S390CPU *cpu)
     return false;
 }
 
-bool s390_cpu_has_ext_int(S390CPU *cpu)
+bool s390_cpu_has_ext_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
         return false;
@@ -199,10 +199,10 @@ bool s390_cpu_has_ext_int(S390CPU *cpu)
     return false;
 }
 
-bool s390_cpu_has_io_int(S390CPU *cpu)
+bool s390_cpu_has_io_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_IO)) {
         return false;
@@ -211,21 +211,21 @@ bool s390_cpu_has_io_int(S390CPU *cpu)
     return qemu_s390_flic_has_io(flic, env->cregs[6]);
 }
 
-bool s390_cpu_has_restart_int(S390CPU *cpu)
+bool s390_cpu_has_restart_int(const S390CPU *cpu)
 {
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     return env->pending_int & INTERRUPT_RESTART;
 }
 
-bool s390_cpu_has_stop_int(S390CPU *cpu)
+bool s390_cpu_has_stop_int(const S390CPU *cpu)
 {
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     return env->pending_int & INTERRUPT_STOP;
 }
 
-bool s390_cpu_has_int(S390CPU *cpu)
+bool s390_cpu_has_int(const S390CPU *cpu)
 {
     if (!tcg_enabled()) {
         return false;
-- 
2.53.0


