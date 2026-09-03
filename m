Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBF3C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CDw-00018Q-E0; Thu, 03 Sep 2026 14:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CDt-00017N-Bt
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x2CDr-0001bN-Hm
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:31:41 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3Zv31430806
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mKHlv7O60QF
 kPN7XH622NOuqoTsgivr4tr+IWmeazZc=; b=prDNF1oWOQIIcwl1CIkzYvXKE42
 nqEeFhxyqzl7Ig8QtB7duz+iWo8+IazMZhDTaYBGXv8Z2t/lwZRu19F4e5UwNNMp
 yWL4dRD9K4kbn1lkEPVDpmVu7f6tuSdgw8jdbZ5cqz+UKnK93wWg44Jf+VeDWdHr
 UE4HaQ5gkn6L76T50Od4blEILYM2jgyXCtsjus+6UcVek2qNETvkhplwqvYPOJbJ
 HtBc4Om5e0imyOb4V8XA8Fw3VxRk/twPSCg6JbvdwED2lF+YwG2LNgcu/KV57tIM
 JZQYoool94vWiOT3+FAZQe9FjgYRKunkUnaEdMihS0Rf1r79glOZSiXaMaA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1j4kg2c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:31:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90e8472ee1eso3578586d6.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788460297; x=1789065097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mKHlv7O60QFkPN7XH622NOuqoTsgivr4tr+IWmeazZc=;
 b=LTA3gLIcxXCypU8Uo9PiqRvBaB3rQMGVriE818Gsot8RzF5aq8WZlhqUub3kSb4Oju
 ezWOjqZ7P/JvQtflbEsAJ5Q+pVNAKOgoAGtSm3//jR7hLFTICUsBMjAFg6Sui57AkgU+
 SIo9/52Dmd6bT4dlDEzDXNu09QIUC0VEQJxZ2gvWMhHijT4ccLbg51QmXOTMcYLXvVdi
 ijCsCE+A5Mrgs1BsxpUvPxAvrswcJm5UfZKe8d/XVgsYu5jkiFnepQ9Dg8BNrcrZhkzP
 eqXal/vNAo2iRF4i813IrgOKYZ9X6FqS49sAlI8SqyZAuXOx6V2dWa/gHMORqAPa8R/+
 s3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460297; x=1789065097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mKHlv7O60QFkPN7XH622NOuqoTsgivr4tr+IWmeazZc=;
 b=QG+Ev1mbekRGP09PupsT1PlCtrOplCLlq2mhyXfN0iYTec8MnED7RPirlERBmbsFN4
 0LGwNMkY8sbPM0uVGQ6qA4LZw3wss8XNLfJlYHYTG+FUfNbZmqjIPR43yu832x38a7lh
 7VSDfMCAbHTYwwDSihSWVq7IOeMyMvgRr1Z0r58KbaQR2NlMprUF1ciCvwGEnpaozook
 k0TAR4B8xtz6zRMHwoESIP1JBciS4QU7KGiWxAbfz+3oijYt4rFDz5D07JJBF0WHmo5o
 csxs2gai5q4NLH4JTYdhjdTi3daJHS9zb3Sx/2eb2RPJGkSWwOglvH3iQyaNBbGMtlFB
 U47g==
X-Gm-Message-State: AFuF++n+Q/qcC7UJzqutiVgt/2tyVdKh/7CLBPpHjq6Ent8arbofb1wu
 RuDm/kdT/nRyA1vND0UvOJBtv30BJqE505TKwsPvy+KtEKZAzJwaupN4IlBOneZx6rZHXHxoup9
 6x/yvk0Ah5WJebZsfr8HrkAbpx//l212OVnWZYsN4I1xM+U909RbdB8y8lFkzI1BK/w==
X-Gm-Gg: AYBFou2abHwWbYEW/24nzQgpsKN5XaVB/1sp+978rulbfLG37lWFchpWLOrEVnfb+q8
 PH3v4za4zrSG4DzFQA6CVR/gxj0BZ4JikpexSuVZQPnXtb966BZlXIQEefLVFHSX5/xzi2cLN7Z
 J9zPeEUzCXLvczMTmpqTTQxnQVFVclv0gtrWceHfDoypOY+wYv/D/B7Xvzfib1m9RiZFamHmnSd
 yfU/2dBlNFwNs/aHAZmIhaDOkMshmTdKy3ljJ/OERhW870oeIlxde+cuiLx/zvKJM91OShxCdD1
 WF3FAAt9pTLnuMamwAokg/33cmhrLyQdxJGpV+sVgQoEPWkkt8U1DMGgVc9w92oCr2J4c0gCJW6
 Er1clY9APe6t9kWkSirfvnOHLTedGzp1oZO9M
X-Received: by 2002:ad4:5dcd:0:b0:910:4080:dc4f with SMTP id
 6a1803df08f44-9104080f964mr209856d6.4.1788460297180; 
 Thu, 03 Sep 2026 11:31:37 -0700 (PDT)
X-Received: by 2002:ad4:5dcd:0:b0:910:4080:dc4f with SMTP id
 6a1803df08f44-9104080f964mr208646d6.4.1788460296396; 
 Thu, 03 Sep 2026 11:31:36 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040693aaasm603596d6.34.2026.09.03.11.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:31:35 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Icenowy Zheng <uwu@icenowy.me>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v9 2/5] target/riscv: add riscv-server-ref CPU
Date: Thu,  3 Sep 2026 15:31:22 -0300
Message-ID: <20260903183125.682865-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
References: <20260903183125.682865-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dufrzVg4 c=1 sm=1 tr=0 ts=6a99bd0a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=V1jnuoLLAAAA:20
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=PXcuKL70AAAA:8 a=zLUtPzHEVTZWnbMtJKMA:9
 a=OIgjcC2v60KrkQgK7BGD:22 a=xVlTc564ipvMDusKsbsT:22 a=1qLaeP4TCVy2vqIEy19U:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 2a0-EPqZSPHGrsjltCsRG3wAbTS2747B
X-Proofpoint-ORIG-GUID: 2a0-EPqZSPHGrsjltCsRG3wAbTS2747B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2MSBTYWx0ZWRfX7ho31umHqkSO
 Wtg8yukfJ5k6PIGuFXwLrYC3ajxJNe+YeSEuFpR9O9R2RB0RU170ufp1frHjkuTzWBEKSjd53if
 7umGiMr3WDRl2J/+jn/Ov87Oy74etJ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2MSBTYWx0ZWRfXwJQS9ovlK1C+
 i2Xl9GyriRQs4O6chCCh1HIk8bwsFPuYpEO+MAEvdJshkEcDvs4SeiI2MgaKux7/A/Igb8CpMj1
 9Mqpiy45GZXTUJVwJ1ka+smCgR0SuSZA38IfA3lfxM6fN9vMqoS+ZaVTA+l8Tfhv8MXTde/O3ea
 XDHlrOCUBnIIwBaBTYJ7Qt4V9kAB8MydR8vAnUg7/R1haTm78AjBrDFSZwtNwhGkYUbQYka3e09
 Y0s5cXl4J1At7ZmqbE06+J2gb9G0k12PRrowjv8wYpJJa4QySw3VsVEA84swidxDz4tRkb5wTCd
 OcinRHPQ0RXGdnDBIqWZup017JAr4YGsjqZ4AMwgR+WMym4/kw/+dnvb7ajm3eHwu3tKtzWEdnL
 ya5DM95KVrfIwLZoHuCcDTt2a0zuXDlSrSNfYq9+3mmD0CiikICoKsiZKBOroverzWLq3dBAlQw
 hFFK3mlbBtMfWrbaI1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030161
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
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
index 4cc73de793..086bc945ba 100644
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
 
@@ -3757,6 +3781,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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


