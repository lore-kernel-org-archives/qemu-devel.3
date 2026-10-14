Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF44CCC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8g5-0006yW-2p; Wed, 14 Oct 2026 19:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g2-0006xS-AA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8g0-0006RC-Mh
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMGIF9905391
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Nae77TQR3Z7
 q3Qlwc9Q49nkMmv1mvtHOrP91FMkoDZw=; b=Mi+9DdXmmrOvHe1pNN0TcYdk38t
 LgMYmdPULFEMfa4GWeHnKUC8G/TabvxTxaYs4F+tUiZke0LAU8hRxNxII39iSRcP
 u0joji5/FCwWOo7/Ks7bQZL+1EGSxKicQ/sEbmIBofsPVpgZ8kPUCzFTt/uCzyN4
 kQ3aq6gVNsK59eadxUjg7vBhyuWf2eQVhABiu1jAxYdHiugST++9v1GmzYkP4jma
 kq1dyCICdY0JR1Hx5wEhqJA2Yp/GnTLrFoDJNfNSptZvw15r1wJqSyaBM3V8Cjt7
 nuFXDshAejJ96WdZccsIc9nVVLr/mc+WPHVnA9AvZgrQKoa0ttpdH7AqP8g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p40g0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso7483590eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021587; x=1792626387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nae77TQR3Z7q3Qlwc9Q49nkMmv1mvtHOrP91FMkoDZw=;
 b=UJXY2IjcKS2eyYkaC0Iu85ffltn7RyQiPcqwr+13fuhrP4VlfhJd1FGpUtq4jdy+Nh
 3UtgI1EAUCG9PHv4UwCkq7jkVipPkiEBda+WWb36CjIgfgfFhkFkxBDrweSilvZTioRK
 1oZ0fwaNK/BXjCd7iTOOMs43t9atBA5EFlKGKwxKO9EiiFSmLuGSe1d4Qj1gnAT2vMe0
 kin7DIZ+9rGYlrsvzutD3OhriffAV87AodR312KjJP7+c0Mt8MVikdw8stFRXTOJ3mFr
 aoyItkgR8qFqCZxCbhMzJrBBmI5Y7ytbTO8s8TU2RkkBgOqOnisSEF7AIngjN3nquV0i
 LrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021587; x=1792626387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nae77TQR3Z7q3Qlwc9Q49nkMmv1mvtHOrP91FMkoDZw=;
 b=VeQvfmgUuYjmWBpZzWC6ig1pCoOV18A5271J6Kba9WEMhW5q2z7ioJofF8wa5qq8JD
 UbbeSEo1e/+dcdWqlNfRDB94xciGAHvef0WdV4e9drX0E26Pd0k5XQuxwYsmRpgtZ9B6
 288jMjB6N6lYlPvk7qmqgb3qWin5//mKJRldjbyEn9eICO+pZsZQV9xuoPZOIlBVvjFs
 OzS3zfWPr+F6uvsx2X8+MPTuB6XpwmICgar8U6IOsI/TVxco+jsmhLHBAMmRJijQy3at
 gm6RYtgzSjoQD5Z53e8/c1vgMqFAMUagsypTSxE3eD6nH5ThVEyrfo2EvCr8gQMW0IlN
 1ILQ==
X-Gm-Message-State: AFq9FYKdlnvOHFmtNmWSo/HzcNKgKe3PqUmdYZYTPE4eGkyKLdnQRk3Z
 jk/Kofwmi87g6KppJZ4S9mjXL3aNe5dA508EmkNjuk4sTkv+7n7vnv4bm61eAhEG/hje2FKfMj3
 aH4EfsmBtMA8FuFmWooddgJZHGNeUB2HG2wZV4jeJnGwizopIYrkwmGVby0jU8mzIDg==
X-Gm-Gg: AYBFou2Ys5KC8H1WUD9Sr100t/+efje+0IMhGt/dQ2ANLTthlGPMVwiX6xaAFWuznEX
 t91FdACAA3iG1QXIjaknPgOLI1PfRmBY2HMRNz2OUpfY9hT3ZwfWKaY+XOgm+IyvPG7fO/qS/4X
 LXuf5NL9cDcETjXP7qlbvV+DIa1Y9twRTlEewhNHWFVX0OTjgXwm9Y4fF5VU/EZ2COQ5O54L3cj
 e/Rn9wgX2OxBdQjPaXRhRbI6qv0n3uN/EIpCPUJIqp/SMg0LcqtuCU6pnLZ1xlCkNNFLSLprs11
 iMyRPyyCAb6oOEYJXe3t+6Sv7zYkdiuPGws2PWC6Przekz/WYhX8pIIib36Wl+YufpegK0Ebyb4
 i3xUzhN00CC8ar3xqN5JCPZjrFUctE7Mo1cv5gQ1nJbFuYfqP2bOU4VzAPnDL
X-Received: by 2002:a05:693c:2516:b0:35d:8c39:b314 with SMTP id
 5a478bee46e88-35d8c39b74bmr5083076eec.37.1792021586486; 
 Wed, 14 Oct 2026 16:46:26 -0700 (PDT)
X-Received: by 2002:a05:693c:2516:b0:35d:8c39:b314 with SMTP id
 5a478bee46e88-35d8c39b74bmr5083049eec.37.1792021585889; 
 Wed, 14 Oct 2026 16:46:25 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 07/19] target/s390x: implement get_dump_info dump op
Date: Wed, 14 Oct 2026 23:45:53 +0000
Message-ID: <20261014234605.209084-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX6SdJevyQYoex
 KVvnocIzF3rpzpWtt/REakR+XCEKzGjdpWWUovzswK/6azI4Xk07SFN8S2LnhpNQRwdmFVIIbQA
 I0wINtaL4wETvRuVl+HTQFUgozjfyq0=
X-Proofpoint-ORIG-GUID: __D8A8jFkAlsAPHB_6SM5Iki5l8xu7__
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6ad01453 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=nTaJaBDiZT1zdI7ihh0A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX95gkLjy8+Prt
 05lxz/XLT1+A6xlUGzacP3kOo6XNVsxbOgC9R/zA/dFHYbdxAMU2GAuFAoTVqhBB+XOJ6biTPLc
 RrMkmuWMbl/SIHTwF3CocTRQ1d9OD8BDGghlq2Tu0jb8DEt6mblOZQ8H4fXP99n/1YhSXzkmxCV
 wrMgnh+ISvmTTvM4Mx7ZH/kzQ3BV/Xzvj7OVOEpm6hWVClVL+MPTKqXyulla5iHg9XMc8vRKqqj
 qDyI1oXUz6CHpL8axeqlrW9s3esYJNLbZj1GOnmHPLCZIpF4S4o574Ke5icqnI4tMEVVjyN88zb
 53mWaHhdl78zmLu8RVYlTLfAFB4DBW8OSKNyAWOcX6a0fzR8euWotmACWX41eCDsrhE4HYdqGOz
 LbPgFHDBMT3Y+kY423llLGeFxEapHOIjvpmWFvlxA9DvFZWddTCrehsGPgGzE06ea1lZXjaoF1F
 pKm9WvS+2Ue1CXhsnBA==
X-Proofpoint-GUID: __D8A8jFkAlsAPHB_6SM5Iki5l8xu7__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140094
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
 target/s390x/arch_dump.c      | 15 +++++++++++++--
 target/s390x/cpu-system.c     |  1 +
 target/s390x/s390x-internal.h |  2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 2c26e992959..19810dcbae8 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -19,6 +19,7 @@
 #include "system/dump.h"
 #include "kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
+#include "hw/core/dump-cpu-ops.h"
 
 struct S390xUserRegsStruct {
     uint64_t psw[2];
@@ -449,8 +450,8 @@ static void arch_cleanup(DumpState *s)
     }
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
+static int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                              const GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_S390;
     info->d_endian = ELFDATA2MSB;
@@ -469,6 +470,16 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+const DumpCPUOps s390_dump_ops = {
+    .get_dump_info = s390_get_dump_info,
+};
+
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
index d963d9e940e..e7c022b3fb5 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -195,6 +195,7 @@ void s390_cpu_system_class_init(CPUClass *cc)
 
     scc->load_normal = s390_cpu_load_normal;
     cc->sysemu_ops = &s390_sysemu_ops;
+    cc->dump_ops = &s390_dump_ops;
 }
 
 static bool disabled_wait(CPUState *cpu)
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index da60b2b1fd4..1c5aaccfa49 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -249,6 +249,8 @@ void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
 bool s390_cpu_has_work(CPUState *cs);
+
+extern const struct DumpCPUOps s390_dump_ops;
 #endif /* CONFIG_USER_ONLY */
 
 
-- 
2.43.0


