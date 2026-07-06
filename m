Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BA6C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjgI-00025C-6v; Mon, 06 Jul 2026 09:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgD-0001WB-Hz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgB-0006no-MD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxCeP238118
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rjq83pfJV2nVYU3+zqImMenwqXneWXWnmXXzu7JibtA=; b=jsMcmOaCMke+BwdC
 LDFhB2BQ43RAPwj+7fHV9s/LDXoC7K6BaQrCct/HNRHpiDggmLBK2Kh/39vQxK5R
 qafXIblzM51mNLV1ejhTgWycLZeqpHh1ugdEL/xCQnT0FFrcOwYkFIZ+uDN1W+2l
 fIAuvR5a9kf4s7AlhsiqDjGWZcKe2xSh8+4Y+VsIQPC92BaktXuZifqv/DU71Amx
 1sOwkJ1nHo5U4QENkwY5JP91+EZq2pyek7B2m4tu/ntYoKT+pg7UkLdtiQo+lEl7
 d5WBg1NW+JabedP5kJgMLEudWDrR4MmH8/jSLySKC68ARrPYjzuYzHCTdb+iGrcu
 zdpRLg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t898u1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:48:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92d1cae5740so351150085a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345689; x=1783950489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rjq83pfJV2nVYU3+zqImMenwqXneWXWnmXXzu7JibtA=;
 b=ErSPQGi/QYihqyogiGDtzx3P10HZmybCG58olVOJFrM48ujZ+3M4HAPDzf7zfcm4ax
 DsPMrwZ3e4YUx657iItwsl5sIRmLKtmSS4fzC0r8shyo5n+FBT40F2oTl0NMy7MQhykx
 OkPpAgszlD1qWmlO3AW2CkDT6FFr8Mf7vQIlaHK1sKALxLvUe7jN/eXAVg/GJcJKo6mq
 d1Hvi8COVws6dBTNdfyxINZzp9KyBzEyevquUrT4eB1QKBHJvAoshIbHjzdlSBiuBNGx
 5rbC7GPe55o0X6EJs1IbLgSS9ulp9dCUhUB+QRQDeB8WEJ/c4oWEl/URVzxq5BClFOYe
 UzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345689; x=1783950489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rjq83pfJV2nVYU3+zqImMenwqXneWXWnmXXzu7JibtA=;
 b=Y9bwnb7gTGQ7Iz1jNBrkyOE5ys6DYJrmeZ7C8ok0F/OOMsbiXscwe3DF+1m7UR1gD3
 fWAe96fwqEd6YBf2P9BxBQi+P03PLKp9Ko8fWys8nEyZo1xU69ih83B8rpqw7w/7NQ9J
 p9tP5+e9VlgUwsggiW5XiUA9XO3AT86eCDPKm/niBW17Wwzf9/w3e7q2whfkV8WXq+ED
 W5QTS0d2S6FWQS7ds4cnuxL38hX6wpSu8g9cYHDnS07kt1kAiK6GsOo5luBZUOHtCSzC
 nfafYbFnYh39inn7fyfV4aZGn+/seP306brLL7SG0JLND1Sue3i9ovpR7GHdiR0x5P4w
 ciWA==
X-Gm-Message-State: AOJu0Yytx5ocOnafzp/njc6WUuNepZcwsTHyZqOVodunw+ItFIGWh7FC
 /Qt+GGPaW21Tz6qZoZ8DwkYsZaw/S1CsSH4+R5ZAdZ7enjJA3meX3JGCKrCjnrr7Q02/2rDOQqX
 YkVCZ7ipAAaBWd864ynT0JXpfc/1aJDXtPnJDroQeDvQnxIJBnpEtlQ2eVeZQLTlmkQ==
X-Gm-Gg: AfdE7clzkn585lzJgd0RYsPHifBkwlEE59Q7jHAihp96BcWvOuvb/49Btjj/Ocoh+rq
 sIidYkRUUsPPrKJK7HKoUjiCcvJhUGf94sIt0c8JTIdIZSYmt70ssi2P8bwYxDeEiOskGc4V+wR
 qaW7nhR4lBCX/ZVER5EXlqzatzWCc0iLlUw85s3dJszGs1tuXhryoqrTTqgricQoG0QQPNV3Vqe
 zUfZoGg120JjtjANRJ4QAap/f0zZxGIH+VzcAkBksEk12IY+ETRZ2jKwUVramaRi4MJ6WhoaUCB
 LN7DDpLr2vpZvW69bUUYpTwRJgo30bKcDTi0O3zQemIprdN2/CtQgdr/OQXydUtLPW638GzedgE
 31wI03uhBiN7NcrGtjT/Rjj3CWHNuWaPuVFhE8cDIpv2Ap89HK5LEK+WkvQ==
X-Received: by 2002:a05:620a:1997:b0:92e:7533:ef67 with SMTP id
 af79cd13be357-92ebb568212mr88266985a.20.1783345688998; 
 Mon, 06 Jul 2026 06:48:08 -0700 (PDT)
X-Received: by 2002:a05:620a:1997:b0:92e:7533:ef67 with SMTP id
 af79cd13be357-92ebb568212mr88261285a.20.1783345688392; 
 Mon, 06 Jul 2026 06:48:08 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef1807asm323576865e9.1.2026.07.06.06.48.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:48:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/32] accel: Hold @can_reverse information in AccelGdbConfig
Date: Mon,  6 Jul 2026 15:45:12 +0200
Message-ID: <20260706134527.84808-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXwRxaVh2gV/d2
 fq0n1FD7PwOSWYEIC2PsNULQmdChirAaobKT3NtWqKvXvj4t0tTjD6SqFP7+d0J6wEiGBDeat9q
 8P3at0Kt/SRiDfeTOMmO6SylmHfRMYQ=
X-Proofpoint-GUID: LdvtBKb-0TRU8IVdFeqKV5zDQDIvusxx
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4bb21a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Zu86EXcvoz0JJFEs46oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LdvtBKb-0TRU8IVdFeqKV5zDQDIvusxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXyXj08RRAUf5c
 NV1IDGuPuWO7HyRZd+HwupTGVjkdjw154/QYDncL0FTrd6Nehea94zmax74cmTHK3HtrWyeKgSP
 cWB+kZ+MVjKmCHPC4zNQx1XZl4K37uqy0P5+aegXcxNvboFS1r2run5Xzw7v4YXSdYbWtbSxK3U
 YCNMcRMB/lUci/BGuZO4YLK5ishb+7qHduR4a2mu+dn4dmgZaTWjDPMpZGLJA46bglmkcH85DWH
 f1BIoh7mVOW9ZcIWnP9TnanG5y9s/m04BZ730Qjy4HOyV94fY6Emrn6wA3Z3V8+IHtVOquBhwh8
 H76hgrCC8ZE6GEqcmOxBIWZedb85wDcCYQoWAKGvNQpqyBW3ooYns1hJdASSpbVLNC3wz3G7Lpn
 qQhHeXCnNy6nmhDLwRIgY3VZ/Gysgg9WBiV4+wHGuE462g+AZLidxKAEapKsabOfyFW2bfioBHk
 yYgQBWZ8G2qlQhAeqkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hold @can_reverse in AccelGdbConfig, set it when initializing
AccelState in AccelClass::init_machine handlers (only TCG sets
it). Remove gdb_can_reverse() as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20260705215729.62196-17-philmd@oss.qualcomm.com>
---
 gdbstub/internals.h  | 1 -
 include/qemu/accel.h | 2 ++
 accel/tcg/tcg-all.c  | 3 +++
 gdbstub/gdbstub.c    | 4 ++--
 gdbstub/system.c     | 5 -----
 gdbstub/user.c       | 6 ------
 6 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 0444dee2246..0b74ea4000f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -154,7 +154,6 @@ CPUState *gdb_first_attached_cpu(void);
 void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
-bool gdb_can_reverse(void); /* system emulation, stub for user */
 int gdb_target_sigtrap(void); /* user */
 
 void gdb_create_default_process(GDBState *s);
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 3b01d55741b..8e0c3dfe088 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -77,9 +77,11 @@ void accel_cpu_common_unrealize(CPUState *cpu);
  * struct AccelGdbConfig - gdbstub configuration for an accelerator.
  *
  * @sstep_flags: Set SSTEP_* flags that accelerator supports for guest debug.
+ * @can_reverse: Whether reverse mode is supported.
  */
 typedef struct AccelGdbConfig {
     unsigned sstep_flags;
+    bool can_reverse;
 } AccelGdbConfig;
 
 #endif /* QEMU_ACCEL_H */
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d30b53cd3b7..7186c10cf02 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -159,6 +159,9 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
          */
         as->gdbstub.sstep_flags |= SSTEP_NOIRQ | SSTEP_NOTIMER;
     }
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        as->gdbstub.can_reverse = true;
+    }
 
     page_init();
     tb_htable_init();
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 6c4fa065638..0a328b0dd48 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1376,7 +1376,7 @@ static void handle_step(GArray *params, void *user_ctx)
 
 static void handle_backward(GArray *params, void *user_ctx)
 {
-    if (!gdb_can_reverse()) {
+    if (!gdbserver_state.accel_config.can_reverse) {
         gdb_put_packet("E22");
         return;
     }
@@ -1684,7 +1684,7 @@ static void handle_query_supported(GArray *params, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
 
-    if (gdb_can_reverse()) {
+    if (gdbserver_state.accel_config.can_reverse) {
         g_string_append(gdbserver_state.str_buf,
             ";ReverseStep+;ReverseContinue+");
     }
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 1179c82cb86..2e8c457097b 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -479,11 +479,6 @@ unsigned int gdb_get_max_cpus(void)
     return ms->smp.max_cpus;
 }
 
-bool gdb_can_reverse(void)
-{
-    return replay_mode == REPLAY_MODE_PLAY;
-}
-
 /*
  * Softmmu specific command helpers
  */
diff --git a/gdbstub/user.c b/gdbstub/user.c
index f7bc4e63dfd..299388b9f71 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -786,12 +786,6 @@ unsigned int gdb_get_max_cpus(void)
     return max_cpus;
 }
 
-/* replay not supported for user-mode */
-bool gdb_can_reverse(void)
-{
-    return false;
-}
-
 /*
  * Break/Watch point helpers
  */
-- 
2.53.0


