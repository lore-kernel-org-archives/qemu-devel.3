Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443A606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XP5iTMfq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jXT/NL5F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuv7-0004DE-Oc; Mon, 19 Oct 2026 17:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutL-0002oG-3I
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutI-0006KS-JN
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKDnJ3103813
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ujn3XxDk/a6WdkokppYCyNTUFJf30Dmej9d2MUOOPUI=; b=XP5iTMfqdwQR7p8o
 oLs+jEAD7RfwCfWBjUSi3UqWSsQ5F+DOFIFIc+IVSwqWCT3zHSeBdBsuY3C66aIz
 FBngXKi8lRFP4Dltgb9Bu/sxH3p7jxJNkgv8LUKiWRuIgPaU8/HxBhZNwOdSRuiK
 r71nqoYFZhwQ3hnARE/gEgenolhgcrffptG0cUof5s5R87wVo8yQ7+n26QV0INpx
 7ml1OLFsA8atn7EjAKK3UP6y3yE7vA5Fk0ndTvONz6/fxm3sP6fFmSm+31bHe9cb
 ENxOP8shmWgmdd8eCYUCH7JP5Z5/dTmrdIP4+87EoZhdjaOedCf+sBB2SGMqslHO
 E7+wPQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0pcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a4a0017549so5519245a91.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445240; x=1793050040; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ujn3XxDk/a6WdkokppYCyNTUFJf30Dmej9d2MUOOPUI=;
 b=jXT/NL5Fby65NpFH5c3lllm0HkS0t8SCG/s0FXVPDKpWlyHX7PugGza3vn55ezNz+z
 SD8qoIvbzGp/vLIBc6WBUcKJReg884ApTlieEPJ3seVjLdYjrgRD3gsPiCfoFN+CXjKf
 8sL5+XRAlpiHQxBWF+6Et8sG6Kl/YaaN33Pger7Bn58PyQ5zF1CZgw4x33GRjBDkxtGK
 js8AmmOsG94FAIJf95aVs0mBWMJmgm/mb6pnjd9i8hIRpWwM/LSopjX8YTlTyhC91ZKL
 ksUY4HGuSazejnp0ogY4LB00Jy+CieJN+mzq4QvWw/LaVySXLcPYGOeQgRqYTHiUnRcU
 Q50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445240; x=1793050040;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ujn3XxDk/a6WdkokppYCyNTUFJf30Dmej9d2MUOOPUI=;
 b=o7i77AB6ErNdwgAS8vaEqMOQRjXP8ibe+5zTEwmxm1qAdhZ8jI9IATLLR5cRHpa9+G
 N5KAqUMtvKPg/Ah+98b13iQI4EHQzO992bkOZZThLXP3yvV7KUS5EXUZJORvUjsYxrdB
 GHg9nruCWsWoYQaEt515kVEipR9zdeoZEYPJCAHzm0COe0kiDGl0QvT3zTV7fE/N2sYr
 FzCXsagWPdGp/7j9K4INxGYtwbHOyIyNneJAvmz4kUDz8TH6sqnnqT4aGTlwU1Qx00ww
 Gu+OP4jRxzDF8KCIZ3WwkVcgQ7DomuslwYH/EKi2HfgggqTpjb8c7EF+5meeMnKhAczs
 SZUA==
X-Gm-Message-State: AFq9FYKwQFuxl0Vk2xXx031FKLOXi7w9u5iEsAWt2XhjGF1b93iqUcPT
 l0b+Q2FS/5903d9gZoSyoAnm1+jyGuRVA1yi/V83SeRv/x13OW2IyAfSTlin8ZHnGP7Ur+MEUPy
 8QdLMaqoOCf3GUhm488jd7zaNFSVyYnCLxiSWDskLYkRGrf/gcSIYcYHJx6Luczmk3g==
X-Gm-Gg: AYBFou1sVUqu/kxWI6yk2QbBIW9t4gfoaXn3gqALkKde1+phv02oAjh7oc6ypDCZVgM
 xn2cwV0/mbKbGQldGOt7CMHY9jNVuNHX54feWs7pbSHYhUsX+vHiToFt4XWkP2nk9hGHjji9Inz
 L8f+L1JC/Yc02pO2/lqTWdGSTz9Qgpm4ThE9if/TOX0WpT4BFXNaDPIte/nBXaup6mSoGvBDcNk
 ZdqZ6EcesdTJ1xSzrp5WKvJzO8SluQ7P0TfZAqajC8Clk+9AIfKbR3kg7l9pOtn5Hc+KPJ5Ph7z
 wMbuSPZ+xOvR62apHh/itbtJAeWD3NXryF5i5v75Mu4LbJPllnRCUswch3uf7LTMIfOZkqP/40q
 CkdLNOoqv3bHYSMh8+JI58A+0zpJaqS2elrbsRJUKDBOmjHD0KEEoURbOCHJ0HTY=
X-Received: by 2002:a17:90b:580f:b0:3ac:9d83:8856 with SMTP id
 98e67ed59e1d1-3acee728d5fmr7319063a91.9.1792445240409; 
 Mon, 19 Oct 2026 14:27:20 -0700 (PDT)
X-Received: by 2002:a17:90b:580f:b0:3ac:9d83:8856 with SMTP id
 98e67ed59e1d1-3acee728d5fmr7319051a91.9.1792445239942; 
 Mon, 19 Oct 2026 14:27:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 15/21] target/arm: implement get_note_size sysemu op
Date: Mon, 19 Oct 2026 21:26:42 +0000
Message-ID: <20261019212648.154493-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QbUiSu7AJT5_vmIe5s_GtBgzeZgpba4T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXy8oc2Rqo1wQo
 78x1VX2HQ1UeZTreL+hluuwoHr9DvZm7NEeByRvZ5ktCFnx3dPZ0l4i0SZ9R9ArEk4+oP+4vCLS
 Ow91UlHPA6eAkvyi68iYVXJLRaKk08c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX3HknG63G1sg7
 WkxFU4UXBqw36rhHtEYhpL/mDSJ5K+1siOHSVDpbCdRUwZ4FMWXrDfw+qYFfcD0wjMFcxEVvTNa
 ifuf5slWwnrlgkEbIxAwpqt1UOvqhLBrjIiXOwt/nXnYuoyPghOC46lYcDOqv2xQV8C2lvLdXsU
 9lAx49pTZnLv9LDnFmQvpk3DbEQjRFNOkcGwlCXNC7YlkA0NK1rCLBhgLLU16rCtbOkxPk6SPa+
 ytPFKqaDsftlDC23DaXglWYyZKxN+XiOrtV9AKVBnxAZa8jlZKopogakP/r+UHxdaRDFu0uPiHS
 +DjFPNGW/QZ7B9dYRCh0dJ6xXEiCj+0L6vHFCY+AcnODHrHFglObRgj6DmWFAFpH2x2a+dsIArF
 F7xdA7Nptf9ERyFeHHNaMA9OGFFm0CoUcBfmJmcySvHHt3ldU2g8qONUR5z8n/827H3BzIoE/UL
 R+BgIYSZ6UlRiJ9y5bQ==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad68b39 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Vcmh8FhFDDEcUw5d5KwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: QbUiSu7AJT5_vmIe5s_GtBgzeZgpba4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index 61b0bbf1ba8..8e4b8f585e2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -440,6 +440,8 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 extern const struct SemihostingCPUOps arm_semihosting_ops;
 int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks);
+ssize_t arm_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus);
 
 typedef enum ARMFPRounding {
     FPROUNDING_TIEEVEN,
-- 
2.43.0


