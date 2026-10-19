Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F25606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nwXTgSXA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZayYaiHN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuth-00030Y-D9; Mon, 19 Oct 2026 17:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutL-0002oI-3q
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutI-0006Ki-VN
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:34 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK9Tn2782100
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p3czTddzfWhRtd+whweYFkDXOUJ9ZXrbFbYyDeRY/dE=; b=nwXTgSXAXZsny/Dg
 40w03ccFVN1INVp3RBuo3/K0HoZ3v82Z8U7nlXZSSr38RaZzRG8k9ri+3wzlaaSH
 w8E50xgY1PIEy2fQHSlZb5eoEyv3aJWqbejZhffYNHcsPbv+J1v+VU7X3GD5cz8w
 8T77EYRlLECuAu8KCy14j+8HIgbcZpMQ/ZUqHBKcgwC2PkHt/tetB8vyvx5Ykt/A
 Wj/RWA8XHUIBEMaokE46GscfprsIWV5j08FJ704Wtj8O9Qeq5jtyIznrahB0ZpPW
 8//Lvz4IelfjexkizzmDCzENw7TxBSfveb6rw7fd7k2zANtMJ8kNU1xE2RYP7jWU
 QVwHjA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr3p0rct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso3447905a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445243; x=1793050043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p3czTddzfWhRtd+whweYFkDXOUJ9ZXrbFbYyDeRY/dE=;
 b=ZayYaiHNSq+/d6RzgHuB8N0Zt+0is6XTibTfDtxzTq14WtiVFOgKepQtd8RWu4SBI1
 KhE1zDuiSH+YQrwxPt4Rgizm1ouqryfZ6FLO/RqhdXpUaMgweKR5SASQf/BD1LvakTKp
 TN8+4Jcn09YtYQOeONwTCy0u6ZSjHj0eAP+GfmTu2FauAQwMC5D6YIYKV7ZQlZBOTlOo
 HpCrHmMDRz5695m9d7pjq87iiVMF5My8Ta9rzW21HxuYxT4hXxZUNuATiqYQz+Y0XsUg
 BlVd4d5HLgNZCCGNrR/VNo4w+jSN5TKhpdy+s9V/7bAouiNP1cEkzi+7IyVakxDFPhHP
 VH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445243; x=1793050043;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p3czTddzfWhRtd+whweYFkDXOUJ9ZXrbFbYyDeRY/dE=;
 b=mdbBLfI29wJ1+LNMUVno2F3q5tdrCTPULtfxtE3S0RQw+/je91nbn0PfRppvVSmkSB
 gsIjbYmt4t+Tf3xMG8DFzOHrkKEXPPagdPVDiaFa3064Zm6w5EA/dJ0HeVozHOc3/2ng
 5SNQ1zxMXco1ag8QRI4uw/zSoo1uPWIFA2cbKS5+2ZVZ9Zv0wvGB9BI1iBEcaCGwojnE
 ge1VxhNBAwIdRGYjadYF4FYPxJhdsJ8+yo065xg6zYFOVp1DEJZQULdcC5mFEE4IUY+M
 Ic/9bNIO5Z1WbmGmFK6p/euiXMWHteR5mWG+iMIJTprUfe/f6lQ26S/d7FWpP8Z6wHcE
 zmLg==
X-Gm-Message-State: AFq9FYKYy/DVctC0UIXLxaNwSJ+vAfFUDZkUjHBbiV8tzdZDYIt/afd7
 XADLPuWsH8Bqmi2jBfyQ/26x8lsXoOA5jPMrzUxKt3ZwoVFJdUO6cWBCG3rAq785QbkrKeyOxdK
 cjy44ywOi8yvlbnE/51LcMm3wSUJmnADL4z3pM++DhIPQOO+huHZSJocZn20JEOr+lA==
X-Gm-Gg: AYBFou0EIulxXzY+f++JlmzqFPuLBeaKKbsW37b5YA5jUgMEWsvck3Y7fHE+r4qBXAo
 pa5/I2lpwSsPmJSbYNC7bLnuKgKthXxZvtfztMEmwCpTBy6NV2MatKocxNioPtH+CafPnnfxv8T
 zXr4nRBTCjIP+ACV/H2sMkqUmpmxwOYmhmBUSD8dYEn9VPhlvCcWCjyQyds/ApUWW8ngi8SvoMW
 XVEBQfG0Gx53rNKX5J8iyHaHWHPvDEm3H35lBXKOUZNQ9puUoyfhkIlEFfUm9LMnHjr3QzMEiks
 x1/EROF6W/B4ItdRhA7Pv+T0LEuqvn2SVf+w8207KRyGwDodfQ0yGY0D3MiVopzupJ8jjys9ngq
 ROom25HUlkMaJl0AzYGto1X/ophLh79XepCzkEiVfI69YYqEZZs4VeWqcMHiVv90=
X-Received: by 2002:a17:90b:39ad:b0:3ac:74b3:a8f3 with SMTP id
 98e67ed59e1d1-3acef542337mr7819945a91.44.1792445243107; 
 Mon, 19 Oct 2026 14:27:23 -0700 (PDT)
X-Received: by 2002:a17:90b:39ad:b0:3ac:74b3:a8f3 with SMTP id
 98e67ed59e1d1-3acef542337mr7819897a91.44.1792445241544; 
 Mon, 19 Oct 2026 14:27:21 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 17/21] target/ppc: implement get_note_size sysemu op
Date: Mon, 19 Oct 2026 21:26:44 +0000
Message-ID: <20261019212648.154493-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WqRg324beGHIISuv_zYgs55vds8xi-Jr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX0lhE5DiiR+Tq
 kkpXQZZAW2DrJiMwqyJ03Wx1+mkNb+V6voFVb1e17wKI9FSL2HA6Y1hsKNRIXp2lghYZ4bhIslu
 AfGx3L8fiLDMoGunbqYPhS2cy8MoqDLvu21xHlo9AM0cbOSZC0Q5mXrygJ5N+jK9m2ImfGznlzM
 AAczbRJRm2tE08uea+PAh1ne0ez5fciS+el8oQ12RMoZ5t4xqbtrH1AHJhYCF5qqv64wGlDcEV2
 GD8f5VYW6YD/sZvAZAMpuDW/LN5Zc+yLd+o0IoO4VI+zfaVV59vbXpMq8ih3VjSOSYIO1xGY8fY
 pssXL6iavMnY2g/C+EdrrCjXQC8CtjFuAxlI9z66Fn7vKLsztICziam6gehc8BMvIxIyvkybDvi
 FvgiIdfQKxunnBlj4cdzqBq7GKsreeJEmkWBqbYPamrnEFGdiBAZvF0Pa9aDJTy2Rn/Genzb6Mg
 q4ubo0MsqO3awnsUM7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX7hq/VCxFAoB4
 wPl2/VesKh8lR0wkEbetRA30JCBYlsOUKqjEZ8yBvrPnpi8aNjORYXPGTCDKmTK+Gj8ofM3RJFp
 jACK3xoFtevA23HZFVRayrrOG0kCwYw=
X-Authority-Analysis: v=2.4 cv=HLxWhYtv c=1 sm=1 tr=0 ts=6ad68b3b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Lumvk8zKUu4O7nVSwh0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: WqRg324beGHIISuv_zYgs55vds8xi-Jr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
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
2.43.0


