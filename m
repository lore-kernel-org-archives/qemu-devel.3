Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC21ACC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT5C-0005R7-RE; Thu, 15 Oct 2026 17:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4X-0005CZ-90
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4V-0002SO-Ix
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:09 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FKDTmP3462814
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Hx0EUtBc7dv
 XA3AGksgltf6SzhPv85okwXe51BzfITk=; b=ZomGKGjV7jBvXZMMxVXPaDz2hk4
 JMcdfUwlkDgSNgbLkE44/WN2E1slZTx10hMtk9JVxLA75RKnLWlztstd/hrt59fJ
 6rPTL5ztssYFKvcoUXO3aps6MfjjJ8xlH81N5NL0MwMHNb9d96LjKN1vjy3+tJky
 iKpTyIYr1b10zhTYHAdQk165fF0viTJc43VuhIjsTm2Rw9/6ziFRvVPa0hc9Ypx3
 xbMeAHmm8q5hjOBCocJnLzIG2qszegtJfARZRye/ej58T6YD8flRbbPguc0VVpRi
 2yd+5OIfx9oFL5hcNN7R0EKRubaBYjkKrUW/cbj7SI6DrBW87hzruTpfg/g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hayu69v54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso2984305a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099975; x=1792704775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hx0EUtBc7dvXA3AGksgltf6SzhPv85okwXe51BzfITk=;
 b=fuZqPd8EP9TkM/VkaXcl8eMTnfQr73QHbtcOee1IaQNg75Wpc5kUPgNhYLoYTzfzmG
 XwkxHVd7e3mNzq5uKLCP4YhQmhzj4W2Xb9kjCC8BN34/wfM/9ePJ9VNVdb7jhcl0mJTA
 9WM843sAOiTIuJ2iS3T2nIQA9Cx315aaoSv6KRLyYDX6P3oer1qnXm3i/mwMZnnILn+8
 SaZpdlLG9mU51iBdSa0OQKkWnbdTSjgyuhAdX1NZCqxzRfQ/hTjg9PRcc/q0jLgrXjSG
 a0OXyQUGk+/T7h3UoLcj0wbh7hqqbMNHOKoNCZJ3kRS1MjNwbSZLJXCwvYXJbXaq5KR1
 rfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099975; x=1792704775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hx0EUtBc7dvXA3AGksgltf6SzhPv85okwXe51BzfITk=;
 b=ZqA4A0C9X3m8Ld4BFqwWsEzU7qBt1wtul4M3A4SkUki1qwP44Q68Bx9/UDxIDSC0kr
 bsZTdI3uNP98jHZSbFl+1i5wXvGmX+UQqVjhrX8TKkKTlma+10J5MXASnSMN4AlsTxJW
 kR2GuC25/9+twRM9EZ/Hy83GZ1m4UAjCkezcu/v2cn21dccjwcXiiZbsv/jPQCwBH4m0
 i7xOiQtU2aIG5iuhggvqirqZa5bvEndM+mO856wQsP1oJJQMsS5ZdkiXwzoy1uGSHH4a
 hmBjJzhnXXz/FoH522NNEq4MGeDJhaysbHNs+YdvYs+8CL/461Pi22CFNiBUK0KsmeBV
 GuRA==
X-Gm-Message-State: AFq9FYLqRkXE/8NkWA8tDYx9XXGeyB5S/WYyHEcdf0RaE9iAFVD84ium
 x1DOK4yVwQSLPy4IMFYKBbBsZXrYi6Ag/eGxLgYmM4L36H3J/whBdw/tbErMr1nijmKxEmAJiS0
 zsxxUuQiPPsI5BUDfiEjlRrx1UqN4FkQDNPgDSwrqIoWgBSKc+DAZTi6iwodnHY7ncQ==
X-Gm-Gg: AYBFou0I45kzlRm0A2hbl0fq6WgNWHQp4MQp1LWitEOJoebITwwc8pNyOWsanK+EcCC
 /IwYz6+0Qw7cEnkhlQ1GcBMnrcjsljUNhnkazcqta0MLdkJZAEquaAK51uiHO+jhJ+KmrY6waBd
 C8vw2OX6Iivnwy0EUFUBdVjy9k+zsuE6U+M8lgM7HOQ/XIdAfBoyJTWtNEgjF7UECmNeufIcis/
 WUftur/Izp1CWP4YaLhJm+YggGSHwsv7G9+8VEIh82kSoU/NOExC7Z27Qlu9tESc7VuF9iiMDwu
 fTVCrT6xLtgc91YRFMt8wVHc4yM/w+k7GW7fJwG0Z/79SAG7QRl1rDI4IMDs8lisPhGyl2bM4yS
 Ajt40g1KGdQ/LJ/Y/k9ifp66WwWGbEGUNl022Rwnvjzy993ffVdxZQ8PgirTnkxE=
X-Received: by 2002:a17:90b:5823:b0:3a7:9413:cfae with SMTP id
 98e67ed59e1d1-3ab3ab1d561mr17607903a91.42.1792099975397; 
 Thu, 15 Oct 2026 14:32:55 -0700 (PDT)
X-Received: by 2002:a17:90b:5823:b0:3a7:9413:cfae with SMTP id
 98e67ed59e1d1-3ab3ab1d561mr17607884a91.42.1792099974927; 
 Thu, 15 Oct 2026 14:32:54 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 12/19] target/arm: implement get_note_size sysemu op
Date: Thu, 15 Oct 2026 21:32:29 +0000
Message-ID: <20261015213236.157767-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E5iCjxZxsrtHl9EVVDqo2v2msAbA66bl
X-Authority-Analysis: v=2.4 cv=ff04WEQF c=1 sm=1 tr=0 ts=6ad14688 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Vcmh8FhFDDEcUw5d5KwA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: E5iCjxZxsrtHl9EVVDqo2v2msAbA66bl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXzv/hBkHVMaOI
 OXWhv8lDS3v6tqmSUEbjTBcH6wJerde7hOfQdwGGJXVXIoM1HgrbX7rMMYcc4oa8B9OdwtfYQ6H
 gusgnfNCGh+flcsJuDRGBRCIGBZRkdMCPQZ+UeML8r+hKIDd2QnrUreufTYNSJmQx8TlVwa9nPZ
 4UR4wdG40ZSKmuN639tiBZapC/vEQlzwsV2HGgvbTqbRqFUAUYgKzCXgl77tMLa32B5ltCjOb9j
 ZVgHyjgisyEkSum965wGhAwvZhxVuDpJLZERofvj2+eERDda47xGxoweU0r+23b+YvjXOt547WO
 Ltc8Qf21W5SmDmT2tX4l06N6Hgii2lnUfJINsa9KQrZG7d/HonDFziJvciHXkLHgdkxTi+gSNhZ
 46/XoQTun+aeYo0S8GMYaHyqf097aUc8eUAHb9DTtszBcyz2+xjus5TWFIQYkFfN23e1AIgc27h
 XfNUqEuoX/iLtw7nBeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXyA99Rhf5Z7ja
 FHrRn00g2EH8nstDwUCqsT6zbFog9a4sDAR/X7Ko1rp+HLd77t0hFx3ZhMfiDGyISG/QfViF91D
 Ob/8NJ+aRrs/68PpRCw6ZfSlOkayf/4=
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

For now, we keep the global cpu_get_note_size symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/arch_dump.c | 10 ++++++++--
 target/arm/cpu.c       |  1 +
 target/arm/internals.h |  2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 181691b81c6..60456e81bf8 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -432,9 +432,10 @@ int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t arm_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus)
 {
-    ARMCPU *cpu = ARM_CPU(first_cpu);
+    ARMCPU *cpu = ARM_CPU(cs);
     size_t note_size;
 
     if (class == ELFCLASS64) {
@@ -452,3 +453,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return arm_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7bf0c5e74f8..73fdc6e460f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2570,6 +2570,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
     .get_dump_info = arm_get_dump_info,
+    .get_note_size = arm_get_note_size,
     .internal_is_big_endian = arm_cpu_internal_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 086d9574ced..242165f5649 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -441,6 +441,8 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 extern const struct SemihostingCPUOps arm_semihosting_ops;
 int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks);
+ssize_t arm_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus);
 
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
-- 
2.43.0


