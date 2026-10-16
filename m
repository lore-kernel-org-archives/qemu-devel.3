Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F84CCCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmT2-0007my-5D; Fri, 16 Oct 2026 14:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRx-000795-Kn
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRv-0000XF-Rf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:37 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5gnp1613410
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+4aRFUUYhZo
 ioX+6RW3+Cr9EnfyeyaS+cwLAKpgFdzs=; b=cFl9/A9O+WWiP5a0/3OJVBupX9g
 tZthZOicOnUTJyaA2Huo/sGoYqd+EpjtpxlBU9Xnj5CIbgwdyZ8HWwajJB9HNsgm
 /AEy+Y67f7WhPQKjekto79nUKSlh7XFTZtq+B4Uz1T1FxSRMD7hO17qK7+1YqZ+h
 oz1IDge779LlFuhNaxZqlOKfqR/HxRUdyj/NAol/ZrDmDvEHbX/rvCJ26xwxWjC7
 Cy+GW8mYNGOuG68FRw2Y2gGFLHRrtbAOZBc6tsvpaG6P7KBp8V7hoiMKiK3FTdXH
 k7h1h6caNFt3MGupdWidZ4mx8Mwjdw3UaMPbHHk9W+2TXANYn4tA/8vaz0w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbk3v1hh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3abb4c24125so194231a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174473; x=1792779273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+4aRFUUYhZoioX+6RW3+Cr9EnfyeyaS+cwLAKpgFdzs=;
 b=A+kUZHsy7vGestU6wIfDD/DOp8iXlwAav+vpIzPdWTv7mORdCDyeC+IHn2tQEeMOtG
 ah/qpvxSCntLR7h3AyzyF/pRrao2C2JBa16XxHUGvf0oFavFa2oIrXOtm4YSYQxc7F1u
 gVmNFoeyEL2AszxkkjrMHQoQ7EPn8b9B9iBXBZZhMDUFkXKnmnED7Tl5StXsINZkArsp
 zcyLtALgV93ZB6oU/ibzpyOEKx9M4aB15jIUkqajHSnjzphE//7zP8jI36AP9DCBCCIR
 N6zDLt+pHtXA9N1o3JfoUf0p9EjBic4UGpYInFIqO3qhWZZpGIxNjyci5nHbz/o8aanj
 h02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174473; x=1792779273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+4aRFUUYhZoioX+6RW3+Cr9EnfyeyaS+cwLAKpgFdzs=;
 b=jgrgUVlGvCrXTXMlFqt5eBLGONfs0XghQ82nNRSIMMJjjDYPJPDLT7ljaurT9Bk7XH
 o2wHbxTmh9CshvmRjmGN7gCO3v2AQ3x/itk/vkqbgnVKE+v08TmsXjjR/DGmOQdGz2Z+
 yhlMBoB29yzynqS1qp+zRzNAp4saQc8VL16cGNZwfmrpaHnOcA92HGyyDTUlA2buj1gz
 dWcPAqFYfVhtKnaiJohnHO2GabwYZ8H25rog7PBIw66xuYv3RaxFuF1s+q6F4VuSegmC
 gedzRaEhTQsqjMdhc6kBfARya+rLMoqLNRetNzXh+O6e+3VQhAeqypXLUHKm/M+KM1iT
 dizQ==
X-Gm-Message-State: AFq9FYKtfX3GqNCeQIlKpPTb8EV8fst+aKSUsNL2gSevsIG3a9qhxo4R
 GklYXi9TuKKl/3qLxTGfSF9AIgOU9XmJZTjeEm4//NvUEDauSMheu6+qpN3qhdXdP+EfeI3DxAM
 cMVmy2DhDEdsuEjyG/jWPCFfcjUETx26lnYrky+/2zkBRRNvM8QaD49z+pts067nung==
X-Gm-Gg: AYBFou1tWbsfLPXF9EKgSoq/eGbeSfh4y+2zK0U8w3SWm8xUFrNP9CqtPQVqFfQfzjV
 +uqisUI4q0QebxnyeSxUWjdPUCIVGvbd87zMUJd50W00JH9w02/XrAfNvbqzfS/Ahg+W5CATOXx
 K+0+FS42Xl94Lg+2lvhHetFGc1htDTP/NdQXDD9ipODvSgzKCaclcrh0QofSo/wDXle1ySddBdz
 +qGd1VuYTjKOzoRz/8bX+mav2r2/6kqb82ZXLWlBnkseK/hGT0B/CIS/x6QPJqz95Gn8BPcUGDZ
 anpj0DbeErK4RnFWkdsU4xLb6XRlqqhaMtDFiv9Trn9lm6nuR1DBN8y8mPbl4niROShVWETO9fa
 o6vDVmMNJISERQAdJu2l9lL2UIrgIFHYZVnHvzAJsDPVbgDiQg/tYZVnaQ/3Rg6A=
X-Received: by 2002:a17:90b:562b:b0:3ab:be66:ddb6 with SMTP id
 98e67ed59e1d1-3aceefbfd37mr468748a91.20.1792174472874; 
 Fri, 16 Oct 2026 11:14:32 -0700 (PDT)
X-Received: by 2002:a17:90b:562b:b0:3ab:be66:ddb6 with SMTP id
 98e67ed59e1d1-3aceefbfd37mr468740a91.20.1792174472395; 
 Fri, 16 Oct 2026 11:14:32 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 11/23] target/s390x: implement get_dump_info sysemu op
Date: Fri, 16 Oct 2026 11:13:58 -0700
Message-ID: <20261016181410.191743-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YirvVPzLiiTgMkytM-35M3C7kjiBNFIJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX0JLFaPoZqxms
 ywJnAc9+IERdUaAXWeFfRJaSlQwZU6Wt4K4KD3+N7KHGwP4vhkxGcu6Je42kmJkqhNADX8sQrpJ
 ceDW1lS+NLyMX6Rt9jiqVSDv7e16OFY=
X-Authority-Analysis: v=2.4 cv=BZdNQbt2 c=1 sm=1 tr=0 ts=6ad26989 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=tWNUsTMbvNwxkxjYQD0A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX2y5LPJndjvvY
 +J3BkA9QKT1c4rYAQWsbv1mDwrvEoNN9gpN1FXj7FrcHOAxAkKJAwsL2hckVnYg3VzkMOzKUsgm
 l90hyer7O7CIOHbOPU0oXu7GkhJ0iGc97ZCsn/QJrqQmYPW5S9rSO1oImgmDXcJlbC75ImK5a8c
 A2ob7V9u9mYQdp9aPSdJe+H/OWCgRlSLP60VIxikmc0wb9QMX7xKcdxuAGSUJMY1dus3QNW+vga
 1hr63nqzh9dnGvRGPsilhDa8gn+bHRZ8esFsV3/DL/cn0bKknNMZRxA/LeBhRK5tMK/hKYA/Mt6
 oIBc45LdQJRXfoqsxGtHfidX8yHzjkTNZaRJINn4rP7EtA50rNea/9JY9RE5vjExVto8aiwQFyD
 5boG5bSpyGYCKXL1NaZUGAgqbHVee6gdG1nkAs/hhVzgneWwXtXN09gvahtb3pUkjp5y+fGSgE5
 tLiLENFgx681kbu/h+Q==
X-Proofpoint-ORIG-GUID: YirvVPzLiiTgMkytM-35M3C7kjiBNFIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
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
 target/s390x/arch_dump.c      | 10 ++++++++--
 target/s390x/cpu-system.c     |  1 +
 target/s390x/s390x-internal.h |  3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 2c26e992959..9a92efd249a 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -449,8 +449,8 @@ static void arch_cleanup(DumpState *s)
     }
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
+int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_S390;
     info->d_endian = ELFDATA2MSB;
@@ -469,6 +469,12 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks)
+{
+    return s390_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "LINUX" or "CORE" + pad */
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index d963d9e940e..965f5cf29ae 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -186,6 +186,7 @@ static const struct SysemuCPUOps s390_sysemu_ops = {
     .get_phys_addr_debug = s390_cpu_get_phys_addr_debug,
     .get_crash_info = s390_cpu_get_crash_info,
     .write_elf64_note = s390_cpu_write_elf64_note,
+    .get_dump_info = s390_get_dump_info,
     .legacy_vmsd = &vmstate_s390_cpu,
 };
 
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index da60b2b1fd4..a1f78799159 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -249,6 +249,9 @@ void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
 bool s390_cpu_has_work(CPUState *cs);
+
+int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const GuestPhysBlockList *guest_phys_blocks);
 #endif /* CONFIG_USER_ONLY */
 
 
-- 
2.47.3


