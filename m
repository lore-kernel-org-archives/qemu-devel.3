Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA4FCD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 20:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcxg-00062i-8L; Thu, 14 May 2026 16:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcxV-0005zk-8s
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:47:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcxS-0000sG-MZ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:47:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpJf44020774
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hzdzUOAb0P2
 K9inq/1huO8u0DZLWq1z14TOxu5huFgk=; b=SZ9uBqtycb6azQpwIrs7DKu8h2A
 z8+kj0wx4iVXJBoo3nI2n9/sy0xtIkoU+UwxetU7V//w4DgdJjoyamwANkMvdgz9
 bvQeVbT2ZHq9RsExuBi1tEO1F6wKtaketq2DHWbZl370TzhKfu2Sj2aCJaPfc79b
 EeZwlzV1yr6pMi1UYvGSpx4EBzuPuXAt5aWfdaJn3f2n4shnYfn4V+OSpd+IPgyc
 ZnBZ5KADIrK0CICWMFMQ/ZFW4DyD46IkVHmiSqnFfFpDmcQbf0WvGD3yMxcUvtCF
 ZmIgXhTh24M73dt+pmmn85y7MmflVzwXo8hMt3AnwtMEtTgQlm3SomYhkLQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1rrc3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:47:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-908438e5f47so78025885a.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778791620; x=1779396420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzdzUOAb0P2K9inq/1huO8u0DZLWq1z14TOxu5huFgk=;
 b=j/TbuSfzZ5mlzEhTttyj5vJFXOsiB/2qfbNgzz0nnenLfFdhf5kUW/9SxGPlJAAIuQ
 GBH9w8TQPYnISxYw6f4vnBjwd2yn8GUy7wyq8otsVU+RIi0dgqeQylFz4SIny5vKsdz3
 uwhMaSf9QhlPgXBTYMjbVIb1japWWYCIazbsm9uVNAdMdYlU1kpDyr0P9PfxhsmtSYPU
 lnqEr8YzVkYxNjHfC1kEuNuuLwcdsQJv5vzEI/RMzoDYTmTZsRRVoh7lFDzjj/uKa8ul
 FnYK7U3ia3TuEDal0LdZrADjIxw958z35iv2sVlid4J2F9L3iLEbQimxDnbABQWN544v
 XkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778791620; x=1779396420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hzdzUOAb0P2K9inq/1huO8u0DZLWq1z14TOxu5huFgk=;
 b=dY0z6GthB3jOmgnhWQeVFdql2Ch2LR44ScVE2kB2mrTQQp1ilW6h8D10GwRjp/ImeO
 54pI12X+dhtQIL+Yuv6JKBUEjYIbK4Z9DcFWSHdPx1EWcM6kmPoiY8eeSm3QvH63Odhf
 njIs6LZOLYV1uagenZ9OI74QniIi8tBsC+drrCXV4vyXYp/sbRTSa0eQCSnXMI3pZ7qK
 y1hZ0PZtGbkvsb0sru+0oLfReLi3hQ+ZuJnUy8xoFcKslb5NeMoYcHPtw4j1nYxMaqnB
 wIwvbRk9KnhOsbTu8HNrPkO8CA04dwTW9sE0jq4pN1aNTGV7QQumF/yNIx300svo+Wt6
 09gQ==
X-Gm-Message-State: AOJu0YxTUcGjR1nfwbdC9sTXB+SaMR0VJX3YQrgo0JffSX6h/nm+VHzz
 zpzjH37+61hgCDPY51eYSHqqtBnX5UpbWKKa/LZL7C4ZoFM4q96oG+YLnBbxg1xI70hLJ7HN3k/
 bfIZPuPb09hehSyBM1/o03tSFnWkkH7jLHz6+VLK9WSYab7quSxZTUime9j4l+PN+pQ==
X-Gm-Gg: Acq92OFIyWjFkwHkzRkHIw6h/1c/j45vKxw6JSxo+oQHiaTsos6fu8af5H7Q7va3EBA
 nCPg+2baq24OBP0Bz6VdZKjhmognrOo8kRlwq4k8Hkap7lfG1A4sMeGPysdgMFBfyDQrh8Hk8Ou
 K/QijP5dkhdAWzRRZpGDGdLDflac5cFlvSGRns5yCZP+AkhgwkS+IV4gsFOdZrLBFeiRlN1jR2h
 Z68oF0H1ruErxAzOmYQE9Im5sAz+c2c6h5qkfevkljZllbZzrQ2uiKnMTeP+J0a0evU4+38x8yD
 9iMM4rGxJP4MdB+rZyDHhMmi+rR1SD5sXvTNt3f75ENvJqVAiXvmsJkh5T/OgWqnAKycYo1vPiz
 JC+CMszOIar2xGrydboLsV7RcK5ZwotACpobUbpd/oodCUnz9wib7upxVoR6P
X-Received: by 2002:a05:620a:3714:b0:8f8:d17c:9f9 with SMTP id
 af79cd13be357-911cf3fb654mr190865885a.16.1778791619863; 
 Thu, 14 May 2026 13:46:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3714:b0:8f8:d17c:9f9 with SMTP id
 af79cd13be357-911cf3fb654mr190861885a.16.1778791619347; 
 Thu, 14 May 2026 13:46:59 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bad2dd8esm343022885a.19.2026.05.14.13.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 13:46:58 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, andrew.jones@oss.qualcomm.com,
 Fei Wu <wu.fei9@sanechips.com.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v6 2/4] target/riscv: Add server platform reference cpu
Date: Thu, 14 May 2026 17:46:38 -0300
Message-ID: <20260514204640.2540054-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
References: <20260514204640.2540054-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vyXZ392n807wQPar9eQas_OaDwMxOtZo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIwNiBTYWx0ZWRfX7Pl1oKZd/KZk
 tsl6YV1H2g4LVu0yLNQDTuh4nWqmG6RfOFJhQXazlyFnE4zBirtt4dRbH4NJaEtiZcP2i0w9ZTe
 nLRrojSeQAqv1gf5YyyRu7bCY2FgyikxKvv+7Ciu4fNXwY8wPjanY0IIxU5cznc4G4j2v/GHD3t
 b0kdHfpTrlP9kyzuTIB3zGsQrix2kJVAynTduJOStc5yFYOh2EFVqNXNrwXebqdcJjG/lOVO/R/
 oGDuAmZSX49m3DI679AOm2txfMbBLGqIHHIWQ3fGD+CRusv7RKbaGGWKkY2r4C4qdp99vmPObB9
 K71ENGlEfXQawRqwUyvn8SEb9uc5gs6PrEW/GWoVfEKREq7FwogmK0pNjJUxEFf9/NwOWa4ZE1r
 SyYPtz9WQMcPAqI8DV3/EJLdyXp/LUNPU8wrav1qJqvvGz6wPnFaVscROf9Mt2txCZ991YxpZJV
 vwwseLYOMTKj47LHoBg==
X-Proofpoint-ORIG-GUID: vyXZ392n807wQPar9eQas_OaDwMxOtZo
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a0634c5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=V1jnuoLLAAAA:20
 a=uTRCLKPYAAAA:8 a=EUspDBNiAAAA:8 a=EVmsHFvQfC4jtDmeNssA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=T-agBWn15iSmxapsA1lH:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140206
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fei Wu <wu.fei9@sanechips.com.cn>

The harts requirements of RISC-V server platform [1] require RVA23 ISA
profile support and others.

This patch provides a new "riscv-server-ref" CPU to go along with the
future "riscv-server-ref" board.

[1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc

Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 11 +++++++++++
 2 files changed, 12 insertions(+)

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
index 586683b28a..c81aab08cd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3401,6 +3401,17 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .profile = &RVA23S64,
+
+        .cfg.ext_zkr = true,
+        .cfg.ext_svadu = true,
+        .cfg.ext_sdext = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV48,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.43.0


