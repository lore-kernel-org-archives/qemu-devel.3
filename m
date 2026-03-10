Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4F9EB107C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzPm-0003S3-32; Tue, 10 Mar 2026 11:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPJ-0002vo-7E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:05 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPF-0006Xs-KG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439b7a87fb5so6262002f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158040; x=1773762840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vtaDzyiQN8DEkBPTYsndoe4vp5c4LDKGS1G9F+UUXM=;
 b=Awq83+zyC2a3c/F5jy9ez2ecjfwT0nd6Iob2YySnzZGeRW2O1nOL8oBoQfmNrI4PQk
 0qvaDj/hIaNjEUD0QdyObsQtmujMzaAW+fabgjstn57Qzh0Jv0LQnKKrOSpArEyCmlkv
 7N7meo2lsx8id4r00ex+LvHLlLCvJZGvg0noHbGfbV8t+9AIo/J+/QTVZa7ES4pInWN5
 4s71/avMY1nrouBqzI35tOi4jx0LD6eNULAebJ0hxN5g6Bh5G7zEdkS0LIROvGm/Zmmz
 aDRlBBkG7TQV1KUCs95q4RrvaZlLo38gUtLHAg/wuLxD0XlOV86hz8TCz8TQ+AAW7vvd
 tteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158040; x=1773762840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0vtaDzyiQN8DEkBPTYsndoe4vp5c4LDKGS1G9F+UUXM=;
 b=HZANd1xoW6N5uUUoIEXgAvFaevbfwAhhXDGOmIjBglMtsLTmhVjVN/y5C9OLrIb7/w
 FIKhA5VSZ2ekbjPM7AMvoko7jgJc+qEtZ99TxBEG3drqD6xyuaOVoFxWhKQQQQlMmoOE
 N80RAokH+XB9vBtVmoqykDwATTkWw6ZfzYmZ8Di0pAgBwiY06Bq0pm2PU+ls7iUZ9St+
 ct8WNooVRbmElOjCS7QTwdHyFD7NrttPdovX0PYo/ZnydhHUskEJ76wGAjX76Cbtr2FK
 d/HWV1fhkaakeURxnSlzbfrQYnQBC+M7YStzQL4TMg9fQDCCLhekJqYteQd1ADyu7zxB
 JQHA==
X-Gm-Message-State: AOJu0YxFOYMHS3ulUGLgAdJKvIlHDKcBvp/rXQ6bKqIt03FLInx7tE1i
 kTfl7iPXpdku6BVGpZwKYDLYv/O+QI9Yf0pXIenZhf2Nk5Rl8GnOeoRLwgqRQNzxkBQTo4qbFt5
 QIDPxDUU=
X-Gm-Gg: ATEYQzxxYqB2VIdcMkM5jYyXp5NaAfxB3u+xe6+xZBRxDOA4Tn2K8jQQbVRMZ5oGVA0
 U6ORc8IZJZhtkYFH8ZYqe51Tj1esju1Iyl9FD6wmb6YdaVeY/uLc0v512Oq/2XlcTV3RpepRYat
 3+NBP1JpSJaXd8VEqETgIZcrLwhxMhUjb1CbvECNpLJTXFgbFw68WWoeZcUI8CoSSGnPdCSBDcB
 pKFO6LELsLjCMsCTY5n/WOsvz/QI1EDaVS5jKVxTdMjpmcSSyN2HAW6vn5CLyk+vQkTPthNmwQq
 q1SAuvyR3FXZJcelNllZ6EV3crZFRgnromtdAclT74vaxiSBU9N36AYnOWKYvlQPExvYrpes85m
 PitRBofbN90d5ZdB6Qt02NyfUikgBcz6gsMysE1wo5+OKhJm66AxH+8G2rulOdQtfsR+oebpeaC
 gy4s1srUR9ESPQVrm1Tsi0xGA/NpI/icPksfkgrsxlGwAfM6ueRGSCEHNav+Pmts4lrLTL9/Vj
X-Received: by 2002:a5d:588c:0:b0:439:c018:60f2 with SMTP id
 ffacd0b85a97d-439da348332mr26993996f8f.12.1773158039639; 
 Tue, 10 Mar 2026 08:53:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3d98asm41322916f8f.30.2026.03.10.08.53.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:53:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 04/13] gdbstub: Add trace events for around XML parsing /
 generation
Date: Tue, 10 Mar 2026 16:53:20 +0100
Message-ID: <20260310155329.48772-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Add trace events to help follow how the various files in
gdb-xml/ are parsed or generated at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c    | 10 ++++++++++
 gdbstub/trace-events |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 139301b485d..9703688eecc 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -478,6 +478,10 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder)
 
     builder->feature->num_regs = builder->regs->len;
     builder->feature->regs = (void *)g_ptr_array_free(builder->regs, FALSE);
+    trace_gdbxml_feature_builder_header(builder->feature->name,
+                                        builder->feature->xmlname,
+                                        builder->feature->num_regs);
+    trace_gdbxml_feature_builder_content(builder->feature->xml);
 }
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname)
@@ -563,6 +567,8 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
         .feature = feature
     };
 
+    trace_gdbxml_register_feature(feature->name, feature->xmlname,
+                                  base_reg, feature->num_regs);
     g_array_append_val(cpu->gdb_regs, s);
 }
 
@@ -599,6 +605,10 @@ void gdb_init_cpu(CPUState *cpu)
         assert(cc->gdb_num_core_regs);
         cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
     }
+
+    trace_gdbxml_init_cpu(object_get_typename(OBJECT(cpu)), cpu->cpu_index,
+                          cpu->gdb_num_regs, cpu->gdb_num_g_regs,
+                          cc->gdb_num_core_regs);
 }
 
 void gdb_register_coprocessor(CPUState *cpu,
diff --git a/gdbstub/trace-events b/gdbstub/trace-events
index 4fd126a38c1..44ef3339934 100644
--- a/gdbstub/trace-events
+++ b/gdbstub/trace-events
@@ -28,5 +28,10 @@ gdbstub_err_checksum_invalid(uint8_t ch) "got invalid command checksum digit: 0x
 gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packet with incorrect checksum, expected=0x%02x, received=0x%02x"
 gdbstub_err_unexpected_runpkt(uint8_t ch) "unexpected packet (0x%02x) while target running"
 
+gdbxml_init_cpu(const char *typename, unsigned id, unsigned gdb_num_regs, unsigned gdb_num_g_regs, unsigned gdb_num_core_regs) "%s:%d regs:%u g_regs:%u core_regs:%u"
+gdbxml_register_feature(const char *featname, const char *xmlname, unsigned base_reg, unsigned num_regs) "%s (%s) @%u +%u"
+gdbxml_feature_builder_header(const char *name, const char *xmlname, int num_regs) "%s (%s) regs:%d"
+gdbxml_feature_builder_content(const char *xml) "%s"
+
 # system.c
 gdbstub_hit_watchpoint(const char *type, int cpu_gdb_index, uint64_t vaddr) "Watchpoint hit, type=\"%s\" cpu=%d, vaddr=0x%" PRIx64 ""
-- 
2.53.0


