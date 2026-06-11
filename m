Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2694ACD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjlB-0003va-FL; Thu, 11 Jun 2026 14:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjlA-0003vS-Ah
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:04:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXjl8-0007AR-KS
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:04:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BErcsT900475
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pz1gnBO6vvlQ7KzROo+DJ0K4UnnXMJB1QJ8r8KJvsTQ=; b=nxVjaX/N37j1JOiI
 OPev+PfCDaTmRhWgoiczqWA5w4d6tSQqdy1CwoY7dehOMoRw0RrX3vJakGYvhiZj
 1w4Ca9ZLcyVz64/gJQSTpOhctF3ugehp+MMJrtQX7Nc0cWYJeNvntD+a8+yFxpzP
 NyEyDYn9vkVxRJTvHz07hCecSxr6sxAa5ExkgGFmbIwDkz8WB2+1HwJiRqljnetM
 arwUm30TDdGRkeLvrGsLPyyO3PbxW/Zvq0PHQA5JZ7meTAbzJHoHjsHC8z3jZsJh
 8qsCSb89RySMg+5/Re/Sr+X3Gz4ZAUlFzk1D9hNWrSTUnfhnJ3ALb06uPjOSk4nl
 W65qwg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe704x96-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 18:04:05 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e6f01486a0so275404a34.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781201044; x=1781805844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pz1gnBO6vvlQ7KzROo+DJ0K4UnnXMJB1QJ8r8KJvsTQ=;
 b=cPjwcH2jRe46LJwXlaIO4yb9Kto5mX/Uag0fzkNaem3jvCaCflw7Skk3fj0xUwVQJW
 D5RAf2MAR1YvurZRSGo2Wq1pDz1+m0pdzbvVpfFtmL+kALorlDwwPNyB3k/wYga56f39
 JJ7xgV9XxMDCfXXZEn5E+ByM4i0sRe/08SPAAur4av55solB3bluPVisC8dtgFjJIl5y
 JT6Sv6qNhr8wBo24L7/OuQ/KfTlWij5jOsf0lWQz+fdKRfly4btdTFc3Rj5MF+fuNNt/
 skyUauwrhqV1cA/E+pUGu2tVsHi23aNHfB03UqrsynaaX5SxfMDZe+UnfmsWKa+Pp27p
 2iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201044; x=1781805844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pz1gnBO6vvlQ7KzROo+DJ0K4UnnXMJB1QJ8r8KJvsTQ=;
 b=GYR5fwdSrKlvxRJpjLinOx3eiSvk0lyvEKTf3Uo/BuHUDoGJ9PlCVUbTl/IqOxDyTV
 6e84Y3GXI0YrY5Iu6jlAkWHdaWlXoTwFuwLUvnquyIojhycLrowndjGg6+bG4JjsDKFg
 Ok/ZV+4ThJsdXXxSf8B+SdyKxpC3LD4wT8jnqNUVwL6KfmsnSgrxrRj2SvPFln6a8ybE
 qNAQqaWkVGna36H/c9MGShId7535MgoQA+rmL+vNPHpFrTq6PAej6FTwd0VZugZySNq/
 08LAxY/0aY48BCNPFnw3vzujkjTnm0DlUhvfnvoK1Xp8vLTXYSLOKMgunRG93Zqu52w3
 cLlQ==
X-Gm-Message-State: AOJu0YwrpwRvpm1daECdhmkf41mtOQtLAYAN1GXRMOex9QzP2UY2yHju
 u4CIcu1HHmExRI+dOeFrLnHZzsR6MPoh0LUziIIRW91EQ5IVjEgoZ3aGFCuMRQDvZWF4s3ptB8Q
 o+G3UP0Wtk0aVG9r0HkmNnjZA+D2xjfv7+0S+tcOzeXeoSrbyzYetUwrIcCcRIXXKDhV8
X-Gm-Gg: Acq92OEsBP/KAIzFaYnW4bj248Gi4h1IRux+FA9Vh8g/8cIDiMoLxnuAz1rRoxIwCzI
 KnmIvgWrKH7iqsiwWQn00qLW8qBlKFrub/Xqt4KK6d6vq9oeRpNz+pCf5mI0pi9nnK7s0lafvfI
 0Q2xs6R1BzAqVrnFifEIci+IiL+4f6zhEEh95UOUaErwa1eGOTX1wuITZDf4kthuo/iXnR359k9
 UNxpVizHZWE1x47+fF1KtHmRf4HLrWFR11gx2V6oUBqkrTyaF75Ahoatk3RSMIWLSiY7qH+oqnQ
 sQpH9+HWt2ddDuA1qLW6alY/B7yFJxHUZ+JALS6yuKKeUfhCFWsHwZidLoaApng3PVXi7mV7kzZ
 4Pe6Eh2QTSFrtctpDFpsGFNk1F4Ue2oq/I+9Uauw8e00ih6/Iea0IZBDjVq4Gqw3gHBPJbL6GJi
 9HFBzVpJPA
X-Received: by 2002:a05:6830:d1c:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e77355005cmr3211306a34.19.1781201044297; 
 Thu, 11 Jun 2026 11:04:04 -0700 (PDT)
X-Received: by 2002:a05:6830:d1c:b0:7e5:68d0:462d with SMTP id
 46e09a7af769-7e77355005cmr3210970a34.19.1781201042321; 
 Thu, 11 Jun 2026 11:04:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606c0ca051sm728566f8f.15.2026.06.11.11.04.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 11:04:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 5/6] target/s390x: Replace legacy
 cpu_physical_memory_read/write() calls
Date: Thu, 11 Jun 2026 20:03:19 +0200
Message-ID: <20260611180320.30320-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611180320.30320-1-philmd@oss.qualcomm.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX9lglPt8SQ/2v
 HpMqrnGwXjfwMD4GXQNLU1S7FSeHDKEVF4ulSOyRx3F8wJLnKoTbI/yhzg78TTWhTSieOOaJIcw
 2SvJ5wlL5fTBx0DsA6CutJfAJxKE3hTfMNJvkBwnULJcvjODN2Lgbvv7u3RMzLGHYgjJ+JXXC/k
 bU7pbCxAR6hmiQOWLTZbt4nArnJgzpuIDKmpk5G2MlBxS6l0z6qfcNt0edSkK2sy8B/dqgc1PEv
 zV95pLDFuYF6QNzMZ9L4Tuz7IhtfnFAfOx2TwRoISJ+f/IGXyCt8NNtZe0+Z2xm2VB5b5I1pU9Q
 zqTMDAnhDOw75eE5iQ3dKsQruAYzFISdsB0/2siFU22JBV86c5ctfi/rocqNyZbwMTcsDB0j7GH
 /D03kZDYQur3qm9f8VF/XpJwFjhPNB5+uoZEMhbUKjGySG7GQ4XdzUIBALZLSSh/VoV1T5SaOqn
 jzJVu7C52XPP9ANR7lg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE4MSBTYWx0ZWRfX/TlNTOmebEqn
 JhtboijQebF20s0cigfP4pPOmEu8QBMYRqsLwhN72ILYjIvuB/2SMfPNB5JltxWHIuD7Mry/1r8
 tj09b1ZazVV2HzzZ9fooaGvQZlcFh/M=
X-Proofpoint-GUID: dP7eF3HETR--UIH7UV5ET7x-mK4ESNl3
X-Proofpoint-ORIG-GUID: dP7eF3HETR--UIH7UV5ET7x-mK4ESNl3
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2af895 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=69wJf7TsAAAA:8 a=wtMswhJjl9DcAQxfHdQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=cvBusfyB2V15izCimMoJ:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace by address_space_read()
and address_space_write() respectively, accessing the per-vCPU
address space instead of the global &address_space_memory one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: qemu-s390x@nongnu.org
---
 target/s390x/diag.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index bc1791067d8..01cc802eaed 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -79,7 +79,8 @@ static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
     if (s390_is_pv()) {
         s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
     } else {
-        cpu_physical_memory_read(addr, iplb, size);
+        address_space_read(cpu_get_address_space(env_cpu(env), 0), addr,
+                           MEMTXATTRS_UNSPECIFIED, iplb, size);
     }
 }
 
@@ -89,7 +90,8 @@ static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
     if (s390_is_pv()) {
         s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
     } else {
-        cpu_physical_memory_write(addr, iplb, size);
+        address_space_write(cpu_get_address_space(env_cpu(env), 0), addr,
+                            MEMTXATTRS_UNSPECIFIED, iplb, size);
     }
 }
 
-- 
2.53.0


