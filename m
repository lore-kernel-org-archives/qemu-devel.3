Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A55DC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24vq-0001Bh-Rw; Thu, 03 Sep 2026 06:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vo-000156-SG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vm-00077m-R3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:32 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH6VV935123
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EuNxuW6DmxZK4+8e+ht4Jx/6CqG794mpV6iO2sy/uNI=; b=SDm0gANOQQWARhxd
 xuKwNkjThQshOb9pvPiNRJvCp6kuJRzVUIQMJKxILeE1Fn4cAzIgEsYMtpktGKWb
 2UQmSzqmRCouFxkbt+b7Lg/Hlxg8k2ne9YeAUYaS2c8LRWoN8wSNXN4zgorgLtBv
 nyYgTxSt87mUFHoYvy8CZI0IrtpgRyFfANrLteDpQiG6vhrsD2rhtkY7RpQORjm/
 nPo06YqVNdDhPBUIeXz2k5tCgttyKa1Cya7gBE+ZXezWI/f3MSvmmHCRgTH/WTB+
 yxPE2Q/CKDi1TUiIaJsiQ6AQbMjE4Fzwj/4tV8LHN4xWYFQ0eBqQtB8pWQh0LLtE
 C7Ze8A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gerdnbvkn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:44:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9390a2c895bso580483385a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432268; x=1789037068; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EuNxuW6DmxZK4+8e+ht4Jx/6CqG794mpV6iO2sy/uNI=;
 b=jisQcHk+1rfGhHdJkKYq61QoBCNV+rTNvi7hJ68h/AFoOEFsMDupzi2EzNI+q8ChxE
 vpbAp3dwVQtDpl7RorAwo1clmznhLhHB745h/8LFb2/hh/1MRU9/ecHJeQ5Mz4GCxgKT
 FbF9MzAMIqhQ/7HmEpFe/LOYfmire21T34bRF2PFxqNa7lv9GGood+bx0TnWSRDQhZCq
 7AEkU6VHx5KpAm9c822A6hfAWKDyOmgtq8dcgjqZgekXpBusbtayatpqe3pMclFxrEJ2
 bFdk6VDkDXDfp4YWccGtd5FpsJwJ7CM9F8NalcH6/bhf1MP0Z30enIFJ6TyVZ21L0iHk
 Y3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432268; x=1789037068;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EuNxuW6DmxZK4+8e+ht4Jx/6CqG794mpV6iO2sy/uNI=;
 b=O/BlaTVCfCGhmTxdegv+r7rJ643EEturFJYX1eNZ7GF9Pvtcwxyay8iXnsWOaWYwdF
 oSQFWeG46Lzz5uP1/f6RZA/Rbrii4msN55IniDgXHwna47YTiFKE4pEA/BZVxIPERV9V
 ov9SWqHUV7YaqQBBrzIReH/fDOwH3OotzAnBngFU/f3rvcwhADqPwVZ2Tbbbed7rXVW0
 xe+xSeHd0f6oCDGi7/dHMG0lA0X9vGYb8+PZ113K58B+mMB0iL4eJCjEvm8SM7tm/T5m
 JKiOAF4Tqzo6X1mxJ1nHfgd9c6n5X9+4JUgegZ7l7iDfSXvfbn66wY9+mivTn54m+xIo
 cTvQ==
X-Gm-Message-State: AFuF++myo8g0yUTl/wPuW9DxsKIrWDOoN9Cq904GxbVV4j9ANWLVAL+U
 dWJUrwUliL2TkxeB5nJTRF+b2OGpDQBPfzQ8uX6cZJv2E6IiQzYeaP0RfomWZG8OEtHTKGPgqYJ
 +DfkT0xfvnG+Lkj30IzsXyu8JV6q5mbqnEgEPrRWPDgoXxxSioOeeCjdn+LMHnSv4pg==
X-Gm-Gg: AYBFou1LlX/3oadFQMEeoNIEn22zq7FaTWBeP2fFE5iuSMzkF+vu4gQlQZA9g9RIrmV
 VtkeufnHqq0+d3ZcampQ+nF9+QcP/QcAW0LXMUoNA1qyQN+MnWz3mnX+gfREZs1ygukFtWRsQ9y
 yRoBOAykNOgHLv40e9qm8qVvmwz1QwJ++NYFB936vTC4+1fQ/THXHTTRyPrHPgVQHP9sWf7/fhk
 JBGmA4jSywtOyumNxZ9ytu3getrjm17B1sVA3c6l5fIUL1lQp8V+/1oAiNRF0xKqQjpfWf7kdfx
 QJhYC69LzdPSIKAGw6/lPAp59EIcSkBSjX2i99VuR1WSnP8vnOJWxkcy2xXp7ao3xkUmSkx9pDB
 zGSDTfMRie4bMev6QLa4I2f7uRRxs1q/LNRHlBClk
X-Received: by 2002:a05:620a:28c1:b0:939:492:20ce with SMTP id
 af79cd13be357-93960fdc49fmr1186138185a.1.1788432268495; 
 Thu, 03 Sep 2026 03:44:28 -0700 (PDT)
X-Received: by 2002:a05:620a:28c1:b0:939:492:20ce with SMTP id
 af79cd13be357-93960fdc49fmr1186134485a.1.1788432268025; 
 Thu, 03 Sep 2026 03:44:28 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d1fa6sm66229575e9.1.2026.09.03.03.44.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:44:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/51] target-info: remove machine_typename
Date: Thu,  3 Sep 2026 12:39:23 +0200
Message-ID: <20260903103936.62355-40-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YcmNIQRf c=1 sm=1 tr=0 ts=6a994f8d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=qKhv0Rusv1ucPuRBWVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX2vwISp1xDcBs
 3ydvoNTlosxM1m1BUrZMvhIci1Si1Gd1G65l9HhXafhLdh58Ng23rj3/+T2J3nk8+8MyvmexoY2
 ICTc/cXZZtXDk2qUheS8UMw1g8e0Mx0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX+xGE3/iW0/2u
 KBFiYbn4o+MDsaohRYn30hDSBaWnrKbDKI0gE4I5OOPR3W2STxetFggGdrZi2uqFpMvOKGSZuu5
 1rANAcrZpTGuNPR0W6hzGEt9Tu+5Ucxz3EINykgcBdpj/TlZCGNCSbgx9AyZfbp3HQUjkExg91X
 jc0HMpRhq000ybpdQrd6+jpIu95lC0ZImiy41hxKzSEkFB8wl412i9xTYcKiO/FquuKf1Mv31K9
 Qi+3lSbViYE3hbBz+q2raWAG65+kxiJ+xiHNkPvm689B0KpYNoOEay3lsC+/tM8VOGcq0AGgPGf
 MRFAkLgw5VzH+kIeGhbp0eFhEUgv5U9ira/7LP+6KO9yKhLPSFR5iKu4/Ghl0HXrKg15OUapbbb
 jZVq9exMmc9mTBRdHsv9JVeft/4mpwqw96MtHPL6BXDuUtfZwGZVsMocV3dwVAMr0vcwUSHLD4H
 R65uHlaCb2tTV8p9RoA==
X-Proofpoint-GUID: ax6vtBXaUmJVpnwuys-jBFLEMIN7dkaf
X-Proofpoint-ORIG-GUID: ax6vtBXaUmJVpnwuys-jBFLEMIN7dkaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030092
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

This field is now unused, so we can remove it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-5-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qemu/target-info-impl.h   | 2 --
 include/qemu/target-info.h        | 8 --------
 configs/targets/aarch64-softmmu.c | 1 -
 configs/targets/arm-softmmu.c     | 1 -
 configs/targets/riscv32-softmmu.c | 1 -
 configs/targets/riscv64-softmmu.c | 1 -
 target-info-stub.c                | 1 -
 target-info.c                     | 5 -----
 8 files changed, 20 deletions(-)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index c917d546eab..cf42aabbc8b 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -21,8 +21,6 @@ typedef struct TargetInfo {
     unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
     const char *cpu_type;
-    /* QOM typename machines for this binary must implement */
-    const char *machine_typename;
     /* related to TARGET_BIG_ENDIAN definition */
     EndianMode endianness;
     /*
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 6c5b714288e..b23e5bc5865 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -23,14 +23,6 @@ const char *target_name(void);
  */
 unsigned target_long_bits(void);
 
-/**
- * target_machine_typename:
- *
- * Returns: Name of the QOM interface implemented by machines
- *          usable on this target binary.
- */
-const char *target_machine_typename(void);
-
 /**
  * target_cpu_type:
  *
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 75d95b0e743..2200a4f19e9 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_aarch64_system = {
     .target_arch = SYS_EMU_TARGET_AARCH64,
     .long_bits = 64,
     .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 73546fa5737..9d558a0c1a1 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_arm_system = {
     .target_arch = SYS_EMU_TARGET_ARM,
     .long_bits = 32,
     .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_ARM_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
index 752c813077e..c1d94679c7e 100644
--- a/configs/targets/riscv32-softmmu.c
+++ b/configs/targets/riscv32-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_riscv32_system = {
     .target_arch = SYS_EMU_TARGET_RISCV32,
     .long_bits = 32,
     .cpu_type = TYPE_RISCV_CPU,
-    .machine_typename = TYPE_TARGET_RISCV32_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
 };
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
index 5150f0fe9d9..f648a5c8944 100644
--- a/configs/targets/riscv64-softmmu.c
+++ b/configs/targets/riscv64-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_riscv64_system = {
     .target_arch = SYS_EMU_TARGET_RISCV64,
     .long_bits = 64,
     .cpu_type = TYPE_RISCV_CPU,
-    .machine_typename = TYPE_TARGET_RISCV64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
 };
diff --git a/target-info-stub.c b/target-info-stub.c
index 22b7911201c..d121b8c0170 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -29,7 +29,6 @@ static const TargetInfo target_info_stub = {
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
-    .machine_typename = TYPE_MACHINE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 #ifdef TARGET_PAGE_BITS_VARY
     .page_bits_vary = true,
diff --git a/target-info.c b/target-info.c
index 04c69c41f8a..012b384036d 100644
--- a/target-info.c
+++ b/target-info.c
@@ -32,11 +32,6 @@ const char *target_cpu_type(void)
     return target_info()->cpu_type;
 }
 
-const char *target_machine_typename(void)
-{
-    return target_info()->machine_typename;
-}
-
 EndianMode target_endian_mode(void)
 {
     return target_info()->endianness;
-- 
2.53.0


