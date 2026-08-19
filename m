Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C6BC5DF8A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhk6-0000Ek-6g; Wed, 19 Aug 2026 10:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjY-00083o-Co
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhjU-0000Yj-G2
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:57:38 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEboYD1117516
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vEFHHeTIxEhuVUgrc9S1ujCq+0s2VQXIEqucZAX5rjQ=; b=E885LpurkhrSWliJ
 YOCaej6n8W0jHUIba5GukgRno4gjErB7PtOXBIVodW7H9LStj1sb4HE6UYKEublv
 cqtkdFWK0zCxSoA6pWo+7aIvYAH9dTNuG7tETnPTAFWFYNACgHxksHx3yT0krAmQ
 bDDDOUNrfAREbloPS+ex7KalZ2dCaOzAgvWoMpVwOr/a2+IKVlzmpo9ut6xQdWOo
 SBPZ31KU2OgL2Zg80LXoWdeybz/NAcLWgJoqeZPd5nD66ixW2HqRgaqXjAUDSJYJ
 LSgsIMqi+P/bH2CsmhgD+0jf2jzNhZXx3GJok4v2bA2DOkdAJpmcAJjD5vkTNyta
 WE8ZFw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfpus38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:57:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so120222685a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151454; x=1787756254; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vEFHHeTIxEhuVUgrc9S1ujCq+0s2VQXIEqucZAX5rjQ=;
 b=f2wbWR9dyHjQalkfCHAqJGk7StLdDt707AtHl/ezlUDvvtfyQOKqvFDjun/0I/NO6c
 pynEAogq0qg1j9g4bq3SldDJrgaXgxEiXkow56tobL4BORIF6ZHOFf8Os8Fcpvs66I7K
 AcajXVgAX6LKzn4H0G3xvrPxXBt276IR/4sVISCnVdJISdbQ66NnduuvubXQIffNhHqO
 AmeVMVpxWd8ga0e6bSDm5pDZKWrrNW1i4ftreR5u0BCORfdlV3M01tUSnrXC26Gg/WyZ
 OAuDoRf80iG98b40/ThZ+lnJDFjBamNpFOhcU+e2Nk1vSxi8mIVNvR4PoGGpLGd1ynF7
 nWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151454; x=1787756254;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vEFHHeTIxEhuVUgrc9S1ujCq+0s2VQXIEqucZAX5rjQ=;
 b=Z508l+kPCv9ag3EHhZUY24P4ZoE/l+P3mocQhIFJqHom8rKe/wVYQmz+hLLPCm10VT
 ZaYeXM2L+rOF1zDs9U2BtTeuVV3+VCaYefbwc27orD8NDSQoBzI2/J1Pa0blXc5rMC7Z
 AWQqi1uZpViEfJywxsl75io6K3amPuiSUVZ4xo5aFJWrz4hdS5TULSOPInGDPuOZOIoH
 02fowzl6WBaXQeJHGEdVDn6QaRpBgxZleM2npfZcS1yanFk/wTM7h0gvOOxQXn81SEpc
 beDTjA3bxUaXJdDH2uxWDmSG+4W/FzbdTSUiMjvw/x+a1gHq+zEo0+V2BUvGcatL8L9a
 5QdQ==
X-Gm-Message-State: AOJu0YwmB0EzF6+am6sfcj93yfpeRJPu8SkZFzJX6YccsUGGRnfzV6Oh
 GuVpPwujciphNa9/W7zMhx0aAwz5gpq2zsiQGgC8C/RLDOoWQp/q5Mkzl3rkjfYlHZXQIEAaJfo
 rBR1dtW7SkCAgNBek5+i5z97t3bhAPh+hwPjbgsl5iTHTnMEXsgAplr6MejXZrk6d3hjC
X-Gm-Gg: AR+sD13sh4vEe3Fth37vx3xj0YY+SZRp1TKcPvYu8cLIZ97MJNk5ws8KJtQuIgzapiy
 3Z4OPlP+QNx5NEEhG0e6r2W9y/STeopvaufYpdXGHoEL4SOLQqXH3RwJUtpoGuk416Ya+rzIJzQ
 dEaWwZY++tuyR7ctGccIFAHXZrUyM4Pnak4AKuKsmhIda/IvfsWnfclDAU+su3SDXate/CsPb6q
 c4U0PP6I2egVG/IIq5eT3eyF3y9bMjS+1nlWUO3BzbAJBC64xraXm0q3Ffa9M+QOArdtd2WqJgA
 PoE0m/liwhPkwFR88oNhHACBYTG0TaKFnAJmUNgkt9/E14Ic5UlpMvQyPI1bDDZX8b2xNNORWEY
 oRUrKcvYLQ7nONreGWVAE2MlArt4w1OWpiS8J0DESgA==
X-Received: by 2002:a05:620a:40d5:b0:92e:535b:e08b with SMTP id
 af79cd13be357-9371e440bc7mr457080585a.33.1787151454014; 
 Wed, 19 Aug 2026 07:57:34 -0700 (PDT)
X-Received: by 2002:a05:620a:40d5:b0:92e:535b:e08b with SMTP id
 af79cd13be357-9371e440bc7mr457076885a.33.1787151453541; 
 Wed, 19 Aug 2026 07:57:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e784b3sm58282045e9.3.2026.08.19.07.57.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:57:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
Date: Wed, 19 Aug 2026 16:56:44 +0200
Message-ID: <20260819145649.23439-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jTfzGIro-uV2tEMEtNzz-KDkTVTxvWEC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX9Ezafu618Zka
 os61qgBbd8DH6FMiTnEL4TCZQw0JGJ7tUGxfRWouORcQC/Vpwe/MAjI5/jwRZHFjrSRwU6lNt72
 Y3dGxcO4f1L8ptM+otX6EO85ZRqENKv8yh+B6KMRAzCoqBXFvccphKIZJxUQfr4vwcLtzDket+I
 47O3JI1rVvY6ea06RFX/LeQwl0nqxLwjKENkO88v+oF1heYuVjsEkRGyJTvCDXjTEuGRmhLXT+u
 45amiyuWwTRWZ7GxuSvQK1iNd9X/8G7YquMZr6Toj05jZN3Ike8Wt8l3cCEAxD1OuCZEO2Xx+E1
 GPtpQtfDkb05B+Oz/RoBFYyhDJ+rjf72RUtlSasgAfTlKdgpSyBjhtlOf9joifyvC+i+JUgZzto
 aSloDhuGtrhotG3IjR1yB3flAVsuvn9NDZL9a676nYEggfcNaKW2dpnrK+fiPKiwdlKuqbwYvVP
 86TZE0d7zlV0zkRf3yQ==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a85c45f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wZIYt5ari_EcBv1I3vgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: jTfzGIro-uV2tEMEtNzz-KDkTVTxvWEC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfXzVPpuYBoA3l3
 9uJJCszq2OWj6GU1092Csq6HrfdrhLDE1rXNp4fPa/6PR6+HXD/XFRWd+lzhIBMsWHYS+sBM4ka
 5Um7Gjm+mfx8o4w0xuKDicfEo80ej9w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
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

Refactor the target-specific halt-to-execution transition
logic (disable WFE/WFI timers, clear the halt_reason flag)
into a separate arm_cpu_transition_halt_to_exec() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/cpu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e2..8e9b584559d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -870,18 +870,26 @@ static bool arm_cpu_internal_is_big_endian(CPUState *cs)
 }
 
 #ifdef CONFIG_TCG
+static void arm_cpu_transition_halt_to_exec(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    assert(cpu_has_work(cs));
+
+    /* We're about to come out of WFI/WFE: disable the WFxT timer */
+    if (cpu->wfxt_timer) {
+        timer_del(cpu->wfxt_timer);
+    }
+    /* clear the halt reason */
+    cpu->env.halt_reason = NOT_HALTED;
+}
+
 bool arm_cpu_exec_halt(CPUState *cs)
 {
     bool leave_halt = cpu_has_work(cs);
 
     if (leave_halt) {
-        /* We're about to come out of WFI/WFE: disable the WFxT timer */
-        ARMCPU *cpu = ARM_CPU(cs);
-        if (cpu->wfxt_timer) {
-            timer_del(cpu->wfxt_timer);
-        }
-        /* clear the halt reason */
-        cpu->env.halt_reason = NOT_HALTED;
+        arm_cpu_transition_halt_to_exec(cs);
     }
     return leave_halt;
 }
-- 
2.53.0


