Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BD3FC9EF9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vypqn-0004J7-8G; Sat, 07 Mar 2026 06:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypql-0004IE-S2
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:29:39 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypqj-0006Az-Uc
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:29:39 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439ac15f35fso6662558f8f.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772882976; x=1773487776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMnDQck5QQNf//a2RzY2HmbmULk0Zh9OexRkCmP4tes=;
 b=atEvJj1jY4DyKVaEzuWtqu5ABQU8l1PsZBpiHh4GU9rtVsZ1KmM+9lmd4RgP7B7zux
 2CdSFQ46os29lx3u/KE5piZrO7+yjz4LT5+vM7NL5ok+kzK4nbO5lG9ufee5WeWKh2CN
 UdTe02yvRYCgYzibAVAm59na4YLpP1gv3OZ5oIO5my5axB2M8FGvDrcaEvsuXxvXQ++E
 VvO+/bT9IczN3xscpivFXS7UmMUH5Z3wMRX2aDHrmCNq1WLTII48PSyyPIhMnFgZpvhb
 mxT8aYtjSucWaGEwD556jzLHI6GGs+2XoxjdPJ1dBf/Uk6PHUdp7Pq5U7yzWQs5KrE0k
 d7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772882976; x=1773487776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xMnDQck5QQNf//a2RzY2HmbmULk0Zh9OexRkCmP4tes=;
 b=dCNHmjUZ4+Vgs77N307dEVVm2i86lr3v7izAgxs6Kd7ADPDVSwU+YGXFAYkkZ9xUKN
 W4gDSggqfBsZDpCDYLzLpmjEhNeTjvcSr5XjpHrzpFobNslWOnGlbA8kSprKPuXtsEIQ
 3dXUB683+QtjHLpxxo3dxulKPjKG+FVgm+lfj6UgjWYeq+4kx1t67PK5Q8jyYrlaX2jl
 rquYLKQxk6LOw4niqcIjhNtp+pEvkohKacqU0CT7wUsXq91bL+lTzuztmgDkjKNT49Ds
 hjhjsXD5xVGdId2E8G23FfyiHMORYFsWLcySSQaASfKrpS0ctgIpc97WY4ZE0NkZvgJ9
 3V1g==
X-Gm-Message-State: AOJu0YyzA1Qp/aTLE3JnwA3cmffV+4ECetmcXB1K8D27XKHo87yDWAIB
 686G3BgVaPViPjfC9LebRKYTRw4sBEDgKI2vRMeGOJVpsuRmveQmu6SQ4ley1vm53ascP++/OSJ
 oBsUh
X-Gm-Gg: ATEYQzwixj7kIzoKcnVzxJ/sEe+t8aofUUOWSiOjKVc/T4YfZ6PvUMb7KMSNr3jtP0K
 wAef468e8b1V7yZ53vqKROmK9g10NbVbqnDY+FLgQMU5ASKksxBtAgHFaIQbhIaJS2v7UZp+z3S
 rruJOz26HA2rBxCGSJYXohLRpI+Fgl8e4DX0cWJG72et/5ojfR3RRFYIBl0GcSrV42OBYHWt+Z4
 +RjtkZ0PEtc+DPMsGAFi+al+YqtRWi7u3tXg+DtD79e/Ckp9+OR69xJdNcXU+POgMtO+bIllbS8
 utP2e+I2PfGVfhrX9z9yP9jGXIdlWcQiN3/x6Uc9/MvxMHxUfITTWh4vY403MQjbx9A9FtQiE24
 A8M1TzwE6IN5Tq8sZ15VcAh8xO1QVAg4OeJ1+IIo0Knueh1svhDWEJit5Jh882KigQ2oMxGvdyx
 qwOn84eK2F45NQT8izX/Q1LC5jsYuHLIwTQ2ZnM4UGbMv/HWuoy9/2XxQ6lX6iyrKvdjFZqmp7Q
 niHWtVibNeE/qXkswwxO8JLJ4kfTWc=
X-Received: by 2002:a05:600c:6299:b0:480:4a4f:c36f with SMTP id
 5b1f17b1804b1-4852696973bmr81590865e9.21.1772882976420; 
 Sat, 07 Mar 2026 03:29:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853252cae1sm13462255e9.3.2026.03.07.03.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 03:29:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 3/3] hw/timer/slavio_timer: Free resources allocated in
 instance_init
Date: Sat,  7 Mar 2026 11:29:31 +0000
Message-ID: <20260307112931.3322532-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307112931.3322532-1-peter.maydell@linaro.org>
References: <20260307112931.3322532-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The slavio_timer device's instance_init function allocates memory for
TimerContext structs and a ptimer, but it never frees this memory, so
we will leak it if the QMP interface does introspection of this
device type, as reported by the clang address sanitizer:

Indirect leak of 4896 byte(s) in 17 object(s) allocated from:
    #0 0x5f2948d9b14d in calloc (/home/pm215/qemu/build/san/qemu-system-sparc+0xe0c14d) (BuildId: 7210711bdf6f7fbd0b863bd2dfcc7c42c7175db1)
    #1 0x758584b11771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5f2949097b8a in slavio_timer_init /home/pm215/qemu/build/san/../../hw/timer/slavio_timer.c:403:14
    #3 0x5f29495d790f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #4 0x5f29495d96ef in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
    #5 0x5f2949a30a26 in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11

Indirect leak of 1632 byte(s) in 17 object(s) allocated from:
    #0 0x5f2948d9b14d in calloc (/home/pm215/qemu/build/san/qemu-system-sparc+0xe0c14d) (BuildId: 7210711bdf6f7fbd0b863bd2dfcc7c42c7175db1)
    #1 0x758584b11771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x5f2948f7c65a in ptimer_init /home/pm215/qemu/build/san/../../hw/core/ptimer.c:464:9
    #3 0x5f2949097c1f in slavio_timer_init /home/pm215/qemu/build/san/../../hw/timer/slavio_timer.c:407:32
    #4 0x5f29495d790f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
    #5 0x5f29495d96ef in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
    #6 0x5f2949a30a26 in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11

Avoid the TimerContext leaks by making them an array inside the
SLAVIO_TimerState struct instead of allocating a compile-time-fixed
number of them each individually with g_new0() and then throwing away
the pointer.

Avoid the ptimer() leak by calling ptimer_free in
instance_finalize().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/slavio_timer.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 4a3e227fba..eccdc532fb 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -62,20 +62,21 @@ typedef struct CPUTimerState {
 #define TYPE_SLAVIO_TIMER "slavio_timer"
 OBJECT_DECLARE_SIMPLE_TYPE(SLAVIO_TIMERState, SLAVIO_TIMER)
 
+typedef struct TimerContext {
+    MemoryRegion iomem;
+    SLAVIO_TIMERState *s;
+    unsigned int timer_index; /* 0 for system, 1 ... MAX_CPUS for CPU timers */
+} TimerContext;
+
 struct SLAVIO_TIMERState {
     SysBusDevice parent_obj;
 
     uint32_t num_cpus;
     uint32_t cputimer_mode;
     CPUTimerState cputimer[MAX_CPUS + 1];
+    TimerContext timer_context[MAX_CPUS + 1];
 };
 
-typedef struct TimerContext {
-    MemoryRegion iomem;
-    SLAVIO_TIMERState *s;
-    unsigned int timer_index; /* 0 for system, 1 ... MAX_CPUS for CPU timers */
-} TimerContext;
-
 #define SYS_TIMER_SIZE 0x14
 #define CPU_TIMER_SIZE 0x10
 
@@ -400,7 +401,7 @@ static void slavio_timer_init(Object *obj)
         uint64_t size;
         char timer_name[20];
 
-        tc = g_new0(TimerContext, 1);
+        tc = &s->timer_context[i];
         tc->s = s;
         tc->timer_index = i;
 
@@ -420,6 +421,15 @@ static void slavio_timer_init(Object *obj)
     }
 }
 
+static void slavio_timer_finalize(Object *obj)
+{
+    SLAVIO_TIMERState *s = SLAVIO_TIMER(obj);
+
+    for (int i = 0; i <= MAX_CPUS; i++) {
+        ptimer_free(s->cputimer[i].timer);
+    }
+}
+
 static const Property slavio_timer_properties[] = {
     DEFINE_PROP_UINT32("num_cpus",  SLAVIO_TIMERState, num_cpus,  0),
 };
@@ -438,6 +448,7 @@ static const TypeInfo slavio_timer_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SLAVIO_TIMERState),
     .instance_init = slavio_timer_init,
+    .instance_finalize = slavio_timer_finalize,
     .class_init    = slavio_timer_class_init,
 };
 
-- 
2.43.0


