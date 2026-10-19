Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0941606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j+wKSiny;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WqZzjk5C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuum-0003iY-PC; Mon, 19 Oct 2026 17:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutK-0002oD-P7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutG-0006K8-Md
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJJsTB3103234
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IDpuezesy3iPbzIJpuuYyYy4rP39kaD/absHbwzOIdU=; b=j+wKSinyBpQEuYqJ
 ZjLzGApAD7pNsjIXnisSoqsJmXQuLter2dMjoHVanDnKfLAm3Wlqrr9+YW8Khro2
 hFv2IIEy99vWD6/Kt0RQUsFiySJYf7eGvztMGrl/4cYQHftlwS9pCw2X+1p8cv1E
 kjY2ZreSdHlBXJVZXoi0rOkI/dCgTkBCjzegmLCtvg7b1V9CzxcEugoJY/373NZ5
 slrHYWmFJRDk23vt5pF5WPx/kIFzaxidg9TykEShVuPpcbXBi2axz9WsbPz3FvT7
 Vyg4/Jt26+vJpX7OIlLsdTI5enFAYq8Arpc+DmPpWG1e41dqjd16pc0ORo79JDnI
 zGw5jA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4q0pc0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so1893890a91.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445235; x=1793050035; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IDpuezesy3iPbzIJpuuYyYy4rP39kaD/absHbwzOIdU=;
 b=WqZzjk5CDQnFkfwpEYzJNNalAlMfzL0EBZkNcjz3Rgu7o8+pPosYxbzI01dP8IsAPI
 w0KybHi69trJYGBITm4ulja7gWDB8Annyjjrnynjy7YY3aqiFEXfU/qeFoyBArQLB4ll
 3e5iku/Ih8OKiSxmhjLJib5q2ZHXoFfA7GtAAoFEVzcDbe7fv6WjRjQYmfc53lQD6+Mc
 VW5SfoovC//wnS/NBtFECtJ4uZwgqehQm70htPGJiYfok9AquDGFbFnJ5kgPJUIjxG5D
 Ir4nPbRw0XUb/iOthVAxMTKTtUUuUM4XpttRnrSanfjkV+0mZEF2a761ufCIMX0hkxql
 jzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445235; x=1793050035;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IDpuezesy3iPbzIJpuuYyYy4rP39kaD/absHbwzOIdU=;
 b=l5+a2n08w/nkamwv3Lm+c1cHH6WVVdMTWA/zpNdjvznXm80n0G+1mfljKjcqN2sp33
 1PQD4nWn48khLF1nglbBZxw6pr3MwWvBy7zfwmCtka8PdcTs3pe6g/0aJ//d/u1y0wy/
 tAPjsdIhcqnx7g2tgHSy3hJGBjU6999DSW3HG64IfZQqllojZj8j/gfGfFxzjfjXK+0m
 65jbprByUCtSzgub8gMPdVOVsOr35TYOX6iicbeWyCI8YoiLX2//P5V6UPSj2rBlOEow
 Nfixy6tdQFiLKHhllm7qeY4XLsbEyVdlqqs3eAAiyygcKkcmC8+ez/xQOoPh8o4Shaky
 2VXQ==
X-Gm-Message-State: AFq9FYKf2YqCh9B9jcL3G/5tjxGiQtWgntz1EchmMSh//+38iOy4FsgZ
 LcCFs3/VBNibGfhKVd95Pw3mCHl1E1CFinEMYwRVQUqn7O3mrT5Z5u4Sq7D4sOWwdbpvw+zd7mN
 eTkdnofK0gJMEsjs50LHB7wjDOFySduj3a8+DShfhlSmUMvfE13K20zRs+MsFRITjdg==
X-Gm-Gg: AYBFou3KPTdHTztTTteXrYmqELs2PCnM206+MWXUG/T9AX07rJ9C01HpBP2xsKanUbn
 sQA4Knf9nR9ncOoLxS01dKK5y6ha0b/CGuC2cnKzp1p85pwhOw6ge+2llbhxvCLyuxiVtKjupov
 uvoJh7BoteuRF49hrzd86GAHOkEQERLIdyCFk04Yi/RbAQWkh/DrPdZ6kJ8x4kjPaWFspfD7a6a
 ytGL4geBZEJ8J6jexZLZT4JV+Y89RYFo1FU5trPlHFxC6hpsYS5Y+PMqG8nji2DgagbBV9FMhes
 3MAaY3hm/MQZl3tcHKhPwzuHtZozag7ZBknyTDKuXk8dZAisGec2be+e+D5bSitscUpXw8spKIn
 EI79Se855pY1y2opgnsOYyThu3htZisdBXmEA0e0kbrHJ+QJvuXnZHOi98w8r3d4=
X-Received: by 2002:a17:90b:388c:b0:3ac:a521:959 with SMTP id
 98e67ed59e1d1-3acef1881camr8754115a91.29.1792445235390; 
 Mon, 19 Oct 2026 14:27:15 -0700 (PDT)
X-Received: by 2002:a17:90b:388c:b0:3ac:a521:959 with SMTP id
 98e67ed59e1d1-3acef1881camr8754103a91.29.1792445234937; 
 Mon, 19 Oct 2026 14:27:14 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 11/21] target/s390x: implement get_dump_info sysemu op
Date: Mon, 19 Oct 2026 21:26:38 +0000
Message-ID: <20261019212648.154493-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C-ZOLDR3LGtIhUD6JcK0SUM3uIt8RIHs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5+sgoJWonE3S
 z50kSoxZgrqJLixGzbpellAh4I3eoK6ICCsBQg/Uk8vMqNOt0phBIGogjqC2LAz0U4DgwmTgwZM
 P45bL+WS3KBEpcx7ASsfafD5X8234sY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXzDmplHE9uof3
 FEMkN394XQq1SZRGc6XwM0/ipdgVug/+EyGZn2ey5zgPgNt8xmoap1WfOHGtmHEX0w7qUBTJqT6
 IDjB1CVsWbhAidbza39upaAipR2g/NJy285aGNXPLW/mmg1YtFWC1QJEkE6ESvPYOwyGEENKhwv
 NXsw/BqqcLKGstN+lPhbP9czumdrLSwIVXRiTs6xd1CI/8J1JoWqXSp0POfywk/l/Ldm82T2mkr
 nR2JTxEXjfa6N0UBdwJ/pxvuPhi2dc3iL18CMDEd7SDgCk0Q92ePqP3nGsH4txYI3No5Yycezwp
 48yBBbIQsMyEjLrZsW62KDMx02Wiou5f8sh8VtJOK2TRCkuhLXXEK7FyoEZziCQYpEHiF3DoTFL
 tw/4G4a4TwJh2jrDG9ZYQGca0i0pO7Cr9GVtMpd5qlmUGEc7IGs1WYhnkctiMTOPI8Hh3HKXNjg
 h5B3GqeeJ7KcjwXEvHA==
X-Authority-Analysis: v=2.4 cv=aqsnmiZV c=1 sm=1 tr=0 ts=6ad68b34 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=tWNUsTMbvNwxkxjYQD0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: C-ZOLDR3LGtIhUD6JcK0SUM3uIt8RIHs
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
2.43.0


