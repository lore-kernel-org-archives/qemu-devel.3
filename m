Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C3BCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmTI-0008QA-Gg; Fri, 16 Oct 2026 14:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS7-0007BD-JQ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS5-0000ZR-56
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE652i2154151
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZJTUBbppvqI
 wcAW3gV5P2JMvWJGJ4tya5Sf96AkEhzw=; b=Tw+f2wd1tPMfRgY/uGwoHnVgF83
 YBLm4udxvlzNpqSGpsitTEgz10cmjs8cg7AvxH+7ikVQ0NrQyNKZa6NjNfWKQGYw
 Q+WxQgTozR7ifBVFR/4fC+dlaxA4xbPOyC6o5OW5Z21PqXDwOfYDSEyiS+TGG3tM
 o9pNohX/ofQXIVD6tt3HRYXX4ZsIXYzjsv7U6DFCZZkAL5EH/W2d6JQVrFZ4SXQ6
 dJ2BTvYrX9HRHN3+2cYZY+XWvRdeKcUy2GmjUqXsGu7BCPUsNmvNYSZ0ierUquJw
 +AVdSllPpzAN4A55Y3P3Cx2BSgWo2BBThzUJTR51FT60XUeBWvmF5VM49Gw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumssv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so411932a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174483; x=1792779283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZJTUBbppvqIwcAW3gV5P2JMvWJGJ4tya5Sf96AkEhzw=;
 b=BKVGGsDiOD3v2yHDA12o/LuGwhgV/tOpYUaie5hMNivM1883G5jh63l7ZzvsMopvbH
 8h99WLQ1BKoQAEAEB7W18qvInmBQeHaLBdaeetSSpYYL/L5TMneKdzedpR7b0kJkEU3J
 7Mt+0kAm7RWhQAXhTog2XKyKOU70LF3oRMhf9tQSLiVnjFazAmkGFY585FeVAZI7C9jb
 I1C9Bs7tHquABrKSL8apOoGyIw48H5fIdsIZx4LbJlZ6huvRp+tiAkO2VjCqjvABsQRW
 g6ZX2OrLwbMzIIWacnwvwqCpP1ZatRM4K/n2zdRwXy8XpeKJIQk72PnJCvk1hnhazaHW
 gaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174483; x=1792779283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZJTUBbppvqIwcAW3gV5P2JMvWJGJ4tya5Sf96AkEhzw=;
 b=rrHZZkmriWojz+vmsVsAzIOsRy5wCdEICga/Lhtzy3IfgELPbb0ded2pkMf7xdhaJV
 ZCI+iDFus/dUYpX9o13Co+zFSBLUtx+EdAoV3ZvKX+wh0qlIiMx8RrYMtMXWXr0L62a8
 DxGubf4nypEFkxYCZrcRimK09LhZZRIlvGfhip7ldCEr7WV60GccrG9KQ53LP7SADz2S
 t7dgqlhdV226JYC5u87yMJpM0WSVSjXK0OKDenh+Kbr8cXeg+t8piYwRRrLUzg+y0ehS
 Qtvk198wCh7Dr5Tp45J61Hjtz5Jk6VG8ehn5Ckd7HmoJT8qnJy9Qq//jKF77Q82Wfk4s
 bTCQ==
X-Gm-Message-State: AFq9FYLkMPH42CK/egNewMeQaMPA1z78+Vxn7W0kAHd8mhYRFtuCCzCU
 NCnp79Lew3miivAEpo5+8Ji3A60bx4A1r02uJlTq1YVBi6DbRYkq8ZwIYSIIIE3kTtiN67TS0S7
 FK5SxzMYp1tNQyumeUsJHl37uwAnvTXeVH2Df5yBcbIAXcS6FUfzNun5l022AkuNnAQ==
X-Gm-Gg: AYBFou3QDaPF1C5XrPibR13nQHHc4xpb9Y4V6Y4bhgkvq565puLczN1rpQM1GxWBpqQ
 cRQ0/QSYiPlvtZOGvs76IUMYbdELNcU996iMYmr2O+QARCWwsunl9ggvvAAfT6+dPJEWrRYGZJB
 g9gfTCCVgb8e7kxPCrep6V4r+/Wd9+M3NW10I1XERzQpc2HfhfXCPUYFmyngxOBEbTxT0djSmw6
 SOU4LyhMyWRwUjKUcelKRCTc1MojSbJ/oiniMtAceKw3NxsQFH+Ji3F0u1x1rfE4vt9xu04jCbO
 g1RMr1U0lB2mi3JP+lCw3ZZlzhtvrvju3X8hferUTqF7ldG3ILx5VleSrEy5soyA+GXe2i1GTOt
 wz5Yyyk158Mxi8WfRd5Mwuyr5GBZW9Xb4gm0CfYOo2KPIuCezLSHynVDtZer3hRw=
X-Received: by 2002:a17:90b:3a50:b0:3a8:d71:5fda with SMTP id
 98e67ed59e1d1-3acef52ef2dmr555455a91.63.1792174482594; 
 Fri, 16 Oct 2026 11:14:42 -0700 (PDT)
X-Received: by 2002:a17:90b:3a50:b0:3a8:d71:5fda with SMTP id
 98e67ed59e1d1-3acef52ef2dmr555438a91.63.1792174482134; 
 Fri, 16 Oct 2026 11:14:42 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 18/23] target/ppc: implement get_note_size sysemu op
Date: Fri, 16 Oct 2026 11:14:05 -0700
Message-ID: <20261016181410.191743-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfX/vYges5I9uh6
 wnPM6sco02mrvbLZOT2fKImiaumBhDQgW8aWf/FEoZ/Dcv8A2KGBVy3qQyEJb6inLNBzHq1LHKn
 GEyHM2Iuw7eCr76ZlI9Eji2ryiN+IP0=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad26993 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Lumvk8zKUu4O7nVSwh0A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: TG7iJ6fbh1phViPzcEunI2NMphK27C1U
X-Proofpoint-ORIG-GUID: TG7iJ6fbh1phViPzcEunI2NMphK27C1U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MSBTYWx0ZWRfXyDqNt0OCEIKa
 K9MmsRCVorc2LWelvjAfsz7OFD3RRR8F6oyFlOMVAVnGJ5CJjTzKrr1Ugv94aG+xGEG3JRktaic
 7FJkRnfMHZdtx0InHLUHZlsjeIbm0fD1vVLqzGkrIBORsN22W1Ez1UkDr5ddiNquHx6oJ9wojtg
 vVV8tXL5Fs3cNAjosUHXPYdhi+shAHigHtnRGvAIrcDhvoUcUdsg14Ddxnw2VvKCF2hTfF+xyGf
 RgWuK4TeQO0oZ2ivgEIUyv732E6ddepUljyzQ4nrjmnUOGXjHovXdu94jmcLpJ8jE+Icwp20mxM
 mPxI+smgAzbMU2rfHerGEWRlkStL5h6EZ1dWfzFAMT3Sm8Lk2ro9hSbhCkhINRybY+t0HdKu7Is
 vWBMVA6AaPMntd5q2H6+CgLYa9ayce1UhxSd7ePW3lKxS2ep0N5Ab1603Km8Z55IYhD6LuuKPk3
 Ip+7CDUEkHbBJHa6cSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160071
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/arch_dump.c | 8 +++++++-
 target/ppc/cpu_init.c  | 1 +
 target/ppc/internal.h  | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index c70c2d0b125..b59fef3c48e 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -252,7 +252,8 @@ int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t ppc_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
     size_t elf_note_size = 0;
@@ -268,6 +269,11 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
     return (elf_note_size) * nr_cpus;
 }
 
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return ppc_get_note_size(first_cpu, class, machine, nr_cpus);
+}
+
 static int ppc_write_all_elf_notes(const char *note_name,
                                    WriteCoreDumpFunction f,
                                    PowerPCCPU *cpu, int id,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5853a92bffd..578dd9194eb 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7474,6 +7474,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
     .get_dump_info = ppc_get_dump_info,
+    .get_note_size = ppc_get_note_size,
     .internal_is_big_endian = ppc_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 4238692a9eb..c385874aa54 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -327,6 +327,8 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
 #ifndef CONFIG_USER_ONLY
 int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks);
+ssize_t ppc_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus);
 #endif
 
 #endif /* PPC_INTERNAL_H */
-- 
2.47.3


