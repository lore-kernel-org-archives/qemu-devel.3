Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2669BCCF2C6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmT0-0007mJ-Ha; Fri, 16 Oct 2026 14:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRz-000797-1b
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRw-0000XT-8Y
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG3ZmO3260332
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YdNfohRYOKo
 iDeBK5n9FUl3Z23aqeUr2Fj3mA3sDNzU=; b=VAaCtYYhc9SFCdS/Be7fxROcEoU
 KqshllNRyH5/mHPfohvpaYN+fTgw0ysTK/8X26FcCi70wacLSsrTc1VsVd/8qy+Z
 +ddw+swATHb3goenk/2iOcZq/15+OssOriFVlV4DXYTYqqHZwUiSkmDmrbzh8QUH
 hAkAcGndJQoX5042noXWz2cUBeoLv+IgeFWWcYie8J8LSLDyzjseSZg5NjI/3h8J
 gmeJuGHaAek6pZkMeikgWOnukmbdCRLAz13H3wKwBlM0XF2g4LI3msy9xFbDoCp2
 q6Xm5BnQ9UV4jhcmtoTUWPx69DkUWppG7rwrRul+0J9+kJwpr5WWRRoHrpw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq450gdd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:35 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so216127a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174474; x=1792779274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YdNfohRYOKoiDeBK5n9FUl3Z23aqeUr2Fj3mA3sDNzU=;
 b=Ana6424GMkfS1Y14TERufGGcjvqVE3uBcOnunzXxYWSo+IODKKWqVy733S0IqbVJdZ
 6o4jyt01wfbiDx5JLc6+A17RHWRiFEDkNfcuFFaWBIveJJHSXv4SilIMth6aZA9Obx7R
 eJw0Agc4sSr7jSa1hx7TQeSI9PTwAhF+OEykH9F9qV/XNJbY+q1XkMUuO7+2pthhaMvN
 q/pWeapJ1Y5R+4QMsWks6OoHo6ZIcVc0OgZDaznMvcBVvTvYNrAwlSpB8phXJmQVavpe
 JccPsMBIfmVlMOS1xPCpkKnF2mvqR9SVgtno4JUaLaTL8NY1TZKQhe7xl4bFaD/8UMBU
 XUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174474; x=1792779274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YdNfohRYOKoiDeBK5n9FUl3Z23aqeUr2Fj3mA3sDNzU=;
 b=Sfjmxt9QmDr3hg5mRHBpyubeyT5a59M6509ZcilxMwtfxAPLxr9camW3rMdQrBfspc
 XX5w+cnSKiZMcDp6rZ0KBxZB0KLFnwatwIjGQ32GzgxGTNVAIjGYP5cRxc8jI+QG9RbB
 AxF7g9JhFlRYSv7Cy8JiHHY15ObzeYI2s4+mc+khxf+3cTfxjy29acB9KvZvUh2A4Tfg
 tRXgH+xuFx1SLee03ylcgyNx+XlNFlsfMGhqauNCUZDpS8cnBrmzXhEihi3FDKxIb5tT
 jSOZyASQrp6E9dDcyUy5qBJMFb+oh2TtdvtcEsOigTKD+h8ycv3DIVN9Gcgx1QQTC6WM
 eXMA==
X-Gm-Message-State: AFq9FYJN52ITIPzuBuxfn/3MaIbiHflE4hfjzJsx45kOXMGxWP4DGaw7
 3RkhyKjlP/yhJ8Rd6KBV6qyHCnKme7VEvPMNOUXTH+LBr23z/B6AZnHUekcoyv9hJw/lxNbR4tX
 toEN8OqBLNMOMUufvhtcYjFXQeO/trEFmjwBl3MuglYbiRRYoi7edOtfZUGHdGQD3xg==
X-Gm-Gg: AYBFou24tAfnjh7muzVrnqkjf6iDqcSVxPqIajubJF0bx3d4+Hxb8It4nrpkYlB8lOn
 F1CNwQJns1W4iGugQdUnozEqmZT31Ilflt0yAY/9n4ZEce70t7/xnHiApClFIl9jZTK9CbKwTrf
 0Wn8RBeOosKovSFBbkcKpJpg+Gvw2wq94ZZRkH2tWggzqJFnHHIUPEfWPQnsK6EIyDrH0cwa69P
 CBccEPZ5TBzZInN8GneHQ1cjUH7Smad5SRmqoJ49kg2RjSvfxT0JKfRV62Wwf7Zs6ROH6VBtWCR
 q8V89tkFU8VRNRGHxyR5VdUXl8TRbfkvwRhblTG1uRq2M/w5LIlw50UD7i85vYU7VjcfD00bOPF
 2ApMTVPEOl2RL67GnTzkrSMN3hPCuELaw4SK9bTvwmQWEKIJBUbZCcT6q0Y+n0eY=
X-Received: by 2002:a17:90b:582f:b0:3aa:f4af:1e0b with SMTP id
 98e67ed59e1d1-3acee98d90emr603844a91.8.1792174474395; 
 Fri, 16 Oct 2026 11:14:34 -0700 (PDT)
X-Received: by 2002:a17:90b:582f:b0:3aa:f4af:1e0b with SMTP id
 98e67ed59e1d1-3acee98d90emr603813a91.8.1792174473892; 
 Fri, 16 Oct 2026 11:14:33 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 12/23] target/loongarch: implement get_dump_info sysemu op
Date: Fri, 16 Oct 2026 11:13:59 -0700
Message-ID: <20261016181410.191743-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2jfUKDf22_n47qbbBat_Hs9kQUb2-CBm
X-Proofpoint-GUID: 2jfUKDf22_n47qbbBat_Hs9kQUb2-CBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX85TtSLf3hjSP
 VVFw/deodNs1giUZ0GNIoaVcX0/6Otx67RgeL2SHP2nCehtz8zOXvY41YIjH0MIQ+/MDnAXDDcR
 bXF9Rdk579fNYtvwqfA+iaNTDFiwbNBu8gwwlaf3y0pyxer3YImMzXYdJoE0fsHCnhIhQgONf+U
 93OOPn5xIyk543zMHmsUNG7HCT954kPFEWkY8b4BJ4an4tVZR8RFRzp4JY/GxjbAO5fQqT3QR5U
 N6OhGSjoTA77QaZfpnCGSxWC6lkB2xX8e++uZqjTf3+UQJowpt7pp0jOeKR48kbZZiL6RK01lXV
 VGHOcOaOf518y7Tacxn5VoSU1Oh7Xf+xjuoRm1mkEGGsL+pFB/mqQp4PvXUm5PdBhzkYCx3W3oI
 g0bfgUrdrZD9wlcxwLMTYJ8XWT0qRu8nniCXospJbOFWr/nhzhGVtGKLFPmw7F1IVmQgekKOVAh
 Mmwr6VeC9H7pPCOZKOQ==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad2698b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=FnhWYSpmk11jPv6NQAkA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX5U7wJogr9WX1
 gWMJAeVKxodpyasrgev2HVoO1u/QpGCYp2kQ6ua8hfWplfgn9hwoSr9uUxN2GN2LLttSipqdnQq
 JPg9U+5o2obPP3DEm9/KWxVu3NNEeMU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/loongarch/arch_dump.c | 10 ++++++++--
 target/loongarch/cpu.c       |  1 +
 target/loongarch/internals.h |  3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

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
index ff956823fd7..83220f32aaf 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -51,4 +51,7 @@ void loongarch_cpu_register_gdb_regs_for_features(CPUState *cs);
 int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                                    int cpuid, DumpState *s);
 
+int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                            const GuestPhysBlockList *guest_phys_blocks);
+
 #endif
-- 
2.47.3


