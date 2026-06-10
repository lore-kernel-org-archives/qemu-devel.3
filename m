Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B11CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQgT-0006wQ-4g; Wed, 10 Jun 2026 17:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQgQ-0006ri-IC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:41:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXQgN-000348-Ty
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:41:58 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJYXu32471976
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cQWKhavUm6Z
 CmKPPrdzelKxZNHx3Yewo+bUhJ968rOw=; b=QPNXgqSkMS5psYeTQC1DVN6cRZy
 tJN/6VEqFNiswxDPM9u6p4xS3A7K1K6/n6mly4ED+G/jwFjGc3ZERC27pQTVMeR3
 cHfmHPK/71qkGigApvIPW4r7HMGoEdsn9UMHUUvY1fV1V+KcA61pBGiBwfP+rAEK
 uhdRq37WUFi2S5Xh9iHKf6w76AMAbbJXxxowwrnD11aUfxYxTziG/wzZ0NXievCj
 8ZqrdGa9iFMymtvwqH8uliwwc+8JEpOQvDPMIBMKKokTM/aEBAw6VOPp3nk0iSeH
 1jQmiKH0cjQxB+BAovYceEeb2cIAO4qFH0KveZfVjuy5wnMX4DRNW6QNNXQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u8ews-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 21:41:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5178ae66ff3so115580061cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781127714; x=1781732514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQWKhavUm6ZCmKPPrdzelKxZNHx3Yewo+bUhJ968rOw=;
 b=NWAV6azsHfss6vfSQwm/QLo8fROtn4rSdxw7m6TW0Om47z13KVETOV0oYFkvakAYR/
 T4sTr1AJ7Ek2qEnp23m8gZD2VhXwxJGdc3UmC0yrRjp9PXlNbg9bCyMYcSl6NYQtrrWR
 KJlx3NihTx3Y3/L/1+lnrdniGB3G47d1RwepStY2JDuyRuG3XAz3eVTCkw1/MhbR2VXv
 tgEB7cqeYPJZXbIYbpXMkHjv9Vu6OQU/DIuORruj31djXsMQXu7ODsIbJZebWxEHgpV3
 PggMJtlTUdAzfQmihg0pz3vpIn+rvTXXlNhJpJxMw4sbg/JDVG1Phge5/QW3qLRutJx5
 xLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781127714; x=1781732514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cQWKhavUm6ZCmKPPrdzelKxZNHx3Yewo+bUhJ968rOw=;
 b=gKOivTH2BCsZZ+yYH3OA/tb5BYfnGAHM1rrQTag9r7LrFwlkIJwSMtd6rDczAc/wSe
 TO5wzfJuc0BsCnCRuMjGKXhMe71P++aPrNCUko2zu/Vgkp3YrB/X48JYkTG9jrQ9aByA
 V+0Ll13DepNjyubA4NSwKIcN9FFBedr3hdSyW6UF202aKK23m8ZEJ5vCus/W03yI5O3q
 609+u7Df4OcYhdxdtwhpnVzkFs82jN0p8u9DDf2hafOj0AQgm19jiAH0FddQNNL3v8Kx
 X6Obc6R05l+uZ4liApFwNDCFUj78ruB4uBaSIIl7IdiqOepgdvWzTJOBeOujafFkr7iF
 i1FA==
X-Gm-Message-State: AOJu0YwdE42a+ozs42ohpdZEuQ4zdcX/X2Z49CM/R9rMlA0PYucum5M3
 hXtYoPXUweu7Z9v4RQiNdTgG2hDj34Afy5FEkqfrgHe6Yg/hcIw7lBtbu57CikdjqZdSnlIIFdV
 wgyvrxmOFjQ5QAf8jV/s5haMHRDrFfBruxvQ+evCdzRkf3eYV1O2T9fRw6au6Jv0yEg==
X-Gm-Gg: Acq92OGC4o/JKBMwzNIjgoAJoqonvymJeuqiMv86y2zukypfSjrfLGw734/Ose7FBol
 s2O/YZsUi1fEuxJdM+eP+1ooQvt5bpORhI2PJa9NkM1/hSlRY0YJEAeWdo1LUIf5Po+JTDygfWp
 UxQ0uUIHO7bVPsYwKeRt38kR+MAwxPy+4PCeez6jfMIXKHmEj3Rtkfi1yqPybd4UaY03Sgz4YL0
 Yz/nAYKAE2ttz75lqItEiGPC2Jz78ed/CiyNJf0pLZXGFOVcgKBDFhzbnvtxaFyzBnvgxdWgDVQ
 lgjzbkoTsnqeWO8cHE8vYphirFjSRdoyXTd00OrUld/QHzWEnb0dDhwk32OpbpVKH5osg/FcrP0
 OJ/5c+k+LtMIxQpjDs0q5ofix9AI+KiLe4Sp4uitVJU+LZrh/ujp2cdEFv1fSsvzPfXYtLg==
X-Received: by 2002:a05:622a:992:b0:517:6a26:43b with SMTP id
 d75a77b69052e-517ee217ec8mr601691cf.44.1781127714123; 
 Wed, 10 Jun 2026 14:41:54 -0700 (PDT)
X-Received: by 2002:a05:622a:992:b0:517:6a26:43b with SMTP id
 d75a77b69052e-517ee217ec8mr601271cf.44.1781127713693; 
 Wed, 10 Jun 2026 14:41:53 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5a6d777996csm20766280e0c.7.2026.06.10.14.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 14:41:52 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 uwu@icenowy.me, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v8 2/7] target/riscv: add riscv-server-ref CPU
Date: Wed, 10 Jun 2026 18:41:28 -0300
Message-ID: <20260610214133.1882563-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfX5KHs6KpzIdrS
 lxzw9dq6uLP/3NSoqFdwnrTdW7a+FQLvIgK0XRDSkdftNJHwlv3VyL5lEY0oKEkjeAGxdBSQd1V
 MqspTqeJVsPSVGveDbe4GpVu1Wrs7q4=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a29da22 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=V1jnuoLLAAAA:20
 a=EUspDBNiAAAA:8 a=RyS-KtFGDtHqjiiJgvUA:9 a=uxP6HrT_eTzRwkO_Te1X:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDIwNyBTYWx0ZWRfX/+KcLoR1UwsE
 j474z7LuL0AH077NlDeuZ3KRHZYKYFhPTQDMnFf36IPlq0S4l0mT4xEZ9nPH/GXYN73nE1xpdH1
 7/CKPUZi/td8T80NreCXhoyTQ3SSmEAyziDLEV070NwcPFoAV/h9/sCvc6nUI/HExL2FPYSSn17
 QR/x3BcS1ltbF+7GyaBZnYTDMS2oIhk/rI2eEDgmvogv0M2hEy6Ztxl+1DMlDY+RUdxIzaHWzE2
 11Ksfdb7z+MQ5kf7TITjBDjiG9pfzsV1s5Tz0YLk8SnaWwtF4EzBvpwdt3O7BORhNLxhzSIrMue
 U/WMUptm1LJWtZ8hzkUmUS67SiOcRLvJxJLyKHkAX45+NopzQXMyrdKR1F0TzBCOk+qZonep6Eg
 7m18sk4K/7Lkp6x8JzKT2tPvsecxih2y/AUlWFKdTy8/dj5cIwxQSkkD9TY9UJ9BAOrcfPotxAY
 fG07pzcUR1Hi4c6VPAg==
X-Proofpoint-GUID: KzzRkp4D8RCPYOCPhrNOwQznoEhVaHWS
X-Proofpoint-ORIG-GUID: KzzRkp4D8RCPYOCPhrNOwQznoEhVaHWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606100207
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
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 30dcdcfaae..a150acd151 100644
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
index e02d53cbba..63fbc4b98e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2063,11 +2063,35 @@ static RISCVCPUProfile RVA23S64 = {
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
+    .s_parent = &RVA22S64,
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
 
@@ -3326,6 +3350,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


