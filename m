Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4976EC79F87
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a1X-0002xu-2E; Fri, 04 Sep 2026 15:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2a1V-0002xb-Kf
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:56:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2a1T-0007jj-Ii
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:56:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HI8eU3521906
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 19:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r/8sgL1kmjY
 vrAW1FDVUeoWzEXFnZJUmnqHjOyHtAU0=; b=FcqAkbut/4+Sh7Cue0sVknJPaTW
 krwkrgLDCdPTsziMNnF1VBN83oc8OmhmK2eM+o3omXJ8YBn4usVVwvwJ+KnPJY1M
 ucNFoSb/c55CnWKr2DBLBOdQ/ZHqPrXe7Owr4mU+G6TQCoaJjW7kYZbHRCG1Fkg1
 rTEuCrDwmmUzmaa8gH66ZhEc4KVLvcMUzZgb3K88gxcn6i1HVORWznurqZ8WsE7S
 dVvjABsW0ZuqpBVwsldM34QLa9lWC65LVK36vyg+dAcMB6OpBkEqRstS1Mxl7aQF
 xQwlLXp5utsaDak4EiSibi3U0tC8EUH3W1z06FQxJI33NcT6hc6TAARTWaw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg010hevd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 19:56:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52ffe24490bso31457601cf.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788551785; x=1789156585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r/8sgL1kmjYvrAW1FDVUeoWzEXFnZJUmnqHjOyHtAU0=;
 b=MD0Ekro/t4CSBIRBKVkkjbfDenpJ4PG9uvTsciJOYBVNggYAAon2J8UwhzcURbUqQZ
 vl7hAac40PYm7AvXuRA8zKBQxpdkmBVyw8jBSsmVqY6SYeSnGxpLFtsB5mAEJoF1SXCi
 Od5sDTuDa0nRe0TtFM/KcCibPsSYlguoSf2qTCAyBPF5+rM55gy3O9iJXo1bpHkisR//
 dq/EOLj8UCGK1Fhtqie08i55KWHu/2nUDDxGB3/gX7zifAZtzilbr+eYvZYqsnIP9yuP
 yMhbbwratnrPczQ0qFjOWXT2n5WhhIPWdmmo/xFBjTIH+FKSEeYdkipBa8AZ6EH62OPO
 iAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788551785; x=1789156585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r/8sgL1kmjYvrAW1FDVUeoWzEXFnZJUmnqHjOyHtAU0=;
 b=ZQaJUxljnhRCiUXuVfN9Oec0RS7F9MGgqhy4FJZ2b2kKE1TRBCdk+tOe9EjzlAgGiC
 +aNksj6+8KgOPbmMxdrPasYBnOyoaMkxj0GfG2H3rm4xdWvOVmIal7dbotzx+VNWFlAV
 sFdetgD5CUBAzT7YmqnYp9ZvQsK4YfcEJ1dgISfEHagapSCcQ5jpqUh6HeHQb2a5PQsU
 tBmQNcXOZXs1+zOviVD35OPwkCKFc8rKkmvjMrRId1iH5xRylsov+tXRPO+gheshNP/H
 x2TrqSor0qR1J1L0CmBJX+Tumkf+c9aoAe03xpxOokt0YhQduiEro0EorkHLTVTLS9fp
 4N3w==
X-Gm-Message-State: AFuF++nAnR/pa4HkRf8/7Pwa5ZxqhDuVR3gBMvrDQzzhAZ6v0kXvOrfz
 wavUqd/pLvTkDl+vheie/iL3KQGpZURgy2/AaFhcjFf8lWQqBlAQj41aMDTYgFWDm10IsUs+Eg1
 /Vwad/SQaagr4t9fNR4/lsC/54C87kJNzS6TwfzPF+7PJ6M6oQgmLmRsIpKQUR9Bsrw==
X-Gm-Gg: AYBFou3GBgMd0lFSe73567xuAI6pN0Frls7630B4R6PNOONKc5WNawJTLlKkdxSjPnv
 wLrEnwxc7qTGLv1dD1DyFcSbGLmmMrg02m5mkpmiI7Izp+lSO/1gesCgZROu0BmCuiYl6yupPij
 ZTGO3w97UuMduJuLbuQZ5DVLuy5LhcdscZE9fvBv1TNoaIc+ej5ne9IAdjT3MoffIg0tU96730A
 SSNUPcAzwWTUYhBQatF1j+GDBaZFjMyLk/vhjV2LnqhB32F2jqwdhKqCyQ8AZHbIQDguma3E1fc
 neYyqa02mYXf/GmtixXbPel9d4kjVfnRUH/SdMnpQLhWgi8/ehK2Hqv6zVSkyZpGsriq1Mcig8A
 9wFAoxtlGDy9EVO3lhXD6uh04e4VbX6+rKfId
X-Received: by 2002:a05:622a:1cca:b0:52e:a24:ee52 with SMTP id
 d75a77b69052e-530544bf2f8mr99810941cf.0.1788551784634; 
 Fri, 04 Sep 2026 12:56:24 -0700 (PDT)
X-Received: by 2002:a05:622a:1cca:b0:52e:a24:ee52 with SMTP id
 d75a77b69052e-530544bf2f8mr99809841cf.0.1788551783823; 
 Fri, 04 Sep 2026 12:56:23 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406871b6sm29117736d6.32.2026.09.04.12.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:56:23 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Icenowy Zheng <uwu@icenowy.me>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v10 2/5] target/riscv: add riscv-server-ref CPU
Date: Fri,  4 Sep 2026 16:56:07 -0300
Message-ID: <20260904195610.964829-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4MiBTYWx0ZWRfX3Ou0uS5e6Oy7
 Ei8gTM0u89wfA7tdZWwFPkbb7l4BX4NjCR1IVp35Pyd7D1EBjYiCwIaFQesuuFhG/aSh+apiEFZ
 3PhO0XGOwMdWAPE3R6Qse8VMXbBE5whpe+iUdK0yzTDbhkr0u7VJ7Pqr8jn8kLjY0PBjxfvXPfN
 +0CmhnOlQVFeh1VMTb9YDMv8sxfAdzQ+msIt/2kDFxlaZGrJUdgdnm1UCZ72WR2DxhlGWOd9roW
 cbiSEBD9KuAtG2Ui8NkA7KdNDZARSXM2XubBXKSn/qu7ZAk8SaOMagMN3avVWxmJYns4KjKXeV6
 vmXCWARpWCkn3VVDuFuG4jbHmIZJXoMXHxtUwr++JxIydsWYs8Xbpy5Wsx8AC249ZYfd4mDqmZ9
 chsJRgVdXvU6eTy93hp6jHCEWEalWazEWIWWYNOm1Sod8LQlr2zj5DfwsRUAusNk1JJEog5W4MZ
 0HL5rFC05S0uZrooWLg==
X-Authority-Analysis: v=2.4 cv=YNavDxGx c=1 sm=1 tr=0 ts=6a9b2269 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=V1jnuoLLAAAA:20
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=PXcuKL70AAAA:8 a=FRSEYCzRAAAA:8
 a=zLUtPzHEVTZWnbMtJKMA:9 a=kacYvNCVWA4VmyqE58fU:22 a=xVlTc564ipvMDusKsbsT:22
 a=1qLaeP4TCVy2vqIEy19U:22 a=H4N_Y-AU75W7NKDNhZlT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: Ntw35RlnuQsDlQtYiARvyvPHNvpomo0s
X-Proofpoint-GUID: Ntw35RlnuQsDlQtYiARvyvPHNvpomo0s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4MiBTYWx0ZWRfX8mjwcOHdocpK
 xEkW1x1j/kPOzE8aX1RjSutFHx+p3j6e/YJFsmnzPMtXSE6LeoDBwmnN3GkhzTs+hzgAH9tEonm
 t85nEfMaTTnPcye0WfZ0jF8TeS5dOdA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040182
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

The harts requirements of RISC-V server platform [1] require RVA23 ISA
profile support and others.

We're going for a profile-based implementation, instead of a regular CPU
that can inherit RVA23, to allow future CPUs to use it internally as a
starting base for their own extension sets.  There's also a new
'rvserver-ref-1.0' flag that can be used to set the extensions in the
command line for other CPUs, which can be used for testing/debugging
purposes.

Note that for all intents and purposes "riscv-server-ref" is a regular
CPU and no, we're not trying to set a precedent of calling the riscv
server platform spec a profile.

[1] defines in rule SEE_020 that we must support at least 11 debug
triggers (4 for insn address, 4 for insn load/store, 1 for icount,
one for int, one for excp).  We're going for the minimum.  If more
triggers are needed users can set any trigger amount with:

-cpu riscv-server-ref,trigger-count=N

Note that N must be <= 128.

[1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc

Suggested-by: Icenowy Zheng <uwu@icenowy.me>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1a28f1369c..61234842e3 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -42,6 +42,7 @@
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
+#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 185474a8cf..b5a75fbc1c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2417,11 +2417,35 @@ static RISCVCPUProfile RVA23S64 = {
     }
 };
 
+/*
+ * The riscv-server-ref spec isn't a profile per se but its
+ * CPU definition can be modelled as a profile that extends
+ * RVA23, with additional things on top of it, and allowing
+ * future CPUs to derive from it via
+ * ".profile = &RVServerRef1_0;".
+ */
+static RISCVCPUProfile RVServerRef1_0 = {
+    .s_parent = &RVA23S64,
+    .name = "rvserver-ref-1.0",
+    .satp_mode = VM_1_10_SV48,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_zkr),
+        CPU_CFG_OFFSET(ext_sdtrig),
+        CPU_CFG_OFFSET(ext_ssaia),
+        CPU_CFG_OFFSET(ext_ssccfg),
+        /* ssstrict is always enabled for PRIV_VER_1_12 */
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
+
 RISCVCPUProfile *riscv_profiles[] = {
     &RVA22U64,
     &RVA22S64,
     &RVA23U64,
     &RVA23S64,
+    &RVServerRef1_0,
     NULL,
 };
 
@@ -3759,6 +3783,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
+        .profile = &RVServerRef1_0,
+        .misa_mxl_max = MXL_RV64,
+        .cfg.max_satp_mode = VM_1_10_SV57,
+        .num_triggers = 11,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.43.0


