Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A173606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pmnFSU3w;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Seh9PI0w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoM-0004Qs-6Z; Wed, 21 Oct 2026 14:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoK-0004Qc-Qn
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoJ-00083k-4q
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpQQX2384285
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jleAmRsQfaGc5DWguPhI7dFEJVXGdQW5T2OOrFoUs0Y=; b=pmnFSU3wsL5Ih9zM
 hzgHF7OReEWGuBfeVDGiCViGLgSoi2TLAMyjKVYmRq2yRg2tpe91VJVHdcwgd3AD
 2KRovOGBnmdnOS4GML/VKExnV0/zUX5O5aYVXsJioyI4t5dziPryJdAmmVRBse3k
 2osGuQnZpo8R7nBbNukifT/L+3LY7q1I59uzYO6OtM+GSpr/vgObLpRGIJUbFbAy
 0w/lMfI5xY/lER8XanxPuhoWI5TwBGSNY8S1kgw0YLmGcdxBGjOkWVtUhC2+G5go
 qXOHwy9dQiQCMkhdZ+zm5rVGPE4DygmoENy42tcjIzuNUezdLGaEnP66jRJelotj
 N4IPcg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke0ju4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:12:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab27eb38d6so1024687a91.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606379; x=1793211179; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jleAmRsQfaGc5DWguPhI7dFEJVXGdQW5T2OOrFoUs0Y=;
 b=Seh9PI0wzYpLvPje85JalwmjQ2C11ZX3OP9X9TnjYyKxds5PBhewqU5D1zUobEiAtp
 VWOF5+E2tlK67DHImzYvAWRBaRn9v9l8fCuFbqiMliJJ7D+TvnKEC10/PfY4ZDg/FsbH
 mU9So1xE5zDx0MlcRhPU9xwuPQmpZ3z5kTpT+4zWfBC3u640jkjD8gFJ+zdmpoFov2ua
 1AI7NeUltpeDymm4v1yN5KXlrXevzbGYAVlcoVk9VsI+YXSvjW4O/utYGaqhS5sa1iwe
 hV2GMi7JMAWnHHbVK8VWNdLnmYvED87Jpn/+e0a+f9UFuVSTHc3jKNtQBG3zSwC+Lbcs
 yFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606379; x=1793211179;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jleAmRsQfaGc5DWguPhI7dFEJVXGdQW5T2OOrFoUs0Y=;
 b=uyBno2F+QZZ7V6cqFEOzzF6g5mzBXCkuOOrlm+Ek1yCAJGLWe834qlCjMY70uVfLqA
 bWWEZOsiTs1ydKaSZCclNFUcpzHu4+2u6FSN04XuSbtJl1FjXf8TVyb0/x6QkifJPp/m
 VqRr4bXTufl2D1cOthm12c3U8Iy3lxDyKL7PCha7EJTWfAv6iMo81S6TbRF3xwHwFOIf
 Kp16LGwHw2Codzl204avSIU+gNfYucNLxJRYEeCFSBlluGIDEs5yWksYOh9a57Z7bKoF
 yRJhWgC8UaIfQvOpl2Vsc+l9Tu8zU8snG4u5gfyNpB0uE7T/NKSZ5Qn11xU1yE5yRtpM
 S/Ig==
X-Gm-Message-State: AFq9FYJ9ddAsFWDcdEbPowpb9PhMTQcnqffO1o17xoFvl5b3VzYkBtbU
 neQDVytQcq64hBpi/8llL9owT0auwcMwVnvbM4ZHP2+HWQQCFbhD3BcBwEdJeNC26AyHxzNcyyq
 oPuL3CDluVdmg63QB7SbBS9Zsy6ZmpYIup7Ng3kJKw4AazL6lxktfeFDowEp219WjWQ==
X-Gm-Gg: AYBFou3lFTKAlJGRqUOtsJtT7wS6qRrGwzrnSpRcLTuZh8ii78IWevX9/jbHV8lw3/Z
 Iw9xgBqnmvRbNRKQCW5TA4zRKFNzNmeusIb4zYNSYrS3q0eFHUh6msm/rvzNm2BcEEL4Yysgk3c
 LQWWU7y8EIWsHDXB/dh9/RH7eFlPNmWsfxm4oSBlld/EVYUIRi79Uh0sK9waNpvH3YHtiDMLB/+
 0N35cb9uUGY+u3j5rkXYQsQwdeCsymxz+iSySqbEvEXraNrujVataExPItK4vFHr7rPc/hcNRV3
 iFISmJx570TFz7GiKZGfv2jZnG13qfOcYgNMnhtQNnhTbiO6cCE9r7ioEtQZkM8XCg/nzIvFokz
 NUXWNTo5Xn0ZsKKUv27e+SUXHA0H1PouLJVow3qV2L2qk9Drl1YYIv1laG7eUYfI=
X-Received: by 2002:a17:90b:3ec5:b0:3ab:e588:c288 with SMTP id
 98e67ed59e1d1-3ad86e9e4cdmr2517882a91.11.1792606378924; 
 Wed, 21 Oct 2026 11:12:58 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec5:b0:3ab:e588:c288 with SMTP id
 98e67ed59e1d1-3ad86e9e4cdmr2517871a91.11.1792606378437; 
 Wed, 21 Oct 2026 11:12:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:12:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 11/21] target/s390x: implement get_dump_info sysemu op
Date: Wed, 21 Oct 2026 11:12:34 -0700
Message-ID: <20261021181244.867840-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9IOannd3-Y0--JZQA_ZabHvy7xIiZuJX
X-Proofpoint-ORIG-GUID: 9IOannd3-Y0--JZQA_ZabHvy7xIiZuJX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX7lL4w2SNTkQh
 9759cudYRqjLFwm7qy48o40zdHHVmc2mdLLUlcDlb+J4sZj+4hCe9sqcYOW6N2VsbAs3+nx2qMl
 GrxqFUfJgb7SLsg4VyZR9fxmBq2Yr5U=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad900ab cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=tWNUsTMbvNwxkxjYQD0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX1KD/OaMUIyJ3
 02WzmL4RIu9wBELn6alOasPjuIgPu2zGsdImmnOxx3t3DHLfy9NhsLomGSvn9i3IA50rvjkxl+g
 96Ty8UGpm7W6ODCGKTyN/zBkSG1Tbe2RCdq9gpl9Kc5dJ5nBCePrvh/aLX8r/KWgP7p8N525uYY
 Cw6yIyzDRS7vTTv0d/JBbYUMPWrQFI2JtA+ZmuyH4iS5LHixVY70AxELKQK7ld74N3i805y6bRQ
 OQO5MsD9qRnJ/mnJZ3nO23DsiOdv4gC3nl0wH2Fqis2kFDzrPZ0O5jiNNv0Y23dNTmCkXUVMW4r
 ntKOSuh4gD/1lOqsqaZKbpJqOmZq5yF/eb9Pi6RKCxXS4S6lyW83fKBiLs3qNiYYiyURc1W5PUX
 Qo6WVBDQWpXnIVFdt/c31hX4AtmjRJ4fgw0gfLOVpioGgpPBpouCwKg1zp777DQwZ3sVhuZ1r4Z
 TOIM9lDuXJvdNlwjIXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210072
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

For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/s390x/arch_dump.c      | 10 ++++++++--
 target/s390x/cpu-system.c     |  1 +
 target/s390x/s390x-internal.h |  3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 2c26e992959..b26f0ffe143 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -449,8 +449,8 @@ static void arch_cleanup(DumpState *s)
     }
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
+void s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                        const GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_S390;
     info->d_endian = ELFDATA2MSB;
@@ -466,6 +466,12 @@ int cpu_get_dump_info(ArchDumpInfo *info,
         info->arch_sections_write_fn = *arch_sections_write;
         info->arch_cleanup_fn = *arch_cleanup;
     }
+}
+
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks)
+{
+    s390_get_dump_info(first_cpu, info, guest_phys_blocks);
     return 0;
 }
 
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
index da60b2b1fd4..5bfc37fc46a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -249,6 +249,9 @@ void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
 bool s390_cpu_has_work(CPUState *cs);
+
+void s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                        const GuestPhysBlockList *guest_phys_blocks);
 #endif /* CONFIG_USER_ONLY */
 
 
-- 
2.47.3


