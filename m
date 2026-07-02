Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E26EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHqN-00035v-9m; Thu, 02 Jul 2026 09:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqF-0002uJ-55
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqD-0008HZ-J2
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:34 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0WlE416409
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GSjWbCL/dirhcrj5dWYYaOR2XqQ0JWP1BRKckTfPwSk=; b=BuFTeSGbqlg+iJ66
 V+M4yj2yPz4WzpefgJOI27ohX5wxFV9Ap91DA0EAXTGywkgbbQoUDwmHWzzBsQtL
 jGVpAlbyei8SIa7oNZRmUxPyP1H+VnrC6ieURYxRzeQddKC5luDm2dtNVsL/Yk4+
 EAN8rqAItl9bGPUmP0V/IB12jb1ZEC6IsoBafwhqdaCWzlNMTt0CVQI93t8VaxOr
 shJgFmkSl6aREZlvpphRLxdF9RFaRpPxo8zeFa1zZzsTRMIS8XKiiAEDLTgUFpQY
 P+uWoYG1SJp0bphBcmG17+0PJ1gKyxSBpnz1+aQy5OWQiXu11ahgqvydCQDssuD2
 +sQy2Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9411y4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:32 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7377e2f1a62so741014137.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000351; x=1783605151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSjWbCL/dirhcrj5dWYYaOR2XqQ0JWP1BRKckTfPwSk=;
 b=cA2TKM/rEpeolMghIL0IrfmW2JzTA98vIz2W3oBUuZ1+fDG2m5FxZHrIjyP4If3XKT
 XX6Gq10cBClBY0MkmSjwgAjFRuLQvv2RPjUDwgWoe80Z2wL/ByjRwokxzvGqL8wrpDHW
 NOCHh3gVh0ZqPd6Go8zLNMZ7kT247CFyr/B4NbEW10St9q5QwoaMA7BQm3nZQ3qSZH1e
 xWaHSu4p8kQVgO2ncX7vY0iNVCR5Im4rpcUO9mA2u9aKdQc00aTxsapMwzXmug29SmOv
 dmU/4bCNCxutmZZELxywfoitIA8j0r2Zf9fqk0TDQp9FhlazoZqjAnzBTGS9V42jVyIL
 uoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000351; x=1783605151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GSjWbCL/dirhcrj5dWYYaOR2XqQ0JWP1BRKckTfPwSk=;
 b=LXW1DVovx0ZpoC+Bm97ksYpDPAKUhyrbuIrNDS7K42JYxk8RoNznIIrfVOo5OoDAo4
 Fp1N9S8cloJt7zcz/1scavP+QtBsekiW4fGAvuvae/+B1zNQBI9VmZ2aaeR1oVUoBvm3
 +gZrmh7v41LbBay5chUVA8nYAd+AsNL+/8ixj0EBoPq1uQ4MyypSEYGtiu6bQ9NA4JsJ
 tcgmacts6yZVAVHXxYVOpamgrENMKG8eBD5NfHgRyimjI+A2FabkW8+zO9KiYZDhuDQy
 3g3kipUjFsdozlC1yo/Dtc+i5L6vL0bwZbPGnP6UCN+QNDkyOIuL8CJC36HAvD6kC4+O
 IqyA==
X-Gm-Message-State: AOJu0Yw5QcSeytglBzEv9yH+9pKSbAMv+5bwbGYq4FUTHQxrHbssCd5S
 ImG6kwaaqmQqFt5HcmY6+UyvMEnJ2k4JggU224qLPitPJTXoK2NKo+YCP6ckDVS7NgUh4qJZcED
 RGRRuZm1LD84zD4AUGieL2Dm9VmBGZfNZPAyvctC6p22iVUcIfvsmbDzK3EVYCOSyng==
X-Gm-Gg: AfdE7cnWVIHP/IHaRCQ61Smq81Y2OVzTKgFGFMcWWzTvmi+DxpRfcz3LzyLu7wxoIj+
 BGsas8a2OzjXSt67XmgKNXOvskidviVKYiiIqcubq4nGyN568QzR6+pUIYVgqWD9g2GvvSTJwD4
 KPmHQRTWZpRryw2J4TH8oyU1xPjSRYXTxTZfIbyMDiicRVnZaLfzgCBpXP12EG295VrBo2oteb5
 KLcOT9PX+x4qIE1lXOFmacIpjEeDkR4SZm7rWbK8kHsS3Mz5ZKfD/dQcbe1QzzX16nLLgt2Y/6o
 wH0CNNASGNbqFzibX/QHc1heSwzjlyppf5Wvo9E46JtvJbOgn0N6hHm4f7WbVoSr2bEQEr9jljK
 L9dK+RJWXtwUysebmoj/CIHgTx0O6Wrispf87Ma54S9JIOA==
X-Received: by 2002:a05:6102:80a5:b0:631:2dc6:2f5c with SMTP id
 ada2fe7eead31-73dba87f7fcmr2338901137.0.1783000351078; 
 Thu, 02 Jul 2026 06:52:31 -0700 (PDT)
X-Received: by 2002:a05:6102:80a5:b0:631:2dc6:2f5c with SMTP id
 ada2fe7eead31-73dba87f7fcmr2338887137.0.1783000350537; 
 Thu, 02 Jul 2026 06:52:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:30 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 22/24] target/riscv: move riscv_cpu_set_geilen() to
 riscv-imsic
Date: Thu,  2 Jul 2026 10:51:24 -0300
Message-ID: <20260702135128.1188021-23-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX97fWPou9bf6x
 0RR/JF5m6uccqJ4bRT06ym5XmHifbtApBgs1aUQupCBJdgpVXzgpKbLLyFnDyVtzGDGs8wz4D+2
 hDX+fnFo82D8xK9XMc1SLG11JPdPEn7f5xZpBxQBMHFD8S6QUQmegWIo2veul7dp/bq3XFL1vqw
 +pE/GiS0nr/SRrIsOf6YqQqwXP16nxhdTWIEA77D+ES5WHCJFkNfR4WA1BvFK7sBIeb8xXny2NZ
 crnLK5I8pEmBaDUVcLVCh7WSjtUIrZc6UKY/DaeSZ4UxZ/zAkktY7eLQDm/df7TpQu8spFlabzh
 w6coJHONRfO7/Erso2UT9wdSgxaJd0ehWRPf+LNo5LhmgBuyj6Rh/Rj6BzfENORSRif4kiIx54I
 rvSwH90eR1ra/0etLv3YJniX8EHqtQHh2db1GGXUUnyl3FlzUerreGPqeA7X94SV78RDROSSxnl
 Jsg8n60tS9yUWbteQ8A==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a466d20 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Lr_FLp39YrF5VQqdKKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: DplXtjD5bXBE-0PpLH2FTcTmTPpWbdrL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX+LkJe14FijUb
 IMVmBAQwl9u8yw/4D3m+nsiE8wnRJ5FIw8Y/nZ7vlq0y6GC8PTzkU9UdWaAh13i7Hp5SyvJcZlV
 dOIEKYh9O1YD5zHaHr0mUxDJ5GgEtBA=
X-Proofpoint-GUID: DplXtjD5bXBE-0PpLH2FTcTmTPpWbdrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
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

riscv_imsic.c is the only caller.  Having it sitting in the TCG only
cpu_helper.c gets in the way of --disable-tcg for no good reason.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/intc/riscv_imsic.c         | 13 +++++++++++++
 target/riscv/cpu.h            |  1 -
 target/riscv/tcg/cpu_helper.c | 13 -------------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 7e5b5349ba..ebb55191c7 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -46,6 +46,19 @@
 #define IMSIC_EISTATE_ENPEND           (IMSIC_EISTATE_ENABLED | \
                                         IMSIC_EISTATE_PENDING)
 
+static void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    if (geilen > (TARGET_LONG_BITS - 1)) {
+        return;
+    }
+
+    env->geilen = geilen;
+}
+
 static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
 {
     uint32_t i, max_irq, base;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7618110412..7a4d8abe07 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 6b39152ee2..71a96a20ef 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -526,19 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return;
-    }
-
-    if (geilen > (TARGET_LONG_BITS - 1)) {
-        return;
-    }
-
-    env->geilen = geilen;
-}
-
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.43.0


