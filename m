Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF91CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5H-0005Tw-1U; Thu, 15 Oct 2026 17:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4h-0005Dv-N5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4c-0002Sk-5w
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3MRc405915
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ON9T3X6hzCS
 RZPGNM61Z2uy3wugCadY3z2Fe+rrOewQ=; b=n2ZE9FbOdFBQ/a1CrVohkLFous9
 JiyMxNP+eHgjsiTirPyNBi/4ZHxk/TVlVvVXjrwnKfhCD7j4rD41CDaftH+Q3pgn
 ljnOl0AK3cLb4QcvnHtrFS/p7A0gi98H9dDdkDJ8YpScDsoVQ23WqzwKiFxi5yL3
 +y34qAhRBgSlFPXeDEinTy9IdMzoTdM8LcXqbya4Z6fhAwnEQUu7MzrJtqRWyhyT
 6WKPFwQNE3ZwkcbM/+Z/Ulx5J1Ql/qjncgujbI+HGhLhRqGNttpA+2VZu2pVnpeA
 mgLcim+Va4Q8gOrNAhxNOxTbPoualWhAiFx4mKakBt0+cZbrNJLUqxlUwNQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa0q1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:33:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so4649890a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099982; x=1792704782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ON9T3X6hzCSRZPGNM61Z2uy3wugCadY3z2Fe+rrOewQ=;
 b=VuZsekwaXqE/9IQg10uR8TqS/N6rpzU37yrcqvdm6pGfbyhUPTj41V5NetXZ3ex0nL
 duHaZhCVYPpTWgknGRQXP/6ylZaonApJINhS77+t6vPj4aWhlQImcj3e4rRTkQfgSz1k
 Ee1Qku5yCfhiDu+dET4QgXc1BVQLtQk0uGl0zw9R5M9BHHs1dVpwrbxlKDx8F6f9nGcG
 Pub5DQba3+66CtMO8xoZEKtTFj3nogwj5rs9NI1m/kPe77ovyPbOxkijNuLF0GuJyqoZ
 D9XNA+jRmshWGY12F2YUlSjVU658yPZbgl/HmXMXInyrkoS2pmLqrdCmZCPlN8Zv77MB
 co1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099982; x=1792704782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ON9T3X6hzCSRZPGNM61Z2uy3wugCadY3z2Fe+rrOewQ=;
 b=YKjDlTzjRBI157dyS5mJSdtRvvYp8+b7LmXoxih2PP7JDiaHNEfBz2w38oCnKL9U2b
 CFOT174fhtt0L8hyzJZVCOamYrXH234uJQZiC3UlmUrm14n6gQNhwVxmhx+taSCnKyY3
 g8rpV41jP4HoEMBago7n+kgKfoKNlIZsAeJu7ZpmWUHuTWzrfJySxKgBmGMfZ+a3HyA6
 7ZsmgF9XuerJhe3fel04k9YpKtYVtdh48aKxvPsDUHOA0wpHpJ94FilqNG3P9/WpxVTL
 ExBR5NgixJ4DOtNKmZ7+u+Bll7tkbdffWvatD6oz1psHnWWkJjnaVcH3SBeyUNWrFDcj
 vYzg==
X-Gm-Message-State: AFq9FYIDprqssEkWw+zjvF/48BFVfDU2dx6WAmzTVgHombgRM0Jzb0w1
 qcXG3i/tUnBsuw1eMoc/Ijf6obOZDCrJIieVkZK4/MmNryRzmyDp5OruYbfd2c3887w8bKzjneU
 d1NBo8jJmrI63zm4+7ZiLAw0qXjLLtbf0V6BwWL98lyoQeKmTVrxwpFfwWfghh61Ang==
X-Gm-Gg: AYBFou0La50F4xMM0jkq2DL1EMQ4AeWMeJXMHJS8TULB9ZYKpeHYSSnk3SBWKddgHsx
 14GPlcaFRjbitta9X4go1J4Lcn/EMhPC1uyKVbtBFXu/i3e+C9OBceD7nzJs4yrlpM/luvNmj6e
 bFMbkUdoNugJfHr/XQ8X4Ivmdz2weOWHQDOHqPA70/0M+Z0jkaQw5LIou8v7UT0yhrPXWuHuD3E
 nIVpFdbpLYPLxYjuF997J94jQ59w6DRgjeFR/fwYoV4XqWa11QXrtc2l+6UGmWagh4PRAY8oeA3
 tS9VvmnYgoVG7AyUcWRfXH0qPsnOpHB1IxaOPmQCz1yGtFvRo+YpznLRoWfnD/LhzwSpCNDRWFD
 cfzqxSyWx0wi/1mQlNjiHhPbTuMulvZnMT9KqAexmXXfbKyyB2v6vPjos9/byDTA=
X-Received: by 2002:a17:90b:1e47:b0:3a4:ee64:b82c with SMTP id
 98e67ed59e1d1-3ab3b06bb4bmr16369255a91.66.1792099981416; 
 Thu, 15 Oct 2026 14:33:01 -0700 (PDT)
X-Received: by 2002:a17:90b:1e47:b0:3a4:ee64:b82c with SMTP id
 98e67ed59e1d1-3ab3b06bb4bmr16369234a91.66.1792099980787; 
 Thu, 15 Oct 2026 14:33:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:33:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 17/19] target/loongarch: implement get_note_size sysemu op
Date: Thu, 15 Oct 2026 21:32:34 +0000
Message-ID: <20261015213236.157767-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX2mhSoQKwEaCw
 EDc5JsIwLNDgYtRgA3upW7gnD/J45sIP413UkNuo5akYN00xobrrtEGoj7jhO1+3nclSfct0Ke9
 aZyH5V5fD89KyuhqWKfRArLjCP5cV0M=
X-Proofpoint-ORIG-GUID: 7qCc9l-ku-pzp5RYmRnjDhRbZxVZoWDQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX9S6hsq503fHu
 aAPVCWHtt1TKqYz/7wULjS0KIwNhC2zL37aAD3M5FpQKgUZutG/2kV9nRhtqT5BXdx1KGaoecSZ
 Q6utQzobBFwWhatZQhi7HGZN18Diq6cEKgLhN6ZUI1ztr6XwnktoSVnPC1L4p/Fyegf4xTF7sNo
 PKBYvvu1QOAvwOIPTbdx8oaYR9/8So8jhx2bfAPzJ2/EnM1cFs0+4aXGrAXyIPYLYGPKA+/0yz6
 2VS8qADiI55NaNqjGVpAzouZui9NVIt27N/fGU482c/pUbBZJIBIhQpH8S+SytODLIkCdjPR8Xw
 GKdggfIQL24oiiIk5OBg2x0udZvnrsCBMOlKWDzPPqnfLZ/5JWCgMWwl1Qb/BrKkeVtI7yGNi0x
 O82Qc6RZCgxv14k6CMvWC6N0Rrje1WCx2mFS6fMycHrGC6d3WI4zqh0NDSVf0mdbUVWXuvshsaG
 J/yp9ptwArXd8bWR/qw==
X-Proofpoint-GUID: 7qCc9l-ku-pzp5RYmRnjDhRbZxVZoWDQ
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad1468e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VoVa20T_UCIUsInyF4AA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

For now, we keep the global cpu_get_note_size symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/loongarch/arch_dump.c | 8 +++++++-
 target/loongarch/cpu.c       | 1 +
 target/loongarch/internals.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 5a0e1742242..e27bd0f6497 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -152,7 +152,8 @@ int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t loongarch_get_note_size(const CPUState *cs, int class,
+                                int machine, int nr_cpus)
 {
     size_t note_size = 0;
 
@@ -162,3 +163,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return loongarch_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 65772f30947..5e182922b7d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -842,6 +842,7 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
     .get_dump_info = loongarch_get_dump_info,
+    .get_note_size = loongarch_get_note_size,
     .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
 };
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index d4bf30b293e..8625529c328 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -55,5 +55,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
 
 int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                             const struct GuestPhysBlockList *guest_phys_blocks);
+ssize_t loongarch_get_note_size(const CPUState *cs, int class,
+                                int machine, int nr_cpus);
 
 #endif
-- 
2.43.0


