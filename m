Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2F5CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmTF-00086D-Fw; Fri, 16 Oct 2026 14:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS5-0007AO-Db
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmS2-0000Yq-V1
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG16xk2551798
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=84lsWzLtoLP
 7Tixne2GNGqNQu9+lU2ha7FBQCu3FgPg=; b=TDMFseVvid7uw7Gq1szqOIv1DJi
 XNVbQmYwLg6Cgz9e+xnYPKJ5acgDguWpazPOiw+FllByHn0UAl055i/q43PTL8TT
 NWA6uUXqzatvd1eazmOkb4qsRp02b8oyH+c20hYPJHBUZkJHrhcksuhrRXXlXmSL
 hSATGi25VpgrYGCnToD/mHjgrTRvZ/kOtOYbRcsDjdHhK7ytcHhp1K8mNZvY1IZU
 AK+SjWi0inBxQoOSVW7DMhdwQzHw4sahT3HMA65j40PdhUrXR+NYxEXAGiII7zaC
 N0aiF0IFUuOkhkVELIsV7Qgnaim6WUJXa0r/LrAeXq6PRfkdKKbEstLo3WA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq2wrq2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cca35cf9f77so126305a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174481; x=1792779281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=84lsWzLtoLP7Tixne2GNGqNQu9+lU2ha7FBQCu3FgPg=;
 b=YNCZ5Ubof8eD1mJf57HRFJ0HV1zPmpF4rBTsvmBWN//4nRO1V2TBu3mzyGm8M8EqoX
 HHcHXTorCo0o8hZse3QULbKZ9QUWSnLXX7fyQVEuwnu4QRpwdSEmchueh25FKJZAZ8+x
 2sFE65U+HIrScCrWzvckpEyTFxJSDB9Pg1BjBPRHF3n0NH1Ch8kirx+BlS4G8eI4b4oc
 eu2kSsR5gBVcd+hi7a0fQBy2xfwZouiRJyHfHa0EyjHqczGmniwX0rFNLturKJuVPVQO
 lJL7scg4CW3Y+AZ7lCQQa4OHG8fXdm3Hhz7T6KOOmLiLVhx4tsH256avRuLjWvhNsnUE
 XjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174481; x=1792779281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=84lsWzLtoLP7Tixne2GNGqNQu9+lU2ha7FBQCu3FgPg=;
 b=K1OYk6a5xdplTi92YoYd8UeU6Fjks0iqlCnAughBeyhxrEd6EVQgvsG4w8To3UFhF9
 rTHNLdzyyfUn5jBx1OWfjS7nLpX8CDFno8bvw/dTROsSQcYk94p1FdwrPJZv+usN1Sps
 M+jvv8owvNjhuzbrdJEQd3KAAL8RkrFjBjFuhe3kVBUE75M/0fGFVnH3Liqgi8C9eBQY
 18k+CEXshfxEZakZMuKSVaHejPaRHDUlwnE0+UUUjLIlFUAPMQ3yFuEI1JjL9rDFOlOK
 hR7xx7qrixoA9zG59Nj6cIYL9n531v1rBSb6fiUdzdkMF5JQxkbumYkElLhTqXBlKzxJ
 g7Yg==
X-Gm-Message-State: AFq9FYJCRRa27K9gjrh9UkLzpOysnGSHsSIl9tYb2VN7qzjkrLFopgDR
 Nut+YnyGz5EwYQdYBFnHp00TS7jyxV9pKIwYQ9XbW/blV5S7fN/NjNZwhe8557+8HsDoCeyqmE1
 NnhmkDJg0pnRK4VLhm269mFS9MGXw42/QD+660d6TIL/r5xEOZ865mQWEPr1qnuh/xw==
X-Gm-Gg: AYBFou0CqpAPoQRlqjYUTQ5nvxDO2C8XFhyOLdq4hKhL2A8Ro/7Y6K/iTbmsr3F8b73
 Bj9q71y7wWTLRp7/yquq7owiSmQwvvJk/Wx3W0S330kc1QvLq+bRHkuXS3hH5wrhDEVO3JxqfCc
 GTwUf6Foxe366APusc4MSQt0dXqlSCjuxso7mrxH4UXKGxeTeVdf8WBXBQBNagOj1apj13GRY71
 z6HZxzZunhfFBvUphforpmkpOnMpIoOU3LBUhpO+3m5uV/iy80HKrK9O+PL8N4T14vImsTQXAiO
 Fu/czv4xtKnsqrj3m3Ge3q1KbXV43V0f5r6PeLnd7NxtzNpke9xsQXTQaHFiRfYCamkyj8Lo2pk
 9rObA3yCBN6IBSEhk6ommTGy1eqjWtPDrRiUb1nKSvf06TX/ioiHaqYBzmZMbDAA=
X-Received: by 2002:a17:90b:4d0d:b0:3a5:133:ca5f with SMTP id
 98e67ed59e1d1-3acef4fe49fmr530585a91.46.1792174481053; 
 Fri, 16 Oct 2026 11:14:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0d:b0:3a5:133:ca5f with SMTP id
 98e67ed59e1d1-3acef4fe49fmr530571a91.46.1792174480548; 
 Fri, 16 Oct 2026 11:14:40 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 17/23] target/i386: implement get_note_size sysemu op
Date: Fri, 16 Oct 2026 11:14:04 -0700
Message-ID: <20261016181410.191743-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WIHqzXsR c=1 sm=1 tr=0 ts=6ad26992 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VkRzHO9NBAn2Hx42XgYA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: TZxf7r6-Ni7ONA3ZBh-uQfjTgzvEiRAM
X-Proofpoint-ORIG-GUID: TZxf7r6-Ni7ONA3ZBh-uQfjTgzvEiRAM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX7q2uRSkF34pu
 oOwIu4O316VfBJewGfwOeZBNrzYrUvHTWDDM/8yHas3tWFgSw/BaUE8PPlFkddvyEM1cTRltDT4
 m9nNJDqftojIy4Bnm8Hte+KvjzxwsVSE4CwqIZVRpI3XzgtR5IBTIYiTe6Ldjdoims7KgSkLBEa
 tl3s5im2p6yax9qS0+OvvdqcPH+mGpx+qq9lsJBWHms8eLepY0xehfGxsCoE49qu0pvtdErybve
 gdyiig2rtpQVRU56Gc53oS2dezhIHhuxMneXqL37CErCcMFTKS5lbKH0j/tqKJ1OTOOqg47IcB6
 lMWzOo/RiIPp6HV3yZgW+pmOgJXlI41AjNWwv/jTpOvlVlCTaw21xCFXtdbUXi9Bm0HuFzmI2UH
 V8VoWpt9a6t4rhHeYzC7NjOHz2yHYPT+vAzZrd7LCM0odUSswWd7eGe84vSTDgovnNKrxZzRZVs
 xCWlgIu0vCnigvO9wFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX6m8Zj0jSkIQW
 7MEgoXE2EGUkpPBvtPoky3VAYwsdLWLL45foNNcVEAjsEYPb/QRwDl8B6CG6ZoP40P2BdUtysf+
 QFMERNIfJJH1AASShmoqm4IfFoLgAvc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160072
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
index 9bd2a37c447..7fb1b262938 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -68,6 +68,8 @@ void x86_cpu_machine_reset_cb(void *opaque);
 
 int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks);
+ssize_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus);
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49f453bb011..dd9cd7c5625 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10921,6 +10921,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
     .get_dump_info = x86_get_dump_info,
+    .get_note_size = x86_get_note_size,
 #ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
 #endif
-- 
2.47.3


