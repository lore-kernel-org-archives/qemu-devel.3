Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CD9C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiHY-0001XB-63; Fri, 03 Jul 2026 14:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHT-0001Oy-Gf
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHR-0002FL-Rx
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiZeY676632
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gmpzB82DGE/aV8td0WaB+C5BqZ48rvErCbJFfP3xpEU=; b=jq2kjoYyCXT/nlw1
 HXf46B8lgT9I1eLuchr8JYRAV6+liqy8O3C3wHxw5ehnlHxBUpSjVQWNeI/P/p/i
 CmS6S9p0yQqMktRaLsRiQvs5PG4dYKdA+0PBkDg426mZwxlknE2kpduXZJhPFm/O
 yyFsdG1ki0FwFkGF3+XrWFBdgj7Nb+Oea5grbn1olo+y1unBnd4JmTP33XpKY9wU
 2IVNysPxQHQENsMkiiPMbRQsXWBRYInJvLm8Hvutlt2SWyiCGemoUtNICjRqQQup
 Cp45KIj+9ZbaqQ6l4zpls844kwTVCtp5hDHGIGGF1JyeKl1+fJ2BJcV+ZoFFOHJB
 MGOHYQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkh04k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d30035dso6847111cf.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101984; x=1783706784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmpzB82DGE/aV8td0WaB+C5BqZ48rvErCbJFfP3xpEU=;
 b=SG3FyDKPEr8kjyiVltEBljsmjAmfUJ3PwjdbirhpJrsDxMODDUwlsCwxObnB3eu/dj
 uT933U7455+J7obSE7a9CRynJzP8DY9UM1F5K/4qhXVdBqon3mhZCNvUaJ1xOldMIzD8
 Y/BxiU2W87d5Zliqmq5pgx4ig87lUuOvKLQrwr5xTzSK5y3IYWJAQj+zKCXjjhE3jfsq
 q0h9sesU1rFJIGCh86Qc93TLQhhhUnV0k3rsFAO1mQPyvtnAv2gySdPamR7Rbds2rMT9
 r767dYonoxANspApDr3XAHs/bbvHurE9UJNtHa/645ajnyYEJrG4kUoemh98Ab4YPWn8
 tjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101984; x=1783706784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gmpzB82DGE/aV8td0WaB+C5BqZ48rvErCbJFfP3xpEU=;
 b=oZayAECtX5hoUcOMB7VAQfu5LaEa9y6XzRuRSMr1UM06P7HWJXw8F7z/FcH95ldHKc
 woyWvbGEnh/q4Sk/GA5C3Fw1Uwu9wPuZc4V/XqqAQWllqpHbL3OM2SyKn/g8u8/gr5lk
 NvXT1rsrxHQ3ge4kFeGozEQ96aL5O5I0S4S6YNRodMeYPfIE4bZSPQiAhJHgz12AhfzY
 7I3Hx97gMZ9AzUY3lMf8SkroTyLuK1CvvMGBB0MsKipgCcd2c/VzXIE4Y8U6p9A9iz3Z
 mo42qiUAozSGZKh/PX+go5wppJGYnPDE4ZZexIkAS2us6rgXcaH0LnXc81K7jzxnz+SN
 gmdQ==
X-Gm-Message-State: AOJu0YzkoeIG6nQ/fYBIE9mCVHyY5Q6NW9aZw+7dXgJShS1cF9eXDPRr
 ooaz51fTwtb/9ceQKdoDvkA2altfkONOnMi1xZNu/FCUW+jHORTOm5KjkEmjnykwPZ+7y8WRRCe
 ZTFaKRjzOSnaAa9qm3R+DhLgIo/DCAghxj6NuqfHkJHDzyCtPi7p2LjpPrRayaHyAKQ==
X-Gm-Gg: AfdE7cmMXbn5gQdaAhHuVzSJA3rC0vnwUfrolrvvoqhGqgKKL5BVx2GSlQ6TN2PYx9w
 0PsSkxHduJwrCeE54CcSm/JoEJDy+vIFlzyQN7TGrAbRPbnV+nULAF+5CWppdwcpfrDnJ6e77i8
 wz5zDX5trmqE5vZiogNqePhGOe4cHaBMJldubY+jEZyGhV4tZfPhKVYtNB4hVrkFQRhvgyQywPe
 T/6Uw9aD7q9dKBgNsZLut+ThM/q5qeR4YzFqEbw3MiCTn3NS/ymloGtynmAeOWV/qrhJdz6SUpn
 pXhAsZqr2T5zGD0pJy59eqpOm5YjEoesPQFhImuq0ZnJOCXV/4TqKYNNsJBUyWEBc5iiVPzxtwJ
 5QupppRBSOL7bNPC0OjMZa/t6z1z4/+1FMKzNzZNJRFbMpw==
X-Received: by 2002:ac8:7c42:0:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-51c4c2c3d9dmr8489751cf.36.1783101984094; 
 Fri, 03 Jul 2026 11:06:24 -0700 (PDT)
X-Received: by 2002:ac8:7c42:0:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-51c4c2c3d9dmr8489191cf.36.1783101983629; 
 Fri, 03 Jul 2026 11:06:23 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:22 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 14/24] target/riscv: move riscv_cpu_claim_interrupts to
 cpu.c
Date: Fri,  3 Jul 2026 15:05:26 -0300
Message-ID: <20260703180538.3346781-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXzxOjzKGIFPWK
 vExe6iyrq97HmqbRJLc27aIiBGx6WIv2o9snwMxReZ1rpj/fyGQUaTya/xQAM8UEJ50vc5aVkep
 feiNPhxxbMZbstlRIHayaO/8LD9KrnZPJ9ESVASzhsk85BOmP6qH6JcmWjSoW0TXD5GHUVTG/d+
 h/0jlBAdTOebt6zEd8gCfhezCVSSU7pViPUckjeq+Tri2/z1Sjwdpm4qti7q4oqkJs83WlhThJv
 AXgTyKOuH+WrgZ6i/Fg2+gMpRovSY4uSt9CWsKDtvRvctTIHyb6cciiOQbi/CoFHR/dztDwpQeI
 EcdueO4S/YRACmJCShjjQUqDbxn8n19UVQaI5/+0SGLnLBQ3YTjoOozycQrEkht2EPRb3gRwkB7
 EXOMPHsy3WWqzL1tDp4OI/Kq5Drng5EFSQIRpYca5tHKjsDJHY3Q0eFLHk1wrb+1BnSXllHQ71a
 Ba579Fx2gkDrUIq9MTA==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47fa20 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=P7v9EdgfUgEVytVI3b0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: u-WoIq79kRSMaFQz6vLwuY_X7i0td_jq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX6sCyt/wB7C2k
 iSxA5yShUksrR4OaY0Rf0ohwNMtp2XnQACuUi2qzs2iUxKv9xxBhadaLaiovoJ5/uF+6PBWSP8K
 N7Q5ZyA8ig5OWe/qIjRGdnC/RXvVBHM=
X-Proofpoint-GUID: u-WoIq79kRSMaFQz6vLwuY_X7i0td_jq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The function is used by hw/intc/ files that KVM cares about like
riscv_aplic.c.  Move it to cpu.c to be accessible for --disable-tcg
builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c            | 14 ++++++++++++++
 target/riscv/tcg/cpu_helper.c | 11 -----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe24751379..2741047769 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -573,6 +573,20 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
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
index 250bb20481..aded995a7f 100644
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


