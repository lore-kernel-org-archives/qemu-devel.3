Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CBAC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGne-00063G-Ay; Wed, 26 Aug 2026 12:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGnc-00062F-N8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzGnZ-0000q8-8N
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:48:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QDv1qO4137525
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2xwFh4IjNi5
 ZPP2cvlmytxr2GRgCFO2TpO0YhBlo5+c=; b=G3nWEyBxOOIREk60QJANyNtH3JK
 UanJMeS92uUjShTzdavhCplhPnzOrkBMnqeNe16lkKRWY311IYDYP+kTdIqImQ5E
 Aa9/oM72cX/MIjtjYCq9rsw3A0VwkP/heGS7T47v8xylFBJmU2A08tR/dyqxHdE8
 73W4QMPIyU7udl13Ll/3HJBYehdqt5aTm8mMg3Meo7GV+WRJ5FccQzYwDb/buCkc
 oiJB0GQGk707w3ME3WkBuFZDuKlvkjLi1FzHaCfBxs2kspgzm4EoYqx44s3V3CUS
 9fOHJ4hF1gIu/2g+XiGiuzCV+mwd9avwpHvPxqMP178IhvNUGloOR4S7xxA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9utht5ng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 16:48:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c07f25de2so10030151cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787762903; x=1788367703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2xwFh4IjNi5ZPP2cvlmytxr2GRgCFO2TpO0YhBlo5+c=;
 b=R1OscclNA0PuyJeieuxPUSXdktAWdGAj7zuzH9QldWOoqyeI4tT6v5gpRdkYD65KLQ
 2BgBCBAf9xUla4iGsT2UgvWZl4DGcjIksVhUOCrTIDU8uNHoSprnb6bfpvHdRvWJh5nB
 YXr1bVB2s4dR855Q02sWbndoMBd/ydRshJcE/o8EXKhgptDllOU2PdAx02aN4O57grms
 Qu99i21PMiPQ6zGfkazUDZoJlBFZkdPcY6U8IbiSVMc+vL1Tsb2TdpujEc3bfNReC7ii
 AHT7lx+VUw25hOuYHb/fASq2u3HrFZ8j2d2XKcw0PRGV21OOyVHRrTgHjlFLtue3wc2Z
 Aysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762903; x=1788367703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2xwFh4IjNi5ZPP2cvlmytxr2GRgCFO2TpO0YhBlo5+c=;
 b=MEXoT+UTBiZJHe1aHstJZmv2x68Qsi03kbb2w/NCU5ODtyPXsC78xAPOmw/TGRTkdu
 jOfARp8nvd8+AtrCPU2uVhsIJ1gMQU8HZ2FzGPsshyqSb2fCM1NuEtSHRVWL63uu1rhb
 UZ42jOzGLlX801EJ2ksxCE+PqXgEZ9znP1//vfmtQ7XqqSNiTGDRb6GIR4dMaNMJRVaZ
 SnuS3+bQ8fy9qbF2T++sCw+suv80XQtjCKcagq0TpuSORmtZbk4oy8mffBHwj3G9kS/p
 UPhdbSgF99jAnsDbdF0yzIsHN7+Ra8Hhgj/h79o0Nsl7cRkNWx/6M/6SmmKekwtHs2DT
 VDoA==
X-Gm-Message-State: AFuF++kwFv7WbmAotillyh5fz6HYEBtzv+fnp3xUSDBIzXEJZOzpOvPM
 yZdWwOZ0SVLBGH//QA2J50YB9FiXzoJIlK7duzo5wE/AKr/TESOVWeARdSoSalMLzIdNiqxITwA
 XpElz1PN5U489cXsD3z1axepikFthc2cA2MmFl8xCnSuA+S7dLwDVlgJPJnPaByJNXQ==
X-Gm-Gg: AR+sD13roag9OQxQQsDnj7COjJ5U/EgfZRa/ep/uXuYA1z4QBc9Jj57bSRiGUahUAN8
 Vjwlt0oRh4fupwvCU2suTXdTp6NbOTTMZalhWNlMSVnm6cdkjDyNTSbdSD0fh2raOYinNsQmNf9
 CAkky4Y5VFVDzQ/FFqTarH1mDSAxiGdie2i5WpEc70q0TEHOBAIJ3YvAc25tr06wEnBldFwxz60
 Oxk+A0tval+7FRB1OlRO+q+cQDfDcIi3PzD0JkcxFN8QyXvjfHEik/MCgvXytPzVVEi1Y9G/0k8
 22B0yFiVFds3t2ThJ1Ktp2/rjhw4HilTH0WW+LigmfbID/1bK1MGzVbLHAIC8ox+gxL3JEGuRJk
 hOO+0dHInALELpd1n6tJ0QWY3pWP1ry6x+qkYJw==
X-Received: by 2002:a05:622a:6102:b0:52d:3ccc:968b with SMTP id
 d75a77b69052e-52e42235c7emr90311461cf.9.1787762903097; 
 Wed, 26 Aug 2026 09:48:23 -0700 (PDT)
X-Received: by 2002:a05:622a:6102:b0:52d:3ccc:968b with SMTP id
 d75a77b69052e-52e42235c7emr90310361cf.9.1787762902468; 
 Wed, 26 Aug 2026 09:48:22 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e4275fc3esm20092651cf.25.2026.08.26.09.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:48:21 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v2 01/13] hw/riscv/fdt-common, virt.c: add create_fdt_flash()
Date: Wed, 26 Aug 2026 13:48:01 -0300
Message-ID: <20260826164814.44335-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
References: <20260826164814.44335-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8f18d7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=agbqTSZeYTzrP7BmR6QA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ZQiRQ2P3AiH3INw5PGfPXposZHoGEvVw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX2/vAnkGsgRcB
 h/iooZN2U1Y8vxT036z5ISdIep83y+YCAOX+9vCOmgRzrAOcFB7uef56yG7TfbmqguFflKR7fdw
 PKyr7kUDlWWHo7xrtNDh28kyv+gEjRXLhBE0S1iEcICoNBOy1aCdsTFlln9sNxFZnLE8BBAs/NM
 9bV3tZ9voewKkRetOdCh/ads8p7nivG9hrMoT/gzKhOCcbHjPU8LOcEfdGVD/ugdAGaYOv1NnJR
 lpIooXBtG1toyQZ0LTZxJd4ZZQSPhMvGV3eZMy4pHduGlDgYdJ9qw2A6ueK3S9+nRSMglEEJqWp
 zoT5ug53IyJPbRyNWVIVONU/Q0IPN35Mf7mBV3NI4XDeT9xCXU82GEZs8VAZeqLcjXGoKk2BiM1
 fNvBcjPBSBqbkSZUv5GdHg8WIX7aP9WfN1ipRfJ8icgfQA//VXhFUMA7+kvsdlxF9AqaeWNlFbE
 K4rt+mBQ+5HZ2c1FpFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0MCBTYWx0ZWRfX4ssNlO2TWCng
 0VPYC+IYByvTvGHiZFMxsIkrwLwhZK8nBPkojn1azz9F/wGUB2vxcHOZ9LHCbltGw6Snpvkshmq
 GL6cajM59ShngXUwW3zld8mkUgpzjwE=
X-Proofpoint-GUID: ZQiRQ2P3AiH3INw5PGfPXposZHoGEvVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260140
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

Add a common helper to create a cfi-flash compatible flash subnode.

This change only affects the existing 'virt' board for now but it will
be used by the future 'riscv-server-ref' board in the future.

No FDT changes intended.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 12 ++++++++++++
 hw/riscv/virt.c               | 18 ++----------------
 include/hw/riscv/fdt-common.h |  1 +
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index aa143a618b..e74423a225 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -282,3 +282,15 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
    qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
                     fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
 }
+
+void create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
+{
+    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "cfi-flash");
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, flashbase, 2, flashsize,
+                                 2, flashbase + flashsize, 2, flashsize);
+    qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d58656f70d..33a121abd9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -865,21 +865,6 @@ static void create_fdt_rtc(RISCVVirtState *s,
     }
 }
 
-static void create_fdt_flash(RISCVVirtState *s)
-{
-    MachineState *ms = MACHINE(s);
-    hwaddr flashsize = s->memmap[VIRT_FLASH].size / 2;
-    hwaddr flashbase = s->memmap[VIRT_FLASH].base;
-    g_autofree char *name = g_strdup_printf("/flash@%" PRIx64, flashbase);
-
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, flashbase, 2, flashsize,
-                                 2, flashbase + flashsize, 2, flashsize);
-    qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
-}
-
 static void create_fdt_fw_cfg(RISCVVirtState *s)
 {
     MachineState *ms = MACHINE(s);
@@ -1040,7 +1025,8 @@ static void create_fdt(RISCVVirtState *s)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_flash(s);
+    create_fdt_flash(ms->fdt, s->memmap[VIRT_FLASH].base,
+                     s->memmap[VIRT_FLASH].size / 2);
     create_fdt_fw_cfg(s);
     create_fdt_pmu(s);
 }
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 1729a6abc6..6e438e0278 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -36,4 +36,5 @@ void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                      uint32_t cells_size, uint32_t ndev_sources,
                      bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
+void create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
 #endif
-- 
2.43.0


