Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC32ACCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5G-0005Tv-Fy; Thu, 15 Oct 2026 17:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4I-0005Ag-RS
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4H-0002RP-8o
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FKW95M3462792
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=l7vWUR2NBQz
 TYrEo7G1rdYbbb4av3psrS4iU7yCmtKI=; b=lu7htCnAQkb5zAkHd7ZGZqgQ/Fy
 kY51a2ymipXdQHHRv4KWaHb5j7whNAQXLXN3VzLPSGi3ZjOeBlW841KzVfRSaMwz
 7McpLrkEVRbqJ7g00ITn7BYmpSPjlwEELkD1/YDaRvroZULAWBrCamZkxRjJeg7d
 CDnc4hqbWCZYm6KqCJSqK5EtCkU1xjpmHgFBnKlMdLzSy4IY+xCT5oAamlOZInhy
 TSSd0FKd4pPvSMEga+GSy2xC2vyDT0CI3LiUZFYugCwE8aI7ISsucBnjxoti13jA
 Eumv3iU7NjML90ZQlC9eGgFgSl1MWvS39FXGibHgwpv3FhfqK9pa3orIdBQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69v4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3abfcf726dcso2743304a91.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099971; x=1792704771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l7vWUR2NBQzTYrEo7G1rdYbbb4av3psrS4iU7yCmtKI=;
 b=Q2b3kkOiPDr94IFhuUOuem3NNCDajTI2sOxstAXIZlyEhvFfTmmhNhqo+rNmPvxfIH
 AiI65fk0aYZ92ajxnATyrMwYvBF8Gv6btfCmFe/aZWcPlN3KeKbNl+hmUT/1Yz3gYuwC
 OhY9Uen2RjvIRkNE2iEdQMflprGycVoUY4ueq/eUUGulJZ+6pgkEMQIVLApTDe3fI+G/
 tJIzPBlCslLFY3IQ2370JqxZzwoETCkIfwFWM2dClbEYoWtMOJwxL0WMSS8xKflVcw7L
 rfY4t/2TDYu8VbsYvH8BnhE/tDx4G6opeWDdsO0qyeLzla9qIEQ0+T+fXRr2wBcqWu8q
 d3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099971; x=1792704771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l7vWUR2NBQzTYrEo7G1rdYbbb4av3psrS4iU7yCmtKI=;
 b=nxtQ5qLNSoURNnzGBWIaSGIxVEutFFMMXeXNV9hxrdV5s2rOp1SIXRdAgpCzU7HQVJ
 qvw0MBPdQwkreERO/dhUt9IxZUYHj8z9ArGh9JmrM6laal3E8j+PCqv/inTz8kpLgBfi
 iJ51CEJmDfq9U2g9SwGIzjpRSmYyfAfZ9AH/Ry/rpQHktx3v54KfiU9LJFIjikid7O1U
 8dSYdVWqxHd9bq035XeQlH42ZLsL3jqFp2XEGiZwK1MkfIqPbsQ47vXDC/iRhy9RMlwH
 qd9/U5Rep+hSt/ydBhPDcESBiqib8nlwfoYhcIlPbQfXuKB00lsJyQw4N5RyRrY72scD
 proQ==
X-Gm-Message-State: AFq9FYLsQz14bVNlh2GCeH6hr44T0g9L5EaX6YLwmel0FXnEofLUDbUb
 x219KwQPqUS4g/zXXZK62ZYmWtzSVizQwIc5zrjG3Xf60a19pbkR1mupTnXk1lmJutDXO0hEIVd
 wSy1z+XRtlXLwh8HnVa746QQSGq0JohKI9MKZlUgXbjeoHTW340fBI9bLSYXwDbXIPQ==
X-Gm-Gg: AYBFou3DqFN0f7G/GirWGyqDjAyFIeZtSG9XzeoUsgdk5d2vVJR86xaw8jfD5iPXUEw
 cEhGOr7CpDnvsUJaCLTP0ReFHCxZ6uvnGeDgqbZrigy5IeBNKVYTpLU7ttaXx4xG0GyJKWoGQyk
 HDHrSiIq3gOiG78nPtWjz4cI8i8C6OOW2kSNVz66tEngSgN/U31/Bkhfbb7ZuM/92O1ROOwWEYp
 ml93o0vmgYVvc++Jc3L5pCgy009NNzlvHsCybqtinrKSoNjr8Fm4Pe4SMuvlg7pRRT5OCcbU3Q2
 WOItT/0SA61laVoim4dDB1k7iAzDm55vuA/KhMbmVnD8mzIO1P57B/E1fdM38aCDV2MKE28BslW
 cVreiTUfo1TYQJ/tvtsjbH/mbPssEU3m7rf7mXg+rHUtBO/BNvLqfS125DNVjY5Y=
X-Received: by 2002:a17:90b:2645:b0:3a8:10e2:ad08 with SMTP id
 98e67ed59e1d1-3ab3ace48edmr17151839a91.48.1792099971371; 
 Thu, 15 Oct 2026 14:32:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2645:b0:3a8:10e2:ad08 with SMTP id
 98e67ed59e1d1-3ab3ace48edmr17151814a91.48.1792099970778; 
 Thu, 15 Oct 2026 14:32:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 08/19] target/loongarch: implement get_dump_info sysemu op
Date: Thu, 15 Oct 2026 21:32:25 +0000
Message-ID: <20261015213236.157767-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dT5pGRa-6QLS0mTbpPtj7yn5eUR_lcoJ
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad14684 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=FnhWYSpmk11jPv6NQAkA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: dT5pGRa-6QLS0mTbpPtj7yn5eUR_lcoJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXwQ1eW5fQpfP9
 Y5DQm9k6WtZPoXWxtJRMYUuGw9kpHIpdtkXsrLy8y3TkC+cycwjQB6340AxnbM2bvR30ufCzinK
 +LjTA4HIlhZZn64RLKQpNCZ8MnWcz/EfISKoSOJIL6klXtqRPm/1DGUgoWGC2d864UaeUemklmp
 0Pro15TfgFBexUjU6a1Q/0NPHd+SC/RIkrvVRl1QUw4Eb9W8OiNC/2zxtcnDeCaBF3X+ywbkza4
 XAmWjohmZOhdyIzmscxY31PBoLipuohvxx7qBg3Ls6TEUg9796W+KKFueL8aQUVwSHcCdAHkZMF
 WssUUQ0xbY/wMrWY1s4IQILwRrfFNlaZL/G3yTBg/KbyaCoGq17c/EggWM9zEtx43aUVTamSjc3
 /8jzLBC0pugwe6JNnAOxfWj9Vr5B6S421LwuBWoMFpiE4u2iI9O2k2reM5oOXq+lVKqpLiSB5eK
 yan/fEVgnbGrMb+yUvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXwIL+l0Ht2G/b
 qgtu8V+F3Qm4RdRT2oR7IT5yKDVSiWgoDWN3sE0SM7HsnH53qwhBqscD+uyqzZJg+StFW45A0OH
 4debzLpDy7itGTku0UeWNTX3Y3U746I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
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

For now, we keep the global cpu_get_dump_info symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/loongarch/arch_dump.c | 10 ++++++++--
 target/loongarch/cpu.c       |  1 +
 target/loongarch/internals.h |  5 +++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 9d84faef969..e216e906414 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -142,8 +142,8 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
     return ret;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                            const GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_LOONGARCH;
     info->d_endian = ELFDATA2LSB;
@@ -152,6 +152,12 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    return loongarch_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size = 0;
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c26998979..65772f30947 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -841,6 +841,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
+    .get_dump_info = loongarch_get_dump_info,
     .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
 };
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index ff956823fd7..d4bf30b293e 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -8,6 +8,8 @@
 #ifndef LOONGARCH_INTERNALS_H
 #define LOONGARCH_INTERNALS_H
 
+#include "system/dump-arch.h"
+
 #define FCMP_LT   0b0001  /* fp0 < fp1 */
 #define FCMP_EQ   0b0010  /* fp0 = fp1 */
 #define FCMP_UN   0b0100  /* unordered */
@@ -51,4 +53,7 @@ void loongarch_cpu_register_gdb_regs_for_features(CPUState *cs);
 int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                                    int cpuid, DumpState *s);
 
+int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                            const struct GuestPhysBlockList *guest_phys_blocks);
+
 #endif
-- 
2.43.0


