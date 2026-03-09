Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAD5F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcyC-0002qo-IU; Mon, 09 Mar 2026 11:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxk-00029V-Vk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxj-0000jM-3w
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so24444475e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071764; x=1773676564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mwB/3Msc370kfGVtYpqiHsadhvF99jZZ70nFea4elt8=;
 b=GJFkTGedpz+KcVypRVGTOTmL3ReUDUw6GttwioDU0RGyOqAf5/jJO/+WIxznKV1m3a
 AhrLNFWLBfs68tJ/EHIn/Fn+9WHqg6S3njyaseQUKrUtmf6oqs8zmxrXYtJNtKtourL/
 YatoV5docgy/ccFwadO5j+SqXGNGP22yI1vKmaeq3xco1MnTNEGkuKh8QPctzwdbCW/4
 wXnMe+Y0PgahfdCkKcb+RA0+yQhTrglwayvltpqIDnYGYf7MUFX0YwlaRZTC+4RX49SC
 XjNlFmiHecDaGGZo8v4h0TCWTH92NNubRysma5bbaGdUPr25zmOESSvlaPO7UDx+uBKg
 lsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071764; x=1773676564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mwB/3Msc370kfGVtYpqiHsadhvF99jZZ70nFea4elt8=;
 b=jyG3hfStHqqzIvbuwUfL9yx+bZm+vCJi6r2xRYHuamhoIBtYIMYHKe3UsAvk52aYGK
 9UgVfsCM3FP7MKTEh8u2l7i8sw71AtdgFw9rKpr27HlS2p3pehwvttDFSytuDyUWy1a9
 yHC8v+DElle8DXhtda2+TTf+3pcWVSqTsCJQRnMxBohA6ru/4tVuP8x9pJbVb+IZReet
 AenhBAyt+edm697Z/fuGQSQut3eYYz7ZlqwLyTAZkfRkiiNOO9jZzaba9M1DyGEq9aKV
 /6OdcaaRV3TzoxlLS39SHdSwVVjK5mvDD9XakxtN4jc7TKrRVUjmQgeqifliO+I2ix/u
 66+w==
X-Gm-Message-State: AOJu0YzWSw/rKYXVIo7wT5ab/NfmfSY6tqnPjYG8II0yGepG+DUr1MTM
 yGm7Hn+HntQC7lXarnjVcRs4JJePj0e4aCn8q0ih+iNw4MTGj4g6wRS/XqCqUlAK6p2/JeyhBOV
 RsLv4J5Y=
X-Gm-Gg: ATEYQzzeSXvIZO4fljll1GO7VOdCxIiTcoDsCcL6bMfjWG8TNUynH0Z3B8AiSoioEQJ
 DpNE8zT7TtNNTionNKjcd7KfvHkG8PcSAbSS20wDr90a4iejxnmps+96eMnMuApsBUUjjAI0g3L
 ohRoCjcjCNJOkp5QzbdqHDbmUaIv0fsCG+dnIprBnuLKmuD5cxHpdEdGeaxl8zxj+YhBJF0dqvs
 xGxSWUTs0a5Lm7Udrm0UMccLr64zo3hTAT+XFyYmStZhj1MUxvNggP07lmhCCPMGA6E1z85HvRi
 DaFNlxZYrQQf/ZIIu1tVqmvhs2XAbr61AOpq6pn76gkbqIl+epFy/80qMQef9LXOzSk3exo8xIf
 7Cng9+7fFvy8uWLzhszSTFYytwXtbyXztP0T3M1ws+LW5GfUfeDy2T/MLwBqzVYq/R5UbW+mkSb
 +l+ji+555UdJhN4Kp+QftGAghzZk1GWyVblqE9LfjyVV7TRusfzOpMAqqBynjLb2TJUDojB68y
X-Received: by 2002:a05:600c:4443:b0:485:410c:119b with SMTP id
 5b1f17b1804b1-485410c1bfemr13282775e9.13.1773071763930; 
 Mon, 09 Mar 2026 08:56:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237f2d2bsm93213115e9.4.2026.03.09.08.56.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:56:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/49] hw/timer/slavio_timer: Free resources allocated in
 instance_init
Date: Mon,  9 Mar 2026 16:52:03 +0100
Message-ID: <20260309155219.62400-34-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20260307112931.3322532-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/slavio_timer.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 4a3e227fbab..eccdc532fb1 100644
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
2.53.0


