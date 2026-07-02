Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F402C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHpy-0002Z9-R3; Thu, 02 Jul 2026 09:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpw-0002Vn-Ka
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpv-00088h-1B
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0bST519002
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eCj10TcGxJDxmWKwE+fQonpl/vTj71slp/maWFMD+s4=; b=gkR6cO6l4rPsf1av
 Ha/HhSpHwrM6PhGmzi5kxhchd5xG4HT1R1lxzzBXnRQdYukd7mdBL24aEtj6Nvik
 IZ1aWtnJtRiegXbi//NWI2j0KWNdtJIul1of1yrhal4NEZJOoGY/ynDqj59f9iJE
 QjykatPqu01fXkgpckNt2XcQV/Ktkq89fewZb3ace8wAYE8Sqt7OmPfipH4GfIxc
 GfNgZt4gzksW4q91o3kacJxEyuHWNjcUPBRdGDFR0u1sNb+W3ySJy3WAm2ZUj9zh
 qvkha+uWSAuXZA64ZsbHF0TuYcdOAhDOk2ZE3jf3LtmKS9aU1lI+w4mYieWBCMS9
 BpsNFw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnp8euf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:03 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-963b099b539so626042241.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000323; x=1783605123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eCj10TcGxJDxmWKwE+fQonpl/vTj71slp/maWFMD+s4=;
 b=HbnM55iNyvYC1OpoSq0hJ22L0GebOtL0HXZYe6CvRRVDNtG962CM+I5CAvRrm4H0Eq
 Uk5HFnrqFjhFdWJHdE2WA8z1kmtRLYrBpUdhBQcIn1QnvF3KAlwQ8Hymsdzt7/CZQiVu
 Iv6HeoyewZvng/9HuMb+R+ax7SvirVKjNnfBZi00lelj+sO4JZMYgly/bsCX62xoh+yw
 hGmxntt00LMrmtU1GLTKymsfiLoADb07fehZD/xXNFLqNgP0M1UMFBfK96eA0ds2r9Yd
 +nafiWnfc05FJiEepGcC71uYTXvMyvivkDGXUrsz8H+giv2rLymxkQWOxZWZN9AQ8wt9
 Bupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000323; x=1783605123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eCj10TcGxJDxmWKwE+fQonpl/vTj71slp/maWFMD+s4=;
 b=lg/XZYr3+juK3w4Hw5c9I/FO5DGodUEn4oNt/mSAf2Aa6mW6ye9XhofMfA48ZtfT5J
 bL956Q18+LsiAzbXJHz58wR+XcA9u19d1Pc6qCsh1Z9aYpM/Ep6zZuREL8oMmEnYZVzu
 TSMEJ5T9hgtgPIR6YRqhLW5sFVJLsxe7E0S2S6ZTDLidox8kqjgJHhqJGf8TvCDx5Jc1
 MrR/Cu17+M31nDbxfI9+RR6BkYPQXdnhRJI5t95XWbhgxgowImG6gcPx5gmIoVQ5p83R
 GJXrKmZyu3a3UMnUnr2UfVrMtDpEBY38wCtLmBv3bs2oAid8cKsKTizmHMiOox7HcmUk
 RtIQ==
X-Gm-Message-State: AOJu0YxzCh9TlY+zmUczEAUVQFJuE5vR0n7SXt4NDczfb2tQBHa/35ix
 hPPFQRGa350j63xkq+TdGQfuHgqiUkPSW71cHJ7RBSuEQzR9zFYQqRSTyU0Ij5jEc9E62WDQfjj
 f7BEliFRTcb+7YdWMWzWxdIJeP8uomxAts/DJNFMrTHgCqBIUBefCT3g/4nOVfm/x9g==
X-Gm-Gg: AfdE7ckoK6SSjq2XxJ6xyN8qek5TRP5Uh/zGQtcsxn/TScAvQRSDZltvBkZWKrJyERO
 EI1mhmz1WOfkMyQifTxEDY35hvxcC5IWpetT+wc1M22fRM8N5dDmMh9Av6/JRtyo1S8NeonLKrf
 m9H4wzt/UYhpqoQDgDmPVns7yVNwtR7nrw2Uvm6oXIhaxT8dLJKOESXxztLn7E2x1J/WFQbU71H
 r0Tfigoo1diuBxbxjHwVQ3eE3a1TXhmwS4SY7lCryXyYIdXkXObVdHe/sm8+InsrIPfDkzoAZPJ
 s65M6xLpbwaKOM9UizUj+EtlVNOUdWclZrVXPA5slASxz2uBosKsIPPD8M8pbsQuMky4rQNGXAL
 ZdiDGuCQiQWrA5SwkZ+uNbkDcmrlHlKyn4bsI0nsU9FZUvw==
X-Received: by 2002:a05:6102:f8a:b0:738:c9e1:c60 with SMTP id
 ada2fe7eead31-73f61aade82mr2601137.0.1783000322740; 
 Thu, 02 Jul 2026 06:52:02 -0700 (PDT)
X-Received: by 2002:a05:6102:f8a:b0:738:c9e1:c60 with SMTP id
 ada2fe7eead31-73f61aade82mr2591137.0.1783000322356; 
 Thu, 02 Jul 2026 06:52:02 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:01 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 11/24] target/riscv: move riscv_cpu_set_nmi() to tcg-cpu.c
Date: Thu,  2 Jul 2026 10:51:13 -0300
Message-ID: <20260702135128.1188021-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX+BrXM1Wgpc1e
 OuKiQC8Mu553PFRqDDDOd29JlE/d6SKDkrAriVGb2UzEdz+Z0JiLFv7fFppF7FkTpDofWvFk+WN
 Z+/3cwCKRCKnqGT/4UL3gBduGXkiFKM=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a466d03 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=9Y5uhDEGy_uPjlLRjCEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX49k2psMAy0h4
 zadRCMwgeJ/htZSLvgQK47+AetK8+9CW9uBHMMxhpYRM0joK8ORBBF2eUYfn96pz1HhcY5SMRct
 tn3Dz/E6gKg8sY6Pt4Rs4tKdKtLq3/pWnDKI1Wghl3PV5EEsAm98n4XM7B4G8Ymg/K6AYHP09GP
 5Cq8ofu7ZHQlS3BF7LK00ORJ4bix+q0uQMS7r1eZB42ArDTLHjGIZK/Ao9k9/dTInQaGU2ctlA6
 udTeSL5AJTxrTZHmGqcS/LajqTJL6sPDUCH/boMDf1SdHhxSqkhnwWFssh/8dndAQmiFp8uh29Q
 TeOgN23KbFfv917ouOEyemArcLLgp270jYbjEvxE2wbxQNblwTrvg0XOnPSQVszWdQIIReX1Zdu
 m0x6rZGCgt3DE+MxP6nAgZOME77SiecKrVkQ2cTOhs8Tr55NWW9CHs6CS0Z/YxR+5JiZ95/c70T
 8TJYGyLca2/FPJi3Pow==
X-Proofpoint-ORIG-GUID: VsCoUckjL78gkP_KcbM4tEU8XgXq_Kvr
X-Proofpoint-GUID: VsCoUckjL78gkP_KcbM4tEU8XgXq_Kvr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020144
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

This function is related to Smrnmi and non-masked interrupts, firing up
interrupts via env->rnmip from riscv_cpu_local_irq_pending().

This is all TCG only code.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 8 --------
 target/riscv/tcg/tcg-cpu.c | 7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index feff7e62e9..69c2827e31 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1167,11 +1167,6 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         g_assert_not_reached();
     }
 }
-
-static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
-{
-    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
-}
 #endif /* CONFIG_USER_ONLY */
 
 static bool riscv_cpu_is_dynamic(Object *cpu_obj)
@@ -1190,9 +1185,6 @@ static void riscv_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
-    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
-                            "riscv.cpu.rnmi", RNMI_MAX);
-
     if (mcc->def->num_triggers) {
         env->num_triggers = mcc->def->num_triggers;
     }
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fef66557c2..4af5cd9c73 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1662,6 +1662,11 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
         }
     }
 }
+
+static inline void riscv_cpu_set_nmi(void *opaque, int irq, int level)
+{
+    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
+}
 #endif
 
 static void riscv_tcg_cpu_instance_init(CPUState *cs)
@@ -1674,6 +1679,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
     if (mcc->def->custom_csrs) {
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
+    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
+                            "riscv.cpu.rnmi", RNMI_MAX);
 #endif
 
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
-- 
2.43.0


