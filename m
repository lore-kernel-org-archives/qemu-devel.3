Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDD9C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiHA-0001Jr-Bh; Fri, 03 Jul 2026 14:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiH6-0001Ip-Pl
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiH5-00028J-6F
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:04 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiOU4494394
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P5A1RJ41oIlsBRfOfbQ9ZlZCMWw0H1WUWGcHvw5tK1c=; b=JdQksl47CAII/Esn
 j1AA2ZLwBLWaDCtOq3n+/f5YC15AeCKTrYtGAI1KVLQvZ/WEs5zrVGWLSE+IYgb/
 CQHM6qlLLPXoAycGQHhFreNg9nLj/6o/2C4WqRR0anjZDtkRHlb/Q63PB30Am26z
 Yq5JmDNa5jaLxTT1nkdPufW3cNezRszy5gEPVWbAkh1OEEXPWWckObZuHLibrp3X
 xxoHkuIGVPinvUmUpFIaOxqS4dihrHm1Bi0PCdwbK4sXUO5OvncEJHiOMnOTWYDZ
 iA/4qw3Jg+2xC7GCZ477xrZIFGalxeq2dkML0HFXq9DTePElBIRsu/fOLALjy1Fm
 mVmqvQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jyta0k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1852a86fso9208441cf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101959; x=1783706759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5A1RJ41oIlsBRfOfbQ9ZlZCMWw0H1WUWGcHvw5tK1c=;
 b=LQq3tmXpPcGuwApt8LAqJ7QBS4X/u4fiVvXCZQFjGoa0qrJQZOtl6v2y9P2H2v+yIP
 uXvgB9t03I4HzPwfvnJvhnmk5dbH+DmNLjpkJzT5vx2AodJ9FRq9oQZzYVnUIxEzV9YR
 P73BMAH0iLC+uPFM9vkHQYpzLYi6c1PvjVqlw4frHOzqXSYQ65TBiv9b9RlbVJCP2Hp2
 OxKsTLRCjtNHxDPtpsSKMehX34GdWvnH1cQzgBtEzwzPcVoVNUdaz/SC7+7M8xS29Ab3
 HrVa8Zw1pAAw8plY5Bg4AZCU8grZTE//xKCdNzkxyTEgRCiIFGHSmQYx2LDn5+DF83xU
 6oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101959; x=1783706759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P5A1RJ41oIlsBRfOfbQ9ZlZCMWw0H1WUWGcHvw5tK1c=;
 b=Xa/PxrxNgEb5uCRpmO0WdsDdzovKYPawGjypxwV+lPntDzyZaZcjfIQmoHRCbOkEib
 pCLo90Gg6s2CbgxUP2vjcJlAH9AmENLJ7D+yPltoWAaw1s+NDzVdY0igrT8xkyk2opJp
 EM/9/l5gGD99qVczWHRmMbEgfdbqdIXa6hciuP8CCxgC3HoCEHQss9eUXz6S80R1i1hL
 eSX60xCdAnNd0XPnarUUSdDiEzAnyvN++3yWkyDjarLEgc+cGbGxqfcU4AuWe+7zPM+5
 5EB2kLm7fqvU8hQX54lCcIpHrEPXs651o/wTM+gOWZ6VRKOdcdULgZhJ7FNhY9lRwm/G
 a83A==
X-Gm-Message-State: AOJu0Yx1G/0KhV3GMwm8l+TzMKu4/csH6bvcQ2RMLVt9hb2lMk1vUt5a
 YPo9ILi1e2iPoSXpRIwVaGL92gyvQUuHzvXDBd411tfl4H0LX9mSqPAihUQsSn+E1/A/foTKVyh
 rufTBeWIeP8im+ZoIXX8EIEV1jluTce9I7kgsXkkJPdCXSLHlLYhpgHcT+NIS0D+grA==
X-Gm-Gg: AfdE7cldVX8r/SimL6Qkw8NJj+zQ/lr7bk3678NlMtvdcNqtTcp9lLcNWv9m5LU/7YZ
 vmlmHfxTX+ei/MxGo+ps2+yMN/M3rEw+98mIIu4B66JfRrip9en2QKiIfMn4j/7m2usuhOwIXQT
 X2d79SoUJ8FAVc+Pv36fMvs9m34xr3je1O05IKBlYoQxqq+k2+iwHZyvifsjmZyiE2Pramo9iIc
 3PFKaGCiLPZlGKnvx7blHLoGLSQxGV1qzHvx9ZhWJ4JYZHJcGswzLt73E7OKfkOp38n/T0H/3g7
 tDU6s93E+tQnmP8Nw5xEPoLvVwlVtDKwqYrHu4pbGj7QgopD/57ltrGOkoT+7Cw4RFZ3Rh4Y6Hh
 0vDNM2vvQ7hZhfiGs3aCHjrIAr7Trhd1nbWuvlGCH3gFnWQ==
X-Received: by 2002:a05:622a:c06:b0:516:eaf9:f6f1 with SMTP id
 d75a77b69052e-51c4c1f62bbmr9931741cf.13.1783101959202; 
 Fri, 03 Jul 2026 11:05:59 -0700 (PDT)
X-Received: by 2002:a05:622a:c06:b0:516:eaf9:f6f1 with SMTP id
 d75a77b69052e-51c4c1f62bbmr9931011cf.13.1783101958598; 
 Fri, 03 Jul 2026 11:05:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:05:58 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 05/24] target/riscv/machine.c: do not migrate pmp state
 with kvm
Date: Fri,  3 Jul 2026 15:05:17 -0300
Message-ID: <20260703180538.3346781-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX8r9tWKHMFefT
 5V6B3vt16UFKQKcFh7h5rftFhv3Y3IdrmEineQTIRUzypN6FbSu1O1oB76YfPdVqna4pEvJ1Skc
 6JnO1hkm3TJ/2lbcosbaeyW4OAhptF5GORCAZoQid5uS9KHLUseeQsGKeoRbHkdmZo//0sgE7ah
 joYb0c9YEN84ShueCDlXZOlsWDbn0FcIqlzRXa0EQwCNn9Ze389YexS3sEpPWwEf0hgHMxltpZ/
 VAI9dIMxC7vTWE08XiTWQHA+vQsfGDoPuH6K6oKLazhpeuetv7nH3heTEiykiNwsXGcQE5otB/V
 W+RuNvRi8L+1lefbS+keUG+fn4+iIEICO9I1Gb7N90zIcvDsV8pjJtu8QEMf8kXCwsn9trsX4Z/
 VimRFvnLyKFMIm0qYJKj88A43HecqOKYOUqNI0rn2n2uaT4WNWXKWCXnMxxlGqUD+9MY6/nuFRk
 vZ0jfbq8L1VlOc/EHew==
X-Proofpoint-GUID: 44cYi3i9zskmIIkiqBCRc8v7TQuLpi-Z
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a47fa08 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2BT_W6hdZ_SFZ63FK7AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 44cYi3i9zskmIIkiqBCRc8v7TQuLpi-Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX5vjqiaPB0RzX
 0xH03wozZwDmsp/IdBlVFWBT1NWAfKjGyjUZS5mt1w7+xOginLUlxr8pOqzmRfeILa9E9a5XLRB
 GWTKQ560qm8xHOM5Mp3pi74qzcKebVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The PMP emulation isn't present in the KVM driver.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/machine.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index ba96ceceef..ef0a8eae24 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
+#include "system/tcg.h"
 #include "migration/cpu.h"
 #include "exec/icount.h"
 #include "target/riscv/debug.h"
@@ -29,21 +30,25 @@ static bool pmp_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.pmp;
+    if (kvm_enabled()) {
+        return false;
+    }
+
+    return tcg_enabled() && cpu->cfg.pmp;
 }
 
 static int pmp_post_load(void *opaque, int version_id)
 {
+#ifdef CONFIG_TCG
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
-    int i;
     uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
-    for (i = 0; i < pmp_regions; i++) {
+    for (int i = 0; i < pmp_regions; i++) {
         pmp_update_rule_addr(env, i);
     }
     pmp_update_rule_nums(env);
-
+#endif
     return 0;
 }
 
-- 
2.43.0


