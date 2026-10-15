Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97690CCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5I-0005Ur-4t; Thu, 15 Oct 2026 17:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4Y-0005Co-Fd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4V-0002SR-Ua
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FG5aiR3493055
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6gXP1UJIWt0
 ontxxK1KuiUet2I0wX5ybB8XqrNjGa/0=; b=S7pm4dZwPSgJ641aMlxeUmdjgdg
 OjkKllkwP4eaOomgeCB0VEjgl3Do9sf+wyjQfrQ5RuqZK59Gtf5mWqG4cdRmKS19
 ML2S402WVdpJmNCv1WeWVZS/pdAKRye2kfd4oDstLlTdVLYCltVfkTyc3l5BHz2x
 GGvYTcSNaPH6xJA9fmSh8WsyjtbdzOxOzdZ03vTdX+5AHg6lvD65FdgWb+rcu43C
 xsW4nyIDRIKPcqho9KxfFeNnQGXpegtGKsaC7Rx6Zn1iWRTvHjVRbVeTfugWU86B
 XxDM/vvyoK8XB5ByBcmh2GMZp1wWFI1bhIzRmleiYEKFcbRbt1su6uz1tjQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb21ws6c7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3a4aa263a4aso1792728a91.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099976; x=1792704776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6gXP1UJIWt0ontxxK1KuiUet2I0wX5ybB8XqrNjGa/0=;
 b=S+Q2hRucIDrfEnZl/RSbGxBZaaoo1wwZS5Cjxy7wxSry7QIiGvov4Y1rGyCJNL/G3t
 svwh+MWAkqqurHPHbxXt71Vpvd+qUlucL7Cb/d7HDw6u710E4iYG2Mb4qXhIOLE9mSPJ
 v36xBZizdG7WHPpebxbogl0LnKLTZYJPWuJCGtaJKSDAVOmIWDi/AgBa/Vtaw5s5PQPR
 qFOug3wJ7ou2eknu4cRPZw5EtNPdm5vFOGVgEvnHPGpxbbwJKST6HrdvbN0A3c5eKcpU
 bB83rSRJUuSmBpaYC1JQaUM5nwEWXbK97eFvBSfr+foCVm09GBl8DbW/Goc2sUVSo2DQ
 R9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099976; x=1792704776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6gXP1UJIWt0ontxxK1KuiUet2I0wX5ybB8XqrNjGa/0=;
 b=tXswD7YSvIMnHJhbY5KA44AQcBolzeOFW4M0WOrAAGqtS5qWWSuqux8t1JQlTEFjUv
 jBBK0tZW24W136bbd/SClXPYUBHXG0Pp6Gr4h8iFXDNfL6gt/sfosvRiEMSweqWL95rd
 Y9kzAv4mc8COVh+YPc17Ed3ZVUoZ8x/8dkqMjwcGoKCz6ugIkmjVIvPStcGBwrNO7xct
 pIfp4IbF0Ol8UxaqYo3s1UGowMqMSMGOif6wxA2JI6LrfMcs6sdHJ79hev518Bxwt932
 WKQh2IaCYM5muxsktb+YrTNcGUMnoY5JuMExZxEKSgCRXVuJurE7aNP12wVuUK24xAe1
 Pv1Q==
X-Gm-Message-State: AFq9FYLh7bIH7AJattQorq94edppXXrgJKgOVRzLUTtPVad7pKeZtNku
 kTu+VY4Cwiwiv8C2m2WXvGQ4oqeofhfBa1guRbSYwpKxbLbLfFu1ck3Eq/m45PkVW06XzoJWpfR
 FftZw1PJ9Lu2iKG3epnJk9vlZctSACCio07AjR077VazWZXTi+F5ALxwcAv57GqKyFg==
X-Gm-Gg: AYBFou0xdq9DpLe4Veea4Z0ZWNgyX0j3fPdidNMDe3RQ/Rfe/1d3SP+sp1f9xJF1y81
 4Q7vaAQg4HEHCWqPmxrusQr/c7k0d9hynlaHOoDPmyyivNonZOqHpC5aDEcSSN3lT4l7Kyhrl2l
 d7qBeHE1yzLGZ8oLKNRirC4a2LZHOOrGOhLT5jXDrzfKqejyCSE0OT0MGFCkPuLD4lipZcLbksE
 P8cA+0a7AI+Nj5oKLOTX4+PAKtDJROdQ9fwwHVSMGOFzQCFbnEfPn5QU8Aum/753/tHaromGyP1
 XnnFLKjIVrbhJGlZ52kfuGRzO/oOO4Q155zwFI/c/Hm72juR/eXmJVd1Izk+MmKlLwdQB1VvMjg
 t1u9ea+7hlSGzV2HBtJMwHekCu8lIOVyC3u90m9t9k2RxNyNeMLKF4CFXh1JBRoQ=
X-Received: by 2002:a17:90b:518f:b0:3ab:1481:69e5 with SMTP id
 98e67ed59e1d1-3ab3a912263mr16829071a91.11.1792099976028; 
 Thu, 15 Oct 2026 14:32:56 -0700 (PDT)
X-Received: by 2002:a17:90b:518f:b0:3ab:1481:69e5 with SMTP id
 98e67ed59e1d1-3ab3a912263mr16829059a91.11.1792099975531; 
 Thu, 15 Oct 2026 14:32:55 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 13/19] target/i386: implement get_note_size sysemu op
Date: Thu, 15 Oct 2026 21:32:30 +0000
Message-ID: <20261015213236.157767-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DmZSyBcKGe40LaisE0wg6T6Cn-qQELDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX8xSAKL631N19
 poJDv45HdLBFj5AnzX7ZhyhCVqRheFKb0UYcVaCTBV8W7YCGcKc1is+g59txPZ4Ws4lguC3pBC9
 lEOJpyhztIqmSQgZI+xv3Wcqf562tQ0I4DhwYKAZRZeEnZVeij04KrESA2h2qhlbjrJKEOE57JX
 rYVA305imwxR7Vut5JaIyymzJ7nK0aH6b6G+9jmCkYY7xafpN6WdOZyfeGZPH+fJkmogb7Pe4DU
 beuvr/HNOil9aI7/XgXrrGWEmoMOltVeszxh11C8Qr/dI+wlxWlSDIgN8p29PZTGCuFzPO72JP1
 w8VFDhZbyixez9oYH+5WH7LOh9YZaacWJ3u3faBugooxo1cwym1qoxQCqPxFAy6w6wC+oULab3I
 YT+OnfMefvyJ8J3tsc1FqJkOONFzRvs6hA26AKxtSmT4Di7y3MHZsNYA1np6LPtlA51bOVgFBNa
 40DScHf0rvSB4yw+95Q==
X-Proofpoint-GUID: DmZSyBcKGe40LaisE0wg6T6Cn-qQELDJ
X-Authority-Analysis: v=2.4 cv=R5qWitRX c=1 sm=1 tr=0 ts=6ad14688 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VkRzHO9NBAn2Hx42XgYA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX0CR5/6e9px34
 mt+3RVQLCTfDQ337h7XLCDpB9ZhG++Yg7AbJ6N0z7gK/ZqpcTbLjHDruMV2PgfwPYDwBRbHgctG
 sfeWTKJW5Gokcf4tp7goaxUy3SzOmgg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150085
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
 target/i386/arch_dump.c    | 8 +++++++-
 target/i386/cpu-internal.h | 2 ++
 target/i386/cpu.c          | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 004a639030e..4d8e9374cd1 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -430,7 +430,8 @@ int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
     size_t elf_note_size = 0;
@@ -460,3 +461,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return x86_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 9407b01d415..a01ddaf9254 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -70,6 +70,8 @@ void x86_cpu_machine_reset_cb(void *opaque);
 
 int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks);
+ssize_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus);
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 03efc411ab3..c23c504c5b0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10920,6 +10920,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
     .get_dump_info = x86_get_dump_info,
+    .get_note_size = x86_get_note_size,
 #ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
 #endif
-- 
2.43.0


