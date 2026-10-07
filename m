Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA26CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOKV-00062J-S0; Wed, 07 Oct 2026 05:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEt-00005K-L0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEp-0000kT-5r
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jnNE152120
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XUAn+Rc0zGgihHBU4X8NXb30cJYQwYHaadjEpZnve0g=; b=Vh+xC9PnGtz0MzaQ
 1nzHLSDNpv/qBXT7YOoHaGACvdN0ROU7TYdYwWejIulToqpwmMtgBcZFzWKbvDsk
 HySG0pd8CO8JUUKzVymvk2VBGNCjxd4RK3gvehBMddbtMfjEbA4nrf2B+kCKcMnE
 8F/dU62qQ7BlmqTA05uVePkEm35qCGncZcR/WfFkCZAr1qsf57q5zmzoJ2U9OnAz
 AIOPobvSPQbLeiiDi1Ky+J6pZuUjJrgm2lO7LUzRc/YyYqygGefT4i/0iNEFp5pV
 rso1iw/VDWNOEu+uAkUKKajrTpoz/hnHi5gUyn/ZXqjpRDSx39UTVcqQbDznccl+
 QjNolQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c719h7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:47:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e92aad34aso284311885a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366420; x=1791971220; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XUAn+Rc0zGgihHBU4X8NXb30cJYQwYHaadjEpZnve0g=;
 b=WFykNK6j4xxFhkWL1N/pcIVngqXCcBkQL5qybbJx6+DetiW0LR7NF5mQOf+aBfKNEw
 r+wRrn0Js4QWdEfk6Cs51XAWalca1XBFDs3agNmmZ5nYbJDV5eQ4AaHJcnScb1x1inm5
 wV+VPTIYv5h+R7+GTRf/JkcqSKI0yoT6/56X32gTMfjp0Dk7nNzplxEjYeZa0DHR93mJ
 AX7K7ir1stpgKQyJnP9R0C22SxjOwbRi0EokZf14xKWDjm+ilVBXEiBqOTHb8Je+5Mfd
 o00dNmhiXSlfCavX49MzsdgqzGjIsa3q2g1JA47p3tG5DttnJQPqOyCEuXAt72Lm7fl9
 Rm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366420; x=1791971220;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XUAn+Rc0zGgihHBU4X8NXb30cJYQwYHaadjEpZnve0g=;
 b=sLk6u3AnRlvt1yiT/TZo1czLRs0ueUV1AkGz6fcybObUYCdStSn2ojKnaT31D8MBtN
 fZiqvceaPZV0y5SqL6we4XIMhYXh3R8qNmzqB9YJlHiKHHsbv2pm8Bpx87DLqiGPNJUz
 fITOsM0oVY/AOoICOUwjqPo0Ftp4cWQTUpxDApATmlh66/RpVuuMXNrbUSQjLkvZ0kpe
 ZzyOUjg2pqyITHNJUHRVJkjHCovS9td/63IE45sfGfB1Ja3P1N/UlEmRY1u2Ppae4iSF
 9lwc444ZIX0pfRSM5j9sVtOdFMjMHivN+HyhrKdUvqZrhCGXUiXSljyqh3FrxvGmVMQW
 QgMg==
X-Gm-Message-State: AFuF++lCYZRGislSCQzfTlsRlsMuthpjkQSZ1YsBEWBHmpvKkstHZvhC
 eqJ0tr+vCf0mOI5UYCCO2seaw5i0vHNtDygsGXQ0Uc30kryKF/hAaOyuS8mh7cnQHb4FLkIN7wp
 /mBYN1qvYcHcDnuX8zUiFWqgWpoJ7jMeYpCjU7nTkChPxlccL6mOC2pJkSucpLMIxU4Jd
X-Gm-Gg: AYBFou3vkwHG+73RyvpNHaNdr6WEeNSEmDS0k10qkIWXDC0TgUWv9L+GC6ibWUQaUcy
 ruxUVwqKh/FwqpjSwDTiyU+8RmuIcCe90E8aOeN2APC9MDNtb9Vy1ZdvgPe/c6ajK22E/pvhMFY
 cagB0eJcnGVeNdKt9aUQGh48D9Pl9yvfAoszmsTBu2o5izAIxK72kGkhWNLCUZnZv/X4WhiCVEo
 ZBRaTe9Bjw5NmZ52zLtsMAW71Qxj9AkC+CPFkgxJqC/k/T6TmJ/W94FlQX+pIDmqv0Ywwl0YmaY
 hQ6iuD5KRwqWBDOXB/HMSIU3Nnm20hRGH0ODyw+Zbk3qh1WP9vZkimZYmR7C9OdtRpRzASGdU9j
 D/ybqg5FZL5RGsjrTobXYcBSmGdRKAGmz2WtJMPuc
X-Received: by 2002:a05:620a:6495:b0:93e:9809:3371 with SMTP id
 af79cd13be357-93e9b86e81dmr296028885a.82.1791366420403; 
 Wed, 07 Oct 2026 02:47:00 -0700 (PDT)
X-Received: by 2002:a05:620a:6495:b0:93e:9809:3371 with SMTP id
 af79cd13be357-93e9b86e81dmr296026385a.82.1791366419962; 
 Wed, 07 Oct 2026 02:46:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f5507a0sm48175575e9.6.2026.10.07.02.46.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:46:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 14/27] target/mips: Register CPUClass::exception_name() handler
Date: Wed,  7 Oct 2026 11:45:02 +0200
Message-ID: <20261007094516.75732-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXxV1QvpuidEu1
 WD9+UXKaeLnuD4nJ1UHOwrzYsxJdYl1B8U7ti6kpycy6bg239hnQDkGV49gsDpc4n/JPZmPK4zE
 pr07tXaihokGOlqj1IDaWFN9LgfoJJw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX7Z4F3X44APr9
 ECeZi3vEfDiRZ3D5WourH7LdsgelZ68ByBll+DeVE2kmfJkFTWomq929Xrx58skGQjJNELSXO84
 WTt7TH/rRcAadVv/n037QUksUivLvte+kBj5FgnQQbqKRrOSjl3M6nd1EtMZ06bVjVwb0oSSEQh
 4j8s08RQI804cxLWbiO9vxsLu+OwJq7M+5CcMg4e9pk9MDSXvs+X/cRymuhdm+dcwZ/V1em/scL
 fGVEmvENLm9oM64IVskV4OULxD2rIzVWMGKsHuh9CReW5JWPLBQTAzKk4LCedbtzCuMda9/lilh
 AJdgdLc15hVLbH/noloaMdud3m48JfjG0sGWsQFH0YDb1j6W4SnIcO9G4tTvCSPls8MkNDMSWw8
 k5npnaPp2i9KZPbnO+2COghcB3tLK/kgWE9ocaiY49MPK4DJzwgGMq59e70QjEB71XZJQQOZvhr
 Rj8ICHI8ArmrfqJv74Q==
X-Proofpoint-GUID: HGwWeS_UqNbQ2pSN6ZhTfC3GoANSsMFV
X-Proofpoint-ORIG-GUID: HGwWeS_UqNbQ2pSN6ZhTfC3GoANSsMFV
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac61515 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LEehXKFoqEHZ457G_xcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Register mips_exception_name() as the CPUClass::exception_name()
handler, so the common exception logging can resolve MIPS exception
codes to names. Return "unknown" for missing array entries.
Remove the qemu_log_mask() call in do_raise_exception_err()
because it would duplicate the one in log_raise_exception().

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu.h              |  2 ++
 target/mips/tcg/tcg-internal.h |  2 --
 target/mips/cpu.c              |  1 +
 target/mips/tcg/exception.c    | 10 +++-------
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 5d8b78a70b8..b080c5de4de 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1349,6 +1349,8 @@ enum {
     EXCP_SEMIHOST,
 };
 
+const char *mips_exception_name(int excp);
+
 /*
  * This is an internally generated WAKE request line.
  * It is driven by the CPU itself. Raised when the MT
diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 950e6afc3f2..9f230e757d6 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -27,8 +27,6 @@ void mips_restore_state_to_opc(CPUState *cs,
                                const TranslationBlock *tb,
                                const uint64_t *data);
 
-const char *mips_exception_name(int32_t exception);
-
 G_NORETURN void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
                                        int error_code, uintptr_t pc);
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0fead20d651..528d926d16c 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -742,6 +742,7 @@ static void mips_cpu_class_init(ObjectClass *c, const void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
+    cc->exception_name = mips_exception_name;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 2f02f9be877..e698def0640 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/log.h"
 #include "cpu.h"
 #include "internal.h"
 #include "exec/helper-proto.h"
@@ -129,12 +128,12 @@ static const char * const excp_names[] = {
     [EXCP_SEMIHOST] = "Semihosting",
 };
 
-const char *mips_exception_name(int32_t exception)
+const char *mips_exception_name(int excp)
 {
-    if (exception < 0 || exception >= ARRAY_SIZE(excp_names)) {
+    if (excp < 0 || excp >= ARRAY_SIZE(excp_names) || !excp_names[excp]) {
         return "unknown";
     }
-    return excp_names[exception];
+    return excp_names[excp];
 }
 
 void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
@@ -142,9 +141,6 @@ void do_raise_exception_err(CPUMIPSState *env, uint32_t exception,
 {
     CPUState *cs = env_cpu(env);
 
-    qemu_log_mask(CPU_LOG_INT, "%s: %d (%s) %d\n",
-                  __func__, exception, mips_exception_name(exception),
-                  error_code);
     cs->exception_index = exception;
     env->error_code = error_code;
 
-- 
2.55.0


