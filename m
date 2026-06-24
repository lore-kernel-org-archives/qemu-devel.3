Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15D9CD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9i-0007u0-A1; Tue, 23 Jun 2026 20:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9X-0007bN-3O
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9T-0003IZ-9l
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK0wjF1177695
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 trZN2ypWOA+WyJb3G4pISP3mPY2cH6T3didQHTIz/bA=; b=cr5RnGF0HNKo0RMa
 dw8AFlsyQu73Suuo4GIbJQOJ8N3HifzEren0TMtX38cCMLRfZBrlCXXVmxvIW4rJ
 1EndXU1Hq9mwBkT3NmSb4XvRuZ3GIPP9l5WVxNQ5H9hK7derqg9m7DRZnfP2xSXQ
 yJ62ivWoLpFD5n1nA7nfpX8ioEwDczbNmtt3JEaAl+Kc22AOzJ3fSNscjU/7kc41
 U/r/KiN7zKQNtkbJNMUBCTKHjzvDYhjQ94vsP70TLYERHbDiD1LM3CiKG8ErXPbg
 Fp5h+bd0lZdV4rb+CkNb9Now7KQZclPTQisJ35LCfgfltbYso0AsPoNmnZw1i0Z9
 kV/obw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe6bda0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e0df2461fdso15070826d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259644; x=1782864444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=trZN2ypWOA+WyJb3G4pISP3mPY2cH6T3didQHTIz/bA=;
 b=MwmbZjmi/KJP87UFpNZw/2UL6Q9Er0JeCcOfCHnscSdkn+4z7Z+m6NSjyvCKfUUGO3
 jBEGGKOo5sLii4+uislMxGZOGcUZJrTadrCw7Le6CNVabCdiFiO82bpIOZ2Kj1jN2Jx1
 ndhfpMkSW2ozJd+nCjhi7ibbsyvOMShZw4oCmjLgNHM1LsTxFwue6s9m6oJTCN1/a9Nj
 +TALX8BusJ3/R4r9PZd/yMY17NCxVNyvVBGo0cPxd7XWi1tBGbxzeq6KlgV5NQATS5i5
 IgbA4Ct94ETXN3CXSlMJwczP3T2907jEDe9z/VBkw3tLaTeUaC4oMPNRJmNBr54P/5ag
 x6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259644; x=1782864444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=trZN2ypWOA+WyJb3G4pISP3mPY2cH6T3didQHTIz/bA=;
 b=QNAVg77wqfoippYIAgti2qMO+U/RvPGXJxf8g3OxcWbqO1KXYO4h5QVTRqnGZGjybO
 xBl3rAa1OWa1Tyfapl6nzv6sE/9rD62r/+idP5C7/xITFEqdYJj18khiKlTymQDYd6G2
 rToeQb08fLoELnvipSPDQZe50wRtE7fS/h7khTRySW4QaNZGHCyMd2gFOvRblayYjT/M
 vs0CunJ3DWm/bdmbEp3upx0+2OoQVjWiKT/YpI9ro5zHfOPyAjec1OYSqDlu6dzpfz6l
 B4AOfltKn79YfM9kyw3nnFGG8kPHmUh/aq2ALWq9RRQPCathTSRzY7TcntwPSdtayioS
 uSdg==
X-Gm-Message-State: AOJu0YwQRyEpvY941Ke6pDQX+Hrgn57MB7dMtLc0ZU34sbIjdyIQKZBH
 PpFS+jmxv8CCpDnJXWjhVsZ4tiDJotiRXWZC6UkeQkBq2nhHyxjg2YaEalFOi/MbpDLaKO50w+c
 QIaX/oBd7iN1S6/5H7Sl7i6a2onyB8dmrdAh02YQHER0gj0k5b/54DJLiLex7utKZew==
X-Gm-Gg: AfdE7cliUWoVKMzu18eAUzMWeDceyAydSlp2lPZsX/ZdGjICno3giWkiGJHlF8j1CEQ
 qXuQLGl2NQHn/w5x0SSvYMpwdRKf3UF2iL0OZGa/tb9t+N86W6btTE/zjnH7Yt/bpSQhyFUP+jc
 eq31XKNmH90WWEiXDDc+8V3EmSeNYM+sfXYKMBcK9ZLV9um5DyzdRxj5psbUEPWrDZbpvoUcxnu
 NKfO00UPADICiYvG4eVnqeAzPaxx0a0OhLGLlevVzwDJ/38X8pOV8kcNb4Aii0DhVABgSY641jq
 qUR80HxOH0xrysXh8PkgXoxZjwAlzzdLV6wBPTo+oAhkx7OfuarHeX73KF8PXL0iGoqHgRN51FB
 vM9LU+ZreY0R5x6Akw4n1zZJbQT1F+XYloQrQPfqiC5hWRw==
X-Received: by 2002:a05:6214:55c8:b0:8c9:c38a:20e1 with SMTP id
 6a1803df08f44-8e52df964b4mr21214426d6.10.1782259643561; 
 Tue, 23 Jun 2026 17:07:23 -0700 (PDT)
X-Received: by 2002:a05:6214:55c8:b0:8c9:c38a:20e1 with SMTP id
 6a1803df08f44-8e52df964b4mr21213776d6.10.1782259642964; 
 Tue, 23 Jun 2026 17:07:22 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:21 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 14/24] target/riscv: move riscv_cpu_claim_interrupts to
 cpu.c
Date: Tue, 23 Jun 2026 21:06:21 -0300
Message-ID: <20260624000632.2149359-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rsioIlyEQmcwFycsA-y5xYkN_qGrN4qD
X-Proofpoint-ORIG-GUID: rsioIlyEQmcwFycsA-y5xYkN_qGrN4qD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX7F5KctzKmU3Y
 1eQl2E+aYT9SxqQNMiUmdMB1x9hibtT3ziK41R86k4YldxMfYw9oAhb/1JRgVSD3tkzIbP/kOVx
 ckE9iD3F2Q3lswNhSf8oGw4yTASY6Qw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX1NJ1Xjhlanun
 fqC/+wEU+FPpn/EsscBoErazVYZCodnBvdKA8XnTBi7fwny92L9ahtYTFjgGt5boMwicpgn/UUv
 b/6LILFwoAT3UynExdbkeqD18TBWWiBHwZf2eN+UpjuN+vCpzgJye29Q0RzP5I3jAanNXxl24x6
 Kf9T5+yHXAb+jH8WUb6J7WQtJszZ4+cDYMCpT3Sdu7Z8NEGvQV6lk9Vof5p31cQHABpFzWiD68T
 ZvpLWo5VaWf7A2in3EJe70EB6HbxSWwjUsvjVuVGnLgqPKQIIO81mRBVeOzaALDYH3viAR34q11
 vtBbMSiu0gkF7+GPPtOoOgvGvD1tAnJj9Dfrw58aGcQigfovuPCWdRgyKiu2tsJT0Qc8Q2bux+h
 8HYz75qZuGERLAzh/K2w8otjL/7rg6dTTX60iwyCE8R5i1dSyhDLv9CQPADM2Dg7y5LhkeK2toN
 Y/Q4ROSl6NGTxqEPsQA==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3b1fbc cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=P7v9EdgfUgEVytVI3b0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The function is used by hw/intc/ files that KVM cares about like
riscv_aplic.c.  Move it to cpu.c to be accessible for --disable-tcg
builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c            | 14 ++++++++++++++
 target/riscv/tcg/cpu_helper.c | 11 -----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 483ac2e0d0..4fc0ee2823 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -566,6 +566,20 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
     return rval;
 }
 
+#ifndef CONFIG_USER_ONLY
+/* Used by lots of folks in hw/intc */
+int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
+{
+    CPURISCVState *env = &cpu->env;
+    if (env->miclaim & interrupts) {
+        return -1;
+    } else {
+        env->miclaim |= interrupts;
+        return 0;
+    }
+}
+#endif
+
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index b38f639dae..9237d2129b 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -572,17 +572,6 @@ void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
     }
 }
 
-int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
-{
-    CPURISCVState *env = &cpu->env;
-    if (env->miclaim & interrupts) {
-        return -1;
-    } else {
-        env->miclaim |= interrupts;
-        return 0;
-    }
-}
-
 void riscv_cpu_interrupt(CPURISCVState *env)
 {
     uint64_t gein, vsgein = 0, vstip = 0, irqf = 0;
-- 
2.43.0


