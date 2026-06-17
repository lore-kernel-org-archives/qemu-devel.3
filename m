Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D78CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtJq-0007HN-Rc; Wed, 17 Jun 2026 12:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtJo-0007GP-SD
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:40:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtJn-0004Ok-4F
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:40:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFpLcF3015146
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vgvXy1iWKLUT9QylG3B0fsudy4/TYWdaU8xWHb3GIZY=; b=Jo2czSgGzguxGLjI
 RtaSiPZYPhSVBvLHnFJJyVzGYfZl5AogCdFjXZzSO0yJe42Ls+PUdMjc+qhtiQyU
 QRyC8IzJ7sFV/qyAJadczID/x91n/GhKIzgN41j3YGxMLDqVoO+LPZe4kSohvzw/
 8dOZgZHscOG7vdCALpjqF3b+iKqwsSIepyQkBUw/fI6yan5q1NYZ+J2XFJKo6kyR
 wtPhyNle7cVCbvVEFUQM0QJNKtKYdgm9NHTxlSEcn32xkEve21lo/uEtAVQs6gBX
 /aeXLXlqWOn4zUf7+NDMAx6mDgJHTbNwRxhn2FbC77zB9Mq6VFxjs7HM8+A4sFrK
 vLcDrQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euees4bun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:40:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9159c4b210aso199222185a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781714445; x=1782319245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgvXy1iWKLUT9QylG3B0fsudy4/TYWdaU8xWHb3GIZY=;
 b=f2kE51v0rxHzZ0ivvIgWH69iVewGJqqJ6ewLplJeMdF0iiDzqmDtbnoUSdN3yj9jKk
 /ORrstFh3PEEId2avylnxsC3BprV4z2KzTrkD6FAi5Z9DW7+ND4FU3Qyux55ewlBRotz
 FoFAT3PL0gwnNSDzwpsnTm0gnvVBVCDTj3Z/9kL1TfhHdxRSbhTzNHRNw8PKc8xjxuqt
 lt5xggAFvcQ0igCKVU8H4EflD96+TzCohYLpyuf7pJlWBtohFj6mPDiRMF2jZDy8RBGv
 2zNadtPgmSUxrqYXRoi1NoHDwFVpU9CE/FazpoZz6KivCpEqfLjFqgro41xCo3QldHDt
 wJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714445; x=1782319245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vgvXy1iWKLUT9QylG3B0fsudy4/TYWdaU8xWHb3GIZY=;
 b=ddLBzjkjNrkKwjlpn7gKHChW0MIlb1VS47BLQkB6ZnbJMBQRhPq8Fu1lO0QE2L34kQ
 /sQgZq1Ed9OkkUN2ceXXBaruzesGoBV+w+2mseL/kAjCMOREk4Nco2VUxWEXaVQZSDxL
 kpQlUD6AbIib/OsC0nn/0YAZ+d5r75s0g07a+PCVBIF3uztt3OthIhgpD7h+97PrK3Bd
 9O/y+TnT0mjh0XnGMCSe9y9//MYeGN5cviHXbs9e8GDMSk3IWyYZ0Pzn0Zu81DEGHGON
 D871CgXRJXr2QWnx/X9IBwdJ902Cd2MbKM41Tx8TSPOwPj1yAydRr5+zAr7HiLvObDcV
 MQ9g==
X-Gm-Message-State: AOJu0YwADHbPFxzEttulS4qRtimq9oMof6MyCwo4X3INlxKo9YE30btF
 nomTnRyQSMW7RgOUN70LAUfEE4pRwKTDiUYTHOi0ypr1tN8HlaMxxS6/E+43BLjEdQrI9/rf2ac
 4oOrVT4ZsS5GGQaV2sP3d2VeuiuNYFlLI2GCRmBFUuc6Bui2lMxZnatsiA7rw3mVuWA==
X-Gm-Gg: Acq92OGAnjBHY7nnz5ddQzntbbYCOJc7pwqKrJUuMu/Xbw4KX5u/ES9bKOG/AMLYzcf
 XaKgG6YCLGWC+zZw/SGMi2raE7oDmX37yx/wPONRqaioDi5rB9HJYsDT2vnLnY0hc1DKZcoJmZB
 pC3hJcEMC7HDMAIkYdbr7HtwgC7NtPsybxGqHPJSQ0WvVHptO1Fv2mxrytpAmhgFsz83cJYPoY0
 dqTH2hjcYZLIcjNzg0gBQlBvmosrdecPgm+2RGEiP7UJMSovlqdpZX9Xfxa+N4tCuCb7MBHPXe6
 19JgHgkFWSKoRfwI1Z0dgvdOh7jFgPtfIpnbTKnumMec3O5VtOaVQQllk2h12XLuxEB1UhwiBUJ
 UR2LHNafNdTUTn+OALuDl6lcdqT7me/e8c++/MNTz9rJsKA1n1zyP57pUKCruLWrcnB+k
X-Received: by 2002:a05:620a:29c8:b0:915:e8fc:153a with SMTP id
 af79cd13be357-91f082fe847mr48606385a.14.1781714445177; 
 Wed, 17 Jun 2026 09:40:45 -0700 (PDT)
X-Received: by 2002:a05:620a:29c8:b0:915:e8fc:153a with SMTP id
 af79cd13be357-91f082fe847mr48601885a.14.1781714444759; 
 Wed, 17 Jun 2026 09:40:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm57959594f8f.11.2026.06.17.09.40.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 09:40:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 1/3] target/s390x: Factor common s390_ipl_read/write()
 helpers
Date: Wed, 17 Jun 2026 18:40:33 +0200
Message-ID: <20260617164035.70788-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617164035.70788-1-philmd@oss.qualcomm.com>
References: <20260617164035.70788-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5DCJ14CnABgNVhwxleXJdYOVfwspg5_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2MCBTYWx0ZWRfX3gGrU39pFmMD
 FqzTBFtpOLuqPCcWyDBGV096IwbrCiMa6LS/basSWVW8ee1JmEq4B3J1Lk413UjvuHbPdQmQGau
 6HP5lnXJMf+n1GKXWBuLox7Fez/0GJnhK/+JJ4FH8Jko3Jx6kZnQ81T7mj46hTgSwUAqHf7DeTv
 3FKRSguuj4G9lO/VjzDZm3hEHRwRdDh7/uEwhV/j/pmMlNlAvJJd79eGz66t0F5sSmKwbpbYeTz
 b48eFPGXN/XoXHzx7QsUsOHNYIw5Yn179tjy+mock1WmAA42rauf+ul/cDe7OkeJu/N9/CKdh0r
 2dXi3vj/YQ1c64HYdxxQabIyKwiVcxEXCeEjrKwbDmy4WlDl3EskEEdTrNjiaWAd7TQht4VkcNE
 s6z+MnovQp7q+0tIQcDfScafX+5wvYz24C2x2rjajTWEDJr+is7SdT2brXYglyaQjnbPawUSnBj
 /XeOMXQHwO9bUm/LN8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2MCBTYWx0ZWRfX3yV/TQ9iPheZ
 Zc+eZ1eO9g+zOmaR8MiDFORV0VIivpfUrgeOUCydwbyAN8tq3NPAYSXI0agkhtPk6WZmUF3ErM6
 r3irPeGVrrK7ADMB6CIpJUPqeHebBzc=
X-Authority-Analysis: v=2.4 cv=KeTidwYD c=1 sm=1 tr=0 ts=6a32ce0d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=yJueZXV2tivX90BAKnoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5DCJ14CnABgNVhwxleXJdYOVfwspg5_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170160
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

Prevent duplication factoring common helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020839.19104-5-philmd@oss.qualcomm.com>
---
 target/s390x/diag.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index da44b0133ed..bc1791067d8 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -73,11 +73,30 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
     return 0;
 }
 
+static void s390_ipl_read(CPUS390XState *env, uint64_t addr,
+                          IplParameterBlock *iplb, size_t size)
+{
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(env_archcpu(env), 0, iplb, size);
+    } else {
+        cpu_physical_memory_read(addr, iplb, size);
+    }
+}
+
+static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
+                           IplParameterBlock *iplb, size_t size)
+{
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_write(env_archcpu(env), 0, iplb, size);
+    } else {
+        cpu_physical_memory_write(addr, iplb, size);
+    }
+}
+
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs = env_cpu(env);
-    S390CPU *cpu = env_archcpu(env);
     uint64_t addr =  env->regs[r1];
     uint64_t subcode = env->regs[r3];
     IplParameterBlock *iplb;
@@ -114,22 +133,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
-        }
-
+        s390_ipl_read(env, addr, iplb, sizeof(iplb->len));
         if (!iplb_valid_len(iplb)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
-
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
+        s390_ipl_read(env, addr, iplb, be32_to_cpu(iplb->len));
 
         valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
         if (!valid) {
@@ -164,11 +173,7 @@ out:
             return;
         }
 
-        if (!s390_is_pv()) {
-            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
+        s390_ipl_write(env, addr, iplb, be32_to_cpu(iplb->len));
         env->regs[r1 + 1] = DIAG_308_RC_OK;
         return;
     case DIAG308_PV_START:
-- 
2.53.0


