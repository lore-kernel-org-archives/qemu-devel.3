Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4146CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT4n-0005Eh-CZ; Thu, 15 Oct 2026 17:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4I-0005Ae-Jp
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4G-0002R9-Hz
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFDPev4126287
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TsJrYiYWeKc
 g5RJ/Ucc96eerc98OYdkvfnXb5YLAsFQ=; b=BAWh/3oTvuGT6Do4gV9Mx7JtNzP
 KleAfrJKiXeejLpCS9dcqGdoyP21Uo9ukobgE12jWAnuB8AhLhE/1fcKKV4jGWyV
 7M378/shmgTKhmVey79U6OfsZV2oa7WzhVOvuJUCaB98TjznJQesOIxWognrlNg9
 7FJfdp2wL08ntgF7gJ534Ren62CAc0K7ERAzEA7q9CK2GwdInJwOZXQFoNwcY3bo
 45N0KOH3a43LaLcBPoOk5nVviVnDqYMJmMEwWagOBO7EdvnPBTToaAot7WPN8S0J
 TcF+UPQDHP0w8visCsOT2HKlQjKJZEvIKfdt/y4jWWr7Yww6RQsEAxkfSmw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m1cxf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso3821946a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099971; x=1792704771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TsJrYiYWeKcg5RJ/Ucc96eerc98OYdkvfnXb5YLAsFQ=;
 b=ZhcF9DNzbumdO+5gqX8aip1pE7ZMribaPOUe+XJkXY6qxiJh7Im40fjyBcU3u5NacL
 dD76cjIm/bhPmcWOIV+dmTl6KqI4t/pnbvg777I0GY8G1QH8Xn4kYntXOWusBuMKMmnD
 YKOUXOzig2wAKCMkEAwXno/GcwXc1IY9bEkHYj0ivIXbiLeDMserWtGsnbIzGT/BaTqs
 Uez4+L/za0B8+AlWHzCLAqi9TrThYg2Tj6b+vJ5XrCy5Jk68kYoJOtyuX8iQff1Yyuqp
 4VPS9khc3YaBpmvCv2ySkEB5qhYv6pkUdO1ZVUrSf+Ha8NPzRnOioBGAQzc+7xoowZ1r
 Bq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099971; x=1792704771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TsJrYiYWeKcg5RJ/Ucc96eerc98OYdkvfnXb5YLAsFQ=;
 b=RKflT+73NoS4n0CMWlUfAsSCQI4B3TjRyacJXbeTg3RACfeuDCfLHwze0lbuvCXnUB
 5xGfpKJKcxj5W95TMiZ8DqEzJpD+wSvhiJS01qibpDtKYb45DjBmfSnvUsHmYayknY/G
 4JV6WAmZmOC9GvF/cIfQGtOBzDrR0ESsYgqQXi6trhMicw1XvMgP1adj947aFb2lv2+2
 DugifOd3PMeRG0FpOnlFwjXPGX+L1RDK60RLdr8B+kvLcmNqO6g6jJjhXs7ZmgJrviJz
 uLA9zpCbN8LawFLDDaWSSNejNiqONCjRcLbrSpBS6R5YHPNUXwdbUQLIWTa9PxDGkTCL
 ur/g==
X-Gm-Message-State: AFq9FYJm9Ja/L6yVp6aFO04YQOIyD2+jUTHWUHJMcTPGGStBZ1ibopZr
 o3AE96ABwGMaomzoUA8uMvoqyMvFqjdqSGGaGUI7YWH4HVDLlcVlgKivK7hk/9+qmA80Prxr2mu
 Vaa+oPF3au/Hvpdl9VjHphiz1D6hoiyRTgp1wnGUZRDCkpufJfR7M+0mq6AgeTf4DHw==
X-Gm-Gg: AYBFou3nNOC5xBJyRAXFnMdVjhlwoJ2lcPkNo87SoWe2UsOnN/hVfGZ91TnjffGa0D0
 8xMI2ebvFpRPCjYLCOZyHqKk0Jtho8sjWzjWC96gyVnP9sFW+ToVHuaq+ep6dB+LnVKjoU6RtCR
 ptwdiaY/gnHDGI1WCbGIoNhipLjBsINfR34Fy6+ae+YHtUBLZ1ib5EPoLxh8l6JiRhf+X+3TNUR
 qTcKxtFdLEfURwLP3ZM7xMBtTvj5tp5Ihp+14RgaeymT/+oW4UH19DruKH2IgrXB3jdY4k7vBOW
 ATtGelweh/bbB+c1f4/jFDTvkhYXok/ZXYB0FRL2AAx7qyW34zZEfJEfYyvZMfglfUVjlTERM0Y
 4IYEH4xc/VNvAJPvSJ8NdzDhNDfDH+tyeQ0Rvzm+wsMWcSOeYHni92z2YoEr0UCo=
X-Received: by 2002:a17:90b:270c:b0:3ab:be66:ddb6 with SMTP id
 98e67ed59e1d1-3abbe66e034mr13286067a91.20.1792099970567; 
 Thu, 15 Oct 2026 14:32:50 -0700 (PDT)
X-Received: by 2002:a17:90b:270c:b0:3ab:be66:ddb6 with SMTP id
 98e67ed59e1d1-3abbe66e034mr13286046a91.20.1792099970101; 
 Thu, 15 Oct 2026 14:32:50 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 07/19] target/s390x: implement get_dump_info sysemu op
Date: Thu, 15 Oct 2026 21:32:24 +0000
Message-ID: <20261015213236.157767-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad14683 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=tWNUsTMbvNwxkxjYQD0A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: nJgQPF8TAdR4f6Sxcxvfp7foDtJ61eO1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXyhF1zjibPELF
 tascXXjgJsRrc0LVynK3TZSs6bbzfJDsZzoSWOJKM6zbLPkZgG9wh/5KNQn0c7OBOA4wP3APt+s
 4Qkt8f/jCy6n7J1BED+R7kR6SS6+Kig=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX6CUL9ehgHcoM
 BSjc8plNYTQ+dXzDaDkeuJqQdV4R/pFz9PrWaun0DfutQjtIF+gI3U4IUooQPjDR7wVtP324KPw
 ZCJ9fceHGrP/ai2mIbCagWS3FZcXVtk2isjT/DOVj1PuGQT1MIWzMlvHt3u3ZK6PlJLMvuctTfh
 RLpVCppVsbJaSZWIFzQUnBxqPGdag8dBNYe6AflVLGmKtOOCvx0G9oT2k69Y7ppwUPuTEcny7sY
 zox27PffMFcGIv+4xXbBNVy927YWCPmXgC+5jOc0zYoaGb7pFwps2feMpUJPGQ89U+GxQo3lU2a
 97SEF0Bwa9FhL/c2+mDTBYW2dfgq7BO3M/SuCOBZ0ve9MHnsuCeFxCE8w91V9N56ggIsT1FPFZY
 h3cPcBfqBGekgnqZHeFnUuQsWgRiY+hV100OchG7JP1/LtpQE9Mwswo0TGgpfMZv5BOaeYtcgom
 1OGibfN1W3dhF5/wb7A==
X-Proofpoint-GUID: nJgQPF8TAdR4f6Sxcxvfp7foDtJ61eO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
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

For now, we keep the global cpu_get_dump_info symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/s390x/arch_dump.c      | 10 ++++++++--
 target/s390x/cpu-system.c     |  1 +
 target/s390x/s390x-internal.h |  4 ++++
 3 files changed, 13 insertions(+), 2 deletions(-)

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
index da60b2b1fd4..a70bab270c9 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -14,6 +14,7 @@
 #include "exec/vaddr.h"
 #include "cpu.h"
 #include "fpu/softfloat.h"
+#include "system/dump-arch.h"
 
 #ifndef CONFIG_USER_ONLY
 typedef struct LowCore {
@@ -249,6 +250,9 @@ void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
 bool s390_cpu_has_work(CPUState *cs);
+
+int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                       const struct GuestPhysBlockList *guest_phys_blocks);
 #endif /* CONFIG_USER_ONLY */
 
 
-- 
2.43.0


